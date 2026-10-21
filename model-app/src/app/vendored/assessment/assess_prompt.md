Run my $domain-model-assessment skill at this project root (load $autonomous-validation alongside it).

This is an UNATTENDED, headless run inside a Databricks Job — no human will answer questions during this session.
Headless contract (overrides any instruction to stop and ask):
1. `conventions.yml` at the project root is complete and confirmed — skip Phase −1 (config bootstrap). `vibe_model.version`, `metamodel_schema` and `metamodel_prefix` are pinned — use them, do not probe for another version.
2. Treat this as a fresh assessment of the `{domain}` domain. Run Phases 0 through 4 (intake, inspect target model,
   profile bronze, model completeness 2C, existing silver/gold integration 3, source-to-target mapping report 4),
   plus the always-on outputs (Gap Registry, `next_vibes.md`). Do not run gold derivation (Mode B) in this run, whatever output_model is — it needs populated silver. Record it as deferred per the skill; no pending decision or blocker for it.
3. STOP before Phase 5 (iteration loop) and Phase 6 (handoff docs). Do not start a build.
4. Strictly read-only on the data layer: SELECT / DESCRIBE / SHOW / information_schema only. Do NOT apply the
   Phase 2C / Step 2.7 metamodel edit or any DDL/DML — write each proposed edit as SQL into
   `docs/design/proposed_metamodel_edits.sql` instead.
5. At every human-in-the-loop gate: do not wait. Take the most conservative default (keep, defer, never drop,
   never add net-new), record the decision you would have asked for in `docs/design/pending_decisions.md`,
   one block per decision in exactly this format, and continue:
   ```
   ### D{n}: {question}
   - Gate: {gate} · Kind: {structure|source|scope} · Entity: {entity} · Blocks build: {yes|no}
   - Context: {2–3 sentences: what the data shows and what the model assumes}
   - Why it matters: {consequence for build / downstream consumers}
   - Options:
     - **{label}** — Pros: {…}; Cons: {…}; Impact: {…}
   - Recommended: {label} — {rationale}
   - Default taken: {label} — {evidence}
   - Affected: {entity.column, entity}
   ```
   In `assessment.json`, `options[]` objects carry pros/cons/impact; `recommended_option` must equal one option's label.
6. Workspace access: the `databricks` CLI is on PATH and already authenticated through the DATABRICKS_HOST /
   DATABRICKS_TOKEN environment variables (do not pass --profile). Run SQL with the statement-execution API against
   SQL warehouse `{warehouse_id}`, e.g.
   `databricks api post /api/2.0/sql/statements --json '{"warehouse_id":"{warehouse_id}","statement":"SELECT 1","wait_timeout":"50s"}'`.
   Notebooks and Spark are not available here; everything goes through SQL.
7. Mapping quality bar (a fast run is not the goal — a correct one is):
   - Decide every source-to-target column mapping yourself, entity by entity, by reading the bronze column names,
     types and sample values. Do not let a name-matching or generator script make mapping decisions; scripts may
     only fetch data and format the documents you have already decided.
   - Map semantically, not by name: SAP/CRM technical columns (e.g. VBELN, ERDAT, NETWR, KUNNR) must be mapped to
     their business targets (order number, created date, net value, sold-to customer) wherever the meaning matches.
   - Bronze is the source of truth for grades. Existing silver/gold (Phase 3) is integration evidence only — never
     use a previously built silver table as the source of a target column.
   - A foreign key must derive from the PARENT's natural key column (e.g. KUNNR for customer), never from the
     child's own primary key. Any FK you cannot source from a real parent key is a gap.
   - Profile what you map: for each mapped column record row count, null %, distinct count, and for dates the
     physical format; for each FK the orphan count against its parent where the parent is in this domain.
   - Before finishing, re-read your S2T report and fix any mapping that violates these rules.
8. Structured detail: after your reports are final, write `docs/design/assessment.json` that validates against
   `assessment.schema.json` at the project root. Derive every value from the reports you already wrote (S2T report,
   Gap Registry, pending_decisions.md, next_vibes.md) — do not re-run analysis to fill it. One `entities[]` row per
   target entity; one `columns[]` row per target column, including gaps.
   Column profile fields come from the S2T column table's `Rows` / `Null %` / `Distinct` / `Date format` / `FK orphans`
   columns: `row_count`, `null_pct`, `distinct_count`, `date_format`, `fk_orphans`. These describe the **target
   projection** — the rows silver will hold for that column.
   Per-source profiles (`profiles_by_source[]`) are **required** when a column has 2+ Populating or Enriching
   systems, or is joined from a table whose grain differs from the target entity; omit them otherwise. Each profile captures
   one `(system, source_table, source_column)` measured **at source grain** in that system's rows only (after row
   filters). Fields: `system` (source name as in Source Ownership section), `source_table` (fully qualified bronze),
   `source_column` (bronze column or expression), `role` (populates | enriches | cross_check), `rows` (source rows),
   `null_pct`, `distinct_count` (measured on source), `fk_orphans` (per-system FK orphans for FK columns only),
   `note` (optional, e.g., "joined at account grain, 1:N to bill").
   Each profile names exactly one system (split "A + B" into two rows) and that system's own table and column,
   never the column-level cell that lists every system. Fill `fk_orphans` on every FK column, `0` included. Leave
   `note` empty unless something needs explaining; never write stock text.
   `gaps[]` has one item per unsourced target column (`entity` + `column`) and one per entity-level finding
   (`column` = `*`), copied from the Gap Registry rows. Never roll several columns into a single bucket item. Every
   non-zero FK orphan count is an `FK_ORPHAN` gap, and every non-zero unmapped crosswalk share is a `CROSSWALK` gap.
   Beyond the base fields, fill these optional ones by COPYING values from the markdown you already wrote:
   - `executive_summary` (`headline`, `verdict` = ready_to_build | iterate_first | blocked, `verdict_reason`,
     `key_findings[]`, `top_risks[]`, `recommended_next_step`) from the `## Executive Summary` of the Domain
     Readiness Summary.
   - Per `entities[]` row, from the S2T grade line `**Grade: {A–F} ({Full|Partial|Blocked})** — Core n/n sourced ·
     Enrichment n/n (pct%) · n Deferred FK · {reason}`: `letter_grade`, `core_sourced`, `core_total`,
     `enrichment_sourced`, `enrichment_total`, `deferred_fk_count`, `grade_reason`, and `row_filter` if the
     report states one. `letter_grade` is the letter you already wrote in the grade line — never recompute it
     differently. The table is: A = gate Full and enrichment_pct ≥ 75; B = Full and 25 ≤ pct < 75; C = Full and
     pct < 25, or Partial with every Core column sourced; D = Partial with a Core column unsourced (a partial
     population is reported as unsourced Core); F = Blocked.
   - Per `entities[]` row, `structure` (sound | review | rework) copied from the `Structure:` part of the grade line.
     Structure is mechanical, never a judgment: `rework` = the entity has an open `Kind: structure` decision with
     `Blocks build: yes`; `review` = it has an open `Kind: structure` decision that does not block, or it is listed
     in the Affected line of a next vibe with Urgency before_build; otherwise `sound`. Open = not yet answered; a
     recorded default is not an answer. A decision applies to its Entity and to every Affected entity.
     | Kind | Use for |
     |---|---|
     | `structure` | the grain, cardinality, FK direction, an entity split or merge, or a missing or extra entity (Phase 2C model completeness, Step 2.7 grain or cardinality assertions) |
     | `source` | source-process fit, proxy sources, or missing ingestion. These already drive the letter (F, D), so they never touch Structure, to avoid double counting |
     | `scope` | cross-domain governance or ownership questions, which don't affect this entity's shape |
   - Per `columns[]` row, `tier` from the S2T `Class` column (core | enrichment | deferred_fk | technical). If `docs/inputs/prior_tiers.json` exists, reuse its tiers per the skill's 'Reuse prior tiers' rule, and record each change in the S2T Tier Changes table.
   - Per `next_vibes[]` item, from its `PRIORITY` block in `next_vibes.md`: `problem` (Problem), `proposed_change`
     (Change), `affected_entities[]` (Affected), `impact_if_skipped` (Impact if skipped), `urgency` (Urgency:
     before_build | during_build | later), `confidence`.
   - Per `pending_decisions[]` item, from its `### D{n}` block in `pending_decisions.md`: `context`,
     `why_it_matters`, `options[]` (`label`, `pros[]`, `cons[]`, `impact`), `recommended_option`,
     `recommendation_rationale`, `blocks_build`, `kind` (the `Kind:` value of the Gate line), `affected[]` (`entity`, `column`).
     List `pending_decisions[]` in D-number order — D1 first, then D2, … with no gaps or renumbering — so index i is
     D{i+1}. Every `Structure: … (Dn)` reference in the S2T grade lines must use these same numbers.
9. Never print environment variables or credentials (tokens, secrets) to the console, logs or any file.
Finish with the structured summary the output schema asks for.
