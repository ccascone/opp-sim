import dpkt
import logging
import time
import os
import humanize
from simpacket import SimPacket
from PyCRC import CRC16, CRC32
from scheduler import Scheduler

file = 'caida/equinix-chicago.dirA.10M.1.pcap'

crc16c = CRC16.CRC16()
crc32c = CRC32.CRC32()


def crc16(input):
    return crc16c.calculate(input)


def crc32(input):
    return crc32c.calculate(input)


N = 8
Q = 12
hash_func = crc16

sched = Scheduler(Q, N, hash_func)


def main():
    global file, log, sched
    byte_report_count = 0
    byte_total_count = 0
    pkt_report_count = 0
    served_report_count = 0
    discarded_total_count = 0
    next_report_pkts = 30000

    with open(file) as f:
        # Get file size in bytes.
        file_size = os.stat(file).st_size

        start_ts = time.time()

        for ts, data in dpkt.pcap.Reader(f):

            print ts

            ether = dpkt.ethernet.Ethernet(data)
            if ether.type != dpkt.ethernet.ETH_TYPE_IP:
                discarded_total_count += 1
                continue

            ip = ether.data

            pkt = SimPacket(lookup_key=ip.src, update_key=ip.src)

            # Enqueue packet.
            sched.accept(pkt)

            # Execute scheduler.
            if sched.execute_tick():
                served_report_count += 1

            # Do some reporting.
            byte_report_count += len(data)
            pkt_report_count += 1

            if pkt_report_count == next_report_pkts:
                delta_seconds = time.time() - start_ts
                byte_total_count += byte_report_count
                pkt_rate = pkt_report_count / delta_seconds
                byte_rate = byte_report_count / delta_seconds
                remaining_bytes = (file_size - byte_total_count)
                eta_seconds = remaining_bytes / byte_rate
                qocc = sched.queue_occupancy()

                print "pkt_rate=%spps, remaining=%sB, eta=%.1fmin, throughput=%.3f, q_sum=%dpkts, q_max=%dpkts" % (
                    humanize.naturalsize(pkt_rate, gnu=True, format="%.0f"),
                    humanize.naturalsize(remaining_bytes, gnu=True, format="%.1f"),
                    eta_seconds / 60.0,
                    served_report_count / float(pkt_report_count),
                    qocc[0],
                    qocc[1])

                # get a report approx every 5 seconds.
                next_report_pkts = int(pkt_rate) * 2
                pkt_report_count = 0
                served_report_count = 0
                byte_report_count = 0
                start_ts = time.time()


if __name__ == '__main__':
    print "OPP-SIM: Q=%d, N=%d, hash_func=%s" % (Q, N, hash_func.__name__)
    try:
        main()
    except KeyboardInterrupt:
        pass
