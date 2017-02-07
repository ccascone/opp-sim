import random
import struct
from collections import Counter
from sys import stderr

from math import floor

import conf
from simpacket import SimPacket

MIN_SIZE = 64


def pkt_size(len, mlen):
    if random.randrange(0, 100) > mlen * 100 and len > 1000 * mlen:
            return max(64, int(random.gauss(1, 1.5) * 300 * mlen + 64))
    else:
        return max(64, len)


def plot_cdf(trace_day, trace_ts, mlen=1):
    fname_a = conf.trace_dir + '/' + conf.trace_fname('A', trace_day, trace_ts, 'parsed')
    fname_b = conf.trace_dir + '/' + conf.trace_fname('B', trace_day, trace_ts, 'parsed')
    dump_a = open(fname_a, 'rb').read()
    dump_b = open(fname_b, 'rb').read()
    tot_pkt_a = len(dump_a) / 32
    tot_pkt_b = len(dump_b) / 32

    pkt_lengths_a = []
    pkt_lengths_b = []
    for pkt_id in range(tot_pkt_a):
        try:
            pkt_lengths_a.append(pkt_size(SimPacket(dump_a, pkt_id * 32).iplen, mlen))
        except struct.error:
            print >> stderr, "Found corrupted data in A"
            tot_pkt_a -= 1

    for pkt_id in range(tot_pkt_b):
        try:
            pkt_lengths_b.append(pkt_size(SimPacket(dump_b, pkt_id * 32).iplen, mlen))
        except struct.error:
            print >> stderr, "Found corrupted data in B"
            tot_pkt_b -= 1

    counter = Counter()
    counter.update(pkt_lengths_a)
    counter.update(pkt_lengths_b)
    counter.update([0, 1500])

    tot_pkt = float(tot_pkt_a + tot_pkt_b)
    cdf = {x: y / tot_pkt for x, y in counter.items()}
    x_sorted = sorted(counter.keys())

    with open('plot_data/pkt_size-mlen=%s.dat' % mlen, 'w') as f:
        for x in x_sorted:
            print >> f, "%s %s" % (x, cdf[x])


if __name__ == '__main__':
    for m in [x / 100.0 for x in range(0, 110, 10)]:
        plot_cdf(trace_day=conf.trace_day, trace_ts=130000, mlen=m)
