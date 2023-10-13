import random
import uuid

from typing import Self


class StripePaymentProcessor:
    def __init__(self: Self, api_key: str):
        self.api_key = api_key

    def initiate_payment(self: Self, amount: int) -> str:
        payment_id = str(uuid.uuid4())
        print(f"Initiating payment with ID: {payment_id}")
        return payment_id

    def verify_payment(self: Self, payment_id: str) -> bool:
        print(f"Verifying payment with ID: {payment_id}")
        return True

    def check_payment_status(self: Self, payment_id: str) -> bool:
        print(f"Checking payment status for ID: {payment_id}")
        return random.randint(1, 10) < 3  # 20% chance of returning True


class StripePaymentProcessorFacade:
    def __init__(self: Self, api_key: str):
        self.api_key = api_key
        self.stripe_processor = StripePaymentProcessor(api_key)

    def pay(self: Self, amount: int) -> bool:
        payment_id = self.stripe_processor.initiate_payment(amount)
        if not self.stripe_processor.verify_payment(payment_id):
            return False

        count = 0
        while count < 10:
            if self.stripe_processor.check_payment_status(payment_id):
                return True
            count += 1
        return False
