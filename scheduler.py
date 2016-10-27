from array import array
from collections import deque

DEBUG = False


class DummyScheduler:
    def __init__(self, Q, N, hash_func):
        self.digests = dict()
        self.queues = [[] for _ in range(Q)]
        self.queues_sum_size = 0
        pass

    def accept(self, pkt):
        return True

    def execute_tick(self):
        return False

    def queue_occupancy(self):
        return 0, 0

    def digest_stats(self):
        return []


class Scheduler:
    def __init__(self, Q, N, hash_func):
        # assert Q >= N, "Q must be greater or equal to N"
        self.Q = Q
        self.N = N
        self.hash_func = hash_func
        self.queues = [deque(array('h', [])) for _ in range(Q)]
        self.hols = [None] * Q
        self.locked_digests = deque([None] * N)
        self.range_Q = [i for i in range(self.Q)]
        self.first_priority = 0
        # Cache digests for speed and reporting.
        self.digests = dict()
        self.locked_count = 0
        self.queues_sum_size = 0

    def accept(self, pkt):
        """
        Accept a new packet to be enqued in one of the flow queues.
        :param pkt: a SimPacket
        """
        # Enqueue ingress packet by its lookup key.
        q = self._digest(pkt.lookup_key)
        if self.hols[q] is None:
            self.hols[q] = self._digest(pkt.update_key)
        else:
            self.queues[q].append(self._digest(pkt.update_key))
        self.queues_sum_size += 1

    def execute_tick(self):
        """
        Executes a clock tick. This is the main scheduler execution.
        :return: True if a packet was served, False if not (i.e. idle cycle)
        """

        if self.queues_sum_size == 0 and self.locked_count == 0:
            # Queues and pipeline are empty.
            return -1

        # Update round robin priority.
        self.first_priority = (self.first_priority + 1) % self.Q

        # Remove last digest form the pipeline.
        if self.locked_digests.pop():
            # Extracted value is not None.
            self.locked_count -= 1

        for i in self.range_Q:
            # Round robin priority.
            q = (i + self.first_priority) % self.Q
            # !! Scheduler arbitration condition !!
            if self.hols[q] is not None and q not in self.locked_digests:
                update_digest = self.hols[q]
                # Update the hol spot for this queue.
                try:
                    self.hols[q] = self.queues[q].popleft()
                except IndexError:
                    # Queue empty.
                    self.hols[q] = None
                self.locked_digests.appendleft(update_digest)
                self.queues_sum_size -= 1
                self.locked_count += 1
                return 1

        # IDLE!
        self.locked_digests.appendleft(None)
        return 0

    def _digest(self, key):
        try:
            return self.digests[key]
        except KeyError:
            digest = self.hash_func(key) % self.Q
            self.digests[key] = digest
            return digest

    def digest_stats(self):
        digest_count = float(len(self.digests))
        return [sum(x == q for x in self.digests.values()) / digest_count for q in range(self.Q)]
