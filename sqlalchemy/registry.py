from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.orm import registry
from sqlalchemy.orm import declarative_base

mapper_registry = registry()

metadata_obj = mapper_registry.metadata

Base = mapper_registry.generate_base()

# Base = declarative_base()


from sqlalchemy.orm import relationship


class User(Base):
    __tablename__ = "user_account"

    id = Column(Integer, primary_key=True)
    name = Column(String(30))
    fullname = Column(String)

    addresses = relationship("Address", back_populates="user")

    def __repr__(self):
        return f"User(id={self.id!r}, name={self.name!r}, fullname={self.fullname!r})"


class Address(Base):
    __tablename__ = "address"

    id = Column(Integer, primary_key=True)
    email_address = Column(String, nullable=False)
    user_id = Column(Integer, ForeignKey("user_account.id"))

    user = relationship("User", back_populates="addresses")

    def __repr__(self):
        return f"Address(id={self.id!r}, email_address={self.email_address!r})"
