"""Run a frontend build command and fail if it changed the dependency pins.

``apx build`` (and ``apx dev start``) always runs ``bun add --dev`` for the
packages its embedded Vite entrypoint imports (``@opentelemetry/*``,
``@tanstack/router-*``, ...). A bare ``bun add`` resolves each package's
``latest`` dist-tag and rewrites ``package.json`` / ``bun.lock`` to match, so a
fresh clone builds against whatever was published that day instead of the
committed lockfile. The ``overrides`` block in ``src/app/package.json`` pins
those packages, which keeps the ``bun add`` a no-op. This guard catches the day
the pins stop holding (a new apx-managed package, a removed override): it runs
the command, compares both files with their pre-build content, and on a change
writes the pre-build files back and exits 1 with the diff. Restoring them makes
every re-run fail the same way until the pins are fixed.

Both files are compared by meaning, so a different bun version re-serializing
them does not count as a change:

- ``package.json``: the dependency specs and ``overrides`` / ``resolutions``.
- ``bun.lock``: the workspace dependency specs, ``overrides``, and per package
  its ``name@version`` and integrity hash. The lockfile header
  (``lockfileVersion`` / ``configVersion``), formatting and tarball URLs are
  ignored (bun writes ``""`` for packages from the default registry).

Usage: python install/frontend_lock_guard.py <app_dir> -- <command> [args...]
"""

from __future__ import annotations

import argparse
import difflib
import json
import re
import subprocess
import sys
from pathlib import Path

PACKAGE_JSON = "package.json"
BUN_LOCK = "bun.lock"

_PACKAGE_JSON_KEYS = (
    "dependencies",
    "devDependencies",
    "optionalDependencies",
    "peerDependencies",
    "overrides",
    "resolutions",
)
_TRAILING_COMMA = re.compile(r",(\s*[}\]])")
_INTEGRITY_PREFIXES = ("sha512-", "sha384-", "sha256-", "sha1-")

FAILURE_MESSAGE = """
ERROR: `{command}` changed the frontend dependency pins in {app_dir}.
The build did not use the committed lockfile, so it is not reproducible.
{files} restored to their pre-build content; this build fails until the pins hold.

If you are installing the app: restore the files with
    git checkout -- src/app/package.json src/app/bun.lock
and re-run the install. If it fails again, report it together with the output
of `apx --version`.

If you maintain the app: restore the files first, then for each moved package
add or bump its pin in the `overrides` block of package.json AND set its
devDependencies spec to `^<override>` (apx's `bun add --dev` rewrites any other
spec), then run `bun install` and commit both files.

What the build changed:
"""


def semantic_package_json(text: str) -> dict:
    data = json.loads(text)
    return {key: data[key] for key in _PACKAGE_JSON_KEYS if key in data}


def semantic_bun_lock(text: str) -> dict:
    data = json.loads(_TRAILING_COMMA.sub(r"\1", text))
    packages = {}
    for key, entry in data.get("packages", {}).items():
        if isinstance(entry, list) and entry:
            integrity = [
                item for item in entry[1:]
                if isinstance(item, str) and item.startswith(_INTEGRITY_PREFIXES)
            ]
            packages[key] = [entry[0], *integrity]
        else:
            packages[key] = entry
    return {
        "workspaces": data.get("workspaces", {}),
        "overrides": data.get("overrides", {}),
        "packages": packages,
    }


_SEMANTICS = {PACKAGE_JSON: semantic_package_json, BUN_LOCK: semantic_bun_lock}


def read_raw(app_dir: Path) -> dict[str, str]:
    """Raw content of each pinned file that exists in ``app_dir``."""
    return {
        name: (app_dir / name).read_text()
        for name in _SEMANTICS
        if (app_dir / name).is_file()
    }


def render(name: str, text: str | None) -> str:
    """Canonical JSON of the file's meaning; the raw text when it does not parse."""
    if text is None:
        return ""
    try:
        return json.dumps(_SEMANTICS[name](text), indent=2, sort_keys=True) + "\n"
    except ValueError:
        return text


def drift(before: dict[str, str], after: dict[str, str]) -> dict[str, str]:
    """Unified diff per file whose meaning changed."""
    diffs: dict[str, str] = {}
    for name in sorted(set(before) | set(after)):
        old, new = render(name, before.get(name)), render(name, after.get(name))
        if old != new:
            diffs[name] = "".join(
                difflib.unified_diff(
                    old.splitlines(keepends=True),
                    new.splitlines(keepends=True),
                    fromfile=f"{name} (before build)",
                    tofile=f"{name} (after build)",
                    n=1,
                )
            )
    return diffs


def restore(app_dir: Path, before: dict[str, str], names: list[str]) -> None:
    for name in names:
        path = app_dir / name
        if name in before:
            path.write_text(before[name])
        elif path.exists():
            path.unlink()


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=(__doc__ or "").splitlines()[0] if __doc__ else None)
    parser.add_argument("app_dir", type=Path)
    parser.add_argument("command", nargs=argparse.REMAINDER)
    args = parser.parse_args(argv)
    command = args.command[1:] if args.command[:1] == ["--"] else args.command
    if not command:
        parser.error("missing command after --")

    before = read_raw(args.app_dir)
    rc = subprocess.run(command, cwd=args.app_dir).returncode
    diffs = drift(before, read_raw(args.app_dir))
    if not diffs:
        return rc
    restore(args.app_dir, before, list(diffs))
    files = " and ".join(diffs)
    sys.stderr.write(
        FAILURE_MESSAGE.format(
            command=" ".join(command),
            app_dir=args.app_dir,
            files=f"{files} {'were' if len(diffs) > 1 else 'was'}",
        )
    )
    for diff in diffs.values():
        sys.stderr.write(diff + "\n")
    return rc or 1


if __name__ == "__main__":
    sys.exit(main())
