from pprint import pprint

import polars as pl
from constants import NYC_TAXI_TRIP_DATA

if __name__ == "__main__":
    df = pl.read_parquet(NYC_TAXI_TRIP_DATA)
    pprint(df.schema)
    print(df.describe().select("statistic", "trip_distance"))
