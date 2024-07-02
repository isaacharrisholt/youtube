import contextlib
import sqlite3

from pypika import Query, Table, Order

USERS = Table("user")
ORDERS = Table("order")


def get_connection():
    return sqlite3.connect(":memory:")  # In-memory database


def setup_tables(conn: sqlite3.Connection) -> None:
    conn.execute(
        """
        CREATE TABLE user (
            id INTEGER PRIMARY KEY,
            name VARCHAR(50)
        )
        """
    )
    conn.execute(
        """
        CREATE TABLE "order" (
            id INTEGER PRIMARY KEY,
            user_id INTEGER REFERENCES user(id),
            description VARCHAR(50),
            payment_status BOOLEAN
        )
        """
    )


def add_user(conn: sqlite3.Connection, name: str) -> tuple[int, str]:
    conn.execute(USERS.insert(name).columns(USERS.name).get_sql())
    cursor = conn.execute(
        Query.from_(USERS)
        .select(USERS.id, USERS.name)
        .orderby(USERS.id, order=Order.desc)
        .limit(1)
        .get_sql()
    )
    return cursor.fetchone()


def add_order(
    conn: sqlite3.Connection,
    user_id: int,
    description: str,
    payment_status: bool,
) -> tuple[int, int, str, bool]:
    conn.execute(
        ORDERS.insert(user_id, description, payment_status)
        .columns(ORDERS.user_id, ORDERS.description, ORDERS.payment_status)
        .get_sql()
    )
    cursor = conn.execute(
        Query.from_(ORDERS)
        .select(ORDERS.id, ORDERS.user_id, ORDERS.description, ORDERS.payment_status)
        .orderby(ORDERS.id, order=Order.desc)
        .limit(1)
        .get_sql()
    )
    return cursor.fetchone()


def main():
    with contextlib.closing(get_connection()) as conn:
        setup_tables(conn)
        user = add_user(conn, "John")
        print(user)
        add_user(conn, "Jane")

        add_order(conn, user[0], "A book", True)

        stmt = (
            Query.from_(ORDERS).select("*").join(USERS).on(ORDERS.user_id == USERS.id)
        )
        print(conn.execute(stmt.get_sql()).fetchall())


if __name__ == "__main__":
    main()
