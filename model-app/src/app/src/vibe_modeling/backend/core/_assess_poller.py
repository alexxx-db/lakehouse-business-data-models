"""Lifespan: start the headless-assessment poller (resumes non-terminal runs on boot).

Returns at once when the feature is not installed (``AppConfig.assessment_enabled``).
"""
from __future__ import annotations

import asyncio
from contextlib import asynccontextmanager, suppress
from typing import AsyncGenerator

from fastapi import FastAPI
from sqlmodel import Session

from ._base import LifespanDependency
from ._config import logger


class _AssessPollerDependency(LifespanDependency):
    @asynccontextmanager
    async def lifespan(self, app: FastAPI) -> AsyncGenerator[None, None]:
        if not app.state.config.assessment_enabled:
            yield
            return
        task: asyncio.Task | None = None
        try:
            from ..assessment.poller import AssessPoller

            engine = app.state.engine
            poller = AssessPoller(app.state.workspace_client, lambda: Session(bind=engine, expire_on_commit=False))
            task = asyncio.create_task(poller.run_forever())
            logger.info("AssessPoller started")
        except Exception:
            logger.exception("AssessPoller failed to start; assessment status will not update")
        yield
        if task is not None:
            task.cancel()
            with suppress(asyncio.CancelledError):
                await task
            logger.info("AssessPoller stopped")

    @staticmethod
    def __call__() -> None:
        return None
