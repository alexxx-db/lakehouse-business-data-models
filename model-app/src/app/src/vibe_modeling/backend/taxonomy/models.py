"""Pydantic shapes for the Domain Taxonomy Builder (/api/taxonomy/*).

Names carry a ``Taxonomy`` prefix so the generated OpenAPI client has no
collisions with existing models.
"""

from __future__ import annotations

from datetime import datetime
from typing import Literal, Optional

from pydantic import BaseModel, Field

from ..models import BUSINESS_NAME_PATTERN, OrgDivisions
from .slots import DEFAULT_CAPACITY, MAX_CAPACITY, MIN_CAPACITY

SECTION_KEYS: tuple[str, ...] = (
    "company", "channels", "processes", "terminology", "systems_of_record", "regulatory",
)
SECTION_HEADINGS: dict[str, str] = {
    "company": "Company and segments",
    "channels": "Channels and customer touchpoints",
    "processes": "Core business processes",
    "terminology": "Industry terminology",
    "systems_of_record": "Systems of record",
    "regulatory": "Regulatory and compliance",
}
PART_TREE = "tree"
PART_DESCRIPTION = "description"

Provenance = Literal["user", "industry", "confirm"]
Strictness = Literal["strict", "guided"]
# ``busy``: no free LLM slot, or the gateway rate-limited the call. Terminal for
# polling; the client retries the part on its own countdown.
PartStatus = Literal["pending", "running", "done", "failed", "cancelled", "timed_out", "busy"]
DraftStatus = Literal["running", "done", "failed", "cancelled", "timed_out", "busy"]
# Outcome of a model-service test call (TaxonomyLLM.probe).
ProbeStatus = Literal["ok", "denied", "not_found", "busy", "error"]


class TaxonomyIntake(BaseModel):
    company_name: str = Field(min_length=1, max_length=128, pattern=BUSINESS_NAME_PATTERN)
    industry: str = Field(min_length=1, max_length=200)
    one_liner: str = Field(default="", max_length=500)
    known_domains: str = Field(default="", max_length=4000)
    key_systems: str = Field(default="", max_length=4000)
    regulators: str = Field(default="", max_length=4000)
    pasted_doc: str = Field(default="", max_length=60000)


class TaxonomySubdomain(BaseModel):
    name: str = Field(min_length=1)
    categories: list[str] = Field(default_factory=list)


class TaxonomyDomain(BaseModel):
    name: str = Field(min_length=1)
    # Blank = derive with snake(name). Users may override in the editor.
    schema_name: str = ""
    subdomains: list[TaxonomySubdomain] = Field(default_factory=list)


class TaxonomySharedMaster(BaseModel):
    entity: str = Field(min_length=1)  # snake entity name, e.g. "customer_account"
    home_domain: str = Field(min_length=1)  # a domain schema name


class TaxonomyRelationship(BaseModel):
    source: str = Field(min_length=1)
    targets: list[str] = Field(min_length=1)


class TaxonomyTree(BaseModel):
    domains: list[TaxonomyDomain] = Field(min_length=1)
    shared_masters: list[TaxonomySharedMaster] = Field(default_factory=list)
    relationships: list[TaxonomyRelationship] = Field(default_factory=list)
    division_names: list[str] = Field(default_factory=list)
    coverage: OrgDivisions = "Operations, Business and Corporate"


class TaxonomyClaim(BaseModel):
    text: str = Field(min_length=1)
    provenance: Provenance


class TaxonomySection(BaseModel):
    claims: list[TaxonomyClaim] = Field(min_length=1)


class TaxonomyDraftPartOut(BaseModel):
    status: PartStatus
    error: str | None = None
    tree: TaxonomyTree | None = None
    section: TaxonomySection | None = None
    description: str | None = None


class TaxonomyDraftOut(BaseModel):
    draft_id: str
    status: DraftStatus
    # keys: "tree", each SECTION_KEYS entry, and/or "description"
    parts: dict[str, TaxonomyDraftPartOut]


class TaxonomyDraftCreated(BaseModel):
    draft_id: str


class TaxonomyCompileIn(BaseModel):
    tree: TaxonomyTree
    strictness: Strictness = "strict"
    sections: dict[str, TaxonomySection] = Field(default_factory=dict)


class TaxonomyIssue(BaseModel):
    severity: Literal["error", "warning"]
    message: str
    # The agent rule (DOM-RUL-NNN) behind the issue; "" for builder-only checks.
    rule_id: str = ""
    # Indices into tree.domains the issue belongs to; [] = model-level.
    domains: list[int] = Field(default_factory=list)


class TaxonomyCompileOut(BaseModel):
    clamp: str
    business_vibes: str
    business_domains: str  # comma+space separated schema names, tree order
    csv: str
    issues: list[TaxonomyIssue]


class TaxonomyCondenseIn(BaseModel):
    intake: TaxonomyIntake
    tree: TaxonomyTree
    sections: dict[str, TaxonomySection]


class TaxonomyExampleOut(BaseModel):
    company_name: str
    industry: str
    tree: TaxonomyTree
    sections: dict[str, TaxonomySection]
    description: str


# --- Settings: /config/taxonomy -------------------------------------------


class TaxonomyCheckOut(BaseModel):
    """One model-service test call: ``ok`` saves; ``busy`` saves with a
    warning; the rest refuse."""

    status: ProbeStatus
    message: str
    checked_at: datetime


class TaxonomyConfigOut(BaseModel):
    installed: bool
    model_service: str
    install_default_model_service: str
    max_concurrency: int
    # Whether the wizard can be offered: installed, a model service is set,
    # and its last test call was not denied / not_found / error (never
    # checked and busy count as ready). Computed only by GET /config/taxonomy.
    ready: bool
    # Most recent test call for ``model_service`` in this app process.
    last_check: Optional[TaxonomyCheckOut] = None


class TaxonomyConfigIn(BaseModel):
    # ``""`` clears the setting (allowed only without an install default).
    model_service: str = Field(default="", max_length=800)
    max_concurrency: int = Field(DEFAULT_CAPACITY, ge=MIN_CAPACITY, le=MAX_CAPACITY)


class TaxonomyModelServicesOut(BaseModel):
    """Model services the app service principal can see, sorted, ``system.ai``
    last. Being listed does not prove EXECUTE; the test call does."""

    services: list[str]
    # Set when the list call failed (``services`` is then empty): Settings
    # falls back to free text.
    message: Optional[str] = None
