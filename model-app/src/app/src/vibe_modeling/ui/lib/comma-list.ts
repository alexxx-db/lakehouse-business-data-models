/**
 * Comma-separated lists ("a, b, c"), as stored in `business_domains` and sent
 * in widget values. Mirrors the backend's `BusinessIn.business_domains`
 * normalization: split on commas, trim, drop blanks, dedupe, keep order.
 */
export function splitCommaList(s: string | null | undefined): string[] {
  const out: string[] = [];
  for (const raw of (s ?? "").split(",")) {
    const item = raw.trim();
    if (item && !out.includes(item)) out.push(item);
  }
  return out;
}

/** The stored form: items joined with ", ". */
export function joinCommaList(items: readonly string[]): string {
  return items.join(", ");
}
