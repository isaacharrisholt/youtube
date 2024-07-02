from typing import Any


class S3Storage:
    def __init__(self, credentials_path: str):
        self.credentials_path = credentials_path
        self.conn = self.connect()

    def connect(self) -> Any:
        print(f"s3: connect {self.credentials_path=}")
        return {"this": "is", "a": "s3", "connection": "object"}

    def put(self, key: str, value: Any) -> None:
        conn = self.conn
        print(f"s3: put {key}={value}, {conn=}")

    def get(self, key: str) -> Any:
        conn = self.conn
        print(f"s3: get {key}, {conn=}")
        return {"name": "Isaac", "age": 21}
