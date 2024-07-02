import math
import timeit
from dataclasses import dataclass

import primes as primes_rs
import primes_nim

RUNS = 100
N = 300


@dataclass
class Result:
    n: int
    python: float
    nim: float
    rust: float


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
    results = []

    for i in range(1, N + 1):
        print(f"N = {i}\nResults:")
        print(f"  Python: {find_nth_prime(i)}")
        print(f"  Nim:    {primes_nim.nth_prime(i)}")
        print(f"  Rust:   {primes_rs.nth_prime(i)}")

        # Benchmark
        python = timeit.timeit(lambda: find_nth_prime(i), number=RUNS) / RUNS
        nim = timeit.timeit(lambda: primes_nim.nth_prime(i), number=RUNS) / RUNS
        rust = timeit.timeit(lambda: primes_rs.nth_prime(i), number=RUNS) / RUNS

        print("\nTime per iteration:")
        # Show ms or μs depending on the result
        if python * 1000 > 1:
            print(f"  Python: {python * 1000:>7.3f}ms")
            print(f"  Nim:    {nim * 1000:>7.3f}ms")
            print(f"  Rust:   {rust * 1000:>7.3f}ms\n\n")
        else:
            print(f"  Python: {python * 1_000_000:>7.3f}μs")
            print(f"  Nim:    {nim * 1_000_000:>7.3f}μs")
            print(f"  Rust:   {rust * 1_000_000:>7.3f}μs\n\n")

        results.append(Result(i, python, nim, rust))

    with open("primes.csv", "w") as f:
        f.write("n,python,nim,rust,nim_v_python,rust_v_python,rust_v_nim\n")
        for result in results:
            f.write(
                f"{result.n},{result.python},{result.nim},{result.rust},{result.python / result.nim},{result.python / result.rust},{result.nim / result.rust}\n"
            )

    print("Results written to primes.csv")


if __name__ == "__main__":
    main()
