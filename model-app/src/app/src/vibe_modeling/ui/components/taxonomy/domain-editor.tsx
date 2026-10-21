import { useState } from "react";
import { Plus, X } from "lucide-react";
import type { TaxonomyTree } from "@/lib/api";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  addCategory, addSubdomain, moveCategory, moveSubdomain,
  removeCategory, removeSubdomain, renameCategory, renameSubdomain,
} from "@/lib/taxonomy/tree";

export const nm = (s: string) => s.trim() || "(unnamed)";

export type Props = { tree: TaxonomyTree; onChange: (t: TaxonomyTree) => void };

export function AddRow({ placeholder, label, onAdd }: { placeholder: string; label: string; onAdd: (v: string) => void }) {
  const [v, setV] = useState("");
  const submit = () => { if (v.trim()) { onAdd(v); setV(""); } };
  return (
    <div className="flex gap-1">
      <Input className="h-7 text-xs" placeholder={placeholder} value={v} onChange={(e) => setV(e.target.value)}
        onKeyDown={(e) => { if (e.key === "Enter") { e.preventDefault(); submit(); } }} />
      <Button type="button" size="sm" variant="outline" className="h-7" aria-label={label} onClick={submit}>
        <Plus className="h-3 w-3" />
      </Button>
    </div>
  );
}

/** Edit list for ONE domain: its sub-domains (rename / move / delete) and categories (rename / move / delete / add). */
export function DomainEditor({ tree, index: di, onChange }: Props & { index: number }) {
  const domains = tree.domains;
  const d = domains[di];
  return (
    <div className="space-y-2" data-testid="taxonomy-outline-editor">
      <div className="space-y-2">
        {(d.subdomains ?? []).map((s, si) => (
          <div key={si} className="space-y-1">
            <div className="flex items-center gap-1">
              <Input className="h-7 text-sm" value={s.name} aria-label={`Sub-domain ${nm(s.name)}`}
                onChange={(e) => onChange(renameSubdomain(tree, di, si, e.target.value))} />
              <select className="h-7 rounded border bg-background text-xs" aria-label={`Move sub-domain ${nm(s.name)} to domain`}
                value={di} onChange={(e) => onChange(moveSubdomain(tree, di, si, Number(e.target.value)))}>
                {domains.map((od, oi) => <option key={oi} value={oi}>{nm(od.name)}</option>)}
              </select>
              <Button type="button" size="icon" variant="ghost" aria-label={`Remove sub-domain ${nm(s.name)}`}
                onClick={() => onChange(removeSubdomain(tree, di, si))}><X className="h-3 w-3" /></Button>
            </div>
            <div className="ml-4 flex flex-wrap gap-1">
              {(s.categories ?? []).map((c, ci) => (
                <span key={ci} className="flex items-center gap-0.5 rounded border px-1">
                  <input className="w-32 bg-transparent text-xs outline-none" value={c} aria-label={`Category ${ci + 1} in ${nm(s.name)}`}
                    onChange={(e) => onChange(renameCategory(tree, di, si, ci, e.target.value))} />
                  <select className="bg-transparent text-[10px]" aria-label={`Move category ${ci + 1} in ${nm(s.name)}`} value=""
                    onChange={(e) => { const [td, ts] = e.target.value.split(":").map(Number); onChange(moveCategory(tree, di, si, ci, td, ts)); }}>
                    <option value="" disabled>↪</option>
                    {domains.flatMap((od, oi) => (od.subdomains ?? []).map((os, osi) => (oi === di && osi === si ? null : (
                      <option key={`${oi}:${osi}`} value={`${oi}:${osi}`}>{nm(od.name)} › {nm(os.name)}</option>
                    ))))}
                  </select>
                  <button type="button" aria-label={`Remove category ${ci + 1} in ${nm(s.name)}`} onClick={() => onChange(removeCategory(tree, di, si, ci))}>
                    <X className="h-3 w-3" />
                  </button>
                </span>
              ))}
              <div className="w-48"><AddRow placeholder="New category" label={`Add category to ${nm(s.name)}`} onAdd={(v) => onChange(addCategory(tree, di, si, v))} /></div>
            </div>
          </div>
        ))}
        <div className="w-64"><AddRow placeholder="New sub-domain" label={`Add sub-domain to ${nm(d.name)}`} onAdd={(v) => onChange(addSubdomain(tree, di, v))} /></div>
      </div>
    </div>
  );
}
