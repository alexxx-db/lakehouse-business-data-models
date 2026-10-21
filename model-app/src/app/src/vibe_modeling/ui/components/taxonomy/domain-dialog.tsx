import { ArrowDown, ArrowUp, ChevronLeft, ChevronRight, Trash2 } from "lucide-react";
import type { TaxonomyIssue, TaxonomyTree } from "@/lib/api";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { domainSchema, moveDomain, removeDomain, renameDomain, setDomainSchema } from "@/lib/taxonomy/tree";
import { DomainCard, domainProblems, domainWarnings } from "./domain-card";
import { DomainEditor, nm } from "./domain-editor";

type Props = {
  tree: TaxonomyTree;
  /** Index of the domain being edited, or null when closed. */
  index: number | null;
  onIndexChange: (i: number | null) => void;
  onChange: (t: TaxonomyTree) => void;
  /** Server compile issues for exactly this tree. */
  issues?: TaxonomyIssue[];
};

export function DomainDialog({ tree, index, onIndexChange, onChange, issues = [] }: Props) {
  const d = index === null ? undefined : tree.domains[index];
  const open = index !== null && !!d;
  const i = index ?? 0;
  const problems = open ? domainProblems(tree, i, issues) : [];
  const warnings = open ? domainWarnings(issues, i) : [];
  return (
    <Dialog open={open} onOpenChange={(o) => { if (!o) onIndexChange(null); }}>
      {open && d && (
        <DialogContent className="max-w-5xl max-h-[90vh] overflow-y-auto" data-testid="domain-dialog">
          <DialogHeader>
            <DialogTitle>Edit domain: {nm(d.name)}</DialogTitle>
            <DialogDescription>Rename it, reshape its sub-domains and categories, or move things to other domains.</DialogDescription>
          </DialogHeader>
          <div className="flex items-start gap-1 pr-6">
            <Input className="h-8 font-medium" value={d.name} aria-label="Domain name"
              onChange={(e) => onChange(renameDomain(tree, i, e.target.value))} />
            <div className="w-44 shrink-0">
              <Input className="h-8 font-mono text-xs" value={d.schema_name ?? ""} placeholder={domainSchema(d)}
                aria-label="Domain schema name" aria-describedby="schema-hint" onChange={(e) => onChange(setDomainSchema(tree, i, e.target.value))} />
              <div id="schema-hint" className="mt-0.5 text-[10px] text-muted-foreground">one lowercase word, ≤20 chars</div>
            </div>
            <Button type="button" size="icon" variant="ghost" aria-label={`Move domain ${nm(d.name)} up`} disabled={i === 0}
              onClick={() => { onChange(moveDomain(tree, i, i - 1)); onIndexChange(i - 1); }}><ArrowUp className="h-3 w-3" /></Button>
            <Button type="button" size="icon" variant="ghost" aria-label={`Move domain ${nm(d.name)} down`} disabled={i === tree.domains.length - 1}
              onClick={() => { onChange(moveDomain(tree, i, i + 1)); onIndexChange(i + 1); }}><ArrowDown className="h-3 w-3" /></Button>
            <Button type="button" size="icon" variant="ghost" aria-label={`Remove domain ${nm(d.name)}`}
              onClick={() => { onChange(removeDomain(tree, i)); onIndexChange(null); }}><Trash2 className="h-3 w-3" /></Button>
          </div>
          {problems.length > 0 && (
            <ul className="space-y-0.5 text-xs text-destructive" role="alert">
              {problems.map((p) => <li key={p}>{p}</li>)}
            </ul>
          )}
          {warnings.length > 0 && (
            <ul className="space-y-0.5 text-xs text-amber-700 dark:text-amber-400" data-testid="domain-warnings">
              {warnings.map((p) => <li key={p}>{p}</li>)}
            </ul>
          )}
          <div className="grid gap-4 md:grid-cols-[3fr_2fr]">
            <DomainEditor tree={tree} index={i} onChange={onChange} />
            <div>
              <div className="mb-1 text-xs font-medium text-muted-foreground">Preview</div>
              <DomainCard domain={d} index={i} hasError={problems.length > 0} hasWarning={warnings.length > 0} />
            </div>
          </div>
          <DialogFooter className="items-center gap-2 sm:justify-between sm:space-x-0">
            <div className="flex gap-2">
              <Button type="button" variant="outline" size="sm" aria-label="Previous domain" disabled={i === 0}
                onClick={() => onIndexChange(i - 1)}><ChevronLeft className="h-3 w-3" /> Prev</Button>
              <Button type="button" variant="outline" size="sm" aria-label="Next domain" disabled={i === tree.domains.length - 1}
                onClick={() => onIndexChange(i + 1)}>Next <ChevronRight className="h-3 w-3" /></Button>
            </div>
            <Button type="button" onClick={() => onIndexChange(null)}>Done</Button>
          </DialogFooter>
        </DialogContent>
      )}
    </Dialog>
  );
}
