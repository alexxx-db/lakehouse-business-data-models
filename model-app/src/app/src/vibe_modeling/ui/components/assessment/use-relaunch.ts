import { useState } from "react";
import { useQueryClient } from "@tanstack/react-query";
import { useNavigate } from "@tanstack/react-router";
import { toast } from "sonner";
import {
  getAssessmentKey,
  listAssessmentsKey,
  relaunchAssessment,
  type ReadinessOut,
} from "@/lib/api";
import { parse409, parseAdminHelp, type AdminHelp } from "@/lib/api-error";
import { notifyError } from "@/lib/notify";

type BlockedDetail = { error: "admin_help"; message?: string; readiness?: ReadinessOut };

/** A launch refused by the readiness checks: the 409 admin-help detail carrying `readiness`; null otherwise. */
export function parseBlocked(err: unknown): { message: string; readiness: ReadinessOut } | null {
  const detail = parse409<BlockedDetail>(err, "admin_help");
  if (!detail?.readiness) return null;
  return { message: detail.message || "Launch blocked by readiness checks", readiness: detail.readiness };
}

/**
 * Relaunch finished domain runs of a batch as a new batch (no body = every failed / cancelled /
 * results-invalid run). Navigates to the new batch; a readiness block is returned in `blocked`
 * and any other admin-help failure in `help`.
 */
export function useRelaunch(businessId: string, batchId: string) {
  const queryClient = useQueryClient();
  const navigate = useNavigate();
  const [pending, setPending] = useState(false);
  const [blocked, setBlocked] = useState<{ message: string; readiness: ReadinessOut } | null>(null);
  const [help, setHelp] = useState<AdminHelp | null>(null);

  const relaunch = async (domainRunIds?: string[]) => {
    setPending(true);
    setBlocked(null);
    setHelp(null);
    try {
      const r = await relaunchAssessment(
        { batch_id: batchId },
        domainRunIds ? { domain_run_ids: domainRunIds } : null,
      );
      toast.success("Relaunched — new assessment started");
      queryClient.invalidateQueries({ queryKey: listAssessmentsKey({ business_id: businessId }) });
      queryClient.invalidateQueries({ queryKey: getAssessmentKey({ batch_id: batchId }) });
      navigate({
        to: "/businesses/$businessId/assessments/$batchId",
        params: { businessId, batchId: r.data.id },
      });
    } catch (err) {
      // A readiness block or an admin-help failure is shown inline by the caller; only other errors toast.
      const b = parseBlocked(err);
      const h = b ? null : parseAdminHelp(err);
      if (b) setBlocked(b);
      else if (h) setHelp(h);
      else notifyError(err, { fallback: "Couldn't relaunch the assessment" });
    } finally {
      setPending(false);
    }
  };
  return { relaunch, pending, blocked, help };
}
