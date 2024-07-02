from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()


class ItemAttributes(BaseModel):
    price: float
    quantity: int


class Item(BaseModel):
    id: int
    name: str
    attributes: ItemAttributes


db: dict[int, Item] = {
    1: Item(id=1, name='Foo', attributes=ItemAttributes(price=1.0, quantity=10)),
    2: Item(id=2, name='Bar', attributes=ItemAttributes(price=2.0, quantity=20)),
    3: Item(id=3, name='Baz', attributes=ItemAttributes(price=3.0, quantity=30)),
}


@app.get('/items/{item_id}')
async def get_item(item_id: int) -> Item:
    try:
        return db[item_id]  # Of type Item
    except KeyError:
        raise HTTPException(status_code=404, detail='Item not found')
