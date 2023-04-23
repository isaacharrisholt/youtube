import string

import pytest
from hypothesis import given, strategies as st

from mail_service import create_mailbox


@given(st.text(alphabet=string.ascii_lowercase, min_size=1, max_size=5))
def test_create_mailbox(s):
    mailbox = create_mailbox(s)
    assert mailbox.email_address == f"{s}@coolemailservice.com"
    assert mailbox.emails == []


@given(st.text(alphabet=string.ascii_lowercase, min_size=6))
def test_create_mailbox_too_long(s):
    with pytest.raises(ValueError):
        create_mailbox(s)


@given(
    st.text(
        alphabet=st.characters(blacklist_characters=string.ascii_letters),
        min_size=1,
        max_size=5,
    ),
)
def test_create_mailbox_invalid_characters(s):
    with pytest.raises(ValueError):
        create_mailbox(s)


def test_create_mailbox_empty_string():
    with pytest.raises(ValueError):
        create_mailbox("")
