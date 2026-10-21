"""The app service principal's own identity and workspace home.

One home for "who is the app": the bundled agent notebook and the assessment
job's workspace folder both live under the app SP's home, and Settings shows
the app's application id in the reader setup steps.
"""

from __future__ import annotations

import logging

from databricks.sdk import WorkspaceClient

logger = logging.getLogger(__name__)

# Process-wide cache of the app's own application id (it cannot change while running).
_APP_ID_CACHE: dict[str, str] = {}


def app_sp_user_name(ws: WorkspaceClient) -> str:
    """The app SP's ``user_name`` (its application id). Raises ``RuntimeError`` when empty."""
    user_name = getattr(ws.current_user.me(), "user_name", None) or ""
    if not isinstance(user_name, str) or not user_name:
        raise RuntimeError("Databricks returned a user with no user_name; cannot resolve the app's identity.")
    return user_name


def app_sp_home(ws: WorkspaceClient) -> str:
    """The app SP's workspace home, ``/Users/<user_name>``."""
    return f"/Users/{app_sp_user_name(ws)}"


def app_application_id(ws: WorkspaceClient) -> str:
    """``app_sp_user_name``, cached for the process; ``""`` on any error (display only)."""
    if "id" in _APP_ID_CACHE:
        return _APP_ID_CACHE["id"]
    try:
        value = app_sp_user_name(ws)
    except Exception as e:  # fail-soft: this only decorates the Settings checklist
        logger.warning("Could not resolve the app's application id: %s", e)
        return ""
    _APP_ID_CACHE["id"] = value
    return value
