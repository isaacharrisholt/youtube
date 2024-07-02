import uuid

from typing import Self


class Database:
    def __init__(self: Self, name: str):
        self.name = name

    def insert(self: Self, data: dict) -> str:
        print(f"Inserting a record in database {self.name} with data: {data}")
        return str(uuid.uuid4())

    def update(self: Self, record_id: str, data: dict) -> None:
        print(f"Updating a record in database {self.name} with data: {data}")

    def select(self: Self, record_id: str) -> dict:
        print(f"Retrieving a record from database {self.name} with ID: {record_id}")
        return {"id": record_id, "data": {"name": "John"}}
