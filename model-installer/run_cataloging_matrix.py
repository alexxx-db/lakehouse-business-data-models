#!/usr/bin/env python3
"""Launch 6 parallel model-installer runs: 3 cataloging styles x (mvm, ecm) on automotive."""
import json
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

# Profiles known to allow CREATE CATALOG (probe before matrix run).
PROFILES = ["my-adp", "my-uae"]
PROFILE = PROFILES[0]
NOTEBOOK_LOCAL = "/Users/amr.ali/Documents/projects/lakehouse-business-data-models/model-installer/data-model-installer.ipynb"
NOTEBOOK_WS = "/Users/amr.ali@databricks.com/data-model-installer_cataloging_test"
INDUSTRY = "automotive"
TS = time.strftime("%Y%m%d_%H%M%S")

RUNS = [
    {"style": "One Catalog", "size": "mvm", "catalog": "t_%s_one_mvm" % TS, "profile": "my-adp"},
    {"style": "One Catalog", "size": "ecm", "catalog": "t_%s_one_ecm" % TS, "profile": "my-adp"},
    {"style": "Catalog per Domain", "size": "mvm", "catalog": "t_%s_dom_mvm" % TS, "profile": "my-adp"},
    {"style": "Catalog per Domain", "size": "ecm", "catalog": "t_%s_dom_ecm" % TS, "profile": "my-uae"},
    {"style": "Catalog per Division", "size": "mvm", "catalog": "t_%s_div_mvm" % TS, "profile": "my-adp"},
    {"style": "Catalog per Division", "size": "ecm", "catalog": "t_%s_div_ecm" % TS, "profile": "my-adp"},
]


def sh(cmd):
    return subprocess.run(cmd, shell=True, capture_output=True, text=True)


def deploy_notebook(profile=None):
    prof = profile or PROFILE
    r = sh(
        'databricks workspace import "%s" --file "%s" --format JUPYTER --language PYTHON --overwrite --profile %s'
        % (NOTEBOOK_WS, NOTEBOOK_LOCAL, prof)
    )
    if r.returncode != 0:
        raise RuntimeError("deploy failed: %s" % r.stderr)
    print("deployed notebook ->", NOTEBOOK_WS, "profile=", prof)


def submit_run(spec):
    job_name = "installer_cat_%s_%s_%s" % (
        spec["catalog"].replace("t_%s_" % TS, ""), INDUSTRY, TS)
    payload = {
        "run_name": job_name,
        "tasks": [
            {
                "task_key": "install",
                "notebook_task": {
                    "notebook_path": NOTEBOOK_WS,
                    "base_parameters": {
                        "model": INDUSTRY,
                        "model_size": spec["size"],
                        "catalog_name": spec["catalog"],
                        "cataloging_style": spec["style"],
                        "catalog_prefix": "t_%s_" % TS,
                        "catalog_suffix": "",
                        "local_install": "",
                        "session_id": "matrix_%s" % spec["catalog"],
                        "threads": "16",
                        "batch_size": "20",
                        "include_metrics": "true",
                        "source_repo": "databricks-industry-solutions/lakehouse-industry-data-models",
                        "source_ref": "main",
                        "github_token": "",
                    },
                },
                "timeout_seconds": 28800,
            }
        ],
    }
    path = "/tmp/installer_job_%s.json" % spec["catalog"]
    with open(path, "w") as f:
        json.dump(payload, f)
    r = sh("databricks jobs submit --json @%s --no-wait --profile %s -o json" % (path, spec.get("profile", PROFILE)))
    if r.returncode != 0:
        return {"spec": spec, "error": r.stderr, "run_id": None}
    data = json.loads(r.stdout)
    run_id = data.get("run_id")
    return {"spec": spec, "run_id": run_id, "error": None}


def poll_run(run_id, profile=None):
    prof = profile or PROFILE
    while True:
        r = sh("databricks jobs get-run %s --profile %s -o json" % (run_id, prof))
        if r.returncode != 0:
            return {"run_id": run_id, "state": "POLL_ERROR", "result": r.stderr}
        data = json.loads(r.stdout)
        state = data.get("state", {})
        life = state.get("life_cycle_state", "")
        result = state.get("result_state", "")
        if life == "TERMINATED":
            return {"run_id": run_id, "state": life, "result": result}
        time.sleep(30)



def main():
    profiles = sorted(set(s.get("profile", PROFILE) for s in RUNS))
    for prof in profiles:
        deploy_notebook(prof)
    submitted = []
    with ThreadPoolExecutor(max_workers=4) as ex:
        futs = [ex.submit(submit_run, s) for s in RUNS if s["style"] != "Catalog per Division"]
        for fut in as_completed(futs):
            submitted.append(fut.result())
    for s in RUNS:
        if s["style"] != "Catalog per Division":
            continue
        submitted.append(submit_run(s))

    print("\nSubmitted runs:")
    for s in submitted:
        if s.get("error"):
            print(" FAIL submit", s["spec"], s["error"][:200])
        else:
            print(" run_id=%s style=%s size=%s catalog=%s" % (
                s["run_id"], s["spec"]["style"], s["spec"]["size"], s["spec"]["catalog"]))

    ok_ids = [s["run_id"] for s in submitted if s.get("run_id")]
    if not ok_ids:
        sys.exit(1)

    results = []
    with ThreadPoolExecutor(max_workers=6) as ex:
        futs = {ex.submit(poll_run, s["run_id"], s.get("profile", PROFILE)): s["run_id"]
              for s in submitted if s.get("run_id")}
        for fut in as_completed(futs):
            results.append(fut.result())

    manifest = "/tmp/installer_cataloging_matrix_%s.json" % TS
    with open(manifest, "w") as f:
        json.dump({"submitted": submitted, "terminal": results, "ts": TS}, f, indent=2)
    print("\nManifest:", manifest)
    for r in results:
        print(" run_id=%s result=%s" % (r["run_id"], r.get("result")))


if __name__ == "__main__":
    main()
