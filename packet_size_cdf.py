import struct
from collections import Counter
from collections import deque
from multiprocessing import cpu_count, Pool
from random import shuffle
from sys import stderr

import os
import time

from misc import get_trace_fname, alpha_pkt_size, hnum
from sim_params import caida_chi15_traces, caida_sj12_traces, fb_traces
from simpacket import SimPacket

MAX_PROCESS = cpu_count()

PKT_CYCLE = 1000000


def pass_func(pkt_size, alpha):
    return pkt_size


def parse_trace(args):
    fname, alpha = args

    alpha_func = pass_func if alpha == 1 else alpha_pkt_size

    try:
        with open(fname, 'rb') as fd:
            print "Reading %s..." % fname
            dump = fd.read()
    except IOError:
        print >> stderr, "Unable to read file, does it even exist? %s" % fname
        return fname, 0, []

    tot_pkts = len(dump) / 32
    pkt_lengths = deque()
    counter = Counter()

    last_ts = time.time()
    for pkt_id in range(tot_pkts):
        try:
            pkt_lengths.append(
                alpha_func(SimPacket(dump, pkt_id * 32).iplen, alpha))
        except struct.error:
            print >> stderr, "Found corrupted data in %s" % fname
            tot_pkts -= 1

        if (pkt_id % PKT_CYCLE) == PKT_CYCLE - 1:
            # flush pkt_lengths to avoid memory overflow
            counter.update(pkt_lengths)
            pkt_lengths = deque()
            rate = PKT_CYCLE / float(time.time() - last_ts)
            last_ts = time.time()
            print "[%spkts/s]" % hnum(rate)

    counter.update(pkt_lengths)

    # Stimulate garbage collector
    del dump

    print >> stderr, "Completed parsing %s" % fname

    return counter


def plot_cdf(name, traces, alpha=1):
    if not isinstance(traces, (list, tuple)):
        traces = [traces]

    fnames = []
    for t in traces:
        fnames.extend(get_trace_fname(t))
    # filter out empty fnames
    fnames = sorted(filter(None, fnames))

    param_list = [(fname, alpha) for fname in fnames]
    num_jobs = len(param_list)
    shuffle(param_list)

    print "%s: will process %d traces (pid %d)..." % (name, num_jobs, os.getpgid(0))

    pool = Pool(MAX_PROCESS)
    results = pool.map(parse_trace, param_list)

    tot_pkt = 0
    counter = Counter()

    for result in results:
        tot_pkt += sum(result.values())
        counter.update(result)

    tot_pkt = float(tot_pkt)
    cdf = {size: count / tot_pkt for size, count in counter.items()}
    x_sorted = sorted(counter.keys())

    if not os.path.exists('plot_data/pkt_size_cdf'):
        os.makedirs('plot_data/pkt_size_cdf')

    with open('plot_data/pkt_size_cdf/%s_alpha=%s.dat' % (name, alpha), 'w') as f:
        print >> f, "# Pkt size CDF:"
        print >> f, "#\t" + '\n#\t '.join(fnames)
        print >> f, "#\n# Evaluated over %s pkts" % int(tot_pkt)

        print >> f, "#\n# bytes -> fraction"
        w = len(str(max(x_sorted)))
        for x in x_sorted:
            print >> f, "%s %s" % (str(x).ljust(w), cdf[x])

    print "All done! %s packet processed" % int(tot_pkt)


if __name__ == '__main__':
    # plot_cdf('mawi-15', dict(provider='mawi', name='201507201400'))
    # plot_cdf('mawi-10', dict(provider='mawi', name='201003081400'))
    # plot_cdf('chi-15', caida_chi15_traces)
    # plot_cdf('sj-12', caida_sj12_traces)
    plot_cdf('fb', fb_traces)
    # plot_cdf('test', dict(provider='caida', link='equinix-chicago', day='20150219', time='125911', direction='X'))
