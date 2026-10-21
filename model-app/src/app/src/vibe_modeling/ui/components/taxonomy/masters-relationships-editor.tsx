import { useState } from "react";
import { X } from "lucide-react";
import type { TaxonomyTree } from "@/lib/api";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { domainSchema, snake } from "@/lib/taxonomy/tree";

type Props = { tree: TaxonomyTree; onChange: (t: TaxonomyTree) => void };

export function MastersRelationshipsEditor({ tree, onChange }: Props) {
  const [entity, setEntity] = useState("");
  const [home, setHome] = useState("");
  const [rel, setRel] = useState("");
  const [masterErr, setMasterErr] = useState("");
  const [relErr, setRelErr] = useState("");
  const masters = tree.shared_masters ?? [];
  const rels = tree.relationships ?? [];
  const schemas = tree.domains.map(domainSchema).filter((x) => x.trim());

  const addMaster = () => {
    const e = snake(entity);
    if (!e) { setMasterErr("Enter an entity name."); return; }
    const existing = masters.find((m) => m.entity === e);
    if (existing) { setMasterErr(`${e} is already homed in ${existing.home_domain}.`); return; }
    if (!home) { setMasterErr("Pick a home domain."); return; }
    onChange({ ...tree, shared_masters: [...masters, { entity: e, home_domain: home }] });
    setEntity("");
    setMasterErr("");
  };
  // "source -> a + b" ; free text targets allowed (e.g. "asset (grid or gas)")
  const addRel = () => {
    const parts = rel.split("->");
    if (parts.length > 2) { setRelErr("Use one arrow (->), with targets separated by +."); return; }
    if (parts.length < 2) { setRelErr("Write it as source -> target (use + for several targets)."); return; }
    const src = snake(parts[0].trim());
    const targets = parts[1].split("+").map((x) => x.trim()).filter(Boolean);
    if (!src) { setRelErr("The source needs a name."); return; }
    if (targets.length === 0) { setRelErr("Add at least one target after the arrow."); return; }
    onChange({ ...tree, relationships: [...rels, { source: src, targets }] });
    setRel("");
    setRelErr("");
  };
  const enter = (fn: () => void) => (e: React.KeyboardEvent) => { if (e.key === "Enter") { e.preventDefault(); fn(); } };

  return (
    <div className="grid gap-4 md:grid-cols-2">
      <section className="space-y-2">
        <h3 className="text-sm font-medium">Shared masters <span className="text-xs text-muted-foreground">(one home each)</span></h3>
        <p className="text-xs text-muted-foreground">
          Core things many domains use — customer, product, plant, supplier. Each is modeled once, in its home domain;
          every other domain links to it instead of keeping its own copy. Add any entity two or more domains would
          otherwise both create.
        </p>
        {masters.map((m, i) => (
          <div key={i} className="flex items-center gap-2 text-xs">
            <span className="font-mono">{m.entity}</span><span>→</span><span className="font-mono">{m.home_domain}</span>
            <button type="button" aria-label={`Remove shared master ${m.entity}`}
              onClick={() => onChange({ ...tree, shared_masters: masters.filter((_, j) => j !== i) })}><X className="h-3 w-3" /></button>
          </div>
        ))}
        <div className="flex gap-1">
          <Input className="h-7 text-xs" placeholder="entity (e.g. customer_account)" value={entity}
            onChange={(e) => { setEntity(e.target.value); setMasterErr(""); }} onKeyDown={enter(addMaster)} />
          <select className="h-7 rounded border bg-background text-xs" aria-label="Shared master home domain" value={home}
            onChange={(e) => { setHome(e.target.value); setMasterErr(""); }}>
            <option value="">home domain…</option>
            {schemas.map((s, i) => <option key={i} value={s}>{s}</option>)}
          </select>
          <Button type="button" size="sm" variant="outline" className="h-7" aria-label="Add shared master" disabled={!home} onClick={addMaster}>Add</Button>
        </div>
        {!home && entity.trim() && <p className="text-xs text-muted-foreground">Pick a home domain</p>}
        {masterErr && <p role="alert" className="text-xs text-destructive">{masterErr}</p>}
      </section>
      <section className="space-y-2">
        <h3 className="text-sm font-medium">Key relationships</h3>
        <p className="text-xs text-muted-foreground">
          Links the model must get right. <span className="font-mono">production_order → plant + bill_of_materials</span> means
          every production order points to a plant and a bill of materials. Add the connections your business depends on,
          especially ones that cross domains.
        </p>
        {rels.map((r, i) => (
          <div key={i} className="flex items-center gap-2 font-mono text-xs">
            {r.source} → {r.targets.join(" + ")}
            <button type="button" aria-label={`Remove relationship ${r.source}`}
              onClick={() => onChange({ ...tree, relationships: rels.filter((_, j) => j !== i) })}><X className="h-3 w-3" /></button>
          </div>
        ))}
        <div className="flex gap-1">
          <Input className="h-7 font-mono text-xs" placeholder="bill -> service_agreement" value={rel}
            onChange={(e) => { setRel(e.target.value); setRelErr(""); }} onKeyDown={enter(addRel)} />
          <Button type="button" size="sm" variant="outline" className="h-7" aria-label="Add relationship" onClick={addRel}>Add</Button>
        </div>
        {relErr && <p role="alert" className="text-xs text-destructive">{relErr}</p>}
      </section>
    </div>
  );
}
