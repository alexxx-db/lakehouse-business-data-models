import { Fragment } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import type { AssessResultsOut } from "@/lib/api";
import { LETTER_CLASS } from "./letter-badge";
import { LETTER_ORDER, STRUCTURE_CLASS, STRUCTURE_LABEL } from "@/lib/assessment";
import { cn } from "@/lib/utils";
import { ExecutiveSummary } from "./executive-summary";
import { NextStepGuide } from "./next-step-guide";

/** Results summary for one domain run: entity grades, model quality score, and the skills / Genie versions that produced it. */
export function Scorecard({
  results,
  onJumpToTab,
}: {
  results: AssessResultsOut;
  onJumpToTab?: (tab: string) => void;
}) {
  const { domain_run: run, grades, letter_counts: letters } = results;
  const score = run.model_quality_score;
  return (
    <div className="space-y-4">
      <ExecutiveSummary summary={results.summary} domainRunId={run.id} />
      <NextStepGuide results={results} onJumpToTab={onJumpToTab} />
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Scorecard</CardTitle>
        </CardHeader>
        <CardContent className="space-y-2 text-sm">
          <div className="flex flex-wrap items-center gap-2">
            {LETTER_ORDER.map((l, i) => {
              const n = letters?.[l] ?? 0;
              return (
                <Fragment key={l}>
                  {i > 0 && <span aria-hidden className="text-muted-foreground">·</span>}
                  <span
                    className={cn(
                      "rounded-full border px-2.5 py-0.5 text-xs font-semibold",
                      n === 0 ? "opacity-40" : LETTER_CLASS[l],
                    )}
                  >
                    {n} {l}
                  </span>
                </Fragment>
              );
            })}
          </div>
          {results.structure_counts && (
            <div className="flex flex-wrap items-center gap-2" aria-label="Structure">
              {(["sound", "review", "rework"] as const).map((s, i) => {
                const n = results.structure_counts[s] ?? 0;
                return (
                  <Fragment key={s}>
                    {i > 0 && <span aria-hidden className="text-muted-foreground">·</span>}
                    <span
                      className={cn(
                        "rounded-full border px-2.5 py-0.5 text-xs font-semibold",
                        n === 0 ? "opacity-40" : STRUCTURE_CLASS[s],
                      )}
                    >
                      {n} {STRUCTURE_LABEL[s]}
                    </span>
                  </Fragment>
                );
              })}
            </div>
          )}
          <p className="text-lg font-medium">
            {grades.full ?? 0} Full · {grades.partial ?? 0} Partial · {grades.blocked ?? 0} Blocked
          </p>
          <p>Model quality score {score == null ? "—" : Math.round(score)}</p>
          <p className="text-muted-foreground">
            Skills {run.skills_version || "—"}
            {run.skills_commit ? ` (${run.skills_commit.slice(0, 7)})` : ""} · Genie {run.genie_version || "—"}
          </p>
          {run.metamodel_location && (
            <p className="text-muted-foreground">
              Metamodel {run.metamodel_location}
              {run.metamodel_version ? ` v${run.metamodel_version}` : ""}
            </p>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
