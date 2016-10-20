from struct import unpack_from


class SimPacket():
    def __init__(self, packed_buffer, offset=0):
        self.direct, self.ts_nano, self.iplen = unpack_from('cdH', packed_buffer, offset=offset)
        self.packed_buffer = packed_buffer
        self.offset = offset
        self.lkp_key = None
        self.upd_key = None

    def lookup_key(self):
        return self.lkp_key

    def update_key(self):
        return self.lkp_key

    def ip_src(self):
        return self.packed_buffer[self.offset + 18:self.offset + 22]
