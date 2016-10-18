import time
from struct import pack, unpack

import dpkt
import os
import progressbar
from dpkt.tcp import TCP
from dpkt.udp import UDP
from progressbar import Bar
from progressbar import ETA
from progressbar import FileTransferSpeed
from progressbar import Percentage
from conf import *


def parse_packets_and_times(day, ts, direct):
    assert direct in ('A', 'B')
    base_fname = trace_fname(direction=direct, day=day, time=ts, extension='')
    label = "{direct}-{day}-{ts}".format(**locals())
    parsed_filename = base_fname + 'parsed'
    pkt_report_count = 0
    next_report_pkts = 1000
    start_ts = time.time()
    byte_total_count = 0
    discarded_count = 0
    processed_count = 0
    lines = []
    i = 0

    print "Starting parsing of %s..." % label

    os.chdir(os.path.dirname(os.path.realpath(__file__)) + '/' + trace_dir)

    fpcap = open(base_fname + 'pcap')
    ftimes = open(base_fname + 'times')

    times = ftimes.readlines()

    widgets = [label, Percentage(), ' ', Bar(), ' ', ETA(), ' ', FileTransferSpeed(unit='p')]
    bar = progressbar.ProgressBar(max_value=len(times), widgets=widgets)
    bar.start()
    bar.update(1)

    try:
        for _, data in dpkt.pcap.Reader(fpcap):

            assert i < len(times)
            ts_nano = float(times[i].strip())

            i += 1
            pkt_report_count += 1
            byte_total_count += len(data)

            try:
                ip = dpkt.ip.IP(data)
            except dpkt.UnpackError:
                discarded_count += 1
                continue

            if type(ip.data) in (UDP, TCP):
                proto = 'U' if type(ip.data) == UDP else 'T'
                sport = ip.data.sport
                dport = ip.data.dport
            else:
                discarded_count += 1
                continue

            lines.append(pack('cdH4s4scHH', direct, ts_nano, ip.len, ip.src, ip.dst, proto, sport, dport))

            processed_count += 1

            if pkt_report_count >= next_report_pkts:
                # Check if we're packing right
                pieces = unpack('cdH4s4scHH', lines[-1])
                assert (direct, ts_nano, ip.len, ip.src, ip.dst, proto, sport, dport) == tuple(pieces)
                delta_seconds = time.time() - start_ts
                pkt_rate = pkt_report_count / delta_seconds
                next_report_pkts = int(pkt_rate) * 0.5
                pkt_report_count = 0
                start_ts = time.time()
                bar.update(i)

    finally:
        bar.update(i)
        fpcap.close()
        ftimes.close()

    with open(parsed_filename, 'wb') as pfile:
        pfile.write(''.join(lines))

    msg = "PARSER: completed %s, processed=%dpkts, discarded=%dpkts (%.3f)" % (label,
                                                                               processed_count,
                                                                               discarded_count,
                                                                               discarded_count / float(i))
    with open('parse_report.txt', 'a') as r:
        r.write(msg + "\n")


if __name__ == "__main__":
    parse_packets_and_times(20150219, 125911, 'A')
