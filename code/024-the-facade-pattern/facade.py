from typing import Self

from database import Database
from payment import PaymentProcessorFacade


class OrderProcessor:
    def __init__(self: Self):
        self._payment_processor = PaymentProcessorFacade(
            "API_KEY"
        )  # Get API key from config/env
        self._database = Database("order")

    def place_order(self: Self, order_data: dict) -> None:
        # Insert order into database
        self._database.insert(order_data)

        # Process payment
        paid = self._payment_processor.pay(order_data["amount"])

        if not paid:
            raise Exception(f"Payment for order {order_data['id']} was not successful")

        # Update order status
        self._database.update(order_data["id"], {"status": "completed"})
