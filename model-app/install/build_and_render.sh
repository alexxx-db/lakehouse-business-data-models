#!/usr/bin/env bash
# Build the apx artifacts and render src/app/.build/app.yml with the
# install-time env-var values. Invoked by databricks.yml's
# artifacts.default.build hook (and therefore by `databricks bundle deploy`).
#
# install/install.sh exports VIBE_MODELING_LAKEBASE_PROJECT,
# VIBE_MODELING_DATABASE_NAME, VIBE_MODELING_DEPLOYMENT_CATALOG, and
# VIBE_MODELING_WAREHOUSE_ID (plus, for the optional Domain Taxonomy Builder,
# VIBE_MODELING_TAXONOMY_BUILDER_ENABLED and VIBE_MODELING_TAXONOMY_MODEL_SERVICE,
# and for the optional bronze assessment skill, VIBE_MODELING_ASSESSMENT_ENABLED
# and VIBE_MODELING_ASSESS_READER_SP) before invoking `bundle deploy`; this script reads them. When run outside install.sh (e.g. a direct
# `databricks bundle deploy`), the same defaults the canonical install
# would produce are applied.
#
# Source src/app/app.yml is never modified — only the build output
# src/app/.build/app.yml is rewritten. The same assessment flag also renders
# install/.generated/app_scopes.yml (deleted when off), the databricks.yml
# include that gives the App its `workspace.workspace` user scope only when the
# assessment is on. `databricks bundle deploy` reads includes before it runs this
# build hook, so every deploy path runs this script first (install.sh and the
# other deploy scripts do); the hook run (`--bundle-hook`) fails the deploy with
# a re-run message when the fragment changed under it.

set -euo pipefail

# `--bundle-hook` (only databricks.yml's build hook passes it): fail the deploy
# when the user-scopes fragment changed, since the bundle already loaded the old one.
HOOK_FLAG=()
if [[ "${1:-}" == "--bundle-hook" ]]; then
  HOOK_FLAG=(--bundle-hook)
fi

# Repo root is the parent of install/.
cd "$(dirname "$0")/.."

# Lowercased so an exported `True`/`TRUE` passes render_app_yaml.py's
# true/false choice (bash 3.2 has no ${var,,}).
TAXONOMY_BUILDER="$(printf '%s' "${VIBE_MODELING_TAXONOMY_BUILDER_ENABLED:-false}" | tr '[:upper:]' '[:lower:]')"
ASSESSMENT="$(printf '%s' "${VIBE_MODELING_ASSESSMENT_ENABLED:-false}" | tr '[:upper:]' '[:lower:]')"

# Print the effective optional-feature values so a redeploy that drops a flag
# (which turns that feature off) is visible in the log.
echo "taxonomy_builder=${TAXONOMY_BUILDER} taxonomy_model_service=${VIBE_MODELING_TAXONOMY_MODEL_SERVICE:-unset}"
echo "assessment=${ASSESSMENT} assess_reader_sp=${VIBE_MODELING_ASSESS_READER_SP:-unset}"

( cd src/app && apx build )

python install/render_app_yaml.py \
  --in  src/app/app.yml \
  --out src/app/.build/app.yml \
  --project            "${VIBE_MODELING_LAKEBASE_PROJECT:-vibe-modeling}" \
  --database           "${VIBE_MODELING_DATABASE_NAME:-vibe_modeling}" \
  --deployment-catalog "${VIBE_MODELING_DEPLOYMENT_CATALOG:-vibe_modeling}" \
  --warehouse-id       "${VIBE_MODELING_WAREHOUSE_ID:-}" \
  --taxonomy-builder   "${TAXONOMY_BUILDER}" \
  --taxonomy-model-service "${VIBE_MODELING_TAXONOMY_MODEL_SERVICE:-}" \
  --assessment         "${ASSESSMENT}" \
  --assess-reader-sp   "${VIBE_MODELING_ASSESS_READER_SP:-}" \
  --bundle-scopes-out  install/.generated/app_scopes.yml \
  ${HOOK_FLAG[@]:+"${HOOK_FLAG[@]}"}
