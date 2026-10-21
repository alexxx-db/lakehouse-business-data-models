import { useMemo } from "react";
import { useQuery } from "@tanstack/react-query";
import { FreeTextCombobox } from "@/components/ui/free-text-combobox";
import { listCatalogs } from "@/lib/api";

export type CatalogOption = {
  name: string;
  comment?: string;
  owner?: string;
};

export type DeploymentCatalogPickerProps = {
  value: string;
  onChange: (v: string) => void;
  disabled?: boolean;
  /** Escape hatch for tests — lets us inject catalogs directly and skip the
   *  `/api/catalogs` fetch so component tests don't depend on MSW or network
   *  mocking. Undefined means "fetch normally". */
  catalogsOverride?: CatalogOption[];
  /** If set (tests), skips the fetch entirely and forces the given state. */
  loadingOverride?: boolean;
  errorOverride?: boolean;
};

async function fetchCatalogs(): Promise<CatalogOption[]> {
  // Phase 7 drift-unification: route through the Orval-generated helper
  // so the request shape + error envelope track the OpenAPI spec. The
  // generated response type is `unknown[]` (the backend returns a list
  // of dicts not modeled in the schema), so we narrow at the boundary.
  const r = await listCatalogs();
  return r.data as CatalogOption[];
}

/**
 * Catalog picker for the Deployment Catalog field. Lists catalogs the app SP
 * can see (auto-filtered by UC), sorted alphabetically, with an inline filter
 * that matches case-insensitively anywhere in the catalog name.
 *
 * Falls back to a plain text input if the listing fails so a broken listing
 * endpoint doesn't block a run, and offers "Use '<input>'" so a catalog that
 * doesn't exist yet can be committed (`FreeTextCombobox`).
 */
export function DeploymentCatalogPicker({
  value,
  onChange,
  disabled,
  catalogsOverride,
  loadingOverride,
  errorOverride,
}: DeploymentCatalogPickerProps) {
  const query = useQuery({
    queryKey: ["catalogs"],
    queryFn: fetchCatalogs,
    staleTime: 60_000,
    retry: false,
    // When an override is provided (tests) we don't want the real fetch to
    // run — gate the query with `enabled`.
    enabled: catalogsOverride === undefined,
  });

  const data = catalogsOverride ?? query.data;
  const isLoading = loadingOverride ?? (catalogsOverride === undefined && query.isLoading);
  const isError = errorOverride ?? (catalogsOverride === undefined && query.isError);

  const names = useMemo(
    () =>
      (data ?? [])
        .map((c) => c.name)
        .sort((a, b) => a.localeCompare(b, undefined, { sensitivity: "base" })),
    [data],
  );

  return (
    <FreeTextCombobox
      value={value}
      onChange={onChange}
      options={names}
      loading={isLoading}
      // Error or unset -> plain input fallback; the live value is still the parent's.
      error={isError || (!isLoading && !data)}
      disabled={disabled}
      ariaLabel="Deployment catalog"
      placeholder="Pick a catalog"
      searchPlaceholder="Filter or type a new catalog name…"
      emptyText="No catalogs match."
      loadingText="Loading catalogs…"
      fallbackPlaceholder="e.g. my_catalog"
      testIdPrefix="deployment-catalog"
    />
  );
}
