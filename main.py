import time
from struct import unpack

import progressbar
from PyCRC import CRC16, CRC32
from progressbar import Bar
from progressbar import ETA
from progressbar import FileTransferSpeed
from progressbar import Percentage
from progressbar import RotatingMarker

from scheduler import Scheduler
from simpacket import SimPacket

file = 'caida/equinix-chicago.dirA.10M.1.pcap.parsed'

crc16c = CRC16.CRC16()
crc32c = CRC32.CRC32()


def crc16(input):
    return crc16c.calculate(input)


def crc32(input):
    return crc32c.calculate(input)


N = 8
Q = 24
hash_func = crc16

sched = Scheduler(Q, N, hash_func)


def main():
    global file, log, sched
    byte_report_count = 0
    byte_total_count = 0
    pkt_report_count = 0
    pkt_total_count = 0
    served_report_count = 0
    served_total_count = 0
    next_report_pkts = 100000
    report_ts = time.time()

    samples = []

    dump = open(file, 'rb').read()

    file_size = len(dump)
    total_pkts = file_size / 24.0

    widgets = ['OPP-SIM: ', Percentage(), ' ', Bar(),
               ' ', ETA(), ' ', FileTransferSpeed()]

    bar = progressbar.ProgressBar(max_value=file_size * 8, widgets=widgets).start()

    start_ts = time.time()
    for x in range(file_size / 24):

        i0 = x * 24
        i12 = i0 + 12
        ts, size = unpack("dI", dump[i0:i12])

        # Key format (in bytes): 4 ipsrc 4 ipdst 2 sport 2 dport
        key = dump[i12:i12 + 4]

        pkt = SimPacket(lookup_key=key, update_key=key)

        # Enqueue packet.
        sched.accept(pkt)

        # Execute scheduler.
        if sched.execute_tick():
            served_report_count += 1

        # Do some reporting.
        byte_report_count += 24
        pkt_report_count += 1

        if pkt_report_count == next_report_pkts:
            delta_seconds = time.time() - report_ts

            byte_total_count += byte_report_count
            served_total_count += served_report_count
            pkt_total_count += pkt_report_count

            pkt_rate = pkt_report_count / delta_seconds
            byte_rate = byte_report_count / delta_seconds

            remaining_bytes = (file_size - byte_total_count)
            eta_seconds = remaining_bytes / byte_rate

            qocc = sched.queue_occupancy()

            throughput = served_report_count / float(pkt_report_count)

            samples.append(throughput)

            # print "pkt_rate=%spps, remaining=%sB, eta=%.1fsec, throughput=%.3f, q_sum=%dpkts, q_max=%dpkts" % (
            #     naturalsize(pkt_rate, gnu=True, format="%.1f"),
            #     naturalsize(remaining_bytes, gnu=True, format="%.1f"),
            #     eta_seconds,
            #     throughput,
            #     qocc[0],
            #     qocc[1])

            # get a report approx every 5 seconds.
            next_report_pkts = int(pkt_rate) * 1
            pkt_report_count = 0
            served_report_count = 0
            byte_report_count = 0
            report_ts = time.time()
            bar.update(byte_total_count * 8)

    print "\nOPP-SIM: Q=%d, N=%d, hash_func=%s, thr=%.3f" % (Q,
                                                           N,
                                                           hash_func.__name__,
                                                           (served_total_count / float(pkt_total_count)))


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        pass
