"""Read a principal's effective Unity Catalog privileges (shared by readiness and the job sync)."""
from __future__ import annotations

from databricks.sdk import WorkspaceClient
from databricks.sdk.errors.platform import DatabricksError


def effective_privileges(ws: WorkspaceClient, securable_type: str, full_name: str, principal: str) -> set[str] | None:
    """Effective (incl. inherited) privileges, or None when the app can't evaluate them."""
    try:
        res = ws.grants.get_effective(securable_type, full_name, principal=principal)
    except DatabricksError:
        return None
    return {getattr(p.privilege, "value", p.privilege)
            for a in (res.privilege_assignments or []) for p in (a.privileges or [])}
