from typing import Any


def connect(username: str, password: str) -> Any:
    print(f"mongo: connect {username=} {password=}")
    return {"this": "is", "a": "mongo", "connection": "object"}


def put(key: str, value: Any, username: str, password: str) -> None:
    conn = connect(username, password)
    print(f"mongo: put {key}={value}, {conn=}")


def get(key: str, username: str, password: str) -> Any:
    conn = connect(username, password)
    print(f"mongo: get {key}, {conn=}")
    return {"name": "Isaac", "age": 21}
