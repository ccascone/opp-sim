from collections import deque


class Empty(Exception):
    pass


class Fifo:
    """Implementation using deque"""

    def __init__(self):
        self.listz = deque([])

    def put(self, obj):
        self.listz.append(obj)

    def get(self):
        return self.listz.popleft()

    def qsize(self):
        return len(self.listz)

    def empty(self):
        return self.qsize() == 0
