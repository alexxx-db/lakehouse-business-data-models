import { AlertTriangle } from "lucide-react";
import type { TaxonomyDomain, TaxonomyIssue, TaxonomyTree } from "@/lib/api";
import { cn } from "@/lib/utils";
import { domainSchema } from "@/lib/taxonomy/tree";

// Theme-aware per-domain accents, cycled. Full literal class strings so Tailwind keeps them.
const ACCENTS = [
  "bg-sky-50 border-sky-200 dark:bg-sky-950/40 dark:border-sky-900",
  "bg-emerald-50 border-emerald-200 dark:bg-emerald-950/40 dark:border-emerald-900",
  "bg-amber-50 border-amber-200 dark:bg-amber-950/40 dark:border-amber-900",
  "bg-violet-50 border-violet-200 dark:bg-violet-950/40 dark:border-violet-900",
  "bg-rose-50 border-rose-200 dark:bg-rose-950/40 dark:border-rose-900",
  "bg-teal-50 border-teal-200 dark:bg-teal-950/40 dark:border-teal-900",
  "bg-lime-50 border-lime-200 dark:bg-lime-950/40 dark:border-lime-900",
  "bg-slate-50 border-slate-200 dark:bg-slate-900/60 dark:border-slate-800",
];

const issuesFor = (issues: TaxonomyIssue[], i: number, severity: TaxonomyIssue["severity"]) =>
  issues.filter((r) => r.severity === severity && (r.domains ?? []).includes(i)).map((r) => r.message);

/**
 * Blocking problems for domain `i`: blank names (checked here, at once) plus the
 * server compile's ERROR issues attributed to it (`issues[].domains`; the
 * agent's naming rules live only in backend `taxonomy/rules.py`). Pass `issues`
 * only when they belong to this exact tree.
 */
export function domainProblems(tree: TaxonomyTree, i: number, issues: TaxonomyIssue[] = []): string[] {
  const d = tree.domains[i];
  if (!d) return [];
  const out: string[] = [];
  if (!d.name.trim()) out.push("This domain needs a name.");
  (d.subdomains ?? []).forEach((s, si) => { if (!s.name.trim()) out.push(`Sub-domain ${si + 1} needs a name.`); });
  return [...out, ...issuesFor(issues, i, "error")];
}

/** Non-blocking warnings the server compile attributed to domain `i` (plural, two-word sub-domains, ...). */
export function domainWarnings(issues: TaxonomyIssue[], i: number): string[] {
  return issuesFor(issues, i, "warning");
}

type Props = {
  domain: TaxonomyDomain;
  index: number;
  hasError?: boolean;
  /** Naming-rule warnings only (non-blocking): shown amber instead of red. */
  hasWarning?: boolean;
  /** When set the card is a button that opens the editor; otherwise it is a static preview. */
  onOpen?: (index: number) => void;
  testId?: string;
};

export function DomainCard({ domain: d, index, hasError, hasWarning, onOpen, testId }: Props) {
  const interactive = !!onOpen;
  return (
    <div
      data-testid={testId ?? (interactive ? `domain-card-${index}` : "domain-preview")}
      className={cn("rounded-md", interactive && "cursor-pointer focus:outline-none focus-visible:ring-2 focus-visible:ring-ring")}
      {...(interactive
        ? {
            role: "button",
            tabIndex: 0,
            onClick: () => onOpen!(index),
            onKeyDown: (e: React.KeyboardEvent) => {
              if (e.key === "Enter" || e.key === " ") { e.preventDefault(); onOpen!(index); }
            },
          }
        : {})}
    >
      <div
        data-testid="taxonomy-domain-column"
        className={cn(
          "h-full rounded-md border p-2 text-foreground",
          ACCENTS[index % ACCENTS.length],
          hasError && "border-destructive dark:border-destructive",
          interactive && "transition-shadow hover:shadow-md",
        )}
      >
        <div className="mb-2">
          <div className="text-sm font-semibold leading-tight">{d.name.trim() || "(unnamed)"}</div>
          <div className="font-mono text-[10px] text-muted-foreground">{domainSchema(d)}</div>
          {(hasError || hasWarning) && (
            <div
              data-testid="domain-attention"
              data-severity={hasError ? "error" : "warning"}
              className={cn("mt-1 flex items-center gap-1 text-[10px] font-medium", hasError ? "text-destructive" : "text-amber-700 dark:text-amber-400")}
            >
              <AlertTriangle className="h-3 w-3" /> Needs attention
            </div>
          )}
        </div>
        {(d.subdomains ?? []).length === 0 && <div className="text-xs italic text-muted-foreground">No sub-domains yet</div>}
        <div className="space-y-2">
          {(d.subdomains ?? []).map((s, j) => (
            <div key={`${j}-${s.name}`} className="rounded border bg-background/70 p-1.5">
              <div className="mb-1 text-xs font-medium">{s.name}</div>
              <div className="flex flex-wrap gap-1">
                {(s.categories ?? []).map((c, k) => (
                  <span key={`${k}-${c}`} data-testid="taxonomy-category-pill" className="rounded-full border bg-card px-2 py-0.5 text-[10px] text-muted-foreground">
                    {c}
                  </span>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
