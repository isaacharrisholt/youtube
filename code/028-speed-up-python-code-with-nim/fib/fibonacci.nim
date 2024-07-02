import nimpy

proc fib(n: int): int {.exportpy.} =
    if n <= 1:
        return n
    else:
        return fib(n - 1) + fib(n - 2)
