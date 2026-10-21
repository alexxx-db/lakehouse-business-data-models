// ISO 8601 date formatting — locale-neutral, unambiguous, sortable.
// Uses sv-SE (Swedish) as a shortcut: its locale output naturally matches
// ISO 8601 ("2026-04-19 16:17:32") while still respecting the viewer's
// local timezone.

const DATE_FMT = new Intl.DateTimeFormat("sv-SE", {
  year: "numeric",
  month: "2-digit",
  day: "2-digit",
});

const DATETIME_FMT = new Intl.DateTimeFormat("sv-SE", {
  year: "numeric",
  month: "2-digit",
  day: "2-digit",
  hour: "2-digit",
  minute: "2-digit",
  second: "2-digit",
});

/** Normalize a backend timestamp to an explicit-UTC ISO string.
 *
 *  Datetime columns here are naive `TIMESTAMP`s (no `DateTime(timezone=True)`),
 *  so Postgres serializes them WITHOUT a tz offset while SQLite test fixtures
 *  keep the `+00:00` from the tz-aware default. A bare `new Date("...")` parses
 *  the offset-less form as LOCAL time, which skews both ordering and "time ago".
 *  Appending `Z` when no designator is present pins every timestamp to one basis
 *  (UTC), so values from either dialect - and visited-vs-never-visited items -
 *  compare on the same epoch. Values that already carry `Z`/an offset, and
 *  date-only strings, pass through unchanged. */
export function ensureUtcIso(value: string): string {
  if (!value || !value.includes("T")) return value;
  const hasTz = /(Z|[+-]\d{2}:?\d{2})$/.test(value);
  return hasTz ? value : `${value}Z`;
}

/** Parse any accepted timestamp input; strings go through `ensureUtcIso` so an
 *  offset-less backend value reads as UTC. Every formatter here parses with it. */
function toDate(value: string | number | Date): Date {
  return new Date(typeof value === "string" ? ensureUtcIso(value) : value);
}

export function formatDate(value: string | number | Date | null | undefined, fallback = "—"): string {
  if (!value) return fallback;
  const d = toDate(value);
  return isNaN(d.getTime()) ? fallback : DATE_FMT.format(d);
}

export function formatDateTime(value: string | number | Date | null | undefined, fallback = "—"): string {
  if (!value) return fallback;
  const d = toDate(value);
  return isNaN(d.getTime()) ? fallback : DATETIME_FMT.format(d);
}

/** Format a duration in seconds for the D-09 watchdog elapsed-time display.
 *  - Under 1 hour: `MM:SS` (e.g. "00:42", "12:07")
 *  - 1 hour or more: `HH:MM:SS` (e.g. "01:00:00", "12:34:56")
 *  Pure helper — kept here next to formatDateTime/formatDuration so the
 *  full "time-related formatters" surface lives in one module. */
export function formatElapsedSeconds(totalSeconds: number): string {
  if (!isFinite(totalSeconds) || totalSeconds < 0) totalSeconds = 0;
  totalSeconds = Math.floor(totalSeconds);
  const hours = Math.floor(totalSeconds / 3600);
  const minutes = Math.floor((totalSeconds % 3600) / 60);
  const seconds = totalSeconds % 60;
  const pad = (n: number) => String(n).padStart(2, "0");
  if (hours >= 1) {
    return `${pad(hours)}:${pad(minutes)}:${pad(seconds)}`;
  }
  return `${pad(minutes)}:${pad(seconds)}`;
}

/** Format a past timestamp as a compact "time ago" string ("just now",
 *  "5m ago", "2h ago", "3d ago"); falls back to an absolute date past a week.
 *  Used by the overview command strip's "latest <ago>" run summary. */
export function formatRelative(
  value: string | number | Date | null | undefined,
  fallback = "—",
): string {
  if (!value) return fallback;
  const d = toDate(value);
  if (isNaN(d.getTime())) return fallback;
  const diffMs = Date.now() - d.getTime();
  if (diffMs < 0) return "just now";
  const seconds = Math.floor(diffMs / 1000);
  if (seconds < 60) return "just now";
  const minutes = Math.floor(seconds / 60);
  if (minutes < 60) return `${minutes}m ago`;
  const hours = Math.floor(minutes / 60);
  if (hours < 24) return `${hours}h ago`;
  const days = Math.floor(hours / 24);
  if (days < 7) return `${days}d ago`;
  return formatDate(d);
}

/** Format a future timestamp relative to `now` ("in under a minute",
 *  "in 5 min", "in 2 h"); a past or unparseable value gives `fallback`.
 *  The forward counterpart of `formatRelative`. */
export function formatUntil(
  value: string | number | Date | null | undefined,
  now: number = Date.now(),
  fallback = "soon",
): string {
  if (!value) return fallback;
  const t = toDate(value).getTime();
  if (isNaN(t)) return fallback;
  const diffMs = t - now;
  if (diffMs <= 0) return fallback;
  const minutes = Math.round(diffMs / 60000);
  if (minutes < 1) return "in under a minute";
  if (minutes < 60) return `in ${minutes} min`;
  return `in ${Math.round(minutes / 60)} h`;
}

/** Format a millisecond duration into a compact human-readable string
 *  ("450ms", "12s", "3m 24s", "1h 12m"). Negative values clamp to 0. */
export function formatDuration(ms: number): string {
  if (!isFinite(ms) || ms < 0) ms = 0;
  if (ms < 1000) return `${Math.round(ms)}ms`;
  const totalSeconds = Math.floor(ms / 1000);
  if (totalSeconds < 60) return `${totalSeconds}s`;
  const totalMinutes = Math.floor(totalSeconds / 60);
  const remSeconds = totalSeconds % 60;
  if (totalMinutes < 60) {
    return remSeconds ? `${totalMinutes}m ${remSeconds}s` : `${totalMinutes}m`;
  }
  const hours = Math.floor(totalMinutes / 60);
  const remMinutes = totalMinutes % 60;
  return remMinutes ? `${hours}h ${remMinutes}m` : `${hours}h`;
}
