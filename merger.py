import heapq
from struct import pack

import os
import progressbar

import conf
from conf import trace_fname, trace_dir
from simpacket import SimPacket


def dump_iterator(fname, rel_start_ts, direction):
    with open(fname, 'rb') as f:
        first_ts = 0
        while True:
            data = f.read(4096)[:]
            if not data:
                break
            for i in range(len(data) / 32):
                pkt_str = data[i * 32:(i + 1) * 32]
                pkt_ts = SimPacket(pkt_str).ts_nano
                if not first_ts:
                    first_ts = pkt_ts
                new_ts = pkt_ts - first_ts + rel_start_ts
                new_head = pack('cd', direction, new_ts)
                yield (new_ts, new_head + pkt_str[len(new_head):])


def read_first_ts(fname):
    with open(fname, 'rb') as f:
        return SimPacket(f.read(32)).ts_nano


def dump_merge(times):
    fnames_a = dict()
    fnames_b = dict()
    for t in times:
        fnames_a[t] = trace_dir + '/' + trace_fname(direction='A', time=t, extension='parsed')
        fnames_b[t] = trace_dir + '/' + trace_fname(direction='B', time=t, extension='parsed')
    tot_pkts = sum(os.path.getsize(fname) / 32 for fname in fnames_a.values() + fnames_b.values())
    print "Will process %d packets..." % tot_pkts
    first_ts_a = read_first_ts(fnames_a[min(times)])
    first_ts_b = read_first_ts(fnames_b[min(times)])
    print "First timestamps are: A=%.9f, B=%.9f" % (first_ts_a, first_ts_b)
    dump_iterators = []
    for fname in fnames_a.values():
        dump_iterators.append(dump_iterator(fname, first_ts_a, 'A'))
    for fname in fnames_b.values():
        dump_iterators.append(dump_iterator(fname, first_ts_b, 'B'))

    bar = progressbar.ProgressBar(max_value=tot_pkts)
    count = 0
    tot_count = 0
    print "Starting merge..."
    with open("merge.parsed", 'wb') as destf:
        for rel_ts, pkt in heapq.merge(*dump_iterators):
            destf.write(pkt)
            count += 1
            if count == 10000:
                tot_count += count
                bar.update(tot_count)
                count = 0
        tot_count += count
        bar.finish()
        print "Processed %d packets" % tot_count


def merge_all():
    """
    Merges all bidirectional traffic traces found in trace dir.
    """
    times = []
    for time in conf.timestamps:
        for direct in conf.directions:
            fname = trace_dir + '/' + trace_fname(direct, time, 'parsed')
            if not os.path.isfile(fname):
                break
        else:
            times.append(time)
    print "Start merging of %d times..." % len(times)
    dump_merge(times)


if __name__ == '__main__':
    merge_all()
