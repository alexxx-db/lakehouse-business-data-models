/**
 * The agent's `org_divisions` widget presets (dropdown values, verbatim) -
 * the one frontend list, used by New Run, the business edit page, the
 * taxonomy wizard and `tree.ts`.
 *
 * Type-checked both ways against `OrgDivisions`, the union the OpenAPI
 * client generates for `TaxonomyTree.coverage` (backend
 * `models.ORG_DIVISIONS_PRESETS`): a preset outside the union, or a union
 * member missing here, fails `tsc` once `api.ts` is regenerated.
 */
import type { TaxonomyTree } from "@/lib/api";

export type OrgDivisions = NonNullable<TaxonomyTree["coverage"]>;

export const ORG_DIVISIONS_PRESETS = [
  "Operations",
  "Operations and Business",
  "Operations, Business and Corporate",
] as const satisfies readonly OrgDivisions[];

type MissingPresets = Exclude<OrgDivisions, (typeof ORG_DIVISIONS_PRESETS)[number]>;
// Compile-time only: `true` is assignable only while no union member is missing.
const _allPresetsListed: [MissingPresets] extends [never] ? true : MissingPresets = true;
void _allPresetsListed;

/** The widest preset; the taxonomy tree's default coverage. */
export const ORG_DIVISIONS_ALL: OrgDivisions = "Operations, Business and Corporate";

export function isOrgDivisionsPreset(v: string): v is OrgDivisions {
  return (ORG_DIVISIONS_PRESETS as readonly string[]).includes(v);
}
