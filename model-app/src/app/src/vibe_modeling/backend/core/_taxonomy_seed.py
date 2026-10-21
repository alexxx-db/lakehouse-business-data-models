"""Lifespan: seed the Domain Taxonomy Builder model service on existing installs.

``_get_or_create_agent_config`` seeds ``AgentConfig.taxonomy_model_service``
from the install default when it creates the row. An install that already
has a row (an upgrade, or enabling the feature later) never reaches that
path, so boot runs one atomic UPDATE that fills the column only while it is
still empty. A value saved in Settings is non-empty and is never touched.

No-op when the feature is not installed or has no install default. Runs at
boot, not on read, keeping the rule that reads never update the singleton
row. Best-effort: a failure logs and the app still boots.

After the seed, boot starts one background test call of the stored model
service (``start_boot_probe``), so ``ready`` reflects real access before the
first visitor sees the landing card.
"""

from __future__ import annotations

from contextlib import asynccontextmanager
from typing import AsyncGenerator

from fastapi import FastAPI
from sqlalchemy import or_, select, update
from sqlalchemy.engine import Engine
from sqlmodel import col

from ..db_models import AgentConfig
from ..taxonomy.access import MODEL_SERVICE_ACCESS
from ..taxonomy.llm import make_taxonomy_llm
from ..taxonomy.slots import TAXONOMY_SLOTS
from ._base import LifespanDependency
from ._config import AppConfig, logger


def seed_taxonomy_model_service(engine: Engine, config: AppConfig) -> int:
    """Fill an empty ``taxonomy_model_service`` from the install default.
    Returns the number of rows updated."""
    service = config.taxonomy_install_default_model_service
    if not service:
        return 0
    stmt = (
        update(AgentConfig)
        .where(or_(col(AgentConfig.taxonomy_model_service) == "", col(AgentConfig.taxonomy_model_service).is_(None)))
        .values(taxonomy_model_service=service)
    )
    with engine.begin() as conn:
        return conn.execute(stmt).rowcount or 0


def start_boot_probe(engine: Engine, config: AppConfig) -> bool:
    """Start one background probe of the stored model service (fire-and-forget,
    through the shared slots). No-op when not installed or nothing is set."""
    if not config.taxonomy_builder_enabled:
        return False
    with engine.connect() as conn:
        row = conn.execute(
            select(col(AgentConfig.taxonomy_model_service)).limit(1)
        ).first()
    service = ((row[0] if row else "") or "").strip()
    if not service:
        return False
    return MODEL_SERVICE_ACCESS.start_background_probe(make_taxonomy_llm(service), TAXONOMY_SLOTS)


class _TaxonomySeedDependency(LifespanDependency):
    @asynccontextmanager
    async def lifespan(self, app: FastAPI) -> AsyncGenerator[None, None]:
        try:
            n = seed_taxonomy_model_service(app.state.engine, app.state.config)
            if n:
                logger.info("Domain Taxonomy Builder: seeded the model service from the install default")
        except Exception:
            logger.exception("Domain Taxonomy Builder: seeding the model service failed; the app will still boot")
        try:
            start_boot_probe(app.state.engine, app.state.config)
        except Exception:
            logger.exception("Domain Taxonomy Builder: the boot test call could not start; the app will still boot")
        yield

    @staticmethod
    def __call__() -> None:
        return None
