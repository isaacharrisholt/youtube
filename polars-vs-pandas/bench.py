from typing import Callable

BenchmarkFunction = Callable[[], int]


def bench(name: str, f: BenchmarkFunction, n: int = 100) -> None:
    print(f"Benchmarking {name}...")

    total = 0
    for i in range(n):
        if i % (n // 10) == 0:
            print(f"Run {i} / {n}", end="\r", flush=True)
        result = f()
        total += result
    print(f"Run {n} / {n}")

    time = total / n
    print(f"{name} done. Time: {time:.2f}ms")
