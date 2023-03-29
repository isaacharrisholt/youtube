from typing import Any


class MongoStorage:
    def __init__(self, username: str, password: str):
        self.username = username
        self.password = password
        self.conn = self.connect()

    def connect(self) -> Any:
        print(f"mongo: connect {self.username=} {self.password=}")
        return {"this": "is", "a": "mongo", "connection": "object"}

    def put(self, key: str, value: Any) -> None:
        conn = self.conn
        print(f"mongo: put {key}={value}, {conn=}")

    def get(self, key: str) -> Any:
        conn = self.conn
        print(f"mongo: get {key}, {conn=}")
        return {"name": "Isaac", "age": 21}
