class SimPacket():
    def __init__(self, lookup_key, update_key):
        """
        Creates a new packet
        :param lookup_key: lookup key
        :param update_key: update key
        :param size: packet size in bytes
        """
        self.lookup_key = lookup_key
        self.update_key = update_key

    def __repr__(self):
        return self.lookup_key+':'+self.update_key
