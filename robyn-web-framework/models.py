from sqlalchemy import Column, Integer, String, create_engine
from sqlalchemy.orm import declarative_base, sessionmaker

Base = declarative_base()

engine = create_engine("sqlite+pysqlite:///db.sql", echo=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


class Note(Base):
    __tablename__ = "notes"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    content = Column(String)


if __name__ == "__main__":
    Base.metadata.create_all(bind=engine)
