import json
import random

from hypothesis import given, strategies as st


@st.composite
def json_serialisable(draw):
    strategies = [
        st.none(),
        st.booleans(),
        st.integers(),
        st.floats(allow_nan=False),
        st.text(),
        st.lists(json_serialisable(), min_size=1),
        st.dictionaries(st.text(), json_serialisable(), min_size=1),
    ]
    return draw(random.choice(strategies))


@given(json_serialisable())
def test_json_roundtrip(s):
    print(s)
    assert s == json.loads(json.dumps(s))
