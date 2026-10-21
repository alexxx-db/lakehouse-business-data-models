"""snake_case naming shared by compile + the frontend (parity: tests/fixtures/taxonomy_snake_fixture.json)."""

from __future__ import annotations

import re
import unicodedata

# DOM-RUL-002: one lowercase word - letters and digits only, no underscores.
SCHEMA_NAME_RE = re.compile(r"^[a-z][a-z0-9]*$")
SCHEMA_NAME_MAX = 20
_NON_ALNUM = re.compile(r"[^a-z0-9]+")


def snake(text: str) -> str:
    """ASCII-fold, lowercase, collapse non-alphanumerics to '_', trim '_'.

    'Énergie Réseau' -> 'energie_reseau'; '&&&' -> ''; '日本' -> ''.
    """
    folded = unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode("ascii")
    return _NON_ALNUM.sub("_", folded.lower()).strip("_")


def schema_for(name: str, override: str = "") -> str:
    """Domain schema: the explicit override, else snake(name) with underscores removed.

    The modeling agent wants one-word schemas ('fieldservice', 'powergeneration'),
    so the derived form drops the separators instead of keeping snake_case.
    """
    return override.strip() or snake(name).replace("_", "")
