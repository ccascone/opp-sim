import inspect
from random import shuffle

import jenkins
from PyCRC import CRC16
from PyCRC import CRC32
from cityhash import CityHash32

import conf

crc16c = CRC16.CRC16()
crc32c = CRC32.CRC32()

N_values = [8]
Q_values = range(8, 17)
clock_freqs = [0, 1 * 10 ** 6, 1.2 * 10 ** 6, 1.5 * 10 ** 6]
read_chunks = [0, 40, 128, 256]
traces = conf.timestamps[0:3]


def hash_jenkins(key):
    return jenkins.hashlittle(key)


def hash_cityhash32(key):
    return CityHash32(key)


def hash_crc16(key):
    return crc16c.calculate(key)


def hash_crc32(key):
    return crc32c.calculate(key)


def key_ipsrc(pkt):
    pkt.lookup_key = pkt.ipsrc()
    pkt.update_key = pkt.lookup_key


def key_ipsrc_ipdst(pkt):
    pkt.lookup_key = pkt.ipsrc() + pkt.ipdst()
    pkt.update_key = pkt.lookup_key


def key_ipdst(pkt):
    pkt.lookup_key = pkt.ipdst()
    pkt.update_key = pkt.lookup_key


def key_ipsrc_X_ipdst(pkt):
    pkt.lookup_key = pkt.ipsrc()
    pkt.update_key = pkt.ipdst()


def key_ipsrc_ipdst_X_ipdst_ipsrc(pkt):
    pkt.lookup_key = pkt.ipsrc() + pkt.ipdst()
    pkt.update_key = pkt.ipdst() + pkt.ipsrc()


def key_ipsrc_dport(pkt):
    pkt.lookup_key = pkt.ipsrc() + pkt.dport()
    pkt.update_key = pkt.lookup_key


def key_5tuple(pkt):
    pkt.lookup_key = pkt.buf_slice(0, 14)
    pkt.update_key = pkt.lookup_key


def key_5tuple_X_5tuple(pkt):
    pkt.lookup_key = pkt.buf_slice(0, 14)
    pkt.update_key = pkt.ipdst() + pkt.ipsrc() + pkt.proto() + pkt.dport() + pkt.sport()


def key_proto_dport(pkt):
    pkt.lookup_key = pkt.proto() + pkt.dport()
    pkt.update_key = pkt.lookup_key


def key_proto_sport(pkt):
    pkt.lookup_key = pkt.sport() + pkt.sport()
    pkt.update_key = pkt.lookup_key


def gen_params():
    me = __import__(inspect.getmodulename(__file__))
    functions = inspect.getmembers(me, inspect.isfunction)
    params = []
    for trace_ts in traces:
        for Q in Q_values:
            for N in N_values:
                for hash_func in filter(lambda f: "hash_" in f[0], functions):
                    for clock_freq in clock_freqs:
                        for read_chunk in read_chunks:
                            for key_func in filter(lambda f: "key_" in f[0], functions):
                                params.append(dict(trace_day=conf.trace_day,
                                                   trace_ts=trace_ts,
                                                   clock_freq=clock_freq,
                                                   Q=Q,
                                                   N=N,
                                                   hash_func=hash_func[1],
                                                   key_func=key_func[1],
                                                   read_chunk=read_chunk))
    shuffle(params)
    return params


if __name__ == '__main__':
    print len(gen_params())
