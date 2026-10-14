import json
import logging
from pathlib import Path

import pytest

import agent_helpers as ah
import vreq_spec_util as vs

REPO = Path(__file__).resolve().parents[2]
NB = REPO / "agent" / "dbx_vibe_modelling_agent.ipynb"
PRE = Path("/tmp/agent_pre_v401.ipynb")  # v4.0.0 backup (pre-preskip)


def _concat(nb_path):
    nb = json.load(open(nb_path))
    return "".join("".join(c.get("source", [])) for c in nb["cells"] if c.get("cell_type") == "code")


class _SandboxCalled(AssertionError):
    pass


def _raise_sandbox(*a, **k):
    raise _SandboxCalled("execute_in_sandbox was called — pre-skip did NOT short-circuit")


def _raise_synth(*a, **k):
    raise _SandboxCalled("synthesize_handler was called — pre-skip did NOT short-circuit")


def _model(with_note):
    # inner model dict shape: top-level 'domains' (NOT wrapped in {'model': ...})
    attributes = [{"name": "order_id", "is_primary_key": True, "data_type": "BIGINT"}]
    if with_note:
        attributes.append({"name": "order_note", "data_type": "STRING"})
    return {
        "domains": [
            {
                "name": "sales",
                "data_products": [
                    {
                        "name": "order",
                        "description": "Customer purchase order header.",
                        "attributes": attributes,
                    }
                ],
            }
        ]
    }


NOTE_SPEC = vs.spec("VREQ-1", "add_column", ["sales.order.order_note"], columns=[{"name": "order_note", "type": "STRING"}])


def _batch():
    return ah.Batch(
        batch_id="B1",
        vreq_ids=("VREQ-1",),
        intent_summary="add an order_note column to the order table",
        target_entities=(("sales", "order"),),
        data_payload=(),
    )


def _handler():
    return ah.Handler(
        batch_id="B1",
        mutator_src="def mutator(model, data):\n    return model\n",
        verifier_src="",
        expected_changes_summary="",
        target_entities=(("sales", "order"),),
    )


@pytest.fixture(autouse=True)
def _isolate(monkeypatch):
    # ensure flag on; patch the LLM + sandbox to raise so any fall-through is provable
    monkeypatch.setattr(ah, "_VOV_DETERMINISTIC_PRESKIP_ENABLED", True, raising=False)
    monkeypatch.setattr(ah, "execute_in_sandbox", _raise_sandbox, raising=False)
    monkeypatch.setattr(ah, "synthesize_handler", _raise_synth, raising=False)
    vs.register(ah, {"model": _model(True)}, NOTE_SPEC)
    yield


def _capture_logger(monkeypatch):
    lg = logging.getLogger("v401test")
    lg.setLevel(logging.INFO)
    records = []

    class _Cap(logging.Handler):
        def emit(self, r):
            records.append(r.getMessage())

    lg.handlers = [_Cap()]
    monkeypatch.setattr(ah, "logger", lg, raising=False)
    return records


# ---------------- deterministic probe unit check ----------------

def test_probe_true_when_the_requested_column_is_present():
    ok, ev = ah._vov_deterministic_satisfied(_batch(), _handler(), _model(True))
    assert ok is True, ev
    assert "1/1 table(s) carry" in ev


def test_probe_false_when_the_requested_column_is_missing():
    ok, ev = ah._vov_deterministic_satisfied(_batch(), _handler(), _model(False))
    assert ok is False, ev
    assert "0/1 table(s) carry" in ev


def test_probe_false_for_a_requirement_the_llm_could_not_read():
    vs.register(ah, {"model": _model(True)}, dict(NOTE_SPEC, interpretable=False, reason="names no column"))
    ok, ev = ah._vov_deterministic_satisfied(_batch(), _handler(), _model(True))
    assert ok is False and "no interpretable spec" in ev, ev


# ---------------- behavioral: pre-skip avoids the LLM+sandbox ----------------

def test_preskip_credits_applied_without_calling_llm():
    m = _model(True)
    new_model, outcome = ah._apply_handler_with_retry(_handler(), _batch(), m, None, object())
    assert outcome.status == "applied", outcome
    assert outcome.attempts == 0, outcome
    assert "deterministic pre-skip" in outcome.diagnostic, outcome.diagnostic
    assert new_model is m  # returned the SAME live model unchanged


def test_preskip_emits_fired_log(monkeypatch):
    records = _capture_logger(monkeypatch)
    ah._apply_handler_with_retry(_handler(), _batch(), _model(True), None, object())
    fired = [r for r in records if "vov-deterministic-preskip FIRED v4.0.1" in r]
    assert fired, records


def test_unsatisfied_falls_through_to_llm_sandbox():
    # column missing -> probe False -> pre-skip does NOT fire -> sandbox is invoked (raises sentinel)
    with pytest.raises(_SandboxCalled):
        ah._apply_handler_with_retry(_handler(), _batch(), _model(False), None, object())


def test_killswitch_disables_preskip(monkeypatch):
    monkeypatch.setattr(ah, "_VOV_DETERMINISTIC_PRESKIP_ENABLED", False, raising=False)
    # even though the model IS satisfied, the disabled pre-skip lets it fall through to the sandbox
    with pytest.raises(_SandboxCalled):
        ah._apply_handler_with_retry(_handler(), _batch(), _model(True), None, object())


# ---------------- version + fail-pre ----------------

def test_version_bumped_to_401():
    # Originally pinned the exact literal "4.0.3"; that one-shot snapshot goes stale on every bump.
    # Durable invariant: canonical single-digit-semver version line present (CLAUDE.md 3a) and never
    # regressing below the version this test gated (4.0.3).
    import re
    m = re.search(r'__AGENT_VERSION__\s*=\s*"(\d)\.(\d)\.(\d)"', _concat(NB))
    assert m, "canonical single-digit-semver __AGENT_VERSION__ line missing (CLAUDE.md 3a)"
    assert tuple(int(g) for g in m.groups()) >= (4, 0, 3), f"version {m.group(0)} regressed below 4.0.3"


def test_failpre_preskip_absent_in_v400_backup():
    if not PRE.exists():
        pytest.skip("v4.0.0 backup not present")
    src = _concat(PRE)
    assert "_VOV_DETERMINISTIC_PRESKIP_ENABLED" not in src
    assert "vov-deterministic-preskip FIRED v4.0.1" not in src
