"""Lifespan: shut down the Domain Taxonomy Builder's LLM thread pool on exit.

``taxonomy/slots.TAXONOMY_EXECUTOR`` is a module-level pool. At app shutdown
queued calls are cancelled and running ones are not waited for (each is
bounded by the LLM client's HTTP timeout), so a stuck gateway call never
holds up the process exit.
"""

from __future__ import annotations

from contextlib import asynccontextmanager
from typing import AsyncGenerator

from fastapi import FastAPI

from ..taxonomy import slots
from ._base import LifespanDependency


def shutdown_taxonomy_executor() -> None:
    slots.TAXONOMY_EXECUTOR.shutdown(wait=False, cancel_futures=True)


class _TaxonomyExecutorDependency(LifespanDependency):
    @asynccontextmanager
    async def lifespan(self, app: FastAPI) -> AsyncGenerator[None, None]:
        try:
            yield
        finally:
            shutdown_taxonomy_executor()

    @staticmethod
    def __call__() -> None:
        return None
