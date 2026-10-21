import { Badge } from "@/components/ui/badge";
import { STATUS_LABEL, formatResume } from "@/lib/assessment";

const VARIANT: Record<string, "default" | "secondary" | "destructive" | "outline"> = {
  completed: "secondary",
  failed: "destructive",
  results_invalid: "destructive",
  cancelled: "outline",
};

/** Assessment status pill; rate-limited runs also show the attempt and resume time. */
export function StatusBadge({
  status,
  attempt,
  resumeAt,
}: {
  status: string;
  attempt?: number;
  resumeAt?: string | null;
}) {
  let label = STATUS_LABEL[status] ?? status;
  if (status === "rate_limited") {
    if (attempt) label += ` · attempt ${attempt}`;
    const resume = formatResume(resumeAt);
    if (resume) label += ` · resumes ${resume}`;
  }
  return <Badge variant={VARIANT[status] ?? "default"}>{label}</Badge>;
}
