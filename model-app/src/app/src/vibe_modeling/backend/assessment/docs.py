"""Run-scoped doc viewing: path guard and capped reader for files in a run's Volume folder."""
from __future__ import annotations

import posixpath
from urllib.parse import unquote

DOC_EXTENSIONS = {".md", ".sql", ".yml", ".yaml", ".json"}
DOC_CAP = 512_000


def resolve_doc_path(out_dir: str, rel_or_abs: str) -> str:
    """Resolve ``rel_or_abs`` to an absolute file path inside ``out_dir/docs/`` (or ``out_dir/conventions.yml``).

    Raises ``ValueError`` for empty, directory-like, out-of-scope (``..``, encoded ``..``, sibling-prefix,
    ``config.json``/``assessment.json``/...) or disallowed-extension paths. The value is decoded (at most 3
    times; still changing => rejected), then normalized, then prefix-checked.
    """
    raw = (rel_or_abs or "").strip()
    for _ in range(3):
        decoded = unquote(raw)
        if decoded == raw:
            break
        raw = decoded
    else:
        if unquote(raw) != raw:
            raise ValueError("Invalid path encoding.")
    if not raw:
        raise ValueError("Path is required.")
    if any(ord(c) < 32 or ord(c) == 127 for c in raw):
        raise ValueError("Invalid path.")
    if raw.endswith("/"):
        raise ValueError("Path must be a file.")
    if ".." in raw.replace("\\", "/").split("/"):
        raise ValueError("Path must not contain '..'.")
    root = out_dir.rstrip("/")
    full = posixpath.normpath(raw if raw.startswith("/") else f"{root}/{raw}")
    if not (full.startswith(root + "/docs/") or full == root + "/conventions.yml"):
        raise ValueError("Only run docs and conventions.yml can be viewed.")
    if posixpath.splitext(full)[1].lower() not in DOC_EXTENSIONS:
        raise ValueError("File type not allowed.")
    return full


def read_doc(ws, path: str, cap: int = DOC_CAP) -> tuple[str, bool]:
    """Read up to ``cap`` bytes of a Volume file as text; returns ``(content, truncated)``."""
    data = ws.files.download(path).contents.read(cap + 1)
    truncated = len(data) > cap
    return data[:cap].decode("utf-8", errors="replace"), truncated
