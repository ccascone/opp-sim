import pickle
import time
from collections import OrderedDict
from multiprocessing import Lock

import os
from humanize import naturalsize as ns

import conf
import params
from fifo import Fifo
from scheduler import Scheduler
from simpacket import SimPacket

lock = Lock()


class SimException(Exception):
    pass


class Simulator:
    def __init__(self, trace_day, trace_ts, clock_freq, N, Q, hash_func=None, key_func=None):
        self.trace_day = trace_day
        self.trace_ts = trace_ts
        self.clock_freq = clock_freq  # Ghz
        self.N = N
        self.Q = Q
        self.hash_func = hash_func
        self.key_func = key_func
        self.scheduler = Scheduler(Q, N, hash_func)
        self.sim_params = OrderedDict(trace_day=trace_day, trace_ts=trace_ts, N=N, Q=Q, clock_rate=clock_freq,
                                      key_func=key_func.__name__, hash_func=hash_func.__name__)
        if clock_freq > 0:
            self.tick_duration = 1.0 / clock_freq
        self.running = True
        self.samples = dict()
        self.label = '-'.join(map(str, self.sim_params.values()))
        self.threaded = False
        self.debug = False
        self.results_fname = "results/%s.p" % self.label

    def _run(self):
        self._print("Configuration: %s" % self.label, False)
        if os.path.isfile(self.results_fname):
            self._print("WARNING: simulation aborted, result already exists for this configuration")
            return

        self._print("Running simulator %s" % self.label, False)
        start_time = time.time()

        try:
            self.do_simulation()
            delta_minutes = (time.time() - start_time) / 60.0
            self._print("Simulation completed (duration=%.1fmin)." % delta_minutes)
            # Save results to file.
            result = dict(params=dict(self.sim_params),
                          samples=self.samples,
                          digest_stats=self.scheduler.digest_stats())
            if not os.path.exists("results"):
                os.makedirs("results")
            pickle.dump(result, open(self.results_fname, 'wb'))
        except SimException as e:
            self._print("ERROR: %s" % e.message)
        except KeyboardInterrupt:
            self._print("Simulation interrupted. Results won't be saved to disk.")
        finally:
            self.running = False

    def run(self, threaded=False, debug=False):
        lock.acquire()
        lock_fname = self.results_fname + '.lock'
        if os.path.isfile(lock_fname):
            self._print("ERROR: simulation aborted, another simulator is running for this configuration" % self.label)
            return
        open(lock_fname, 'w').write("locked")
        lock.release()
        self.threaded = threaded
        self.debug = debug
        try:
            self.run()
        finally:
            os.remove(lock_fname)

    def do_simulation(self):

        fname_a = conf.trace_dir + '/' + conf.trace_fname('A', self.trace_day, self.trace_ts, 'parsed')
        fname_b = conf.trace_dir + '/' + conf.trace_fname('B', self.trace_day, self.trace_ts, 'parsed')

        if not os.path.isfile(fname_a) or not os.path.isfile(fname_b):
            raise SimException("Missing trace file for direction A or B")

        self._print('Reading %s...' % fname_a, False)
        dump_a = open(fname_a, 'rb').read()
        self._print('Reading %s...' % fname_b, False)
        dump_b = open(fname_b, 'rb').read()

        tot_pkt_a, rem_a = divmod(len(dump_a), 32.0)
        tot_pkt_b, rem_b = divmod(len(dump_b), 32.0)

        if (rem_a + rem_b) != 0:
            raise SimException("Invalid byte count in file A or B (file size must be multiple of 32 bytes)")

        tot_pkts = tot_pkt_a + tot_pkt_b

        idx_a = 0
        idx_b = 0
        pkt_a = None
        pkt_b = None

        # Variables needed for reporting.
        pkt_count = 0
        report_pkt_count = 0
        report_served_count = 0
        served_total_count = 0
        start_ts = time.time()
        report_ts = start_ts

        report_trfc_byte_count = 0
        report_trfc_last_ts = 0
        report_queueing_delay = 0
        report_last_cycle = 0
        start_pkt_ts = 0
        cycle = 0

        ingress_queue = Fifo()

        self._print("Starting simulation (tot_pkts=%s)..." % ns(tot_pkts, gnu=True, format="%.2f"))

        while self.running:

            # Extract packet from direction A
            if pkt_a is None and idx_a < tot_pkt_a:
                pkt_a = SimPacket(dump_a, idx_a * 32)
                idx_a += 1
            # Extract packet from direction B
            if pkt_b is None and idx_b < tot_pkt_b:
                pkt_b = SimPacket(dump_b, idx_b * 32)
                idx_b += 1
            # Choose between A and B.
            if pkt_a is not None and (pkt_b is None or pkt_a.ts_nano <= pkt_b.ts_nano):
                pkt = pkt_a
                pkt_a = None
            elif pkt_b is not None and (pkt_a is None or pkt_b.ts_nano <= pkt_a.ts_nano):
                pkt = pkt_b
                pkt_b = None
            else:
                # No more packets to process.
                return

            if start_pkt_ts == 0:
                start_pkt_ts = pkt.ts_nano
                report_trfc_last_ts = pkt.ts_nano
            elif self.clock_freq > 0:
                # We are simulating a clock frequency.
                pkt_relative_time = pkt.ts_nano - start_pkt_ts
                while True:
                    # Fast forward time till it's time to process this packet.
                    sim_time = cycle * self.tick_duration
                    if pkt_relative_time < sim_time:
                        report_queueing_delay += sim_time - pkt_relative_time
                        break
                    if self.scheduler.execute_tick():
                        report_served_count += 1
                    cycle += 1

            # It's about time...
            # Extract keys. /ipsrc
            self.key_func(pkt)
            self.scheduler.accept(pkt)
            if self.scheduler.execute_tick():
                report_served_count += 1
            cycle += 1

            pkt_count += 1
            report_pkt_count += 1
            report_trfc_byte_count += pkt.iplen

            if (pkt.ts_nano - report_trfc_last_ts) >= 1:
                # Report values every 1 second of traffic.
                report_delta_time = time.time() - report_ts
                sim_pkt_rate = report_pkt_count / report_delta_time
                sim_eta = (tot_pkts - pkt_count) / sim_pkt_rate
                sim_avg_queue_delay = report_queueing_delay / float(report_pkt_count)
                trfc_delta_time = pkt.ts_nano - report_trfc_last_ts
                trfc_bitrate = (report_trfc_byte_count * 8) / trfc_delta_time
                trfc_pkt_rate = report_pkt_count / trfc_delta_time
                served_total_count += report_served_count
                thrpt = report_served_count / float(report_pkt_count)
                util = trfc_pkt_rate / float(cycle - report_last_cycle)
                qocc = self.scheduler.queue_occupancy()

                report_values = OrderedDict(thrpt=thrpt,
                                            sched_queues_sum=qocc[0],
                                            sched_queues_max=qocc[1],
                                            digests_count=len(self.scheduler.digests),
                                            trfc_bitrate=trfc_bitrate,
                                            trfc_pkt_rate=trfc_pkt_rate,
                                            util=util,
                                            sim_avg_queue_delay=sim_avg_queue_delay,
                                            sim_pkt_rate=sim_pkt_rate,
                                            sim_eta=sim_eta)

                self._append_samples(report_values)

                if not self.threaded:
                    Simulator._print_report(report_values)

                # Reset report variables.
                report_pkt_count = 0
                report_trfc_last_ts = pkt.ts_nano
                report_trfc_byte_count = 0
                report_served_count = 0
                report_queueing_delay = 0
                report_last_cycle = cycle
                report_ts = time.time()

        # self.running is False
        raise SimException("Forced shutdown")

    def _print(self, msg, important=True):
        if not self.threaded:
            print msg
        elif important or self.debug:
            datetime = time.strftime("%d/%m/%Y %H:%M:%S")
            msg = "%s: %s [%s]" % (datetime, msg, self.label)
            if self.debug:
                print msg
            else:
                open('simulator.log', 'a').write(msg + "\n")

    @staticmethod
    def _print_report(report_values):
        formatted_values = list()
        for key, val in report_values.items():
            if val > 999 or val < 0.01:
                val = ns(val, gnu=True, format="%.1f")
            else:
                val = "%.3f" % val
            formatted_values.append("%s=%s" % (key, str(val)))
        print ', '.join(formatted_values)

    def _append_samples(self, values):
        for k in values:
            if k not in self.samples:
                self.samples[k] = list()
            self.samples[k].append(values[k])


if __name__ == '__main__':
    # sim_parameters = params.gen_params()
    sim = Simulator(trace_day=conf.trace_day, trace_ts=130000, clock_freq=1.5 * 10 ** 6, N=8, Q=8,
                    hash_func=params.hash_crc32, key_func=params.key_ipsrc)
    sim.run()
