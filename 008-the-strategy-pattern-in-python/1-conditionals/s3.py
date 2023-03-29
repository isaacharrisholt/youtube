from typing import Any


def connect(credentials_path: str) -> Any:
    print(f"s3: connect {credentials_path=}")
    return {"this": "is", "a": "s3", "connection": "object"}


def put(key: str, value: Any, credentials_path: str) -> None:
    conn = connect(credentials_path)
    print(f"s3: put {key}={value}, {conn=}")


def get(key: str, credentials_path: str) -> Any:
    conn = connect(credentials_path)
    print(f"s3: get {key}, {conn=}")
    return {"name": "Isaac", "age": 21}


