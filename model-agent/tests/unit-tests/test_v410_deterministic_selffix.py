import ast
import copy
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

NB_PATH = Path(__file__).resolve().parents[2] / "agent" / "dbx_vibe_modelling_agent.ipynb"

# Function-name prefixes the deterministic SelfFixer fallback (v4.1.0) depends on. We extract every
# top-level def with these prefixes from the notebook and exec them into one namespace so the
# behavioral tests exercise the REAL production code path (no stubs), per CLAUDE.md §8.10.
_PREFIXES = ("_v410_", "_v251_", "_v337_", "_v327_")


def _build_ns():
    src = "\n".join(
        "".join(c.get("source", []))
        for c in json.loads(NB_PATH.read_text()).get("cells", [])
        if c.get("cell_type") == "code"
    )
    tree = ast.parse(src)
    keep = [n for n in tree.body if isinstance(n, ast.FunctionDef) and n.name.startswith(_PREFIXES)]
    mod = ast.Module(body=keep, type_ignores=[])
    ast.fix_missing_locations(mod)
    ns = dict(vars(ah), re=__import__("re"), copy=__import__("copy"))
    exec(compile(mod, str(NB_PATH), "exec"), ns)
    return ns


class _L:
    def info(self, *a, **k):
        pass

    def warning(self, *a, **k):
        pass


def _model():
    return {
        "model": {
            "domains": [
                {"name": "experience", "products": [
                    {"name": "program", "primary_key": "program_id",
                     "attributes": [{"name": "program_id", "type": "BIGINT"}]}
                ]},
                {"name": "property", "products": [
                    {"name": "property", "primary_key": "property_id",
                     "attributes": [{"name": "property_id", "type": "BIGINT"}]}
                ]},
                {"name": "reservation", "products": [
                    {"name": "reservation_booking", "primary_key": "reservation_booking_id",
                     "attributes": [{"name": "reservation_booking_id", "type": "BIGINT"},
                                    {"name": "room_type_requested", "type": "STRING"}]}
                ]},
                {"name": "inventory", "products": [
                    {"name": "room_type", "primary_key": "room_type_id",
                     "attributes": [{"name": "room_type_id", "type": "BIGINT"}]}
                ]},
                {"name": "procurement", "products": [
                    {"name": "benefit_plan", "primary_key": "benefit_plan_id",
                     "attributes": [{"name": "benefit_plan_id", "type": "BIGINT"}]}
                ]},
                {"name": "workforce", "products": [
                    {"name": "employee", "primary_key": "employee_id",
                     "attributes": [{"name": "employee_id", "type": "BIGINT"}]}
                ]},
            ]
        }
    }


def _attr(model, dom, prod, col):
    for d in model["model"]["domains"]:
        if d["name"] != dom:
            continue
        for p in d.get("products", []):
            if p["name"] != prod:
                continue
            for a in p.get("attributes", []):
                if a.get("name") == col:
                    return a
    return None


def _selffix(model, spec):
    vs.register(ah, model, spec)
    return ah._v410_deterministic_selffix(model, {"id": spec["id"]}, _L())


def test_v410_fix_functions_exist():
    ns = _build_ns()
    for fn in ("_v410_resolve_pk", "_v410_deterministic_selffix", "_vreq_spec_det_ops"):
        assert fn in ns, fn
    assert "_v410_parse_req_to_action" not in ns, "the fast path reads the requirement spec, never the requirement text"


def test_v410_connect_table_adds_fk_deterministically():
    model = _model()
    assert _attr(model, "experience", "program", "property_id") is None
    ok, ev = _selffix(model, vs.spec("VREQ-031", "add_column", ["experience.program"], columns=[{"name": "property_id", "type": "BIGINT"}],
                                     fk_target="property.property.property_id"))
    assert ok is True, ev
    a = _attr(model, "experience", "program", "property_id")
    assert a is not None and a.get("foreign_key_to") == "property.property.property_id", a


def test_v410_two_part_fk_resolves_pk_and_links():
    model = _model()
    ok, ev = _selffix(model, vs.spec("VREQ-023", "add_fk", ["reservation.reservation_booking.room_type_requested"], fk_target="inventory.room_type"))
    assert ok is True, ev
    a = _attr(model, "reservation", "reservation_booking", "room_type_requested")
    assert a is not None and a.get("foreign_key_to") == "inventory.room_type.room_type_id", a


def test_v410_move_product_relocates_deterministically():
    model = _model()
    ok, ev = _selffix(model, vs.spec("VREQ-046", "move_product", ["procurement.benefit_plan"], destination_domain="workforce"))
    assert ok is True, ev
    proc = [d for d in model["model"]["domains"] if d["name"] == "procurement"][0]
    work = [d for d in model["model"]["domains"] if d["name"] == "workforce"][0]
    assert all(p["name"] != "benefit_plan" for p in proc.get("products", [])), "still in source"
    assert any(p["name"] == "benefit_plan" for p in work.get("products", [])), "not in target"


def test_v410_generative_req_returns_none_stays_on_llm():
    model = _model()
    before = copy.deepcopy(model)
    assert _selffix(model, vs.spec("VREQ-047", "other", ["reservation.reservation_booking"])) == (None, "no_deterministic_action")
    assert _selffix(model, vs.spec("VREQ-048", "set_fields", ["reservation.reservation_booking"],
                                   fields=[vs.field("attributes", "description")])) == (None, "no_deterministic_action")
    assert ah._v410_deterministic_selffix(model, {"id": "VREQ-049"}, _L()) == (None, "no_deterministic_action")
    assert model == before


def test_v410_unresolvable_target_returns_none():
    model = _model()
    before = copy.deepcopy(model)
    ok, ev = _selffix(model, vs.spec("VREQ-050", "add_column", ["ghost.missing"], columns=[{"name": "property_id", "type": "BIGINT"}],
                                     fk_target="property.property.property_id"))
    assert ok is None and ev == "add_fk_apply_failed", ev
    assert model == before


def test_v410_resolve_pk_prefers_declared_then_id_suffix():
    ns = _build_ns()
    model = _model()
    assert ns["_v410_resolve_pk"](model, "inventory", "room_type") == "room_type_id"
