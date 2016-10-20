import hashlib

import os
from PyCRC import CRC16
from PyCRC import CRC32
from os.path import isfile

trace_dir = 'caida'
trace_link = 'equinix-chicago'
trace_url_prefix = "https://data.caida.org/datasets/passive-2015/equinix-chicago/20150219-130000.UTC/"
trace_day = "20150219"
directions = ('A', 'B')
extensions = ("pcap.gz", "pcap.stats", "times.gz")
timestamps = [125911, 130000, 130100, 130200, 130300, 130400, 130500, 130600, 130700, 130800, 130900, 131000,
              131100, 131200, 131300, 131400, 131500, 131600, 131700, 131800, 131900, 132000, 132100, 132200,
              132300, 132400, 132500, 132600, 132700, 132800, 132900, 133000, 133100, 133200, 133300, 133400,
              133500, 133600, 133700, 133800, 133900, 134000, 134100, 134200, 134300, 134400, 134500, 134600,
              134700, 134800, 134900, 135000, 135100, 135200, 135300, 135400, 135500, 135600, 135700, 135800,
              135900, 140000, 140100, 140200]
caida_user = "pontarelli@ing.uniroma2.it"
caida_passwd = "pont313"

md5s = {}


def trace_fname(direction, day, time, extension, link_name=trace_link):
    return "{link_name}.dir{direction}.{day}-{time}.UTC.anon.{extension}".format(**locals())


def parse_trace_fname(fname):
    """
    Returns direction, day, time, extension for the given trace file name.
    """
    pieces = fname.split('.', 5)
    assert (pieces[0], pieces[3], pieces[4]) == (trace_link, 'UTC', 'anon')
    date = pieces[2].split('-')
    if len(pieces) > 5:
        ext = pieces[5]
    else:
        ext = ''
    return pieces[1][-1], date[0], date[1], ext


# Returns the MD5 hash of the given filename
def md5(fname):
    hash_md5 = hashlib.md5()
    with open(fname, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()


def was_downloaded(fname):
    this_dir = os.path.dirname(os.path.realpath(__file__))
    file_path = this_dir + '/' + trace_dir + '/' + fname
    return isfile(file_path) and md5(file_path) == md5s[fname]


# Read MD5 (to avoid red-downloading the same file)
def read_md5_lines():
    with open(trace_dir + '/' + "md5.md5") as f:
        return f.readlines()


# Read MD5 from file and store in a dict (file_names as key)
for (k, v) in (l.split() for l in (l.strip() for l in read_md5_lines())):
    md5s[k] = v

crc16c = CRC16.CRC16()
crc32c = CRC32.CRC32()


def crc16(input):
    return crc16c.calculate(input)


def crc32(input):
    return crc32c.calculate(input)

def key_ipsrc(pkt):
    return pkt.ipsrc, pkt.ipsrc
