"""Idempotent ``<catalog>._metamodel`` + MANAGED volume setup (``vol_root`` by default).

Canonical implementation for the app and the installer:
``install/grant_catalog.py`` loads this file by path (``vibe_modeling`` is not
installed in the operator env), so it imports only the stdlib and
``databricks.sdk``. The helper always raises on failure; the policy lives in
the callers (the app refuses the run, the installer logs the manual SQL and
continues). The ``new-base-model`` create handler calls this after every gate,
before the Run row is written, so a brand-new base model in a fresh catalog is
not blocked on a manual installer step: step-0 dispatch may spill
``model_vibes`` into ``vol_root`` before the agent can create ``_metamodel``
itself.

Identity: the app passes the ``Dependencies.Client`` workspace client, which
is the App service principal (``WorkspaceClient()`` built in the lifespan from
the app's injected credentials), NOT the on-behalf-of user. So the SP needs
``USE_CATALOG`` + ``CREATE_SCHEMA`` on the catalog for this to succeed.
"""

from __future__ import annotations

import logging

from databricks.sdk.errors import NotFound, PermissionDenied
from databricks.sdk.service.catalog import VolumeType

logger = logging.getLogger(__name__)

METAMODEL_SCHEMA = "_metamodel"
VOL_ROOT = "vol_root"


class MetamodelSetupError(Exception):
    """Setup failed at ``step`` (``"schema"`` or ``"volume"``). ``str(exc)`` is
    a fixed, user-safe message (no raw SDK exception text); the raw error is
    logged server-side."""

    def __init__(self, message: str, *, step: str) -> None:
        super().__init__(message)
        self.step = step


def _app_principal(ws) -> str:
    """Best-effort App service-principal client id for the error message."""
    client_id = getattr(getattr(ws, "config", None), "client_id", None)
    if isinstance(client_id, str) and client_id.strip():
        return f"({client_id.strip()})"
    return "(its client id is on the app's Authorization/Environment page)"


def _generic_failure_message(ws, catalog: str, step: str, volume: str = VOL_ROOT) -> str:
    if step == "volume":
        return (
            f"Couldn't set up `_metamodel` in '{catalog}' automatically (the "
            f"`{volume}` volume step failed). Check that the app's service "
            f"principal {_app_principal(ws)} has USE_SCHEMA + CREATE_VOLUME on "
            f"'{catalog}.{METAMODEL_SCHEMA}', or run `install/grant_catalog.py`, "
            f"then retry."
        )
    return (
        f"Couldn't set up `_metamodel` in '{catalog}' automatically. Check that the "
        f"catalog exists and the app's service principal {_app_principal(ws)} has "
        f"USE_CATALOG + CREATE_SCHEMA on it, or run `install/grant_catalog.py`, "
        f"then retry."
    )


def _permission_message(ws, catalog: str, step: str, volume: str = VOL_ROOT) -> str:
    if step == "volume":
        return (
            f"The app can't create the `{volume}` volume in "
            f"'{catalog}.{METAMODEL_SCHEMA}' (needs USE_SCHEMA + CREATE_VOLUME on "
            f"that schema). Ask a catalog owner to grant the app's service "
            f"principal {_app_principal(ws)} those privileges, or run "
            f"`install/grant_catalog.py`."
        )
    return (
        f"The app can't create `_metamodel` in '{catalog}' (needs USE_CATALOG + "
        f"CREATE_SCHEMA on the catalog). Ask a catalog owner to grant the app's "
        f"service principal {_app_principal(ws)} those privileges, or run "
        f"`install/grant_catalog.py`."
    )


def _probe(ws, catalog: str, *, step: str, probe, full_name: str, volume: str = VOL_ROOT) -> bool:
    """Pre-create probe: True when ``probe(full_name)`` reads the object.

    ``NotFound`` / ``PermissionDenied`` return False so the caller attempts the
    create; any other error fails the step with its generic message.
    """
    try:
        probe(full_name)
    except (NotFound, PermissionDenied):
        return False
    except Exception as exc:  # noqa: BLE001 — an unreadable object fails the step
        logger.warning("Probing %s failed: %s", full_name, exc, exc_info=True)
        raise MetamodelSetupError(
            _generic_failure_message(ws, catalog, step, volume), step=step
        ) from exc
    return True


def _readable_now(probe, full_name: str) -> bool:
    """Post-failure re-probe: True when the object exists now. Never raises, so
    the caller can re-raise the original create error."""
    try:
        probe(full_name)
    except Exception as exc:  # noqa: BLE001 — any error means "not confirmed"
        logger.warning("%s not readable after a failed create: %s", full_name, exc)
        return False
    return True


def ensure_metamodel_schema_and_volume(ws, catalog: str, volumes: tuple[str, ...] = (VOL_ROOT,)) -> list[str]:
    """Create ``<catalog>._metamodel`` and each MANAGED volume in ``volumes`` if absent.

    ``volumes`` defaults to ``("vol_root",)``; the assessment job sync passes
    ``("vol_root", "assess_runs")``. Returns the list of resources actually created
    (``[]`` when all already existed). Each object is probed first and skipped
    when it exists. Any failed create is followed by a re-probe and decided
    from state: UC reports an existing schema as ``BadRequest``
    (``SCHEMA_ALREADY_EXISTS``) and an existing volume as
    ``ResourceAlreadyExists``, so the error type alone does not say whether the
    object exists. Readable now = success; otherwise the original create error
    maps to :class:`MetamodelSetupError` (with ``step``) and a fixed,
    actionable message naming the volume.
    """
    created: list[str] = []
    schema_full = f"{catalog}.{METAMODEL_SCHEMA}"
    step, volume = "schema", volumes[0] if volumes else VOL_ROOT
    try:
        if not _probe(ws, catalog, step=step, probe=ws.schemas.get, full_name=schema_full):
            try:
                ws.schemas.create(name=METAMODEL_SCHEMA, catalog_name=catalog)
                created.append(f"schema {schema_full}")
            except Exception:
                if not _readable_now(ws.schemas.get, schema_full):
                    raise
        step = "volume"
        for volume in volumes:
            vol_full = f"{schema_full}.{volume}"
            if _probe(ws, catalog, step=step, probe=ws.volumes.read, full_name=vol_full, volume=volume):
                continue
            try:
                ws.volumes.create(
                    catalog_name=catalog,
                    schema_name=METAMODEL_SCHEMA,
                    name=volume,
                    volume_type=VolumeType.MANAGED,
                )
                created.append(f"managed volume {vol_full}")
            except Exception:
                if not _readable_now(ws.volumes.read, vol_full):
                    raise
    except MetamodelSetupError:
        # Keep the outer ``except Exception`` from re-wrapping the step error
        # (a MetamodelSetupError can't match ``except PermissionDenied``).
        raise
    except PermissionDenied as exc:
        logger.warning("No permission to set up %s (%s step): %s", schema_full, step, exc)
        raise MetamodelSetupError(_permission_message(ws, catalog, step, volume), step=step) from exc
    except Exception as exc:  # noqa: BLE001 — any SDK/transport error becomes a blocker
        logger.warning("Setting up %s failed (%s step): %s", schema_full, step, exc,
                       exc_info=True)
        raise MetamodelSetupError(_generic_failure_message(ws, catalog, step, volume), step=step) from exc

    if created:
        logger.info("Auto-created in %s: %s", catalog, ", ".join(created))
    return created
