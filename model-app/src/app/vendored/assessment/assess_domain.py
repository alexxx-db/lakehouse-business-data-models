# Databricks notebook source
# MAGIC %md
# MAGIC # Headless domain-model-assessment — one domain
# MAGIC Reads a `config.json` (path in the `config_path` parameter), runs a read-only pre-flight, installs the Genie Code
# MAGIC CLI, stages the skills bundled with the job (never fetched at run time) + a `conventions.yml` for this domain, runs `genie exec` (Phases 0–4, read-only)
# MAGIC with a `progress.json` heartbeat, validates the structured `assessment.json`, and copies everything to the runs volume.
# MAGIC Invoked once per domain by the `vibe-assess` job. The Genie Code CLI and the Databricks CLI are pinned by tag
# MAGIC and sha256 (VERSIONS.json, passed in `config.json`) and verified before every use.

# COMMAND ----------

import json
import os
import platform
import random
import shutil
import subprocess
import sys
import tarfile
import time
import urllib.request
import zipfile
from pathlib import Path

from databricks.sdk import WorkspaceClient


def param(name, default=""):
    try:
        return dbutils.widgets.get(name) or default
    except Exception:
        return default


# Sibling workspace files (skills/, prompt, schemas, assess_lib.py) live next to this notebook.
notebook_dir = "/Workspace" + os.path.dirname(
    dbutils.notebook.entry_point.getDbutils().notebook().getContext().notebookPath().get())
try:
    import assess_lib
except ImportError:
    sys.path.insert(0, notebook_dir)
    import assess_lib

cfg = assess_lib.load_config(param("config_path"))
domain = cfg["domain"]
run_id = cfg["batch_id"]
genie_version = cfg["genie"]["tag"]
genie_model = cfg["genie_model"]
timeout_s = int(cfg["timeout_minutes"]) * 60

skills_path = f"{notebook_dir}/skills"
prompt_path = f"{notebook_dir}/assess_prompt.md"
schema_path = f"{notebook_dir}/assess_result.schema.json"
assessment_schema_path = f"{notebook_dir}/assessment.schema.json"

work = Path(f"/tmp/vibe_assess/{run_id}/{domain}")
tools = Path("/tmp/vibe_assess/_tools")
project = work / "project"
genie_home = work / "genie_home"
out_dir = Path(cfg["out_dir"])
for p in (tools, project, genie_home, out_dir):
    p.mkdir(parents=True, exist_ok=True)

progress = assess_lib.ProgressWriter(out_dir / "progress.json")
progress.write("preflight")

timings = {}
print(f"domain={domain} run_id={run_id} machine={platform.machine()} out={out_dir}")

# COMMAND ----------

# MAGIC %md ## Pre-flight (read-only, as the job's run_as identity — before installing anything)

# COMMAND ----------

w = WorkspaceClient()
warehouse_id = cfg["warehouse_id"]


def preflight_fail(label, reason):
    progress.write("preflight_failed", last_message=f"{label}: {reason}")
    (out_dir / "summary.json").write_text(json.dumps(
        {"domain": domain, "preflight": {"ok": False, "failed": label, "reason": reason}}, indent=2))
    raise RuntimeError(f"pre-flight failed for {domain} at {label}: {reason}")


def run_sql(sql):
    """Returns (state, first_cell_as_int_or_None, error_message)."""
    r = w.statement_execution.execute_statement(warehouse_id=warehouse_id, statement=sql, wait_timeout="50s")
    state = str(r.status.state.value if hasattr(r.status.state, "value") else r.status.state)
    if state != "SUCCEEDED":
        return state, None, (r.status.error.message if r.status.error else state)
    rows = r.result.data_array if r.result else None
    return state, (int(rows[0][0]) if rows and rows[0] and rows[0][0] is not None else None), ""


for label, sql in assess_lib.preflight_statements(cfg):
    try:
        state, n, err = run_sql(sql)
    except Exception as e:
        preflight_fail(label, repr(e)[:300])
    if state != "SUCCEEDED":
        preflight_fail(label, err[:300])
    if (label.startswith("bronze:") or label == "physical") and not n:
        preflight_fail(label, "no tables found in schema")
    print(f"preflight {label}: ok ({n})")

def metamodel_columns(table):
    r = w.statement_execution.execute_statement(
        warehouse_id=warehouse_id, statement=assess_lib.metamodel_columns_statement(cfg, table), wait_timeout="50s")
    state = str(r.status.state.value if hasattr(r.status.state, "value") else r.status.state)
    if state != "SUCCEEDED":
        preflight_fail("version", f"cannot read columns of {table}: {(r.status.error.message if r.status.error else state)[:250]}")
    return {row[0].lower() for row in (r.result.data_array if r.result else None) or []}


# Pinned model version must exist for this domain (column-aware; skipped when the metamodel has no version column).
version_check = "ok"
product_cols = metamodel_columns("product")
domain_cols = set() if (not product_cols or "domain" in product_cols) else metamodel_columns("domain")
action, detail = assess_lib.version_check_plan(cfg, product_cols, domain_cols)
if action == "fail":
    preflight_fail("version", detail)
elif action == "skip":
    version_check = detail
    print(f"preflight version: {version_check}")
else:
    try:
        state, n, err = run_sql(detail)
    except Exception as e:
        state, n, err = "FAILED", None, repr(e)
    if state != "SUCCEEDED":
        preflight_fail("version", err[:300])
    elif not n:
        _biz, _scope, _ver = assess_lib.version_check_values(cfg)
        preflight_fail("version", f"no products for domain {domain}, business {_biz}, scope {_scope}, version {_ver}")
    else:
        print(f"preflight version: ok ({n} products)")

# COMMAND ----------

# MAGIC %md ## Install Genie Code CLI + Databricks CLI

# COMMAND ----------


def fetch(url, dest):
    req = urllib.request.Request(url, headers={"User-Agent": "vibe-assess"})
    with urllib.request.urlopen(req, timeout=300) as r, open(dest, "wb") as f:
        shutil.copyfileobj(r, f)
    return dest


try:
    progress.write("installing")
    t0 = time.time()
    downloads = assess_lib.tool_downloads(cfg, platform.machine())

    # Tag-keyed cache (/tmp/vibe_assess/_tools/<tool>/<tag>/); the archive is re-hashed against the pin before
    # every reuse and the binaries are re-extracted from it, so nothing unverified runs.
    genie_dir = tools / "genie" / downloads["genie"]["tag"]
    tgz = assess_lib.ensure_pinned_archive(genie_dir, downloads["genie"], fetch)
    shutil.rmtree(genie_dir / "pkg", ignore_errors=True)
    with tarfile.open(tgz) as tf:
        tf.extractall(genie_dir / "pkg")
    genie_bin = next(p for p in (genie_dir / "pkg").rglob("genie") if p.is_file())
    for p in genie_bin.parent.iterdir():
        p.chmod(0o755)

    cli_dir = tools / "databricks_cli" / downloads["databricks_cli"]["tag"]
    z = assess_lib.ensure_pinned_archive(cli_dir, downloads["databricks_cli"], fetch)
    shutil.rmtree(cli_dir / "bin", ignore_errors=True)
    with zipfile.ZipFile(z) as zf:
        zf.extract("databricks", cli_dir / "bin")
    db_bin = cli_dir / "bin" / "databricks"
    db_bin.chmod(0o755)

    print(subprocess.run([str(genie_bin), "--version"], capture_output=True, text=True).stdout.strip())
    print(subprocess.run([str(db_bin), "--version"], capture_output=True, text=True).stdout.strip())
    timings["install_s"] = round(time.time() - t0, 1)


    # Auth and Genie config


    host = w.config.host.rstrip("/")
    token = w.config.authenticate()["Authorization"].split(" ", 1)[1]
    workspace_id = w.get_workspace_id()
    print(f"host={host} workspace_id={workspace_id} warehouse_id={warehouse_id}")

    (genie_home / "config.toml").write_text(f'''model_provider = "databricks"
    model = "{genie_model}"
    model_reasoning_effort = "{cfg["reasoning_effort"]}"

    [model_providers.databricks]
    name = "Databricks AI Gateway"
    base_url = "{host}/ai-gateway/codex/v1"
    wire_api = "responses"
    env_key = "DATABRICKS_TOKEN"
    # Ride out AI Gateway 429s (workspace tokens-per-minute limit) with exponential backoff.
    request_max_retries = 20
    stream_max_retries = 20

    [model_providers.databricks.http_headers]
    x-databricks-workspace-id = "{workspace_id}"
    ''')


    # Stage the project root (skills + conventions.yml + schemas)


    # Skills come only from the bundle next to this notebook (the release's pinned snapshot); nothing is fetched.
    skills_dst = project / ".agents" / "skills"
    shutil.rmtree(skills_dst, ignore_errors=True)
    skills_info = assess_lib.stage_bundled_skills(Path(skills_path), skills_dst, list(cfg["skills"]))
    print("skills:", skills_info)

    (project / "conventions.yml").write_text(assess_lib.render_conventions(cfg, run_id))
    shutil.copyfile(assessment_schema_path, project / "assessment.schema.json")

    if cfg.get("prior_tiers"):
        (project / "docs" / "inputs").mkdir(parents=True, exist_ok=True)
        (project / "docs" / "inputs" / "prior_tiers.json").write_text(json.dumps(cfg["prior_tiers"], indent=2))

    prompt = (
        Path(prompt_path).read_text()
        .replace("{domain}", domain)
        .replace("{warehouse_id}", warehouse_id)
    )
    git_ok = subprocess.run("git init -q && git add -A && git -c user.email=job@local -c user.name=vibe-assess commit -qm seed",
                            shell=True, cwd=project, capture_output=True, text=True)
    print("git:", git_ok.returncode, git_ok.stderr.strip()[:300])


    # Run `genie exec`


    env = {k: v for k, v in os.environ.items() if not k.startswith(("DATABRICKS_", "GENIE_"))}
    env.update({
        "GENIE_HOME": str(genie_home),
        "HOME": str(work),
        "PATH": f"{genie_bin.parent}:{db_bin.parent}:{env.get('PATH', '/usr/bin:/bin')}",
        "DATABRICKS_HOST": host,
        "DATABRICKS_TOKEN": token,
        "DATABRICKS_AUTH_TYPE": "pat",
        "DATABRICKS_WAREHOUSE_ID": warehouse_id,
    })
    # Job-level backoff: the AI Gateway enforces a per-workspace tokens-per-minute limit that genie's own
    # request retries can't outlast, and every agent turn resends the full context. When a turn dies on a
    # 429 we wait (exponential + jitter) and `genie exec resume` the SAME session, so completed work isn't redone.
    max_resumes = int(cfg["max_resumes"])
    backoff_base_s = int(cfg["backoff_base_seconds"])
    backoff_max_s = 300
    HEARTBEAT_S = 60
    resume_prompt = (
        "You were interrupted by a model rate limit (HTTP 429), not by an error in your work. Continue the same "
        "unattended assessment from exactly where you stopped: do not restart completed phases or re-run queries "
        "whose results you already have. The headless contract and mapping quality bar from the original "
        "instructions still apply. Finish with the structured summary the output schema asks for."
    )
    common = [
        "--json",
        # The job container is the external sandbox; the prompt enforces read-only on the data layer.
        "--dangerously-bypass-approvals-and-sandbox",
        "--output-schema", schema_path,
        "-o", str(work / "result.json"),
    ]


    def read_events(path):
        out = []
        for l in path.read_bytes().decode("utf-8", "replace").splitlines():
            if l.startswith("{"):
                try:
                    out.append(json.loads(l))
                except ValueError:
                    pass  # partial line while genie is still writing
        return out


    def run_attempt(n, args, stdin_text, remaining_s, label="assessing"):
        ev_path = work / f"events.{n:02d}.jsonl"
        with open(ev_path, "w") as ev, open(work / "stderr.log", "a") as er:
            er.write(f"\n===== attempt {n} =====\n")
            er.flush()
            proc = subprocess.Popen(args, stdin=subprocess.PIPE, stdout=ev, stderr=er, env=env, cwd=project, text=True)
            proc.stdin.write(stdin_text)
            proc.stdin.close()
            deadline = time.time() + max(remaining_s, 60)
            rc = None
            try:
                while rc is None:
                    try:
                        rc = proc.wait(timeout=min(HEARTBEAT_S, max(deadline - time.time(), 1)))
                    except subprocess.TimeoutExpired:
                        if time.time() >= deadline:
                            proc.kill()
                            proc.wait()
                            rc = "timeout"
                        else:
                            try:  # best-effort: a heartbeat failure must never abort the run
                                progress.write(label, attempt=n,
                                               last_message=assess_lib.last_agent_message(read_events(ev_path)))
                            except Exception as hb_err:
                                print(f"WARNING: heartbeat failed: {hb_err!r}")
            finally:
                if proc.poll() is None:
                    proc.kill()
                    proc.wait()
        evs = read_events(ev_path)
        return {"n": n, "rc": rc, "events": evs, **assess_lib.classify_attempt(evs)}


    t0 = time.time()
    (work / "stderr.log").write_text("")
    attempts, thread_id, waited_s = [], None, 0.0
    args, stdin_text = [str(genie_bin), "exec", *common, "-C", str(project), "-"], prompt
    for n in range(max_resumes + 1):
        progress.write("assessing", attempt=n)
        a = run_attempt(n, args, stdin_text, timeout_s - (time.time() - t0))
        thread_id = thread_id or a["thread_id"]
        attempts.append(a)
        print(f"attempt {n}: rc={a['rc']} completed={a['completed']} rate_limited={a['rate_limited']} "
              f"errors={[x[:120] for x in a['errors']]}")
        if a["rc"] == 0 and a["completed"] and not a["errors"]:
            break
        if not a["rate_limited"] or thread_id is None or n == max_resumes:
            break
        wait = min(backoff_max_s, backoff_base_s * 2 ** n) + random.uniform(0, 15)
        if time.time() - t0 + wait > timeout_s:
            print("out of time budget for another resume")
            break
        print(f"rate limited; sleeping {wait:.0f}s then resuming session {thread_id}")
        progress.write("rate_limited", attempt=n, rate_limited=True, resume_at=time.time() + wait)
        time.sleep(wait)
        waited_s += wait
        args, stdin_text = [str(genie_bin), "exec", "resume", *common, thread_id, "-"], resume_prompt

    # Validate the structured detail; one repair resume if it doesn't match the schema.
    progress.write("validating")
    assessment_path = project / "docs" / "design" / "assessment.json"
    assessment_schema = json.loads(Path(assessment_schema_path).read_text())

    def check_assessment():
        if not assessment_path.exists():
            return ["docs/design/assessment.json was not written"]
        try:
            return assess_lib.validate_assessment(json.loads(assessment_path.read_text()), assessment_schema)
        except ValueError as e:
            return [f"assessment.json is not valid JSON: {e}"]

    final = attempts[-1]  # pass/fail (rc, errors) comes from the main run, never from the repair turn
    repair_attempts = []
    errs = check_assessment() if (final["rc"] == 0 and final["completed"] and not final["errors"]) else ["genie exec did not complete"]
    if errs and thread_id and final["rc"] == 0 and final["completed"]:
        fix_prompt = ("assessment.json failed validation. Fix ONLY docs/design/assessment.json so it validates "
                      "against assessment.schema.json. Errors:\n" + "\n".join(errs))
        n = len(attempts)
        progress.write("validating", attempt=n)
        repair_common = [*common[:-1], str(work / "result.repair.json")]  # keep the main run's result.json
        a = run_attempt(n, [str(genie_bin), "exec", "resume", *repair_common, thread_id, "-"], fix_prompt,
                        max(timeout_s - (time.time() - t0), 600), label="validating")
        repair_attempts.append(a)
        errs = check_assessment()
    results_valid = not errs

    rc = final["rc"]
    with open(work / "events.jsonl", "w") as ev:
        for a in attempts + repair_attempts:
            ev.write(json.dumps({"type": "harness.attempt", "n": a["n"], "rc": a["rc"], "rate_limited": a["rate_limited"]}) + "\n")
            for e in a["events"]:
                ev.write(json.dumps(e) + "\n")
    timings["genie_exec_s"] = round(time.time() - t0, 1)
    timings["backoff_wait_s"] = round(waited_s, 1)
    timings["attempts"] = len(attempts)
    print("genie exec rc:", rc, timings)

    # Persist outputs to the volume.
    progress.write("writing_outputs")
    for name in ("events.jsonl", "stderr.log", "result.json"):
        if (work / name).exists():
            raw = (work / name).read_bytes().decode("utf-8", "replace")
            (out_dir / name).write_text(assess_lib.redact(raw, [token]))
    (out_dir / "conventions.yml").write_text((project / "conventions.yml").read_text())
    if (project / "docs").exists():
        shutil.copytree(project / "docs", out_dir / "docs", dirs_exist_ok=True, copy_function=shutil.copyfile)

    events = read_events(work / "events.jsonl")
    event_types = {}
    for e in events:
        event_types[e.get("type", "?")] = event_types.get(e.get("type", "?"), 0) + 1
    result = json.loads((work / "result.json").read_text()) if (work / "result.json").exists() else None
    summary = {
        "domain": domain, "rc": rc, "timings": timings, "warehouse_id": warehouse_id,
        "event_types": event_types, "result": result,
        "docs": sorted(str(p.relative_to(project)) for p in (project / "docs").rglob("*") if p.is_file())
        if (project / "docs").exists() else [],
        "out_dir": str(out_dir),
    }
    errors = final["errors"]  # earlier attempts' 429s were recovered from; only the last attempt decides
    summary["errors"] = errors
    summary["thread_id"] = thread_id
    summary["skills"] = skills_info
    # The output contract this run wrote against; the app refuses versions it doesn't support.
    summary["schema_version"] = assessment_schema.get("x-schema-version")
    summary["genie_version"] = genie_version
    summary["results_valid"] = results_valid
    summary["validation_errors"] = errs[:10]
    summary["preflight"] = {"ok": True, "version_check": version_check}
    summary["repair"] = ({k: repair_attempts[0][k] for k in ("rc", "completed", "rate_limited")}
                         | {"errors": [x[:200] for x in repair_attempts[0]["errors"]]}) if repair_attempts else None
    summary["attempts"] = [{k: a[k] for k in ("n", "rc", "completed", "rate_limited")} | {"errors": [x[:200] for x in a["errors"]]}
                           for a in attempts]
    (out_dir / "summary.json").write_text(json.dumps(summary, indent=2))
    print(json.dumps(summary, indent=2)[:4000])
    # Fails only on non-429 genie failure; results_valid=false still exits 0.
    if rc != 0 or errors or result is None:
        raise RuntimeError(f"genie exec failed for {domain}: rc={rc} errors={errors[:1]} result={'present' if result else 'missing'}")
    progress.write("done")
except Exception as e:
    progress.write("failed", last_message=repr(e)[:300])
    raise

dbutils.notebook.exit(json.dumps({k: summary[k] for k in ("domain", "rc", "timings", "out_dir")}
                                 | {"status": (result or {}).get("status"), "results_valid": results_valid}))
