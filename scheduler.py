from fifo import Queue2 as Queue

DEBUG = False


class Scheduler:
    def __init__(self, Q, N, hash_func):
        assert Q >= N, "Q must be greater or equal to N"
        self.Q = Q
        self.N = N
        self.hash_func = hash_func
        self.queues = [Queue() for _ in range(Q)]
        self.hols = [None] * Q
        self.locked_keys = [None] * N
        self.first_priority = 0
        self.last_packet = None
        # Digests are cached for speed.
        self.digests = {}

    def accept(self, pkt):
        """
        Accept a new packet to be enqued in one of the flow queues.
        :param pkt: a packet
        :return: True if packet can be accepted, False otherwise (e.g. queues are full)
        """
        # Enqueue ingress packet by its lookup key.
        self.queues[self._digest(pkt.lookup_key)].put(pkt)
        # TODO if queues have limited size we could return false
        return True

    def execute_tick(self):
        """
        Executes a clock tick. This is the main scheduler execution.
        :return: True if a packet was served, False if not (i.e. idle cycle)
        """
        # Extract head of line (HOL) packets from queues...
        # ...if there's not already one blocking.
        for q in range(self.Q):
            if self.hols[q] is None:
                try:
                    self.hols[q] = self.queues[q].get()
                except IndexError:
                    pass

        # Update round robin priority.
        self.first_priority = (self.first_priority + 1) % self.Q

        for i in range(self.Q):
            # Round robin priority.
            q = (i + self.first_priority) % self.Q
            # Get head of line packet.
            pkt = self.hols[q]
            # Evaluate arbitration condition.
            if pkt is not None and q not in self.locked_keys:
                # Free the HOL spot for this queue.
                self.hols[q] = None
                self._serve(pkt)
                # Break the round robin loop.
                return True

        # IDLE!
        self._serve(None)
        return False

    def _serve(self, pkt):
        """
        Serve a packet, push it at the beginning of the processing pipeline.
        :param pkt: a packet or None
        :return: None
        """
        if pkt is None:
            # Insert None at beginning of the list....
            self.locked_keys.insert(0, None)
        else:
            # Insert hash of the update key at the beginning of the list.
            self.locked_keys.insert(0, self._digest(pkt.update_key))

        # Remove last key.
        self.locked_keys.pop()

    def _digest(self, key):
        try:
            return self.digests[key]
        except KeyError:
            digest = self.hash_func(key) % self.Q
            self.digests[key] = digest
            return digest

    def queue_occupancy(self):
        sizes = [x.qsize() for x in self.queues]
        return sum(sizes), max(sizes)
