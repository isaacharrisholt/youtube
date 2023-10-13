from facade import OrderProcessor

if __name__ == "__main__":
    order_data = {"id": "ORD_123", "amount": 125}
    order_processor = OrderProcessor()
    order_processor.place_order(order_data)
