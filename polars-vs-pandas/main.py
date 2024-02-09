from pathlib import Path

import imdb
import taxi
from constants import (
    IMDB_REVIEWS_DATA,
    IMDB_REVIEWS_DATA_URL,
    NYC_TAXI_TRIP_DATA,
    NYC_TAXI_TRIP_DATA_URL,
)

if __name__ == "__main__":
    Path("./data").mkdir(exist_ok=True)
    if not Path(NYC_TAXI_TRIP_DATA).exists():
        print(
            f"NYC taxi trip data not found. Please download it from: {NYC_TAXI_TRIP_DATA_URL}"
        )
    if not Path(IMDB_REVIEWS_DATA).exists():
        print(
            f"IMDB reviews data not found. Please download it from: {IMDB_REVIEWS_DATA_URL}"
        )

    # Taxi benchmarks
    taxi.benchmark_data_load()
    taxi.benchmark_vendor_groupby()
    taxi.benchmark_chained_operations()

    # IMDB reviews benchmark
    imdb.benchmark_string_operations()
