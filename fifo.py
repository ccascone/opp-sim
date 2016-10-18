from collections import deque


class Empty(Exception):
    pass


class Queue1:
    """Implementation using 2 stacks"""

    def __init__(self):
        self.in_stack = []
        self.out_stack = []

    def put(self, obj):
        self.in_stack.append(obj)

    def get(self):
        if not self.out_stack:
            while self.in_stack:
                self.out_stack.append(self.in_stack.pop())
        return self.out_stack.pop()

    def qsize(self):
        return len(self.in_stack) + len(self.out_stack)


class Queue2:
    """Implementation using deque"""

    def __init__(self):
        self.listz = deque([])

    def put(self, obj):
        self.listz.append(obj)

    def get(self):
        return self.listz.popleft()

    def qsize(self):
        return len(self.listz)


def qsize(self):
    return len(self.listz)
