from array import array
from collections import deque

DEBUG = False

SKIP = -1
WORK, EMPTY, STALL, HAZARD = range(4)


class OPPScheduler():
    def __init__(self, Q, W, N, hash_func):
        # assert Q >= N, "Q must be greater or equal to N"
        self.Q = Q
        self.N = N
        self.W = W
        self.hash_func = hash_func
        self.queues = [deque(array('h', [])) for _ in range(Q)]
        self.hols = [None] * Q
        self.pipeline = deque([None] * N)
        self.range_Q = [i for i in range(self.Q)]
        self.first_priority = 0
        # Cache digests for speed and reporting.
        self.digests = {self.Q: {}, self.W: {}}
        self.pipeline_count = 0
        self.pkt_backlog = 0
        self.last_result = -1
        self.clock = 0
        self.latencies = deque()
        self.queue_lens = deque()

    def accept(self, pkt):
        """
        Accept a new packet to be enqued in one of the flow queues.
        :param pkt: a SimPacket
        """
        # Enqueue ingress packet by its lookup key.
        q = self._digest(pkt.lookup_key, self.Q)
        w = self._digest(pkt.update_key, self.W)
        p = (w, self.clock)
        # Head of line, otherwise enqueue
        if self.hols[q] is None:
            self.hols[q] = p
        else:
            self.queues[q].append(p)
            self.queue_lens.append([len(self.queues[i]) for i in self.range_Q])
        self.pkt_backlog += 1

    def execute_tick(self):
        self.last_result = self._execute_tick()
        self.clock += 1
        return self.last_result

    def _execute_tick(self):
        """
        Executes a clock tick. This is the main scheduler execution.
        :return: True if a packet was served, False if not (i.e. idle cycle)
        """

        # Remove last digest form the pipeline.
        if self.pipeline.pop():
            # Extracted value is not None
            self.pipeline_count -= 1

        if self.pkt_backlog == 0:
            # No packets to serve.
            self.pipeline.appendleft(None)
            if self.pipeline_count == 0:
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
            p = self.hols[q]
            if p is not None and p[0] not in self.pipeline:
                # Found a packet that can be safelly served, with no concurrency hazards
                # Update the hol spot for this queue.
                try:
                    self.hols[q] = self.queues[q].popleft()
                except IndexError:
                    # Queue empty.
                    self.hols[q] = None
                self.pipeline.appendleft(p[0])
                self.pkt_backlog -= 1
                self.pipeline_count += 1
                self.latencies.append(self.clock - p[1])
                return WORK

        # No packets can be served, this is a stall.
        self.pipeline.appendleft(None)
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

    def flush_latencies(self):
        latencies = self.latencies
        self.latencies = deque()
        return latencies

    def flush_queue_lens(self):
        samples = self.queue_lens
        self.queue_lens = deque()
        return samples

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

    def flush_latencies(self):
        # No latency in this scheduler
        return []

    def flush_queue_lens(self):
        return [[0]]

    def key_count(self):
        return len(self.digests)
