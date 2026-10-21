import { createFileRoute, Link } from "@tanstack/react-router";
import { keepPreviousData, useQuery } from "@tanstack/react-query";
import { useEffect, useMemo, useState, type ReactNode } from "react";
import { ArrowLeft } from "lucide-react";
import {
  compileTaxonomy, createTaxonomyDraft, getTaxonomyExample, useGetTaxonomyConfig,
  type TaxonomyConfigOut, type TaxonomyExampleOut, type TaxonomyIntake, type TaxonomySection, type TaxonomyTree,
} from "@/lib/api";
import { apiErrorMessage } from "@/lib/api-error";
import { useDebouncedValue, useUserRole } from "@/lib/hooks";
import { notifyError } from "@/lib/notify";
import { useTaxonomyDraft, useTaxonomyDraftActions } from "@/lib/taxonomy/use-taxonomy-draft";
import { useBusyAutoRetry } from "@/lib/taxonomy/busy-retry";
import { TREE_FALLBACK_STATUSES } from "@/lib/taxonomy/part-status";
import { emptyTree, sanitize } from "@/lib/taxonomy/tree";
import { Button } from "@/components/ui/button";
import { BusyCountdown } from "@/components/taxonomy/busy-countdown";
import { CompileIssues } from "@/components/taxonomy/compile-issues";
import { DraftProgress, PART_ORDER } from "@/components/taxonomy/draft-progress";
import { IntakeForm, type SkipStart } from "@/components/taxonomy/intake-form";
import { OutlineEditor } from "@/components/taxonomy/outline-editor";
import { MastersRelationshipsEditor } from "@/components/taxonomy/masters-relationships-editor";
import { SectionCard } from "@/components/taxonomy/section-card";
import { ReviewStep } from "@/components/taxonomy/review-step";
import { Skeleton } from "@/components/ui/skeleton";
import { ORG_DIVISIONS_PRESETS } from "@/lib/org-divisions";
import { joinCommaList, splitCommaList } from "@/lib/comma-list";

export const Route = createFileRoute("/_sidebar/businesses/new_/from-domains")({ component: WizardGate });

export const NOT_INSTALLED_COPY =
  "This installation doesn't include the Domain Taxonomy Builder. It is enabled at install time.";
export const NOT_READY_COPY = "An admin must choose a model service in Settings → Platform.";
export const UNAVAILABLE_COPY =
  "The Domain Taxonomy Builder is unavailable right now. It is checked again automatically.";

function GateNotice({ children }: { children: ReactNode }) {
  return (
    <div className="space-y-6 p-6">
      <div className="flex items-center gap-4">
        <Button variant="ghost" size="icon" asChild><Link to="/"><ArrowLeft className="h-4 w-4" /></Link></Button>
        <h1 className="text-2xl font-semibold tracking-tight">Build from your domains</h1>
      </div>
      <div className="max-w-2xl space-y-2 rounded-md border p-4 text-sm" data-testid="taxonomy-gate">{children}</div>
    </div>
  );
}

/**
 * Installed but not ready. No model service: anyone sees that an admin must
 * choose one. A service whose last test call was refused: non-admins see that
 * it is unavailable and re-checked automatically (the server re-probes a
 * refusal older than 5 minutes); admins see the reason. Admins always get the
 * Settings link.
 */
function NotReady({ config }: { config: TaxonomyConfigOut }) {
  const isAdmin = useUserRole() === "app_admin";
  const reason = config.last_check?.message;
  return (
    <GateNotice>
      {!config.model_service ? (
        <p>{NOT_READY_COPY}</p>
      ) : isAdmin && reason ? (
        <>
          <p>{reason}</p>
          <p className="text-muted-foreground">It is checked again automatically, or run Test in Settings.</p>
        </>
      ) : (
        <p>{UNAVAILABLE_COPY}</p>
      )}
      {isAdmin && (
        <Button variant="outline" size="sm" asChild>
          <Link to="/settings" search={{ tab: "platform" }}>Open Settings → Platform</Link>
        </Button>
      )}
    </GateNotice>
  );
}

/**
 * Entry check for the optional builder: not installed, or installed but not
 * ready (no model service, or its last test call was refused), shows a notice
 * instead of the wizard. Once the wizard has been shown it stays mounted, so
 * a refusal later (a draft start or retry refused with 422 `config_missing`,
 * shown by `notifyError`) never throws away the user's edits.
 */
function WizardGate() {
  const { data, error, isLoading } = useGetTaxonomyConfig({ query: { retry: false } });
  const [entered, setEntered] = useState(false);
  const config = data?.data;
  if (config?.ready && !entered) setEntered(true);
  if (entered) return <Wizard />;
  if (isLoading) return <div className="p-6"><Skeleton className="h-64 w-full max-w-4xl" /></div>;
  if (error || !config) {
    return <GateNotice><p>{apiErrorMessage(error, "Couldn't check whether the Domain Taxonomy Builder is available.")}</p></GateNotice>;
  }
  if (!config.installed) return <GateNotice><p>{NOT_INSTALLED_COPY}</p></GateNotice>;
  return <NotReady config={config} />;
}

const STEPS = ["Tell us about you", "Domains", "Everything else", "Review & create"];
const SECTION_PARTS = PART_ORDER.filter((k) => k !== "tree");
const INLINE_COMPILE_DEBOUNCE_MS = 400;



/** Comma-separated division names. Keeps its own text so typing ", " isn't eaten by re-joining. */
function DivisionsInput({ value, onChange }: { value: string[]; onChange: (v: string[]) => void }) {
  const [text, setText] = useState(joinCommaList(value));
  useEffect(() => {
    // Resync only when the tree changed from outside (draft landed, example loaded).
    if (splitCommaList(text).join("\u0000") !== value.join("\u0000")) setText(joinCommaList(value));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [value]);
  return (
    <label className="flex items-center gap-1">Division names
      <input className="h-7 w-80 rounded border bg-background px-2 text-xs" value={text}
        placeholder="Customer Operations, Grid & Gas Operations, Corporate"
        onChange={(e) => { setText(e.target.value); onChange(splitCommaList(e.target.value)); }} />
    </label>
  );
}

function Wizard() {
  const [step, setStep] = useState(0);
  const [intake, setIntake] = useState<TaxonomyIntake | null>(null);
  const [sectorId, setSectorId] = useState<string | null>(null);
  const [draftId, setDraftId] = useState<string | null>(null);
  const [starting, setStarting] = useState(false);
  const [tree, setTree] = useState<TaxonomyTree | null>(null);
  const [sections, setSections] = useState<Record<string, TaxonomySection>>({});
  const [strictness, setStrictness] = useState<"strict" | "guided">("strict");
  const [sorConfirmed, setSorConfirmed] = useState(false);
  const [example, setExample] = useState<TaxonomyExampleOut | null>(null);
  const [initialDescription, setInitialDescription] = useState<string | undefined>(undefined);
  const { draft, lost } = useTaxonomyDraft(draftId);
  const { retry, cancel } = useTaxonomyDraftActions(draftId);
  // Only the tree counts down while it is busy (the sections wait for it), and
  // only while its countdown is on screen: Step 1's fallback without a tree, or
  // DraftProgress on Steps 1-2 with one.
  const treeCountdownShown = step === 1 || (step === 2 && tree !== null);
  const treeRetry = useBusyAutoRetry(treeCountdownShown ? draft?.parts.tree?.status : undefined, {
    retry: () => retry("tree"), cancel, resetKey: draftId,
  });

  useEffect(() => { getTaxonomyExample().then((r) => setExample(r.data)).catch(() => {}); }, []);

  // Copy drafted parts into local (editable) state once each lands; never overwrite user edits.
  useEffect(() => {
    if (!draft) return;
    const t = draft.parts.tree;
    if (t?.status === "done" && t.tree && !tree) setTree(t.tree);
    setSections((prev) => {
      const next = { ...prev };
      for (const k of SECTION_PARTS) {
        const p = draft.parts[k];
        if (p?.status === "done" && p.section && !next[k]) next[k] = p.section;
      }
      return next;
    });
  }, [draft, tree]);

  // Step 2 inline check: debounced compile of the sanitized tree (warnings + errors under the editor).
  const debouncedTree = useDebouncedValue(tree, INLINE_COMPILE_DEBOUNCE_MS);
  const inlineClean = useMemo(() => (debouncedTree ? sanitize(debouncedTree, {}) : null), [debouncedTree]);
  const inlineBlocked = !inlineClean || inlineClean.problems.length > 0;
  const inline = useQuery({
    queryKey: ["taxonomy-compile-inline", inlineClean?.tree, strictness],
    queryFn: async () => (await compileTaxonomy({ tree: inlineClean!.tree, strictness, sections: {} })).data,
    enabled: step === 1 && !inlineBlocked,
    retry: false,
    placeholderData: keepPreviousData,
  });
  // Per-card attribution uses issue indices, so only issues for exactly the
  // current tree: none while the debounce is pending, while the shown result is
  // the previous tree's (placeholder data), or while blank names block the
  // compile (local problems show instead).
  const cardIssues = debouncedTree === tree && !inline.isPlaceholderData && !inlineBlocked ? inline.data?.issues : undefined;

  /** Start a draft. From the intake form it starts fresh. "Draft again" after a
   *  lost draft passes `keepEdits`: the user's tree and sections stay, the step
   *  stays, and the copy-only-if-empty effect above fills only what is missing. */
  const startDraft = async (i: TaxonomyIntake, sec: string | null, { keepEdits = false } = {}) => {
    setIntake(i); setSectorId(sec); setStarting(true);
    try {
      const r = await createTaxonomyDraft(i);
      if (!keepEdits) { setTree(null); setSections({}); setStep(1); }
      setDraftId(r.data.draft_id);
    } catch (err) {
      notifyError(err, { fallback: "Couldn't start drafting" });
    } finally {
      setStarting(false);
    }
  };

  const loadExample = async () => {
    try {
      const ex = example ?? (await getTaxonomyExample()).data;
      setExample(ex);
      setTree(ex.tree);
      setSections(ex.sections);
      setInitialDescription(ex.description);
    } catch (err) {
      notifyError(err, { fallback: "Couldn't load the Ridgeline example" });
      setTree(emptyTree());
      setSections({});
    }
  };

  const skip = async (i: TaxonomyIntake, sec: string | null, start: SkipStart) => {
    setIntake(i); setSectorId(sec); setDraftId(null); setInitialDescription(undefined);
    if (start === "example") {
      await loadExample();
    } else {
      setTree(emptyTree());
      setSections({});
    }
    setStep(1);
  };

  const partStatus = (k: string) => draft?.parts[k]?.status ?? (draftId ? "pending" : "done");

  return (
    <div className="space-y-6 p-6">
      <div className="flex items-center gap-4">
        <Button variant="ghost" size="icon" asChild><Link to="/"><ArrowLeft className="h-4 w-4" /></Link></Button>
        <h1 className="text-2xl font-semibold tracking-tight">Build from your domains</h1>
      </div>
      <ol className="flex gap-4 text-sm">
        {STEPS.map((s, i) => (
          <li key={s} className={i === step ? "font-semibold" : "text-muted-foreground"}>{i + 1}. {s}</li>
        ))}
      </ol>

      {lost && intake && (
        <div className="flex items-center gap-2 rounded border border-destructive/40 p-2 text-sm">
          This draft was lost (the app restarted or it expired).
          <Button size="sm" variant="outline" onClick={() => startDraft(intake, sectorId, { keepEdits: true })}>Draft again</Button>
        </div>
      )}
      {draft && step > 0 && step < 3 && (
        // With no tree yet, step 1 shows the tree countdown itself.
        <DraftProgress draft={draft} onCancel={cancel} treeRetry={tree ? treeRetry : undefined} />
      )}

      {step === 0 && <IntakeForm initial={intake ?? undefined} initialSectorId={sectorId} submitting={starting} onDraft={startDraft} onSkip={skip} />}

      {step === 1 && (
        <div className="space-y-4">
          {!tree && !TREE_FALLBACK_STATUSES.has(partStatus("tree")) && <p className="text-sm text-muted-foreground">Waiting for the domain draft…</p>}
          {!tree && TREE_FALLBACK_STATUSES.has(partStatus("tree")) && (
            <div className="flex flex-wrap items-center gap-2">
              {treeRetry.busy
                ? <BusyCountdown state={treeRetry} retryLabel="Retry domains" testId="tree-busy-countdown" />
                : <Button variant="outline" onClick={() => retry("tree")}>Retry domains</Button>}
              {/* Dropping the draft id makes the section cards behave as on the skip path (no draft errors/Retry). */}
              <Button variant="outline" onClick={() => { setDraftId(null); setTree(emptyTree()); setSections({}); }}>Start blank</Button>
              <Button variant="outline" onClick={() => { setDraftId(null); setInitialDescription(undefined); void loadExample(); }}>Start from the Ridgeline example</Button>
            </div>
          )}
          {tree && (
            <>
              <OutlineEditor tree={tree} onChange={setTree} issues={cardIssues} />
              <MastersRelationshipsEditor tree={tree} onChange={setTree} />
              <div className="flex flex-wrap items-center gap-4 text-sm">
                <label className="flex items-center gap-1"><input type="radio" checked={strictness === "strict"} onChange={() => setStrictness("strict")} /> Strict — exactly these domains</label>
                <label className="flex items-center gap-1"><input type="radio" checked={strictness === "guided"} onChange={() => setStrictness("guided")} /> Guided — suggest missing domains</label>
                <label className="flex items-center gap-1">Organization divisions
                  <select className="rounded border bg-background text-xs" value={tree.coverage} onChange={(e) => setTree({ ...tree, coverage: e.target.value as TaxonomyTree["coverage"] })}>
                    {ORG_DIVISIONS_PRESETS.map((p) => <option key={p}>{p}</option>)}
                  </select>
                </label>
                <DivisionsInput value={tree.division_names ?? []} onChange={(division_names) => setTree({ ...tree, division_names })} />
              </div>
              <CompileIssues
                problems={inlineClean?.problems ?? []}
                issues={inlineBlocked ? [] : inline.data?.issues ?? []}
                error={inline.error ? apiErrorMessage(inline.error, "Couldn't check the taxonomy") : null}
              />
              <div className="flex gap-2">
                <Button variant="outline" onClick={() => setStep(0)}>Back</Button>
                <Button onClick={() => setStep(2)} disabled={tree.domains.length === 0}>Continue</Button>
              </div>
            </>
          )}
          {!tree && <Button variant="outline" onClick={() => setStep(0)}>Back</Button>}
        </div>
      )}

      {step === 2 && (
        <div className="space-y-3">
          {SECTION_PARTS.map((k) => (
            <SectionCard key={k} sectionKey={k} section={sections[k]} partStatus={partStatus(k)} partError={draft?.parts[k]?.error}
              exampleText={example?.sections[k]?.claims.map((c) => c.text).join(" ") ?? ""}
              onChange={(s) => setSections((p) => ({ ...p, [k]: s }))} onRetry={() => retry(k)}
              onCancel={cancel} waitingForTree={partStatus("tree") === "busy"} draftId={draftId} />
          ))}
          <label className="flex items-center gap-2 text-sm">
            <input type="checkbox" checked={sorConfirmed} onChange={(e) => setSorConfirmed(e.target.checked)} />
            I've checked the systems of record — they're right for us.
          </label>
          <div className="flex gap-2">
            <Button variant="outline" onClick={() => setStep(1)}>Back</Button>
            <Button onClick={() => setStep(3)} disabled={!sorConfirmed}>Continue</Button>
          </div>
        </div>
      )}

      {step === 3 && intake && tree && (
        <div className="space-y-4">
          <ReviewStep intake={intake} sectorId={sectorId} tree={tree} strictness={strictness} sections={sections} initialDescription={initialDescription} />
          <Button variant="outline" onClick={() => setStep(2)}>Back</Button>
        </div>
      )}
    </div>
  );
}
