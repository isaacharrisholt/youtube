import os
from typing import Any

import mongo
import s3


def put(location: str, key: str, value: Any) -> None:
    if location == "s3":
        credentials_file = os.getenv('S3_CREDENTIALS_FILE')
        s3.put(key, value, credentials_file)
    elif location == "mongo":
        username = os.getenv('MONGO_USERNAME')
        password = os.getenv('MONGO_PASSWORD')
        mongo.put(key, value, username, password)
    else:
        raise ValueError(f"Unknown location: {location}")


def get(location: str, key: str) -> Any:
    if location == "s3":
        credentials_file = os.getenv('S3_CREDENTIALS_FILE')
        return s3.get(key, credentials_file)
    elif location == "mongo":
        username = os.getenv('MONGO_USERNAME')
        password = os.getenv('MONGO_PASSWORD')
        return mongo.get(key, username, password)
    else:
        raise ValueError(f"Unknown location: {location}")


def pipeline(location: str, source_key: str) -> str:
    value = get(location, source_key)
    sink_key = f"{source_key}-out"

    # Do some processing on the value...
    value.update({"processed": True})

    put(location, sink_key, value)
    return sink_key


if __name__ == "__main__":
    in_key = "my-pipeline"

    # Ignore me :)
    os.environ['S3_CREDENTIALS_FILE'] = "s3-credentials.json"
    os.environ['MONGO_USERNAME'] = "isaac"
    os.environ['MONGO_PASSWORD'] = "password"

    print("====== s3 ======")
    out_key = pipeline("s3", in_key)
    print(f"out_key: {out_key}")

    print("\n\n====== mongo ======")
    out_key = pipeline("mongo", in_key)
    print(f"out_key: {out_key}")
