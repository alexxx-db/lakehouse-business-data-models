"""v5.3.3: the defects the live validation of 5.3.2 found.

- R34 651377744624962, R35 155237215962513 and R43 902627616694840: the final artifact carry-over copied the base
  version's schemas/ and metrics/ files into the new version folder, so the folder carried domains the model no longer
  has (client, inventory, audience, partner), a stale cross-domain FK file and, in time, an old vibe_scope drop file.
"""
import copy
import io
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
    next(p for d in new["model"]["domains"] if d["name"] == "flight" for p in d["products"] if p["name"] == "scheduled_flight")["description"] = "x"
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
