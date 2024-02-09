import time

import pandas as pd
import polars as pl
from bench import bench
from constants import IMDB_REVIEWS_DATA


def read_polars() -> pl.DataFrame:
    return pl.read_csv(IMDB_REVIEWS_DATA)


def read_pandas() -> pd.DataFrame:
    return pd.read_csv(IMDB_REVIEWS_DATA)


"""
STRING OPERATIONS
"""


def polars_string_operations_eager() -> int:
    df = read_polars()
    start = time.perf_counter()
    (
        df.with_columns(
            [
                pl.col("review")
                .str.to_lowercase()
                .str.replace_all("<.*?>", "")
                .str.replace_all(r"[^\w\s]", "")
                .alias("review_clean"),
            ]
        )
        .with_columns(
            [
                pl.col("review_clean").str.split(" ").alias("tokens"),
            ]
        )
        .with_columns(
            [
                pl.col("tokens").list.len().alias("word_count"),
            ]
        )
    )
    end = time.perf_counter()
    del df

    return int((end - start) * 1000)


def polars_string_operations_lazy() -> int:
    df = read_polars()
    start = time.perf_counter()
    (
        df.lazy()
        .with_columns(
            [
                pl.col("review")
                .str.to_lowercase()
                .str.replace_all("<.*?>", "")
                .str.replace_all(r"[^\w\s]", "")
                .alias("review_clean"),
            ]
        )
        .with_columns(
            [
                pl.col("review_clean").str.split(" ").alias("tokens"),
            ]
        )
        .with_columns(
            [
                pl.col("tokens").list.len().alias("word_count"),
            ]
        )
        .collect()
    )
    end = time.perf_counter()
    del df

    return int((end - start) * 1000)


def pandas_string_operations() -> int:
    df = read_pandas()
    start = time.perf_counter()
    (
        df.assign(
            review_clean=lambda x: x["review"]
            .str.lower()
            .replace("<.*?>", "", regex=True)
            .replace(r"[^\w\s]", "", regex=True),
            tokens=lambda x: x["review_clean"].str.split(),
            # Yes, this gets the length of the list
            word_count=lambda x: x["tokens"].str.len(),
        )
    )
    end = time.perf_counter()
    del df

    return int((end - start) * 1000)


def benchmark_string_operations() -> None:
    print("========== BENCHMARKING STRING OPERATIONS ==========")
    bench("Polars eager", polars_string_operations_eager)
    print()
    bench("Polars lazy", polars_string_operations_lazy)
    print()
    bench("Pandas", pandas_string_operations)
    print("====================================================\n\n")
