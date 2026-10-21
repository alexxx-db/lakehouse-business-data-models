"""``core/_time.as_utc``: naive Lakebase datetimes are UTC; aware ones are converted."""
from datetime import datetime, timedelta, timezone

from vibe_modeling.backend.core._time import as_utc


def test_as_utc():
    assert as_utc(None) is None
    assert as_utc(datetime(2026, 10, 19, 12, 0)) == datetime(2026, 10, 19, 12, 0, tzinfo=timezone.utc)
    cest = datetime(2026, 10, 19, 14, 0, tzinfo=timezone(timedelta(hours=2)))
    out = as_utc(cest)
    assert out.utcoffset() == timedelta(0) and out.hour == 12
