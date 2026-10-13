import json, os, re, sys, textwrap, pytest

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vreq_spec_util as vs  # noqa: E402

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
NB = os.path.join(REPO, "agent", "dbx_vibe_modelling_agent.ipynb")


def _cells():
    nb = json.load(open(NB))
    return [
        "".join(c.get("source", [])) if isinstance(c.get("source"), list) else c.get("source", "")
        for c in nb["cells"] if c.get("cell_type") == "code"
    ]


def _full_src():
    return "\n".join(_cells())


def _extract_nested_fn(src, name):
    m = re.search(rf"\n( +)def {name}\(.*?\n\1    return \"\"\n", src, re.S)
    assert m, f"{name} not found as nested fn"
    return textwrap.dedent(m.group(0))


# ---------------------------------------------------------------------------
# FIX-A: vibe-enumerated-product-cap-floor — deterministic per-domain floor
# Root cause (gov_transport 38.1%): max_data_products_per_domain=16 trimmed the user's
# 43 verbatim HR products. The floor helper must derive 43 from the products the LLM
# requirement specs add to each user-named domain (v5.3.3: no checklist text is read).
# ---------------------------------------------------------------------------
def _register(*specs):
    vs.register(ah, {"model": {"domains": []}}, *specs)


def test_fixA_cap_floor_derives_enumerated_count():
    _register(vs.spec("VREQ-001", "add_product", [f"hr.hr_prod_{i}" for i in range(43)]),
              vs.spec("VREQ-002", "add_product", [f"project.proj_prod_{i}" for i in range(21)]),
              vs.spec("VREQ-003", "add_product", [f"finance.fin_prod_{i}" for i in range(60)]),
              vs.spec("VREQ-004", "add_product", [f"hr.unread_{i}" for i in range(90)], interpretable=False, reason="unclear"))
    floor, counts = ah._enumerated_product_cap_floor(["hr", "project"])
    assert counts == {"hr": 43, "project": 21}, counts
    assert floor == 43, floor


def test_fixA_cap_floor_none_when_no_enumeration():
    assert ah._enumerated_product_cap_floor(["hr"]) == (None, {})
    _register(vs.spec("VREQ-001", "set_fields", ["hr"], breadth="set", fields=[vs.field("products", "description")]))
    floor, counts = ah._enumerated_product_cap_floor(["hr"])
    assert floor is None and counts == {}


def test_fixA_wired_to_validated_params():
    # the helper output must FORCE validated_params[max_data_products_per_domain]
    src = "\n".join(c for c in _cells() if "_epc_floor" in c)
    assert "_enumerated_product_cap_floor(" in src
    assert 'validated_params["max_data_products_per_domain"] = _epc_floor' in src


# ---------------------------------------------------------------------------
# FIX-B: verifier-declared-context-recursive — surface NESTED declared context.
# Root cause: RC5 read business_context_data with a flat .get(); runtime stores
# it nested -> empty -> model-scope declare VREQs false-failed. The recursive
# finder must succeed on a nested dict where a flat .get() returns "".
# ---------------------------------------------------------------------------
def _bind_find():
    src = None
    for c in _cells():
        if "def _v340_find(" in c:
            src = c
            break
    assert src is not None
    ns = {}
    exec(_extract_nested_fn(src, "_v340_find"), ns)
    return ns["_v340_find"]


def test_fixB_recursive_find_nested_beats_flat_get():
    find = _bind_find()
    nested = {"business_information": {"operational_systems_of_records": "SAP, DCH, Beacon"}}
    # pre-patch behavior (flat get) would fail:
    assert nested.get("operational_systems_of_records", "") == ""
    # post-patch recursive finder succeeds:
    assert find(nested, "operational_systems_of_records") == "SAP, DCH, Beacon"


def test_fixB_recursive_find_flat_list_and_missing():
    find = _bind_find()
    assert find({"industry_governing_body": "PCI, OWASP"}, "industry_governing_body") == "PCI, OWASP"
    assert find({"common_business_jargons": ["doh", "dmv"]}, "common_business_jargons") == "doh, dmv"
    assert find({"x": {"y": {}}}, "operational_systems_of_records") == ""


def test_fixB_surfaces_three_context_kinds():
    src = "\n".join(c for c in _cells() if "verifier-declared-context-recursive" in c)
    assert "DECLARED OPERATIONAL SYSTEMS OF RECORD" in src
    assert "DECLARED INDUSTRY GOVERNING BODIES" in src
    assert "DECLARED BUSINESS JARGON" in src
    assert "_v100_summary_lines.append" in src


# ---------------------------------------------------------------------------
# FIX-C: selffixer-endpoint-resolve — revive dead agentic loop. Root cause:
# SelfFixer.__init__ only tried thinker/large; envs without a thinker model
# left endpoint=None (24 inert LLM calls). Must cascade worker/large + scan
# enabled models and build endpoint from name when llm_endpoint_name absent.
# ---------------------------------------------------------------------------
def test_fixC_selffixer_cascade_present():
    src = None
    for c in _cells():
        if "selffixer-endpoint-resolve" in c:
            src = c
            break
    assert src is not None
    assert '("thinker", "large"), ("worker", "large")' in src
    assert "scan-enabled" in src
    assert '"databricks-" + _n' in src  # build endpoint from name
    assert "self.llm_endpoint = llm_endpoint" in src


def test_version_is_340():
    m = re.search(r'__AGENT_VERSION__\s*=\s*"([^"]+)"', _full_src())
    assert m and tuple(int(x) for x in m.group(1).split(".")) >= (3, 4, 0), m.group(1) if m else None
