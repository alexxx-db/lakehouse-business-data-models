"""v3.3.2 — verifier metadata-blindness fix.

ROOT CAUSE (live gov_transport mvm_v8 run <run_id>): the per-VREQ verifier snapshot
exposed ONLY products + attributes. It omitted TAGS, METRIC VIEWS and the CATALOG name,
so the LLM verifier (and its deterministic-blind fallback) reported "No tags present",
"Metric view absent" and "no catalog reference" for a model that actually carried 785
tagged attributes / 6 metric views / a real catalog. Separately, remove_fk was verified
at TABLE level: removing one column's FK while the table kept other legitimate FKs always
scored FAILED. Together these produced 16 confirmed false-FAILs that dragged measured
precision to 39.7% on an otherwise healthy 92/100 model.

Fixes (this file proves each against the EXACT deployed block, failing on pre-patch HEAD):
  A. verifier-snapshot-metadata: untruncatable TAG / METRIC-VIEW / CATALOG inventories.
  B. verifier-relation-remove-column: column-scoped remove_fk verification. v5.3.3: the LLM spec names
     the columns, and _verify_from_spec checks each named column (or, once dropped, its FK before).
"""
import json
import logging
import os
import sys
import textwrap
import types

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

NB = os.path.join(os.path.dirname(__file__), "..", "..", "agent", "dbx_vibe_modelling_agent.ipynb")


def _load_src():
    nb = json.load(open(NB))
    return "".join("".join(c.get("source", [])) for c in nb["cells"] if c.get("cell_type") == "code")


def _slice(src, start, end):
    i = src.index(start)
    j = src.index(end, i + len(start))
    return src[i:j]


# ---------------- FIX A: snapshot metadata inventories ----------------

def _run_metadata_block(attributes_data, metric_views, catalog):
    src = _load_src()
    block = _slice(src, "            _v332_tag_counts = {}\n",
                   "            _v100_attrs_by_pk = {}\n")
    block = textwrap.dedent(block)
    _self = types.SimpleNamespace(
        logger=logging.getLogger("v332test"),
        widgets_values={"metric_views": metric_views, "catalog": catalog},
    )
    ns = {"attributes_data": attributes_data,
          "_v100_summary_lines": ["# Model snapshot (post-mutation)"],
          "self": _self}
    exec(block, ns, ns)
    return "\n".join(ns["_v100_summary_lines"])


def test_tag_inventory_surfaced():
    attrs = [
        {"domain": "hr", "product": "employee", "attribute": "employee_id",
         "tags": "primary_key,confidential,pii,gov_transport_cde=CDE-26"},
        {"domain": "hr", "product": "employee", "attribute": "division_id", "tags": "foreign_key"},
        {"domain": "hr", "product": "employee", "attribute": "name", "tags": ""},
    ]
    snap = _run_metadata_block(attrs, [], "")
    assert "TAG INVENTORY" in snap, snap
    # 2 of 3 attrs carry tags; distinct keys include pii + confidential
    assert "2 attribute(s) carry tags" in snap, snap
    assert "pii" in snap and "confidential" in snap, snap


def test_metric_view_inventory_surfaced():
    mvs = [{"name": "Vacancy Rate"}, {"name": "Retirement Eligibility"}, {"name": "Total Positions"}]
    snap = _run_metadata_block([], mvs, "")
    assert "METRIC-VIEW INVENTORY" in snap, snap
    assert "3 metric view(s)" in snap, snap
    assert "Vacancy Rate" in snap and "Total Positions" in snap, snap


def test_catalog_surfaced():
    snap = _run_metadata_block([], [], "gov_transport_v1")
    assert "CATALOG (authoritative): gov_transport_v1" in snap, snap


def test_metadata_absent_when_model_has_none():
    # No tags / no MVs / no catalog -> none of the inventory headers appear (no false claims).
    snap = _run_metadata_block([{"domain": "d", "product": "p", "attribute": "a", "tags": ""}], [], "")
    assert "TAG INVENTORY" not in snap
    assert "METRIC-VIEW INVENTORY" not in snap
    assert "CATALOG (authoritative)" not in snap


# ---------------- FIX B: column-level remove_fk verification ----------------

_GROUP = ("project", "dsctr_category_group")
_LINKED = {"domain": "project", "product": "dsctr_category_group", "attribute": "pse_user_id", "foreign_key_to": "hr.pse_user.id"}
_OTHERS = [{"domain": "project", "product": "dsctr_category_group", "attribute": f"other_{i}_id", "foreign_key_to": f"project.x{i}.id"}
           for i in range(7)]


def _remove_fk_verdict(read_against, live):
    def _products(rows):
        return [{"domain": d, "product": p} for d, p in dict.fromkeys((r["domain"], r["product"]) for r in rows)] or [
            {"domain": _GROUP[0], "product": _GROUP[1]}]
    model = ah.widgets_flat_to_model([{"domain": "project"}], _products(read_against), [dict(r) for r in read_against])
    vs.register(ah, model, vs.spec("VREQ-009", "remove_fk", ["project.dsctr_category_group.pse_user_id"]))
    return ah._verify_from_spec(ah.vreq_spec("VREQ-009"), [{"domain": "project"}], _products(live), live)


def test_remove_fk_column_level_fulfilled_when_named_column_removed():
    res = _remove_fk_verdict(_OTHERS + [_LINKED], _OTHERS)
    assert res["status"] == "fulfilled" and "1/1 foreign key(s) removed" in res["evidence"], res
    res = _remove_fk_verdict(_OTHERS + [_LINKED], _OTHERS + [dict(_LINKED, foreign_key_to="")])
    assert res["status"] == "fulfilled", res
    res = _remove_fk_verdict(_OTHERS + [_LINKED], _OTHERS + [dict(_LINKED, attribute="pse_user_ref")])
    assert res["status"] == "failed", res


def test_remove_fk_column_level_failed_when_named_column_still_linked():
    res = _remove_fk_verdict([_LINKED], [_LINKED])
    assert res["status"] == "failed" and "0/1 foreign key(s) removed" in res["evidence"], res


# ---------------- static contracts ----------------

def test_version_is_332():
    import re as _re
    m = _re.search(r'__AGENT_VERSION__\s*=\s*"(\d+)\.(\d+)\.(\d+)"', _load_src())
    assert m, "version constant not found"
    assert tuple(int(x) for x in m.groups()) >= (3, 3, 2), m.groups()


def test_aliases_present():
    src = _load_src()
    for a in ("verifier-snapshot-metadata", "alias=verifier-spec"):
        assert a in src, a
    assert "AUTHORITATIVE TAGS/METRIC-VIEWS/CATALOG" in src
