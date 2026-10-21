/**
 * Draft part status groups (backend `PartStatus`), shared by the wizard,
 * section cards, the review step and the busy countdown.
 */

/** Still drafting: a poll will report more. */
export const LIVE_PART_STATUSES: ReadonlySet<string> = new Set(["pending", "running"]);

/** Ended without a result; a manual Retry is valid (never "done": the server answers 409). */
export const RETRYABLE_PART_STATUSES: ReadonlySet<string> = new Set(["failed", "timed_out", "cancelled"]);

/** Tree states with no tree: Step 1 offers Retry / Start blank / the example instead of
 *  waiting. A busy tree counts down there, its Retry domains being the countdown's Retry now. */
export const TREE_FALLBACK_STATUSES: ReadonlySet<string> = new Set([...RETRYABLE_PART_STATUSES, "busy"]);
