from Queue import Queue, Empty
import logging

DEBUG = False

log = logging.getLogger("scheduler")


class Scheduler:
    def __init__(self, Q, N, hash_func):
        assert Q >= N, "Q must be greater or equal to N"
        self.Q = Q
        self.N = N
        self.hash_func = hash_func
        self.queues = [Queue() for _ in range(Q)]
        self.hols = [None] * Q
        self.stage_packets = [None] * N
        self.locked_keys = [None] * N
        self.first_priority = 0
        self.last_packet = None
        log.debug("scheduler created: Q=%d, N=%d, hash_func=%s", (Q, N, hash_func.__name__))

    def accept(self, packet):
        """
        Accept a new packet to enqued in one of the flow queues.
        :param packet: a packet
        :return: True if packet can be accepted, False otherwise (e.g. queues are full)
        """
        # Compute hash.
        digest = self.hash_func(packet.lookup_key)
        assert digest < self.Q, "invalid lookup key digest"
        packet.lookup_digest = digest
        # Enqueue packet.
        self.queues[digest].put(packet)
        log.debug("enqued packet on queue %d", digest)

    def prepare_tick(self):
        """
        Prepare for a clock tick.
        :return: None
        """
        # Extract head of line (HOL) packets.
        for q in range(self.Q):
            if self.hols[q] is None:
                try:
                    self.hols[q] = self.queues[q].get_nowait()
                except Empty:
                    pass
        log.debug("extracted hols: %s", str(self.hols))
        # Save reference to last served packet.
        self.last_packet = self.stage_packets[-1]
        # Shift packets and locked_keys forward.
        self.stage_packets = [None] + self.stage_packets[0:-1]
        self.locked_keys = [None] + self.locked_keys[0:-1]
        log.debug("shifted locked_keys: %s", str(self.locked_keys))

    def execute_tick(self):
        """
        Executes a clock tick. This is the main scheduler execution.
        :return:
        """
        log.debug("executing tick...")
        for q in range(self.Q):
            # Queue with highest priority.
            i = (q + self.first_priority) % self.Q
            log.debug("starting with queue %d", i)
            # Head of line packet.
            pkt = self.hols[i]
            if pkt is not None and pkt.lookup_digest not in self.locked_keys:
                log.debug("found pkt to serve: lookup_digest=%d", pkt.lookup_digest)
                self.serve(pkt)
                break
        else:
            # IDLE cycle!
            self.serve(None)

        # Round robin cyclic priority.
        self.first_priority = (self.first_priority + 1) % len(self.queues)

    def serve(self, packet):
        """
        Serve a packet, push it at the beginning of the processing pipeline.
        :param packet: a packet or None
        :return: None
        """
        if packet is None:
            log.warning("IDLE!")
        # Starts packet processing, i.e. first step of the stage.
        self.stage_packets[0] = packet
        # Update locked keys with update digest.
        digest = self.hash_func(packet.update_key)
        assert digest < self.Q, "invalid update key digest"
        self.locked_keys[0] = digest
