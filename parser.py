import os
import time
from struct import pack

import dpkt
import humanize
from dpkt.tcp import TCP
from dpkt.udp import UDP


def parse_pcap(inputfile):
    global log, sched
    byte_report_count = 0
    byte_total_count = 0
    pkt_report_count = 0
    discarded_total_count = 0
    next_report_pkts = 30000
    # Get file size in bytes.
    file_size = os.stat(inputfile).st_size

    dump = ""

    with open(inputfile) as f:
        with open(inputfile + ".parsed", 'ab') as dest:

            start_ts = time.time()

            for ts, data in dpkt.pcap.Reader(f):

                ether = dpkt.ethernet.Ethernet(data)
                if ether.type != dpkt.ethernet.ETH_TYPE_IP:
                    discarded_total_count += 1
                    continue

                ip = ether.data

                src = ip.src
                dst = ip.dst

                if type(ip.data) in (UDP, TCP):  # checking of type of data that was recognized by dpkg
                    trsp = ip.data
                    sport = trsp.sport
                    dport = trsp.dport
                else:
                    discarded_total_count += 1
                    continue

                line = pack('dI', ts, len(data)) + src + dst + pack('HH', sport, dport)
                dump += line

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

                    print "pkt_rate=%spps, remaining=%sB, eta=%.1fmin" % (
                        humanize.naturalsize(pkt_rate, gnu=True, format="%.0f"),
                        humanize.naturalsize(remaining_bytes, gnu=True, format="%.1f"),
                        eta_seconds / 60.0)

                    dest.write(dump)
                    dump = ""

                    # get a report approx every 1 seconds.
                    next_report_pkts = int(pkt_rate) * 1
                    pkt_report_count = 0
                    byte_report_count = 0
                    start_ts = time.time()


if __name__ == "__main__":
    parse_pcap('caida/equinix-chicago.dirA.10M.1.pcap')
