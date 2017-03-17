from PyCRC import CRC16
from PyCRC import CRC32

crc16c = CRC16.CRC16()
crc32c = CRC32.CRC32()


def hash_perfect(key):
    """Perfect hash with no collissions"""
    return key


def hash_crc16(key):
    return crc16c.calculate(key)


def hash_crc32(key):
    return crc32c.calculate(key)


def key_const(pkt):
    pkt.lookup_key = '1'
    pkt.update_key = '1'


def key_ipsrc(pkt):
    pkt.lookup_key = pkt.ipsrc()
    pkt.update_key = pkt.lookup_key


def key_ipsrc8(pkt):
    pkt.lookup_key = pkt.ipsrc8()
    pkt.update_key = pkt.lookup_key


def key_ipsrc16(pkt):
    pkt.lookup_key = pkt.ipsrc16()
    pkt.update_key = pkt.lookup_key


def key_ipsrc24(pkt):
    pkt.lookup_key = pkt.ipsrc24()
    pkt.update_key = pkt.lookup_key


def key_ipsrc_ipdst(pkt):
    pkt.lookup_key = pkt.ipsrc() + pkt.ipdst()
    pkt.update_key = pkt.lookup_key


def key_ipdst(pkt):
    pkt.lookup_key = pkt.ipdst()
    pkt.update_key = pkt.lookup_key


def key_ipdst8(pkt):
    pkt.lookup_key = pkt.ipdst8()
    pkt.update_key = pkt.lookup_key


def key_ipdst16(pkt):
    pkt.lookup_key = pkt.ipdst16()
    pkt.update_key = pkt.lookup_key


def key_ipdst24(pkt):
    pkt.lookup_key = pkt.ipdst24()
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
    pkt.lookup_key = pkt.proto() + pkt.sport()
    pkt.update_key = pkt.lookup_key
