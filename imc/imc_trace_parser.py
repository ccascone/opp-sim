import sys
import time
from struct import pack, unpack

import dpkt
import os
import progressbar
from dpkt.ip import IP
from dpkt.tcp import TCP
from dpkt.udp import UDP
from progressbar import Bar
from progressbar import ETA
from progressbar import FileTransferSpeed
from progressbar import Percentage


def parse_packets(fname):
    base_fname = fname
    label = base_fname
    parsed_filename = base_fname + '.parsed'
    pkt_report_count = 0
    next_report_pkts = 1000
    start_ts = time.time()
    byte_total_count = 0
    discarded_count = 0
    processed_count = 0
    lines = []
    i = 0

    # print "Starting parsing of %s..." % label

    fpcap = open(base_fname)
    byte_len = os.stat(base_fname).st_size

    widgets = [label, Percentage(), ' ', Bar(), ' ', ETA(), ' ', FileTransferSpeed(unit='B')]
    bar = progressbar.ProgressBar(widgets=widgets)
    bar.start(max_value=byte_len)
    bar.update(1)

    try:
        for ts, data in dpkt.pcap.Reader(fpcap):

            i += 1
            pkt_report_count += 1
            byte_total_count += len(data)

            try:
                eth = dpkt.ethernet.Ethernet(data)
                ip = eth.data
                if not isinstance(ip, IP):
                    discarded_count += 1
                    continue
            except dpkt.UnpackError:
                discarded_count += 1
                continue
            except Exception as e:
                print "Unexpected exception " + str(e)
                discarded_count +=1
                continue

            if type(ip.data) in (UDP, TCP):
                proto = 'U' if type(ip.data) == UDP else 'T'
                sport = ip.data.sport
                dport = ip.data.dport
            else:
                discarded_count += 1
                continue

            lines.append(pack('cdH4s4scHH', 'X', float(ts), ip.len, ip.src, ip.dst, proto, sport, dport))

            processed_count += 1

            if pkt_report_count >= next_report_pkts:
                # Check if we're packing right
                pieces = unpack('cdH4s4scHH', lines[-1])
                assert ('X', ts, ip.len, ip.src, ip.dst, proto, sport, dport) == tuple(pieces)
                delta_seconds = time.time() - start_ts
                pkt_rate = pkt_report_count / delta_seconds
                next_report_pkts = int(pkt_rate) * 0.5
                pkt_report_count = 0
                start_ts = time.time()
                bar.update(byte_total_count)

    finally:
        bar.update(byte_total_count)
        fpcap.close()

    with open(parsed_filename, 'wb') as pfile:
        pfile.write(''.join(lines))

    msg = "PARSER: completed %s, processed=%dpkts, discarded=%dpkts (%.3f)" % (label,
                                                                               processed_count,
                                                                               discarded_count,
                                                                               discarded_count / float(i))
    with open('parse_report.txt', 'a') as r:
        r.write(msg + "\n")


if __name__ == "__main__":
    curr_dir = os.path.dirname(os.path.realpath(__file__))
    trace_fullpath = os.path.dirname(os.path.realpath(__file__))
    if not curr_dir.endswith('imc'):
        os.chdir(trace_fullpath)

    while True:
        try:
            print "This script will loop indefinitely looking for files to parse in %s...\n" \
                  "Press CTRL-C to exit." % trace_fullpath
            for f in os.listdir(trace_fullpath):
                if (f.startswith('univ1_pt') or f.startswith('univ2_pt')) and not f.endswith('.parsed'):
                    if not os.path.isfile(f + '.parsed'):
                        parse_packets(f)
            time.sleep(10)
        except KeyboardInterrupt:
            sys.exit()
