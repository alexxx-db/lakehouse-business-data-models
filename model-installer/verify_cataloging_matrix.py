#!/usr/bin/env python3
"""Verify physical catalog layout after cataloging-style installer runs."""
import json
import subprocess
import sys

MANIFEST = sys.argv[1] if len(sys.argv) > 1 else "/tmp/installer_matrix_20260709_1635.json"
DEFAULT_PROFILE = sys.argv[2] if len(sys.argv) > 2 else "my-adp"


def sh(cmd):
    r = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return r.stdout, r.stderr, r.returncode


def sql_query(statement):
    out, err, code = sh(
        'databricks experimental aiotools sql --profile %s --statement %s -o json'
        % (PROFILE, json.dumps(statement))
    )
    if code != 0:
        # fallback: api statement execution not always available
        return None
    try:
        return json.loads(out)
    except Exception:
        return None


def list_catalogs(profile):
    out, err, code = sh("databricks catalogs list --profile %s -o json" % profile)
    if code != 0:
        raise RuntimeError(err)
    data = json.loads(out)
    items = data if isinstance(data, list) else data.get("catalogs", data)
    skip = {"hive_metastore", "samples", "system", "__databricks_internal"}
    return [c["name"] for c in items if c.get("name") not in skip and c.get("catalog_type", "") != "SYSTEM_CATALOG"]


def count_tables(catalog, schema):
    stmt = "SHOW TABLES IN `%s`.`%s`" % (catalog, schema)
    out, err, code = sh(
        'databricks api post /api/2.0/sql/statements --profile %s -o json --json \'{"warehouse_id":"auto","statement":"%s","wait_timeout":"30s"}\''
        % (PROFILE, stmt.replace("'", "\\'"))
    )
    return None


def verify_run(spec, all_catalogs):
    prefix = spec.get("catalog_prefix", "")
    base = spec["catalog"]
    style = spec["style"]
    issues = []
    matched = [c for c in all_catalogs if c.startswith(prefix) or c == base]

    if style == "One Catalog":
        if base not in all_catalogs:
            issues.append("base catalog %s missing" % base)
        return issues, matched

    if style == "Catalog per Domain":
        domain_cats = [c for c in matched if c != base and c.startswith(prefix)]
        if len(domain_cats) < 5:
            issues.append("expected >=5 domain catalogs with prefix %r, found %d" % (prefix, len(domain_cats)))
        if base not in all_catalogs:
            issues.append("base catalog %s missing (_metrics host)" % base)
        return issues, matched

    if style == "Catalog per Division":
        for div in ("operations", "business", "corporate"):
            name = "%s%s" % (prefix, div)
            if name not in all_catalogs:
                issues.append("division catalog %s missing" % name)
        if base not in all_catalogs:
            issues.append("base catalog %s missing (_metrics host)" % base)
        return issues, matched

    return ["unknown style"], matched


def main():
    runs = json.load(open(MANIFEST))
    terminal = []
    for spec in runs:
        rid = spec["run_id"]
        profile = spec.get("profile", DEFAULT_PROFILE)
        out, err, code = sh("databricks jobs get-run %s --profile %s -o json" % (rid, profile))
        d = json.loads(out)
        st = d.get("state", {})
        terminal.append({
            "run_id": rid,
            "style": spec["style"],
            "size": spec["size"],
            "catalog": spec["catalog"],
            "life_cycle_state": st.get("life_cycle_state"),
            "result_state": st.get("result_state"),
        })

    report = {"terminal": terminal, "catalog_checks": []}
    for spec in runs:
        spec = dict(spec)
        profile = spec.get("profile", DEFAULT_PROFILE)
        spec["catalog_prefix"] = spec["catalog"].rsplit("_", 2)[0] + "_"
        cats = list_catalogs(profile)
        issues, matched = verify_run(spec, cats)
        report["catalog_checks"].append({
            "style": spec["style"],
            "size": spec["size"],
            "catalog": spec["catalog"],
            "matched_catalogs": matched,
            "issues": issues,
        })

    out_path = MANIFEST.replace(".json", "_verify.json")
    json.dump(report, open(out_path, "w"), indent=2)
    print(json.dumps(report, indent=2))
    print("saved", out_path)


if __name__ == "__main__":
    main()
