from array import array
from collections import deque

DEBUG = False

SKIP = -1
WORK, EMPTY, STALL, HAZARD = range(4)


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

    def key_count(self):
        return 0


class OPPScheduler:
    def __init__(self, Q, W, N, hash_func):
        # assert Q >= N, "Q must be greater or equal to N"
        self.Q = Q
        self.N = N
        self.W = W
        self.hash_func = hash_func
        self.queues = [deque(array('h', [])) for _ in range(Q)]
        self.hols = [None] * Q
        self.locked_digests = deque([None] * N)
        self.range_Q = [i for i in range(self.Q)]
        self.first_priority = 0
        # Cache digests for speed and reporting.
        self.digests = {self.Q: {}, self.W: {}}
        self.locked_count = 0
        self.queues_sum_size = 0
        self.last_result = -1

    def accept(self, pkt):
        """
        Accept a new packet to be enqued in one of the flow queues.
        :param pkt: a SimPacket
        """
        # Enqueue ingress packet by its lookup key.
        q = self._digest(pkt.lookup_key, self.Q)
        w = self._digest(pkt.update_key, self.W)
        # Head of line, otherwise enqueue
        if self.hols[q] is None:
            self.hols[q] = w
        else:
            self.queues[q].append(w)
        self.queues_sum_size += 1

    def execute_tick(self):
        self.last_result = self._execute_tick()
        return self.last_result

    def _execute_tick(self):
        """
        Executes a clock tick. This is the main scheduler execution.
        :return: True if a packet was served, False if not (i.e. idle cycle)
        """
        # Remove last digest form the pipeline.
        if self.locked_digests.pop():
            # Extracted value is not None
            self.locked_count -= 1

        if self.queues_sum_size == 0:
            # No packets to serve.
            self.locked_digests.appendleft(None)
            if self.locked_count == 0:
                return SKIP
            else:
                return EMPTY

        # There are packets that are waiting to be served...

        # Update round robin priority.
        self.first_priority = (self.first_priority + 1) % self.Q

        for i in self.range_Q:
            # Round robin priority.
            q = (i + self.first_priority) % self.Q
            # !! Scheduler arbitration condition !!
            w = self.hols[q]
            if w is not None and w not in self.locked_digests:
                # Found a packet that can be safelly served, with no concurrency hazards
                # Update the hol spot for this queue.
                try:
                    self.hols[q] = self.queues[q].popleft()
                except IndexError:
                    # Queue empty.
                    self.hols[q] = None
                self.locked_digests.appendleft(w)
                self.queues_sum_size -= 1
                self.locked_count += 1
                return WORK

        # Any packet could be served, this is a stall.
        self.locked_digests.appendleft(None)
        return STALL

    def _digest(self, key, space):
        try:
            return self.digests[space][key]
        except KeyError:
            digest = self.hash_func(key) % space
            self.digests[space][key] = digest
            return digest

    def digest_stats(self, space=None):
        # FIXME: should report for Q or W?
        if not space:
            space = self.Q
        digest_count = float(len(self.digests[space]))
        return [sum(x == s for x in self.digests[space].values()) / digest_count for s in range(space)]

    def key_count(self):
        return len(self.digests[self.Q])


class HazardDetector:
    def __init__(self, Q, W, N, hash_func):
        # assert Q >= N, "Q must be greater or equal to N"
        assert Q == W
        self.Q = Q
        self.N = N
        self.hash_func = hash_func
        self.locked_digests = deque([None] * N)
        # Cache digests for speed and reporting.
        self.digests = dict()
        self.the_pkt = None
        self.last_result = -1

    def accept(self, pkt):
        """
        Accept a new packet to be enqued in one of the flow queues.
        :param pkt: a SimPacket
        """
        self.the_pkt = pkt

    def execute_tick(self):
        self.last_result = self._execute_tick()
        return self.last_result

    def _execute_tick(self):
        """
        Executes a clock tick. This is the main scheduler execution.
        :return: True if a packet was served, False if not (i.e. idle cycle)
        """

        # Remove last digest form the pipeline.
        self.locked_digests.pop()

        if self.the_pkt is None:
            # No packets to serve.
            key_to_lock = None
            result = EMPTY
        else:
            q = self._digest(self.the_pkt.lookup_key)
            key_to_lock = self._digest(self.the_pkt.update_key)
            if q in self.locked_digests:
                result = HAZARD
            else:
                result = WORK

        self.locked_digests.appendleft(key_to_lock)
        self.the_pkt = None
        return result

    def _digest(self, key):
        try:
            return self.digests[key]
        except KeyError:
            if self.Q > 0:
                digest = self.hash_func(key) % self.Q
            else:
                digest = self.hash_func(key)
            self.digests[key] = digest
            return digest

    def digest_stats(self):
        digest_count = float(len(self.digests))
        return [sum(x == q for x in self.digests.values()) / digest_count for q in range(self.Q)]

    def key_count(self):
        return len(self.digests)
