"""A vibe_scope artifact is a delta: the tables the run kept are `CREATE TABLE IF NOT EXISTS` with no
foreign keys, tags or metric views, because on the base version they already exist. The agent writes
those statements to `*_vibe_scope_preserved_*.sql` completion files. The installer runs them only into
a catalog that holds none of the model's schemas, and skips them on the base version.
"""
from installer_harness import (BASE_V1_TABLES, REGISTRY_COLUMNS, FakeUC, load_pipeline, pipeline_cfg,
                               registry_row, scoped_folder)

MODEL_JSON = {"agent_version": "5.3.3", "model_requirements": {"business_name": "Demo Air"},
              "_vibe_scope": {"mode": "requested", "entries": ["sales"], "base_version": "1",
                              "operation": "vibe modeling of version"},
              "model": {"version": "v2_mvm", "domains": []}}
COMPLETION = ("-- vibe_scope completion\n"
              "ALTER TABLE `demo`.`sales`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_glossary' = 'Order Id');\n"
              "ALTER TABLE `demo`.`sales`.`order` ADD CONSTRAINT `fk_order_pair` FOREIGN KEY (`order_id`) "
              "REFERENCES `demo`.`sales`.`customer_v2` (`customer_id`);\n")


def _install(tmp_path, tables, rows, model_json=MODEL_JSON):
    folder = scoped_folder(tmp_path, model_json=model_json)
    (folder / "schemas" / "demo_vibe_scope_preserved_v2_mvm.sql").write_text(COMPLETION)
    spark = FakeUC(tables, columns=REGISTRY_COLUMNS, rows=rows)
    ns = load_pipeline(spark, extra_cells=("def uninstall(cfg)", "def guard_scoped_install"))
    cfg = pipeline_cfg(folder)
    plan = ns["build_plan"](cfg)
    held = sum(len(v) for v in cfg["vibe_scope_completion"].values())
    model = ns["load_model_json"](cfg)
    ns["guard_scoped_install"](cfg, plan, model)
    final, _, _ = ns["install"](cfg, plan)
    return ns, plan, final, spark, held


def test_build_plan_holds_the_completion_statements_back(tmp_path):
    ns, plan, final, spark, held = _install(tmp_path, BASE_V1_TABLES, [registry_row(1, business="Demo Air")])
    assert held == 2


def test_an_install_into_an_empty_catalog_runs_the_completion_file(tmp_path):
    ns, plan, final, spark, held = _install(tmp_path, {}, [])
    assert final == []
    order = spark.tables["demo.sales.order"]
    assert order["fks"] == {"fk_order_customer": "demo.sales.customer_v2", "fk_order_pair": "demo.sales.customer_v2"}
    assert "dbx_glossary" in order["tags"].get("order_id", "")
    assert any("running 2 completion statement(s)" in line for line in ns["_log_lines"])


def test_an_install_on_the_base_version_skips_the_completion_file(tmp_path):
    ns, plan, final, spark, held = _install(tmp_path, BASE_V1_TABLES, [registry_row(1, business="Demo Air")])
    assert final == []
    order = spark.tables["demo.sales.order"]
    assert "fk_order_pair" not in order["fks"] and "order_id" not in order["tags"]
    assert any("skipping 2 completion statement(s)" in line for line in ns["_log_lines"])
    assert not spark.position("fk_order_pair")


def test_without_a_vibe_scope_block_the_catalog_decides(tmp_path):
    bare = {"agent_version": "5.3.3", "model_requirements": {"business_name": "Demo Air"}, "model": {"version": "v2_mvm", "domains": []}}
    ns, plan, final, spark, held = _install(tmp_path, {}, [], model_json=bare)
    assert "fk_order_pair" in spark.tables["demo.sales.order"]["fks"]
    ns, plan, final, spark, held = _install(tmp_path / "again", BASE_V1_TABLES, [], model_json=bare)
    assert not spark.position("fk_order_pair")
