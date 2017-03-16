import glob
import hashlib
import random

import os
from genericpath import isfile
from math import floor, ceil

import conf as caida_conf
from conf import trace_dir
from simpacket import SimPacket

powers = [(9, 'G', 'n'), (6, 'M', 'u'), (3, 'K', 'm')]


def hnum(value):
    value = float(value)
    if value == 0:
        return '0'
    for (p, b, s) in powers:
        if value > 10 ** p:
            return ("%.1f" % (value / 10 ** p)).rstrip('0').rstrip('.') + b
        if p != 3 and value < 10 ** -(p - 3):
            return ("%.1f" % (value * 10 ** p)).rstrip('0').rstrip('.') + s
    return ("%.2f" % value).rstrip('0').rstrip('.')


def percentile(N, percent, key=lambda x: x):
    """
    Find the percentile of a list of values.

    @parameter N - is a list of values. Note N MUST be sorted.
    @parameter percent - a float value from 0.0 to 1.0.
    @parameter key - optional key function to compute value from each element of N.

    @return - the percentile of the values
    """
    if not N:
        return None
    k = (len(N) - 1) * percent
    f = floor(k)
    c = ceil(k)
    if f == c:
        return key(N[int(k)])
    d0 = key(N[int(f)]) * (c - k)
    d1 = key(N[int(c)]) * (k - f)
    return d0 + d1


def get_trace_fname(trace):
    if trace['provider'] == 'caida':
        if 'direction' in trace and trace['direction'] == 'X':
            # Already merged trace
            fname_a = './caida/' + misc.caida_trace_fname(trace, 'parsed')
            fname_b = None
        else:
            fname_a = './caida/' + misc.caida_trace_fname(dict(direction='A', **trace), 'parsed')
            fname_b = './caida/' + misc.caida_trace_fname(dict(direction='B', **trace), 'parsed')

    elif trace['provider'] == 'fb':
        fname_a = './fb/%s/%s-%s.parsed' % (trace['cluster'], trace['cluster'], trace['rack'])
        fname_b = None

    elif trace['provider'] == 'mawi':
        fname_a = './mawi/%s.dump.parsed' % trace['name']
        fname_b = None
    else:
        raise Exception("Invalid trace provider %s" % trace['provider'])

    return fname_a, fname_b


def get_trace_label(trace):
    return '_'.join([trace['provider']] + [trace[k] for k in sorted(trace.keys()) if k != 'provider'])


def alpha_pkt_size(pkt_size, alpha):
    if random.randrange(0, 100) > alpha * 100 and pkt_size > 1000 * alpha:
        return max(64, int(random.gauss(1, 1.5) * 300 * alpha + 64))
    else:
        return max(64, pkt_size)


def evaluate_bitrate(dump):
    last_report_ts = 0
    byte_count = 0
    samples = []
    for i in range(len(dump) / 32):
        pkt = SimPacket(dump, i * 32)
        if last_report_ts == 0:
            last_report_ts = pkt.ts_nano
        byte_count += pkt.iplen
        if pkt.ts_nano - last_report_ts > 1:
            delta_time = pkt.ts_nano - last_report_ts
            bitrate = (byte_count * 8) / float(delta_time)
            samples.append(bitrate)
            last_report_ts = pkt.ts_nano
            byte_count = 0

    return dict(max=max(samples), min=min(samples), avg=(sum(samples) / len(samples)))


def caida_was_downloaded(fname):
    this_dir = os.path.dirname(os.path.realpath(__file__))
    file_path = this_dir + '/' + caida_conf.trace_dir + '/' + fname
    return isfile(file_path) # and md5(file_path) == caida_conf.md5s[fname]


def caida_list_all_trace_couples(subdir):
    fnames = glob.glob('./%s/%s/*.parsed' % (trace_dir, subdir))
    trace_opts = [caida_parse_trace_fname(fname)[0] for fname in fnames]
    trace_per_date = dict()
    for trace_opt in trace_opts:
        date = "%s-%s" % (trace_opt['day'], trace_opt['time'])
        if date not in trace_per_date:
            trace_per_date[date] = []
        trace_per_date[date].append(trace_opt)

    result = []

    for date in sorted(trace_per_date.keys()):
        num_traces = len(trace_per_date[date])
        directs = [trace_per_date[date][i]['direction'] for i in range(num_traces)]
        if 'X' in directs:
            result.append(trace_per_date[date][directs.index('X')])
        elif 'A' in directs and 'B' in directs:
            opt = trace_per_date[date][directs.index('A')]
            del opt['direction']
            result.append(opt)

    return result


def caida_trace_fname(trace_opts, extension):
    trace_opts['city'] = trace_opts['link'].split('-')[1]
    return "{city}-{day}/{link}.dir{direction}.{day}-{time}.UTC.anon.".format(**trace_opts) + extension


def caida_parse_trace_fname(fname):
    """
    Returns direction, day, time, extension for the given trace file name.
    """
    # drop subdir
    fname_pieces = fname.split('/')
    fname = fname_pieces[-1]
    pieces = fname.split('.', 5)
    assert (pieces[3], pieces[4]) == ('UTC', 'anon')
    date = pieces[2].split('-')
    if len(pieces) > 5:
        ext = pieces[5]
    else:
        ext = ''
    trace = dict(provider='caida', link=pieces[0], direction=pieces[1][-1], day=date[0], time=date[1])
    return trace, ext