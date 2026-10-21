import type { TaxonomyIssue } from "@/lib/api";

type Props = {
  /** Blocking problems from sanitize() (blank names, no domains). */
  problems: string[];
  /** Compile issues from /api/taxonomy/compile. */
  issues: TaxonomyIssue[];
  /** A failed compile request (already turned into a message). */
  error?: string | null;
};

/** One list for everything that can block Create or needs a look: Step 2 (inline) and Step 4. */
export function CompileIssues({ problems, issues, error }: Props) {
  const errors = issues.filter((i) => i.severity === "error");
  const warnings = issues.filter((i) => i.severity === "warning");
  if (!error && problems.length === 0 && issues.length === 0) return null;
  return (
    <div className="space-y-1" data-testid="compile-issues">
      {error && <p className="text-sm text-destructive">{error}</p>}
      {problems.map((msg, k) => <p key={`p${k}`} className="text-sm text-destructive">{msg}</p>)}
      {errors.map((i, k) => <p key={`e${k}`} className="text-sm text-destructive">{i.message}</p>)}
      {warnings.map((i, k) => <p key={`w${k}`} className="text-xs text-warning">{i.message}</p>)}
    </div>
  );
}
