from struct import unpack_from, pack


class SimPacket():
    def __init__(self, packed_buffer, offset=0):
        self.direct, self.ts_nano, self.iplen = unpack_from('cdH', packed_buffer, offset=offset)
        self.packed_buffer = packed_buffer
        self.offset = offset
        self.lookup_key = None
        self.update_key = None

    def buf_slice(self, start, length):
        # type: () -> string
        return self.packed_buffer[self.offset + 18 + start:self.offset + 18 + start + length]

    def ipsrc(self):
        # type: () -> string
        return self.buf_slice(0, 4)

    def ipsrc8(self):
        # type: () -> string
        return self.buf_slice(0, 1)

    def ipsrc16(self):
        # type: () -> string
        return self.buf_slice(0, 2)

    def ipsrc24(self):
        # type: () -> string
        return self.buf_slice(0, 3)

    def ipdst(self):
        # type: () -> string
        return self.buf_slice(4, 4)

    def ipdst8(self):
        # type: () -> string
        return self.buf_slice(4, 1)

    def ipdst16(self):
        # type: () -> string
        return self.buf_slice(4, 2)

    def ipdst24(self):
        # type: () -> string
        return self.buf_slice(4, 3)

    def proto(self):
        # type: () -> string
        return self.buf_slice(8, 2)

    def sport(self):
        # type: () -> string
        return self.buf_slice(10, 2)

    def dport(self):
        # type: () -> string
        return self.buf_slice(12, 2)


class DummyPacket():
    def __init__(self, direct, ts_nano, iplen):
        self.direct, self.ts_nano, self.iplen = direct, ts_nano, iplen
        self.lookup_key = None
        self.update_key = None

    def buf_slice(self, start, length):
        return "0"

    def ipsrc(self):
        return "0"

    def ipsrc8(self):
        return "0"

    def ipsrc16(self):
        return "0"

    def ipsrc24(self):
        return "0"

    def ipdst(self):
        return "0"

    def ipdst8(self):
        return "0"

    def ipdst16(self):
        return "0"

    def ipdst24(self):
        return "0"

    def proto(self):
        return "0"

    def sport(self):
        return "0"

    def dport(self):
        return "0"
