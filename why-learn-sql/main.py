import os
import timeit

import faker
import matplotlib.pyplot as plt
import pandas as pd
from cycler import cycler
from sqlalchemy import (
    Boolean,
    Column,
    ForeignKey,
    Integer,
    String,
    create_engine,
)
from sqlalchemy.orm import Session, declarative_base, sessionmaker

Base = declarative_base()
plt.rcParams['axes.prop_cycle'] = cycler('color', plt.get_cmap('tab20').colors)

NUM_REPEATS = 100


class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True)
    name = Column(String(50))


class Order(Base):
    __tablename__ = 'orders'

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('users.id'))
    description = Column(String(50))
    payment_status = Column(Boolean, index=True)


def add_data(session: Session, n_users: int, n_orders: int):
    f = faker.Faker()
    users = [User(name=f.name()) for _ in range(n_users)]
    session.add_all(users)
    session.commit()

    orders = [
        Order(
            user_id=f.random_int(1, n_users),
            description=f.text(50),
            payment_status=f.boolean(),
        )
        for _ in range(n_orders)
    ]
    session.add_all(orders)
    session.commit()


def empty_tables(session: Session):
    session.query(Order).delete()
    session.query(User).delete()
    session.commit()


def setup_db(session: Session):
    Base.metadata.create_all(session.bind)


def teardown_db(session: Session):
    Base.metadata.drop_all(session.bind)


def get_sessionmaker() -> sessionmaker:
    engine = create_engine('mysql+pymysql://user:password@localhost/default')
    return sessionmaker(bind=engine)


def get_users_with_failed_orders_python(session: Session) -> set[User]:
    """Get all users with failed orders using a naive Python implementation."""
    failed_orders = (
        session
        .query(Order)
        .prefix_with('SQL_NO_CACHE')
        .filter(Order.payment_status == False)
        .all()
    )

    users = set()

    for order in failed_orders:
        user = (
            session
            .query(User)
            .prefix_with('SQL_NO_CACHE')
            .filter(User.id == order.user_id)
            .one_or_none()
        )
        users.add(user)

    return users


def get_users_with_failed_orders_sql(session: Session) -> set[User]:
    """Get all users with failed orders using a SQL implementation."""
    return set(
        session
        .query(User)
        .prefix_with('SQL_NO_CACHE')
        .distinct()
        .join(Order)
        .filter(Order.payment_status == False)
        .all()
    )


def run_benchmark(
    session: Session,
    n_users: int,
    n_orders: int,
) -> tuple[float, float]:
    try:
        setup_db(session)
        add_data(session, n_users, n_orders)
        python = timeit.timeit(
            lambda: get_users_with_failed_orders_python(session),
            number=NUM_REPEATS,
        )
        sql = timeit.timeit(
            lambda: get_users_with_failed_orders_sql(session),
            number=NUM_REPEATS,
        )
        return python / NUM_REPEATS * 1000, sql / NUM_REPEATS * 1000
    finally:
        empty_tables(session)
        teardown_db(session)


def save_plot(
    df: pd.DataFrame,
    x: str,
    y: str,
    group: str,
    title: str,
    filename: str,
):
    plt.set_cmap('tab10')
    fig, ax = plt.subplots()
    df = df.set_index(x)
    df.groupby(group)[y].plot(
        title=title,
        ax=ax,
    )
    ax.set_ylabel('Time (ms)')
    ax.legend(title=group)
    fig.savefig(os.path.join('results', filename))


def main():
    Session = get_sessionmaker()

    results = []

    with Session() as session:
        teardown_db(session)
        print('Starting benchmark...\n')
        nums = (10, 100, 1000)
        for n_users in nums:
            for n_orders in nums:
                print(f'n_users: {n_users:,}, n_orders: {n_orders:,}')
                python, sql = run_benchmark(session, n_users, n_orders)
                print(f'Python: {python:.2f}ms, SQL: {sql:.2f}ms\n')
                results.append((n_users, n_orders, python, sql))

    df = pd.DataFrame(
        results,
        columns=['n_users', 'n_orders', 'python', 'sql'],
    )

    df.to_csv('results/results.csv', index=False)

    save_plot(
        df,
        'n_users',
        'python',
        'n_orders',
        'Python query against n_users',
        'python_n_users.png',
    )
    save_plot(
        df,
        'n_orders',
        'python',
        'n_users',
        'Python query against n_orders',
        'python_n_orders.png',
    )
    save_plot(
        df,
        'n_users',
        'sql',
        'n_orders',
        'SQL query against n_users',
        'sql_n_users.png',
    )
    save_plot(
        df,
        'n_orders',
        'sql',
        'n_users',
        'SQL query against n_orders',
        'sql_n_orders.png',
    )


if __name__ == '__main__':
    main()
