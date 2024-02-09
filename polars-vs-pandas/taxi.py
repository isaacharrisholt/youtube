import time

import pandas as pd
import polars as pl
from bench import bench
from constants import NYC_TAXI_TRIP_DATA

"""
LOADING DATA
"""


def polars_load() -> int:
    start = time.perf_counter()
    df = pl.read_parquet(NYC_TAXI_TRIP_DATA)
    end = time.perf_counter()
    del df

    return int((end - start) * 1000)


def pandas_load() -> int:
    start = time.perf_counter()
    df = pd.read_parquet(NYC_TAXI_TRIP_DATA)
    end = time.perf_counter()
    del df

    return int((end - start) * 1000)


def benchmark_data_load() -> None:
    print("========== BENCHMARKING DATA LOAD ==========")
    bench("Polars", polars_load)
    print()
    bench("Pandas", pandas_load)
    print("============================================\n\n")
