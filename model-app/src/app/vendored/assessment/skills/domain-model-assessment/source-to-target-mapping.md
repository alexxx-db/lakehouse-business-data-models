# Source-to-Target Mapping — Phase 4

---

## Mode-Specific Report Scope (read first)

The scope of *this* report depends on `output_model` and which layer the assessment targets. Do not
leave it to the agent to guess (the sales-order run guessed correctly but unguided):

| `output_model` | Report scope | Gold handling |
| --- | --- | --- |
| `normalized` | **Single tier** — 3NF product-named tables only | none |
| `dimensional` | **Single tier** — the `dim_/fact_/bridge_` star only | the star IS the target |
| `hybrid` | **Silver tier now** (3NF), plus one deferral line | gold is a *later, separate* pass — see below |

**Hybrid is layered, not both-at-once.** For a `hybrid` first pass, map the **silver 3NF** target
exactly as `normalized` mode, then write only one line in the Domain Readiness Summary:
`Gold (Mode B): deferred — runs after the silver build is populated.` Say nothing about which
entities become dims or facts — that classification is a gold design. The full gold star is assessed in a **second pass** using `gold-derivation-protocol.md`,
after the silver build lands — do NOT design the gold star in the silver S2T report.

> Trigger for the gold pass: silver is built + populated, and the user asks to "assess/build the
> gold layer." The SKILL.md **Mode Gate** routes it to Mode B (`gold-derivation-protocol.md`).

---

## Bronze Type Profile (report header section — before the per-entity mappings)

Open the report body with a **Bronze Type Profile** so the build knows up front how much type
casting is needed and which date masks to use. Two small tables, both filled from Step 2.4 / 2.4c:

```
### Bronze Type Profile

| Source system | Total columns | All STRING? | Typed dates | Typed numerics |
| sap_sd         | 81            | YES         | 0           | 0              |
| salesforce_crm | 39            | YES         | 0           | 0              |

### Date Formats (per source system)   ← from Step 2.4c
| Source system | Date columns        | Observed format | Cast mask                        |
| sap_sd        | erdat, vdatu, edatu | yyyyMMdd        | TRY_TO_DATE(col, 'yyyyMMdd')     |
| salesforce_crm| quote_date, valid_until | yyyy-MM-dd  | TRY_TO_DATE(col, 'yyyy-MM-dd')   |
```

Then a **Source Ownership** section from Step 2.3b, so a reviewer can see which systems the
population comes from before reading any mapping:

```
### Source Ownership   ← from Step 2.3b (one row per entity with 2+ candidate systems)
| Entity | Systems | Pattern (split by time / split by population / duplicate / complementary) | Date range per system | Overlap result | Population used |
```

Follow it with a **Value Semantics** section from Step 2.4d. One row per finding; write "none
found" per check rather than dropping the row, so a reviewer can tell "probed, clean" from "not
probed":

```
### Value Semantics   ← from Step 2.4d
| Check | Source system | Column(s) | Observed | Rule / transform | Open risk |
|---|---|---|---|---|---|
| Units (A) | `{system}` | `{measure}` + `{uom_col}` | `{distinct units / magnitude ratio}` | `{conversion + factor source}` | `{—}` |
| Time / DST (B) | `{system}` | `{ts_col}` | `{naive local zone / offset-aware; fall-back duplicates n}` | `{to_utc_timestamp(...) / key rule}` | `{—}` |
| Row exclusion (C) | `{system}` | `{flag_col}` | `{values + counts}` | `{exclude / carry status + exclude from measures}` | `{—}` |
| Cross-system key (D) | `{system}` | `{key_col}` | `{format mix; match rate per format; crosswalk coverage}` | `{normalization per format}` | `{unmatched bucket n (P-item)}` |
| Sign / number (E) | `{system}` | `{amount_col}` | `{trailing minus / parens / cents}` | `{parse rule}` | `{—}` |
| Code vocabulary (F) | `{system}` | `{code_col}` | `{distinct codes per system; overlap; crosswalk table + coverage}` | `{map to one vocabulary via crosswalk / confirmed CASE}` | `{codes with no mapping n (P-item)}` |
```

Rows A and F record the **conformed** rule (one unit, one vocabulary per target column), not only
what was observed. A row whose Rule cell just says the observed values are kept is an open risk.

If the profile is **All-STRING**, say so in the report header ("All-STRING bronze — full type
casting required") — it tells the build every column needs an explicit cast and every date needs a
sampled mask (Step 2.4c), and that the load strategy resolved via the Step 2.6.0 fast-exit.

---

## Report Structure

For each real target table (in load order, Tier 0 → Tier N), produce one section with:

```
### N. `{table_name}` — {One-line title from metamodel}

**Intent** *(from vibe_metamodel_product.description)*: {verbatim quote}

**Candidate sources**
| Source | Rows | Event date range | Role (Populates / Enriches / Cross-check / Excluded: reason) | Why it fits |

**Column mapping**
| Target (silver) column | Class | Target Type | Source table | Source column | Transformation | FK Lookup | Null Disposition | Metamodel description | Glossary term | Gap? | Rows | Null % | Distinct | Date format | FK orphans |

> **`Source column` is a VERIFIED bronze column name (from Step 2.4b reconciliation) — NEVER a
> repeat of the target name.** The metamodel attribute is the target name we *want*; the bronze
> column that populates it is frequently different or absent. If a target column has no confirmed
> source column, its `Source column` is blank and `Gap?` is `Derived` or `GAP` — do not invent a
> bronze column name. This split is what prevents the downstream build from guessing (the 76%-rewrite
> failure mode).

> **Carry the metamodel's own words forward.** `Metamodel description` = `vibe_metamodel_attribute.description`; `Glossary term` = `business_glossary_term` (both from the Phase 1.3 pull). These seed the built table's COMMENT + `glossary_term` tag downstream (`etl-development-framework/naming-standards.md` §5.6). A column with neither gets `—`, never blank — so the build can tell "none" from "forgotten".

**Source profiles** *(required when a column has 2+ Populating/Enriching systems or is joined from a different grain — see "Per-source profiles")*

| Column | System | Role | Source table.column | Rows | Null % | Distinct | FK orphans | Note |
|---|---|---|---|---:|---:|---:|---:|---|

Omitted when no column requires per-source profiling.

**Key derivation**: {formula}

**Expected orphan rates** (for FK columns): {estimate per FK; when 2+ systems populate the entity,
the measured rate **per Populating system** from Step 2.7 (d), e.g. `system_a 0% · system_b 0%`}

**FK resolution** (REQUIRED for every FK — normalized product FKs and fact FKs alike). This
per-entity table maps into spec Section 3 (which is ONE table for the whole spec): prepend this
entity as the §3 `Owning Entity` column, and the build adds a `Values verified equal?` column that
it populates and confirms during its confirmation pass:

| FK Column | Parent Entity | Domain (intra/cross) | Resolution (LEFT JOIN / NULL) | Join Condition |
| --- | --- | --- | --- | --- |

`Join Condition` MUST be the explicit, complete predicate — including every column of a composite
join (e.g. `vkorg = k.sales_org AND vtweg = k.dist_channel AND spart = k.division`) — so the build
never reverse-engineers it. Note name-vs-code / internal-vs-external mismatches in the condition.

**Cross-domain FK availability** (per cross-domain FK, from Step 2.8): {Resolvable / Deferred /
Blocked — parent domain populated / empty / absent. Tells the build which FKs to EXPECT, which to
accept as NULL, and which are a cross-domain dependency.}

**Row filter**: {the exclusion rule from Step 2.4d C — e.g. "exclude soft-deleted rows; carry
cancelled documents with status, excluded from measures" — or "none (probed: no exclusion columns)"}

**Load strategy**: {FULL_MERGE | INCREMENTAL_MERGE | APPEND_ONLY | SDP} — {source row count +
mutability → why. See "Load Strategy Recommendation" below.}

**Grade: {A–F} ({Full|Partial|Blocked}) · Structure: {Sound|Review|Rework} ({D#, Vibe n})** — Core {n}/{n} sourced · Enrichment {n}/{n} ({pct}%) · {n} Deferred FK · {one-sentence reason}
```

---

## Load Order Derivation

Before mapping any table, derive the load order from the FK graph (the resolved
`referential_constraints` + `key_column_usage` join from discovery-protocol §1.5 — or the
`foreign_key_to` fallback when the model declares FKs only in the metamodel, not as physical UC
constraints). Use this algorithm:

1. **Tier 0** — tables with no FK columns (root masters)
2. **Tier 1** — tables whose only FK columns point to Tier 0 tables
3. **Tier N** — tables whose FK columns point to Tier N-1 tables
4. **Skip** — degenerate placeholder and any Blocked table (no source)

State the full tier sequence at the top of the S2T report before the per-table sections.

---

## Grading Rubric

The grade answers one question: **can the build populate this entity's business process from the
data we have?** It is not a raw column-coverage percentage. Vibe models are deliberately wide — an
entity often carries 30–50 columns, many describing systems or practices a given customer doesn't
run. A flat "% of columns sourced" bar grades every wide entity Partial, so the scorecard stops
separating a well-sourced entity from a weak one. Grade on the columns that carry the process, and
report the rest as coverage.

### Step 1 — Classify every target column (record the class in the S2T row, in the `Class` column of the column table)

| Class | What belongs here | Counts toward the grade? |
| --- | --- | --- |
| **Core** | The PK / natural key and grain-defining columns; the entity's primary event date(s); its primary measures or amounts; its lifecycle status; **mandatory intra-domain** FKs (every row has the relationship) | **Yes** — every Core column must be sourced or derivable for Full |
| **Enrichment** | Every other business attribute: descriptive, optional, or capability flags. Also **conditional intra-domain FKs**: a relationship that by business rule applies to only some rows (a credit memo points to the invoice it corrects; an order line points to the promotion that priced it) | Only as a **group** (see Partial). Scattered Enrichment gaps are coverage, not a grade driver |
| **Deferred FK** | An FK that can't resolve for a reason outside this entity's own data. Tag the reason in `FK Lookup`: **`parent domain empty`** (cross-domain parent exists but is empty, Step 2.8 = Deferred, natural/bridge key present) · **`sibling Blocked`** (the parent is an entity in *this* domain that is graded Blocked) · **`model decision D#`** (Step 2.7 found the relationship itself wrong and the fix is a pending decision) | **No** — see the rules below. Never a penalty on this entity |
| **Technical** | Audit / ETL-housekeeping columns (`created_timestamp`, `updated_timestamp`, `record_*`, load metadata) that the build stamps itself | **No** — the build supplies them |

**Reuse prior tiers.** When `docs/inputs/prior_tiers.json` exists (a re-assessment of the same model
version), start from it: every column it lists keeps its tier. Change a tier only on new evidence,
and record each change in a **Tier changes** table in the S2T report (`Entity | Column | Prior | New |
Evidence`). Re-check every `deferred_fk` reason each run, because decisions get answered. A column the
file doesn't list is classified fresh. Without the file, classify as below.

Take Core membership from the metamodel: the product `description` (its "Intent" — what the entity
records) plus the PK, grain, and intra-domain FK declarations from Phase 1. When a column's class
is ambiguous, treat it as Enrichment and say so — never quietly promote a gap out of Core to earn a
Full.

**Three FK rules.** Each one stops a single upstream fact from being counted as a gap on many
entities:

1. **Mandatory vs conditional.** An intra-domain FK is Core only when every row of the entity has
   the relationship. If the product or attribute description makes it conditional ("when this memo
   corrects an invoice", "if a promotion applied"), it is Enrichment. Still map it wherever the
   source supplies it. If it's unsourced *even for the rows it applies to*, that is an Enrichment
   gap in the registry. When unsure, say which rows the relationship applies to and why.
2. **FK to a Blocked sibling.** When the parent is an entity in this domain that is graded Blocked,
   the FK column is `Deferred FK (sibling Blocked)` on every child. The gap belongs to the Blocked
   entity and is recorded there once, with its ingestion ask. The children are graded on their own
   data. Don't downgrade three entities for one missing source.
3. **FK the model got wrong.** When a Step 2.7 assertion shows the relationship itself is wrong (no
   real parent-child relationship, or many:many where the model declares 1:many) and the fix is a
   pending decision, the FK column is `Deferred FK (model decision D#)`. Grade the entity against the
   corrected model, and put "pending model fix D#" in the grade reason so the dependency stays
   visible. This applies only when Step 2.7 records the contradiction as evidence. An FK that is
   merely hard to source stays in its class.
   **This holds even when the FK would otherwise be Core** (a mandatory relationship, e.g. a rider's
   `rate_schedule_id`). A wrong relationship tied to a decision is `Deferred FK (model decision D#)`,
   never an unsourced Core column, and never the reason for a Partial gate or a D/F letter. If the only
   unsourced Core column is an FK cited by a structure decision, the entity is Full and its Structure is Rework.

### Full
- Primary natural key is sourceable with a clear derivation
- **Every Core column is sourced or derivable** across the full expected population
- No **Enrichment column group** named in the product description is wholly unsourced (see Partial)
- No **mandatory** intra-domain FK left entirely unresolvable (Deferred FKs excepted)
- V1 proof exists (non-zero rows in MVP), OR column inspection confirms mapping

### Partial
- Primary natural key is sourceable, AND at least one of:
  - A **Core** column has no viable source
  - A **column group** the product description names as part of the entity's purpose has no
    viable source (e.g. all cost fields, all compliance flags, all approval-workflow fields, all
    scheduled-date fields). This is usually one unextracted system, so name that system in the
    ingestion ask
  - The source covers only a **subset of the expected population** — e.g. one plant of four, or
    only the records from one of two systems that each own part of the population. Always state
    the coverage caveat explicitly. **The expected population is the union of every system that
    owns part of the process (Step 2.3b)**, never "the system I mapped". If a Populating system is
    left out of the mapping, the entity is Partial, even when every column is sourced from the
    other one

### Blocked
- Primary natural key (or its source system ID equivalent) has no bronze, silver, or gold source
- The entity simply cannot be populated without new ingestion
- OR: the only source is a SaaS platform (Windchill PLM, o9, etc.) that is not yet ingested
- OR: the only candidate source records a **different business process** — a **proxy source**
  (Step 2.7 Assertion (g)). Populating the entity from it would fill the table with the wrong facts.
  Record the proxy as a possible enrichment or cross-check source, and name the real system of
  record in the ingestion ask

### Letter grade

A mechanical letter sits on top of the Full / Partial / Blocked gate. `enrichment_pct = enrichment_sourced / enrichment_total`, and 100% when `enrichment_total = 0`. A column counts as sourced when its status is mapped or derived.

| Letter | Rule |
|---|---|
| A | Gate Full and enrichment_pct ≥ 75% |
| B | Gate Full and 25% ≤ enrichment_pct < 75% |
| C | Gate Full and enrichment_pct < 25%; or gate Partial with every Core column sourced (only a named Enrichment group is missing) |
| D | Gate Partial with a Core column unsourced. A partial-population gap counts here: report the Core columns that are not sourced across the full population as unsourced in `Core n/n`, so the letter stays mechanical |
| F | Gate Blocked |

> The letter is mechanical. Compute it from the gate and the counts; never adjust it by judgment. Put judgment in the gate and the reason.

The Summary Scorecard `Grade` cell carries the same `{Letter} ({Gate})` value as the grade line plus the structure (e.g. `B (Full) · Rework`), and the Totals line counts letters, gates and structures.

### Structure

The letter measures source coverage; it says nothing about whether the entity's shape is right. A second, separate axis sits next to it. Each entity gets one of (first match wins):

| Structure | Rule |
|---|---|
| Rework | The entity has an open pending decision with `kind = structure` **and** `Blocks build: yes` |
| Review | The entity has an open `kind = structure` decision that doesn't block, **or** it is in `Affected` of a next vibe with `Urgency: before_build` |
| Sound | Otherwise |

- **Open** means unanswered: a recorded default is not an answer.
- **Decision `kind`** (a field on every `pending_decisions.md` block: `structure | source | scope`):
  - `structure`: the grain, cardinality, FK direction, an entity split or merge, or a missing or extra entity (Phase 2C model completeness, Step 2.7 grain or cardinality assertions).
  - `source`: source-process fit, proxy sources, or missing ingestion. These already drive the letter (F, D), so they never touch Structure, to avoid double counting.
  - `scope`: cross-domain governance or ownership questions, which don't affect this entity's shape.
- A decision applies to its `Entity` and to every entity in its `Affected` line.
- The grade line lists the driving decision IDs and vibe priorities in parentheses, e.g. `Structure: Rework (D4)` or `Structure: Review (Vibe 2)`; omit them for Sound.

> Structure is mechanical — derive it from `pending_decisions.md` and `next_vibes.md`; never adjust it by judgment.

### Report the coverage next to the grade

The grade line carries both numbers, so a reviewer sees the shape without re-deriving it:

`**Grade: B (Full) · Structure: Rework (D4)** — Core 9/9 sourced · Enrichment 14/31 (45%) · 6 Deferred FK · {one-sentence reason}`

Enrichment gaps still go to the Gap & Enhancement Registry (usually P2/P3) whatever the grade.
Full means the process is buildable now, not that every column is filled.

> **Blocked ≠ dropped.** A Blocked entity is recorded **DEFERRED** in the Gap & Enhancement
> Registry with a future-enhancement callout (the ingestion ask that would unblock it) — it is
> **never silently descoped**. This is knob-blind: an entity blocked for lack of data is blocked
> regardless of `output_model`. See `iteration-loop.md` gap disposition and the ETL skill's
> `discovery-and-gap-analysis.md` "No silent descoping".

**Important distinctions:**
- A column being derivable (computed from other columns) counts as sourced, not a gap
- A column whose only bronze source is 100% NULL is a **`NULL_SOURCE` gap**, NOT sourced — it
  delivers no data. Grade it exactly like a missing column of the same class: a NULL_SOURCE
  **Core** column (or a NULL_SOURCE column that completes an unsourced Enrichment group) makes the
  entity **Partial, not Full**. Never count a NULL_SOURCE column as sourced. Every NULL_SOURCE column
  is recorded in the Gap & Enhancement Registry regardless of keep/drop disposition.
- A column in a missing EBS table (e.g., `wip_discrete_jobs` not in `orcy_wip_curated`)
  counts as a gap — note the missing table name as the ingestion ask
- A column that maps to a cross-domain FK (e.g., `abl_pn_registry_id` to componentmaster) is a
  **Deferred FK** — not a gap — when the natural key (`abl_pn`) is present and the parent domain
  exists but is empty. It is a gap only when the natural key itself has no source
- **An empty parent domain never downgrades this entity.** If every entity in the domain would grade
  Partial "because the cross-domain parents are empty", the rubric is being misapplied. That is one
  domain-level dependency: record it once in the registry (e.g. "build `{parent_domain}` before
  enforcing N cross-domain FKs"), not twelve times as entity grades

---

## Column Mapping Conventions

### Per-Column Fields
| Field | What to write |
| --- | --- |
| `Target (silver) column` | The TARGET column name the model declares (from `vibe_metamodel` attribute) |
| `Class` | `Core` \| `Enrichment` \| `Deferred FK` \| `Technical` — the column's tier from the Grading Rubric (Step 1). Ambiguous = Enrichment. |
| `Target Type` | The TARGET column's declared type from the metamodel attribute (Phase 1.3 pull) — carried through to the handoff spec §2 `Type`. Never omit; a derived/constant column states its computed result type. |
| `FK Lookup` | For a FK column, the parent entity + the join it resolves through (full condition goes in the FK-resolution table); `—` for a non-FK column. |
| `Null Disposition` | For a `NULL_SOURCE` column only: `keep` \| `drop`, or blank = the `conventions.yml` `null_columns.disposition` global default. Ignored for non-null-source columns. |
| `Source table` | `{catalog}.{schema}.{table}` the column comes from, or blank if Derived/Constant/GAP |
| `Source column` | The **verified** bronze column name (Step 2.4b), or blank for `Derived`/`Constant`/`GAP`. **Never the target name.** |
| `Transformation` | SQL expression: `CAST(...)`, `CASE WHEN ...`, `SHA2(...)`, `SUM(...)`, or `Constant` value |
| `Gap?` | `No` / `Partial` (exists but incomplete) / `Derived` (computed, no single source col) / **`GAP`** (no source) / **`NULL_SOURCE`** (source column exists but is 100% NULL across all rows) |
| `Rows` · `Null %` · `Distinct` · `Date format` · `FK orphans` | *Optional profile columns, after `Gap?`.* The **target projection** — profile evidence for the mapped column's final silver rows: row count, null rate, distinct count, the detected date mask (date columns only), and the FK orphan count (FK columns only). Blank when not profiled; they map to `row_count`, `null_pct`, `distinct_count`, `date_format`, `fk_orphans` in the structured assessment output. |

> **The `Source column` MUST be a real column returned by `information_schema.columns` for the
> `Source table` (Step 2.4b reconciled it). A target column with no confirmed bronze column is a
> `GAP` or `Derived` — leaving `Source column` blank — never a copy of the target name.**

### Profiling derived columns

Every `Derived` mapping (and any mapped expression that is not a plain column copy) gets an
expression-level profile **before the mapping is finalised** — raw-source null probes do not tell you
what the transformation produces. Wrap the mapped expression in a CTE over the source and report
`COUNT(*)`, the null count and rate, and `COUNT(DISTINCT expr)`:

```sql
WITH mapped AS (
  SELECT {mapped_expression} AS target_col          -- the exact Transformation from the S2T row
  FROM {catalog}.{schema}.{source_table}
)
SELECT COUNT(*)                                        AS row_count,
       COUNT(*) - COUNT(target_col)                    AS null_count,
       (COUNT(*) - COUNT(target_col)) / NULLIF(COUNT(*), 0) AS null_pct,
       COUNT(DISTINCT target_col)                      AS distinct_count
FROM mapped
```
Record the results in the `Rows`, `Null %` and `Distinct` columns of that mapping row. A derived
column whose expression returns all NULL or a single distinct value is a finding, not a mapping.

### Per-source profiles

**Required** when a column has 2+ Populating or Enriching systems, or is joined from a table whose grain differs from
the target entity. **Optional** otherwise (single source, same grain: the column-level metrics already describe the target projection).

For each qualifying column, one row per `(system, source_table, source_column)` contributing to it, measured
**at source grain** in that system's rows only, after the entity's row filter:

| Field | Meaning |
|---|---|
| `system` | Source name as in the Source Ownership section (e.g. `src_oracle_ccb`). |
| `source_table` | Fully qualified bronze table. |
| `source_column` | Bronze column (or expression). |
| `role` | `populates` · `enriches` · `cross_check` (lenient string; matches Source Ownership roles). |
| `rows` | Rows of this source at source grain. |
| `null_pct` · `distinct_count` | Measured on this source's rows. |
| `fk_orphans` | This system's orphans for the column's FK lookup (the Step 2.7 per-system probe); FK columns only. |
| `note` | Optional, e.g. `joined at account grain, 1:N to bill`. |

**Row rules** (a row that breaks one is wrong, not approximate):
- **One system per row.** `system` names exactly one source. Never `Oracle CC&B + SAP IS-U`; split it into two rows.
- **That system's own column.** `source_table` and `source_column` are the table and column *this* system reads
  (e.g. `…ridgeline_oracle_ccb.ci_bill` / `BILL_DT` on the CC&B row, `…ridgeline_sap_isu.erch` / `ABRDATS` on the SAP
  row). Never copy the column-level `Source table` / `Source column` cell, which lists every system. If two rows
  carry the same `source_column` text, check them again.
- **Measured, not inherited.** `rows`, `null_pct` and `distinct_count` come from this system's own projection
  (the query below). Populating rows usually sum to the target `Rows`. When they don't (dedup, filters, a
  population split), say why in `note`.
- **Per-system orphans on every FK column.** `fk_orphans` is this system's result from the Step 2.7 (d) probe.
  Fill it on every FK column with a parent in this domain, including `0`. Leave it blank only on non-FK columns.
- **`note` only when there is something to say:** a different grain, a dedup, a sum that doesn't match the target,
  a conformance rule. Leave it empty otherwise. Never write stock text such as "Measured at source grain".

**Canonical query: one per entity, long form.** Build one projection per system that applies the entity's row filter
and that system's transformations, then unpivot:

```sql
WITH ccb AS (SELECT 'src_oracle_ccb' AS _system, {col_a_expr_ccb} AS col_a, {col_b_expr_ccb} AS col_b
             FROM {ccb_table} WHERE {row_filter_ccb}),
     sap AS (SELECT 'src_sap_isu'    AS _system, {col_a_expr_sap} AS col_a, {col_b_expr_sap} AS col_b
             FROM {sap_table} WHERE {row_filter_sap}),
     u AS (SELECT * FROM ccb UNION ALL SELECT * FROM sap)
SELECT _system, 'col_a' AS target_column, COUNT(*) AS rows,
       ROUND(100.0 * COUNT_IF(col_a IS NULL) / COUNT(*), 2) AS null_pct, COUNT(DISTINCT col_a) AS distinct_count
FROM u GROUP BY _system
UNION ALL
SELECT _system, 'col_b', COUNT(*), ROUND(100.0 * COUNT_IF(col_b IS NULL) / COUNT(*), 2), COUNT(DISTINCT col_b)
FROM u GROUP BY _system;
```

A joined enrichment at another grain gets its own CTE at **its** grain (`rows` = rows of the joined table after its
filter), not the target grain. Join the Step 2.7 (d) per-system orphan results onto the FK columns. Write the result
into the entity's **Source profiles** table. These rows map to `profiles_by_source[]` in the structured assessment
output, with keys system, source_table, source_column, role, rows, null_pct, distinct_count, fk_orphans and note.

### Key Derivation Standard  *(knob-aware — depends on `output_model`)*
Always state the natural key explicitly — it is the idempotent reload anchor in every mode.
- **`dimensional`** (+ `hybrid`-gold): the built PK is a BIGINT surrogate `{Entity}_Key`.
  Derivation: `SHA2(CAST({natural_key_column} AS STRING), 256)` cast to BIGINT; composite →
  `SHA2(CONCAT_WS('|', col1, col2, col3), 256)`. (`scd_strategy: type_2` adds `_effective_from`
  to the hash so each version gets a distinct key.)
- **`normalized`** (+ `hybrid`-silver): the built PK **follows the vibe model** — keep the
  model's `{product}_id` and type; do NOT overlay a `{Entity}_Key` SHA2 surrogate. Add a
  surrogate only where the model PK is composite/mutable or cross-source integration needs one.
  (The metamodel `{table}_id` is often already a BIGINT surrogate — preserve it as-is.)

Example:
```
**Key derivation**: SHA2(CAST(WIP_ENTITY_ID AS STRING) || '|' || CAST(ORGANIZATION_ID AS STRING), 256)
Natural key: WIP_ENTITY_ID + ORGANIZATION_ID
```

### FK Resolution Pattern
For each FK column, document:
1. The intra-domain join (if FK points within this schema)
2. The natural key join for cross-domain FKs (those in `foreign_key_to` pointing outside the schema)
3. The expected orphan rate (NULL or unmatched FKs as % of rows)

Example:
```
`plant_id` FK: JOIN org_organization_definitions ON ORGANIZATION_ID → SHA2(plant) lookup
Expected orphan rate: <1% (org codes that have been decommissioned since 2019)
```

---

## Load Strategy Recommendation (REQUIRED — you already have the row counts)

Discovery profiles row counts *and* mutability per source (Phase 2, Steps 2.3 + 2.6). Use both
to recommend a load strategy per entity so the ETL skill does not default everything to full
MERGE. This maps directly to `etl_detailed_spec.md` Section 5.

**Mutability, not row count, is the deciding axis** — run the Step 2.6 Mutability Probe
(entity semantics + creation-vs-update timestamp divergence) for every fact first. Row count
only chooses *between* the mutable strategies.

| Source rows | Mutable after insert? (Step 2.6) | Recommend |
| --- | --- | --- |
| any size | **append-only** ledger (transactions/moves/completions/postings; `pct_mutated ≈ 0`) | `APPEND_ONLY` |
| < ~5M | mutable | `FULL_MERGE` (full scan is cheap at this size) |
| 5M–100M | mutable, **has** update ts | `INCREMENTAL_MERGE` (name the watermark column) |
| > 100M mutable, OR mutable with **no** usable watermark, OR needs SCD2 / enforced DQ | — | `SDP` (flag as escalation + CDF dependency) |

State the chosen strategy and the evidence (row count + `pct_mutated` + watermark column) that
drove it in each table's **Load strategy** line. Two calls to make explicit:
- **Immutable transaction facts → `APPEND_ONLY` regardless of size.** The `WHEN MATCHED` branch
  and full-target rewrite are pure waste for write-once rows.
- **Mutable fact with no reliable update timestamp → `SDP`, never a silent `FULL_MERGE`.** A
  watermark can't be built, so record it as an escalation with a **Change Data Feed on bronze**
  dependency (owned by the ingestion team; must be enabled going forward). Note in the same
  breath that `APPEND_ONLY` and watermarked `INCREMENTAL_MERGE` need **no CDF** — only this
  no-watermark / delete-capture / SCD2 tier does.

---

## Naming: the S2T report stays in metamodel-native names (with a crosswalk)

**This report uses the RAW metamodel names** (`order`, `order_id`, `lower_snake`) — it is a
*discovery* artifact whose job is to map bronze columns to model attributes, so keeping
model-native names here is correct and keeps it 1:1 with the metamodel you profiled. The
downstream **handoff docs** (`business_requirements.md` / `etl_detailed_spec.md`) DO apply the
`conventions.yml` `naming:` block (`fact_order`, `Order_Key`, `Pascal_Snake` — see
`iteration-loop.md` handoff section). So the two artifacts intentionally use different vocabularies.

**To keep them reconcilable, the S2T report MUST carry the crosswalk** — do not leave the reader
to guess that S2T `order` == spec `fact_order`. Add a `Built Name (conventions)` column to the
Summary Scorecard (below) mapping each metamodel name to the built name the build will use. State
once, above the scorecard: "Target Table = metamodel-native name; Built Name = after
`conventions.yml` `naming:` + `output_model` — this is the name the ETL build/spec uses."

> **The Built Name is KNOB-AWARE — this is the one place `output_model` enters the S2T report.**
> The grades, sources, and gaps to its left are **knob-blind** (they describe whether the data
> supports the business entity, regardless of shape). Only the Built-Name crosswalk and the key
> derivation shift with the knob:
> - `dimensional` → `dim_/fact_/bridge_` prefix, `{Entity}_Key` surrogate.
> - `normalized` → the metamodel product name verbatim (`order`, not `fact_order`), `{product}_id`.
> - `hybrid` → normalized product name for silver; the `dim_/fact_` star name for the gold tier.

## Summary Scorecard Format

Always produce this table at the end of the S2T report. Everything except **Built Name** is
knob-blind. Fill `Built Name (conventions)` by applying `conventions.yml` `output_model` +
`naming:`: `dimensional` → Type-based `dim_/fact_/bridge_` prefix + `table_case` + `entity_form`;
`normalized` → metamodel product name unchanged; `hybrid` → note both (silver product / gold star).

| # | Target Table (metamodel) | Built Name (per output_model) | Grade | Primary Source(s) | Source Rows | Load Strategy | Key Gap |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `plant` | dim: `dim_plant` · norm: `plant` | C (Partial) | `dff_curated.tbl_plants` + `org_organization_definitions` | 120 | FULL_MERGE | Address, ISO cert |
| 2 | `wip_material_transaction` | dim: `fact_wip_material_transaction` · norm: `wip_material_transaction` | A (Full) | `orcy_wip_curated.mtl_material_transactions` | 168M | APPEND_ONLY | — |
| ... | | | | | | | |

**Totals: X Full · Y Partial · Z Blocked · Letters: a A · b B · c C · d D · f F**
**Load: A FULL_MERGE · B INCREMENTAL_MERGE · C APPEND_ONLY · D SDP-escalation**

---

## Ingestion Ask Table Format

Always produce this at the end of every report:

| Priority | Table to Ingest | System | Target Schema | Unblocks |
| --- | --- | --- | --- | --- |
| **P0** | `wip_discrete_jobs` | Oracle EBS WIP | `orcy_wip_curated` | `wip_job` qty, status, dates |
| **P1** | ... | | | |

Priority definitions:
- **P0**: Unblocks a Blocked entity OR unblocks the primary natural key of a Partial entity
- **P1**: Unblocks a significant column group (>3 columns) on an existing Partial entity
- **P2**: Unblocks one specific column (compliance flag, ECN ref, etc.) — high business value
- **P3**: Nice-to-have enrichment; low-volume table; not on critical path

---

## What Counts as "Sourced"

| Situation | Count as |
| --- | --- |
| Column maps directly from a bronze column | Sourced (No gap) |
| Column maps to a bronze column that is 100% NULL across all rows | **NULL_SOURCE** — a gap; register it, graded by its column class (see grading). Disposition keep/drop per `conventions.yml` `null_columns` (+ per-column override) |
| Column is derivable from other sourced columns (CASE, arithmetic, date diff) | Sourced — note `Derived` in Source field |
| Column maps from a silver table (via Option B consume-as-source) | Sourced — note the silver table |
| Column maps from a gold table (e.g. an existing gold schema like `o9_gold`) | Sourced — note gold origin |
| Column exists in a bronze table that is IN the bronze catalog but NOT in the identified schema | GAP — state missing table name as ingestion ask |
| Column exists in a source system not yet ingested to any lake tier | Blocked — state the source system |
| Column is a cross-domain FK that resolves via natural key join | Sourced (Partial if high orphan rate expected) |
| Column is a cross-domain FK whose parent table exists but is empty (Step 2.8 Deferred), natural key present | **Deferred FK** — not a gap; excluded from the grade |
| Column is an intra-domain FK to a sibling entity graded Blocked | **Deferred FK (sibling Blocked)** — the gap is recorded once, on the Blocked entity |
| Column is an FK that Step 2.7 found structurally wrong, fix pending | **Deferred FK (model decision D#)** — grade against the corrected model |
| Column is an intra-domain FK whose parent entity is populated in this domain | **Never "no conforming source".** Map it through the parent's natural key, a crosswalk, or an indirect path of up to two hops (Step 2.7 "Indirect (multi-hop) FK resolution") and measure the orphan rate per Populating system (Step 2.7 (d)). A high orphan rate is a measured finding (an `FK_ORPHAN` gap with the count), not a reason to defer the column |
| Column is an intra-domain FK that applies to only some rows by business rule | **Enrichment** — map it where sourced; a gap only if unsourced for the rows it applies to |
| Column resolves for one Populating system but not another (Step 2.7 (d) per-system test), no crosswalk in bronze | **Gap for that system's rows** — a Core column unsourced for part of the population (Partial). With a crosswalk in bronze, it is Sourced, and the Transformation routes the lookup through it |
| Column is a measure or code that Populating systems record in different units or vocabularies | Sourced only when the Transformation conforms them (Step 2.4d A.5 / F). Passed through unconverted, it counts as a gap for the system whose values don't match the target |
| Column is a cross-domain FK where the target domain is not in the lake | Column-level Blocked (state which domain). Downgrades the entity only if the column is its natural key |
| Element was user-confirmed dropped at the Phase 2C gate (matching `model_deviation` toggle on) | **DROPPED (deviation)** — represent the element *present* in the S2T with this origin; never omit it silently. Record reason in Key Gap column. |
| Bronze reveals a table/column the model lacks; user confirms at Phase 2C gate (`allow_new_entities` on) | **NET-NEW (deviation)** — add an S2T row with origin `NET-NEW (deviation)` and a fit grade; ETL build CREATEs it (propose→build). |

---

## Deviation Rows in the Entity Scorecard

When `model_deviation` toggles are active, the Entity Scorecard may include these special rows.

> **Deviation column convention:** The **Grade** axis and the disposition/origin axis are
> orthogonal — deviation labels are **annotations**, not grade values. Never put `DROPPED (deviation)` or
> `NET-NEW (deviation)` in the Grade cell:
> - **`DROPPED (deviation)`** — record the entity's **real fit grade** in the Grade cell (typically
>   `Blocked` or `Partial` — that finding drove the drop). Put the disposition note in the **Key Gap**
>   column: `DROPPED (deviation) — {reason}`.
> - **`NET-NEW (deviation)`** — same pattern: a real fit grade in Grade, and `Origin: NET-NEW (deviation) — {reason}` prefixed in **Key Gap**.
>
> This mirrors the registry rule: `Gap_Type = DROPPED (deviation)` is an annotation on a row whose
> `gap_status = ACCEPTED` — the status field never holds `DROPPED (deviation)`.

| # | Target Table (metamodel) | Built Name (per output_model) | Grade | Primary Source(s) | Source Rows | Load Strategy | Key Gap |
| --- | --- | --- | --- | --- | --- | --- | --- |
| — | `delivery_schedule` | dim: `dim_delivery_schedule` · norm: `delivery_schedule` | F (Blocked) | *(none — `drop_no_process_tables` on)* | 0 | — | DROPPED (deviation) — no bronze process table; user confirmed drop at Phase 2C gate. Recovery breadcrumb emitted for next_vibes. |
| — | `field_event` | dim: `dim_field_event` · norm: `field_event` | C (Partial) | `fieldlink.field_events` | 42K | FULL_MERGE | Origin: NET-NEW (deviation) — bronze table not in model; user confirmed propose→build at Phase 2C gate (`allow_new_entities` on). Recorded in Gap Registry + `business_requirements.md`. |

> **Rule:** A dropped element is always represented **present** in the S2T scorecard — never absent.
> Its Grade cell holds the **real fit grade**; `DROPPED (deviation)` appears only in Key Gap as a
> disposition annotation. A net-new element carries `Origin: NET-NEW (deviation)` prefixed in Key Gap
> and a fit grade like any other row. Neither is ever introduced silently; both require human
> confirmation at the Phase 2C / Step 2.7 gate.

---

## Report File Naming Convention

Save the S2T mapping report to `docs/design/` as a **stable snake_case filename**, matching the
sibling handoff artifacts (`business_requirements.md`, `etl_detailed_spec.md`, `next_vibes.md`):
```
{project_folder}/docs/design/s2t_map.md
```
Example: `meridian/sales_order_mvm/docs/design/s2t_map.md`

Do **not** use a dated title-case filename (e.g. `2026-07-12 - Sales Order Vibe V3 - Source-to-Target
Mapping Report.md`) — the date/version/domain belong in the report's H1 + header block, not the
filename. A stable name keeps the artifact re-findable across re-runs and consistent with every other
`docs/design/` doc. Use the `templates/s2t_map.md` shell to structure the output.
