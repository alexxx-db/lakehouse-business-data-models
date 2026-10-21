"""404 gating for optional, install-time features.

An optional feature keeps its router mounted, so the OpenAPI spec does not
change by deployment, and every gated route answers 404 while the install flag
on ``AppConfig`` is off.
"""

from __future__ import annotations

from typing import Callable

from fastapi import HTTPException

from .dependencies import Dependencies


def require_installed(flag_attr: str, detail: str) -> Callable[..., None]:
    """A route dependency that raises 404 ``detail`` unless ``AppConfig.<flag_attr>`` is true."""

    def _require(config: Dependencies.Config) -> None:
        if not getattr(config, flag_attr):
            raise HTTPException(status_code=404, detail=detail)

    _require.__name__ = f"require_{flag_attr}"
    return _require
