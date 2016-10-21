from struct import unpack_from, pack


class SimPacket():
    def __init__(self, packed_buffer, offset=0):
        self.direct, self.ts_nano, self.iplen = unpack_from('cdH', packed_buffer, offset=offset)
        self.packed_buffer = packed_buffer
        self.offset = offset
        self.lookup_key = None
        self.update_key = None

    def buf_slice(self, start, len):
        # type: () -> string
        return self.packed_buffer[self.offset + 18 + start:self.offset + 18 + start + len]

    def ipsrc(self):
        # type: () -> string
        return self.buf_slice(0, 4)

    def ipdst(self):
        # type: () -> string
        return self.buf_slice(4, 4)

    def proto(self):
        # type: () -> string
        return self.buf_slice(8, 2)

    def sport(self):
        # type: () -> string
        return self.buf_slice(10, 2)

    def dport(self):
        # type: () -> string
        return self.buf_slice(12, 2)
