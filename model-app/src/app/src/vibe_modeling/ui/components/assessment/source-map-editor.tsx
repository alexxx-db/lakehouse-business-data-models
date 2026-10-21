import { useRef } from "react";
import { useQuery } from "@tanstack/react-query";
import { Plus, Trash2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { browseVolumes, listCatalogs, type SourceIn } from "@/lib/api";

const SOURCE_NAME_RE = /^[A-Za-z0-9_]+$/;

/** Mirrors the backend `SourceIn` catalog/schema pattern. */
export const CATALOG_SCHEMA_RE = /^[A-Za-z0-9_-]+$/;

/** True when a row is complete and passes every backend pattern. */
export function isValidSource(s: SourceIn): boolean {
  return (
    SOURCE_NAME_RE.test(s.source_name) &&
    CATALOG_SCHEMA_RE.test(s.catalog_name) &&
    CATALOG_SCHEMA_RE.test(s.schema_name)
  );
}

type CatalogOption = { name: string };

function Option({ value, options, placeholder, label, onChange }: {
  value: string;
  options: string[];
  placeholder: string;
  label: string;
  onChange: (v: string) => void;
}) {
  // Keep a saved value selectable even if the listing doesn't include it.
  const all = value && !options.includes(value) ? [value, ...options] : options;
  // Always controlled: "" shows the placeholder. Flipping to uncontrolled would
  // leave Radix displaying a stale internal value.
  return (
    <Select value={value} onValueChange={onChange}>
      <SelectTrigger aria-label={label} className="w-full">
        <SelectValue placeholder={placeholder} />
      </SelectTrigger>
      <SelectContent>
        {all.map((o) => (
          <SelectItem key={o} value={o}>
            {o}
          </SelectItem>
        ))}
      </SelectContent>
    </Select>
  );
}

function SchemaSelect({ catalog, value, onChange, schemasOverride }: {
  catalog: string;
  value: string;
  onChange: (v: string) => void;
  schemasOverride?: string[];
}) {
  const query = useQuery({
    queryKey: ["assess-schemas", catalog],
    queryFn: async () => {
      const r = await browseVolumes({ path: `/${catalog}` });
      return r.data.entries.filter((e) => e.kind === "schema").map((e) => e.name);
    },
    enabled: schemasOverride === undefined && Boolean(catalog),
    staleTime: 60_000,
    retry: false,
  });
  const options = schemasOverride ?? query.data ?? [];
  return (
    <Option
      value={value}
      options={options}
      label="Schema"
      placeholder={catalog ? "Pick a schema" : "Pick a catalog first"}
      onChange={onChange}
    />
  );
}

/**
 * Editable list of bronze source mappings (source name → catalog.schema).
 * `catalogsOverride` / `schemasOverride` skip the fetches (tests), mirroring
 * `DeploymentCatalogPicker`.
 */
export function SourceMapEditor({
  value,
  onChange,
  catalogsOverride,
  schemasOverride,
}: {
  value: SourceIn[];
  onChange: (v: SourceIn[]) => void;
  catalogsOverride?: CatalogOption[];
  schemasOverride?: string[];
}) {
  const catalogsQuery = useQuery({
    queryKey: ["catalogs"],
    queryFn: async () => (await listCatalogs()).data as CatalogOption[],
    staleTime: 60_000,
    retry: false,
    enabled: catalogsOverride === undefined,
  });
  const catalogs = (catalogsOverride ?? catalogsQuery.data ?? []).map((c) => c.name).sort();

  // Stable per-row keys, kept out of the SourceIn payload: index keys would
  // hand a removed row's Select state to its neighbour.
  const ids = useRef<string[]>([]);
  const nextId = useRef(0);
  while (ids.current.length < value.length) ids.current.push(`row-${nextId.current++}`);
  ids.current.length = value.length;

  const update = (i: number, patch: Partial<SourceIn>) =>
    onChange(value.map((row, idx) => (idx === i ? { ...row, ...patch } : row)));

  return (
    <div className="space-y-2" data-testid="source-map-editor">
      {value.map((row, i) => {
        const nameInvalid = row.source_name !== "" && !SOURCE_NAME_RE.test(row.source_name);
        return (
          <div key={ids.current[i]} className="grid grid-cols-[1fr_1fr_1fr_auto] items-start gap-2">
            <div className="space-y-1">
              <Input
                aria-label="Source name"
                placeholder="e.g. src_sap"
                value={row.source_name}
                aria-invalid={nameInvalid}
                onChange={(e) => update(i, { source_name: e.target.value })}
              />
              {nameInvalid && (
                <p className="text-xs text-destructive">Letters, digits and _ only</p>
              )}
            </div>
            <Option
              value={row.catalog_name}
              options={catalogs}
              label="Catalog"
              placeholder="Pick a catalog"
              onChange={(v) => update(i, { catalog_name: v, schema_name: "" })}
            />
            <SchemaSelect
              catalog={row.catalog_name}
              value={row.schema_name}
              schemasOverride={schemasOverride}
              onChange={(v) => update(i, { schema_name: v })}
            />
            <Button
              type="button"
              variant="ghost"
              size="icon"
              aria-label="Remove source"
              onClick={() => {
                ids.current.splice(i, 1);
                onChange(value.filter((_, idx) => idx !== i));
              }}
            >
              <Trash2 className="h-4 w-4" />
            </Button>
          </div>
        );
      })}
      <Button
        type="button"
        variant="outline"
        size="sm"
        onClick={() => onChange([...value, { source_name: "", catalog_name: "", schema_name: "" }])}
      >
        <Plus className="mr-1.5 h-4 w-4" />
        Add source
      </Button>
    </div>
  );
}
