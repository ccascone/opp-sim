from collections import deque


class Empty(Exception):
    pass


class Fifo:
    """Implementation using deque"""

    def __init__(self):
        self.lizt = deque([])

    def put(self, obj):
        self.lizt.append(obj)

    def get(self):
        return self.lizt.popleft()

    def qsize(self):
        return len(self.lizt)

    def empty(self):
        return self.qsize() == 0
