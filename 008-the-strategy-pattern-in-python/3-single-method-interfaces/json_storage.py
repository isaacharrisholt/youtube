from typing import Any


class JsonStorage:
    def __init__(self, filename: str):
        self.filename = filename

    def put(self, key: str, value: Any) -> None:
        filename = self.filename
        print(f"json: put {key}={value}, {filename=}")

    def get(self, key: str) -> Any:
        filename = self.filename
        print(f"json: get {key}, {filename=}")
        return {"name": "Isaac", "age": 21}
