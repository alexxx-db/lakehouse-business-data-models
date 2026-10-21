"""Domain Taxonomy Builder endpoints (`/api/taxonomy/*`).

Drafting is asynchronous: POST returns a draft id at once and the work runs as
background tasks in this process; the UI polls GET /drafts/{id}. Drafts are
scoped to the calling user (``Dependencies.UserIdentity``, the same identity
as per-user preferences) and kept in memory only.

Gating, checked before anything is created:
- every route answers 404 when the feature is not installed
  (``require_taxonomy_installed``); the router stays mounted so the OpenAPI
  spec does not change by deployment;
- the three LLM routes (create draft, retry part, condense) refuse with the
  structured 422 ``config_missing`` when no model service is set, or when the
  service fails its test call (``ensure_model_service_usable``).

Mutators (create / cancel / retry / condense) require BusinessAdminOnly - the
same bar as createBusiness, which is where the wizard ends. GET draft, compile,
and example are read-only (allow-listed in tests/test_app/test_rbac_coverage.py).
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException

from ..._metadata import api_prefix
from ..core import Dependencies
from ..core._features import require_installed
from ..taxonomy.access import MODEL_SERVICE_ACCESS, REFUSED_CHECKS
from ..taxonomy.compile import compile_taxonomy
from ..taxonomy.drafts import DraftStore
from ..taxonomy.example import load_ridgeline_example
from ..taxonomy.llm import TaxonomyLLM, make_taxonomy_llm
from ..taxonomy.models import (
    TaxonomyCompileIn,
    TaxonomyCompileOut,
    TaxonomyCondenseIn,
    TaxonomyDraftCreated,
    TaxonomyDraftOut,
    TaxonomyExampleOut,
    TaxonomyIntake,
)
from ..taxonomy.slots import TAXONOMY_SLOTS
from ._helpers import _get_or_create_agent_config, config_missing_error, require_config

NOT_INSTALLED_DETAIL = "Domain Taxonomy Builder is not installed"

require_taxonomy_installed = require_installed("taxonomy_builder_enabled", NOT_INSTALLED_DETAIL)


router = APIRouter(prefix=api_prefix, dependencies=[Depends(require_taxonomy_installed)])
_STORE = DraftStore()

def get_draft_store() -> DraftStore:
    return _STORE


@dataclass(frozen=True)
class TaxonomyLLMSettings:
    model_service: str
    max_concurrency: int


def read_taxonomy_llm_settings(session: Dependencies.Session, config: Dependencies.Config) -> TaxonomyLLMSettings:
    """The stored settings, from the AgentConfig singleton. Plain ``def``:
    FastAPI runs it in its threadpool, so the DB read never blocks the loop."""
    cfg = _get_or_create_agent_config(session, config)
    return TaxonomyLLMSettings((cfg.taxonomy_model_service or "").strip(), cfg.taxonomy_llm_max_concurrency)


def get_taxonomy_llm_settings(session: Dependencies.Session, config: Dependencies.Config) -> TaxonomyLLMSettings:
    """``read_taxonomy_llm_settings``, or 422 ``config_missing`` when no model
    service is set."""
    require_config(session, config, {"taxonomy_llm"}, mode="raise")
    return read_taxonomy_llm_settings(session, config)


LLMSettings = Annotated[TaxonomyLLMSettings, Depends(get_taxonomy_llm_settings)]


def get_taxonomy_llm(settings: LLMSettings) -> TaxonomyLLM:
    return make_taxonomy_llm(settings.model_service)


Store = Annotated[DraftStore, Depends(get_draft_store)]
LLM = Annotated[TaxonomyLLM, Depends(get_taxonomy_llm)]


async def ensure_model_service_usable(llm: TaxonomyLLM) -> bool:
    """Probe the service unless it passed recently in this process. ``denied``,
    ``not_found`` and ``error`` refuse with 422 before any draft exists.
    Returns False when the probe was ``busy``: the draft is still created, with
    the part reported busy (the client counts down and retries, which probes
    again)."""
    if MODEL_SERVICE_ACCESS.is_cached(llm.model_service):
        return True
    check = await MODEL_SERVICE_ACCESS.probe(llm, TAXONOMY_SLOTS)
    if check.status in REFUSED_CHECKS:
        raise config_missing_error("taxonomy_llm", check.message)
    return check.status != "busy"


def _get_or_404(store: DraftStore, draft_id: str, owner: str) -> TaxonomyDraftOut:
    out = store.get(draft_id, owner)
    if out is None:
        raise HTTPException(status_code=404, detail="Draft not found (it may have expired or the app restarted)")
    return out


async def require_draft_part(draft_id: str, part: str, store: Store, owner: Dependencies.UserIdentity) -> None:
    """404 for a missing draft, 400 for an unknown part. A dependency listed
    before the LLM settings, so these answer before the 422 config check and
    before any test call. ``async``: the store is touched on the event loop
    only."""
    if part not in _get_or_404(store, draft_id, owner).parts:
        raise HTTPException(status_code=400, detail=f"Unknown draft part '{part}'")


@router.post("/taxonomy/drafts", response_model=TaxonomyDraftCreated, operation_id="createTaxonomyDraft")
async def create_taxonomy_draft(
    data: TaxonomyIntake, store: Store, owner: Dependencies.UserIdentity,
    _role: Dependencies.BusinessAdminOnly, settings: LLMSettings, llm: LLM,
):
    usable = await ensure_model_service_usable(llm)
    draft_id = store.create(owner, data, llm, capacity=settings.max_concurrency, busy=not usable)
    return TaxonomyDraftCreated(draft_id=draft_id)


@router.get("/taxonomy/drafts/{draft_id}", response_model=TaxonomyDraftOut, operation_id="getTaxonomyDraft")
async def get_taxonomy_draft(draft_id: str, store: Store, owner: Dependencies.UserIdentity):
    return _get_or_404(store, draft_id, owner)


@router.post("/taxonomy/drafts/{draft_id}/cancel", response_model=TaxonomyDraftOut, operation_id="cancelTaxonomyDraft")
async def cancel_taxonomy_draft(
    draft_id: str, store: Store, owner: Dependencies.UserIdentity, _role: Dependencies.BusinessAdminOnly,
):
    if not store.cancel(draft_id, owner):
        raise HTTPException(status_code=404, detail="Draft not found")
    return _get_or_404(store, draft_id, owner)


@router.post(
    "/taxonomy/drafts/{draft_id}/parts/{part}/retry",
    response_model=TaxonomyDraftOut,
    operation_id="retryTaxonomyDraftPart",
)
async def retry_taxonomy_draft_part(
    draft_id: str, part: str, store: Store, owner: Dependencies.UserIdentity,
    _role: Dependencies.BusinessAdminOnly, _exists: Annotated[None, Depends(require_draft_part)],
    settings: LLMSettings, llm: LLM,
):
    usable = await ensure_model_service_usable(llm)
    result = store.retry_part(draft_id, owner, part, llm, capacity=settings.max_concurrency, busy=not usable)
    if result == "not_found":
        raise HTTPException(status_code=404, detail="Draft not found")
    if result == "bad_part":
        raise HTTPException(status_code=400, detail=f"Unknown draft part '{part}'")
    if result == "needs_tree":
        raise HTTPException(status_code=409, detail="Retry the domains first")
    if result == "in_progress":
        raise HTTPException(status_code=409, detail="That part is still drafting")
    if result == "not_retryable":
        raise HTTPException(status_code=409, detail="That part already finished; edit it instead")
    return _get_or_404(store, draft_id, owner)


@router.post("/taxonomy/condense", response_model=TaxonomyDraftCreated, operation_id="condenseTaxonomy")
async def condense_taxonomy(
    data: TaxonomyCondenseIn, store: Store, owner: Dependencies.UserIdentity,
    _role: Dependencies.BusinessAdminOnly, settings: LLMSettings, llm: LLM,
):
    usable = await ensure_model_service_usable(llm)
    draft_id = store.create_condense(owner, data, llm, capacity=settings.max_concurrency, busy=not usable)
    return TaxonomyDraftCreated(draft_id=draft_id)


@router.post("/taxonomy/compile", response_model=TaxonomyCompileOut, operation_id="compileTaxonomy")
def compile_taxonomy_route(data: TaxonomyCompileIn):
    return compile_taxonomy(data)


@router.get("/taxonomy/example", response_model=TaxonomyExampleOut, operation_id="getTaxonomyExample")
def get_taxonomy_example():
    return load_ridgeline_example()
