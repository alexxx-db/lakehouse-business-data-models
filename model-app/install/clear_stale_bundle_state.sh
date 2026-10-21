#!/usr/bin/env bash
# Shared stale-local-bundle-state guard for any (re-)deploy of the bundle.
#
# The local DAB terraform state under .databricks/bundle/<target>/terraform is a
# cache; the authoritative copy lives in the target workspace. When the bundle
# was last deployed to a DIFFERENT workspace from this machine, the cached state
# pins that workspace and `databricks bundle deploy` aborts with
# "workspace_id mismatch ... in provider_config". Detect a workspace switch and
# clear the stale local state so the deploy re-syncs from the target.
#
# Best-effort: if the target workspace id can't be resolved (offline, missing
# jq, auth quirk), this is a no-op and the deploy proceeds unchanged — worst
# case the caller hits the original mismatch error, same as before this guard.
#
# Usage (call from a deploy script):
#
#   PROFILE=<profile> TARGET=dev REPO_ROOT="$REPO_ROOT" \
#     bash "$REPO_ROOT/install/clear_stale_bundle_state.sh"
#
# Vars consumed:
#   PROFILE    — Databricks CLI profile (optional; omit for ambient/DEFAULT auth)
#   TARGET     — bundle target whose state to check (default: dev)
#   REPO_ROOT  — bundle root (default: current directory)
#
# Exit code: always 0 — the guard is advisory and never blocks the deploy.

set -euo pipefail

PROFILE="${PROFILE:-}"
PROFILE_FLAGS=()
[[ -n "$PROFILE" ]] && PROFILE_FLAGS=(--profile "$PROFILE")
TARGET="${TARGET:-dev}"
REPO_ROOT="${REPO_ROOT:-$(pwd)}"

TF_STATE="$REPO_ROOT/.databricks/bundle/$TARGET/terraform/terraform.tfstate"
[[ -f "$TF_STATE" ]] || exit 0

# workspace_id recorded in the cached state (any nesting depth).
STATE_WSID="$(jq -r '[.. | .workspace_id? // empty][0] // empty' "$TF_STATE" 2>/dev/null || true)"

# Target workspace id: the org id the profile actually resolves to, read from
# the X-Databricks-Org-Id response header (numeric workspace id on all clouds).
HOST="$(databricks auth env ${PROFILE_FLAGS[@]:+"${PROFILE_FLAGS[@]}"} 2>/dev/null | jq -r '.env.DATABRICKS_HOST // empty' 2>/dev/null || true)"
TOKEN="$(databricks auth token ${PROFILE_FLAGS[@]:+"${PROFILE_FLAGS[@]}"} --output json 2>/dev/null | jq -r '.access_token // empty' 2>/dev/null || true)"
TARGET_WSID=""
if [[ -n "$HOST" && -n "$TOKEN" ]]; then
  TARGET_WSID="$(curl -sS -D - -o /dev/null --max-time 10 \
    -H "Authorization: Bearer $TOKEN" \
    "$HOST/api/2.0/preview/scim/v2/Me" 2>/dev/null \
    | tr -d '\r' | awk 'tolower($1)=="x-databricks-org-id:"{print $2}' || true)"
fi

if [[ -n "$STATE_WSID" && -n "$TARGET_WSID" && "$STATE_WSID" != "$TARGET_WSID" ]]; then
  echo "    [fix] local bundle state (target '$TARGET') pins workspace $STATE_WSID but target is $TARGET_WSID;"
  echo "          clearing stale $REPO_ROOT/.databricks/bundle/$TARGET/terraform so the deploy re-syncs."
  rm -rf "$REPO_ROOT/.databricks/bundle/$TARGET/terraform"
fi
exit 0
