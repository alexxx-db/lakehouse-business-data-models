"""Locate the vendored assessment assets and upload them to the workspace."""
from __future__ import annotations

import hashlib
import io
import json
from importlib import resources
from pathlib import Path

from databricks.sdk import WorkspaceClient
from databricks.sdk.service.workspace import ExportFormat, ImportFormat, Language

SKILL_VERSION_FILE = ".vibe-skill-version"  # "<skills_version> <skills_ref>" in every vendored skill dir

def _candidate_roots() -> list[Path]:
    roots: list[Path] = []
    try:
        roots.append(Path(str(resources.files("vibe_modeling"))) / "vendored" / "assessment")
    except (ModuleNotFoundError, TypeError, AttributeError):
        pass
    roots.append(Path(__file__).resolve().parents[4] / "vendored" / "assessment")
    return roots


def resolve_vendored_assessment() -> Path | None:
    return next((r for r in _candidate_roots() if (r / "VERSIONS.json").is_file()), None)


def read_versions() -> dict:
    root = resolve_vendored_assessment()
    if root is None:
        raise RuntimeError("Vendored assessment assets are not packaged with this build.")
    return json.loads((root / "VERSIONS.json").read_text())


def read_bundled_skill_versions(names: list[str]) -> dict[str, str]:
    """Version marker (`<skills_version> <skills_ref>`) of each skill in the local vendored tree; '' if absent."""
    root = resolve_vendored_assessment()
    out: dict[str, str] = {}
    for n in names:
        f = root / "skills" / n / SKILL_VERSION_FILE if root else None
        out[n] = f.read_text().strip() if f is not None and f.is_file() else ""
    return out


def is_bundled_file(base: Path, p: Path) -> bool:
    """A vendored file that ships (to the job folder or a user's skills): no caches, no dotfiles
    except the skill version marker, which the run records and the skills check compares."""
    parts = p.relative_to(base).parts
    return p.is_file() and not any(
        s == "__pycache__" or (s.startswith(".") and s != SKILL_VERSION_FILE) for s in parts)


MANIFEST_NAME = "vibe-assess-manifest.json"
NOTEBOOK_SOURCE = "assess_domain.py"  # uploaded extensionless as a SOURCE notebook so the job can run it


def bundle_files() -> tuple[Path, list[Path]]:
    """The vendored root and its uploadable files, in a stable order."""
    root = resolve_vendored_assessment()
    if root is None:
        raise RuntimeError("Vendored assessment assets are not packaged with this build.")
    return root, sorted(p for p in root.rglob("*") if is_bundled_file(root, p))


def bundle_manifest(root: Path, files: list[Path]) -> bytes:
    """sha256 of every bundled file by relative path, as canonical JSON."""
    digests = {f.relative_to(root).as_posix(): hashlib.sha256(f.read_bytes()).hexdigest() for f in files}
    return json.dumps(digests, sort_keys=True, indent=1).encode()


def remote_manifest(ws: WorkspaceClient, folder: str) -> bytes | None:
    """The manifest a previous upload wrote, or None when it is absent or unreadable."""
    try:
        data = ws.workspace.download(f"{folder}/{MANIFEST_NAME}", format=ExportFormat.AUTO).read()
    except Exception:  # noqa: BLE001 — absent or unreadable means "upload again"
        return None
    return data if isinstance(data, bytes) else None


def upload_assessment_assets(ws: WorkspaceClient, folder: str) -> bool:
    """Upload the vendored tree into ``folder`` unless its manifest already matches; returns True if it uploaded.

    Check-then-act: the manifest (sha256 per bundled file) is written last, so a
    partial upload never matches and is redone on the next sync.
    """
    root, files = bundle_files()
    manifest = bundle_manifest(root, files)
    if remote_manifest(ws, folder) == manifest:
        return False
    ws.workspace.mkdirs(folder)
    made = {folder}
    for f in files:
        rel = f.relative_to(root).as_posix()
        if rel == NOTEBOOK_SOURCE:
            ws.workspace.upload(f"{folder}/assess_domain", io.BytesIO(f.read_bytes()),
                                format=ImportFormat.SOURCE, language=Language.PYTHON, overwrite=True)
            continue
        parent = f"{folder}/{rel}".rsplit("/", 1)[0]
        if parent not in made:
            ws.workspace.mkdirs(parent)
            made.add(parent)
        ws.workspace.upload(f"{folder}/{rel}", io.BytesIO(f.read_bytes()), format=ImportFormat.RAW, overwrite=True)
    ws.workspace.upload(f"{folder}/{MANIFEST_NAME}", io.BytesIO(manifest), format=ImportFormat.RAW, overwrite=True)
    return True
