import time

import pandas as pd
import polars as pl
from bench import bench
from constants import NYC_TAXI_TRIP_DATA


def read_polars() -> pl.DataFrame:
    return pl.read_parquet(NYC_TAXI_TRIP_DATA)


def read_pandas() -> pd.DataFrame:
    return pd.read_parquet(NYC_TAXI_TRIP_DATA)


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


"""
GROUP BY OPERATIONS
"""


def polars_vendor_groupby_eager() -> int:
    df = read_polars()
    start = time.perf_counter()
    df.groupby("VendorID").agg(
        [
            pl.col("trip_distance").mean().alias("avg_distance"),
            pl.col("trip_distance").sum().alias("total_distance"),
        ]
    )
    end = time.perf_counter()
    del df

    return int((end - start) * 1000)


def polars_vendor_groupby_lazy() -> int:
    df = read_polars()
    start = time.perf_counter()
    df.lazy().groupby("VendorID").agg(
        [
            pl.col("trip_distance").mean().alias("avg_distance"),
            pl.col("trip_distance").sum().alias("total_distance"),
        ]
    ).collect()
    end = time.perf_counter()
    del df

    return int((end - start) * 1000)


def pandas_vendor_groupby() -> int:
    df = read_pandas()
    start = time.perf_counter()
    df.groupby("VendorID").agg({"trip_distance": ["mean", "sum"]})
    end = time.perf_counter()
    del df

    return int((end - start) * 1000)


def benchmark_vendor_groupby() -> None:
    print("========== BENCHMARKING VENDOR GROUP BY ==========")
    bench("Polars eager", polars_vendor_groupby_eager)
    print()
    bench("Polars lazy", polars_vendor_groupby_lazy)
    print()
    bench("Pandas", pandas_vendor_groupby)
    print("==================================================\n\n")


"""
CHAINED OPERATIONS
"""


def polars_chained_eager() -> int:
    df = read_polars()
    start = time.perf_counter()
    (
        df.filter(pl.col("trip_distance") > 3)
        .with_columns(
            (pl.col("fare_amount") + pl.col("tip_amount")).alias("total_fare_with_tips")
        )
        .groupby("PULocationID")
        .agg(
            pl.mean("total_fare_with_tips").alias(
                "average_total_fare"
            )  # Calculate average total fare
        )
        .sort("average_total_fare", descending=True)
        .limit(10)
    )
    end = time.perf_counter()
    del df

    return int((end - start) * 1000)


def polars_chained_lazy() -> int:
    df = read_polars()
    start = time.perf_counter()
    (
        df.lazy()
        .filter(pl.col("trip_distance") > 3)
        .with_columns(
            (pl.col("fare_amount") + pl.col("tip_amount")).alias("total_fare_with_tips")
        )
        .groupby("PULocationID")
        .agg(
            pl.mean("total_fare_with_tips").alias(
                "average_total_fare"
            )  # Calculate average total fare
        )
        .sort("average_total_fare", descending=True)
        .limit(10)
        .collect()
    )
    end = time.perf_counter()
    del df

    return int((end - start) * 1000)


def pandas_chained() -> int:
    df = read_pandas()
    start = time.perf_counter()
    (
        df[df["trip_distance"] > 1]
        .assign(total_fare_with_tips=lambda x: x["fare_amount"] + x["tip_amount"])
        .groupby("PULocationID", as_index=False)
        .agg(average_total_fare=("total_fare_with_tips", "mean"))
        .sort_values("average_total_fare", ascending=False)
        .head(10)
    )
    end = time.perf_counter()
    del df

    return int((end - start) * 1000)


def benchmark_chained_operations() -> None:
    print("========== BENCHMARKING CHAINED OPERATIONS ==========")
    bench("Polars eager", polars_chained_eager)
    print()
    bench("Polars lazy", polars_chained_lazy)
    print()
    bench("Pandas", pandas_chained)
    print("=====================================================\n\n")
