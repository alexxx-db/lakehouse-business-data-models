import { useEffect, useState } from "react";
import { Skeleton } from "@/components/ui/skeleton";
import { MarkdownView } from "@/components/ui/markdown-view";
import { useGetAssessmentDocContent, useListAssessmentDocs, type DocEntry, type DocsOut } from "@/lib/api";
import { selector } from "@/lib/selector";
import { cn } from "@/lib/utils";

const SUMMARY_DOC = "domain_readiness_summary.md";

/** Resolve a relative .md link against the current doc's folder; null for external or non-markdown links. */
export function resolveDocLink(current: string, href: string): string | null {
  if (/^[a-z][a-z0-9+.-]*:/i.test(href) || href.startsWith("/") || href.startsWith("#")) return null;
  const file = href.split("#")[0].split("?")[0];
  if (!file.toLowerCase().endsWith(".md")) return null;
  const parts = current.split("/").slice(0, -1);
  for (const seg of file.split("/")) {
    if (seg === "" || seg === ".") continue;
    if (seg === "..") parts.pop();
    else parts.push(seg);
  }
  return parts.join("/");
}

/** One run document, rendered in-app: markdown via MarkdownView, anything else in a scrollable <pre>. */
export function DocViewer({
  domainRunId,
  path,
  onNavigate,
}: {
  domainRunId: string;
  path: string;
  onNavigate?: (path: string) => void;
}) {
  const { data, isLoading, isError } = useGetAssessmentDocContent({
    params: { domain_run_id: domainRunId, path },
    query: { retry: false },
  });
  if (isLoading) return <Skeleton className="h-24 w-full" />;
  if (isError || !data?.data) return <p className="text-sm text-muted-foreground">This document could not be loaded.</p>;
  const { content, truncated } = data.data;
  return (
    <div className="space-y-2">
      {truncated && (
        <p className="text-xs text-amber-700">This document is truncated; use Browse folder to see the full file.</p>
      )}
      <div className="max-h-[70vh] overflow-auto rounded-md border p-3">
        {path.toLowerCase().endsWith(".md") ? (
          <MarkdownView
            content={content}
            onLinkClick={(href) => {
              const target = resolveDocLink(path, href);
              if (!target || !onNavigate) return false;
              onNavigate(target);
              return true;
            }}
          />
        ) : (
          <pre className="text-[11px] leading-snug whitespace-pre">{content}</pre>
        )}
      </div>
    </div>
  );
}

function DocButton({ doc, active, onSelect }: { doc: DocEntry; active: boolean; onSelect: () => void }) {
  return (
    <li>
      <button
        type="button"
        onClick={onSelect}
        className={cn("w-full rounded px-2 py-1 text-left text-sm hover:bg-muted", active && "bg-muted font-medium")}
      >
        {doc.name}
      </button>
    </li>
  );
}

/** Docs tab body: grouped doc list (Design / Other / collapsed skill-author feedback) beside the viewer. */
export function DocsPane({ domainRunId }: { domainRunId: string }) {
  const { data, isLoading } = useListAssessmentDocs({
    params: { domain_run_id: domainRunId },
    ...selector<DocsOut>(),
  });
  const [picked, setPicked] = useState<string | null>(null);
  useEffect(() => setPicked(null), [domainRunId]);
  if (isLoading) return <Skeleton className="h-16 w-full" />;
  if (!data || data.docs.length === 0) return <p className="text-sm text-muted-foreground">No docs were produced.</p>;
  const selected = picked ?? (data.docs.find((d) => d.name === SUMMARY_DOC) ?? data.docs[0]).path;
  const group = (cat: DocEntry["category"]) => data.docs.filter((d) => d.category === cat);
  const section = (title: string, docs: DocEntry[]) =>
    docs.length > 0 && (
      <div>
        <h4 className="px-2 text-xs font-semibold uppercase text-muted-foreground">{title}</h4>
        <ul>
          {docs.map((d) => (
            <DocButton key={d.path} doc={d} active={d.path === selected} onSelect={() => setPicked(d.path)} />
          ))}
        </ul>
      </div>
    );
  const commentary = group("commentary");
  const commentarySelected = commentary.some((d) => d.path === selected);
  return (
    <div className="grid gap-4 md:grid-cols-[16rem_1fr]">
      <div className="space-y-3">
        {section("Design", group("design"))}
        {section("Other", group("other"))}
        {commentary.length > 0 && (
          <details open={commentarySelected || undefined}>
            <summary className="cursor-pointer px-2 text-xs font-semibold uppercase text-muted-foreground">
              Feedback for the skill authors
            </summary>
            <ul>
              {commentary.map((d) => (
                <DocButton key={d.path} doc={d} active={d.path === selected} onSelect={() => setPicked(d.path)} />
              ))}
            </ul>
          </details>
        )}
        {data.folder_url && (
          <a href={data.folder_url} target="_blank" rel="noreferrer" className="block px-2 text-sm text-primary hover:underline">
            Browse folder
          </a>
        )}
      </div>
      <DocViewer
        domainRunId={domainRunId}
        path={selected}
        onNavigate={(p) => data.docs.some((d) => d.path === p) && setPicked(p)}
      />
    </div>
  );
}
