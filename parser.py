import sys
import time
from struct import pack, unpack

import dpkt
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

    # print "Starting parsing of %s..." % label

    fpcap = open(base_fname + 'pcap')
    ftimes = open(base_fname + 'times')

    times = ftimes.readlines()

    widgets = [label, Percentage(), ' ', Bar(), ' ', ETA(), ' ', FileTransferSpeed(unit='p')]
    bar = progressbar.ProgressBar(widgets=widgets)
    bar.start(max_value=len(times))
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


def try_parsing(fname):
    direction, day, ts, extension = parse_trace_fname(fname)

    if extension not in ('pcap.gz', 'times.gz', 'pcap', 'times'):
        return

    pcapgz_fname = trace_fname(direction=direction, day=day, time=ts, extension='pcap.gz')
    timesgz_fname = trace_fname(direction=direction, day=day, time=ts, extension='times.gz')
    pcap_fname = trace_fname(direction=direction, day=day, time=ts, extension='pcap')
    times_fname = trace_fname(direction=direction, day=day, time=ts, extension='times')

    # print "Trying parsing of {direction}-{day}-{ts}...".format(**locals())

    other_fname = None

    if fname in (pcapgz_fname, pcap_fname):
        if fname == pcapgz_fname and not was_downloaded(fname):
            return
        if isfile(times_fname):
            other_fname = times_fname
        elif was_downloaded(timesgz_fname):
            other_fname = timesgz_fname
        else:
            return
    elif fname in (timesgz_fname, times_fname):
        if fname == timesgz_fname and not was_downloaded(fname):
            return
        if isfile(pcap_fname):
            other_fname = pcap_fname
        elif was_downloaded(pcapgz_fname):
            other_fname = pcapgz_fname
        else:
            return

    # Trigger parsing
    print "Starting parsing of {direction}-{day}-{ts}...".format(**locals())

    for f in (fname, other_fname):
        if f.endswith('.gz'):
            print "Gunzipping %s..." % f
            retcode = os.system('gunzip ' + f)
            assert retcode == 0, "unable to gunzip " + f

    assert isfile(pcap_fname) and isfile(times_fname), \
        "Unable to find '.pcap' or '.times' file for trace {direction}-{day}-{ts}".format(**locals())
    try:
        parse_packets_and_times(day, ts, direction)
        os.remove(pcap_fname)
        os.remove(times_fname)
    finally:
        pass


if __name__ == "__main__":
    curr_dir = os.path.dirname(os.path.realpath(__file__))
    trace_fullpath = os.path.dirname(os.path.realpath(__file__)) + '/' + trace_dir
    if not curr_dir.endswith(trace_dir):
        os.chdir(trace_fullpath)

    while True:
        try:
            print "This script will loop indefinitely looking for files to parse in %s...\n" \
                  "Press CTRL-C to exit." % trace_fullpath
            for f in os.listdir(trace_fullpath):
                if f.endswith('pcap.gz') or f.endswith('times.gz') or f.endswith('pcap') or f.endswith('times'):
                    try_parsing(f)
            time.sleep(10)
        except KeyboardInterrupt:
            sys.exit()
