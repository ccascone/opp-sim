import glob
import struct
from collections import Counter
from collections import deque
from multiprocessing import cpu_count, Pool
from random import shuffle
from sys import stderr

import os
import time

from misc import get_trace_fname, alpha_pkt_size, hnum
from result_parser import avg, perc_99th, median
from sim_params import caida_chi15_traces, caida_sj12_traces, fb_traces, keys_ccr, mawi15_traces, imc1_traces, \
    imc2_traces
from simpacket import SimPacket

MAX_PROCESS = cpu_count()

PKT_CYCLE = 1000000


def pass_func(pkt_size, alpha):
    return pkt_size


keys_to_count = keys_ccr


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
    key_sets = {k.__name__: set() for k in keys_to_count}
    counter = Counter()
    num_key_samples = {k.__name__: [] for k in keys_to_count}

    last_ts = time.time()
    for pkt_id in range(tot_pkts):
        try:
            pkt = SimPacket(dump, pkt_id * 32)
            pkt_lengths.append(alpha_func(pkt.iplen, alpha))
            for key_func in keys_to_count:
                key_func(pkt)
                key_sets[key_func.__name__].add(pkt.lookup_key)
        except struct.error:
            print >> stderr, "Found corrupted data in %s" % fname
            tot_pkts -= 1

        if (pkt_id % PKT_CYCLE) == PKT_CYCLE - 1:
            # flush pkt_lengths to avoid memory overflow
            counter.update(pkt_lengths)
            pkt_lengths = deque()
            for key_func in keys_to_count:
                num_key_samples[key_func.__name__].append(len(key_sets[key_func.__name__]))
            key_sets = {k.__name__: set() for k in keys_to_count}
            rate = PKT_CYCLE / float(time.time() - last_ts)
            last_ts = time.time()
            print "[%spkts/s]" % hnum(rate)

    # Update counters a last time
    counter.update(pkt_lengths)

    for key_func in keys_to_count:
        num_key_samples[key_func.__name__].append(len(key_sets[key_func.__name__]))

    # Stimulate garbage collector
    del dump

    print >> stderr, "Completed parsing %s" % fname

    return counter, num_key_samples


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
    num_key_samples = {k.__name__: [] for k in keys_to_count}

    for this_counter, this_num_key_samples in results:
        tot_pkt += sum(this_counter.values())
        counter.update(this_counter)
        for key_name in num_key_samples:
            num_key_samples[key_name].extend(this_num_key_samples[key_name])

    tot_pkt = float(tot_pkt)
    cdf = {size: count / tot_pkt for size, count in counter.items()}
    x_sorted = sorted(counter.keys())

    if not os.path.exists('plot_data/pkt_size_cdf'):
        os.makedirs('plot_data/pkt_size_cdf')

    with open('plot_data/pkt_size_cdf/%s_alpha=%s.dat' % (name, alpha), 'w') as f:
        print >> f, "# Pkt size CDF:"
        print >> f, "#\t" + '\n#\t '.join(fnames)
        print >> f, "#\n# Evaluated over %s pkts" % int(tot_pkt)
        print >> f, "#\n# key rate per %s pkts:" % PKT_CYCLE
        for key_name in num_key_samples:
            if len(num_key_samples[key_name]) == 0:
                print >> f, "# %s: no samples" % key_name
            else:
                ss = num_key_samples[key_name]
                print >> f, "# %s: %s (avg) %s (99th) %s (median) %s (max) %s (num_samples)"\
                            % (key_name, avg(ss), perc_99th(ss), median(ss), max(ss), len(ss))
        print >> f, "#\n# bytes -> fraction"
        w = len(str(max(x_sorted)))
        for x in x_sorted:
            print >> f, "%s %s" % (str(x).ljust(w), cdf[x])

    print "All done! %s packet processed" % int(tot_pkt)


def make_cumul():
    fnames = glob.glob('./plot_data/pkt_size_cdf/*.dat')
    fnames = filter(lambda x: 'cumul' not in x, fnames)
    for fname in fnames:
        with open(fname, 'r') as f:
            lines = f.readlines()

        lines = map(str.rstrip, lines)

        with open(fname[0:-4] + '_cumul.dat', 'w') as f:
            count = 0
            for line in lines:
                if line.startswith('#'):
                    print >> f, line
                else:
                    pieces = line.split()
                    x = pieces[0]
                    val = float(pieces[1])
                    count += val
                    print >> f, "%s %s" % (x, count)


if __name__ == '__main__':
    plot_cdf('mawi-15', mawi15_traces)
    # plot_cdf('mawi-10', dict(provider='mawi', name='201003081400'))
    plot_cdf('chi-15', caida_chi15_traces)
    plot_cdf('sj-12', caida_sj12_traces)
    plot_cdf('imc1', imc1_traces)
    plot_cdf('imc2', imc2_traces)
    plot_cdf('fb', fb_traces)
    # plot_cdf('test', dict(provider='caida', link='equinix-chicago', day='20150219', time='125911', direction='X'))
    make_cumul()
