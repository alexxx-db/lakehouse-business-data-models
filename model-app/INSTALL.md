# Installing Vibe Data Modeling

Install the Vibe Data Modeling app on a Databricks workspace (AWS or Azure). End-to-end time: **~10 minutes**.

The canonical install path is [`install/install.sh`](install/install.sh) — it runs `bundle deploy`, provisions Lakebase, grants Unity Catalog privileges, starts the app, and pushes the built source. Idempotent — safe to re-run.

## TL;DR — copy-paste install

Once the prerequisites below are in place:

```bash
git clone https://github.com/databricks-industry-solutions/lakehouse-industry-data-models.git
cd lakehouse-industry-data-models/model-app

bash install/install.sh \
  --profile        my-workspace      \
  --app-name       vibe-modeling     \
  --project        vibe-modeling     \
  --catalog        vibe_modeling     \
  --warehouse-id   <sql-warehouse-id>
```

Substitute your CLI profile name and SQL warehouse ID. Total wall-clock: ~10 minutes on a fresh workspace. Skip `--warehouse-id` to configure it later via the first-run UI.

`install/install.sh` also takes flags for the two optional features (`--enable-taxonomy-builder`, `--taxonomy-model-service`, `--enable-assessment`, `--assess-reader-sp`). Every flag is listed in [Parameter reference](#parameter-reference) below.

## Privileges required

Pick **one** of the two paths below.

### Path A: Workspace Admin (simplest)

Workspace Admin on the target workspace covers every grant the installer needs by default. No extra setup. **Recommended for first installs.**

### Path B: Non-admin grant matrix

If you install as a non-admin identity, you need **all** of the following on the target workspace:

- **Create Databricks Apps** — [AWS](https://docs.databricks.com/aws/en/dev-tools/databricks-apps/get-started) · [Azure](https://learn.microsoft.com/en-us/azure/databricks/dev-tools/databricks-apps/get-started)
- **Create Lakebase Postgres projects** — [AWS](https://docs.databricks.com/aws/en/oltp/projects/get-started) · [Azure](https://learn.microsoft.com/en-us/azure/databricks/oltp/projects/get-started)
- **Deploy Databricks Asset Bundles** to your `/Workspace/Users/<you>` tree — [AWS](https://docs.databricks.com/aws/en/dev-tools/bundles/) · [Azure](https://learn.microsoft.com/en-us/azure/databricks/dev-tools/bundles/)
- **Grant authority on the target Unity Catalog** — `install/install.sh` issues these grants automatically to the new App service principal:
  - `USE CATALOG`, `CREATE SCHEMA`, `BROWSE` on the catalog passed via `--catalog`
    (`BROWSE` is required by the agent's `_create_metrics_database_if_needed` step,
    which probes whether the `_metrics` schema already exists by reading catalog
    metadata)
  - On the `_metamodel` schema in that catalog, on every install: the installer creates the schema and its `vol_root` volume if absent, then grants `USE SCHEMA`, `CREATE TABLE`, `MODIFY`, `SELECT`, `READ VOLUME`, `WRITE VOLUME`, `CREATE VOLUME` and `MANAGE`. The `*_VOLUME` privileges cascade to current and future volumes. `CREATE VOLUME` and `MANAGE` are granted whether or not you enable the bronze assessment; they let the app create its assessment runs volume and grant the assessment reader access to it.

  To issue those, the installer's identity needs one of: **catalog ownership**, **`MANAGE` on the catalog**, or **metastore-admin**.
- **Permission to create UC catalogs** if `--catalog` points at one that doesn't exist yet — [AWS](https://docs.databricks.com/aws/en/catalogs/create-catalog) · [Azure](https://learn.microsoft.com/en-us/azure/databricks/catalogs/create-catalog).

If your identity lacks grant authority on the catalog, `install/install.sh` **logs the equivalent SQL to stdout and continues** — the install finishes, but a privileged user must run those `GRANT` statements before the app can list catalogs in the New Run picker. See [App SP catalog privileges](#app-sp-catalog-privileges) below for the canonical SQL.

## Prerequisites

### On your machine

| Tool | Min version | Purpose |
|------|-------------|---------|
| **Databricks CLI** | 0.230.0+ | Bundle deploy, app lifecycle, current-user lookup — [install](https://docs.databricks.com/aws/en/dev-tools/cli/install) |
| **Python** | 3.11+ | Runs `provision_lakebase.py` and `grant_catalog.py` |
| **apx** | latest | Builds the app artifacts (`apx build`, driven by the bundle artifacts hook); orchestrates bun + uv — [apx](https://github.com/databricks-solutions/apx) |
| **Bun** | 1.2+ | Frontend build (via `apx build`) — [bun.sh](https://bun.sh) |
| **uv** | latest | Python build for the wheel artifact (via `apx build`) — [uv](https://github.com/astral-sh/uv) |
| **jq** | 1.6+ | `install.sh` parses CLI JSON output (SP UUID, current user, app status) |
| **curl** | any | In-flight runs guard, stale bundle-state check and post-install verification |
| **git** | latest | Clone the repo |

`install.sh` verifies these at step `[0/5]`: it aborts if any of `databricks`, `python`, `jq`, `curl`, `apx`, `uv`, or `bun` is missing from PATH, and warns (does not block) if the Databricks CLI or Python is below its minimum.

> **Node.js is not required to install.** The frontend is built with Bun (via `apx build`), so a fresh install needs only the tools above. Node.js and npm are needed only to *develop* the frontend — see [CONTRIBUTING.md](CONTRIBUTING.md).

Install the Python packages the install scripts import:

```bash
python -m pip install 'databricks-sdk>=0.61' 'psycopg[binary]'
```

`install.sh` fail-fasts at step 0 if `databricks-sdk` is not importable in the active Python env.

### SQL warehouse

The app polls Delta tables (`_business`, `_vibe_progress`) for run progress through a SQL warehouse. **Provision a SQL warehouse before installing**, then either:

- Pass its ID via `--warehouse-id` to `install.sh`, which exports `VIBE_MODELING_WAREHOUSE_ID` so the artifacts hook bakes it into `src/app/.build/app.yml`, **or**
- Skip `--warehouse-id` at install time and pick the warehouse from the dropdown on the app's first-run Settings page.

Serverless SQL warehouses are recommended — the app issues short, frequent statements and benefits from cold-start avoidance.

### Cloud and workspace

- **Lakebase is generally available on both AWS and Azure.** No preview enrollment required.
- The modeling agent notebook is **bundled inside the app wheel** (`src/app/vendored/agent/`, shipped in this repo). The app uploads it to `/Users/<app-sp>/vibe-modelling-agent/` on first boot via its FastAPI lifespan hook (`backend/core/_bundled_agent_init.py`) and creates the persistent Databricks Job. The first-run UI exposes an **Install bundled agent notebook** button as a one-click reinstall if you ever need it. No manual notebook import.

> **Metastores that use Default Storage:** if the target metastore uses Default Storage (no metastore-level storage root), the installer cannot create the UC catalog via API/CLI — catalog creation there is UI-only and requires metastore-admin rights. Create the catalog through the workspace UI (or ask a workspace/metastore admin) with the same name as your `--catalog` value (default `vibe_modeling`), in the same region as the workspace, then re-run the installer or `python install/grant_catalog.py --profile <p> --catalog <name> --app-sp <sp>` to apply the grants. The app boots and is healthy without the catalog; only **model-producing runs** (which write `_metamodel.*` into it) require it.

## Parameter reference

All flags below are accepted by [`install/install.sh`](install/install.sh). The order matches the script's `usage` block.

| Flag | Required | Default | What it controls | When to override |
|------|----------|---------|------------------|------------------|
| `--profile <name>` | no | _(CLI default auth)_ | Databricks CLI profile name (must be pre-authenticated with `databricks auth login --profile <name>`). Drives every `databricks` CLI call and Python install step inside `install.sh`. Without it, the CLI and SDK use their default authentication (the `DEFAULT` profile or `DATABRICKS_*` environment variables). | Pass it whenever your default authentication does not point at the target workspace. |
| `--app-name <name>` | no | `vibe-modeling` | Databricks App resource name shown in the workspace **Apps** UI. The bundle deploys the App under this name; the App's service principal is bound to this name's lifecycle. | Use a suffix (e.g. `vibe-modeling-staging`) to run multiple installs on the same workspace. Note: the bundle storage path under `/Workspace/Users/<you>/.bundle/vibe-modeling/...` is always `vibe-modeling` (bundle name is fixed), so two co-existing installs share the same source path — fine for renames, not for true parallel installs. |
| `--project <id>` | no | `vibe-modeling` | Lakebase project ID. Must be unique in the workspace. The installer creates the project, its compute endpoint, and a database whose name matches `--catalog`. | If the default name is taken (or recently deleted — the name is locked for ~2 hours after delete), pick another. By convention, match `--app-name` for easier ops debugging. |
| `--catalog <name>` | no | `vibe_modeling` | Unity Catalog name AND Postgres database name. Underscores, not hyphens. The app uses this catalog for the agent's `_metamodel.*` artifacts (Delta tables, the `vol_root` volume) and the same name for its Lakebase Postgres state DB. The installer creates the catalog if absent (**not possible on a metastore that uses Default Storage** — create the catalog via the workspace UI first, see the note under [Cloud and workspace](#cloud-and-workspace)), grants the App SP `USE CATALOG`, `CREATE SCHEMA` and `BROWSE`, creates the `_metamodel` schema and its `vol_root` volume if absent, and issues the schema-level grants listed in [App SP catalog privileges](#app-sp-catalog-privileges). | Override if your workspace governance reserves catalog naming, or if you want a non-default isolation domain for the agent's artifacts. |
| `--warehouse-id <id>` | no | _(unset)_ | SQL warehouse ID the app uses for Delta polling during vibe runs. Pre-populates `VIBE_MODELING_WAREHOUSE_ID`; the artifacts hook bakes it into `src/app/.build/app.yml`. | Pass at install time to skip the first-run UI configuration. Omit to choose interactively from the Settings page after the app boots. |
| `--enable-taxonomy-builder` | no | _(off)_ | Installs the optional Domain Taxonomy Builder (an LLM-assisted wizard that drafts a business's domains and description). Exports `VIBE_MODELING_TAXONOMY_BUILDER_ENABLED=true`, and runs a read-only check that the App SP can use the model service. See [Enabling the Domain Taxonomy Builder](#enabling-the-domain-taxonomy-builder-optional). | Pass to turn the feature on. Omit and the feature stays off; the rest of the app does not depend on it. |
| `--taxonomy-model-service <catalog.schema.service>` | no | `system.ai.claude-sonnet-5-5` | The Unity Catalog model service the builder drafts with, as a three-part name. Seeds the app's setting on first boot; after that, Settings → Platform owns it. | Pass a custom model service (recommended). Requires `--enable-taxonomy-builder`, otherwise the installer exits with a usage error (exit 2), as it does for a name that isn't three-part. |
| `--enable-assessment` | no | _(off)_ | Installs the optional in-app bronze assessment skill. Exports `VIBE_MODELING_ASSESSMENT_ENABLED=true`. See [Enabling the in-app bronze assessment skill](#enabling-the-in-app-bronze-assessment-skill-optional). | Pass to turn the feature on. Omit and the feature stays off: its pages are hidden and its API answers 404. |
| `--assess-reader-sp <application_id>` | no | _(unset)_ | The reader service principal the assessment job runs as (its application id, a UUID). Seeds the app's setting on first boot; after that, Settings → Assessment owns it. With it, the installer runs a warn-only check of the reader. | Pass when the reader already exists. Without it the feature stays disabled until an admin sets the reader in Settings. Requires `--enable-assessment`; a value that isn't a UUID is a usage error (exit 2). |
| `-h`, `--help` | no | — | Print the usage block and exit. | — |

`install/install.sh` passes the install-time values to the build as `VIBE_MODELING_*` environment variables before it runs `databricks bundle deploy`. The bundle's `artifacts.default.build` hook (`install/build_and_render.sh`) renders them into `src/app/.build/app.yml` during the build. The checked-in source `src/app/app.yml` is **never modified**. No manual file edits.

### Deploying without `install.sh`

To change or redeploy an install, re-run `install/install.sh` with the same flags you installed with. It is idempotent and sets everything below for you.

If you run `install/build_and_render.sh` or `databricks bundle deploy` yourself (for example for the `github-publish` target), export the same values first. A variable you leave unset falls back to the default in the table, and an optional feature whose flag is unset turns off.

| Variable | Install flag | Meaning | Default when unset |
|----------|--------------|---------|--------------------|
| `VIBE_MODELING_LAKEBASE_PROJECT` | `--project` | Lakebase project ID the app connects to | `vibe-modeling` |
| `VIBE_MODELING_DATABASE_NAME` | `--catalog` | Postgres database name in that project | `vibe_modeling` |
| `VIBE_MODELING_DEPLOYMENT_CATALOG` | `--catalog` | Deployment catalog, which holds `_metamodel`; seeds the app's setting on first boot | `vibe_modeling` |
| `VIBE_MODELING_WAREHOUSE_ID` | `--warehouse-id` | SQL warehouse ID for run polling | empty (pick it in Settings) |
| `VIBE_MODELING_TAXONOMY_BUILDER_ENABLED` | `--enable-taxonomy-builder` | `true` turns the Domain Taxonomy Builder on | `false` |
| `VIBE_MODELING_TAXONOMY_MODEL_SERVICE` | `--taxonomy-model-service` | Model service the builder drafts with (`catalog.schema.service`); fills an empty setting only | empty (`install.sh` uses `system.ai.claude-sonnet-5-5`) |
| `VIBE_MODELING_ASSESSMENT_ENABLED` | `--enable-assessment` | `true` turns the in-app bronze assessment on | `false` |
| `VIBE_MODELING_ASSESS_READER_SP` | `--assess-reader-sp` | Application ID of the assessment reader service principal; fills an empty setting only | empty (set it in Settings) |

For example, for an install made with `--project my-proj --catalog my_catalog --warehouse-id abc123 --enable-assessment`:

```bash
export VIBE_MODELING_LAKEBASE_PROJECT=my-proj
export VIBE_MODELING_DATABASE_NAME=my_catalog
export VIBE_MODELING_DEPLOYMENT_CATALOG=my_catalog
export VIBE_MODELING_WAREHOUSE_ID=abc123
export VIBE_MODELING_ASSESSMENT_ENABLED=true
bash install/build_and_render.sh
```

Run `install/build_and_render.sh` before `databricks bundle deploy`. The deploy reads the rendered user-scopes file before its own build step runs. If you skip it, the deploy's build step may stop with "The app's user API scopes changed"; re-run the deploy.

## Pre-install: authenticate the CLI

```bash
databricks auth login --host https://<your-workspace>.cloud.databricks.com --profile my-workspace
databricks current-user me --profile my-workspace   # confirm
```

The profile name you pass to `databricks auth login` is the same name you pass to `install.sh --profile`.

## Run the installer

```bash
bash install/install.sh --profile my-workspace
```

> Run repo scripts with a `bash <script>` prefix as shown — a fresh checkout may not carry the executable bit, so invoking `./install.sh` directly can fail with "permission denied". To run a script directly instead, `chmod +x` it first.

The five-phase script prints `[N/5]` markers and stops on the first failure:

1. `[0/5]` Verify the CLI profile and prerequisites: critical tools (`databricks`, `python`, `jq`, `curl`, `apx`, `uv`, `bun`) and Python packages (`databricks-sdk`, `psycopg`) must be present or the script aborts; `databricks` CLI and `python` below their minimum versions warn but do not block.
2. `[1/5]` `databricks bundle deploy` — creates the App resource and its service principal.
3. `[2/5]` `python install/provision_lakebase.py` — Lakebase project, endpoint, database, role grants.
4. `[3/5]` `python install/grant_catalog.py` — UC privileges for the App SP (best-effort, logs SQL on permission failure). With `--enable-taxonomy-builder`, `python install/check_model_service.py` then checks the model service (read-only; see [Enabling the Domain Taxonomy Builder](#enabling-the-domain-taxonomy-builder-optional)). With `--enable-assessment --assess-reader-sp`, the same script checks the reader, warn-only (see [Enabling the in-app bronze assessment skill](#enabling-the-in-app-bronze-assessment-skill-optional)).
5. `[4/5]` Start app compute, wait for `ACTIVE`.
6. `[5/5]` `databricks apps deploy` from `src/app/.build`, wait for `RUNNING`.

After `[5/5]`, install.sh runs a warn-only `[verify]` block (homepage `200`, `/api/industries` == 40, the catalog exists in Unity Catalog). These are eventually-consistent and best-effort, so a gap warns rather than fails. The final block prints the App URL, Lakebase project, UC catalog, database, warehouse, and SP — copy this for later reference.

## App SP catalog privileges

The app's service principal (SP) needs to list the catalog, create schemas, and read/write the tables and volumes the agent produces. At step `[3/5]`, `install/install.sh` creates the catalog, the `_metamodel` schema, and its `vol_root` MANAGED volume if absent (the app's industry-download writes artifacts to `/Volumes/<catalog>/_metamodel/vol_root/...` before any vibe run, so they must exist at install time), then issues the grants below automatically. This section is what you (or someone with grant authority) needs to run **only if** that step logged a permission warning.

Find the SP client ID:

```bash
databricks apps get vibe-modeling --profile <your-profile> --output json | jq -r .service_principal_client_id
```

Then issue:

```sql
GRANT USE CATALOG, CREATE SCHEMA, BROWSE ON CATALOG <catalog> TO `<sp-client-id>`;
```

The installer also creates `_metamodel` + `vol_root` and grants the SP at the schema level (so it can write download artifacts before any vibe run). If you are issuing grants by hand, also run:

```sql
CREATE SCHEMA IF NOT EXISTS <catalog>._metamodel;
CREATE VOLUME IF NOT EXISTS <catalog>._metamodel.vol_root;
GRANT USE SCHEMA, CREATE TABLE, MODIFY, SELECT, READ VOLUME, WRITE VOLUME, CREATE VOLUME, MANAGE
  ON SCHEMA <catalog>._metamodel TO `<sp-client-id>`;
```

`READ VOLUME` and `WRITE VOLUME` cascade to current and future volumes in the schema (including `_metamodel.vol_root`), so no separate per-volume grant is required.

`CREATE VOLUME` and `MANAGE` on `_metamodel` are granted on every install, whether or not the bronze assessment skill is enabled. The app creates its own runs volume (`_metamodel.assess_runs`) and gives the assessment reader access to it and to `_metamodel`, so enabling the skill later needs no admin step.

Re-running the grants is idempotent:

```bash
python install/grant_catalog.py --profile <your-profile> --catalog <catalog> --app-sp <sp-uuid>
```

**Symptom if the SP lacks `USE CATALOG`:** the New Run form's *Deployment Catalog* picker shows "No catalogs match" even when the catalog exists. The app's `/api/catalogs` endpoint filters via `w.catalogs.list()`, which only returns catalogs the SP can `USE CATALOG` on.

**Redeploy note:** the App SP is tied to the App resource's lifetime, not to each deploy. A source-only push (`databricks apps deploy …`, install.sh step `[5/5]`) reuses the existing SP — no grant changes. The SP rotates only when you delete and recreate the App; re-running `install/install.sh` against the recreated app re-issues the grants automatically.

## Verify the install

Wait ~30 seconds after `install.sh` finishes (gives the FastAPI lifespan hook time to upload the bundled notebook and create the Job), then:

```bash
PROFILE=my-workspace
APP_NAME=vibe-modeling

TOKEN=$(databricks auth token --profile "$PROFILE" | jq -r .access_token)
APP_URL=$(databricks apps get "$APP_NAME" --profile "$PROFILE" --output json | jq -r .url)

# App status should be RUNNING:
databricks apps get "$APP_NAME" --profile "$PROFILE" --output json | jq -r '.app_status.state'

# Homepage returns 200:
curl -s -o /dev/null -w '%{http_code}\n' -H "Authorization: Bearer $TOKEN" "$APP_URL/"

# Industries were seeded (expect 40):
curl -s -H "Authorization: Bearer $TOKEN" "$APP_URL/api/industries" | jq 'length'

# Businesses list loads (empty on a fresh install):
curl -s -H "Authorization: Bearer $TOKEN" "$APP_URL/api/businesses" | jq
```

Expected:

- `app_status.state` → `"RUNNING"`
- `/` → HTTP `200`
- `/api/industries` → `40`
- `/api/businesses` → `[]`

If any check fails, see [Troubleshooting](#troubleshooting).

## Open the app

```bash
databricks apps get vibe-modeling --profile <your-profile> --output json | jq -r .url
```

The Settings page is pre-populated by the lifespan hook — the bundled agent notebook is uploaded, the persistent Databricks Job (`dbx_vibe_modelling`, tagged `managed_by=vibe_modeling_app`) is created, and the metamodel catalog matches your `--catalog` choice. You only need to touch Settings if you want to swap in a custom notebook or change the deployment catalog / warehouse.

## Access model

By default, every user granted Databricks Apps access to the app is treated as an app admin, with full access to settings, businesses, model versions, and runs. This is the expected behavior for the current 0.x releases.

Setting `VIBE_MODELING_RBAC_ENABLED=true` (an app environment variable) enables group-based roles resolved from workspace group membership:

- `vibe-app-admins` — full access, including settings and group management
- `vibe-business-admins` — manage businesses, approve syncs, manage model versions
- `vibe-modelers` — navigate, run vibes, provide feedback

With RBAC enabled, a user who is in none of these groups gets read-only access. Finer role separation is planned future work.

Because the default grants every app user admin rights, either scope Databricks Apps access to trusted users, or set `VIBE_MODELING_RBAC_ENABLED=true` and place users in the appropriate groups.

## Upgrading an existing deployment

A fresh install needs nothing beyond the steps above: the schema migrations run on first boot.

To upgrade a deployment that already holds data:

1. **Make sure you can restore the database.** Take a snapshot of the Lakebase project's production branch, or note the current time so you can use point-in-time restore within the project's restore window. The app never downgrades its schema, so going back to an older app version after an upgrade means restoring the database.
2. **Wait for in-flight runs to finish**, or cancel them. The installer refuses to deploy while runs are active (see [Troubleshooting](#troubleshooting)).
3. **Re-run `install/install.sh` from the new release with the same flags** you installed with, including every optional feature flag you use. A feature whose flag is left out turns off.

On boot, the app applies the schema migrations the new release adds, in place. Your businesses, model versions and runs are kept.

## Authenticating source reads (recommended)

Browsing, previewing, and downloading models from the public industry-model repo (and the upstream-agent monitor) read GitHub over HTTP. Unauthenticated reads are capped at 60 requests/hour per egress IP, and on Databricks Apps that IP is shared, so anonymous browsing hits the limit almost immediately and downloads fail. Configure a read credential (a GitHub App, recommended, or a personal access token) from **Settings → Sources → Source read access** to raise the limit to 5,000/hour. The secret material lives in a Databricks secret scope and the app service principal needs READ on that scope. See [`docs/github-app-source-auth.md`](docs/github-app-source-auth.md) for all three modes and the required grant.

## Enabling publish-to-GitHub (optional)

The app can publish a model version to a GitHub repository as a pull request. This feature is **optional and off by default** - it is not needed for the core install. Publishing is separate from source reads (above): it runs on behalf of the acting user through a Unity Catalog HTTP connection, and the read path never uses that connection.

Publish runs on behalf of the acting user through a Unity Catalog HTTP connection named `github_pr`. That connection uses per-user OAuth (U2M), which is interactive, so it **cannot be created by `install/install.sh`, Terraform, or SQL** - you create it once by hand in Catalog Explorer. Because the bundle's default (`dev`) target declares no app resources, a fresh install deploys cleanly on any workspace whether or not `github_pr` exists.

To enable publish on a workspace:

1. Create the `github_pr` UC HTTP connection and grant it, following [`docs/github-integration-setup.md`](docs/github-integration-setup.md) (register a GitHub OAuth app, create the connection, grant `USE CONNECTION`, enable OBO on the app).
2. Deploy with the `github-publish` bundle target so the app re-applies the `USE_CONNECTION` grant on `github_pr` each deploy:

   ```bash
   databricks bundle deploy --target github-publish --profile <your-profile> --var "app_name=<app-name>"
   databricks apps deploy <app-name> \
     --source-code-path "/Workspace/Users/<you>/.bundle/vibe-modeling/github-publish/files/src/app/.build" \
     --profile <your-profile>
   ```

   Before the first command, export the same `VIBE_MODELING_*` values your install uses and run `bash install/build_and_render.sh`. The variables are listed in [Deploying without `install.sh`](#deploying-without-installsh). If the deploy's build step stops with "The app's user API scopes changed", re-run the deploy.

   The grant is the only difference from the default target. The connection name is referenced by name (`github_pr`); the bundle resource key (`github_conn`) is cosmetic.
3. Configure the GitHub tab in the app's Settings (connection name, repo owner/name) per Step E of the integration guide.

If you skip this, the Publish action stays disabled and returns `422 github_connection_missing` until configured - everything else works.

## Enabling the Domain Taxonomy Builder (optional)

The Domain Taxonomy Builder is a wizard that uses an LLM to draft a business's domains and description. It is **optional and off by default**. Turn it on at install time:

```bash
bash install/install.sh --profile my-workspace \
  --enable-taxonomy-builder \
  --taxonomy-model-service <catalog.schema.service>
```

Without `--taxonomy-model-service`, the builder uses `system.ai.claude-sonnet-5-5`. We recommend a custom model service per workload. A workspace admin can deny the shared `system.ai` services, so a custom service is the safer choice.

The app calls the model service through the Unity AI Gateway as its service principal. The App SP needs three privileges. Grant them with the Databricks CLI, which handles Unity Gateway model services:

```bash
databricks grants update catalog <catalog> \
  --json '{"changes":[{"principal":"<app-sp-application-id>","add":["USE_CATALOG"]}]}'
databricks grants update schema <catalog>.<schema> \
  --json '{"changes":[{"principal":"<app-sp-application-id>","add":["USE_SCHEMA"]}]}'
databricks grants update model_service <catalog>.<schema>.<service> \
  --json '{"changes":[{"principal":"<app-sp-application-id>","add":["EXECUTE"]}]}'
```

Or grant the same privileges in Catalog Explorer → the catalog, schema and model service → **Permissions**.

Grants on `system.ai` need a metastore admin or the `MANAGE` privilege. The installer never grants these. It checks them, read-only, after the App SP exists:

- If the model service does not exist, the install stops with "Model service '<name>' not found."
- If a privilege is missing, the install stops and prints the exact `databricks grants update` commands. An admin runs them, then you re-run `install.sh` (every step is idempotent).
- If the installer cannot read the SP's privileges, it warns and continues. The app's own test call then decides.

After install, an admin can change the model service and the concurrency limit in **Settings → Platform**, which runs a test call as the App SP on every change.

To turn the builder on for an existing install, re-run `install.sh` with `--enable-taxonomy-builder`. A re-run must pass every optional feature flag the install uses (`--enable-taxonomy-builder`, `--enable-assessment`); a feature whose flag is left out turns off. Pass `--taxonomy-model-service` and `--assess-reader-sp` again as well while Settings has no value for them: they only fill an empty setting. To turn it off, redeploy without the flag. Business data the wizard wrote stays in place.

## Enabling the in-app [bronze assessment skill](https://github.com/databricks-industry-solutions/lakehouse-industry-data-models/tree/main/model-genie-skills) (optional)

For a model version and the source (bronze) schemas you pick, the assessment profiles the sources and maps them to the model. It grades how well the sources cover the model and lists the decisions and model changes ("next vibes") it suggests. Each domain runs as a Databricks job that runs as a reader service principal you create. It is **optional and off by default**.

This release bundles a development-branch calibration of those skills that is newer than the published 0.4.0 release. Later releases will bundle the official published version.

When a user launches from the assessment wizard, the app checks the reader's access first (`/assess/readiness`): the reader and its job, the runs volume, the `_metamodel` schema, the SQL warehouse, and per domain the model catalog and each source (bronze) schema. A confirmed missing grant blocks the launch and shows the SQL to fix it. Any error during an assessment (the launch, the job run, saving results, the hand-off) is shown to the user with the error text and links to the job and the job run, and the user is told to contact the administrator, who diagnoses it from the job run.

The feature stays disabled until a reader service principal is set. An admin sets it at install time (`--assess-reader-sp`) or later in **Settings → Assessment**.

The reader needs no write privilege on model, source or `_metamodel` tables; the app grants it READ/WRITE VOLUME on the runs volume itself.

Steps:

1. Create the reader service principal, and give the App SP the **Service Principal User** role on it (Service principals → the reader → Permissions).
2. Grant the reader `USE CATALOG`, `USE SCHEMA` and `SELECT` at catalog level on the catalogs the app deploys models into and on the approved source catalogs. Catalog-level grants cover schemas created later. If you grant per schema instead, users see the missing SQL when they launch an assessment.
3. Grant the reader `USE CATALOG` on the deployment catalog (`--catalog`).
4. Grant the reader `CAN USE` on the SQL warehouse, and `EXECUTE` on the Genie Code model service (`system.ai.gpt-5-6-sol`).
5. Allow `github.com` egress from serverless jobs (the job downloads the pinned Genie Code and Databricks CLIs).
6. Install with the flags:

```bash
bash install/install.sh --profile my-workspace \
  --enable-assessment \
  --assess-reader-sp <reader-application-id>
```

With a reader, step `[3/5]` runs `install/check_model_service.py --principal <reader>`. It is warn-only and never stops the install. It warns when the reader does not exist and when the reader lacks `EXECUTE` on the model service, and it reminds you to give the App SP the Service Principal User role on the reader (step 1), which it does not check.

The app creates the runs volume `<catalog>._metamodel.assess_runs` and gives the reader these grants:

- `CAN READ` on the job's notebook folder in the App SP's workspace home;
- `READ VOLUME` and `WRITE VOLUME` on the runs volume;
- `USE SCHEMA` on `<catalog>._metamodel`.

The App SP's `CREATE VOLUME` and `MANAGE` on `_metamodel` (see [App SP catalog privileges](#app-sp-catalog-privileges)) are what let it do this. The app grants nothing on the deployment catalog itself or on any model or source catalog; steps 2 and 3 are yours.

With `--enable-assessment`, the app also requests the `workspace.workspace` user scope, because the hand-off writes into the user's own workspace home with the user's own token. Without the flag the app requests no user scopes. Each user consents once. If you enable the assessment later, that redeploy adds the scope and each user consents once more on their next visit. If your workspace restricts the scopes apps may request, allow `workspace.workspace` for this app.

To turn the skill on for an existing install, re-run `install.sh` with `--enable-assessment`. A re-run must pass every optional feature flag the install uses (`--enable-taxonomy-builder`, `--enable-assessment`); a feature whose flag is left out turns off. Pass `--taxonomy-model-service` and `--assess-reader-sp` again as well while Settings has no value for them: they only fill an empty setting. To turn it off, redeploy without the flag. Existing assessment results stay in place.

## Troubleshooting

### Redeploy appears to run old code

Databricks Apps installs the app wheel by version and skips reinstalling an unchanged one. Bump `version` in `src/app/pyproject.toml` before redeploying so the wheel reinstalls — the deploy log should read `Successfully installed vibe-modeling-<new-version>`, not `Requirements have not changed. Skipping installation`.

### `refusing to (re-)install — N in-flight run(s) on ...`

The installer refuses to (re-)deploy while runs are active. Atomic-replace App containers can't hand off in-memory pollers cleanly — pushing a new wheel would silently orphan in-flight runs until the new container's lifespan re-attaches. Cancel the runs in the UI (or wait for them to finish), then re-run install. For emergencies, set `FORCE=1` before invoking `install.sh` (`FORCE=1 bash install/install.sh ...`) — affected runs will lose their pollers and may need recovery via UI cancel-and-resume.

### `permission denied for schema public` on app startup

Re-run `install/install.sh --profile <your-profile>`. The provision step re-applies Lakebase schema grants idempotently.

### `Cannot deploy app … as it is not in RUNNING state`

`install/install.sh` handles compute startup; you only hit this running the steps manually. Run `databricks apps start <app-name> --profile <profile>` and wait 15 seconds before re-deploying.

### `project with such id already exists`

A Lakebase project with that name already exists, or was recently deleted (project names are locked for ~2 hours after deletion). Re-run with `--project <other-id>`.

### `Lakebase Autoscaling connection validation failed`

The `VIBE_MODELING_LAKEBASE_PROJECT` env var rendered into `src/app/.build/app.yml` doesn't match the `--project` value. Re-run `install/install.sh --profile <your-profile> --project <correct-id>` — the artifacts hook will re-render the file from the corrected env var.

### First model diagram takes minutes to load

Expected on the very first view after a deploy (ELK layout warm-up). Subsequent loads are sub-second. If it times out, raise the app compute size in the Databricks UI (`MEDIUM` → `LARGE`).

### `Connection 'github_pr' does not exist` during bundle deploy

You deployed the `github-publish` target on a workspace where the `github_pr` UC connection has not been created yet. The default install (`install/install.sh`, `dev` target) does not declare this resource and is unaffected. Either create the connection first (see [Enabling publish-to-GitHub](#enabling-publish-to-github-optional)) or deploy the default target.

### App SP can't see catalogs in the New Run picker

The auto-grant step at `[3/5]` likely logged a permission warning. Have a user with catalog ownership / `MANAGE` / metastore-admin run the SQL in [App SP catalog privileges](#app-sp-catalog-privileges), or re-run `python install/grant_catalog.py` from a privileged identity.

### `bundle deploy` fails with `workspace_id mismatch ... in provider_config`

The local DAB terraform state under `.databricks/bundle/dev/` is a cache that pins the workspace this bundle was last deployed to from this machine. Installing to a **different** workspace (e.g. a different workspace after previously deploying elsewhere) trips this mismatch. `install.sh` auto-detects a workspace switch and clears the stale local state before deploy; if you hit it running `databricks bundle deploy` directly, clear it yourself — `rm -rf .databricks/bundle/dev/terraform` — and redeploy. The authoritative state lives in the target workspace, so clearing the local cache is safe.
