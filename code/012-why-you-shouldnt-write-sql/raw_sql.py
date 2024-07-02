import contextlib
import sqlite3


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
    cursor = conn.execute(
        """
        INSERT INTO user (name) VALUES (?) RETURNING *
        """,
        (name,),
    )
    return cursor.fetchone()


def add_order(
    conn: sqlite3.Connection,
    user_id: int,
    description: str,
    payment_status: bool,
) -> tuple[int, int, str, bool]:
    cursor = conn.execute(
        """
        INSERT INTO 'order' (user_id, description, payment_status)
        VALUES (?, ?, ?) RETURNING *
        """,
        (user_id, description, payment_status),
    )
    return cursor.fetchone()


def main():
    with contextlib.closing(get_connection()) as conn:
        setup_tables(conn)
        user = add_user(conn, "John")
        print(user)
        add_user(conn, "Jane")

        add_order(conn, user[0], "A book", True)

        print(conn.execute(
            """
            SELECT * FROM "order"
            INNER JOIN user ON "order".user_id = user.id
            """
        ).fetchall())


if __name__ == "__main__":
    main()
