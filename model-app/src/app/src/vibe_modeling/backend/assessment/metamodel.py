"""Locate the UC metamodel for an installed model version (mirrors the skill's §1.0 probe)."""
from __future__ import annotations

from dataclasses import dataclass

from databricks.sdk import WorkspaceClient
from databricks.sdk.errors.platform import NotFound, PermissionDenied

METAMODEL_TABLES = ("business", "product", "attribute", "domain")


@dataclass(frozen=True)
class MetamodelLocation:
    catalog: str
    schema: str
    prefix: str

    @property
    def fqn(self) -> str:
        return f"{self.catalog}.{self.schema}"


def _names(ws: WorkspaceClient, catalog: str, schema: str) -> set[str]:
    try:
        return {t.name for t in ws.tables.list(catalog_name=catalog, schema_name=schema)}
    except (NotFound, PermissionDenied):
        return set()


def resolve_metamodel_location(ws: WorkspaceClient, catalog: str, physical_schema: str) -> MetamodelLocation | None:
    """Bare ``_metamodel`` schema first, else ``vibe_metamodel_*`` tables co-located in the domain schema."""
    if set(METAMODEL_TABLES) <= _names(ws, catalog, "_metamodel"):
        return MetamodelLocation(catalog, "_metamodel", "")
    if {f"vibe_metamodel_{t}" for t in METAMODEL_TABLES} <= _names(ws, catalog, physical_schema):
        return MetamodelLocation(catalog, physical_schema, "vibe_metamodel_")
    return None
