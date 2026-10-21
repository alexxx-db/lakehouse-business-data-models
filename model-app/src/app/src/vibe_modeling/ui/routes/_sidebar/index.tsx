import { createFileRoute, Link } from "@tanstack/react-router";
import { Suspense, useEffect, useRef } from "react";
import { QueryErrorResetBoundary, useQueryClient } from "@tanstack/react-query";
import { ErrorBoundary } from "react-error-boundary";
import { ArrowRight, Clock } from "lucide-react";

import {
  useListBusinessesSuspense,
  getUserPreferencesKey,
  useGetUserPreferences,
  type BusinessListOut,
  type UserPreferenceOut,
} from "@/lib/api";
import { selector } from "@/lib/selector";
import { Skeleton } from "@/components/ui/skeleton";
import { WorkflowDiagram } from "@/components/flow/workflow-diagram";
import { useAssessReady } from "@/lib/assessment";
import { EntryPoints } from "@/components/home/entry-points";
import { JumpBackInList } from "@/components/home/jump-back-in";
import {
  buildRecentItems,
  collectVisits,
  deleteVisitKeys,
  pruneVisits,
} from "@/components/home/recent-items";

export const Route = createFileRoute("/_sidebar/")({
  component: HomePage,
});

export function HomePage() {
  return (
    <div className="mx-auto w-full max-w-5xl space-y-10 px-6 py-8">
      <OrientationStrip />
      <QueryErrorResetBoundary>
        {({ reset }) => (
          <ErrorBoundary
            onReset={reset}
            fallbackRender={({ resetErrorBoundary }) => (
              <ResumeErrorFallback onRetry={resetErrorBoundary} />
            )}
          >
            <Suspense fallback={<ResumeSkeleton />}>
              <ResumeSection />
            </Suspense>
          </ErrorBoundary>
        )}
      </QueryErrorResetBoundary>
    </div>
  );
}

function OrientationStrip() {
  const { ready: assessReady } = useAssessReady();
  return (
    <section>
      <div className="mb-3 flex flex-wrap items-end justify-between gap-2">
        <p className="max-w-[68ch] text-sm text-muted-foreground">
          You build your data model through iterations (runs) with an AI agent.
          Pick a starting point, review, add contextual feedback and run again.
        </p>
        <Link
          to="/help/$topic"
          params={{ topic: "flow" }}
          className="inline-flex shrink-0 items-center gap-1.5 text-sm text-primary hover:underline"
        >
          Learn how it works
          <ArrowRight className="h-3.5 w-3.5" />
        </Link>
      </div>
      <div className="rounded-md border border-border bg-card p-5">
        <WorkflowDiagram variant="strip" assessment={assessReady} />
      </div>
    </section>
  );
}

/** Data-backed resume section. "Jump back in" renders only when there is
 *  history; "Start something new" always renders so a newcomer can start from
 *  the home page. Visit times come from the per-user preference store, so the
 *  list reorders after visiting a business, industry, or model version. */
function ResumeSection() {
  // Unfiltered: businesses and industries are both `businesses` rows, told
  // apart by `kind`.
  const {
    data: businesses,
    dataUpdatedAt,
    isFetching,
  } = useListBusinessesSuspense<BusinessListOut[]>(selector<BusinessListOut[]>());
  // Non-suspense + no retry: a preferences fetch failure degrades to
  // creation-order rather than throwing into the ErrorBoundary. `select`
  // unwraps the `{ data }` envelope so `prefs` is the array directly.
  const { data: prefs, isFetching: prefsFetching } = useGetUserPreferences<UserPreferenceOut[]>({
    query: { retry: false, select: (r) => r.data },
  });

  // Prune stale and excess visit rows once per mount, after both reads have
  // finished fetching (cached prefs may predate a visit just recorded). The ref outlives StrictMode's simulated remount and the prefs
  // refetch that the invalidation below causes.
  const queryClient = useQueryClient();
  const pruned = useRef(false);
  useEffect(() => {
    if (pruned.current || prefs === undefined || isFetching || prefsFetching) return;
    pruned.current = true;
    const keys = pruneVisits(prefs, businesses, dataUpdatedAt);
    if (keys.length === 0) return;
    void deleteVisitKeys(keys)
      .then((anyDeleted) =>
        anyDeleted
          ? queryClient.invalidateQueries({ queryKey: getUserPreferencesKey() })
          : undefined,
      )
      .catch(() => {});
  }, [prefs, businesses, dataUpdatedAt, isFetching, prefsFetching, queryClient]);

  const items = buildRecentItems(businesses, collectVisits(prefs ?? []));

  return (
    <>
      {items.length > 0 && (
        <section>
          <div className="mb-3 flex items-center gap-2">
            <Clock className="h-4 w-4 text-muted-foreground" />
            <h2 className="text-lg font-semibold">Jump back in</h2>
          </div>
          <JumpBackInList items={items} />
        </section>
      )}

      <section>
        <h2 className="mb-3 text-xs font-semibold uppercase tracking-wider text-muted-foreground">
          Start something new
        </h2>
        <EntryPoints />
      </section>
    </>
  );
}

function ResumeSkeleton() {
  return (
    <section className="space-y-3">
      <Skeleton className="h-6 w-40" />
      <div className="grid gap-2 sm:grid-cols-2">
        {[...Array(4)].map((_, i) => (
          <Skeleton key={i} className="h-14 w-full" />
        ))}
      </div>
    </section>
  );
}

function ResumeErrorFallback({ onRetry }: { onRetry: () => void }) {
  return (
    <section className="rounded-md border border-border bg-card p-6">
      <p className="text-sm font-medium">Couldn't load your recent work</p>
      <p className="mt-1 text-sm text-muted-foreground">
        You can still start something new below, or try again.
      </p>
      <div className="mt-4 space-y-4">
        <button
          type="button"
          onClick={onRetry}
          className="text-sm text-primary hover:underline"
        >
          Try again
        </button>
        <EntryPoints />
      </div>
    </section>
  );
}
