from Queue import Queue, Empty
import logging

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

    def accept(self, packet):
        """
        Accept a new packet to be enqued in one of the flow queues.
        :param packet: a packet
        :return: True if packet can be accepted, False otherwise (e.g. queues are full)
        """
        # Enqueue ingress packet by its lookup key.
        digest = self.hash_func(packet.lookup_key) % self.Q
        self.queues[digest].put(packet)
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
                    self.hols[q] = self.queues[q].get_nowait()
                except Empty:
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

    def _serve(self, packet):
        """
        Serve a packet, push it at the beginning of the processing pipeline.
        :param packet: a packet or None
        :return: None
        """
        if packet is None:
            # Insert None at beginning of the list....
            self.locked_keys.insert(0, None)
        else:
            # Insert hash of the update key at the beginning of the list.
            digest = self.hash_func(packet.update_key) % self.Q
            self.locked_keys.insert(0, digest)

        # Remove last key.
        self.locked_keys.pop()

    def queue_occupancy(self):
        sizes = [x.qsize() for x in self.queues]
        return sum(sizes), max(sizes)
