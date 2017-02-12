import pickle
import random
import time
from collections import OrderedDict, Counter
from math import ceil
from multiprocessing import Lock

import os

import conf as caida_conf
import misc
import params
import scheduler
from simpacket import SimPacket

lock = Lock()

MAX_PKT_REPORT_COUNT = 100000


def transform_pkt_size(len, mlen):
    if random.randrange(0, 100) > mlen * 100 and len > 1000 * mlen:
        return max(64, int(random.gauss(1, 1.5) * 300 * mlen + 64))
    else:
        return max(64, len)


class SimException(Exception):
    pass


class Simulator:
    def __init__(self, trace_provider, N, Q, sched, hashf, key, W=None,
                 clock_freq=0, read_chunk=0, line_rate_util=0.0, mlen=1, sim_group='all', sim_name=None, max_samples=0,
                 trace_cluster=None, trace_rack=None, trace_day=None, trace_ts=None):
        """
        Creates a new simulator instance.
        :param trace_day: Day of the traffic trace to use.
        :param trace_ts: Timestamp of the traffic trace to use.
        :param N: Number of clock cycles needed for the OPP stage to atomically process a packet.
        :param Q: Number of flow queues.
        :param hashf: A function to compute the digests of the lookup and update keys.
        :param key: A function to extract the lookup and update keys from the packet.
        :param clock_freq: A clock frequency (Hz), 0 to simulate the case where packets arrives at each clock cycle.
        :param read_chunk: Number of bytes that can be read from an input port at each clock cycle.
                            0 to read the whole packet in 1 tick.
        :param line_rate_util:
        """

        if W is None:
            W = Q

        # type: (basestring, int, int, int, function, function, int, int, int) -> None
        self.sim_params = OrderedDict(provider=trace_provider,
                                      day=trace_day, ts=trace_ts,  # caida
                                      cluster=trace_cluster, rack=trace_rack,  # fb
                                      sched=sched.__name__, N=N, Q=Q, W=W,
                                      key=key.__name__, hash=hashf.__name__,
                                      mlen=mlen, clock=clock_freq, read_chunk=read_chunk, util=line_rate_util)
        self.label = '-'.join(["%s=%s" % (k, str(v)) for k, v in self.sim_params.items()])

        if sim_name is not None:
            self.label = sim_name
        self.sim_group = sim_group
        self.results_fname = "results/%s/%s.p" % (self.sim_group, self.label)
        if not os.path.exists("results/%s" % self.sim_group):
            os.makedirs("results/%s" % self.sim_group)

        self.trace_provider = trace_provider
        self.trace_cluster = trace_cluster
        self.trace_rack = trace_rack
        self.trace_day = trace_day
        self.trace_ts = trace_ts

        self.clock_freq = clock_freq  # Ghz
        self.N = N
        self.Q = Q
        self.W = W
        self.hash_func = hashf
        self.key_func = key
        self.scheduler = sched(N=self.N, Q=self.Q, W=self.W, hash_func=self.hash_func)
        self.read_chunk = float(read_chunk)
        assert 0 <= line_rate_util <= 1
        self.sim_util = float(line_rate_util)
        self.report_interval = 1
        if clock_freq > 0:
            self.tick_duration = 1 / float(clock_freq)
        self.running = True
        self.samples = dict()
        self.threaded = False
        self.debug = False
        if read_chunk > 0 and clock_freq > 0:
            self.line_rate = clock_freq * read_chunk * 8
        else:
            self.line_rate = 0
        self.time_stretch_factor = 0
        self.max_samples = max_samples
        self.mlen = mlen

    def _run(self):
        if not self.debug and os.path.isfile(self.results_fname):

            with open(self.results_fname, "rb") as f:
                try:
                    pickle.load(f)
                    self._print("WARNING: simulation aborted, result already exists for this configuration")
                    return
                except EOFError:
                    # Can't read file, do sim again
                    os.remove(self.results_fname)

        self._print("Running simulator %s" % self.label, False)
        start_time = time.time()

        try:
            self.do_simulation()
            delta_minutes = (time.time() - start_time) / 60.0
            self._print("Simulation completed (duration=%.1fmin)." % delta_minutes)
            if not self.debug:
                # Save results under ./results/sim_group
                result = dict(params=dict(self.sim_params),
                              samples=self.samples,
                              digest_stats=self.scheduler.digest_stats(),
                              line_rate=self.line_rate)
                with open(self.results_fname, 'wb') as f:
                    pickle.dump(result, f)
        except SimException as e:
            self._print("*** ERROR: %s" % e.message)
        except KeyboardInterrupt:
            self._print("Simulation interrupted. Results won't be saved to disk.")
        finally:
            self.running = False

    def run(self, threaded=False, debug=False):
        lock.acquire()
        lock_fname = self.results_fname + '.lock'
        if os.path.isfile(lock_fname):
            self._print("*** ERROR: simulation aborted, another simulator is running for this configuration")
            return
        with open(lock_fname, 'w') as f:
            f.write("locked")
        lock.release()
        self.threaded = threaded
        self.debug = debug
        try:
            self._run()
        finally:
            os.remove(lock_fname)

    def do_simulation(self):

        if self.trace_provider == 'caida':

            fname_a = caida_conf.trace_dir + '/' + caida_conf.trace_fname('A', self.trace_day, self.trace_ts, 'parsed')
            fname_b = caida_conf.trace_dir + '/' + caida_conf.trace_fname('B', self.trace_day, self.trace_ts, 'parsed')

            if not os.path.isfile(fname_a) or not os.path.isfile(fname_b):
                raise SimException("Missing CAIDA trace file for direction A or B")

            try:
                with open(fname_a, 'rb') as fa:
                    self._print('Reading %s...' % fname_a, False)
                    dump_a = fa.read()
                with open(fname_b, 'rb') as fb:
                    self._print('Reading %s...' % fname_b, False)
                    dump_b = fb.read()
            except IOError:
                raise SimException("Unable to read trace file")

        elif self.trace_provider == 'fb':

            fname = './fb/%s/%s-%s.parsed' % (self.trace_cluster, self.trace_cluster, self.trace_rack)

            if not os.path.isfile(fname):
                raise SimException("Not such FB trace file: %s" % fname)
            try:
                with open(fname, 'rb') as f:
                    self._print('Reading %s...' % fname, False)
                    dump_a = f.read()
            except IOError:
                raise SimException("Unable to read trace file %s" % fname)

            dump_b = ''

        else:
            raise SimException("Invalid trace provider %s" % self.trace_provider)

        tot_pkt_a, rem_a = divmod(len(dump_a), 32.0)
        tot_pkt_b, rem_b = divmod(len(dump_b), 32.0)

        if (rem_a + rem_b) != 0:
            raise SimException("Invalid byte count in file A or B (file size must be multiple of 32 bytes)")

        if self.line_rate > 0 and self.sim_util != 0:
            self._print('Simulated line rate is %sbps' % misc.hnum(self.line_rate), False)
            self._print('Evaluating traces bitrate...', False)
            bitrate_a = misc.evaluate_bitrate(dump_a)
            bitrate_b = misc.evaluate_bitrate(dump_b) if len(dump_b) else {'max': 0}
            max_bitrate = bitrate_a['max'] + bitrate_b['max']
            self.time_stretch_factor = max_bitrate / (self.line_rate * self.sim_util)
            self._print('Trace max bitrate is %sbps, setting time stretch factor to %f...'
                        % (misc.hnum(max_bitrate), self.time_stretch_factor), False)
            self.report_interval *= self.time_stretch_factor

        tot_pkts = tot_pkt_a + tot_pkt_b

        idx_a = 0  # index of next packet to be read from trace A
        idx_b = 0  # ... from trace B
        pkt_a = None
        pkt_b = None

        start_ts = time.time()  # now
        start_pkt_ts = 0  # timestamp of the first packet processed
        cycle = 0  # next cycle to be executed
        pkt_count = 0  # count of packets processed
        work_cycles_count = 0  # count of cycles where the scheduler was not IDLE
        sample_count = 0

        # Report variables. These are reset every report interval.
        report_ts = start_ts
        report_pkt_count = 0
        report_sched_cycles = [0, 0, 0, 0]
        report_read_cycle_count = 0  # number of cycles spent reading packets from the ingress queue
        report_trfc_byte_count = 0  # number of bytes processed
        report_trfc_last_ts = 0  # timestamp of the last packet of the last report
        report_queueing_delay = 0  # cumulative ingress queuing delay
        report_last_cycle = 0  # last cycle number of the last report

        self._print("Starting simulation (tot_pkts=%s)..." % misc.hnum(tot_pkts))

        while self.running:

            # Extract packet from direction A
            if not pkt_a and idx_a < tot_pkt_a:
                pkt_a = SimPacket(dump_a, idx_a * 32)
                idx_a += 1
            # Extract packet from direction B
            if not pkt_b and idx_b < tot_pkt_b:
                pkt_b = SimPacket(dump_b, idx_b * 32)
                idx_b += 1
            # Choose between A and B.
            if pkt_a and (not pkt_b or pkt_a.ts_nano <= pkt_b.ts_nano):
                pkt = pkt_a
                pkt_a = None
            elif pkt_b and (not pkt_a or pkt_b.ts_nano <= pkt_a.ts_nano):
                pkt = pkt_b
                pkt_b = None
            else:
                # No more packets to process.
                return

            # Scale time if required.
            if self.time_stretch_factor != 0:
                pkt.ts_nano *= self.time_stretch_factor

            if start_pkt_ts == 0:
                start_pkt_ts = pkt.ts_nano
                report_trfc_last_ts = pkt.ts_nano
            elif self.clock_freq > 0:
                # We are simulating a clock frequency.
                pkt_relative_time = pkt.ts_nano - start_pkt_ts
                sim_time = cycle * self.tick_duration
                if pkt_relative_time > sim_time:
                    # Fast forward time till it's time to process this packet.
                    extra_cycles_to_do = int(ceil((pkt_relative_time - sim_time) / self.tick_duration))
                    cycle += extra_cycles_to_do
                    for x in range(extra_cycles_to_do):
                        result = self.scheduler.execute_tick()
                        report_sched_cycles[result] += 1
                        if result == scheduler.SKIP:
                            report_sched_cycles[scheduler.EMPTY] += extra_cycles_to_do - x - 1
                            break
                else:
                    # Report any queuing delay at ingress ports.
                    report_queueing_delay += sim_time - pkt_relative_time

            # Packet size multiplier
            pkt.iplen = transform_pkt_size(pkt.iplen, self.mlen)

            if 0 < self.read_chunk < pkt.iplen:
                # Need more than 1 clock cycle to read the packet
                extra_cycles_to_do = int(ceil(pkt.iplen / self.read_chunk)) - 1
                cycle += extra_cycles_to_do
                report_read_cycle_count += extra_cycles_to_do
                for x in range(extra_cycles_to_do):
                    result = self.scheduler.execute_tick()
                    report_sched_cycles[result] += 1
                    if result == scheduler.SKIP:
                        report_sched_cycles[scheduler.EMPTY] += extra_cycles_to_do - x - 1
                        break

            # Time to process this packet headers in the OPP stage.
            # Key_func is supposed to store the extract key in the pkt object.
            self.key_func(pkt)
            self.scheduler.accept(pkt)
            result = self.scheduler.execute_tick()
            report_sched_cycles[result] += 1

            cycle += 1
            report_pkt_count += 1
            report_read_cycle_count += 1
            report_trfc_byte_count += pkt.iplen

            if report_pkt_count >= MAX_PKT_REPORT_COUNT:
                # if (pkt.ts_nano - report_trfc_last_ts) >= self.report_interval:
                # Report values every 1 second of traffic.
                report_delta_time = time.time() - report_ts
                report_cycle_count = cycle - report_last_cycle
                sim_pkt_rate = report_pkt_count / float(report_delta_time)
                sim_cycle_rate = report_cycle_count / float(report_delta_time)
                sim_eta = (tot_pkts - pkt_count) / sim_pkt_rate  # seconds
                sim_avg_queue_delay = report_queueing_delay / float(report_pkt_count)

                trfc_delta_time = pkt.ts_nano - report_trfc_last_ts
                trfc_bitrate = (report_trfc_byte_count * 8) / trfc_delta_time
                trfc_pkt_rate = report_pkt_count / trfc_delta_time

                work_cycles = report_sched_cycles[scheduler.WORK] + report_sched_cycles[scheduler.HAZARD]

                work_cycles_count += work_cycles
                pkt_count += report_pkt_count

                thrpt = work_cycles / float(report_pkt_count)

                util = report_read_cycle_count / float(cycle - report_last_cycle)

                try:
                    queue_sizes = [len(x) for x in self.scheduler.queues]
                except AttributeError:
                    queue_sizes = [0]

                p_tot_cycles = float(sum(report_sched_cycles))
                assert p_tot_cycles == report_cycle_count
                p_quotas = [report_sched_cycles[x] / p_tot_cycles
                            for x in range(len(report_sched_cycles))]

                report_values = OrderedDict(sched_thrpt=thrpt,
                                            sched_quota_work=p_quotas[scheduler.WORK],
                                            sched_quota_hazard=p_quotas[scheduler.HAZARD],
                                            sched_quota_stall=p_quotas[scheduler.STALL],
                                            sched_quota_empty=p_quotas[scheduler.EMPTY],
                                            sched_queues_avg=(sum(queue_sizes) / float(self.Q) if self.Q else 0),
                                            sched_queues_max=max(queue_sizes),
                                            sched_queues_min=min(queue_sizes),
                                            sched_keys_count=self.scheduler.key_count(),
                                            trfc_bitrate=trfc_bitrate,
                                            trfc_pkt_rate=trfc_pkt_rate,
                                            cycle_util=util,
                                            avg_in_queue_delay=sim_avg_queue_delay,
                                            sim_pkt_rate=sim_pkt_rate,
                                            sim_cycle_rate=sim_cycle_rate,
                                            sim_eta=sim_eta)

                self._append_samples(report_values)
                sample_count += 1

                if not self.threaded:
                    Simulator._print_report(report_values)

                if 0 < self.max_samples == sample_count:
                    return

                # Reset report variables.
                report_pkt_count = 0
                report_trfc_last_ts = pkt.ts_nano
                report_trfc_byte_count = 0
                report_sched_cycles = [0, 0, 0, 0]
                report_read_cycle_count = 0
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
                with open('simulator.log', 'a') as f:
                    f.write(msg + "\n")

    @staticmethod
    def _print_report(report_values):
        formatted_values = list()
        for key, val in report_values.items():
            val = misc.hnum(val)
            formatted_values.append("%s=%s" % (key, str(val)))
        print ', '.join(formatted_values)

    def _append_samples(self, values):
        for k in values:
            if k not in self.samples:
                self.samples[k] = list()
            self.samples[k].append(values[k])


if __name__ == '__main__':
    # sim_parameters = params.gen_params()
    #sim = Simulator(trace_provider='caida', trace_day=caida_conf.trace_day, trace_ts=130000, N=10, Q=1, W=1,
    #                sched=scheduler.OPPScheduler, hashf=params.hash_crc16, key=params.key_const,
    #                clock_freq=0, read_chunk=80, line_rate_util=1, mlen=1)
    sim = Simulator(trace_provider='fb', trace_cluster='B', trace_rack='bace22a7', N=3, Q=1, W=1,
                    sched=scheduler.OPPScheduler, hashf=params.hash_crc16, key=params.key_const,
                    clock_freq=0, read_chunk=80, line_rate_util=1, mlen=1)
    sim.run(debug=True)
