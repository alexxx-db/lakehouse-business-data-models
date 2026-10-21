---
project: {project}
customer: {customer}
use_case: {Domain} Vibe V{version} — Source-to-Target Mapping Report
type: discovery_report
created: {YYYY-MM-DD}
author: Genie Code
---

# {Domain} Vibe V{version} — Source-to-Target Mapping Report

> **Scope:** Discovery-only pass against `{catalog}.{schema}` ({N} real target tables;
> {M} metamodel tables; {degenerate} degenerate placeholder excluded).
> All proposed sources are read-only **data** — no data table has been created, loaded, or
> modified. The only writes this motion permits are scoped **metamodel edits via Genie Code**
> (`vibe_metamodel_*`), made only at the human gate when the user picks edit-in-place.

---

## Grading Legend

| Grade | Meaning |
|---|---|
| **Full** | PK derivation clear; every Core column (key, grain, event dates, measures, status, intra-domain FKs) sourced across the full population; no named column group wholly unsourced |
| **Partial** | Key sourceable, but a Core column, a named column group, or part of the expected population has no source |
| **Blocked** | No viable bronze/silver/gold source for the key, OR the only source is a proxy that records a different process; requires new ingestion before ETL can run |

Each grade line leads with a mechanical letter (A–F, see the `### Letter grade` table in `source-to-target-mapping.md`) and the gate, then reports `Core n/n · Enrichment n/n (pct%) · n Deferred FK`. Deferred FKs (cross-domain parent exists but is empty) and Technical columns never count against the grade.

---

## Discovery Context

### Bronze schemas confirmed in `{bronze_catalog}`

| Schema | Relevant tables found | Notes |
|---|---|---|
| `{schema}` | {table list} | {notes} |

### Bronze Type Profile

| Source system | Total columns | All STRING? | Typed dates | Typed numerics |
|---|---|---|---|---|
| `{system}` | {N} | {YES/NO} | {N} | {N} |

*If All-STRING: state "All-STRING bronze — full type casting required" and confirm the load strategy
resolved via the Step 2.6.0 fast-exit.*

### Date Formats (per source system) — from Step 2.4c

| Source system | Date columns | Observed format | Cast mask |
|---|---|---|---|
| `{system}` | {cols} | `{yyyyMMdd / yyyy-MM-dd / ...}` | `TRY_TO_DATE(col, '{fmt}')` |

### Source Ownership — from Step 2.3b

| Entity | Systems | Pattern | Date range per system | Overlap result | Population used |
|---|---|---|---|---|---|
| `{entity}` | `{system_a}`, `{system_b}` | {split by time / split by population / duplicate / complementary} | {a: min–max · b: min–max} | {no shared owner-months / n shared} | {union / one system: reason} |

*Every `bronze_sources` schema needs a role per entity it has candidate tables for. An Excluded system that owns part of a population is a decision, and the entity stays Partial until it's made.*

### Value Semantics — from Step 2.4d

*One row per finding. Write "none found" for a check that ran clean, never drop it.*

| Check | Source system | Column(s) | Observed | Rule / transform | Open risk |
|---|---|---|---|---|---|
| Units (A) | `{system}` | `{measure}` + `{uom_col}` | `{distinct units / magnitude ratio}` | `{conversion + factor source}` | `{—}` |
| Time / DST (B) | `{system}` | `{ts_col}` | `{naive local zone / offset-aware; fall-back duplicates n}` | `{to_utc_timestamp(...) / key rule}` | `{—}` |
| Row exclusion (C) | `{system}` | `{flag_col}` | `{values + counts}` | `{exclude / carry status + exclude from measures}` | `{—}` |
| Cross-system key (D) | `{system}` | `{key_col}` | `{format mix; match rate per format; crosswalk coverage}` | `{normalization per format}` | `{unmatched bucket n (P-item)}` |
| Sign / number (E) | `{system}` | `{amount_col}` | `{trailing minus / parens / cents}` | `{parse rule}` | `{—}` |
| Code vocabulary (F) | `{system}` | `{code_col}` | `{distinct codes per system; overlap; crosswalk table + coverage}` | `{map to one vocabulary via crosswalk / confirmed CASE}` | `{codes with no mapping n (P-item)}` |

### V1/MVP — proven mappings already established

| V1 entity | Rows | Primary source |
|---|---|---|
| `{entity}` | {N} | `{source}` |

### Existing silver/gold — assets in scope

| Schema | Tables | Rows | Notes |
|---|---|---|---|
| `{schema}` | {tables} | {N} | {purpose classification} |

---

## Source-to-Target Mapping ({N} Real Tables)

### Load Order

```
Tier 0 — Masters (no upstream FK within domain)
  {table} → {source}

Tier 1 — Masters with Tier-0 FK
  {table} → {source}

...

Tier N — Facts / Transactions
  {table} → {source}

Skip / Defer:
  {blocked table} → SKIP until {ingestion ask} unblocked
```

---

### 1. `{table_name}` — {Short title}

**Intent** *(from vibe_metamodel_product.description)*: {verbatim}

**Candidate sources**

| Source | Rows | Event date range | Role | Why it fits |
|---|---|---|---|---|
| `{catalog}.{schema}.{table}` | {N} | {reason} |

**Column mapping**

> `Source column` = the VERIFIED bronze column (Step 2.4b), NEVER the target name. Blank for
> Derived/Constant/GAP.

| Target (silver) column | Class | Source table | Source column | Transformation | Gap? | Rows | Null % | Distinct | Date format | FK orphans |
|---|---|---|---|---|---|---|---|---|---|---|
| `{pk}_id` (PK) | Core | `{catalog}.{schema}.{table}` | `{source_pk_col}` | SHA2(CAST({source_pk_col} AS STRING), 256) | No |
| `{column}` | {Core / Enrichment / Deferred FK / Technical} | `{catalog}.{schema}.{table}` | `{verified_source_col}` | {expr} | {No / Partial / GAP} |
| `{derived_col}` | {Core / Enrichment} | | | {CASE/arith over sourced cols} | Derived |
| `{unsourced_col}` | {Core / Enrichment} | | | CAST(NULL AS {type}) | GAP |

*Profile columns (`Rows` … `FK orphans`) are optional; fill them for every `Derived` mapping using the CTE pattern in `source-to-target-mapping.md` "Profiling derived columns".*

*Class — Core: PK/natural key, grain, primary event dates, primary measures, lifecycle status, mandatory intra-domain FKs · Enrichment: every other business attribute · Deferred FK: tag the reason (parent domain empty / sibling Blocked / model decision D#); conditional FKs are Enrichment · Technical: audit/lineage.*

**Source profiles** *(required when a column has 2+ Populating/Enriching systems or is joined from a different grain)*

| Column | System | Role | Source table.column | Rows | Null % | Distinct | FK orphans | Note |
|---|---|---|---|---:|---:|---:|---:|---|
| `bill_date` | `src_oracle_ccb` | populates | `{catalog}.ridgeline_oracle_ccb.ci_bill.BILL_DT` | 112,665 | 0.0 | 707 | — | |
| `bill_date` | `src_sap_isu` | populates | `{catalog}.ridgeline_sap_isu.erch.ABRDATS` | 10,122 | 0.0 | 162 | — | |
| `meter_id` | `src_oracle_ccb` | populates | `{catalog}.ridgeline_oracle_ccb.ci_bseg.MTR_ID` | 112,665 | 0.0 | 5,690 | 0 | |
| `meter_id` | `src_sap_isu` | populates | `{catalog}.ridgeline_sap_isu.erch.GERAET` | 10,122 | 0.0 | 1,640 | 12 | 12 rows reference SAP devices with no keymap row |

*One system per row, that system's own table.column, `FK orphans` on every FK column (0 included), `Note` only
when something needs explaining. Omitted when no column requires per-source profiling.*

**Key derivation** (per `output_model`): dimensional/hybrid-gold → surrogate `{Entity}_Key` =
SHA2({natural_key}, 256); normalized/hybrid-silver → follow the model's `{product}_id` (no
overlay surrogate). Natural key: {col1} [+ {col2}] — the idempotent reload anchor in every mode.

**Expected orphan rates**: {estimate for each FK column}

**Row filter**: {exclusion rule from Step 2.4d C, or "none (probed: no exclusion columns)"}

**Grade: {A–F} ({Full|Partial|Blocked}) · Structure: {Sound|Review|Rework} ({D#, Vibe n})** — Core {n}/{n} sourced · Enrichment {n}/{n} ({pct}%) · {n} Deferred FK · {one-sentence reason}

<!-- Structure is mechanical: derive it from pending_decisions.md and next_vibes.md (source-to-target-mapping.md "Structure"). The parentheses list the driving decision IDs / vibe priorities; omit them for Sound. -->

---

## Intra-Domain FK Orphan Measurements — from Step 2.7 (d)/(e)

*Required. One row per intra-domain FK × Populating system, measured against the parent key as built. Never drop a
non-zero result; each one is also an `FK_ORPHAN` row in the Gap Registry.*

| FK | Populating system | Child rows | Orphans | Note |
|---|---|---:|---:|---|
| `{child}.{fk_column}` | `{system}` | {N} | {orphans} | {cause when non-zero} |

## Tier Changes — only when `docs/inputs/prior_tiers.json` exists

*Every column whose tier differs from the prior run's, with the new evidence. "None" when nothing changed.*

| Entity | Column | Prior | New | Evidence |
|---|---|---|---|---|
| `{entity}` | `{column}` | {tier} | {tier} | {what changed} |

## Crosswalk Coverage — from Step 2.4d D.3

*Required when a key-map / crosswalk bridges two systems. "Moved but unmapped" vs "new" is decided by the D.3 tests,
never assumed.*

| Crosswalk | Objects needing it | Mapped | Secondary match | Unmapped: moved | Unmapped: new | Rule |
|---|---:|---:|---:|---:|---:|---|
| `{keymap}` ({system_a}→{system_b}) | {N} | {N} | {N} | {N} | {N} | {keymap first, secondary-match fallback, source-scoped key for new} |

---

## Summary Scorecard

> Target Table = metamodel-native name (as used throughout this report); Built Name = after
> `conventions.yml` `output_model` + `naming:` — the name the ETL build/spec uses. Only the Built
> Name column is knob-aware: dimensional → `dim_/fact_/bridge_` prefix; normalized → metamodel
> product name unchanged; hybrid → both. Grades/sources/gaps to the left are knob-blind.

| # | Target Table (metamodel) | Built Name (per output_model) | Grade | Primary Source(s) | Key Gap |
|---|---|---|---|---|---|
| 1 | `{table}` | dim: `dim_{table}` · norm: `{table}` | {letter} ({gate}) · {structure} | `{source}` | {gap} |

**Totals: {X} Full · {Y} Partial · {Z} Blocked · Letters: {a} A · {b} B · {c} C · {d} D · {f} F · Structure: {a} Sound · {b} Review · {c} Rework (Blocked → DEFERRED in registry, never dropped)**

---

## Gap & Enhancement Registry

*One row per unsourced target column (entity + column), plus one row per entity-level finding. Never roll several
columns up into a single bucket row: the per-column rows are what the build and the app's gap table read.*

| Entity | Column | Gap type | Description | Status | Ask |
|---|---|---|---|---|---|
| `{entity}` | `{column}` | `MISSING_SOURCE` | {no bronze column; what was searched} | OPEN | P{n} |

*Gap types: `MISSING_SOURCE` (no bronze column) · `NULL_SOURCE` (column 100% NULL) · `PARTIAL_POPULATION` (sourced for
some Populating systems only) · `FK_ORPHAN` (measured orphans) · `CROSSWALK` (unmapped objects) · `MODEL_CARDINALITY` ·
`MODEL_COMPLETENESS` · `TIME_SEMANTICS` · `MISSING_PROCESS_SOURCE` · `POPULATION_COVERAGE` · `SCOPE`. Use the entity-level
types with `*` as the column.*

## Prioritised Ingestion Asks

| Priority | Table to Ingest | System | Schema Target | Unblocks |
|---|---|---|---|---|
| **P0** | `{table}` | {system} | `{schema}` | `{entity}` {columns} |

---

## What Can Be Built Now

{List entities ready to build in Phase 1 (Full or Partial), in load order}

Defer until ingestion ask fulfilled: {Blocked entities}

---

*Report generated by Genie Code — {date}. All reads against {catalogs}.*
