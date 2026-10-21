#!/usr/bin/env bash
# Shared in-flight-runs guard for any (re-)deploy of the App container.
#
# Atomic-replace container swap (Databricks Apps) cannot hand off the
# previous container's in-memory poll tasks. Refuse to deploy a new
# image while a run is active so progress isn't lost. The App itself
# carries no runtime drain gate — deploy-time enforcement is the
# canonical place for the invariant.
#
# Usage (source from a deploy script):
#
#   PROFILE=<profile> APP=vibe-modeling FORCE=0 \
#     bash "$REPO_ROOT/install/in_flight_guard.sh"
#
# Vars consumed:
#   APP       — Databricks App name (e.g. vibe-modeling)
#   PROFILE   — Databricks CLI profile (optional; omit for ambient/DEFAULT auth)
#   FORCE     — 1 to allow deploying despite in-flight runs (default 0)
#
# Exit codes:
#   0 — safe to proceed (no app yet, no in-flight runs, or FORCE=1)
#   2 — in-flight runs present and FORCE != 1; abort the caller

set -euo pipefail

: "${APP:?in_flight_guard.sh: APP must be set}"
PROFILE="${PROFILE:-}"
PROFILE_FLAGS=()
[[ -n "$PROFILE" ]] && PROFILE_FLAGS=(--profile "$PROFILE")
FORCE="${FORCE:-0}"

APP_HOST_FOR_GUARD="$(databricks apps get "$APP" ${PROFILE_FLAGS[@]:+"${PROFILE_FLAGS[@]}"} --output json 2>/dev/null \
  | jq -r '.url // empty' 2>/dev/null | sed -E 's#^[A-Za-z]+://##; s#[/:?].*$##' || true)"

if [[ -z "$APP_HOST_FOR_GUARD" ]]; then
  # App resource doesn't exist yet (fresh install) or we couldn't reach
  # the workspace. Either way there's nothing in-flight to protect.
  echo "    Fresh install or unreachable App '$APP' — skipping in-flight check."
  exit 0
fi

TOKEN="$(databricks auth token ${PROFILE_FLAGS[@]:+"${PROFILE_FLAGS[@]}"} --output json 2>/dev/null \
  | jq -r '.access_token // empty' 2>/dev/null || true)"
if [[ -z "$TOKEN" ]]; then
  echo "    No token (profile: ${PROFILE:-<ambient>}) — skipping in-flight check."
  exit 0
fi

HEALTH="$(curl -sS --max-time 8 \
  "https://$APP_HOST_FOR_GUARD/api/health" \
  -H "Authorization: Bearer $TOKEN" 2>/dev/null || true)"

IN_FLIGHT="$(printf '%s' "$HEALTH" | jq -r '.in_flight_runs // 0' 2>/dev/null || true)"
# A non-JSON or non-numeric health response counts as no in-flight runs.
[[ "$IN_FLIGHT" =~ ^[0-9]+$ ]] || IN_FLIGHT=0

if [[ "$IN_FLIGHT" -le 0 ]]; then
  echo "    OK — no in-flight runs on $APP_HOST_FOR_GUARD."
  exit 0
fi

if [[ "$FORCE" -ne 1 ]]; then
  echo "ERROR: refusing to deploy — $IN_FLIGHT in-flight run(s) on $APP_HOST_FOR_GUARD." >&2
  echo "       Cancel them in the UI or wait for completion before deploying." >&2
  echo "       Use FORCE=1 to override (you will lose in-flight progress)." >&2
  exit 2
fi

echo "WARNING: FORCE=1 in effect; deploying despite $IN_FLIGHT in-flight run(s)."
echo "         Affected runs will lose their in-memory pollers and may need recovery."
exit 0
