/**
 * Single source of truth for the `v{n}` / `v{n} {SCOPE}` version label; don't inline
 * `scope ? ... : ...` ternaries.
 * Returns "v{version}" when scope is empty/null/undefined.
 * Returns "v{version} {SCOPE}" (uppercase) when scope is provided.
 * The backend builds the same label in `backend/router.py:1875`; keep empty-scope
 * behavior in sync.
 */
export function versionScopeLabel(
  version: number | string,
  scope?: string | null,
): string {
  if (!scope) {
    return `v${version}`;
  }
  return `v${version} ${scope.toUpperCase()}`;
}
