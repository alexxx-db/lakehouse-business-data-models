"""Behavioral tests for v2.7.1 — the two precision fixes that lifted gov_transport VOV
adherence past the 0.85 fidelity gate (v270 ceiling was 0.804):

  FIX 1 [v271-vov-pass1-fixpoint] — `_v251_apply_pass1_priorities` ran a SINGLE
  pass and PERMANENTLY dropped (structural_unresolvable) any connect_table whose
  FK-target attribute did not exist YET, even when a LATER priority creates it.
  96 such ordering drops on the 48-priority gov_transport run. The fix re-attempts
  prevalidate-deferred priorities round-over-round as long as the previous round
  applied >=1 mutation; only a zero-progress round declares the remainder
  genuinely unresolvable.

  FIX 2 [verifier-rename-state] — rename_* requirements carry "tag"/"convention"
  words in original_text and fell through to the tag/pii branch, returning
  "partial: inconclusive" even though the sandbox renamed the column in place.
  The fix verifies the post-rename state: the renamed-TO name must be present.

Both tests exercise the REAL notebook code through agent_helpers with the requirement
spec an LLM would return registered, and assert OBSERVABLE state changes.
"""
import re
import sys
from pathlib import Path
from types import SimpleNamespace

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402
from notebook_source_util import notebook_concat_source  # noqa: E402

SRC = notebook_concat_source()


class _ListLogger:
    def __init__(self):
        self.info_msgs = []
        self.warn_msgs = []
        self.error_msgs = []

    def info(self, msg, *a, **k):
        self.info_msgs.append(str(msg))

    def warning(self, msg, *a, **k):
        self.warn_msgs.append(str(msg))

    def error(self, msg, *a, **k):
        self.error_msgs.append(str(msg))


# ---------- version + sentinel contract ----------

def test_version_271_and_aliases_present():
    m = re.search(r'__AGENT_VERSION__\s*=\s*"([^"]+)"', SRC)
    # Relaxed to >= (test_v295 precedent): the v2.7.1 aliases under test persist in
    # later versions; pinning an exact string broke spuriously on every version bump.
    assert m, "version missing"
    assert tuple(int(x) for x in m.group(1).split(".")) >= (2, 7, 1), f"expected >= 2.7.1, got {m.group(1)}"
    assert "v271-vov-pass1-fixpoint FIRED" in SRC
    assert "[verifier-spec FIRED v5.3.3]" in SRC
    assert "verifier-rename-state FIRED" not in SRC


# ---------- FIX 1: fixpoint ordering recovery ----------

def _sales_model():
    return {
        "model": {
            "domains": [
                {
                    "name": "sales",
                    "products": [
                        {"name": "order", "attributes": [{"name": "order_id", "type": "BIGINT"}]},
                        {"name": "invoice", "attributes": [{"name": "invoice_id", "type": "BIGINT"}]},
                    ],
                }
            ]
        }
    }


def _connect(vid, table, column, fk_target):
    return vs.spec(vid, "add_column", [table], columns=[{"name": column, "type": "BIGINT"}], fk_target=fk_target)


def test_fixpoint_recovers_ordering_dependent_priority():
    """P_A connects to an FK target that P_B creates. P_A is ordered FIRST.

    Pre-patch single-pass: P_A -> fk-target-missing -> structural_unresolvable (dropped).
    Post-patch fixpoint: round1 applies P_B (creates the target), round2 applies P_A.
    Both end APPLIED.
    """
    model = _sales_model()
    vs.register(ah, model, _connect("P001", "sales.order", "audit_ref_id", "sales.invoice.audit_id"),
                _connect("P002", "sales.invoice", "audit_id", "sales.order.order_id"))
    priorities = [
        {
            "priority_id": 1,
            "vreq_id": "P001",
            "action": "connect_table",
            "target": "sales.order",
            # FK target sales.invoice.audit_id does NOT exist yet — created by P002 below
            "reason": "add column audit_ref_id (BIGINT) with FK to sales.invoice.audit_id",
        },
        {
            "priority_id": 2,
            "vreq_id": "P002",
            "action": "connect_table",
            "target": "sales.invoice",
            "reason": "add column audit_id (BIGINT) with FK to sales.order.order_id",
        },
    ]
    logger = _ListLogger()
    updated, outcomes, residual = ah._v251_apply_pass1_priorities(priorities, model, logger)
    by_id = {o.batch_id: o for o in outcomes}
    assert by_id["P002"].status == "applied"
    assert by_id["P001"].status == "applied", (
        f"fixpoint should recover ordering-dependent P001, got {by_id['P001'].status}"
    )
    assert residual == []
    # observable model state: P001's column landed on sales.order with the FK resolved
    order_attrs = updated["model"]["domains"][0]["products"][0]["attributes"]
    audit_ref = [a for a in order_attrs if a["name"] == "audit_ref_id"]
    assert audit_ref and audit_ref[0].get("foreign_key_to") == "sales.invoice.audit_id"
    assert any("v271-vov-pass1-fixpoint FIRED" in m for m in logger.info_msgs)


def test_fixpoint_requeues_a_genuinely_unresolvable_priority_to_the_llm_residual():
    """A connect_table to a product that NO priority ever creates is never applied: after a
    zero-progress round it goes to the LLM residual (v3.2.2 vov-prevalidate-requeue), not into the model."""
    model = _sales_model()
    vs.register(ah, model, _connect("P001", "sales.invoice", "order_id", "sales.order.order_id"),
                _connect("P002", "sales.nonexistent_product", "x_id", "sales.invoice.invoice_id"))
    priorities = [
        {
            "priority_id": 1,
            "vreq_id": "P001",
            "action": "connect_table",
            "target": "sales.invoice",
            "reason": "add column order_id (BIGINT) with FK to sales.order.order_id",
        },
        {
            "priority_id": 2,
            "vreq_id": "P002",
            "action": "connect_table",
            "target": "sales.nonexistent_product",  # never created
            "reason": "add column x_id (BIGINT) with FK to sales.invoice.invoice_id",
        },
    ]
    logger = _ListLogger()
    updated, outcomes, residual = ah._v251_apply_pass1_priorities(priorities, model, logger)
    assert [(o.batch_id, o.status) for o in outcomes] == [("P001", "applied")]
    assert [p["vreq_id"] for p in residual] == ["P002"]
    assert [d["name"] for d in updated["model"]["domains"][0]["products"]] == ["order", "invoice"]
    assert any("requeued=1 reason=target-domain-product-missing priority=P2" in m for m in logger.warn_msgs)


# ---------- FIX 2: verifier rename-state ----------

def _verifier():
    orch = object.__new__(ah.VibeOrchestrator)
    orch.logger = _ListLogger()
    orch._step_snapshots = {}
    orch.config = {}
    return orch


def _employee_rows(column):
    domains_data = [{"domain": "hr"}]
    products_data = [{"domain": "hr", "product": "employee", "primary_key": "employee_id"}]
    attributes_data = [
        {"domain": "hr", "product": "employee", "attribute": "employee_id", "type": "BIGINT"},
        {"domain": "hr", "product": "employee", "attribute": column, "type": "STRING"},
    ]
    return domains_data, products_data, attributes_data


def _register_rename(new_name):
    vs.register(ah, ah.widgets_flat_to_model(*_employee_rows("ethnicity")),
                vs.spec("VREQ-024", "rename_column", ["hr.employee.ethnicity"], new_name=new_name))


def test_verifier_rename_attribute_reports_fulfilled_when_new_name_present():
    _register_rename("ethnic_origin")
    req = SimpleNamespace(
        id="VREQ-024",
        scope="attribute",
        scope_targets=["hr.employee.ethnicity"],
        # carries a "tag/glossary" word that used to route it to the tag/pii branch
        original_text="rename column `ethnicity` to `ethnic_origin` and update the glossary tag",
    )
    # post-rename state: the renamed-TO attribute is present (sandbox applied it)
    res = _verifier()._verify_deterministic(req, *_employee_rows("ethnic_origin"))
    assert res["status"] == "fulfilled", f"expected fulfilled, got {res}"
    assert "verifier-spec FIRED" in res["evidence"] and "ethnicity -> ethnic_origin" in res["evidence"]


def test_verifier_rename_does_not_false_fulfill_when_new_name_absent():
    """Conservative: if the renamed-TO name is NOT present, or the LLM read no usable new
    name, the rename must NOT verify as fulfilled."""
    _register_rename("ethnic_origin")
    req = SimpleNamespace(
        id="VREQ-024",
        scope="attribute",
        scope_targets=["hr.employee.ethnicity"],
        original_text="rename column `ethnicity` to `ethnic_origin`",
    )
    # rename NOT applied: old name still present, new name absent
    res = _verifier()._verify_deterministic(req, *_employee_rows("ethnicity"))
    assert res["status"] == "failed", f"must not false-fulfill when new name absent, got {res}"
    ah.vov_ledger_reset()
    _register_rename("ethnic origin and update the glossary tag")
    res = _verifier()._verify_deterministic(req, *_employee_rows("ethnic_origin"))
    assert res["status"] == "failed" and "rename_column names no new name" in res["evidence"], res
