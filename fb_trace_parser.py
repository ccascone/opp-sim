import time
from collections import Counter
from struct import pack, unpack
from sys import stderr

import os
import progressbar
from progressbar import Bar
from progressbar import ETA
from progressbar import FileTransferSpeed
from progressbar import Percentage

from params import hash_crc16, hash_crc32

MAX_IPLEN = 1500


def make_cdf_dat(cluster, name, elements):
    if not os.path.isdir('./stats'):
        os.makedirs('./stats')

    counter = Counter(elements)
    tot_elements = float(len(elements))

    if name == 'iplen':
        distr = {x: (counter[x] / tot_elements) for x in sorted(counter.keys())}
    else:
        distr_list = [counter[x] / tot_elements for x in counter]
        distr_list = sorted(distr_list, reverse=True)
        distr = {i: distr_list[i] for i in range(len(distr_list))}

    with open('./stats/cluster-%s-%s-distr.dat' % (cluster, name), 'w') as f:
        for x in sorted(distr.keys()):
            print >> f, "%s\t%s" % (x, distr[x])


def parse_trace(cluster, trace_lines):
    assert cluster in ('A', 'B', 'C')
    label = "cluster-%s" % cluster
    parsed_filename = label + '.parsed'
    pkt_report_count = 0
    next_report_pkts = 10
    start_ts = time.time()
    discarded_count = 0
    processed_count = 0
    parsed_lines = []
    i = 0

    print "Will parse %d packets..." % len(trace_lines)

    widgets = [label, Percentage(), ' ', Bar(), ' ', ETA(), ' ', FileTransferSpeed(unit='p')]
    bar = progressbar.ProgressBar(widgets=widgets)
    bar.start(max_value=len(trace_lines))
    bar.update(1)

    iplens = []
    ipsrcs = []
    ipdsts = []
    protos = []
    sports = []
    dports = []

    try:
        for tline in trace_lines:

            ts, iplen, ipsrc, ipdst, sport, dport, proto = tline.split("\t")[0:7]

            direct = 'X'
            ts = float(ts)
            iplen = min(int(iplen), MAX_IPLEN)
            ipsrc = pack('I', hash_crc32(ipsrc))
            ipdst = pack('I', hash_crc32(ipdst))
            proto = chr(int(proto))
            sport = hash_crc16(sport)
            dport = hash_crc16(dport)

            iplens.append(iplen)
            ipsrcs.append(ipsrc)
            ipdsts.append(ipdst)
            protos.append(proto)
            sports.append(sport)
            dports.append(dport)

            parsed_lines.append(pack('cdH4s4scHH', direct, ts, iplen, ipsrc, ipdst, proto, sport, dport))

            processed_count += 1

            pkt_report_count += 1
            i += 1

            if pkt_report_count >= next_report_pkts:
                # Check if we're packing right
                pieces = unpack('cdH4s4scHH', parsed_lines[-1])
                assert (direct, ts, iplen, ipsrc, ipdst, proto, sport, dport) == tuple(pieces)
                delta_seconds = time.time() - start_ts
                pkt_rate = pkt_report_count / delta_seconds
                next_report_pkts = int(pkt_rate) * 0.5
                pkt_report_count = 0
                start_ts = time.time()
                bar.update(i)

    finally:
        bar.update(i)

    with open('%s' % parsed_filename, 'wb') as f:
        f.write(''.join(parsed_lines))

    make_cdf_dat(cluster, 'iplen', iplens)
    make_cdf_dat(cluster, 'ipsrc', ipsrcs)
    make_cdf_dat(cluster, 'ipdst', ipdsts)
    make_cdf_dat(cluster, 'proto', protos)
    make_cdf_dat(cluster, 'sport', sports)
    make_cdf_dat(cluster, 'dport', dports)

    msg = "PARSER: completed %s, processed=%dpkts, discarded=%dpkts (%.3f)" % (label,
                                                                               processed_count,
                                                                               discarded_count,
                                                                               discarded_count / float(i))
    with open('fb_parse_report.txt', 'a') as r:
        r.write(msg + "\n")


def rename_bz2_files():
    for f in os.listdir('./'):
        if '.bz2' in f:
            if not f.endswith('.bz2'):
                new_fname = f[0:f.index('.bz2')] + '.bz2'
                os.rename(f, new_fname)


def unzip_all():
    for f in os.listdir('./'):
        if f.endswith('.bz2'):
            print "Unzipping %s..." % f
            retcode = os.system('bunzip2 ' + f)
            if retcode == 0:
                pass
                # os.remove(f)
            else:
                print >> stderr, "unable to unzip " + f


def parse_cluster(cluster):
    assert cluster in ('A', 'B', 'C')

    # Trigger parsing
    print "Starting parsing of cluster %s" % cluster

    rename_bz2_files()
    unzip_all()

    trace_lines = []

    trace_files = os.listdir('./')
    trace_files = [x for x in trace_files if x.endswith('_n')]
    trace_files = sorted(trace_files)

    for fname in trace_files:
        if fname.endswith('_n'):
            with open(fname) as ftrace:
                trace_lines.extend(ftrace.readlines())

    parse_trace(cluster, trace_lines)


if __name__ == "__main__":
    for cluster in ('A', 'B', 'C'):
        curr_dir = os.path.dirname(os.path.realpath(__file__))
        trace_fullpath = os.path.dirname(os.path.realpath(__file__)) + '/fb/%s' % cluster
        if not curr_dir.endswith('fb/%s' % cluster):
            os.chdir(trace_fullpath)
        parse_cluster(cluster)