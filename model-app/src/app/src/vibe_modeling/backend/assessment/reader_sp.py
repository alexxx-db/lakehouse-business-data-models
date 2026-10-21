"""Look up the reader service principal by application id (Settings Save, readiness and the job sync)."""
from __future__ import annotations

from databricks.sdk import WorkspaceClient


def find_reader_sp(ws: WorkspaceClient, application_id: str):
    safe = application_id.replace('"', "")
    return next(iter(ws.service_principals.list(filter=f'applicationId eq "{safe}"')), None)


def reader_not_found_message(application_id: str) -> str:
    return f"Service principal with application ID {application_id!r} not found in this workspace."
