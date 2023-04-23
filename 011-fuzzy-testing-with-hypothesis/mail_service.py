import re
from datetime import datetime

from pydantic import BaseModel, Field, constr

USERNAME_VALIDATION = re.compile(r"^[a-z]+$")
DATABASE = []


class Mailbox(BaseModel):
    email_address: constr(max_length=26)
    created_at: datetime = Field(default_factory=datetime.now)
    emails: list = Field(default_factory=list)


def create_mailbox(username: str) -> Mailbox:
    username = username.lower()
    if len(username) > 5:
        raise ValueError("Username must be 5 characters or less")

    if not USERNAME_VALIDATION.match(username):
        raise ValueError("Username must contain only letters and numbers")

    new_mailbox = Mailbox(email_address=f"{username}@coolemailservice.com")
    DATABASE.append(new_mailbox)
    return new_mailbox
