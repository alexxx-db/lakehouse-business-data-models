"""v5.3.3: the defects the live validation of 5.3.2 found.

- R34 651377744624962, R35 155237215962513 and R43 902627616694840: the final artifact carry-over copied the base
  version's schemas/ and metrics/ files into the new version folder, so the folder carried domains the model no longer
  has (client, inventory, audience, partner), a stale cross-domain FK file and, in time, an old vibe_scope drop file.
"""
import copy
import io
import json
import re
import sys
import types
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))
import conftest  # noqa: F401,E402
import agent_helpers as ah  # noqa: E402
import vibe_scope_deploy_harness as h  # noqa: E402


@pytest.fixture(autouse=True)
def _reset():
    ah.set_vibe_scope_runtime(None)
    ah.vov_ledger_reset()
    yield
    ah.set_vibe_scope_runtime(None)
    ah.vov_ledger_reset()


class _Entry:
    def __init__(self, path):
        self.path = path
        self.is_directory = False


class _Files:
    def __init__(self, tree):
        self.tree = tree
        self.uploads = []

    def list_directory_contents(self, directory):
        if directory not in self.tree:
            raise FileNotFoundError(directory)
        return [_Entry(f"{directory}/{name}") for name in self.tree[directory]]

    def download(self, path):
        directory, name = path.rsplit("/", 1)
        if name not in self.tree.get(directory, {}):
            raise FileNotFoundError(path)
        return types.SimpleNamespace(contents=io.BytesIO(self.tree[directory][name]))

    def upload(self, file_path, contents, overwrite=False):
        self.uploads.append(file_path)


def test_carry_over_never_copies_another_versions_ddl(monkeypatch):
    prev, cur = "/Volumes/c/_metamodel/vol_root/business/b/v1/mvm", "/Volumes/c/_metamodel/vol_root/business/b/v2/mvm"
    files = _Files({
        f"{prev}/schemas": {"b_gone_schema_v1_mvm.sql": b"CREATE TABLE gone", "b_cross_domain_foreign_keys_v1_mvm.sql": b"ALTER TABLE x",
                            "b_vibe_scope_removed_v1_mvm.sql": b"DROP TABLE IF EXISTS `c`.`kept`.`t`;"},
        f"{prev}/metrics": {"b_gone_metrics_v1_mvm.sql": b"CREATE VIEW gone"},
        f"{prev}/docs": {"b_model_v1_mvm.csv": b"a,b"},
        f"{cur}/schemas": {"b_kept_schema_v2_mvm.sql": b"CREATE TABLE kept"},
        f"{cur}/metrics": {"b_kept_metrics_v2_mvm.sql": b"CREATE VIEW kept"},
    })
    sdk = types.ModuleType("databricks.sdk")
    sdk.WorkspaceClient = lambda *a, **k: types.SimpleNamespace(files=files)
    monkeypatch.setitem(sys.modules, "databricks", types.ModuleType("databricks"))
    monkeypatch.setitem(sys.modules, "databricks.sdk", sdk)
    wv = {"operation": h.VOV, "base_version_for_review": "1", "current_version": "2", "model_scope": "mvm"}
    ah._carry_over_missing_artifacts_from_previous_version(wv, {"TARGET_VOLUME": cur}, h.LOG)
    assert files.uploads == [f"{cur}/docs/b_model_v2_mvm.csv"]


VIEWS = ["crew_roster_kpis", "flight_crew_coverage", "asset_utilization"]


def _rename_view(model):
    view = next(v for v in model["model"]["metric_views"] if v["view_name"] == "fleet_utilization")
    view["view_name"] = "asset_utilization"
    view["sql"] = view["sql"].replace("`fleet_utilization`", "`asset_utilization`")
    return model


def _scoped_root():
    root = _rename_view(h.scoped_final_model())
    root["_vibe_scope"] = h.scoped_facts()
    return root


def _deploy(monkeypatch, dry_run=False):
    base = _rename_view(h.base_model())
    ah.set_vibe_scope_runtime(ah.build_vibe_scope_fence(ah.parse_vibe_scope("Some Domains", "crew"), base, h.VOV, h.LOG))
    spark = h.FakeSpark(h.base_physical_tables(), views=VIEWS)
    root = _scoped_root()
    wv = h.flat_widgets(root, spark=spark, facts=h.scoped_facts(), dry_run=dry_run, statement_model=base)
    res = h.run_deploy_steps(wv, spark, root, lambda name, value: monkeypatch.setitem(ah.__dict__, name, value))
    if dry_run:
        ah._vibe_scope_dry_run_metric_artifacts(wv, h.LOG)
    res["files"] = {Path(p).name: t for p, t in res["artifacts"].items()}
    return res


def test_the_artifact_carries_the_fks_tags_and_views_of_kept_tables_for_an_empty_catalog(monkeypatch, caplog):
    caplog.set_level("INFO")
    res = _deploy(monkeypatch)
    completion = ah.parse_sql_statements(res["files"]["skyline_air_vibe_scope_preserved_v2_mvm.sql"])
    executed = res["statements"]
    assert ("ALTER TABLE `skyline`.`flight`.`scheduled_flight` ADD CONSTRAINT `fk_flight_scheduled_flight_aircraft_id` FOREIGN KEY "
            "(`aircraft_id`) REFERENCES `skyline`.`fleet`.`aircraft`(`aircraft_id`)") in completion
    assert any("`fleet`.`aircraft` ALTER COLUMN `tail_number` SET TAGS" in s for s in completion)
    assert any(s.startswith("ALTER SCHEMA `skyline`.`fleet` SET TAGS") for s in completion)
    assert not set(completion) & {s.rstrip(";") for s in executed}, "the completion statements were also run on the base"
    views = ah.parse_sql_statements(res["files"]["skyline_air_vibe_scope_preserved_metrics_v2_mvm.sql"])
    assert [ah._extract_metric_view_name_from_statement(s) for s in views] == ["asset_utilization"]
    fleet = res["files"]["skyline_air_fleet_metrics_v2_mvm.sql"]
    assert "preserved from the base version" in fleet and "failed validation" not in fleet
    assert "Step 1d: Creating 6 physical tables (3 CREATE OR REPLACE, 3 CREATE TABLE IF NOT EXISTS)." in caplog.text


def test_a_dry_run_writes_the_same_completion_files(monkeypatch):
    res = _deploy(monkeypatch, dry_run=True)
    assert "skyline_air_vibe_scope_preserved_v2_mvm.sql" in res["files"]
    views = ah.parse_sql_statements(res["files"]["skyline_air_vibe_scope_preserved_metrics_v2_mvm.sql"])
    assert [ah._extract_metric_view_name_from_statement(s) for s in views] == ["asset_utilization"]
    assert not [s for s in res["statements"] if s.upper().startswith(("CREATE", "ALTER", "DROP"))]


def test_an_install_into_an_empty_catalog_drops_the_scoped_plan():
    plan = object()
    assert ah._vibe_scope_effective_install_plan(plan, "fresh", h.LOG) is None
    assert ah._vibe_scope_effective_install_plan(plan, "base_match", h.LOG) is plan
    assert ah._vibe_scope_effective_install_plan(plan, "new_base", h.LOG) is plan
    assert ah._vibe_scope_effective_install_plan(None, "fresh", h.LOG) is None
    deploy = h.notebook_concat_source()
    call = deploy.index("_vs_precondition = _scoped_install_precondition(")
    assert deploy.index("_vs_install = _vibe_scope_effective_install_plan(_vs_install, _vs_precondition, _dlog)", call) < deploy.index(
        'if _vs_install is not None and _vs_precondition == "base_match":', call)


def test_a_full_install_of_the_scoped_model_creates_every_fk_and_view():
    spark = h.FakeSpark({}, views=[])
    rec, result, plan = h.run_install(_scoped_root(), spark, use_plan=False)
    assert result["error"] is None and plan is None
    ddl = spark.statements
    assert not [s for s in ddl if "CREATE TABLE IF NOT EXISTS" in s]
    assert any("ADD CONSTRAINT `fk_flight_scheduled_flight_aircraft_id`" in s for s in ddl)
    assert "asset_utilization" in " ".join(rec.phase("metric_views"))


def _shift_base():
    model = h.base_model()
    model["model"]["domains"][1]["products"][0]["attributes"].append(
        {"name": "assigned_crew_shift_id", "type": "BIGINT", "tags": "", "column_name": "assigned_crew_shift_id", "foreign_key_to": "", "description": "Shift"})
    return model


def _shift_model(link):
    model = _shift_base()
    crew = model["model"]["domains"][0]
    crew["products"].append({"name": "crew_shift", "subdomain": "crew_scheduling", "primary_key": "crew_shift_id", "table_name": "crew_shift",
                             "description": "Crew shift", "tags": "", "type": "entity",
                             "attributes": [{"name": "crew_shift_id", "type": "BIGINT", "tags": "primary_key", "column_name": "crew_shift_id",
                                             "foreign_key_to": "", "description": "Primary key"}]})
    if link:
        sched = model["model"]["domains"][1]["products"][0]
        next(a for a in sched["attributes"] if a["name"] == "assigned_crew_shift_id")["foreign_key_to"] = "crew.crew_shift.crew_shift_id"
    return model


def test_a_p3_link_made_after_the_engine_survives_the_engine_result_restore():
    """Live R41 705242797106879: the engine created order.gift_registry, the linker then set customer.household.gift_registry_id
    (P3), and the engine-result restore at logical_schema_review cleared it because the engine baseline already held the new
    product."""
    base = _shift_base()
    fence = ah.build_vibe_scope_fence(ah.parse_vibe_scope("Some Domains", "crew"), base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    fence.narrow_to_named({("crew", "crewshift")}, set(), set(), h.LOG)
    fence.record_change("create", "crew", "crew_shift", "engine:VREQ-0001")
    d, p, a, mv = ah.model_to_widgets_flat(_shift_model(link=False))
    fence.requested_snapshot(d, p, a, mv, h.LOG)
    d, p, a, mv = ah.model_to_widgets_flat(_shift_model(link=True))
    wv = {"domains": d, "products": p, "attributes": a, "_metric_view_records": mv}
    ah._vibe_scope_checkpoint_widgets("logical_schema_review", wv, h.LOG)
    linked = next(r for r in wv["attributes"] if r["product"] == "scheduled_flight" and r["attribute"] == "assigned_crew_shift_id")
    assert linked["foreign_key_to"] == "crew.crew_shift.crew_shift_id"
    assert fence.check_flat(wv["domains"], wv["products"], wv["attributes"], wv["_metric_view_records"]).summary()["by_kind"] == {"P3": 1}


def test_a_link_from_an_out_of_scope_product_named_with_its_in_scope_target_is_p4():
    """Live R41: 'In the product customer.profile, add a foreign key column gift_registry_id that references
    order.gift_registry' named both products, was split as a mixed requirement and its out-of-scope part rejected."""
    base = h.base_model()
    fence = ah.build_vibe_scope_fence(ah.parse_vibe_scope("Some Domains", "crew"), base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    text = "In the product flight.scheduled_flight, add a foreign key column standby_member_id that references crew.member."
    vreq = ah.RawVREQ(vreq_id="VREQ-0002", intent=text, target="flight.scheduled_flight, crew.member", source_quote=text, source_chunk_id="c1")
    kept, rejected, outcomes = ah._vibe_scope_triage_vreqs(fence, [vreq], base, h.LOG)
    assert [v.vreq_id for v in kept] == ["VREQ-0002"] and kept[0].target == vreq.target
    assert rejected == [] and outcomes == []
    auth = fence.report()["authorizations"]
    assert [(x["oos"], x["target"], x["column"]) for x in auth] == [("flight.scheduled_flight", "crew.member", "standby_member_id")]
    priority = {"vreq_id": "P-1", "action": "connect_table", "target": "flight.scheduled_flight, crew.member", "reason": text}
    kept_p, rejected_p = ah._vibe_scope_triage_priorities(fence, [priority], base, h.LOG)
    assert kept_p == [priority] and rejected_p == []
    assert len(fence.report()["authorizations"]) == 2


def test_a_mixed_requirement_without_a_link_is_still_split():
    base = h.base_model()
    fence = ah.build_vibe_scope_fence(ah.parse_vibe_scope("Some Domains", "crew"), base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    text = "Rename crew.member to crew_member and add a description to flight.scheduled_flight."
    vreq = ah.RawVREQ(vreq_id="VREQ-0003", intent=text, target="crew.member, flight.scheduled_flight", source_quote=text, source_chunk_id="c1")
    kept, rejected, outcomes = ah._vibe_scope_triage_vreqs(fence, [vreq], base, h.LOG)
    assert [v.target for v in kept] == ["crew.member"]
    assert [v.vreq_id for v in rejected] == ["VREQ-0003#oos"] and outcomes[0].status == "scope_rejected"
    assert fence.report()["authorizations"] == []


def test_a_derived_name_on_a_record_the_base_stores_without_one_is_not_a_frozen_change():
    """Live R41: next_vibes reported 'frozen_product_changed product.product_bundle (fields association_edges,table_name)'
    while model.json carried the base record unchanged."""
    base = h.base_model()
    aircraft = base["model"]["domains"][2]["products"][0]
    aircraft.pop("table_name")
    aircraft["attributes"][2].pop("column_name")
    fence = ah.build_vibe_scope_fence(ah.parse_vibe_scope("Some Domains", "crew"), base, h.VOV, h.LOG)
    cur = copy.deepcopy(base)
    craft = cur["model"]["domains"][2]["products"][0]
    craft["table_name"] = "aircraft"
    craft["association_edges"] = ["fleet.aircraft->crew.base"]
    craft["attributes"][2]["column_name"] = "tail_number"
    assert fence.check(cur).ok and not fence.check(cur).violations
    assert fence.changed_in_scope_products(cur) == set()
    craft["table_name"] = "aircraft_v2"
    assert [v["kind"] for v in fence.check(cur).violations] == ["frozen_product_changed"]


def test_an_all_domains_keep_tables_run_marks_its_model_json_as_a_delta_on_its_base():
    """The 2B deploy plan wrote a delta (unchanged tables as CREATE TABLE IF NOT EXISTS) while model.json carried no
    _vibe_scope block, so neither install path could tell the artifact needed its base version."""
    import test_v514_vibe_scope_parse as PS
    new = copy.deepcopy(PS.RAW)
    next(p for d in new["model"]["domains"] if d["name"] == "flight" for p in d["products"] if p["name"] == "scheduled_flight")["attributes"].append(
        {"name": "gate_code", "type": "STRING"})
    wv = {"business_context_raw": copy.deepcopy(PS.RAW), "operation": h.VOV, "base_version_for_review": "7", "model_scope": "mvm",
          "config": {"TARGET_CATALOG": "cat", "MODEL_SCOPE": "mvm"}}
    assert ah._vibe_scope_model_json_facts(new["model"], dict(wv), h.LOG) is None
    wv["_vov_keep_tables"] = True
    facts = ah._vibe_scope_model_json_facts(new["model"], wv, h.LOG)
    assert facts["mode"] == "all" and facts["label"] == "All Domains" and facts["changed_in_scope_products"] == ["flight.scheduled_flight"]
    assert (facts["base_version"], facts["base_scope"], facts["base_catalog"]) == ("7", "mvm", "cat")
    assert wv["_vov_unfenced_facts"] is facts
    plan = ah._vibe_scope_install_plan({"_vibe_scope": facts, "model": new["model"]}, new["model"])
    assert plan.state("flight", "scheduled_flight") == "replace" and plan.state("fleet", "aircraft") == "preserve"
    src = h.notebook_concat_source()
    assert "_vs_facts = _vibe_scope_model_json_facts(data_model, widgets_values, logger)" in src


def test_an_all_domains_dry_run_on_the_installed_head_keeps_tables_like_the_full_run(monkeypatch):
    calls = []
    monkeypatch.setitem(ah.__dict__, "_vov_keeps_installed_tables", lambda *a, **k: calls.append(a) or True)
    monkeypatch.setitem(ah.__dict__, "_schema_ownership_snapshot", lambda *a, **k: {"owned": {"cat.crew"}, "versions": {}, "rows": []})
    monkeypatch.setitem(ah.__dict__, "_schema_ownership_state", lambda snap, key: "owned")
    spark = types.SimpleNamespace(sql=lambda q: types.SimpleNamespace(collect=lambda: [("crew",)]))
    wv = {"operation": h.VOV, "_dry_run": True, "base_version_for_review": "3"}
    plan = ah._staging_catalog_teardown(spark, {"TARGET_CATALOG": "cat", "MODEL_SCOPE": "mvm"}, wv, h.LOG)
    assert plan["drop"] == ["crew"] and wv.get("_vov_keep_tables") is True and len(calls) == 1


def _wide(text, vid="VREQ-0001"):
    return ah.RawVREQ(vreq_id=vid, intent=text, target="*", source_quote=text, source_chunk_id="c1")


def test_a_set_target_requirement_opens_only_the_fields_it_names():
    """Live R36 1102287390591033: 'Make sure every table in the model has a non-empty description' turned the fence off; the run
    replaced all 97 tables (every sentinel row lost), rewrote 97 descriptions and moved 70 products to other subdomains."""
    assert ah._vibe_scope_open_fields_for("Make sure every table in the model has a non-empty description.") == {("products", "description")}
    assert ah._vibe_scope_open_fields_for("Write a description for every domain, table and column.") == {
        ("domains", "description"), ("products", "description"), ("attributes", "description")}
    assert ah._vibe_scope_open_fields_for("Tag every column that holds personal data with pii=true.") == {
        ("attributes", "tags"), ("attributes", "tag_set")}
    assert ah._vibe_scope_open_fields_for("Add an audit column to every table.") == frozenset()
    assert ah._vibe_scope_open_fields_for("Rename every table to snake case.") == frozenset()
    base = h.base_model()
    spec, wide = ah._vibe_scope_requested_spec([_wide("Make sure every table in the model has a non-empty description.")], base)
    assert wide == [] and spec.mode == "requested" and spec.entries == ()
    assert spec.open_fields == {("products", "description")} and spec.open_field_vreqs == ("VREQ-0001",)
    assert spec.fill_only_fields == {("products", "description")}
    spec, _wide_list = ah._vibe_scope_requested_spec([_wide("Rewrite every table description in plain business English.")], base)
    assert spec.open_fields == {("products", "description")} and spec.fill_only_fields == frozenset()
    spec, wide = ah._vibe_scope_requested_spec([_wide("Add an audit column to every table.")], base)
    assert spec is None and wide == ["VREQ-0001: *"]


def _field_fence():
    base = h.base_model()
    spec, _wide_list = ah._vibe_scope_requested_spec([_wide("Rewrite every table description in plain business English.")], base)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    return base, fence


def _described(base, subdomain=False):
    cur = copy.deepcopy(base)
    craft = cur["model"]["domains"][2]["products"][0]
    craft["description"] = "Every aircraft the airline operates, with its home base and tail number."
    if subdomain:
        craft["subdomain"] = "aircraft_registry"
    return cur


def test_the_fence_keeps_an_open_field_and_restores_everything_else():
    base, fence = _field_fence()
    result = fence.check(_described(base, subdomain=True))
    assert result.summary()["by_kind"] == {"P6": 1, "frozen_product_changed": 1}
    assert [v["detail"] for v in result.violations] == ["fields subdomain"]
    d, p, a, mv = ah.model_to_widgets_flat(_described(base, subdomain=True))
    fence.restore_flat(d, p, a, mv, "test")
    craft = next(r for r in p if r["product"] == "aircraft")
    assert craft["subdomain"] == "fleet_assets" and craft["description"].startswith("Every aircraft")
    model = _described(base)
    fence.splice_and_verify(model, h.LOG)
    spliced = model["model"]["domains"][2]["products"][0]
    assert spliced["description"].startswith("Every aircraft") and spliced["subdomain"] == "fleet_assets"
    facts = fence.scope_facts(model, "passed")
    p6 = [d for d in facts["permitted_deltas"] if d["kind"] == "P6"]
    assert [(d["domain"], d["product"], d["attribute"], d["fields"]) for d in p6] == [("fleet", "aircraft", "", ["description"])]
    assert "fleet.aircraft" in facts["preserved_products"] and facts["changed_in_scope_products"] == []


def test_a_metadata_only_change_keeps_the_table_and_its_rows(monkeypatch):
    base, fence = _field_fence()
    final = _described(base)
    fence.splice_and_verify(final, h.LOG)
    tail = next(x for x in final["model"]["domains"][2]["products"][0]["attributes"] if x["name"] == "tail_number")
    facts = fence.scope_facts(final, "passed")
    facts["permitted_deltas"].append({"kind": "P6", "domain": "fleet", "product": "aircraft", "attribute": "tail_number", "old_fk": "", "new_fk": "",
                                      "view_name": "", "fields": ["business_glossary_term", "description"], "old": {"business_glossary_term": "Tail Number"},
                                      "new": {"business_glossary_term": "", "description": "Registration mark"}, "cause": "test"})
    tail["business_glossary_term"], tail["description"] = "", "Registration mark"
    root = dict(final, _vibe_scope=facts)
    spark = h.FakeSpark(h.base_physical_tables(), views=["crew_roster_kpis", "flight_crew_coverage", "fleet_utilization"])
    wv = h.flat_widgets(root, spark=spark, facts=facts, statement_model=base)
    res = h.run_deploy_steps(wv, spark, root, lambda name, value: monkeypatch.setitem(ah.__dict__, name, value))
    ddl = [s.rstrip(";") for s in res["statements"] if s.upper().startswith(("CREATE", "ALTER", "COMMENT", "DROP"))]
    assert not [s for s in ddl if s.startswith("CREATE OR REPLACE TABLE")], "a description-only change replaced a table"
    assert "COMMENT ON TABLE `skyline`.`fleet`.`aircraft` IS 'Every aircraft the airline operates, with its home base and tail number.'" in ddl
    assert "ALTER TABLE `skyline`.`fleet`.`aircraft` ALTER COLUMN `tail_number` COMMENT 'Registration mark'" in ddl
    assert "ALTER TABLE `skyline`.`fleet`.`aircraft` ALTER COLUMN `tail_number` UNSET TAGS ('business_glossary_term')" in ddl
    files = {Path(p).name: t for p, t in res["artifacts"].items()}
    assert "COMMENT ON TABLE `skyline`.`fleet`.`aircraft`" in files["skyline_air_fleet_schema_v2_mvm.sql"]


def test_in_a_scoped_run_a_set_target_opens_fields_only_inside_the_scope():
    base = h.base_model()
    fence = ah.build_vibe_scope_fence(ah.parse_vibe_scope("Some Domains", "fleet"), base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    ah._vibe_scope_narrow_scoped(fence, [_wide("Rewrite every table description in plain business English.")], base)
    assert fence.spec.named_only and fence.spec.open_fields == {("products", "description")}
    cur = _described(base)
    cur["model"]["domains"][1]["products"][0]["description"] = "rewritten outside the scope"
    kinds = fence.check(cur).summary()["by_kind"]
    assert kinds == {"P6": 1, "frozen_product_changed": 1}
    assert [v["path"] for v in fence.check(cur).violations] == ["flight.scheduled_flight"]


def test_requirements_a_later_corrective_applied_count_as_applied():
    """Live R41: the engine batch failed on a fence violation, a corrective then created order.gift_registry with every
    requested column, yet next_vibes listed the columns under MISSED VIBES and reported 16.7% in-scope adherence."""
    model = _shift_model(link=False)
    model["model"]["domains"][0]["products"][-1]["attributes"].append(
        {"name": "shift_label", "type": "STRING", "column_name": "shift_label", "foreign_key_to": "", "description": "Shift label"})
    d, p, a, mv = ah.model_to_widgets_flat(model)
    raw = [{"vreq_id": "VREQ-0001", "intent": "Create a new product crew_shift in the crew domain", "target": "crew.crew_shift", "source_quote": ""},
           {"vreq_id": "VREQ-0002", "intent": "Add column shift_label to crew.crew_shift", "target": "crew.crew_shift.shift_label", "source_quote": ""},
           {"vreq_id": "VREQ-0003", "intent": "Add column shift_code to crew.crew_shift", "target": "crew.crew_shift.shift_code", "source_quote": ""},
           {"vreq_id": "VREQ-0004", "intent": "Add column x to flight.scheduled_flight", "target": "flight.scheduled_flight.duty_member_id", "source_quote": ""}]
    wv = {"operation": h.VOV, "domains": d, "products": p, "attributes": a, "_vov_2_raw_vreqs": raw,
          "_vov_vreq_status": {"VREQ-0001": {"status": "failed", "reason": "x"}, "VREQ-0002": {"status": "scope_fence_violation", "reason": "y"},
                               "VREQ-0003": {"status": "failed", "reason": "z"}, "VREQ-0004": {"status": "scope_rejected", "reason": "oos"}},
          "_v296_deferred_vreqs": [{"vreq_id": "VREQ-0001", "intent": "create"}, {"vreq_id": "VREQ-0003", "intent": "shift_code"}],
          "_vibe_scope_outcomes": {"scope_rejected": [{"vreq_id": "VREQ-0004"}], "scope_fence_violation": [{"vreq_id": "VREQ-0002"}],
                                   "scope_dependency_conflict": [], "adherence_in_scope_pct": 0.0},
          "_vibe_input_map": {"items": {"i1": {"target": "crew.crew_shift", "spans": [[0, 10]]}},
                              "vreqs": {"VREQ-0001": {"item_ids": ["i1"]}, "VREQ-0002": {"item_ids": ["i1"]}}}}
    assert ah._vov_reconcile_final_outcomes(wv, h.LOG) == ["VREQ-0001", "VREQ-0002"]
    assert wv["_vov_vreq_status"]["VREQ-0003"]["status"] == "failed" and wv["_vov_vreq_status"]["VREQ-0004"]["status"] == "scope_rejected"
    assert [x["vreq_id"] for x in wv["_v296_deferred_vreqs"]] == ["VREQ-0003"]
    assert wv["_vibe_scope_outcomes"]["scope_fence_violation"] == [] and wv["_vibe_scope_outcomes"]["adherence_in_scope_pct"] == 66.67
    assert [o["status"] for o in wv["_vibe_input_outcomes"]] == ["applied"]
    assert ah._vov_reconcile_final_outcomes(wv, h.LOG) == []
    src = h.notebook_concat_source()
    assert "_vov_reconcile_final_outcomes(widgets_values, logger)\n        _vi_outcomes = _vibe_input_model_json_outcomes(widgets_values)" in src


def test_a_run_that_fails_before_inserting_its_business_row_deletes_no_registry_row():
    """Live e5 203035110094916 (refused at setup) and a1 769409395543761 ran at the same time on one business: e5 computed
    the same next version, never inserted its row, and its failure rollback deleted a1's v26 business row, so the next run
    reused v26 and overwrote a1's artifacts."""
    src = h.notebook_concat_source()
    insert = src.index("_vibe_writer.insert_business_row({")
    owned = src.index('widgets_values["_registry_row_owned"] = True', insert)
    assert owned < src.index("_vibe_writer.initialize_session()", insert)
    rollback = src.index("# ROLLBACK: Delete all metamodel records for this failed run (all-or-nothing)")
    guard = src.index('and not widgets_values.get("_registry_row_owned"):', rollback)
    first_delete = src.index("DELETE FROM {main_tables['ATTRIBUTE']}", rollback)
    assert rollback < guard < first_delete
    assert "[registry-rollback-owned FIRED v5.3.3]" in src[guard:first_delete]
    assert src[guard:first_delete].count("elif current_version and biz_name and spark and main_tables:") == 1


def test_a_landed_domain_rename_is_verified_as_fulfilled():
    """Live b1 907726038170799: the domain rename alliance -> vendor_network landed (model and Unity Catalog), yet the
    physical ground-truth audit scored it failed, model.json reported 50% adherence and next_vibes listed it under
    MISSED VIBES."""
    import test_v329_behavioral as V
    v = V._build_verifier()
    req = V._Req("VREQ-001", "Rename the domain 'alliance' to 'vendor_network'.", scope="domain", targets=["alliance"])
    renamed = [{"domain": "vendor_network"}, {"domain": "campaign"}]
    assert v._verify_deterministic(req, renamed, [], [])["status"] == "fulfilled"
    assert v._verify_deterministic(req, [{"domain": "alliance"}, {"domain": "campaign"}], [], [])["status"] == "failed"
    assert v._verify_deterministic(req, [{"domain": "alliance"}, {"domain": "vendor_network"}], [], [])["status"] == "partial"
    other = V._Req("VREQ-002", "Rename the alliance domain to vendor_network.", scope="domain", targets=["alliance"])
    assert v._verify_deterministic(other, renamed, [], [])["status"] == "fulfilled"
    product = V._Req("VREQ-003", "Rename the product carrier in the order domain to shipping_carrier.", scope="table", targets=["order.carrier"])
    try:
        verdict = v._verify_deterministic(product, [{"domain": "order"}], [{"domain": "order", "product": "shipping_carrier"}], [])
    except NameError:
        verdict = None
    assert not (verdict or {}).get("evidence", "").startswith("[verifier-rename-domain")


def test_after_the_engine_only_the_engine_changes_an_open_field():
    """Live c1 834012025262118: 'Add a business glossary term to every column that has none' opened the glossary field; the
    engine filled the 7 empty terms, then the finalize tag cleanup cleared 1269 other terms on frozen columns, and the open
    field let those clears reach model.json and Unity Catalog (1269 UNSET TAGS)."""
    base = h.base_model()
    spec, _w = ah._vibe_scope_requested_spec([_wide("Add a business glossary term to every column that has none.")], base)
    assert spec.open_fields == {("attributes", "business_glossary_term")}
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    engine = copy.deepcopy(base)
    roster_date = next(a for a in engine["model"]["domains"][0]["products"][1]["attributes"] if a["name"] == "roster_date")
    roster_date["business_glossary_term"] = "Roster Date"
    d, p, a, mv = ah.model_to_widgets_flat(engine)
    fence.requested_snapshot(d, p, a, mv, h.LOG)
    final = copy.deepcopy(engine)
    tail = next(x for x in final["model"]["domains"][2]["products"][0]["attributes"] if x["name"] == "tail_number")
    tail["business_glossary_term"] = ""
    fence.splice_and_verify(final, h.LOG)
    attrs = {(dd["name"], pp["name"], aa["name"]): aa for dd in final["model"]["domains"] for pp in dd["products"] for aa in pp["attributes"]}
    assert attrs[("crew", "roster", "roster_date")]["business_glossary_term"] == "Roster Date"
    assert attrs[("fleet", "aircraft", "tail_number")]["business_glossary_term"] == "Tail Number"
    facts = fence.scope_facts(final, "passed")
    assert [(x["product"], x["attribute"], x["new"]) for x in facts["permitted_deltas"] if x["kind"] == "P6"] == [
        ("roster", "roster_date", {"business_glossary_term": "Roster Date"})]
    wv = {"domains": d, "products": p, "attributes": copy.deepcopy(a), "_metric_view_records": mv}
    for row in wv["attributes"]:
        if row["product"] == "aircraft" and row["attribute"] == "tail_number":
            row["business_glossary_term"] = ""
    ah._vibe_scope_checkpoint_widgets("logical_schema_review", wv, h.LOG)
    assert next(r for r in wv["attributes"] if r["attribute"] == "tail_number")["business_glossary_term"] == "Tail Number"


def test_a_metadata_change_on_a_column_the_table_does_not_have_is_skipped_and_reported():
    """Live c1 834012025262118: 15 UNSET TAGS statements failed with COLUMN_NOT_FOUND on columns the published model names
    but the installed tables do not have."""
    facts = h.scoped_facts()
    facts["permitted_deltas"] = [{"kind": "P6", "domain": "fleet", "product": "aircraft", "attribute": attr, "old_fk": "", "new_fk": "",
                                  "view_name": "", "fields": ["business_glossary_term"], "old": {"business_glossary_term": "Old"},
                                  "new": {"business_glossary_term": ""}, "cause": "test"} for attr in ("tail_number", "home_base")]
    plan = ah._scope_deploy_plan(facts, h.scoped_final_model(), h.LOG, use_runtime=False)
    plan.columns["skyline.fleet.aircraft"] = {"aircraft_id": "bigint", "home_base": "string"}
    out = plan._metadata_statements(("fleet", "aircraft"), "`skyline`.`fleet`.`aircraft`",
                                    [("tail_number", "`tail_number` STRING"), ("home_base", "`home_base` STRING")], "x")
    assert out == ["ALTER TABLE `skyline`.`fleet`.`aircraft` ALTER COLUMN `home_base` UNSET TAGS ('business_glossary_term');"]
    assert plan.summary()["absent_columns"] == ["skyline.fleet.aircraft.tail_number"]
    assert plan.counts["metadata_absent_column"] == 1


def test_a_column_introduced_with_named_or_called_is_verified_by_its_name():
    """Live a7 954014908148594: 'add a new column named anniversary_plan_id with type BIGINT' landed in model.json and in
    Unity Catalog, yet the verifier read the column name as 'named', did not see an add verb, fell back to the count diff
    ('No model changes detected') and scored it failed: 50% adherence in model.json and the requirement in MISSED VIBES."""
    from test_v406_verifier_false_negatives import _Req, _bare_orch
    orch = _bare_orch(ah.VibeOrchestrator)
    orch.config = {}
    orch._step_snapshots = {"step_interpret_model_instructions_before": {
        "domains": {"customer": {}}, "products": {"customer.household": {}}, "product_attributes": {"customer.household": ["household_id", "x"]}}}
    with_col = [{"domain": "customer", "product": "household", "attribute": "household_id", "foreign_key_to": ""},
                {"domain": "customer", "product": "household", "attribute": "anniversary_plan_id", "foreign_key_to": ""}]
    without = [with_col[0], {"domain": "customer", "product": "household", "attribute": "x", "foreign_key_to": ""}]
    prods = [{"domain": "customer", "product": "household"}]
    domains = [{"domain": "customer"}]
    text = "In the product customer.household (within the customer domain), add a new column named anniversary_plan_id with type BIGINT."
    req = _Req(text, "VREQ-001", ["customer.household"])
    assert orch._verify_deterministic(req, domains, prods, with_col)["status"] == "fulfilled"
    assert orch._verify_deterministic(req, domains, prods, without)["status"] == "failed"
    called = _Req("Add a BIGINT column called anniversary_plan_id to customer.household.", "VREQ-002")
    assert orch._verify_deterministic(called, domains, prods, with_col)["status"] == "fulfilled"
    assert orch._verify_deterministic(called, domains, prods, without)["status"] == "failed"
    removal = _Req("In customer.household, remove the column named anniversary_plan_id.", "VREQ-003", ["customer.household"])
    assert orch._verify_deterministic(removal, domains, prods, with_col)["status"] == "failed"
    assert orch._verify_deterministic(removal, domains, prods, without)["status"] == "fulfilled"
    assert ah._v337_extract_col_rename("In order.order_note, rename the column named note_lang to note_language.") == ("note_lang", "note_language")


def test_a_placeholder_glossary_term_is_not_coverage_and_is_reported():
    """Live c1 834012025262118: the engine filled the empty glossary terms with 'TODO' and the coverage verifier counted
    every glossary tag key as covered whatever its value."""
    from test_v406_verifier_false_negatives import _Req, _bare_orch
    orch = _bare_orch(ah.VibeOrchestrator)
    orch.config = {}
    req = _Req("Add a business glossary term to every column that has none.", "VREQ-001", ["*"])
    real = [{"domain": "d", "product": "p", "attribute": f"a{i}", "tags": f"dbx_business_glossary_term=Term {i}"} for i in range(9)]
    todo = real + [{"domain": "d", "product": "p", "attribute": "a9", "tags": "dbx_business_glossary_term=TODO"}]
    assert orch._verify_bulk_coverage(req, [], [], real + [{"domain": "d", "product": "p", "attribute": "a9", "tags": "dbx_business_glossary_term=Last"}])["status"] == "fulfilled"
    assert orch._verify_bulk_coverage(req, [], [], todo)["evidence"].split(" coverage ")[1].startswith("9/10")
    by_field = [{"domain": "d", "product": "p", "attribute": "a0", "business_glossary_term": "TBD"},
                {"domain": "d", "product": "p", "attribute": "a1", "business_glossary_term": "Order Date"}]
    assert orch._verify_bulk_coverage(req, [], [], by_field)["evidence"].split(" coverage ")[1].startswith("1/2")
    findings = ah._v381_verify_tag_semantics([], [], [{"domain": "menu", "product": "menu_modifier_group", "attribute": "menu_id", "business_glossary_term": "TODO"},
                                                    {"domain": "menu", "product": "menu_modifier_group", "attribute": "name", "business_glossary_term": "Modifier Group Name"}])
    assert findings == ["[SA:tag_placeholder_value] menu.menu_modifier_group.menu_id: business glossary term has placeholder value 'TODO'"]


def test_a_requirement_about_empty_values_changes_only_empty_values():
    """Live a9 116734783973928: for 'Make sure every table in the model has a non-empty description' the verification-sweep
    corrective rewrote 83 descriptions that were already filled."""
    base = h.base_model()
    base["model"]["domains"][0]["products"][1]["description"] = ""
    spec, _w = ah._vibe_scope_requested_spec([_wide("Make sure every table in the model has a non-empty description.")], base)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    cur = _described(base)
    cur["model"]["domains"][0]["products"][1]["description"] = "Who flies which duty on which day."
    result = fence.check(cur)
    assert result.summary()["by_kind"] == {"P6": 1, "frozen_product_changed": 1}
    assert [v["path"] for v in result.violations] == ["fleet.aircraft"]
    fence.splice_and_verify(cur, h.LOG)
    assert cur["model"]["domains"][0]["products"][1]["description"] == "Who flies which duty on which day."
    assert cur["model"]["domains"][2]["products"][0]["description"] == base["model"]["domains"][2]["products"][0]["description"]


def test_open_fields_settle_at_the_review_checkpoint():
    """The verification-sweep corrective applies set-target requirements after the engine; what it sets by the review checkpoint
    is kept, and a later pass cannot change it."""
    base = h.base_model()
    roster = next(a for a in base["model"]["domains"][0]["products"][1]["attributes"] if a["name"] == "roster_date")
    roster["business_glossary_term"] = ""
    spec, _w = ah._vibe_scope_requested_spec([_wide("Add a business glossary term to every column that has none.")], base)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    d, p, a, mv = ah.model_to_widgets_flat(base)
    fence.requested_snapshot(d, p, a, mv, h.LOG)
    wv = {"domains": d, "products": p, "attributes": a, "_metric_view_records": mv}
    next(r for r in a if r["attribute"] == "roster_date")["business_glossary_term"] = "Roster Date"
    ah._vibe_scope_checkpoint_widgets("logical_schema_review", wv, h.LOG)
    assert next(r for r in a if r["attribute"] == "roster_date")["business_glossary_term"] == "Roster Date"
    next(r for r in a if r["attribute"] == "roster_date")["business_glossary_term"] = "Rota Day"
    ah._vibe_scope_checkpoint_widgets("after_metric_views", wv, h.LOG)
    assert next(r for r in a if r["attribute"] == "roster_date")["business_glossary_term"] == "Roster Date"
    final = ah.widgets_flat_to_model(d, p, a, mv)
    final = {"model": final} if "model" not in final else final
    next(x for x in final["model"]["domains"][0]["products"][1]["attributes"] if x["name"] == "roster_date")["business_glossary_term"] = ""
    fence.splice_and_verify(final, h.LOG)
    assert next(x for x in final["model"]["domains"][0]["products"][1]["attributes"] if x["name"] == "roster_date")["business_glossary_term"] == "Roster Date"


def test_a_run_with_no_metric_view_to_deploy_still_writes_the_kept_views(monkeypatch):
    """Live a9 116734783973928 and a10 179605726850868: no metric view was in scope, the metric step returned before writing
    metrics/, so the version folder had no file with the 85 kept views and an install into an empty catalog would create none."""
    real = ah._vibe_scope_metric_view_deploy_set

    def _all_kept(plan, statements, records, spark, logger, catalog):
        deploy, kept, frozen = real(plan, statements, records, spark, logger, catalog)
        return [], kept, frozen

    monkeypatch.setitem(ah.__dict__, "_vibe_scope_metric_view_deploy_set", _all_kept)
    res = _deploy(monkeypatch)
    mv_step = res["statements"][res["marks"]["tags"]:res["marks"]["mv"]]
    assert not [s for s in mv_step if "VIEW" in s.upper() and s.upper().startswith("CREATE")], mv_step
    views = ah.parse_sql_statements(res["files"]["skyline_air_vibe_scope_preserved_metrics_v2_mvm.sql"])
    assert [ah._extract_metric_view_name_from_statement(s) for s in views] == ["asset_utilization"]
    assert "preserved from the base version" in res["files"]["skyline_air_fleet_metrics_v2_mvm.sql"]


def test_a_named_table_whose_only_changes_are_metadata_keeps_its_rows(monkeypatch):
    """Decision 2A: a named table whose description or column glossary changed was replaced, which drops its rows; it now
    stays in place and the change deploys as COMMENT and tag statements."""
    base = h.base_model()
    vreqs = [ah.RawVREQ(vreq_id="VREQ-0001", intent="Improve the description and the glossary terms of fleet.aircraft", target="fleet.aircraft",
                        source_quote="Improve the description and the glossary terms of fleet.aircraft", source_chunk_id="c1"),
             ah.RawVREQ(vreq_id="VREQ-0002", intent="In crew.roster add a column rest_hours", target="crew.roster.rest_hours",
                        source_quote="In crew.roster add a column rest_hours", source_chunk_id="c1")]
    spec, wide = ah._vibe_scope_requested_spec(vreqs, base)
    assert wide == [] and spec.mode == "requested"
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    final = _described(base)
    craft = final["model"]["domains"][2]["products"][0]
    next(a for a in craft["attributes"] if a["name"] == "tail_number")["business_glossary_term"] = "Registration Mark"
    final["model"]["domains"][0]["products"][1]["attributes"].append(
        {"name": "rest_hours", "type": "INT", "tags": "", "column_name": "rest_hours", "foreign_key_to": "", "description": "Rest hours"})
    fence.splice_and_verify(final, h.LOG)
    facts = fence.scope_facts(final, "passed")
    assert facts["changed_in_scope_products"] == ["crew.roster"]
    assert "fleet.aircraft" in facts["preserved_products"]
    assert sorted((d["product"], d["attribute"], tuple(d["fields"])) for d in facts["permitted_deltas"] if d["kind"] == "P6") == [
        ("aircraft", "", ("description",)), ("aircraft", "tail_number", ("business_glossary_term",))]
    root = dict(final, _vibe_scope=facts)
    spark = h.FakeSpark(h.base_physical_tables(), views=["crew_roster_kpis", "flight_crew_coverage", "fleet_utilization"])
    wv = h.flat_widgets(root, spark=spark, facts=facts, statement_model=base)
    res = h.run_deploy_steps(wv, spark, root, lambda name, value: monkeypatch.setitem(ah.__dict__, name, value))
    ddl = [s.rstrip(";") for s in res["statements"] if s.upper().startswith(("CREATE", "ALTER", "COMMENT", "DROP"))]
    assert [s for s in ddl if s.startswith("CREATE OR REPLACE TABLE")] == [s for s in ddl if s.startswith("CREATE OR REPLACE TABLE `skyline`.`crew`.`roster`")]
    assert not [s for s in ddl if s.startswith("CREATE OR REPLACE TABLE `skyline`.`fleet`.`aircraft`")]
    assert "COMMENT ON TABLE `skyline`.`fleet`.`aircraft` IS 'Every aircraft the airline operates, with its home base and tail number.'" in ddl


def test_a_rewrite_requirement_on_open_fields_is_verified_from_the_changed_values():
    """Live a11 619920396866994: 'Rewrite the description of every table' changed 84 descriptions (deployed as 84 COMMENT ON
    TABLE), yet no deterministic verifier covered a rewrite, the LLM judge read the fence text as a refusal and model.json
    reported 0% adherence."""
    from test_v406_verifier_false_negatives import _Req, _bare_orch
    base = h.base_model()
    text = "Rewrite the description of every table in plain business English, one short sentence each."
    spec, _w = ah._vibe_scope_requested_spec([_wide(text)], base)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    d, p, a, mv = ah.model_to_widgets_flat(base)
    orch = _bare_orch(ah.VibeOrchestrator)
    orch.config = {}
    req = _Req(text, "VREQ-001", ["*"])
    assert orch._verify_deterministic(req, d, p, a)["status"] == "failed"
    for row in p:
        row["description"] = f"{row['product']} in plain English."
    verdict = orch._verify_deterministic(req, d, p, a)
    assert verdict["status"] == "fulfilled" and verdict["evidence"].startswith(f"[verifier-open-fields FIRED v5.3.3] {len(p)}/{len(p)}")
    for row in p[1:]:
        row["description"] = next(x for x in ah.model_to_widgets_flat(base)[1] if x["product"] == row["product"])["description"]
    assert orch._verify_deterministic(req, d, p, a)["status"] == "partial"
    assert ah._vibe_scope_open_field_verdict(_Req("Make sure every table has a non-empty description.", "VREQ-002", ["*"]), d, p, a) is None
    ah.set_vibe_scope_runtime(None)
    assert ah._vibe_scope_open_field_verdict(req, d, p, a) is None


def test_a_placeholder_is_never_an_open_field_value():
    """Live c2 933723576430631: for 'Add a business glossary term to every column that has none' the engine filled all 1269
    empty terms with 'TODO'; the fence accepted them as P6 and the deploy set 1269 TODO glossary tags in Unity Catalog."""
    base = h.base_model()
    roster = next(a for a in base["model"]["domains"][0]["products"][1]["attributes"] if a["name"] == "roster_date")
    roster["business_glossary_term"] = ""
    spec, _w = ah._vibe_scope_requested_spec([_wide("Add a business glossary term to every column that has none.")], base)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    for value, kinds in (("TODO", {"frozen_attr_changed": 1}), ("N/A", {"frozen_attr_changed": 1}), ("Roster Date", {"P6": 1})):
        cur = copy.deepcopy(base)
        next(a for a in cur["model"]["domains"][0]["products"][1]["attributes"] if a["name"] == "roster_date")["business_glossary_term"] = value
        assert fence.check(cur).summary()["by_kind"] == kinds, value
    d, p, a, mv = ah.model_to_widgets_flat(base)
    next(r for r in a if r["attribute"] == "roster_date")["business_glossary_term"] = "TODO"
    fence.restore_flat(d, p, a, mv, "test")
    assert next(r for r in a if r["attribute"] == "roster_date")["business_glossary_term"] == ""
    roster["business_glossary_term"] = "TBD"
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    cur = copy.deepcopy(base)
    next(a for a in cur["model"]["domains"][0]["products"][1]["attributes"] if a["name"] == "roster_date")["business_glossary_term"] = "Roster Date"
    assert fence.check(cur).summary()["by_kind"] == {"P6": 1}, "a placeholder in the base counts as no value for a fill-only requirement"


def test_requirements_that_name_different_tables_are_never_duplicates():
    """Live a13 940565594073673: four 'remove the foreign key on campaign_id' lines differed only in the table; the extraction
    auditor recovered the customer.campaign line and the quote dedupe dropped it as a copy of the product.campaign one, so
    the fence never opened customer.campaign."""
    quotes = {t: f"In {t}, remove the foreign key on the column campaign_id; it points to customer.survey_campaign by mistake."
              for t in ("customer.campaign", "product.campaign", "product.collection")}
    existing = [ah.RawVREQ(vreq_id="VREQ-0003", intent="remove fk", target="product.campaign.campaign_id", source_quote=quotes["product.campaign"],
                           source_chunk_id="c1")]
    assert ah._v292_duplicate_of(quotes["customer.campaign"], existing) is None
    assert ah._v292_duplicate_of(quotes["product.campaign"], existing) == "VREQ-0003"
    vreqs = [ah.RawVREQ(vreq_id=f"VREQ-000{i}", intent="Remove the foreign key on campaign_id", target=f"{t}.campaign_id", source_quote=q,
                        source_chunk_id="c1") for i, (t, q) in enumerate(quotes.items(), 1)]
    assert sorted(len(c) for c in ah.cluster_vreqs(vreqs)) == [1, 1, 1]
    same = [vreqs[0], ah.RawVREQ(vreq_id="VREQ-0009", intent=vreqs[0].intent, target=vreqs[0].target, source_quote=vreqs[0].source_quote,
                                 source_chunk_id="c2")]
    assert [len(c) for c in ah.cluster_vreqs(same)] == [2]


def test_every_function_that_logs_without_a_logger_argument_has_the_vov_logger():
    """Live a13 940565594073673: the sandbox repair passed a free name 'logger' that _apply_handler_with_retry never defined;
    the NameError halted the run. Eight other VOV runtime functions logged through the same free name inside try blocks,
    so their log lines were dropped."""
    import ast
    import logging
    tree = ast.parse(h.notebook_concat_source())
    module_logger = any(isinstance(n, ast.Assign) and any(isinstance(t, ast.Name) and t.id == "logger" for t in n.targets) for n in tree.body)
    free = []
    for node in tree.body:
        fns = [node] if isinstance(node, ast.FunctionDef) else [b for b in getattr(node, "body", []) if isinstance(b, ast.FunctionDef)] if isinstance(node, ast.ClassDef) else []
        for fn in fns:
            bound = {a.arg for a in fn.args.args + fn.args.kwonlyargs} | {n.id for n in ast.walk(fn) if isinstance(n, ast.Name) and isinstance(n.ctx, ast.Store)}
            if "logger" not in bound and any(isinstance(n, ast.Name) and n.id == "logger" for n in ast.walk(fn)):
                free.append(fn.name)
    assert "_apply_handler_with_retry" in free and module_logger
    assert isinstance(ah.__dict__.get("logger"), logging.Logger) and ah.__dict__["logger"].name == "vov2-pipeline"


def test_the_mutation_engine_sets_glossary_terms_and_stewards_as_fields_not_tags():
    """Live c3 135313671686372: the verification-sweep corrective could not set business_glossary_term, since the mutation
    engine knew neither the field nor told the LLM about it; a modify of it became a 'business_glossary_term=...' tag and
    the LLM fell back to placeholder terms."""
    import logging
    domains = [{"domain": "order"}]
    products = [{"domain": "order", "product": "sales_order", "description": "Orders", "tags": "", "steward": ""}]
    attributes = [{"domain": "order", "product": "sales_order", "attribute": "order_date", "type": "DATE", "tags": "", "business_glossary_term": "", "steward": ""}]
    mutations = [{"entity_type": "attribute", "operation": "modify", "entity_ref": "order.sales_order.order_date", "field": "business_glossary_term", "new_value": "Order Date"},
                 {"entity_type": "attribute", "operation": "modify", "entity_ref": "order.sales_order.order_date.steward", "new_value": "sales_ops"},
                 {"entity_type": "product", "operation": "modify", "entity_ref": "order.sales_order", "field": "steward", "new_value": "order_desk"}]
    ah._llm_fallback_apply_mutations(mutations, domains, products, attributes, [], logging.getLogger("t533"))
    assert attributes[0]["business_glossary_term"] == "Order Date" and attributes[0]["steward"] == "sales_ops" and attributes[0]["tags"] == ""
    assert products[0]["steward"] == "order_desk" and products[0]["tags"] == ""
    assert "business_glossary_term, steward" in h.notebook_concat_source()


def test_a_set_target_requirement_that_changed_no_open_field_is_not_counted_applied():
    """Live c3 135313671686372: every glossary value the corrective wrote was a placeholder, the fence put them all back,
    yet the in-scope adherence said 100% while the verifiers said 0%."""
    def _wv(base, status="applied"):
        d, p, a, mv = ah.model_to_widgets_flat(base)
        return {"operation": h.VOV, "domains": d, "products": p, "attributes": a,
                "_vov_2_raw_vreqs": [{"vreq_id": "VREQ-0001", "intent": "glossary", "target": "*", "source_quote": ""}],
                "_vov_vreq_status": {"VREQ-0001": {"status": status, "reason": ""}},
                "_vibe_scope_outcomes": {"scope_rejected": [], "scope_fence_violation": [], "scope_dependency_conflict": [], "adherence_in_scope_pct": 100.0}}

    text = "Add a business glossary term to every column that has none."
    base = h.base_model()
    next(a for a in base["model"]["domains"][0]["products"][1]["attributes"] if a["name"] == "roster_date")["business_glossary_term"] = "TODO"
    spec, _w = ah._vibe_scope_requested_spec([_wide(text)], base)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    fence.splice_and_verify(copy.deepcopy(base), h.LOG)
    wv = _wv(base)
    assert ah._vov_reconcile_final_outcomes(wv, h.LOG) == ["VREQ-0001"]
    assert wv["_vov_vreq_status"]["VREQ-0001"]["status"] == "noop_failed" and wv["_vibe_scope_outcomes"]["adherence_in_scope_pct"] == 0.0
    filled = h.base_model()
    for attr in (a for d in filled["model"]["domains"] for p in d["products"] for a in p["attributes"]):
        attr["business_glossary_term"] = attr.get("business_glossary_term") or attr["name"].replace("_", " ").title()
    spec, _w = ah._vibe_scope_requested_spec([_wide(text)], filled)
    fence = ah.build_vibe_scope_fence(spec, filled, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    fence.splice_and_verify(copy.deepcopy(filled), h.LOG)
    wv = _wv(filled)
    assert ah._vov_reconcile_final_outcomes(wv, h.LOG) == [], "a requirement the base already satisfies stays applied"
    assert wv["_vov_vreq_status"]["VREQ-0001"]["status"] == "applied"


def test_an_fk_removal_is_scored_on_the_final_model_and_follows_renames():
    """Live a14 909307094667756: 'remove the foreign key on campaign_id' landed nowhere; on two tables a pass renamed the
    column to survey_campaign_id and kept the FK, yet the verifier scored 'FK removed' because campaign_id was gone, and the
    in-scope adherence said 100%."""
    from test_v406_verifier_false_negatives import _Req, _bare_orch
    orch = _bare_orch(ah.VibeOrchestrator)
    orch.config = {}
    text = "In product.collection, remove the foreign key on the column campaign_id; it points to customer.survey_campaign by mistake."
    req = _Req(text, "VREQ-001", ["product.collection.campaign_id"])
    prods = [{"domain": "product", "product": "collection"}]
    renamed = [{"domain": "product", "product": "collection", "attribute": "collection_id", "foreign_key_to": ""},
               {"domain": "product", "product": "collection", "attribute": "survey_campaign_id", "foreign_key_to": "customer.survey_campaign.survey_campaign_id"}]
    assert orch._verify_deterministic(req, [{"domain": "product"}], prods, renamed)["status"] == "failed"
    removed = [renamed[0], {"domain": "product", "product": "collection", "attribute": "campaign_id", "foreign_key_to": ""}]
    assert orch._verify_deterministic(req, [{"domain": "product"}], prods, removed)["status"] == "fulfilled"

    base = h.base_model()
    sched = base["model"]["domains"][1]["products"][0]
    column = next(a for a in sched["attributes"] if a.get("foreign_key_to"))
    spec, _w = ah._vibe_scope_requested_spec([ah.RawVREQ(vreq_id="VREQ-0001", intent=f"In flight.scheduled_flight remove the foreign key on {column['name']}",
                                                         target=f"flight.scheduled_flight.{column['name']}", source_quote="", source_chunk_id="c1")], base)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    final = copy.deepcopy(base)
    moved = next(a for a in final["model"]["domains"][1]["products"][0]["attributes"] if a["name"] == column["name"])
    moved["name"] = moved["column_name"] = "assigned_" + column["name"]
    ah._vov_note_attribute_rename("flight", "scheduled_flight", column["name"], moved["name"], "pass:test")
    d, p, a, mv = ah.model_to_widgets_flat(final)
    raw = [{"vreq_id": "VREQ-0001", "intent": f"In flight.scheduled_flight remove the foreign key on {column['name']}",
            "target": f"flight.scheduled_flight.{column['name']}", "source_quote": ""}]
    wv = {"operation": h.VOV, "domains": d, "products": p, "attributes": a, "_vov_2_raw_vreqs": raw,
          "_vov_vreq_status": {"VREQ-0001": {"status": "applied", "reason": ""}},
          "_vibe_scope_outcomes": {"scope_rejected": [], "scope_fence_violation": [], "scope_dependency_conflict": [], "adherence_in_scope_pct": 100.0}}
    assert ah._vov_reconcile_final_outcomes(wv, h.LOG) == ["VREQ-0001"]
    assert wv["_vov_vreq_status"]["VREQ-0001"]["status"] == "failed" and wv["_vibe_scope_outcomes"]["adherence_in_scope_pct"] == 0.0
    next(r for r in a if r["attribute"] == moved["name"])["foreign_key_to"] = ""
    wv["_vov_vreq_status"] = {"VREQ-0001": {"status": "applied", "reason": ""}}
    assert ah._vov_reconcile_final_outcomes(wv, h.LOG) == []


def test_a_set_target_column_addition_keeps_the_fence_and_adds_only_that_column(monkeypatch):
    """Decision 2A: 'add a column X to every table' turned the fence off, so every changed table was replaced and lost its
    rows; now only the named column may be added to frozen tables (P7) and it deploys with ALTER TABLE ADD COLUMNS."""
    assert ah._vibe_scope_open_columns_for("Add a column created_at (TIMESTAMP) to every table.") == {"createdat"}
    assert ah._vibe_scope_open_columns_for("Add a load_ts TIMESTAMP column to every table.") == {"loadts"}
    assert ah._vibe_scope_open_columns_for("Add an audit column to every table.") == frozenset()
    assert ah._vibe_scope_open_columns_for("Drop the column load_ts from every table.") == frozenset()
    assert ah._vibe_scope_open_columns_for("Add a column created_at to the roster table.") == frozenset()
    base = h.base_model()
    text = "Add a column created_at (TIMESTAMP) to every table."
    spec, wide = ah._vibe_scope_requested_spec([_wide(text)], base)
    assert wide == [] and spec.open_columns == {"createdat"} and spec.open_field_vreqs == ("VREQ-0001",)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    cur = copy.deepcopy(base)
    col = {"name": "created_at", "type": "TIMESTAMP", "tags": "", "column_name": "created_at", "foreign_key_to": "", "description": "Created at"}
    for d in cur["model"]["domains"]:
        for p in d["products"]:
            p["attributes"].append(copy.deepcopy(col))
    cur["model"]["domains"][2]["products"][0]["attributes"].append(dict(col, name="extra_col", column_name="extra_col"))
    result = fence.check(cur)
    kinds = result.summary()["by_kind"]
    n_products = sum(len(d["products"]) for d in base["model"]["domains"])
    assert kinds == {"P7": n_products, "frozen_attr_added": 1}
    d, p, a, mv = ah.model_to_widgets_flat(cur)
    fence.restore_flat(d, p, a, mv, "test")
    assert sum(1 for r in a if r["attribute"] == "created_at") == n_products and not [r for r in a if r["attribute"] == "extra_col"]
    final = copy.deepcopy(cur)
    final["model"]["domains"][2]["products"][0]["attributes"].pop()
    fence.splice_and_verify(final, h.LOG)
    facts = fence.scope_facts(final, "passed")
    p7 = [x for x in facts["permitted_deltas"] if x["kind"] == "P7"]
    assert len(p7) == n_products and {x["attribute"] for x in p7} == {"created_at"}
    assert facts["changed_in_scope_products"] == []
    from test_v406_verifier_false_negatives import _Req
    verdict = ah._vibe_scope_open_field_verdict(_Req(text, "VREQ-001", ["*"]), d, p, a)
    assert verdict["status"] == "fulfilled" and verdict["evidence"].startswith(f"[verifier-open-columns FIRED v5.3.3] {n_products}/{n_products}")
    root = dict(final, _vibe_scope=facts)
    spark = h.FakeSpark(h.base_physical_tables(), views=["crew_roster_kpis", "flight_crew_coverage", "fleet_utilization"])
    wv = h.flat_widgets(root, spark=spark, facts=facts, statement_model=base)
    res = h.run_deploy_steps(wv, spark, root, lambda name, value: monkeypatch.setitem(ah.__dict__, name, value))
    ddl = [s.rstrip(";") for s in res["statements"] if s.upper().startswith(("CREATE", "ALTER", "COMMENT", "DROP"))]
    assert not [s for s in ddl if s.startswith("CREATE OR REPLACE TABLE")], "a column addition replaced a table"
    assert len([s for s in ddl if s.startswith("ALTER TABLE") and "ADD COLUMNS (`created_at` TIMESTAMP" in s]) == n_products


def test_the_verification_sweep_changes_to_named_products_are_kept_until_review():
    """Decision 1A: a named product was frozen at its engine result after the engine, so the verification sweep's fixes to it
    were put back (b4 116870625878074: 857 glossary mutations on the finance domain, 0 changes in the final model)."""
    base = h.base_model()
    spec, _w = ah._vibe_scope_requested_spec([ah.RawVREQ(vreq_id="VREQ-0001", intent="Add a glossary term to every crew column that has none",
                                                         target="crew", source_quote="", source_chunk_id="c1")], base)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    d, p, a, mv = ah.model_to_widgets_flat(base)
    fence.requested_snapshot(d, p, a, mv, h.LOG)
    wv = {"domains": d, "products": p, "attributes": a, "_metric_view_records": mv}
    row = next(r for r in a if r["domain"] == "crew" and r["attribute"] == "roster_date")
    row["business_glossary_term"] = "Roster Day"
    ah._vibe_scope_checkpoint_widgets("logical_schema_review", wv, h.LOG)
    assert next(r for r in a if r["domain"] == "crew" and r["attribute"] == "roster_date")["business_glossary_term"] == "Roster Day"
    next(r for r in a if r["domain"] == "crew" and r["attribute"] == "roster_date")["business_glossary_term"] = "Changed later"
    ah._vibe_scope_checkpoint_widgets("after_metric_views", wv, h.LOG)
    assert next(r for r in a if r["domain"] == "crew" and r["attribute"] == "roster_date")["business_glossary_term"] == "Roster Day"


def test_a_templated_glossary_term_is_a_placeholder():
    """Live b5 583010004363545: the verification sweep filled 202 finance glossary terms with 'GlossaryTerm_<column>'."""
    for value in ("GlossaryTerm_cost_center_id", "Glossary Term: allocation method", "term_billable_flag", "TODO", "<value>"):
        assert ah._v381_is_placeholder_tag_value(value), value
    for value in ("Cost Center", "Terminal Identifier", "Term Length", "Billable Flag"):
        assert not ah._v381_is_placeholder_tag_value(value), value
    findings = ah._v381_verify_tag_semantics([], [], [{"domain": "finance", "product": "cost_center", "attribute": "cost_center_id",
                                                        "business_glossary_term": "GlossaryTerm_cost_center_id"}])
    assert findings == ["[SA:tag_placeholder_value] finance.cost_center.cost_center_id: business glossary term has placeholder value 'GlossaryTerm_cost_center_id'"]


def test_a_requirement_that_names_a_target_and_only_fields_opens_only_those_fields_there():
    """Decision 4A (live b5 583010004363545): 'Add a business glossary term to every column of the finance domain that has
    none' opened the whole finance domain, so the verification sweep also dropped 3 FK columns and 3 tables were replaced."""
    base = h.base_model()
    for attr in base["model"]["domains"][0]["products"][1]["attributes"]:
        attr["business_glossary_term"] = ""
    text = "Add a business glossary term to every column of the crew domain that has none."
    vreq = ah.RawVREQ(vreq_id="VREQ-0001", intent=text, target="crew", source_quote=text, source_chunk_id="c1")
    spec, wide = ah._vibe_scope_requested_spec([vreq], base)
    assert wide == [] and spec.products == frozenset() and spec.whole_domains == frozenset() and spec.entries == ("crew",)
    assert spec.open_field_targets == {("crew", "", "attributes", "business_glossary_term")}
    assert ("attributes", "business_glossary_term") in spec.fill_only_fields and spec.open_field_vreqs == ("VREQ-0001",)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    cur = copy.deepcopy(base)
    roster = cur["model"]["domains"][0]["products"][1]
    for attr in roster["attributes"]:
        attr["business_glossary_term"] = "Crew " + attr["name"].replace("_", " ").title()
    dropped = roster["attributes"].pop()
    next(a for a in cur["model"]["domains"][2]["products"][0]["attributes"] if a["name"] == "tail_number")["business_glossary_term"] = ""
    kinds = fence.check(cur).summary()["by_kind"]
    assert kinds.get("P6") == len(roster["attributes"]) and kinds.get("frozen_attr_removed") == 1 and kinds.get("frozen_attr_changed") == 1
    d, p, a, mv = ah.model_to_widgets_flat(cur)
    fence.restore_flat(d, p, a, mv, "test")
    crew_roster = [r for r in a if r["domain"] == "crew" and r["product"] == "roster"]
    assert any(r["attribute"] == dropped["name"] for r in crew_roster), "the dropped column came back"
    assert next(r for r in a if r["attribute"] == "tail_number")["business_glossary_term"] == "Tail Number"
    from test_v406_verifier_false_negatives import _Req
    verdict = ah._vibe_scope_open_field_verdict(_Req(text, "VREQ-001", ["crew"]), d, p, a)
    assert verdict["status"] in ("fulfilled", "partial") and verdict["evidence"].startswith("[verifier-open-field-targets FIRED v5.3.3]")
    wv = {"operation": h.VOV, "domains": d, "products": p, "attributes": a,
          "_vov_2_raw_vreqs": [{"vreq_id": "VREQ-0001", "intent": text, "target": "crew", "source_quote": text}],
          "_vov_vreq_status": {"VREQ-0001": {"status": "noop_failed", "reason": "engine"}},
          "_vibe_scope_outcomes": {"scope_rejected": [], "scope_fence_violation": [], "scope_dependency_conflict": [], "adherence_in_scope_pct": 0.0}}
    for r in a:
        if r["domain"] == "crew" and not r.get("business_glossary_term"):
            r["business_glossary_term"] = "Crew " + r["attribute"].replace("_", " ").title()
    assert ah._vov_reconcile_final_outcomes(wv, h.LOG) == ["VREQ-0001"]
    assert wv["_vov_vreq_status"]["VREQ-0001"]["status"] == "applied" and wv["_vibe_scope_outcomes"]["adherence_in_scope_pct"] == 100.0


def test_a_domain_wildcard_target_is_the_domain_and_an_opened_requirement_passes_triage():
    """Live b6 813685565341565: the extractor gave the target 'finance.*'; the spec builder read '*' as an invalid name and
    opened the glossary model-wide, then the triage judged finance frozen and rejected the requirement."""
    base = h.base_model()
    text = "Add a business glossary term to every column of the crew domain that has none."
    vreq = ah.RawVREQ(vreq_id="VREQ-0001", intent=text, target="crew.*", source_quote=text, source_chunk_id="c1")
    spec, wide = ah._vibe_scope_requested_spec([vreq], base)
    assert wide == [] and spec.entries == ("crew",) and spec.open_fields == frozenset()
    assert spec.open_field_targets == {("crew", "", "attributes", "business_glossary_term")}
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    kept, rejected, outcomes = ah._vibe_scope_triage_vreqs(fence, [vreq], base, h.LOG)[:3]
    assert [v.vreq_id for v in kept] == ["VREQ-0001"] and not rejected
    wide_spec, _w = ah._vibe_scope_requested_spec([ah.RawVREQ(vreq_id="VREQ-0002", intent=text, target="*", source_quote=text, source_chunk_id="c1")], base)
    wide_fence = ah.build_vibe_scope_fence(wide_spec, base, h.VOV, h.LOG)
    named_text = ah.RawVREQ(vreq_id="VREQ-0002", intent=text, target="crew.member, crew.roster", source_quote=text, source_chunk_id="c1")
    kept, rejected = ah._vibe_scope_triage_vreqs(wide_fence, [named_text], base, h.LOG)[:2]
    assert [v.vreq_id for v in kept] == ["VREQ-0002"] and not rejected, "a requirement the spec opened fields for is never rejected"


def test_each_clause_opens_its_own_field_and_a_target_less_verdict_uses_the_open_targets():
    """Live a17 511127613148987: 'Improve the description of the table X and give each of its columns a business glossary
    term' also opened column descriptions, and with no concrete target on the requirement the verifier fell back to
    model-wide glossary coverage (35%) and reported 0%."""
    text = "Improve the description of the table crew.roster and give each of its columns a business glossary term."
    assert ah._vibe_scope_open_fields_for(text) == {("products", "description"), ("attributes", "business_glossary_term")}
    assert ah._vibe_scope_open_fields_for("Write a description for every domain, table and column.") == {
        ("domains", "description"), ("products", "description"), ("attributes", "description")}
    base = h.base_model()
    for attr in base["model"]["domains"][0]["products"][1]["attributes"]:
        attr["business_glossary_term"] = ""
    spec, _w = ah._vibe_scope_requested_spec([ah.RawVREQ(vreq_id="VREQ-0001", intent=text, target="crew.roster", source_quote=text,
                                                         source_chunk_id="c1")], base)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    cur = copy.deepcopy(base)
    roster = cur["model"]["domains"][0]["products"][1]
    roster["description"] = "Who flies which duty on which day."
    for attr in roster["attributes"]:
        attr["business_glossary_term"] = "Crew " + attr["name"].replace("_", " ").title()
    d, p, a, mv = ah.model_to_widgets_flat(cur)
    from test_v406_verifier_false_negatives import _Req
    for targets in (["*"], ["roster"], ["crew.roster"]):
        verdict = ah._vibe_scope_open_field_verdict(_Req(text, "VREQ-001", targets), d, p, a)
        assert verdict["status"] == "fulfilled" and verdict["evidence"].startswith("[verifier-open-field-targets FIRED v5.3.3]"), (targets, verdict)


def test_a_field_limited_target_is_shown_to_the_engine_and_the_sweep_with_its_open_fields():
    """Live a18 492254310643790: the engine digest marked customer.survey_campaign frozen ('never modify'), the engine
    no-op'd three times, and the verification sweep's per-product batch ignored its product filter, so the domain
    snapshot was cut at 60,000 characters before survey_campaign and carried no glossary values."""
    base = h.base_model()
    text = "Give every column of the table crew.roster that has no business glossary term one."
    spec, _w = ah._vibe_scope_requested_spec([ah.RawVREQ(vreq_id="VREQ-0001", intent=text, target="crew.roster", source_quote=text,
                                                         source_chunk_id="c1")], base)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    block = fence.prompt_block()
    assert "may change ONLY these fields on these records" in block and "crew.roster: attributes.business_glossary_term" in block
    frozen, shown = ah._vibe_scope_digest_marks(base)
    assert ("crew", "roster") in frozen and ("crew", "roster") in shown
    d, p, a, _mv = ah.model_to_widgets_flat(base)
    a = [dict(r, business_glossary_term="Roster Date") if r.get("attribute") == "roster_date" else r for r in a]
    snap = ah._llm_fallback_build_model_snapshot(d, p, a, domain_filter="crew", product_filter="roster")
    assert "TABLE: crew.roster" in snap and "TABLE: crew.member" not in snap
    assert "roster_date (type: DATE)  [glossary: Roster Date]" in snap and snap.count("[glossary:") == 1
    whole = ah._llm_fallback_build_model_snapshot(d, p, a, domain_filter="crew")
    assert "TABLE: crew.member" in whole
    text = "Add a business glossary term to every column of the crew domain that has none."
    spec, _w = ah._vibe_scope_requested_spec([ah.RawVREQ(vreq_id="VREQ-0001", intent=text, target="crew", source_quote=text,
                                                         source_chunk_id="c1")], base)
    ah.set_vibe_scope_runtime(ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG))
    frozen, shown = ah._vibe_scope_digest_marks(base)
    assert {("crew", "member"), ("crew", "roster"), ("crew", "base")} <= frozen & shown
    assert ("fleet", "maintenance") in frozen and ("fleet", "maintenance") not in shown
    assert "crew (every table): attributes.business_glossary_term" in ah.get_vibe_scope_runtime().prompt_block()


def test_a_glossary_term_is_a_business_term_not_a_placeholder_or_a_sentence():
    """Live b7 309339185517965: the verification sweep replaced 127 'GlossaryTerm_<column>' placeholders with description
    sentences ('Unique surrogate identifier for a cost center record, used as the primary key ...'), and the fence, the
    coverage verifier and the static gates all accepted them as glossary terms."""
    defect = ah._v533_glossary_term_defect
    assert defect("GlossaryTerm_cost_center_id") == "placeholder" and defect("TODO") == "placeholder"
    assert defect("Unique surrogate identifier for a cost center record, used as the primary key for the cost_center entity.") == "sentence"
    assert defect("Portion of the total budget that has been formally allocated to specific campaigns line items or cost centers") == "sentence"
    for good in ("Currency Code", "Customer Lifetime Value (CLTV) Band", "Quantity Before Adjustment (Stock on Hand)",
                 "California Consumer Privacy Act (CCPA) / California Privacy Rights Act (CPRA) Sale Opt-Out Flag", "", None):
        assert defect(good) is None, good
    assert ah._vibe_scope_bad_value("business_glossary_term", "Date on which the payment was initiated.")
    assert not ah._vibe_scope_bad_value("description", "Date on which the payment was initiated.")
    assert ah._vibe_scope_bad_value("description", "TODO") and not ah._vibe_scope_bad_value("business_glossary_term", "Payment Date")
    assert ah._v533_attr_glossary_value({"business_glossary_term": "Date on which the payment was initiated.",
                                         "tags": {"dbx_business_glossary_term": "Payment Date"}}) == "Payment Date"
    base = h.base_model()
    for attr in base["model"]["domains"][0]["products"][1]["attributes"]:
        attr["business_glossary_term"] = ""
    text = "Give every column of the table crew.roster that has no business glossary term one."
    spec, _w = ah._vibe_scope_requested_spec([ah.RawVREQ(vreq_id="VREQ-0001", intent=text, target="crew.roster", source_quote=text,
                                                         source_chunk_id="c1")], base)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    for value, kinds in (("Date on which the roster applies.", {"frozen_attr_changed": 1}), ("Roster Date", {"P6": 1}),
                         ("Crew Roster Date", {"P6": 1})):
        cur = copy.deepcopy(base)
        next(a for a in cur["model"]["domains"][0]["products"][1]["attributes"] if a["name"] == "roster_date")["business_glossary_term"] = value
        assert fence.check(cur).summary()["by_kind"] == kinds, value
    from test_v406_verifier_false_negatives import _Req, _bare_orch
    orch = _bare_orch(ah.VibeOrchestrator)
    orch.config = {}
    req = _Req("Add a business glossary term to every column that has none.", "VREQ-001", ["*"])
    rows = [{"domain": "d", "product": "p", "attribute": f"a{i}", "business_glossary_term": f"Term {i}"} for i in range(9)]
    rows.append({"domain": "d", "product": "p", "attribute": "a9", "business_glossary_term": "Date on which the payment was initiated."})
    assert orch._verify_bulk_coverage(req, [], [], rows)["evidence"].split(" coverage ")[1].startswith("9/10")


def test_the_static_analysis_reports_glossary_terms_that_are_placeholders_or_sentences_and_requeues_them():
    """Live b7 309339185517965: lane 2 carried 416 'GlossaryTerm_<column>' values and then 127 sentences, and
    missing_glossary_tag passed because it only checks that a glossary tag exists."""
    from test_v368_qgate_suite import _clean_model, _requeue_ns, _run_sa
    d, p, a = _clean_model()
    cats, _ = _run_sa(d, p, a)
    assert "invalid_glossary_term" not in cats
    a = [dict(r) for r in a]
    a[1]["business_glossary_term"] = "GlossaryTerm_amount"
    a[4]["business_glossary_term"] = "Gross weight of the shipment in kilograms as measured at origin."
    a[0]["business_glossary_term"] = "Deal Identifier"
    _cats, issues = _run_sa(d, p, a)
    issue = next(i for i in issues if i["category"] == "invalid_glossary_term")
    assert issue["details"]["count"] == 2 and issue["details"]["by_reason"] == {"placeholder": 1, "sentence": 1}
    assert issue["details"]["attributes"] == ["sales.deal.amount", "logistics.shipment.weight"]
    ns = _requeue_ns([{"category": "invalid_glossary_term", "severity": "warning", "message": "x", "details": {"entity": "finance.invoice.vendor_name"}}])
    wv = {"domains": [{"name": "finance"}], "products": [{"domain": "finance", "product": "invoice"}],
          "attributes": [{"domain": "finance", "product": "invoice", "attribute": "vendor_name"}], "_unfulfilled_for_next_vibe": []}
    assert ns["_v366_sa_findings_requeue"](wv, {}, h.LOG) == 1


def test_the_fallback_refuses_a_glossary_term_that_is_a_sentence_or_a_placeholder():
    base = h.base_model()
    d, p, a, _mv = ah.model_to_widgets_flat(base)
    row = next(r for r in a if r["domain"] == "crew" and r["attribute"] == "roster_date")
    row["business_glossary_term"] = ""

    def mutation(value):
        return [{"entity_type": "attribute", "operation": "modify", "entity_ref": "crew.roster.roster_date", "field": "business_glossary_term",
                 "new_value": value}]
    for value in ("Date on which the crew roster applies.", "GlossaryTerm_roster_date"):
        assert ah._llm_fallback_apply_mutations(mutation(value), d, p, a, [], h.LOG) == 0
        assert row["business_glossary_term"] == "", value
    assert ah._llm_fallback_apply_mutations(mutation("Roster Date"), d, p, a, [], h.LOG) == 1
    assert row["business_glossary_term"] == "Roster Date"


def test_the_verification_sweep_plans_batches_from_the_tables_it_names_and_fits_them(monkeypatch):
    """Live b7 309339185517965: the classifier chose per_domain but listed ten finance tables; the per-domain branch matched
    the table refs against domain names, found none and ran every domain, starting with campaign, so the LLM never saw a
    finance table. Live a19 284506174299098: batch=single sent the whole model, cut at 60,000 characters."""
    base = h.base_model()
    d, p, a, _mv = ah.model_to_widgets_flat(base)

    def plan(strategy, affected):
        return ah._llm_fallback_plan_batches(strategy, affected, d, p, a, h.LOG)
    assert [b["label"] for b in plan("per_domain", ["crew.roster", "crew.member"])] == ["domain:crew"]
    assert [b["label"] for b in plan("per_domain", [])] == ["domain:crew", "domain:flight", "domain:fleet"]
    assert [b["label"] for b in plan("per_product", ["crew"])] == ["domain:crew"]
    assert [b["label"] for b in plan("per_product", ["crew.roster", "crew"])] == ["domain:crew"]
    assert [(b["domain_filter"], b["product_filter"]) for b in plan("per_product", ["crew.roster", "fleet.aircraft"])] == [
        ("crew", "roster"), ("fleet", "aircraft")]
    assert plan("single", ["crew.roster", "fleet"]) == [{"domain_filter": None, "refs": [("crew", "roster"), ("fleet", None)],
                                                         "label": "entities:crew.roster,fleet"}]
    assert plan("single", ["crew.roster", "nowhere"]) == [{"domain_filter": None, "label": "all"}]
    assert plan("single", []) == [{"domain_filter": None, "label": "all"}]
    monkeypatch.setattr(ah, "_LLM_FALLBACK_BATCH_CHARS", 160)
    fitted = plan("per_domain", ["crew"])
    assert len(fitted) > 1 and all(b["label"].startswith("domain:crew#") for b in fitted)
    assert sorted(t for b in fitted for t in b["product_filter"]) == ["base", "member", "roster"]
    for b in fitted:
        size = len(ah._llm_fallback_build_model_snapshot(d, p, a, domain_filter="crew", product_filter=b["product_filter"]))
        assert size <= 160 or len(b["product_filter"]) == 1, (b, size)
    text = "Give every column of the table crew.roster that has no business glossary term one."
    spec, _w = ah._vibe_scope_requested_spec([ah.RawVREQ(vreq_id="VREQ-0001", intent=text, target="crew.roster", source_quote=text,
                                                         source_chunk_id="c1")], base)
    ah.set_vibe_scope_runtime(ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG))
    assert [b["product_filter"] for b in plan("per_domain", ["crew"])] == [["roster"]], "only tables the run may change are sent"


def test_the_verification_sweep_shows_the_llm_only_the_named_table_with_its_glossary_terms():
    """Live a18 492254310643790 and a19 284506174299098: 'the table does not appear in the provided model-state snapshot'."""
    base = h.base_model()
    d, p, a, _mv = ah.model_to_widgets_flat(base)
    row = next(r for r in a if r["domain"] == "crew" and r["attribute"] == "roster_date")

    class _Agent:
        def __init__(self, strategy, affected):
            self.prompts = []
            self.classification = {"scope": "attribute", "affected_entities": affected, "batch_strategy": strategy, "operation_type": "mutate",
                                   "validation_hint": {"check_type": "none", "target_description": "", "expected_outcome": ""}}

        def _call_ai_query(self, prompt_name=None, prompt=None, **_kw):
            self.prompts.append((prompt_name, prompt))
            if prompt_name == "LLM_FALLBACK_CLASSIFY_PROMPT":
                return json.dumps(self.classification)
            return json.dumps({"summary": "filled", "mutations": [{"entity_type": "attribute", "operation": "modify", "entity_ref": "crew.roster.roster_date",
                                                                   "field": "business_glossary_term", "new_value": "Roster Date"}]})
    action = {"action": "set_property", "scope": "crew.roster", "name": "glossary", "target_state": "every column has a term", "reason": "vibe"}
    for strategy, shown in (("single", {"crew.roster"}), ("per_product", {"crew.roster"}), ("per_domain", {"crew.member", "crew.roster", "crew.base"})):
        row["business_glossary_term"] = ""
        agent = _Agent(strategy, ["crew.roster"])
        ctx = {"logger": h.LOG, "domains_data": d, "products_data": p, "attributes_data": a, "config": {}}
        assert ah._llm_fallback_handler(action, ctx, agent, "Give every column of crew.roster a glossary term.")
        executes = [prompt for name, prompt in agent.prompts if name == "LLM_FALLBACK_EXECUTE_PROMPT"]
        assert len(executes) == 1, strategy
        state = executes[0].split("CURRENT MODEL STATE", 1)[1].split("CROSS-DOMAIN FK TARGETS", 1)
        assert len(state) == 2, f"{strategy}: the FK target registry follows the snapshot"
        assert set(re.findall(r"TABLE: (\w+\.\w+)", state[0])) == shown, strategy
        assert "business_glossary_term = the business term for the column in Title Case" in executes[0]
        assert row["business_glossary_term"] == "Roster Date", strategy


def _roster_glossary_fence():
    base = h.base_model()
    roster = base["model"]["domains"][0]["products"][1]
    roster["attributes"].append(dict(copy.deepcopy(next(a for a in roster["attributes"] if a["name"] == "roster_date")), name="shift_code", type="STRING"))
    for attr in roster["attributes"]:
        attr["business_glossary_term"] = ""
    text = "Give every column of the table crew.roster that has no business glossary term one."
    spec, _w = ah._vibe_scope_requested_spec([ah.RawVREQ(vreq_id="VREQ-0001", intent=text, target="crew.roster", source_quote=text,
                                                         source_chunk_id="c1")], base)
    ah.set_vibe_scope_runtime(ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG))
    cur = copy.deepcopy(base)
    next(a for a in cur["model"]["domains"][0]["products"][1]["attributes"] if a["name"] == "roster_date")["business_glossary_term"] = "Crew Roster Date"
    return text, cur


def test_every_scoring_path_reads_a_field_limited_target_with_the_deterministic_verdict():
    """Live a19 284506174299098: the physical ground-truth audit scored 'give every column of customer.survey_campaign that
    has no business glossary term one' from model-wide glossary coverage (1015/2855, 35%), because its rows carry the
    glossary term only as a column tag; validate then sent the requirement to the LLM audit, which reported the table
    'byte-identical', and the run closed it as failed with 2 of the 4 columns filled."""
    from test_v406_verifier_false_negatives import _Req, _bare_orch
    text, cur = _roster_glossary_fence()
    orch = _bare_orch(ah.VibeOrchestrator)
    orch.config = {}
    phys = [{"domain": "crew", "product": "roster", "attribute": "roster_id", "foreign_key_to": "", "data_type": "bigint", "tags": {}},
            {"domain": "crew", "product": "roster", "attribute": "member_id", "foreign_key_to": "crew.member.member_id", "data_type": "bigint"},
            {"domain": "crew", "product": "roster", "attribute": "roster_date", "foreign_key_to": "", "data_type": "date",
             "tags": {"dbx_business_glossary_term": "Crew Roster Date"}},
            {"domain": "crew", "product": "roster", "attribute": "shift_code", "foreign_key_to": "", "data_type": "string",
             "tags": {"dbx_business_glossary_term": "Code of the shift the roster covers."}}]
    products = [{"domain": "crew", "product": "roster", "primary_key": "roster_id"}]
    verdict = orch._verify_deterministic(_Req(text, "VREQ-001", ["crew.roster"]), [{"domain": "crew"}], products, phys)
    assert verdict["status"] == "partial" and verdict["evidence"].startswith("[verifier-open-field-targets FIRED v5.3.3] 1/2"), verdict
    phys[3]["tags"] = {"dbx_business_glossary_term": "Crew Shift Code"}
    assert orch._verify_deterministic(_Req(text, "VREQ-001", ["crew.roster"]), [{"domain": "crew"}], products, phys)["status"] == "fulfilled"

    class _AuditLLM:
        calls = 0

        def _call_ai_query(self, **_kw):
            _AuditLLM.calls += 1
            return json.dumps({"verification_results": [{"requirement_id": "VREQ-001", "status": "failed", "evidence": "byte-identical"}],
                               "remediation_actions": [], "summary": {}})
    full = ah.VibeOrchestrator({"logger": h.LOG, "config": {}, "vibe_modelling_instructions": text, "operation": h.VOV})
    req = ah.VibeRequirement(id="VREQ-001", original_text=text, intent="glossary", scope="table", scope_targets=["crew.roster"],
                             verification_strategy="llm_verify")
    full.manifest = ah.VibeManifest(raw_text=text, requirements=[req])
    assert full.is_enabled
    full.ai_agent = _AuditLLM()
    full._llm_verify_enabled = True
    d, p, a, _mv = ah.model_to_widgets_flat(cur)
    full.widgets_values.update({"domains": d, "products": p, "attributes": a})
    full.validate()
    assert req.status == "partial" and req.evidence.startswith("[verifier-open-field-targets FIRED v5.3.3] 1/2"), (req.status, req.evidence)
    assert _AuditLLM.calls == 0, "a deterministic open-field verdict is not handed to the LLM audit"
    req.verification_strategy = "state_diff"
    assert full._verify_requirement(req, d, p, a)["evidence"].startswith("[verifier-open-field-targets FIRED v5.3.3] 1/2")


def test_a_partly_met_set_target_requirement_is_partial_not_failed():
    text, cur = _roster_glossary_fence()
    d, p, a, _mv = ah.model_to_widgets_flat(cur)
    wv = {"operation": h.VOV, "domains": d, "products": p, "attributes": a,
          "_vov_2_raw_vreqs": [{"vreq_id": "VREQ-0001", "intent": text, "target": "crew.roster", "source_quote": text}],
          "_vov_vreq_status": {"VREQ-0001": {"status": "noop_failed", "reason": "engine"}},
          "_vibe_input_map": {"items": {"i1": {"target": "crew.roster", "spans": [(0, 10)]}}, "vreqs": {"VREQ-0001": {"item_ids": ["i1"]}}},
          "_vibe_scope_outcomes": {"scope_rejected": [], "scope_fence_violation": [], "scope_dependency_conflict": [], "adherence_in_scope_pct": 0.0}}
    assert ah._vov_reconcile_final_outcomes(wv, h.LOG) == ["VREQ-0001"]
    assert wv["_vov_vreq_status"]["VREQ-0001"]["status"] == "partial"
    assert [(o["status"], o["vreq_ids"]) for o in wv["_vibe_input_outcomes"]] == [("partial", ["VREQ-0001"])]
    assert wv["_vibe_scope_outcomes"]["adherence_in_scope_pct"] == 0.0
    assert ah._vibe_input_fold([("V1", {"status": "failed"}), ("V2", {"status": "partial"})])[0] == "partial"
    assert ah._vibe_input_fold([("V1", {"status": "failed"}), ("V2", {"status": "deferred"})])[0] == "failed"


def test_a_glossary_fill_survives_the_serialization_cleanup_and_templates_are_placeholders():
    """Live b8 640584420933318: the sweep replaced 211 'GlossaryTerm_<column>' values with real terms, but the VOV reviewer
    finalization (P12) cleared every term equal to its column name on every run, so 75 terms such as 'Annual Budget Amount'
    became blank and the fence accepted the blanks. The snapshot also showed the 125 sentence values as terms, so the sweep
    left them, and 'Finance Column: <column>' templates and the agent's own 'Primary Key for <table>' terms passed as real
    terms."""
    defect = ah._v533_glossary_term_defect
    assert defect("Finance Column: budget_owner_name") == "placeholder" and defect("Primary Key for guest_visit") == "placeholder"
    assert defect("Unique surrogate identifier for a cost center record, used as the primary key for the cost_center entity.") == "sentence"
    assert defect("Preferred Store Identifier (PREFERRED_STORE_ID)") is None
    assert ah._v533_glossary_is_column_name("Annual Budget Amount", "annual_budget_amount")
    assert not ah._v533_glossary_is_column_name("Cost Center Annual Budget Amount", "annual_budget_amount")
    assert not ah._vibe_scope_bad_value("business_glossary_term", "Annual Budget Amount")
    assert ah._v533_identifier_term("guest_visit", "Identifier") == "Guest Visit Identifier"
    src = open(conftest.NOTEBOOK_PATH, encoding="utf-8").read()
    assert "Primary Key for {" not in src and "Reference to {best_target" not in src and "Reference to {forced_target" not in src
    base = h.base_model()
    roster = base["model"]["domains"][0]["products"][1]
    for attr in roster["attributes"]:
        attr["business_glossary_term"] = "GlossaryTerm_" + attr["name"]
    text = "Give every column of the table crew.roster that has no business glossary term one."
    spec, _w = ah._vibe_scope_requested_spec([ah.RawVREQ(vreq_id="VREQ-0001", intent=text, target="crew.roster", source_quote=text,
                                                         source_chunk_id="c1")], base)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    for value, kinds in (("", {"frozen_attr_changed": 1}), ("Roster Date", {"P6": 1}), ("Crew Duty Date", {"P6": 1})):
        cur = copy.deepcopy(base)
        next(a for a in cur["model"]["domains"][0]["products"][1]["attributes"] if a["name"] == "roster_date")["business_glossary_term"] = value
        assert fence.check(cur).summary()["by_kind"] == kinds, repr(value)
    cleaned = copy.deepcopy(base)
    attrs = cleaned["model"]["domains"][0]["products"][1]["attributes"]
    attrs[0]["business_glossary_term"], attrs[1]["business_glossary_term"] = attrs[0]["name"].replace("_", " ").title(), "Crew Duty Date"
    ah._v441_reviewer_finalization(cleaned, "Give every column of crew.roster a glossary term.", h.LOG)
    assert attrs[0]["business_glossary_term"] == attrs[0]["name"].replace("_", " ").title() and attrs[1]["business_glossary_term"] == "Crew Duty Date"
    ah._v441_reviewer_finalization(cleaned, "Clean up the auto-generated glossary terms of crew.roster.", h.LOG)
    assert attrs[0]["business_glossary_term"] == "" and attrs[1]["business_glossary_term"] == "Crew Duty Date"
    d, p, a, _mv = ah.model_to_widgets_flat(base)
    rows = {r["attribute"]: r for r in a if r["domain"] == "crew" and r["product"] == "roster"}
    names = list(rows)
    rows[names[0]]["business_glossary_term"] = "Date on which the crew roster applies."
    rows[names[1]]["business_glossary_term"] = "Crew Duty Date"
    snap = ah._llm_fallback_build_model_snapshot(d, p, a, domain_filter="crew", product_filter="roster")
    assert snap.count("[glossary:") == 1 and "[glossary: Crew Duty Date]" in snap and "GlossaryTerm_" not in snap


def test_the_serializer_and_the_attribute_factory_never_invent_a_glossary_term():
    """Decision 5A (live b8 640584420933318): the model.json serializer wrote the column name in Title Case into every empty
    glossary term, about 20% of the terms in base models, and the attribute factory wrote 'Product - Column', so coverage
    counted terms nobody wrote; every VOV then cleared every term equal to its column name, real ones included."""
    assert ah._modeljson_attr_obj({"attribute": "currency_code", "business_glossary_term": ""})["business_glossary_term"] == ""
    assert ah._modeljson_attr_obj({"attribute": "currency_code", "business_glossary_term": " Settlement Currency "})["business_glossary_term"] == "Settlement Currency"
    assert ah.make_attribute_dict("b", "crew", "roster", "shift_code")["business_glossary_term"] == ""
    assert ah.make_attribute_dict("b", "crew", "roster", "roster_id", glossary="Crew Roster Identifier")["business_glossary_term"] == "Crew Roster Identifier"
    assert ah._v533_vibe_asks_glossary_cleanup("Clean up the auto-generated glossary terms.")
    assert ah._v533_vibe_asks_glossary_cleanup("Remove the noise glossary tags")
    assert not ah._v533_vibe_asks_glossary_cleanup("Add a business glossary term to every column that has none.")
    assert not ah._v533_vibe_asks_glossary_cleanup("Remove the foreign key on campaign_id.")


def test_a_set_or_empty_requirement_target_falls_back_to_the_target_its_vibe_item_names():
    """Live b9 399314237946296: the vibe item was anchored 'target=finance', but the extractor gave the requirement a set
    target, so the fence opened the glossary field on every frozen record and named nothing."""
    base = h.base_model()
    vibe = ("## Domain: crew\n- (high) [crew] Add a business glossary term to every column of the crew domain that has none. "
            "<!-- vi:7f8dd164-a4ab-400a-be44-54b04e4b8dc2 target=crew -->\n")
    stripped, items = ah._vibe_input_strip(vibe)
    input_map = {"sha": ah._vibe_input_sha(stripped), "chars": len(stripped), "items": items, "vreqs": {}}
    quote = "[crew] Add a business glossary term to every column of the crew domain that has none."
    vreqs = [ah.RawVREQ(vreq_id="VREQ-0001", intent="In the crew domain, add a glossary term to every column that has none.", target=target,
                        source_quote=quote, source_chunk_id="c1") for target in ("*", "", "crew domain")]
    vreqs.append(ah.RawVREQ(vreq_id="VREQ-0002", intent="Describe crew.roster.", target="crew.roster", source_quote=quote, source_chunk_id="c1"))
    out = ah._vov_normalize_vreq_targets(vreqs, base, h.LOG, input_map=input_map, vibe_text=stripped)
    assert [v.target for v in out] == ["crew", "crew", "crew", "crew.roster"]
    assert [v.target for v in ah._vov_normalize_vreq_targets(vreqs[:1], base, h.LOG)] == ["*"], "no vibe item, no change"
    spec, _w = ah._vibe_scope_requested_spec(out[:1], base)
    assert spec.entries == ("crew",) and spec.open_fields == frozenset()
    assert spec.open_field_targets == {("crew", "", "attributes", "business_glossary_term")}
    assert ah._vov_target_is_wide("*") and ah._vov_target_is_wide("") and ah._vov_target_is_wide("crew domain")
    assert not ah._vov_target_is_wide("crew.*") and not ah._vov_target_is_wide("crew.roster")


def test_the_engine_cannot_call_an_open_field_requirement_already_satisfied_while_values_are_missing():
    """Live b9 399314237946296: the engine's handler returned an empty diff with 'already satisfied: ... targets the frozen
    out-of-scope finance domain', and the empty diff was counted as applied, so no corrective ran and nothing changed."""
    from test_v514_vibe_scope_vov_engine import _CannedLLM
    base = h.base_model()
    for attr in base["model"]["domains"][0]["products"][1]["attributes"]:
        attr["business_glossary_term"] = ""
    text = "Give every column of the table crew.roster that has no business glossary term one."
    spec, _w = ah._vibe_scope_requested_spec([ah.RawVREQ(vreq_id="VREQ-0001", intent=text, target="crew.roster", source_quote=text,
                                                         source_chunk_id="c1")], base)
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    noop = "def mutator(model, data):\n    return model\n"
    summary = "already satisfied: the table is frozen and no operation may add glossary terms"
    batch = ah.Batch(batch_id="B1", vreq_ids=("VREQ-0001",), intent_summary=text, target_entities=(("crew", "roster"),),
                     data_payload=({"intent": text, "target": "crew.roster", "source_quote": text},))
    handler = ah.Handler(batch_id="B1", mutator_src=noop, verifier_src="", expected_changes_summary=summary, target_entities=(("crew", "roster"),))
    model = copy.deepcopy(base)
    invariants = ah.capture_invariants(model, [], [], scope_fence=fence)
    llm = _CannedLLM(mutator=noop, summary=summary)
    new_model, outcome = ah._apply_handler_with_retry(handler, batch, model, invariants, llm, 3, (), (), 60.0)
    assert new_model is None and outcome.status == "noop_failed" and "already satisfied" in outcome.diagnostic, outcome
    assert fence.open_fields_needed(ah._vibe_scope_index(model)) == 3
    for attr in model["model"]["domains"][0]["products"][1]["attributes"]:
        attr["business_glossary_term"] = "Crew " + attr["name"].replace("_", " ").title()
    assert fence.open_fields_needed(ah._vibe_scope_index(model)) == 0
    invariants = ah.capture_invariants(model, [], [], scope_fence=fence)
    done, outcome = ah._apply_handler_with_retry(handler, batch, model, invariants, llm, 3, (), (), 60.0)
    assert outcome.status == "applied", "a requirement whose values are all present is already satisfied"


def test_model_json_carries_the_in_scope_adherence_after_the_final_outcomes():
    """Live b9 399314237946296: model.json said adherence_in_scope_pct 100.0 while the final outcomes failed the only
    requirement, because the scope facts are a copy taken before the final outcomes ran."""
    text, cur = _roster_glossary_fence()
    d, p, a, _mv = ah.model_to_widgets_flat(cur)
    outcomes = {"scope_rejected": [], "scope_fence_violation": [], "scope_dependency_conflict": [], "adherence_in_scope_pct": 100.0}
    wv = {"operation": h.VOV, "domains": d, "products": p, "attributes": a,
          "_vov_2_raw_vreqs": [{"vreq_id": "VREQ-0001", "intent": text, "target": "crew.roster", "source_quote": text}],
          "_vov_vreq_status": {"VREQ-0001": {"status": "noop_failed", "reason": "engine"}}, "_vibe_scope_outcomes": outcomes,
          "_vibe_scope_facts": {"mode": "requested", "outcomes": json.loads(json.dumps(outcomes))}}
    assert ah._vov_reconcile_final_outcomes(wv, h.LOG) == ["VREQ-0001"]
    assert wv["_vibe_scope_facts"]["outcomes"]["adherence_in_scope_pct"] == 0.0
    assert wv["_vibe_scope_facts"]["outcomes"] is not wv["_vibe_scope_outcomes"]


def test_only_the_clause_about_empty_values_is_fill_only():
    """Found while planning live run a21: in 'Improve the description of the table X and give each of its columns that has no
    business glossary term one' the empty-values phrase made the description fill-only too, so the description could not
    change, and the verifier would have counted the unchanged description as filled."""
    text = "Improve the description of the table crew.roster and give each of its columns that has no business glossary term one."
    assert ah._vibe_scope_fill_fields_for(text) == {("attributes", "business_glossary_term")}
    assert ah._vibe_scope_fill_fields_for("Give every column a glossary term. Only change columns that have none.") == {
        ("attributes", "business_glossary_term")}
    assert ah._vibe_scope_fill_fields_for("Rewrite every table description.") == frozenset()
    base = h.base_model()
    for attr in base["model"]["domains"][0]["products"][1]["attributes"]:
        attr["business_glossary_term"] = ""
    spec, _w = ah._vibe_scope_requested_spec([ah.RawVREQ(vreq_id="VREQ-0001", intent=text, target="crew.roster", source_quote=text,
                                                         source_chunk_id="c1")], base)
    assert spec.fill_only_fields == {("attributes", "business_glossary_term")}
    fence = ah.build_vibe_scope_fence(spec, base, h.VOV, h.LOG)
    ah.set_vibe_scope_runtime(fence)
    cur = copy.deepcopy(base)
    roster = cur["model"]["domains"][0]["products"][1]
    for attr in roster["attributes"]:
        attr["business_glossary_term"] = "Crew " + attr["name"].replace("_", " ").title()
    from test_v406_verifier_false_negatives import _Req
    d, p, a, _mv = ah.model_to_widgets_flat(cur)
    verdict = ah._vibe_scope_open_field_verdict(_Req(text, "VREQ-001", ["crew.roster"]), d, p, a)
    assert verdict["status"] == "partial" and "filled or changed" in verdict["evidence"], "the unchanged description is not counted"
    roster["description"] = "Which crew member flies which duty on which day."
    assert fence.check(cur).summary()["by_kind"] == {"P6": 4}
    d, p, a, _mv = ah.model_to_widgets_flat(cur)
    assert ah._vibe_scope_open_field_verdict(_Req(text, "VREQ-001", ["crew.roster"]), d, p, a)["status"] == "fulfilled"
