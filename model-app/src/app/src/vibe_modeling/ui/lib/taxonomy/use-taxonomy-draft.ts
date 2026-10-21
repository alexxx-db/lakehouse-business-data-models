import { useCallback } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { ApiError, cancelTaxonomyDraft, getTaxonomyDraft, retryTaxonomyDraftPart, type TaxonomyDraftOut } from "@/lib/api";
import { notifyError } from "@/lib/notify";

export const TAXONOMY_POLL_MS = 1500;

const isNotFound = (e: unknown) => e instanceof ApiError && e.status === 404;
const draftKey = (draftId: string | null) => ["taxonomy-draft", draftId] as const;

/**
 * Polls GET /api/taxonomy/drafts/{id} while the draft is running; stops when it
 * isn't. Retry/cancel go through `useTaxonomyDraftActions`, which writes the
 * returned TaxonomyDraftOut into ["taxonomy-draft", draftId] (setQueryData +
 * invalidateQueries): that re-evaluates refetchInterval, so a finished draft
 * that goes back to "running" resumes polling.
 */
export function useTaxonomyDraft(draftId: string | null, { pollMs = TAXONOMY_POLL_MS }: { pollMs?: number } = {}) {
  const q = useQuery<TaxonomyDraftOut, unknown>({
    queryKey: draftKey(draftId),
    enabled: Boolean(draftId),
    queryFn: async () => (await getTaxonomyDraft({ draft_id: draftId! })).data,
    refetchInterval: (query) => {
      if (isNotFound(query.state.error)) return false; // draft is gone; nothing to poll
      return query.state.data?.status === "running" || !query.state.data ? pollMs : false;
    },
    retry: (count, err) => !isNotFound(err) && count < 3,
  });
  const lost = isNotFound(q.error);
  return { draft: q.data, error: q.error, lost };
}

/**
 * The one per-part Retry and Cancel path for a draft (wizard parts and the
 * review step's description). Each writes the returned draft into the polling
 * hook's cache, so a retried part on a finished draft renders and polls.
 * Failures go to `notifyError` (a 422 `config_missing` shows its message).
 */
export function useTaxonomyDraftActions(draftId: string | null) {
  const queryClient = useQueryClient();
  const apply = useCallback((d: TaxonomyDraftOut) => {
    queryClient.setQueryData(draftKey(draftId), d);
    void queryClient.invalidateQueries({ queryKey: draftKey(draftId) });
  }, [queryClient, draftId]);

  const retry = useCallback(async (part: string) => {
    if (!draftId) return;
    try {
      apply((await retryTaxonomyDraftPart({ draft_id: draftId, part })).data);
    } catch (err) {
      notifyError(err, { fallback: "Retry failed" });
    }
  }, [apply, draftId]);

  const cancel = useCallback(async () => {
    if (!draftId) return;
    try {
      apply((await cancelTaxonomyDraft({ draft_id: draftId })).data);
    } catch (err) {
      notifyError(err, { fallback: "Cancel failed" });
    }
  }, [apply, draftId]);

  return { retry, cancel };
}
