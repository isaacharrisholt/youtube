import math
from random import randint
from timeit import timeit
from typing import Callable

import distance_c
import distance_nim
import distance_rs


def generate_points(n: int, plane_size: int = 100) -> list[tuple[int, int]]:
    return [(randint(0, plane_size), randint(0, plane_size)) for _ in range(n)]


def benchmark_distance_function(
    lang: str,
    func: Callable[[list[tuple[int, int]]], float],
    points: list[tuple[int, int]],
    times: int = 1000,
) -> tuple[str, float]:
    print(f"{lang} implementation: ", end="", flush=True)
    time = timeit(lambda: func(points), number=times) / times
    print(f"{time:.6f} seconds")
    return lang, time


def calculate_distance(coords: list[tuple[int, int]]) -> float:
    total_distance = 0.0
    for i in range(len(coords) - 1):
        x1, y1 = coords[i]
        x2, y2 = coords[i + 1]
        total_distance += math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)
    return total_distance


def main():
    points = generate_points(10_000)
    print(f"Benchmarking with {len(points)} points\n")

    tests = [
        ("Python", calculate_distance),
        ("C", distance_c.calculate_distance),
        ("Rust", distance_rs.calculate_distance),
        ("Nim", distance_nim.calculateDistance),
    ]

    results = [benchmark_distance_function(lang, func, points) for lang, func in tests]

    with open("results.csv", "w") as f:
        f.write("Language,Time\n")
        for lang, time in results:
            f.write(f"{lang},{time}\n")


if __name__ == "__main__":
    main()
