from sqlalchemy import (
    Boolean,
    Column,
    ForeignKey,
    Integer,
    String,
    create_engine,
    select,
)
from sqlalchemy.orm import declarative_base, Session, Mapped

Base = declarative_base()


class User(Base):
    __tablename__ = "user"

    id: Mapped[int] = Column(Integer, primary_key=True)
    name: Mapped[str] = Column(String(50))

    def __repr__(self):
        return f"User(id={self.id!r}, name={self.name!r})"


class Order(Base):
    __tablename__ = "order"

    id: Mapped[int] = Column(Integer, primary_key=True)
    user_id: Mapped[int] = Column(Integer, ForeignKey(User.id))
    description: Mapped[str] = Column(String(50))
    payment_status: Mapped[bool] = Column(Boolean, index=True)

    def __repr__(self):
        return (
            f"Order(id={self.id!r}, user_id={self.user_id!r}, "
            f"description={self.description!r}, "
            f"payment_status={self.payment_status!r})"
        )


def add_user(session: Session, name: str) -> User:
    user = User(name=name)
    session.add(user)
    # Will update the `user` object with the `id` from the database
    session.commit()
    return user


def add_order(
    session: Session,
    user_id: int,
    description: str,
    payment_status: bool,
) -> Order:
    order = Order(
        user_id=user_id,
        description=description,
        payment_status=payment_status,
    )
    session.add(order)
    session.commit()
    return order


def main():
    engine = create_engine("sqlite:///:memory:")
    Base.metadata.create_all(engine)

    with Session(engine) as session:
        user = add_user(session, "John")
        add_user(session, "Jane")

        add_order(session, user.id, "A book", True)

        stmt = select(User, Order).join(Order)
        print(session.execute(stmt).all())


if __name__ == "__main__":
    main()
