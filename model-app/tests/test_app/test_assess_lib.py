import importlib.util
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2] / "src" / "app" / "vendored" / "assessment"
spec = importlib.util.spec_from_file_location("assess_lib", ROOT / "assess_lib.py")
lib = importlib.util.module_from_spec(spec); spec.loader.exec_module(lib)

CFG = {
    "batch_id": "b1", "domain": "sales_order", "customer": "meridian",
    "vibe_catalog": "manufacturing_mvm_v1", "physical_schema": "sales_order",
    "metamodel_schema": "_metamodel", "metamodel_prefix": "", "model_version": 3,
    "bronze_sources": {"src_sap_sd": "manufacturing_bronze_vibe.sap_sd_mvm"},
    "bronze_catalog": "manufacturing_bronze_vibe", "silver_catalog": "s", "gold_catalog": "g",
    "output_model": "hybrid", "etl_type": "sdp_pipeline", "warehouse_id": "wh",
}


def test_render_conventions_pins_version_and_metamodel():
    y = lib.render_conventions(CFG, run_label="b1")
    assert "  version: 3" in y
    assert '  metamodel_schema: _metamodel' in y
    assert '  metamodel_prefix: ""' in y
    assert "  src_sap_sd: manufacturing_bronze_vibe.sap_sd_mvm" in y
    assert "allow_new_entities: false" in y


def test_progress_writer_is_atomic(tmp_path):
    p = tmp_path / "progress.json"
    w = lib.ProgressWriter(p)
    w.write("rate_limited", attempt=2, rate_limited=True, resume_at=1700000000.0, last_message="x" * 500)
    d = json.loads(p.read_text())
    assert d["stage"] == "rate_limited" and d["attempt"] == 2 and d["rate_limited"] is True
    assert len(d["last_message"]) == 300 and "updated_at" in d
    assert not list(tmp_path.glob("*.tmp"))


def test_classify_attempt_rate_limited_vs_error():
    rl = [{"type": "thread.started", "thread_id": "t1"},
          {"type": "turn.failed", "error": {"message": "HTTP 429 REQUEST_LIMIT_EXCEEDED"}}]
    a = lib.classify_attempt(rl)
    assert a["thread_id"] == "t1" and a["rate_limited"] and not a["completed"]
    other = [{"type": "error", "message": "boom"}]
    assert lib.classify_attempt(other)["rate_limited"] is False


def test_last_agent_message_picks_latest_agent_text():
    evs = [{"type": "item.completed", "item": {"type": "agent_message", "text": "first"}},
           {"type": "item.completed", "item": {"type": "reasoning", "text": "thinking"}},
           {"type": "item.completed", "item": {"type": "agent_message", "text": "Phase 2 done"}}]
    assert lib.last_agent_message(evs) == "Phase 2 done"
    assert lib.last_agent_message([]) == ""


def test_validate_assessment_reports_errors():
    schema = json.loads((ROOT / "assessment.schema.json").read_text())
    assert lib.validate_assessment({"entities": "nope"}, schema)
    good = json.loads((Path(__file__).resolve().parents[1] / "fixtures" / "assessment" / "assessment.json").read_text())
    assert lib.validate_assessment(good, schema) == []


def test_preflight_statements_cover_every_bronze_schema_and_metamodel():
    stmts = dict(lib.preflight_statements(CFG))
    assert stmts["warehouse"] == "SELECT 1"
    assert "`manufacturing_mvm_v1`.`_metamodel`.`domain`" in stmts["metamodel"]
    assert "`manufacturing_bronze_vibe`.information_schema.tables" in stmts["bronze:src_sap_sd"]
    assert "table_schema = 'sap_sd_mvm'" in stmts["bronze:src_sap_sd"]


def test_preflight_statements_quote_hyphenated_identifiers():
    cfg = {**CFG, "vibe_catalog": "my-cat", "metamodel_prefix": "mm_",
           "bronze_sources": {"s": "bronze-cat.sap-sd"}}
    stmts = dict(lib.preflight_statements(cfg))
    assert "`my-cat`.`_metamodel`.`mm_domain`" in stmts["metamodel"]
    assert "`my-cat`.information_schema.tables" in stmts["physical"]
    assert "`bronze-cat`.information_schema.tables" in stmts["bronze:s"]
    assert "table_schema = 'sap-sd'" in stmts["bronze:s"]


REAL_PRODUCT = {"business", "version", "model_scope", "domain", "subdomain", "product", "tags"}
REAL_DOMAIN = {"business", "version", "model_scope", "domain", "division"}


def test_metamodel_columns_statement_targets_information_schema():
    sql = lib.metamodel_columns_statement({**CFG, "metamodel_prefix": "mm_"}, "product")
    assert "`manufacturing_mvm_v1`.information_schema.columns" in sql
    assert "table_schema = '_metamodel'" in sql and "lower(table_name) = 'mm_product'" in sql


def test_version_check_real_metamodel_shape():
    cfg = {**CFG, "customer": "Ridgeline Energy", "metamodel_business": "ridgeline_energy", "model_scope": "ecm"}
    sql = lib.version_check_statement(cfg, REAL_PRODUCT, REAL_DOMAIN)
    assert "p.domain = 'sales_order'" in sql and "LOWER(p.business) = 'ridgeline_energy'" in sql
    assert "LOWER(p.model_scope) = 'ecm'" in sql and "CAST(p.version AS STRING) = '3'" in sql
    assert "JOIN" not in sql and "domain_id" not in sql
    assert "`manufacturing_mvm_v1`.`_metamodel`.`product` p" in sql


import pytest


@pytest.mark.parametrize("ver", ["2", "v2", "V2", 2])
def test_version_check_matches_agent_stored_values(ver):
    cfg = {**CFG, "domain": "meter_to_cash", "customer": "Ridgeline Energy",
           "metamodel_business": "ridgeline_energy", "model_scope": "mvm", "model_version": ver}
    sql = lib.version_check_statement(cfg, REAL_PRODUCT, REAL_DOMAIN)
    assert "LOWER(p.business) = 'ridgeline_energy'" in sql
    assert "Ridgeline Energy" not in sql
    assert "LOWER(p.model_scope) = 'mvm'" in sql
    assert "CAST(p.version AS STRING) = '2'" in sql
    assert lib.version_check_values(cfg) == ("ridgeline_energy", "mvm", "2")


def test_version_check_business_falls_back_to_customer():
    cfg = {**CFG, "customer": "Meridian"}
    assert "LOWER(p.business) = 'meridian'" in lib.version_check_statement(cfg, REAL_PRODUCT, REAL_DOMAIN)


def test_version_check_domain_id_build_joins_on_name():
    sql = lib.version_check_statement(CFG, {"version", "domain_id"}, {"domain_id", "name"})
    assert "JOIN `manufacturing_mvm_v1`.`_metamodel`.`domain` d ON p.domain_id = d.domain_id" in sql
    assert "d.name = 'sales_order'" in sql


def test_version_check_domain_id_build_falls_back_to_domain_column():
    sql = lib.version_check_statement(CFG, {"version", "domain_id"}, {"domain_id", "domain"})
    assert "d.domain = 'sales_order'" in sql


def test_version_check_uses_model_version_column_and_skips_without_one():
    sql = lib.version_check_statement(CFG, {"model_version", "domain"}, set())
    assert "CAST(p.model_version AS STRING) = '3'" in sql
    assert lib.version_check_statement(CFG, {"domain"}, set()) is None
    assert lib.version_check_statement(CFG, {"version"}, set()) is None


def test_version_check_quotes_and_escapes():
    cfg = {**CFG, "vibe_catalog": "my-cat", "metamodel_prefix": "mm-", "domain": "o'brien", "customer": "A'B"}
    sql = lib.version_check_statement(cfg, REAL_PRODUCT, REAL_DOMAIN)
    assert "`my-cat`.`_metamodel`.`mm-product` p" in sql
    assert "p.domain = 'o''brien'" in sql and "LOWER(p.business) = 'a''b'" in sql


def test_version_check_plan_branches():
    plan = lib.version_check_plan
    assert plan(CFG, REAL_PRODUCT, set())[0] == "run"
    assert "CAST(p.version" in plan(CFG, REAL_PRODUCT, set())[1]
    assert plan(CFG, {"version", "domain_id"}, {"domain_id", "name"})[0] == "run"
    # product table not visible -> fail, not skip
    kind, reason = plan(CFG, set(), set())
    assert kind == "fail" and "manufacturing_mvm_v1._metamodel.product" in reason and "grant SELECT" in reason
    # domain_id build with invisible domain table -> fail
    kind, reason = plan(CFG, {"version", "domain_id"}, set())
    assert kind == "fail" and "domain" in reason
    # visible but genuinely lacking columns -> skip
    assert plan(CFG, {"domain"}, set())[0] == "skip"
    assert plan(CFG, {"version", "tags"}, set())[0] == "skip"
    assert plan(CFG, {"version", "domain_id"}, {"domain_id", "description"})[0] == "skip"


def test_redact_replaces_every_secret_occurrence():
    out = lib.redact("a dapi123 b dapi123 c other", ["dapi123", ""])
    assert out == "a [REDACTED] b [REDACTED] c other"
    assert lib.redact("nothing", []) == "nothing"


def _skill(root: Path, name: str, marker: str | None, skill_md: bool = True) -> None:
    d = root / name
    (d / "templates").mkdir(parents=True)
    (d / "templates" / "t.md").write_text("t")
    if skill_md:
        (d / "SKILL.md").write_text(f"# {name}")
    if marker is not None:
        (d / lib.SKILL_VERSION_FILE).write_text(marker + "\n")


def test_stage_bundled_skills_copies_and_records_markers(tmp_path):
    src, dst = tmp_path / "skills", tmp_path / "project" / ".agents" / "skills"
    for name in ("a", "b", "unstaged"):
        _skill(src, name, "0.4.0 4c709f704d4e4bc977aeb4379409fb709f2ab7e4")
    info = lib.stage_bundled_skills(src, dst, ["a", "b"])
    assert sorted(p.name for p in dst.iterdir()) == ["a", "b"]
    assert (dst / "a" / "templates" / "t.md").read_text() == "t"
    assert (dst / "b" / lib.SKILL_VERSION_FILE).is_file()
    assert info == {"source": "bundle", "path": str(src),
                    "markers": {"a": "0.4.0 4c709f704d4e4bc977aeb4379409fb709f2ab7e4",
                                "b": "0.4.0 4c709f704d4e4bc977aeb4379409fb709f2ab7e4"},
                    "version": "0.4.0", "ref": "4c709f704d4e4bc977aeb4379409fb709f2ab7e4",
                    "commit": "4c709f704d4e4bc977aeb4379409fb709f2ab7e4"}


def test_stage_bundled_skills_dev_ref_commit_and_disagreeing_markers(tmp_path):
    src = tmp_path / "skills"
    _skill(src, "a", "0.4.0 dev:fix/x@6e08f54")
    _skill(src, "b", "0.3.9 dev:fix/x@6e08f54")
    dev = lib.stage_bundled_skills(src, tmp_path / "d1", ["a"])
    assert (dev["version"], dev["ref"], dev["commit"]) == ("0.4.0", "dev:fix/x@6e08f54", "6e08f54")
    _skill(src, "c", "0.4.0 dev:fix/x")
    no_sha = lib.stage_bundled_skills(src, tmp_path / "d3", ["c"])
    assert (no_sha["ref"], no_sha["commit"]) == ("dev:fix/x", None)  # no @sha: no commit
    mixed = lib.stage_bundled_skills(src, tmp_path / "d2", ["a", "b"])
    assert (mixed["version"], mixed["ref"], mixed["commit"]) == (None, None, None)
    assert mixed["markers"] == {"a": "0.4.0 dev:fix/x@6e08f54", "b": "0.3.9 dev:fix/x@6e08f54"}


def test_stage_bundled_skills_refuses_an_incomplete_skill(tmp_path):
    import pytest
    src = tmp_path / "skills"
    _skill(src, "no_marker", None)
    _skill(src, "no_skill_md", "0.4.0 r", skill_md=False)
    for name in ("no_marker", "no_skill_md", "absent"):
        with pytest.raises(RuntimeError, match=name):
            lib.stage_bundled_skills(src, tmp_path / f"dst_{name}", [name])
