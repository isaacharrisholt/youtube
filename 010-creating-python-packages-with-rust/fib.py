import sys
from timeit import timeit

import fibbers


RUNS = 100


def fibonacci(n: int) -> int:
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)


def main():
    num = int(sys.argv[1])
    print(f"{fibonacci(num) = }")
    print(f"{fibbers.fib(num) = }")

    python_time_per_call = timeit(lambda: fibonacci(num), number=RUNS) / RUNS
    print(f"\nPython μs per call: {python_time_per_call * 1_000_000:.2f} μs")
    print(f"Python ms per call: {python_time_per_call * 1_000:.2f} ms")

    rust_time_per_call = timeit(lambda: fibbers.fib(num), number=RUNS) / RUNS
    print(f"\nRust μs per call: {rust_time_per_call * 1_000_000:.2f} μs")
    print(f"Rust ms per call: {rust_time_per_call * 1_000:.2f} ms")


if __name__ == '__main__':
    main()
