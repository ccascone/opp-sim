import threading
import time
from collections import OrderedDict

from collections import defaultdict

from fifo import Fifo

import pickle
from threading import Lock

import os
from humanize import naturalsize as ns

import conf
import params
from scheduler import Scheduler
from simpacket import SimPacket

lock = Lock()

dumps = dict()
max_dump_locks = 50
dump_locks = [Lock() for _ in range(max_dump_locks)]


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
        self.sim_params = OrderedDict(trace_day=trace_day, trace_ts=trace_ts, N=N, Q=Q, clock_rate=clock_freq,
                                      key_func=key_func.__name__, hash_func=hash_func.__name__)
        if clock_freq > 0:
            self.tick_duration = 1.0 / clock_freq
        self.running = True
        self.samples = dict()
        self.label = '-'.join(map(str, self.sim_params.values()))
        self.threaded = False
        self.debug = False

    def run(self):
        self._print("Running simulator %s" % self.label, False)
        start_time = time.time()
        try:
            self.do_simulation()
            delta_minutes = (time.time() - start_time) / 60.0
            self._print("Simulation completed (duration=%.1fmin)." % delta_minutes)
            # Save results to file.
            result = dict(params=dict(self.sim_params), samples=self.samples)
            if os.path.isfile("results/%s.p" % self.label):
                os.remove("results/%s.p" % self.label)
            pickle.dump(result, open("results/%s.p" % self.label, 'wb'))
        except SimException as e:
            self._print("ERROR: %s" % e.message)
        except KeyboardInterrupt:
            self._print("Simulation interrupted. Results won't be saved to disk.")
        finally:
            self.running = False

    def run_threaded(self, debug=False):
        with lock:
            if os.path.isfile("results/%s.lock" % self.label):
                self._print("Execution aborted, there's already a simulator running for %s" % self.label)
                return
            else:
                open("results/%s.lock" % self.label, 'w').write("locked")

        self.threaded = True
        self.debug = debug
        self.run()
        os.remove("results/%s.lock" % self.label)

    def do_simulation(self):

        with dump_locks[int(self.trace_ts) % max_dump_locks]:
            if self.trace_ts not in dumps:
                fname_a = conf.trace_dir + '/' + conf.trace_fname('A', self.trace_day, self.trace_ts, 'parsed')
                fname_b = conf.trace_dir + '/' + conf.trace_fname('B', self.trace_day, self.trace_ts, 'parsed')
                if not os.path.isfile(fname_a) or not os.path.isfile(fname_b):
                    raise SimException("missing trace file for direction A or B")
                self._print('Reading %s...' % fname_a, False)
                dump_a = open(fname_a, 'rb').read()
                self._print('Reading %s...' % fname_b, False)
                dump_b = open(fname_b, 'rb').read()
                dumps[self.trace_ts] = (dump_a, dump_b)
            else:
                self._print('Found cached dumps, using them...', False)
                dump_a, dump_b = dumps[self.trace_ts]

        tot_pkt_a, rem_a = divmod(len(dump_a), 32.0)
        tot_pkt_b, rem_b = divmod(len(dump_b), 32.0)

        if (rem_a + rem_b) != 0:
            raise SimException("invalid byte count in file A or B (file size must be multiple of 32 bytes)")

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
        start_pkt_ts = 0
        cycle = 0

        ingress_queue = Fifo()
        scheduler = Scheduler(self.Q, self.N, self.hash_func)

        params_str = ', '.join("%s=%s" % (k, str(v)) for k, v in self.sim_params.items())
        self._print("Starting simulation (tot_pkts=%s): %s" % (ns(tot_pkts, gnu=True, format="%.2f"), params_str))

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
                return True

            if start_pkt_ts == 0:
                start_pkt_ts = pkt.ts_nano
                report_trfc_last_ts = pkt.ts_nano
            elif self.clock_freq > 0:
                # We are simulating a clock rate.
                pkt_relative_time = pkt.ts_nano - start_pkt_ts

                if pkt_relative_time < (cycle * self.tick_duration):
                    if not ingress_queue.empty():
                        ingress_queue.put(pkt)
                        pkt = ingress_queue.get()
                else:
                    # Fast forward time till it's time to process this packet.
                    while pkt_relative_time > (cycle * self.tick_duration):
                        if scheduler.execute_tick():
                            report_served_count += 1
                        cycle += 1

            # It's about time...
            # Extract keys. /ipsrc
            self.key_func(pkt)
            scheduler.accept(pkt)
            if scheduler.execute_tick():
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
                trfc_delta_time = pkt.ts_nano - report_trfc_last_ts
                trfc_bitrate = (report_trfc_byte_count * 8) / trfc_delta_time
                trfc_pkt_rate = report_pkt_count / trfc_delta_time
                served_total_count += report_served_count
                thrpt = report_served_count / float(report_pkt_count)
                qocc = scheduler.queue_occupancy()

                report_values = OrderedDict(thrpt=thrpt,
                                            queues_sum=qocc[0],
                                            queues_max=qocc[1],
                                            digests_count=len(scheduler.digests),
                                            trfc_bitrate=trfc_bitrate,
                                            trfc_pkt_rate=trfc_pkt_rate,
                                            ingress_queue=ingress_queue.qsize(),
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
                report_ts = time.time()

        raise SimException("forced shutdown")

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
    sim_parameters = params.gen_params()
    sim = Simulator(**sim_parameters[0])
    sim.run()
