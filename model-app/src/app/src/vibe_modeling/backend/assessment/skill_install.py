"""Install the bundled Genie Code skills into the caller's own workspace folder (on-behalf-of)."""
from __future__ import annotations

import base64
import logging
import re
from pathlib import Path

from databricks.sdk import WorkspaceClient
from databricks.sdk.errors import DatabricksError
from databricks.sdk.service.workspace import ImportFormat

from .assets import SKILL_VERSION_FILE, is_bundled_file, resolve_vendored_assessment
from .handoff import user_skill_dir
from .schemas import SkillStatus

logger = logging.getLogger(__name__)
_ACTUAL_TYPE = re.compile(r"actual:\s*(\w+)", re.I)


def plan_install(statuses: list[SkillStatus], names: list[str], update: list[str]) -> tuple[list[str], list[str], list[str]]:
    """(to_install, to_update, skipped). Default installs every missing skill; ``update`` overwrites listed ones (including unknown ones)."""
    by_name = {s.name: s for s in statuses}
    wanted = names or [s.name for s in statuses if s.state == "missing"]
    to_install = [n for n in dict.fromkeys(wanted) if n in by_name and by_name[n].state == "missing"]
    to_update = [n for n in dict.fromkeys(update) if n in by_name and by_name[n].state in ("update_available", "unknown")]
    done = {*to_install, *to_update}
    universe = list(by_name) if not names else list(dict.fromkeys([*names, *update]))
    return to_install, to_update, [n for n in universe if n not in done]


def _skill_files(name: str) -> list[Path]:
    root = resolve_vendored_assessment()
    if root is None:
        raise RuntimeError("Vendored assessment assets are not packaged with this build.")
    base = root / "skills" / name
    files = [p for p in sorted(base.rglob("*")) if is_bundled_file(base, p)]
    return sorted(files, key=lambda p: p.name == SKILL_VERSION_FILE)  # stable: marker last


def install_skill(user_ws: WorkspaceClient, name: str, user_email: str) -> None:
    """Write one vendored skill into /Workspace/Users/<email>/.assistant/skills/<name> as plain files."""
    root = resolve_vendored_assessment()
    base = root / "skills" / name
    dest = user_skill_dir(user_email, name)
    made: set[str] = set()
    for f in _skill_files(name):
        target = f"{dest}/{f.relative_to(base).as_posix()}"
        parent = target.rsplit("/", 1)[0]
        if parent not in made:
            user_ws.workspace.mkdirs(parent)
            made.add(parent)
        # RAW keeps every file (SKILL.md, scripts) a workspace FILE; AUTO/SOURCE could turn .py/.sql into notebooks.
        content = base64.b64encode(f.read_bytes()).decode()
        try:
            user_ws.workspace.import_(target, content=content, format=ImportFormat.RAW, overwrite=True)
        except DatabricksError as e:
            if "type mismatch" not in str(e).lower():
                raise
            # An earlier manual install may have auto-converted this file (e.g. .lvdash.json -> DASHBOARD); RAW
            # import cannot overwrite a different object type, so remove exactly this one path and retry once.
            m = _ACTUAL_TYPE.search(str(e))
            user_ws.workspace.delete(target, recursive=False)
            logger.info("replaced %s (was %s)", f.relative_to(base).as_posix(), m.group(1) if m else "unknown type")
            user_ws.workspace.import_(target, content=content, format=ImportFormat.RAW, overwrite=True)
