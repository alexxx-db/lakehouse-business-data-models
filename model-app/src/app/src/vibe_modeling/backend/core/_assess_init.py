"""Lifespan: seed the assessment reader and re-sync the assessment job on every boot.

Runs after the Lakebase lifespan (schema reconciled). Returns at once when the
feature is not installed (``AppConfig.assessment_enabled``). Seeds the reader
from ``AppConfig.assess_reader_sp`` (a new row, or an existing row whose
reader is empty), then, when a reader is set, runs the same
``sync_assessment_job`` Settings Save runs, so a redeploy points the job at
this version's notebook. A failed sync is recorded on the row (the readiness
rule reports it); it never crashes the boot.
"""
from __future__ import annotations

from contextlib import asynccontextmanager
from typing import AsyncGenerator

from fastapi import FastAPI
from sqlmodel import Session

from ... import __version__ as APP_VERSION
from ._base import LifespanDependency
from ._config import logger


def run_assess_boot_sync(engine, ws, config, app_version: str) -> None:
    """Seed, then sync and commit (or record the failure). Skipped without a reader."""
    from ..assessment.config_service import get_or_create_assess_config, seed_reader_from_install, sync_and_commit
    from ._catalogs import resolve_metamodel_catalog

    with Session(bind=engine, expire_on_commit=False) as session:
        cfg = get_or_create_assess_config(session, config)
        seed_reader_from_install(session, config)
        session.commit()
        session.refresh(cfg)
        if not cfg.reader_application_id:
            logger.info("Assessment job sync skipped: no reader service principal is configured")
            return
        result = sync_and_commit(session, ws, cfg, deployment_catalog=resolve_metamodel_catalog(session, config),
                                 app_version=app_version)
        if result.ok:
            logger.info("Assessment job synced: job_id=%s folder=%s", result.job_id, result.workspace_path)


class _AssessInitDependency(LifespanDependency):
    @asynccontextmanager
    async def lifespan(self, app: FastAPI) -> AsyncGenerator[None, None]:
        config = app.state.config
        if config.assessment_enabled:
            try:
                run_assess_boot_sync(app.state.engine, app.state.workspace_client, config, APP_VERSION)
            except Exception:
                logger.exception("Assessment boot sync failed; the app will still boot")
        yield

    @staticmethod
    def __call__() -> None:
        return None
