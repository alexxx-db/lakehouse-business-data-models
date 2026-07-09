"""Core SQL-processing logic for data-model-installer.ipynb.

Authored as a standalone module so it can be unit-tested locally against
real repo SQL before being embedded verbatim into the notebook cells.
No Spark / Databricks dependency in this module.
"""
import re
from collections import OrderedDict


_CATALOGING_STYLE_MAP = {
    "One Catalog": "one_catalog",
    "Catalog per Division": "catalog_per_division",
    "Catalog per Domain": "catalog_per_domain",
    "one_catalog": "one_catalog",
    "catalog_per_division": "catalog_per_division",
    "catalog_per_domain": "catalog_per_domain",
}

_DIVISION_CATALOG_MAP = {
    "operations": "operations",
    "business": "business",
    "corporate": "corporate",
    "supporting": "business",
}

_INTERNAL_SCHEMAS = frozenset({"_metrics", "_install", "_metamodel", "information_schema", "default"})

_DOMAIN_HEADER_RE = re.compile(r"--\s*Schema for Domain:\s*(\S+)", re.IGNORECASE)
_METRIC_DOMAIN_HEADER_RE = re.compile(r"--\s*Metric views for domain:\s*(\S+)", re.IGNORECASE)
_DIVISION_TAG_RE = re.compile(r"dbx_division['\"]?\s*=\s*['\"](\w+)['\"]", re.IGNORECASE)
_CATALOG_SCHEMA_RE = re.compile(r"`([^`]+)`\.`([^`]+)`")
_CREATE_SCHEMA_RE = re.compile(
    r"CREATE\s+(?:OR\s+REPLACE\s+)?(?:DATABASE|SCHEMA)\s+(?:IF\s+NOT\s+EXISTS\s+)?`([^`]+)`\.`([^`]+)`",
    re.IGNORECASE,
)


class CatalogResolver:
    """Mirrors vibe-modelling-agent CatalogResolver (industry-agnostic)."""

    def __init__(self, style, base_catalog, prefix="", suffix=""):
        self.style = _CATALOGING_STYLE_MAP.get(style, style)
        if self.style not in ("one_catalog", "catalog_per_division", "catalog_per_domain"):
            self.style = "one_catalog"
        self.base_catalog = base_catalog
        self.prefix = prefix or ""
        self.suffix = suffix or ""
        if self.style in ("catalog_per_domain", "catalog_per_division") and not self.prefix and not self.suffix:
            self.prefix = "cat_"

    def resolve_catalog(self, domain_dict):
        if self.style == "one_catalog":
            return self.base_catalog
        if self.style == "catalog_per_division":
            division = (domain_dict.get("division") or "business").lower().strip()
            cat = _DIVISION_CATALOG_MAP.get(division, "business")
            return self._apply_affixes(cat)
        if self.style == "catalog_per_domain":
            domain_name = domain_dict.get("domain") or domain_dict.get("name", "")
            cat = _snake_case(domain_name) if domain_name else "default"
            return self._apply_affixes(cat)
        return self.base_catalog

    def all_catalogs(self, domains):
        return sorted({self.resolve_catalog(d) for d in domains})

    def _apply_affixes(self, name):
        if self.prefix or self.suffix:
            return "%s%s%s" % (self.prefix, name, self.suffix)
        return name


def _snake_case(name):
    s = re.sub(r"[^a-zA-Z0-9]+", "_", str(name or "").strip())
    s = re.sub(r"_+", "_", s).strip("_").lower()
    return s or "default"


def normalize_cataloging_style(style):
    return _CATALOGING_STYLE_MAP.get((style or "").strip(), "one_catalog")


def parse_schema_metadata(sql_text, src_catalog=None):
    """Extract schema -> {domain, division} from one schema or metric SQL file."""
    meta = {}
    domain = None
    dm = _DOMAIN_HEADER_RE.search(sql_text) or _METRIC_DOMAIN_HEADER_RE.search(sql_text)
    if dm:
        domain = dm.group(1).strip().lower()

    division = "business"
    div_m = _DIVISION_TAG_RE.search(sql_text)
    if div_m:
        division = div_m.group(1).strip().lower()

    for cat, schema in _CREATE_SCHEMA_RE.findall(sql_text):
        if src_catalog and cat != src_catalog:
            continue
        if schema.startswith("_"):
            continue
        key = schema.lower()
        meta[key] = {"domain": domain or key, "division": division, "schema": schema}

    if not meta:
        for cat, schema in _CATALOG_SCHEMA_RE.findall(sql_text):
            if src_catalog and cat != src_catalog:
                continue
            if schema.startswith("_"):
                continue
            key = schema.lower()
            if key not in meta:
                meta[key] = {"domain": domain or key, "division": division, "schema": schema}

    if domain:
        dk = domain.lower()
        if dk in meta:
            meta[dk]["domain"] = dk

    return meta


def collect_schema_metadata(raw_by_name, src_catalog):
    """Merge per-file schema metadata across all schema + metric SQL sources."""
    merged = OrderedDict()
    for name, raw in raw_by_name.items():
        if not name.endswith(".sql"):
            continue
        for schema_key, info in parse_schema_metadata(raw, src_catalog).items():
            if schema_key not in merged:
                merged[schema_key] = dict(info)
            else:
                if info.get("division") and info["division"] != "business":
                    merged[schema_key]["division"] = info["division"]
    return merged


def build_schema_catalog_map(schema_meta, resolver, src_catalog, base_catalog):
    """Map schema_name -> target_catalog for layout rewrite."""
    mapping = {}
    for schema_key, info in schema_meta.items():
        target = resolver.resolve_catalog(
            {"domain": info.get("domain") or schema_key, "division": info.get("division") or "business"}
        )
        mapping[schema_key] = target
        mapping[info.get("schema", schema_key)] = target

    for internal in _INTERNAL_SCHEMAS:
        mapping[internal] = base_catalog

    if resolver.style == "one_catalog":
        for key in list(mapping.keys()):
            mapping[key] = base_catalog

    return mapping


def target_catalogs_for_layout(schema_catalog_map, base_catalog, style):
    style = normalize_cataloging_style(style)
    if style == "one_catalog":
        return [base_catalog]
    cats = sorted(set(schema_catalog_map.values()))
    if base_catalog not in cats:
        cats.append(base_catalog)
    return sorted(set(cats))


def rewrite_catalog_layout(text, src_catalog, schema_catalog_map, base_catalog):
    """Rewrite `src`.`schema` triples using per-schema target catalogs."""
    if not src_catalog or not text:
        return text

    pairs = []
    seen = set()
    for m in _CATALOG_SCHEMA_RE.finditer(text):
        cat, schema = m.group(1), m.group(2)
        if cat != src_catalog:
            continue
        key = (cat, schema)
        if key in seen:
            continue
        seen.add(key)
        if schema.startswith("_") or schema.lower() in _INTERNAL_SCHEMAS:
            target = base_catalog
        else:
            target = schema_catalog_map.get(schema, schema_catalog_map.get(schema.lower(), base_catalog))
        pairs.append((cat, schema, target))

    pairs.sort(key=lambda t: len(t[1]), reverse=True)
    out = text
    for cat, schema, target in pairs:
        out = out.replace("`%s`.`%s`" % (cat, schema), "`%s`.`%s`" % (target, schema))
    return out


def split_sql(text):
    """Split a SQL script into individual statements on top-level ';'."""
    stmts = []
    buf = []
    i = 0
    n = len(text)
    in_line_comment = False
    in_block_comment = False
    in_squote = False
    in_btick = False
    in_dollar = False
    while i < n:
        c = text[i]
        nxt = text[i + 1] if i + 1 < n else ''
        if in_line_comment:
            if c == '\n':
                in_line_comment = False
                buf.append(c)
            i += 1
            continue
        if in_block_comment:
            if c == '*' and nxt == '/':
                in_block_comment = False
                i += 2
                continue
            i += 1
            continue
        if in_dollar:
            if c == '$' and nxt == '$':
                buf.append('$$')
                in_dollar = False
                i += 2
                continue
            buf.append(c)
            i += 1
            continue
        if in_squote:
            buf.append(c)
            if c == "'":
                if nxt == "'":
                    buf.append(nxt)
                    i += 2
                    continue
                in_squote = False
            i += 1
            continue
        if in_btick:
            buf.append(c)
            if c == '`':
                in_btick = False
            i += 1
            continue
        if c == '-' and nxt == '-':
            in_line_comment = True
            i += 2
            continue
        if c == '/' and nxt == '*':
            in_block_comment = True
            i += 2
            continue
        if c == '$' and nxt == '$':
            in_dollar = True
            buf.append('$$')
            i += 2
            continue
        if c == "'":
            in_squote = True
            buf.append(c)
            i += 1
            continue
        if c == '`':
            in_btick = True
            buf.append(c)
            i += 1
            continue
        if c == ';':
            stmt = ''.join(buf).strip()
            if stmt:
                stmts.append(stmt)
            buf = []
            i += 1
            continue
        buf.append(c)
        i += 1
    tail = ''.join(buf).strip()
    if tail:
        stmts.append(tail)
    return stmts


def detect_catalog_token(catalogs_sql):
    m = re.search(r"CREATE\s+CATALOG\s+(?:IF\s+NOT\s+EXISTS\s+)?`([^`]+)`",
                  catalogs_sql, re.IGNORECASE)
    return m.group(1) if m else None


def rewrite_catalog(text, src_token, dst_token):
    if not src_token or src_token == dst_token:
        return text
    return text.replace("`%s`" % src_token, "`%s`" % dst_token)


def categorize(stmt):
    u = re.sub(r"\s+", " ", stmt).strip().upper()
    if u.startswith("CREATE CATALOG"):
        return "catalog"
    if u.startswith("CREATE DATABASE") or u.startswith("CREATE SCHEMA"):
        return "schema"
    if u.startswith("CREATE OR REPLACE TABLE") or u.startswith("CREATE TABLE") \
            or u.startswith("CREATE EXTERNAL TABLE"):
        return "table"
    if "ADD CONSTRAINT" in u and "FOREIGN KEY" in u:
        return "fk"
    if "SET TAGS" in u or "UNSET TAGS" in u:
        return "tag"
    if ("CREATE OR REPLACE VIEW" in u or u.startswith("CREATE VIEW")
            or "CREATE MATERIALIZED VIEW" in u):
        return "metric"
    return "other"


_TARGET_RE = re.compile(
    r"ALTER\s+(?:TABLE|SCHEMA|VIEW|MATERIALIZED\s+VIEW)\s+(`[^`]+`(?:\.`[^`]+`){0,2})",
    re.IGNORECASE)


def target_key(stmt):
    m = _TARGET_RE.search(stmt)
    if not m:
        return ""
    parts = m.group(1).split("`.`")
    cleaned = [p.strip("`") for p in parts]
    return ".".join(cleaned)


def build_batches(statements, batch_size, group_by_target=False):
    if not group_by_target:
        return [statements[i:i + batch_size]
                for i in range(0, len(statements), batch_size)]
    groups = OrderedDict()
    for s in statements:
        k = target_key(s)
        groups.setdefault(k, []).append(s)
    return [g for g in groups.values()]


_SET_TAGS_RE = re.compile(
    r"^(?P<prefix>.*?\bSET\s+TAGS\s*\()(?P<body>.*)\)\s*$",
    re.IGNORECASE | re.DOTALL)


def merge_tag_statements(tag_stmts):
    merged = OrderedDict()
    passthrough = []
    for s in tag_stmts:
        m = _SET_TAGS_RE.match(s.strip())
        if not m:
            passthrough.append(s)
            continue
        prefix = re.sub(r"\s+", " ", m.group("prefix")).strip()
        body = m.group("body").strip()
        merged.setdefault(prefix, []).append(body)
    out = ["%s%s)" % (prefix, ", ".join(bodies)) for prefix, bodies in merged.items()]
    return out + passthrough


def build_layout_context(raw_by_name, src_token, base_catalog, cataloging_style,
                         catalog_prefix="", catalog_suffix=""):
    """Compute schema catalog map + target catalog list for an install run."""
    style = normalize_cataloging_style(cataloging_style)
    resolver = CatalogResolver(style, base_catalog, catalog_prefix, catalog_suffix)
    schema_meta = collect_schema_metadata(raw_by_name, src_token)
    schema_map = build_schema_catalog_map(schema_meta, resolver, src_token, base_catalog)
    targets = target_catalogs_for_layout(schema_map, base_catalog, style)
    return {
        "style": style,
        "resolver": resolver,
        "schema_meta": schema_meta,
        "schema_catalog_map": schema_map,
        "target_catalogs": targets,
    }


def rewrite_model_sql(raw_text, src_token, layout_ctx):
    """Rewrite one SQL file for the chosen cataloging layout."""
    base = layout_ctx["schema_catalog_map"].get("_metrics") or layout_ctx["target_catalogs"][0]
    if layout_ctx["style"] == "one_catalog":
        return rewrite_catalog(raw_text, src_token, base)
    return rewrite_catalog_layout(raw_text, src_token, layout_ctx["schema_catalog_map"], base)


def filter_catalog_statements(stmts, layout_ctx):
    """Drop source CREATE CATALOG statements when layout creates catalogs at install time."""
    if layout_ctx["style"] == "one_catalog":
        return stmts
    return [s for s in stmts if categorize(s) != "catalog"]
