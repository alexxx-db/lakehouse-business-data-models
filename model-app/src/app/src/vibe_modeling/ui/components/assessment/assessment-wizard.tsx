import { Suspense, useCallback, useEffect, useMemo, useRef, useState } from "react";
import { ASSESS_MODEL } from "@/lib/assessment";
import { Link, useNavigate } from "@tanstack/react-router";
import { AlertTriangle, Loader2, Rocket } from "lucide-react";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Checkbox } from "@/components/ui/checkbox";
import { Skeleton } from "@/components/ui/skeleton";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  checkAssessReadiness,
  launchAssessment,
  putAssessSourceMap,
  useGetAssessConfig,
  useGetAssessSourceMapSuspense,
  useGetModelSummarySuspense,
  useListVersionsSuspense,
  type AssessBatchIn,
  type AssessConfigOut,
  type ReadinessOut,
  type SourceIn,
  type SourceMapOut,
} from "@/lib/api";
import { apiErrorMessage, parseAdminHelp, type AdminHelp } from "@/lib/api-error";
import { notifyError } from "@/lib/notify";
import { selector } from "@/lib/selector";
import { AdminHelpBlock } from "@/components/assessment/admin-help-block";
import { parseBlocked } from "@/components/assessment/use-relaunch";
import { ReadinessPanel } from "@/components/assessment/readiness-panel";
import { SourceMapEditor, isValidSource } from "@/components/assessment/source-map-editor";

const DEBOUNCE_MS = 600;

const OUTPUT_MODELS = ["normalized", "dimensional", "hybrid"] as const;
const ETL_TYPES = [
  { value: "sdp_pipeline", label: "SDP pipeline" },
  { value: "notebook", label: "Notebook" },
] as const;
const EFFORTS = ["low", "medium", "high"] as const;

type OutputModel = (typeof OUTPUT_MODELS)[number];
type EtlType = (typeof ETL_TYPES)[number]["value"];
type Effort = (typeof EFFORTS)[number];

type ReadinessState =
  | { status: "idle" }
  | { status: "loading" }
  | { status: "error"; message: string }
  | { status: "done"; data: ReadinessOut };

/** Union of rows across domains, deduped by source_name (last wins). */
function unionSources(lists: SourceIn[][]): SourceIn[] {
  const byName = new Map<string, SourceIn>();
  for (const row of lists.flat()) byName.set(row.source_name, row);
  return [...byName.values()];
}

/**
 * Launch wizard: pick an installed model version, the domains to assess and
 * their bronze source mappings, tune settings, check readiness, launch.
 * Three cards on one page (not a modal).
 */
type Settings = { outputModel: OutputModel; etlType: EtlType; effort: Effort };

const BLANK_ROW: SourceIn = { source_name: "", catalog_name: "", schema_name: "" };
const isBlank = (r: SourceIn) => !r.source_name && !r.catalog_name && !r.schema_name;

/** Why a domain's source rows can't be sent yet (null when they can). */
function domainIssue(rows: SourceIn[], name: string): string | null {
  if (rows.some((r) => !isBlank(r) && !isValidSource(r))) {
    return `Complete or remove the incomplete source rows for ${name}`;
  }
  if (!rows.some(isValidSource)) return `Add at least one complete source for ${name}`;
  return null;
}

function SettingsCard({
  settings,
  onChange,
}: {
  settings: Settings;
  onChange: (patch: Partial<Settings>) => void;
}) {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">3. Settings</CardTitle>
        <CardDescription>
          Typically 30–60 min per domain; rate limits can extend this. Runs share this workspace's
          rate limit for {ASSESS_MODEL}; to run faster, ask your Databricks account team for a
          higher limit.
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="grid gap-4 sm:grid-cols-3">
          <div className="space-y-1">
            <label className="text-sm font-medium">Output model</label>
            <Select value={settings.outputModel} onValueChange={(v) => onChange({ outputModel: v as OutputModel })}>
              <SelectTrigger aria-label="Output model">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                {OUTPUT_MODELS.map((o) => (
                  <SelectItem key={o} value={o}>
                    {o}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
          <div className="space-y-1">
            <label className="text-sm font-medium">ETL type</label>
            <Select value={settings.etlType} onValueChange={(v) => onChange({ etlType: v as EtlType })}>
              <SelectTrigger aria-label="ETL type">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                {ETL_TYPES.map((o) => (
                  <SelectItem key={o.value} value={o.value}>
                    {o.label}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
          <div className="space-y-1">
            <label className="text-sm font-medium">Reasoning effort</label>
            <Select value={settings.effort} onValueChange={(v) => onChange({ effort: v as Effort })}>
              <SelectTrigger aria-label="Reasoning effort">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                {EFFORTS.map((o) => (
                  <SelectItem key={o} value={o}>
                    {o}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
        </div>
        {settings.outputModel === "hybrid" && (
          <p className="text-xs text-muted-foreground">hybrid = normalized silver plus a derived gold star</p>
        )}
      </CardContent>
    </Card>
  );
}

type EligibleVersion = { id: string; version: number; scope?: string; uc_catalog: string };

/**
 * Everything that depends on the chosen version's domain list. The wizard
 * remounts it (key = version id) on a version change, which drops selections
 * that belong to the previous version.
 */
function WizardBody({
  businessId,
  version,
  initialDomainId,
  savedSources,
  settings,
  onSettings,
}: {
  businessId: string;
  version: EligibleVersion;
  initialDomainId?: string;
  savedSources: SourceIn[];
  settings: Settings;
  onSettings: (patch: Partial<Settings>) => void;
}) {
  const navigate = useNavigate();
  const { data: model } = useGetModelSummarySuspense({
    params: { business_id: businessId, version_int: version.version, scope: version.scope ?? "" },
    ...selector(),
  });
  const domains = useMemo(
    () => (model.domains ?? []).filter((d) => d.id && d.change_status !== "deleted"),
    [model],
  );
  const seedRows = () => (savedSources.length ? savedSources.map((s) => ({ ...s })) : [{ ...BLANK_ROW }]);

  // Only pre-select a domain that really belongs to this version.
  const [rowsByDomain, setRowsByDomain] = useState<Record<string, SourceIn[]>>(() =>
    initialDomainId && domains.some((d) => d.id === initialDomainId) ? { [initialDomainId]: seedRows() } : {},
  );

  const [readiness, setReadiness] = useState<ReadinessState>({ status: "idle" });
  // The last result stays on screen (dimmed) while a new check runs.
  const [shownReadiness, setShownReadiness] = useState<ReadinessOut | null>(null);
  // A request is on the wire (not just the debounce pending): Check readiness is disabled with a spinner.
  const [inFlight, setInFlight] = useState(false);
  const [blockedMessage, setBlockedMessage] = useState<string | null>(null);
  const [launchHelp, setLaunchHelp] = useState<AdminHelp | null>(null);
  const [launching, setLaunching] = useState(false);

  const selectedDomainIds = useMemo(() => Object.keys(rowsByDomain), [rowsByDomain]);
  const issues = useMemo(() => {
    const out: Record<string, string | null> = {};
    for (const id of selectedDomainIds) {
      const name = domains.find((d) => d.id === id)?.name ?? id;
      out[id] = domainIssue(rowsByDomain[id], name);
    }
    return out;
  }, [selectedDomainIds, rowsByDomain, domains]);
  const hasIssue = Object.values(issues).some(Boolean);

  // Only complete, pattern-valid rows go to the backend (issues block the check).
  const readinessBody = useMemo(
    () => ({
      version_id: version.id,
      domains: selectedDomainIds.map((id) => ({
        domain_id: id,
        sources: rowsByDomain[id].filter(isValidSource),
      })),
    }),
    [version.id, selectedDomainIds, rowsByDomain],
  );
  const bodyKey = JSON.stringify(readinessBody);
  const canCheck = selectedDomainIds.length > 0 && !hasIssue;

  const seq = useRef(0);
  const timer = useRef<ReturnType<typeof setTimeout> | null>(null);
  const clearTimer = () => {
    if (timer.current) clearTimeout(timer.current);
    timer.current = null;
  };

  const runCheck = useCallback(async (body: typeof readinessBody) => {
    const mine = ++seq.current;
    setReadiness({ status: "loading" });
    setInFlight(true);
    try {
      const r = await checkAssessReadiness(body);
      if (mine === seq.current) {
        setReadiness({ status: "done", data: r.data });
        setShownReadiness(r.data);
      }
    } catch (err) {
      if (mine === seq.current) {
        setReadiness({ status: "error", message: apiErrorMessage(err, "Readiness check failed") });
      }
    } finally {
      if (mine === seq.current) setInFlight(false);
    }
  }, []);

  // Auto re-check (debounced) whenever the domains / sources change.
  // Launch stays disabled from the moment inputs change until the check lands.
  const latestBody = useRef(readinessBody);
  latestBody.current = readinessBody;
  useEffect(() => {
    clearTimer();
    seq.current++;
    setInFlight(false);
    setBlockedMessage(null);
    setLaunchHelp(null);
    if (!canCheck) {
      setReadiness({ status: "idle" });
      setShownReadiness(null);
      return;
    }
    setReadiness({ status: "loading" });
    timer.current = setTimeout(() => {
      timer.current = null;
      void runCheck(latestBody.current);
    }, DEBOUNCE_MS);
    return clearTimer;
  }, [bodyKey, canCheck, runCheck]);

  const checkNow = () => {
    if (!canCheck) return;
    clearTimer();
    setBlockedMessage(null);
    setLaunchHelp(null);
    void runCheck(readinessBody);
  };

  const toggleDomain = (id: string, checked: boolean) =>
    setRowsByDomain((prev) => {
      const next = { ...prev };
      if (checked) next[id] = seedRows();
      else delete next[id];
      return next;
    });

  const readinessData = readiness.status === "done" ? readiness.data : null;
  const checking = readiness.status === "loading";
  const anyBlocked = readinessData?.domains.some((d) => d.blocked) ?? false;
  const launchDisabled = !canCheck || readiness.status !== "done" || anyBlocked || launching;

  const launch = async () => {
    setLaunching(true);
    setBlockedMessage(null);
    setLaunchHelp(null);
    try {
      const sources = unionSources(readinessBody.domains.map((d) => d.sources));
      try {
        await putAssessSourceMap({ business_id: businessId }, { sources });
      } catch (err) {
        notifyError(err, { fallback: "Couldn't save the source map" });
        return;
      }
      const body: AssessBatchIn = {
        ...readinessBody,
        output_model: settings.outputModel,
        etl_type: settings.etlType,
        reasoning_effort: settings.effort,
      };
      try {
        const r = await launchAssessment({ business_id: businessId }, body);
        navigate({
          to: "/businesses/$businessId/assessments/$batchId",
          params: { businessId, batchId: r.data.id },
        });
      } catch (err) {
        const blocked = parseBlocked(err);
        const help = blocked ? null : parseAdminHelp(err);
        if (blocked) {
          seq.current++;
          setReadiness({ status: "done", data: blocked.readiness });
          setShownReadiness(blocked.readiness);
          setBlockedMessage(blocked.message);
        } else if (help) {
          setLaunchHelp(help);
        } else {
          notifyError(err, { fallback: "Couldn't launch the assessment" });
        }
      }
    } finally {
      setLaunching(false);
    }
  };

  return (
    <>
      <Card>
        <CardHeader>
          <CardTitle className="text-base">2. Domains and sources</CardTitle>
          <CardDescription>
            Map each bronze source to the catalog and schema holding it. The source map is shared across the
            business and saved when you launch.
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          {domains.length === 0 ? (
            <p className="text-sm text-muted-foreground">This version has no domains.</p>
          ) : (
            <ul className="space-y-2">
              {domains.map((d) => (
                <li key={d.id} className="flex items-center gap-2 text-sm">
                  <Checkbox
                    id={`assess-domain-${d.id}`}
                    aria-label={d.name}
                    checked={d.id! in rowsByDomain}
                    onCheckedChange={(c) => toggleDomain(d.id as string, c === true)}
                  />
                  <label htmlFor={`assess-domain-${d.id}`}>{d.name}</label>
                </li>
              ))}
            </ul>
          )}
          {selectedDomainIds.map((id) => (
            <section key={id} className="space-y-2">
              <h4 className="text-sm font-semibold">{domains.find((d) => d.id === id)?.name ?? id}</h4>
              <SourceMapEditor
                value={rowsByDomain[id]}
                onChange={(rows) => setRowsByDomain((prev) => ({ ...prev, [id]: rows }))}
              />
              {issues[id] && (
                <p className="text-xs text-destructive" data-testid={`source-issue-${id}`}>
                  {issues[id]}
                </p>
              )}
            </section>
          ))}
        </CardContent>
      </Card>

      <SettingsCard settings={settings} onChange={onSettings} />

      {blockedMessage && (
        <Alert variant="destructive">
          <AlertTriangle className="h-4 w-4" />
          <AlertDescription>{blockedMessage}</AlertDescription>
        </Alert>
      )}
      {readiness.status === "error" && (
        <Alert variant="destructive">
          <AlertTriangle className="h-4 w-4" />
          <AlertDescription>{readiness.message}</AlertDescription>
        </Alert>
      )}
      {launchHelp && <AdminHelpBlock help={launchHelp} testId="launch-admin-help" live />}
      {shownReadiness && readiness.status !== "error" && (
        <ReadinessPanel readiness={shownReadiness} checking={checking} />
      )}

      <div className="flex items-center gap-2">
        <Button type="button" variant="outline" disabled={!canCheck || inFlight} onClick={checkNow}>
          {inFlight && <Loader2 className="mr-1.5 h-4 w-4 animate-spin" aria-hidden />}
          Check readiness
        </Button>
        <Button type="button" disabled={launchDisabled} onClick={() => void launch()}>
          <Rocket className="mr-1.5 h-4 w-4" />
          Launch assessment
        </Button>
      </div>
    </>
  );
}

/**
 * Launch wizard: pick an installed model version, the domains to assess and
 * their bronze source mappings, tune settings, check readiness, launch.
 * Three cards on one page (not a modal).
 */
export function AssessmentWizard({
  businessId,
  versionId,
  domainId,
}: {
  businessId: string;
  versionId?: string;
  domainId?: string;
}) {
  const { data: versions } = useListVersionsSuspense({
    params: { business_id: businessId },
    ...selector(),
  });
  const { data: savedMap } = useGetAssessSourceMapSuspense({
    params: { business_id: businessId },
    ...selector<SourceMapOut>(),
  });
  const { data: config } = useGetAssessConfig(selector<AssessConfigOut>());

  const eligible = useMemo(
    () => versions.filter((v) => v.deployment_status === "deployed" && !!v.uc_catalog),
    [versions],
  );

  // The domain param only means something for the version it came with.
  const paramVersion = eligible.find((v) => v.id === versionId);
  const [selectedVersionId, setSelectedVersionId] = useState(paramVersion?.id ?? eligible[0]?.id ?? "");
  const [partial, setPartial] = useState<Partial<Settings>>({});
  const settings: Settings = {
    outputModel: "hybrid",
    etlType: "sdp_pipeline",
    effort: (config?.default_reasoning_effort as Effort | undefined) ?? "high",
    ...partial,
  };
  const version = eligible.find((v) => v.id === selectedVersionId);
  const initialDomainId = paramVersion && paramVersion.id === selectedVersionId ? domainId : undefined;

  return (
    <div className="space-y-4 max-w-3xl">
      <div
        data-testid="assess-intro"
        className="space-y-1 rounded-md border bg-muted/30 p-3 text-sm text-muted-foreground"
      >
        <p>
          Check an installed model against your bronze sources. For each domain you select, Genie
          Code runs headless in a Databricks job, profiles your data, maps every target column to a
          source column, grades each entity Full, Partial or Blocked, and lists the gaps and
          decisions for you.
        </p>
        <p>
          It is read-only: it runs as the reader service principal and only reads your data. Expect
          30-60 minutes per domain.{" "}
          <Link
            to="/help/$topic"
            params={{ topic: "assessment" }}
            className="text-primary hover:underline"
          >
            How assessments work →
          </Link>
        </p>
      </div>
      <Card>
        <CardHeader>
          <CardTitle className="text-base">1. Model</CardTitle>
          <CardDescription>Only versions installed into a catalog can be assessed.</CardDescription>
        </CardHeader>
        <CardContent className="space-y-2">
          {eligible.length === 0 ? (
            <p className="text-sm text-muted-foreground">
              No installed versions. Install a version into a catalog first.
            </p>
          ) : (
            <div className="flex items-center gap-3">
              <Select value={selectedVersionId} onValueChange={setSelectedVersionId}>
                <SelectTrigger aria-label="Model version" className="w-56">
                  <SelectValue placeholder="Pick a version" />
                </SelectTrigger>
                <SelectContent>
                  {eligible.map((v) => (
                    <SelectItem key={v.id} value={v.id}>
                      {`v${v.version}${v.scope ? ` ${v.scope.toUpperCase()}` : ""}`}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              {version && (
                <span className="font-mono text-xs text-muted-foreground">{version.uc_catalog}</span>
              )}
            </div>
          )}
        </CardContent>
      </Card>

      {version ? (
        <Suspense fallback={<Skeleton className="h-48 w-full" />}>
          <WizardBody
            key={version.id}
            businessId={businessId}
            version={version}
            initialDomainId={initialDomainId}
            savedSources={savedMap?.sources ?? []}
            settings={settings}
            onSettings={(patch) => setPartial((p) => ({ ...p, ...patch }))}
          />
        </Suspense>
      ) : (
        <p className="text-sm text-muted-foreground">Pick a model version first.</p>
      )}
    </div>
  );
}
