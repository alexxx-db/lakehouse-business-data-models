import copy
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

    def info(self, msg, *args, **kwargs):
        self.info_msgs.append(str(msg))

    def warning(self, msg, *args, **kwargs):
        self.warn_msgs.append(str(msg))

    def error(self, msg, *args, **kwargs):
        self.error_msgs.append(str(msg))


def _exec_v251_namespace():
    return dict(vars(ah))


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


def _connect_spec(vid, table, column, fk_target):
    return vs.spec(vid, "add_column", [table], columns=[{"name": column, "type": "BIGINT"}], fk_target=fk_target)


PRIORITY_1 = "**PRIORITY 1 — connect_table: sales.invoice** — add column order_id (BIGINT) with FK to sales.order.order_id"


def test_v251_version_and_aliases_present():
    m = re.search(r'__AGENT_VERSION__\s*=\s*"([^"]+)"', SRC)
    assert m, "__AGENT_VERSION__ not found"
    # The v251 aliases must survive forward; the version moves on (>= 2.5.2,
    # single-digit semver per CLAUDE.md 3a). Do not pin an exact stale value.
    parts = tuple(int(x) for x in m.group(1).split("."))
    assert parts >= (2, 5, 2), f"expected >= 2.5.2, got {m.group(1)}"
    assert all(0 <= p <= 9 for p in parts), f"semver segments single-digit: {m.group(1)}"
    for marker in [
        "v251-vov-target-prevalidate FIRED",
        "v251-rename-atomic FIRED",
        "v251-vov-pass1-deterministic FIRED",
        "v251-vov-budget-exceeded FIRED",
    ]:
        assert marker in SRC


def test_v251_prevalidate_rejects_missing_target_and_fk():
    ns = _exec_v251_namespace()
    parse_details = ns["_v251_parse_priority_details"]
    prevalidate = ns["_v251_prevalidate_priority"]

    model = {
        "model": {
            "domains": [
                {
                    "name": "sales",
                    "products": [
                        {
                            "name": "order",
                            "attributes": [{"name": "order_id", "type": "BIGINT"}],
                        }
                    ],
                }
            ]
        }
    }
    vs.register(ah, model,
                _connect_spec("P001", "sales.invoice", "order_id", "sales.order.order_id"),
                _connect_spec("P002", "sales.order", "invoice_id", "sales.invoice.invoice_id"),
                _connect_spec("P003", "sales.order", "parent_order_id", "sales.order.order_id"))

    p_missing_product = {
        "priority_id": 1,
        "vreq_id": "P001",
        "action": "connect_table",
        "target": "sales.invoice",
        "reason": "add column order_id (BIGINT) with FK to sales.order.order_id",
    }
    ok1, reason1 = prevalidate(p_missing_product, model, parse_details(p_missing_product))
    assert ok1 is False
    assert reason1 == "target-domain-product-missing"

    p_missing_fk = {
        "priority_id": 2,
        "vreq_id": "P002",
        "action": "connect_table",
        "target": "sales.order",
        "reason": "add column invoice_id (BIGINT) with FK to sales.invoice.invoice_id",
    }
    details = parse_details(p_missing_fk)
    assert (details["column"], details["fk_target"]) == ("invoice_id", "sales.invoice.invoice_id")
    ok2, reason2 = prevalidate(p_missing_fk, model, details)
    assert ok2 is False
    assert reason2 == "fk-target-missing"

    p_resolvable = dict(p_missing_fk, priority_id=3, vreq_id="P003")
    assert prevalidate(p_resolvable, model, parse_details(p_resolvable)) == (True, "")


def test_v251_atomic_rename_product_updates_fks_and_drops_old():
    ns = _exec_v251_namespace()
    parse_details = ns["_v251_parse_priority_details"]
    apply_det = ns["_v251_apply_priority_deterministic"]
    logger = _ListLogger()

    model = {
        "model": {
            "domains": [
                {
                    "name": "store",
                    "products": [
                        {"name": "store_cluster", "attributes": [{"name": "store_cluster_id", "type": "BIGINT"}]},
                        {"name": "cluster", "attributes": [{"name": "cluster_id", "type": "BIGINT"}]},
                        {
                            "name": "planogram",
                            "attributes": [
                                {
                                    "name": "store_cluster_id",
                                    "type": "BIGINT",
                                    "foreign_key_to": "store.store_cluster.store_cluster_id",
                                }
                            ],
                        },
                    ],
                }
            ]
        }
    }
    vs.register(ah, model, vs.spec("P004", "rename_product", ["store.store_cluster"], new_name="cluster"),
                vs.spec("P005", "rename_product", ["store.store_cluster"], new_name="cluster because duplicate"))
    misread = {"priority_id": 5, "vreq_id": "P005", "action": "rename_product", "target": "store.store_cluster",
               "reason": "rename to cluster because duplicate"}
    before = copy.deepcopy(model)
    assert ah.vreq_spec("P005")["interpretable"] is False
    assert apply_det(misread, parse_details(misread), model, logger) == (False, "rename-new-name-missing")
    assert model == before

    priority = {
        "priority_id": 4,
        "vreq_id": "P004",
        "action": "rename_product",
        "target": "store.store_cluster",
        "reason": "rename to cluster because duplicate",
    }
    ok, diag = apply_det(priority, parse_details(priority), model, logger)
    assert ok is True
    assert diag == "applied"

    products = model["model"]["domains"][0]["products"]
    names = [p["name"] for p in products]
    assert "store_cluster" not in names
    assert "cluster" in names
    planogram_fk = products[-1]["attributes"][0]["foreign_key_to"]
    assert planogram_fk.startswith("store.cluster.")


def test_v251_atomic_rename_attribute_updates_foreign_keys():
    ns = _exec_v251_namespace()
    parse_details = ns["_v251_parse_priority_details"]
    apply_det = ns["_v251_apply_priority_deterministic"]

    model = {
        "model": {
            "domains": [
                {
                    "name": "inventory",
                    "products": [
                        {
                            "name": "shrinkage_event",
                            "attributes": [{"name": "shared_employee_id", "type": "BIGINT"}],
                        },
                        {
                            "name": "approval",
                            "attributes": [
                                {
                                    "name": "actor_id",
                                    "type": "BIGINT",
                                    "foreign_key_to": "inventory.shrinkage_event.shared_employee_id",
                                }
                            ],
                        },
                    ],
                }
            ]
        }
    }
    vs.register(ah, model,
                vs.spec("P028", "rename_column", ["inventory.shrinkage_event.shared_employee_id"], new_name="approver_employee_id"),
                vs.spec("P029", "rename_column", ["inventory.shrinkage_event.shared_employee_id"], new_name="approver employee id"))
    misread = {"priority_id": 29, "vreq_id": "P029", "action": "rename_attribute", "target": "inventory.shrinkage_event",
               "reason": "rename column shared_employee_id to approver employee id"}
    before = copy.deepcopy(model)
    assert apply_det(misread, parse_details(misread), model, _ListLogger()) == (False, "rename-names-missing")
    assert model == before

    priority = {
        "priority_id": 28,
        "vreq_id": "P028",
        "action": "rename_attribute",
        "target": "inventory.shrinkage_event",
        "reason": "rename column shared_employee_id to approver_employee_id",
    }
    ok, diag = apply_det(priority, parse_details(priority), model, _ListLogger())
    assert ok is True
    assert diag == "applied"

    attrs = model["model"]["domains"][0]["products"][0]["attributes"]
    attr_names = [a["name"] for a in attrs]
    assert "shared_employee_id" not in attr_names
    assert "approver_employee_id" in attr_names
    fk = model["model"]["domains"][0]["products"][1]["attributes"][0]["foreign_key_to"]
    assert fk == "inventory.shrinkage_event.approver_employee_id"


def test_v251_pass1_applies_resolved_and_requeues_unresolvable():
    ns = _exec_v251_namespace()
    apply_pass1 = ns["_v251_apply_pass1_priorities"]

    model = _sales_model()
    vs.register(ah, model,
                _connect_spec("P001", "sales.invoice", "order_id", "sales.order.order_id"),
                _connect_spec("P002", "sales.payment", "invoice_id", "sales.invoice.invoice_id"))
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
            "target": "sales.payment",
            "reason": "add column invoice_id (BIGINT) with FK to sales.invoice.invoice_id",
        },
    ]

    logger = _ListLogger()
    updated, outcomes, residual = apply_pass1(priorities, model, logger)
    assert updated is model
    assert [(o.batch_id, o.status) for o in outcomes] == [("P001", "applied")]
    assert [p["vreq_id"] for p in residual] == ["P002"]
    invoice = model["model"]["domains"][0]["products"][1]["attributes"]
    assert [(a["name"], a.get("foreign_key_to")) for a in invoice if a["name"] == "order_id"] == [("order_id", "sales.order.order_id")]
    assert any("v251-vov-target-prevalidate FIRED" in m and "reason=target-domain-product-missing" in m for m in logger.warn_msgs)
    assert any("v251-vov-pass1-deterministic FIRED" in m for m in logger.info_msgs)


def test_v251_run_pipeline_uses_deterministic_first_without_llm_batches(monkeypatch):
    called = {"batch_vreqs": 0}

    def _batch_vreqs(*args, **kwargs):
        called["batch_vreqs"] += 1
        return []

    monkeypatch.setitem(ah.__dict__, "batch_vreqs", _batch_vreqs)
    llm = vs.SpecOnlyLLM([_connect_spec("P001", "sales.invoice", "order_id", "sales.order.order_id")])
    result = ah.run_vov_pipeline(PRIORITY_1, _sales_model(), llm=llm, user_pinned_domains=(), user_pinned_products=(), parallel=False)
    assert called["batch_vreqs"] == 0
    assert result.coverage_pct == 100.0
    assert [o.status for o in result.outcomes if "P001" in o.vreq_ids] == ["applied"]
    assert len(llm.prompts) == 1 and vs.is_classifier_call(*llm.prompts[0])
    invoice = result.final_model["model"]["domains"][0]["products"][1]["attributes"]
    assert any(a["name"] == "order_id" and a.get("foreign_key_to") == "sales.order.order_id" for a in invoice)


def test_v251_run_pipeline_reapplies_missing_priorities_for_configured_loops(monkeypatch):
    calls = {"pass1": 0, "batch_vreqs": 0}

    def _fake_pass1(priorities, model, logger):
        calls["pass1"] += 1
        out = []
        for p in priorities:
            vid = str(p.get("vreq_id") or f"P{int(p.get('priority_id') or 0):03d}")
            out.append(ah.VReqOutcome(batch_id=vid, vreq_ids=(vid,), status="skipped_unsafe", diagnostic="forced-miss", attempts=1))
        return model, out, []

    def _batch_vreqs(*args, **kwargs):
        calls["batch_vreqs"] += 1
        return []

    monkeypatch.setitem(ah.__dict__, "_v251_apply_pass1_priorities", _fake_pass1)
    monkeypatch.setitem(ah.__dict__, "batch_vreqs", _batch_vreqs)
    llm = vs.SpecOnlyLLM([_connect_spec("P001", "sales.invoice", "order_id", "sales.order.order_id")])
    result = ah.run_vov_pipeline(
        PRIORITY_1,
        _sales_model(),
        llm=llm,
        user_pinned_domains=(),
        user_pinned_products=(),
        parallel=False,
        priority_reapply_loops=3,
    )
    # v260 STALE-BREAK: when a reapply iteration makes ZERO progress (every
    # priority still skipped_unsafe), the agentic loop breaks early instead of
    # burning the remaining configured loops on a permanently-failing priority.
    # So pass1 is invoked at least twice (initial + >=1 reapply) but may stop
    # before exhausting all 3 loops. The contract is: it DID reapply, and the
    # residual priority is reported unfulfilled.
    assert 2 <= calls["pass1"] <= 3, f"expected 2-3 reapply invocations, got {calls['pass1']}"
    assert calls["batch_vreqs"] == 0
    assert any(o.status == "agentic_loop_unfulfilled" for o in result.outcomes)


def test_v251_apply_handler_stops_on_budget():
    ns = _exec_v251_namespace()
    fn = ns["_apply_handler_with_retry"]

    handler = SimpleNamespace(batch_id="b1", mutator_src="x", verifier_src="y", expected_changes_summary="")
    batch = SimpleNamespace(batch_id="b1", vreq_ids=("P001",), data_payload=())
    new_model, outcome = fn(
        handler,
        batch,
        {},
        invariants=None,
        llm=None,
        max_retries=3,
        pinned_domains=(),
        pinned_products=(),
        max_elapsed_s=-1.0,
    )
    assert new_model is None
    assert outcome.status == "time_budget_exceeded"
    assert "time-budget-exceeded" in outcome.diagnostic
