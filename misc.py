import hashlib

import os
from genericpath import isfile

from conf import trace_dir, md5s
from simpacket import SimPacket


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


def md5(fname):
    hash_md5 = hashlib.md5()
    with open(fname, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()


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


def was_downloaded(fname):
    this_dir = os.path.dirname(os.path.realpath(__file__))
    file_path = this_dir + '/' + trace_dir + '/' + fname
    return isfile(file_path) and md5(file_path) == md5s[fname]


powers = [(9, 'G', 'n'), (6, 'M', 'u'), (3, 'K', 'm')]

if __name__ == '__main__':
    result = evaluate_trace_bitrate('caida/equinix-chicago.dirA.20150219-125911.UTC.anon.parsed')
    for key in result:
        print "%s: %s" % (key, hnum(result[key]))
