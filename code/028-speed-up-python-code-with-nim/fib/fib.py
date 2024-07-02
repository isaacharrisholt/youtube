import timeit
from dataclasses import dataclass

import fibbers
import fibonacci

RUNS = 100
N = 30


@dataclass
class Result:
    n: int
    python: float
    nim: float
    rust: float


def fib(n: int) -> int:
    if n <= 1:
        return n
    else:
        return fib(n - 1) + fib(n - 2)


def main():
    results = []

    for i in range(1, N + 1):
        print(f"N = {i}\nResults:")
        print(f"  Python: {fib(i)}")
        print(f"  Nim:    {fibonacci.fib(i)}")
        print(f"  Rust:   {fibbers.fib(i)}")

        # Benchmark
        python = timeit.timeit(lambda: fib(i), number=RUNS) / RUNS
        nim = timeit.timeit(lambda: fibonacci.fib(i), number=RUNS) / RUNS
        rust = timeit.timeit(lambda: fibbers.fib(i), number=RUNS) / RUNS

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

    with open("fib.csv", "w") as f:
        f.write("n,python,nim,rust,nim_v_python,rust_v_python,rust_v_nim\n")
        for result in results:
            f.write(
                f"{result.n},{result.python},{result.nim},{result.rust},{result.python / result.nim},{result.python / result.rust},{result.nim / result.rust}\n"
            )

    print("Results written to fib.csv")


if __name__ == "__main__":
    main()
