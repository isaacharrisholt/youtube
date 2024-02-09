from pathlib import Path

import taxi
from constants import NYC_TAXI_TRIP_DATA, NYC_TAXI_TRIP_DATA_URL

if __name__ == "__main__":
    Path("./data").mkdir(exist_ok=True)
    if not Path(NYC_TAXI_TRIP_DATA).exists():
        print(
            f"NYC taxi trip data not found. Please download it from: {NYC_TAXI_TRIP_DATA_URL}"
        )

    taxi.benchmark_data_load()
