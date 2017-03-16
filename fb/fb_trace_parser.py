import time
from collections import Counter
from collections import deque
from multiprocessing import Pool, cpu_count
from struct import pack, unpack
from sys import stderr

import os
import progressbar
from progressbar import Bar
from progressbar import ETA
from progressbar import FileTransferSpeed
from progressbar import Percentage

MAX_IPLEN = 1500
MAX_RACK_PER_CLUSTER = 30
MAX_PACKETS_PER_RACK = 50000000

mapz = dict(ip=dict(), port=dict())
mapz_count = dict(ip=0, port=0)


def reduce_addr_space(type, value):
    if value not in mapz[type]:
        mapz[type][value] = mapz_count[type]
        mapz_count[type] += 1
    return mapz[type][value]


def make_cdf_dat(cluster, name, counter):
    if not os.path.isdir('./stats'):
        os.makedirs('./stats')

    tot_elements = float(sum(counter.values()))

    if name == 'iplen':
        distr = {x: (counter[x] / tot_elements) for x in sorted(counter.keys())}
    else:
        distr_list = [counter[x] / tot_elements for x in counter]
        distr_list = sorted(distr_list, reverse=True)
        distr = {i: distr_list[i] for i in range(len(distr_list))}

    with open('./stats/cluster-%s-%s-distr.dat' % (cluster, name), 'w') as f:
        for x in sorted(distr.keys()):
            print >> f, "%s\t%s" % (x, distr[x])


def parse_trace(cluster, trace_files):
    label = "cluster-%s" % cluster
    pkt_report_count = 0
    processed_count = 0
    # Grouped per rack
    i = 0

    print "Will process %s trace files..." % len(trace_files)

    widgets = [label, Percentage(), ' ', Bar(), ' ', ETA(), ' ', FileTransferSpeed(unit='p')]
    bar = progressbar.ProgressBar(widgets=widgets)
    bar.start(max_value=len(trace_files))
    bar.update(1)

    iplens = Counter()
    ipsrcs = Counter()
    ipdsts = Counter()
    protos = Counter()
    sports = Counter()
    dports = Counter()

    report_iplens = deque()
    report_ipsrcs = deque()
    report_ipdsts = deque()
    report_protos = deque()
    report_sports = deque()
    report_dports = deque()

    lines_count = dict()

    # we expect trace_files to be already sorted
    for tfile in trace_files:

        with open(tfile) as ftrace:
            trace_lines = ftrace.readlines()

        parsed_lines = dict()

        for tline in trace_lines:

            ts, iplen, ipsrc, ipdst, sport, dport, proto, hpsrc, \
            hpdst, racksrc, rackdst, _ = tline.split("\t", maxsplit=11)

            # The following packing logic is due to backward compatibility with CAIDA traces

            direct = 'X'
            ts = float(ts)
            iplen = min(int(iplen), MAX_IPLEN)
            ipsrc = pack('I', reduce_addr_space('ip', ipsrc))
            ipdst = pack('I', reduce_addr_space('ip', ipdst))
            proto = chr(int(proto))
            sport = reduce_addr_space('port', sport)
            dport = reduce_addr_space('port', dport)

            report_iplens.append(iplen)
            report_ipsrcs.append(ipsrc)
            report_ipdsts.append(ipdst)
            report_protos.append(proto)
            report_sports.append(sport)
            report_dports.append(dport)

            packed_line = pack('cdH4s4scHH', direct, ts, iplen, ipsrc, ipdst, proto, sport, dport)

            for rackid in (racksrc, rackdst):
                if rackid not in parsed_lines:
                    parsed_lines[rackid] = []
                parsed_lines[rackid].append(packed_line)

            pkt_report_count += 1

        # Finished parsing this file, write data
        i += 1
        bar.update(i)

        iplens.update(report_iplens)
        ipsrcs.update(report_ipsrcs)
        ipdsts.update(report_ipdsts)
        protos.update(report_protos)
        sports.update(report_sports)
        dports.update(report_dports)

        report_iplens = deque()
        report_ipsrcs = deque()
        report_ipdsts = deque()
        report_protos = deque()
        report_sports = deque()
        report_dports = deque()

        for rack in parsed_lines:
            with open('%s-%s.parsed' % (cluster, rack), 'ab') as f:
                f.write(''.join(parsed_lines[rack]))
                if rack not in lines_count:
                    lines_count[rack] = 0
                lines_count[rack] += len(parsed_lines[rack])

        max_count = max(lines_count.values())

        if max_count >= MAX_PACKETS_PER_RACK:
            print "\nReached max number of packets per rack. Stopping here."
            break
        else:
            print "\nCurrent max packets per rack: %s" % max_count

    make_cdf_dat(cluster, 'iplen', iplens)
    make_cdf_dat(cluster, 'ipsrc', ipsrcs)
    make_cdf_dat(cluster, 'ipdst', ipdsts)
    make_cdf_dat(cluster, 'proto', protos)
    make_cdf_dat(cluster, 'sport', sports)
    make_cdf_dat(cluster, 'dport', dports)


def rename_bz2_files():
    pool = Pool(cpu_count())
    param_list = []
    for f in os.listdir('./'):
        if '.bz2' in f:
            if not f.endswith('.bz2'):
                new_fname = f[0:f.index('.bz2')] + '.bz2'
                param_list.append((f, new_fname))
    if len(param_list) > 0:
        pool.map(os.rename, param_list)
        pool.close()
        pool.join()


def unzip_all():
    def worker(fname):
        print "Unzipping %s..." % fname
        retcode = os.system('bunzip2 ' + fname)
        if retcode != 0:
            print >> stderr, "unable to unzip " + fname

    pool = Pool(cpu_count())
    param_list = [f for f in os.listdir('./') if f.endswith('.bz2')]
    pool.map(worker, param_list)
    pool.close()
    pool.join()


def parse_cluster(cluster):
    assert cluster in ('A', 'B', 'C')

    # Trigger parsing
    print "Starting parsing of cluster %s" % cluster

    # rename_bz2_files()
    # unzip_all()

    trace_files = os.listdir('./')
    trace_files = [x for x in trace_files if x.endswith('_n')]
    trace_files = sorted(trace_files)

    parse_trace(cluster, trace_files)


if __name__ == "__main__":
    for cluster in ('A', 'B', 'C'):
        curr_dir = os.path.dirname(os.path.realpath(__file__))
        trace_fullpath = os.path.dirname(os.path.realpath(__file__)) + '/' + cluster
        if not os.path.isdir(trace_fullpath):
            continue
        if not curr_dir.endswith('fb/%s' % cluster):
            os.chdir(trace_fullpath)
        parse_cluster(cluster)
