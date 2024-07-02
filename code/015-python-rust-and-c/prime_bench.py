import math
import sys
from timeit import timeit

import primes

RUNS = 10_000


def is_prime(num: int) -> bool:
    for i in range(2, int(math.sqrt(num)) + 1):
        if num % i == 0:
            return False

    return True


def find_nth_prime(n: int) -> int:
    if n < 1 or not isinstance(n, int):
        raise ValueError("n must be a positive integer")

    found = 0
    num = 1

    while found < n:
        num += 1
        if not is_prime(num):
            continue

        found += 1

    return num


def main():
    n = int(sys.argv[1])
    print(n)
    print(f"{find_nth_prime(n) = }")
    print(f"{primes.nth_prime(n) = }")

    python_time_per_call = timeit(lambda: find_nth_prime(n), number=RUNS) / RUNS
    print(f"\nPython μs per call: {python_time_per_call * 1_000_000:.2f} μs")
    print(f"Python ms per call: {python_time_per_call * 1_000:.2f} ms")

    rust_time_per_call = timeit(lambda: primes.nth_prime(n), number=RUNS) / RUNS
    print(f"\nRust μs per call: {rust_time_per_call * 1_000_000:.2f} μs")
    print(f"Rust ms per call: {rust_time_per_call * 1_000:.2f} ms")


if __name__ == "__main__":
    main()
