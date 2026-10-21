import { useEffect, useRef, type ComponentType } from "react";
import { useQueryClient } from "@tanstack/react-query";
import { Building2, Factory, Boxes, Play } from "lucide-react";
import {
  BusinessKind,
  deleteUserPreference,
  getUserPreferencesKey,
  setUserPreference,
  type BusinessListOut,
  type UserPreferenceOut,
} from "@/lib/api";
import { ensureUtcIso } from "@/lib/date";
import { entityKindLabel } from "@/lib/entity-kind";
import { versionScopeLabel } from "@/lib/version-label";

/** Preference-key prefix for a business/industry visit record. One row per
 *  visited business or industry (both are `businesses` rows); the upsert bumps
 *  `updated_at` on every visit, so the store doubles as an ordered recency
 *  signal. This module owns the visit convention: the recorders
 *  (`useRecordVisit`, used by the `businesses.$businessId` and version-scope
 *  routes), the home reader (`collectVisits`) and the home cleanup
 *  (`pruneVisits`) all go through it. */
export const VISIT_BUSINESS_PREFIX = "visit:business:";

export function businessVisitKey(businessId: string): string {
  return `${VISIT_BUSINESS_PREFIX}${businessId}`;
}

/** Preference-key prefix for a model-version visit record:
 *  `visit:version:<businessId>:<version>:<scope>`. The value remembers the last
 *  place visited inside the version (see `versionPlaceValue`). */
export const VISIT_VERSION_PREFIX = "visit:version:";

const POSITIVE_INT = /^[1-9]\d*$/;
const VERSION_SCOPES: ReadonlySet<string> = new Set(["ecm", "mvm"]);

export interface VersionKeyParts {
  businessId: string;
  version: number;
  scope: string;
}

/** The one parser for business visit keys: the business or industry id, or
 *  `null` for a key outside the prefix or with an empty id. */
export function parseBusinessVisitKey(key: string): string | null {
  if (!key.startsWith(VISIT_BUSINESS_PREFIX)) return null;
  return key.slice(VISIT_BUSINESS_PREFIX.length) || null;
}

/** The one parser for version visit keys. Parses from the right (scope, then a
 *  positive-integer version, the rest is the business id) so a business id may
 *  itself contain colons. Returns `null` for any other `visit:version:` shape
 *  and for keys outside the prefix. */
export function parseVersionVisitKey(key: string): VersionKeyParts | null {
  if (!key.startsWith(VISIT_VERSION_PREFIX)) return null;
  const rest = key.slice(VISIT_VERSION_PREFIX.length);
  const scopeAt = rest.lastIndexOf(":");
  if (scopeAt < 0) return null;
  const scope = rest.slice(scopeAt + 1);
  if (!VERSION_SCOPES.has(scope)) return null;
  const head = rest.slice(0, scopeAt);
  const versionAt = head.lastIndexOf(":");
  if (versionAt < 0) return null;
  const versionText = head.slice(versionAt + 1);
  if (!POSITIVE_INT.test(versionText) || !Number.isSafeInteger(Number(versionText))) return null;
  const businessId = head.slice(0, versionAt);
  if (!businessId) return null;
  return { businessId, version: Number(versionText), scope };
}

/** Whether a parsed version visit still points at a real place: its business
 *  is in `byId` and the scope is one the business has downloaded. */
export function isVersionListed(
  byId: ReadonlyMap<string, BusinessListOut>,
  parts: VersionKeyParts,
): boolean {
  const b = byId.get(parts.businessId);
  return !!b && (b.downloaded_scopes ?? []).includes(parts.scope);
}

/** Key for a version visit, or `null` when the route params are not a real
 *  version (`/model/abc/foo`, `/model/03/mvm`). Built through
 *  `parseVersionVisitKey`, so a recorder never writes a key the reader or the
 *  prune pass would reject. */
export function versionVisitKey(
  businessId: string,
  version: string | number,
  scope: string,
): string | null {
  const key = `${VISIT_VERSION_PREFIX}${businessId}:${version}:${scope}`;
  const parts = parseVersionVisitKey(key);
  if (!parts || parts.businessId !== businessId) return null;
  return key;
}

/** Stored value for a version visit: `{}` for the version overview, or
 *  `{"domain":"<name>"}` once a domain page was the last place visited. */
export function versionPlaceValue(domain?: string): string {
  return JSON.stringify(domain ? { domain } : {});
}

/** The remembered domain of a version visit, or `undefined` for the overview.
 *  Anything but an object with a non-empty string `domain` (legacy `"1"`,
 *  invalid JSON) is the overview. */
export function parseVersionPlace(value: string): { domain?: string } {
  let parsed: unknown;
  try {
    parsed = JSON.parse(value);
  } catch {
    return {};
  }
  if (parsed && typeof parsed === "object" && !Array.isArray(parsed)) {
    const domain = (parsed as { domain?: unknown }).domain;
    if (typeof domain === "string" && domain) return { domain };
  }
  return {};
}

/** A model-version visit read from a `visit:version:` preference row. */
export interface VersionVisit {
  businessId: string;
  version: number;
  scope: string;
  visitedAt: string;
  domain?: string;
}

export interface Visits {
  /** Business/industry id -> ISO `updated_at` of its visit row. */
  businesses: Map<string, string>;
  versions: VersionVisit[];
}

export function collectVisits(prefs: readonly UserPreferenceOut[]): Visits {
  const businesses = new Map<string, string>();
  const versions: VersionVisit[] = [];
  for (const p of prefs) {
    if (p.key.startsWith(VISIT_BUSINESS_PREFIX)) {
      const id = parseBusinessVisitKey(p.key);
      if (id) businesses.set(id, p.updated_at);
      continue;
    }
    const parts = parseVersionVisitKey(p.key);
    if (!parts) continue;
    const { domain } = parseVersionPlace(p.value);
    versions.push({
      ...parts,
      visitedAt: p.updated_at,
      ...(domain ? { domain } : {}),
    });
  }
  return { businesses, versions };
}

/** Newest visit rows kept per kind; the prune pass deletes the rest. */
export const MAX_VERSION_VISITS = 50;
export const MAX_BUSINESS_VISITS = 50;
/** A visit row newer than the business list's fetch time minus this window is
 *  never pruned for a missing business or scope: the list may predate the
 *  business or download that the row belongs to. */
export const PRUNE_GRACE_MS = 60 * 60 * 1000;
/** Upper bound on visit rows deleted per home load. */
export const MAX_PRUNE_PER_LOAD = 20;
/** Concurrent DELETE requests while pruning. */
export const PRUNE_CONCURRENCY = 4;

/** Visit preference keys the home load should delete, at most
 *  `MAX_PRUNE_PER_LOAD`, stale rows first and then the oldest excess rows.
 *
 *  Stale rows: a business visit whose id is not in `businesses`; a version
 *  visit whose business is not listed or whose scope is not in that business's
 *  `downloaded_scopes`. These apply only to rows last updated before
 *  `listFetchedAt - PRUNE_GRACE_MS`. A `visit:version:` key the shared parser
 *  rejects, and a `visit:business:` key with an empty id, are always stale:
 *  recorders never write them, so no fresh write can be one.
 *
 *  Excess rows: the non-stale rows of each kind beyond the newest
 *  `MAX_VERSION_VISITS` / `MAX_BUSINESS_VISITS` by `updated_at`.
 *
 *  Only `visit:business:` and `visit:version:` keys are ever returned, so a
 *  newer release's other `visit:*` rows and unrelated preferences survive. */
export function pruneVisits(
  prefs: readonly UserPreferenceOut[],
  businesses: readonly BusinessListOut[],
  listFetchedAt: number,
): string[] {
  const byId = new Map(businesses.map((b) => [b.id, b]));
  const cutoff = listFetchedAt - PRUNE_GRACE_MS;
  const isOld = (p: UserPreferenceOut) => epoch(ensureUtcIso(p.updated_at)) < cutoff;

  const stale: string[] = [];
  const liveBusinesses: UserPreferenceOut[] = [];
  const liveVersions: UserPreferenceOut[] = [];

  for (const p of prefs) {
    if (p.key.startsWith(VISIT_BUSINESS_PREFIX)) {
      const id = parseBusinessVisitKey(p.key);
      if (id === null) {
        stale.push(p.key);
        continue;
      }
      if (!byId.has(id) && isOld(p)) stale.push(p.key);
      else liveBusinesses.push(p);
    } else if (p.key.startsWith(VISIT_VERSION_PREFIX)) {
      const parts = parseVersionVisitKey(p.key);
      if (!parts) {
        stale.push(p.key);
        continue;
      }
      if (!isVersionListed(byId, parts) && isOld(p)) stale.push(p.key);
      else liveVersions.push(p);
    }
  }

  const excess = (rows: UserPreferenceOut[], max: number): string[] =>
    rows
      .sort(
        (a, b) =>
          epoch(ensureUtcIso(b.updated_at)) - epoch(ensureUtcIso(a.updated_at)) ||
          a.key.localeCompare(b.key),
      )
      .slice(max)
      .map((p) => p.key)
      .reverse();

  return [
    ...stale,
    ...excess(liveVersions, MAX_VERSION_VISITS),
    ...excess(liveBusinesses, MAX_BUSINESS_VISITS),
  ].slice(0, MAX_PRUNE_PER_LOAD);
}

/** Delete preference rows, `PRUNE_CONCURRENCY` at a time. Failures are
 *  swallowed (a row that survives is pruned on a later home load). Resolves
 *  `true` when at least one delete succeeded. */
export async function deleteVisitKeys(keys: readonly string[]): Promise<boolean> {
  let anyDeleted = false;
  for (let i = 0; i < keys.length; i += PRUNE_CONCURRENCY) {
    const results = await Promise.allSettled(
      keys.slice(i, i + PRUNE_CONCURRENCY).map((key) => deleteUserPreference({ key })),
    );
    if (results.some((r) => r.status === "fulfilled")) anyDeleted = true;
  }
  return anyDeleted;
}

/** Record a visit by upserting the preference `key`, then refresh the
 *  preferences query so the home list reorders immediately. The effect skips
 *  the write when `(key, value)` equals the last one written, so StrictMode's
 *  double effect writes once; a `null` key writes nothing and re-arms the
 *  recorder. Failures are
 *  swallowed: a lost visit write only means recency does not update. */
export function useRecordVisit(key: string | null, value = "1"): void {
  const queryClient = useQueryClient();
  const last = useRef<{ key: string; value: string } | null>(null);

  useEffect(() => {
    if (key === null) {
      last.current = null;
      return;
    }
    if (last.current?.key === key && last.current.value === value) return;
    last.current = { key, value };
    void setUserPreference({ key }, { value })
      .then(() => queryClient.invalidateQueries({ queryKey: getUserPreferencesKey() }))
      .catch(() => {});
  }, [key, value, queryClient]);
}

/**
 * A single "Jump back in" entry: a display kind, title, subtitle, a timestamp
 * and the deep-link target. `businessId` is on every variant; the variants add
 * what their kind needs to build a link.
 *
 * `buildRecentItems` emits `business`, `industry` and `model_version` entries.
 * The `run` variant is declared for entries built from runs later.
 */
interface RecentItemBase {
  key: string;
  title: string;
  subtitle?: string;
  /** ISO timestamp used for the relative "when" and for sorting. */
  timestamp: string;
  businessId: string;
}

export interface BusinessRecentItem extends RecentItemBase {
  kind: "business" | "industry";
}

export interface ModelVersionRecentItem extends RecentItemBase {
  kind: "model_version";
  version: number;
  scope: string;
  domain?: string;
}

export interface RunRecentItem extends RecentItemBase {
  kind: "run";
  runId: string;
}

export type RecentItem =
  | BusinessRecentItem
  | ModelVersionRecentItem
  | RunRecentItem;

export type RecentKind = RecentItem["kind"];

export const RECENT_KIND_META: Record<
  RecentKind,
  { label: string; Icon: ComponentType<{ className?: string }> }
> = {
  business: { label: entityKindLabel(BusinessKind.business), Icon: Building2 },
  industry: { label: entityKindLabel(BusinessKind.industry), Icon: Factory },
  model_version: { label: "Model version", Icon: Boxes },
  run: { label: "Run", Icon: Play },
};

function countLabel(n: number, singular: string): string {
  return `${n} ${singular}${n === 1 ? "" : "s"}`;
}

/** Epoch ms for sorting; an unparseable timestamp sinks to the bottom so the
 *  comparator stays transitive. */
function epoch(timestamp: string): number {
  const t = new Date(timestamp).getTime();
  return Number.isNaN(t) ? -Infinity : t;
}

const MODEL_VERSION_SEPARATOR = " \u00b7 ";

/**
 * Merge the listed businesses and industries and the visited model versions
 * into one recency-ordered list, capped at `limit`.
 *
 * `visits.businesses` maps an id to the ISO `updated_at` of its
 * `visit:business:<id>` preference. A visited entity sorts and displays by its
 * visit time; a never-visited one falls back to `created_at`, so entities that
 * predate visit tracking still appear. Both go through `ensureUtcIso` so the
 * two sort bases share one epoch (an offset-less visit time against a `Z`
 * `created_at` would otherwise skew the order).
 *
 * A model version appears only after a visit, and only while its business is
 * listed and its scope is in the business's `downloaded_scopes`; its title is
 * the business name and its subtitle the version label plus the remembered
 * domain. Equal timestamps order `model_version` first, then by key.
 */
export function buildRecentItems(
  businesses: BusinessListOut[],
  visits: Visits,
  limit = 8,
): RecentItem[] {
  const items: RecentItem[] = businesses.map((b) => {
    const isIndustry = b.kind === BusinessKind.industry;
    return {
      key: `${isIndustry ? "industry" : "business"}:${b.id}`,
      kind: isIndustry ? "industry" : "business",
      title: b.name,
      subtitle: isIndustry
        ? "template"
        : (b.model_count ?? 0) > 0
          ? countLabel(b.model_count ?? 0, "model version")
          : "No models yet",
      timestamp: ensureUtcIso(visits.businesses.get(b.id) ?? b.created_at),
      businessId: b.id,
    };
  });

  const byId = new Map(businesses.map((b) => [b.id, b]));
  for (const v of visits.versions) {
    const b = byId.get(v.businessId);
    if (!b || !isVersionListed(byId, v)) continue;
    const label = versionScopeLabel(v.version, v.scope);
    items.push({
      key: `model_version:${v.businessId}:${v.version}:${v.scope}`,
      kind: "model_version",
      title: b.name,
      subtitle: v.domain ? `${label}${MODEL_VERSION_SEPARATOR}${v.domain}` : label,
      timestamp: ensureUtcIso(v.visitedAt),
      businessId: v.businessId,
      version: v.version,
      scope: v.scope,
      ...(v.domain ? { domain: v.domain } : {}),
    });
  }

  const kindRank = (i: RecentItem) => (i.kind === "model_version" ? 0 : 1);
  return items
    .sort(
      (a, b) =>
        epoch(b.timestamp) - epoch(a.timestamp) ||
        kindRank(a) - kindRank(b) ||
        a.key.localeCompare(b.key),
    )
    .slice(0, limit);
}
