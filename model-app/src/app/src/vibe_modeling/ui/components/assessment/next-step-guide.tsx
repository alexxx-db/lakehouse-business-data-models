import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import type { AssessResultsOut } from "@/lib/api";
import { linkDecisionsToVibes, vibeRef } from "@/lib/assessment";

interface NextStepGuideProps {
  results: AssessResultsOut;
  onJumpToTab?: (tab: "vibes" | "decisions" | "handoff" | "scorecard") => void;
}

type StepStatus = "done" | "current" | "upcoming";

interface Step {
  label: string;
  detail: string;
  status: StepStatus;
  actionText?: string;
  tab?: "vibes" | "decisions" | "handoff" | "scorecard";
}

/**
 * Guided next steps card: shows the current action (iterate model, answer decisions, hand off)
 * with completion status and progress through the assessment workflow.
 */
export function NextStepGuide({ results, onJumpToTab }: NextStepGuideProps) {
  const { structure_counts, pending_decisions, next_vibes } = results;

  // Link decisions to vibes to get refs for step 1 detail
  const { decisionsForVibe } = linkDecisionsToVibes(pending_decisions, next_vibes);

  // Get before_build vibes and their refs (keep API order: prioritized first, then by priority/ordinal)
  const beforeBuildVibes = next_vibes.filter((v) => v.urgency === "before_build");
  const beforeBuildRefs = beforeBuildVibes.map((v) => vibeRef(v, next_vibes));

  // Get linked vibes (those referenced by decisions, in API order)
  const linkedVibeIds = Object.keys(decisionsForVibe);
  const linkedVibes = next_vibes.filter((v) => linkedVibeIds.includes(v.id));
  const linkedRefs = linkedVibes.map((v) => vibeRef(v, next_vibes));

  // Determine step statuses
  const structureOpen = pending_decisions.filter(
    (d) =>
      d.kind === "structure" &&
      d.answer_status === "open",
  );
  const sourceOpen = pending_decisions.filter((d) => d.kind === "source" && d.answer_status === "open");

  const step1Done = !structureOpen.length && structure_counts && (structure_counts.review ?? 0) === 0 && (structure_counts.rework ?? 0) === 0;
  const step2Done = !sourceOpen.length;

  // Build step 1 detail with before_build or linked vibe refs
  const vibeRefsToShow = beforeBuildRefs.length > 0 ? beforeBuildRefs : linkedRefs;
  const vibeRefsSuffix = vibeRefsToShow.length > 0 ? ` (${vibeRefsToShow.join(", ")})` : "";

  const steps: Step[] = [
    {
      label: "Iterate the model",
      detail: structureOpen.length
        ? `${structureOpen.length} structure decision${structureOpen.length > 1 ? "s" : ""} pending. Review the next vibes${vibeRefsSuffix}, run them, then re-assess.`
        : structure_counts && ((structure_counts.review ?? 0) > 0 || (structure_counts.rework ?? 0) > 0)
          ? `${(structure_counts.review ?? 0) + (structure_counts.rework ?? 0)} entities need review or rework. Review the next vibes${vibeRefsSuffix}, run them, then re-assess.`
          : "Model structure is sound.",
      status: step1Done ? "done" : "current",
      tab: "vibes",
      actionText: step1Done ? undefined : "Review vibes",
    },
    {
      label: "Answer the build-gate decisions",
      detail: sourceOpen.length
        ? `${sourceOpen.length} source decision${sourceOpen.length > 1 ? "s" : ""} pending. They don't change the model.`
        : "No source decisions pending.",
      status: step1Done && !step2Done ? "current" : step1Done && step2Done ? "done" : "upcoming",
      tab: "decisions",
      actionText: sourceOpen.length > 0 && step1Done ? "Answer decisions" : undefined,
    },
    {
      label: "Hand off to the build",
      detail: "All decisions answered, model is ready.",
      status: step1Done && step2Done ? "current" : "upcoming",
      tab: "handoff",
      actionText: step1Done && step2Done ? "Go to hand-off" : undefined,
    },
  ];

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">What to do next</CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        {steps.map((step, i) => (
          <div key={step.label} className="space-y-2">
            <div className="flex items-start gap-3">
              <div className="flex flex-col items-center gap-1">
                <div
                  className={`h-8 w-8 rounded-full flex items-center justify-center text-sm font-semibold ${
                    step.status === "done"
                      ? "bg-green-100 text-green-800"
                      : step.status === "current"
                        ? "bg-primary/10 text-primary"
                        : "bg-muted text-muted-foreground"
                  }`}
                >
                  {step.status === "done" ? "✓" : i + 1}
                </div>
                {i < steps.length - 1 && (
                  <div
                    className={`w-0.5 h-12 ${
                      step.status === "done" ? "bg-green-200" : "bg-border"
                    }`}
                  />
                )}
              </div>
              <div className="flex-1 pt-1">
                <div className="flex items-center gap-2">
                  <h4 className="font-semibold text-sm">{step.label}</h4>
                  {step.status !== "upcoming" && (
                    <Badge variant={step.status === "done" ? "secondary" : "default"} className="text-xs">
                      {step.status === "done" ? "Done" : "Current"}
                    </Badge>
                  )}
                </div>
                <p className="text-sm text-muted-foreground mt-1">{step.detail}</p>
                {step.actionText && step.tab && onJumpToTab && (
                  <button
                    type="button"
                    className="mt-2 text-sm font-medium text-primary hover:underline"
                    aria-label={`Go to ${step.tab === "vibes" ? "Next vibes" : step.tab === "decisions" ? "Decisions" : "Hand-off"}`}
                    onClick={() => onJumpToTab(step.tab as "vibes" | "decisions" | "handoff")}
                  >
                    {step.actionText} →
                  </button>
                )}
              </div>
            </div>
          </div>
        ))}
      </CardContent>
    </Card>
  );
}
