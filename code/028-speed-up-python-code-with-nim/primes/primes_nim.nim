import nimpy
from std/math import sqrt

proc is_prime(num: int): bool =
    for i in 2..int(sqrt(float64(num))):
        if num mod i == 0:
            return false

    return true


proc nth_prime(n: int): int {.exportpy.} = 
    var found = 0
    var num = 1

    while found < n:
        num += 1
        if not is_prime(num):
            continue

        found += 1

    return num
