import time
from collections import deque

from humanize import naturalsize as ns

import conf
from scheduler import Scheduler
from simpacket import SimPacket


class Simulator:
    def __init__(self, trace_day, trace_ts, clock_rate, N, Q, hash_func=None, key_extract_func=None):
        self.trace_day = trace_day
        self.trace_ts = trace_ts
        self.clock_rate = clock_rate
        self.N = N
        self.Q = Q
        self.hash_func = hash_func
        self.key_extract_func = key_extract_func
        self.running = True
        self.samples = dict(thrpt=[], queues_sum=[], queues_max=[])

    def start(self):
        try:
            self.do_simulation()
            print "Simulation completed."
        except KeyboardInterrupt:
            print "Simulation interrupted. Results won't be saved to disk."
            pass
        self.running = False
        if 'thrpt' in self.samples:
            print "Collected %d samples" % len(self.samples["thrpt"])

    def do_simulation(self):

        fname_a = conf.trace_dir + '/' + conf.trace_fname('A', self.trace_day, self.trace_ts, 'parsed')
        fname_b = conf.trace_dir + '/' + conf.trace_fname('B', self.trace_day, self.trace_ts, 'parsed')

        print 'Reading %s...' % fname_a
        dump_a = open(fname_a, 'rb').read()
        print 'Reading %s...' % fname_b
        dump_b = open(fname_b, 'rb').read()

        tot_pkt_a, rem_a = divmod(len(dump_a), 32.0)
        tot_pkt_b, rem_b = divmod(len(dump_b), 32.0)
        assert (rem_a + rem_b) == 0, "invalid byte count in file A or B (file size must be multiple of 32 bytes)"

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

        scheduler = Scheduler(self.Q, self.N, self.hash_func)

        print "Starting simulation (tot_pkts=%s)...." % ns(tot_pkts, gnu=True, format="%.2f")
        while True:

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

            pkt_count += 1
            report_pkt_count += 1
            report_trfc_byte_count += pkt.iplen
            if start_pkt_ts == 0:
                start_pkt_ts = pkt.ts_nano
                report_trfc_last_ts = pkt.ts_nano

            # Extract keys. /ipsrc
            pkt.lkp_key = pkt.ip_src()
            # Enqueue packet.
            scheduler.accept(pkt)
            # Execute scheduler.
            if scheduler.execute_tick():
                report_served_count += 1

            # Report values every 1 second of traffic.
            if (pkt.ts_nano - report_trfc_last_ts) >= 1:
                report_delta_time = time.time() - report_ts
                sim_pkt_rate = report_pkt_count / report_delta_time
                sim_eta = (tot_pkts - pkt_count) / sim_pkt_rate

                if report_trfc_last_ts > 0:
                    trfc_delta_time = pkt.ts_nano - report_trfc_last_ts
                    trfc_bitrate = (report_trfc_byte_count * 8) / trfc_delta_time
                    trfc_pkt_rate = report_pkt_count / trfc_delta_time
                else:
                    trfc_bitrate = 0
                    trfc_pkt_rate = 0

                served_total_count += report_served_count

                thrpt = report_served_count / float(report_pkt_count)
                qocc = scheduler.queue_occupancy()

                self.samples['thrpt'].append(thrpt)
                self.samples['queues_sum'].append(qocc[0])
                self.samples['queues_max'].append(qocc[1])

                print "sim_pkt_rate=%spps, sim_eta=%.1fsec, " \
                      "trfc_bitrate=%sbps, trfc_pkt_rate=%spps, trfc_thrpt=%.3f, " \
                      "q_sum=%dpkts, q_max=%dpkts" % (ns(sim_pkt_rate, gnu=True, format="%.1f"),
                                                      sim_eta,
                                                      ns(trfc_bitrate, gnu=True, format="%.1f"),
                                                      ns(trfc_pkt_rate, gnu=True, format="%.1f"),
                                                      thrpt,
                                                      qocc[0],
                                                      qocc[1])

                # Reset report variables.
                report_pkt_count = 0
                report_trfc_last_ts = pkt.ts_nano
                report_trfc_byte_count = 0
                report_served_count = 0
                report_ts = time.time()


if __name__ == '__main__':
    sim = Simulator(trace_day=conf.trace_day, trace_ts=125911, clock_rate=0, N=8, Q=16, hash_func=conf.crc32,
                    key_extract_func=None)
    sim.start()
