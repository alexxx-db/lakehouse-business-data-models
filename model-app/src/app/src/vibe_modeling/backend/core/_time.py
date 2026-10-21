"""Timezone helper for datetimes read back from Lakebase.

The datetime columns are naive ``TIMESTAMP``s that hold UTC, so a value read back
has no tzinfo. ``as_utc`` marks it UTC, which lets it be compared with an aware
``datetime.now(timezone.utc)`` and serialized with an offset the browser parses
correctly. An aware value is converted to UTC.
"""
from __future__ import annotations

from datetime import datetime, timezone
from typing import overload


@overload
def as_utc(value: datetime) -> datetime: ...
@overload
def as_utc(value: None) -> None: ...
def as_utc(value: datetime | None) -> datetime | None:
    if value is None:
        return None
    return value.replace(tzinfo=timezone.utc) if value.tzinfo is None else value.astimezone(timezone.utc)
