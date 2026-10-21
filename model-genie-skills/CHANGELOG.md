# Changelog

All notable changes to the vibe-model-skills suite are documented here.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); the suite
follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.5.0] - 2026-10-21
### Added
- multi-hop FK resolution, single-valued FK fan-in check, prior-tier reuse
- link decisions to next vibes; verdict names the next action
- per-source profiles for multi-system and different-grain columns
- per-system FK probes, unit/code conformance, crosswalk-gap classification
- Structure axis (Sound / Review / Rework) next to the letter; decision Kind
- unattended branch for human gates — record conservative defaults in pending_decisions, never as confirmation
- defer Mode B until silver is populated; dedup qualified product rows; S2T profile columns + derived-expression profiling
- source ownership step (2.3b), FK deferral rules, source roles in S2T
- letter grade, S2T Class column, next-vibe urgency, executive summary

### Fixed
- per-source profile row rules, Deferred FK for wrong Core FKs, orphan/crosswalk/gap sections kept
- hybrid first pass writes only the gold deferral line
- scorecard Grade cells carry the letter; partial population counts as a Core gap (D)
- grade by Core/Enrichment tiers, value-semantics probes, source-process fit

### Documentation
- polish README to the industry-solutions house style
- clean README to match industry-solutions house style## [0.4.0] - 2026-09-04
### Added
- emit improvement-recommendations file at closeout
- add shared commentary-emission protocol + persist/verify principles
- sales_order_mvm worked example + live-run skill fixes (#49)

### Fixed
- keep empty changelog sections from aborting the release
- order commentary emission as the final Self-Audit obligation
- add project-relative-path rule, gold-existence + ownership gates, e2e Model-Guide run, and emit improvement-recommendations at closeout
- apply Genie-query + Model-Guide session-feedback rules (column-dict reads, FK COMMENTs, sandbox gaps, Genie name, dual-links, SQL notebook)
- apply session-feedback rules (persist, aggregate isolation, verify pass, live-query handoff, widget templates) + emit improvement-recommendations at closeout

### Documentation
- document the per-skill commentary-emission convention
- implementation plan for skill commentary + feedback fixes
- spec for skill commentary emission + session-feedback fixes
- add workflow map with getting-started and post-assessment diagrams## [0.3.0] - 2026-09-02
### Added
- config bootstrap, opt-in model deviation, always-on next_vibes (#45)

### Changed
- extract phase protocols into phase-protocol.md (#47)
- split Phase 2B/2C out of discovery-protocol.md (#46)## [0.2.0] - 2026-09-01
### Added
- honor null_columns drop at DDL — omit column with mandatory NULL_SOURCE gap row
- confirmation-only reconciliation for typed handoff + NULL_SOURCE gap class
- mandate complete typed handoff (§2/§3), formula refs, NULL_SOURCE registry rows
- carry target type + probe every mapped column for all-null at 2.4b
- S2T carries target type, FK Lookup, per-FK table, NULL_SOURCE gap + disposition
- typed complete handoff spec — FK Lookup, Null Disposition, per-FK table, formula pointer
- add NULL_SOURCE gap type + kept-null accepted-exception rule
- add null_columns disposition knob + NULL_SOURCE gap type
- entity-first hardening of the ETL build skill (#42)
- harden ETL framework from two sales_order build reports (#41)

### Fixed
- address /code-review — §3 owner column, FK heading, grade-axis + all-null-key clarity
- clarify §3 Values-verified ownership, §2 NULL_SOURCE Notes marker, no-silent-descope vs NULL_SOURCE drop
- correct (intra/cross) parenthetical in §3 handoff row

### Documentation
- add design spec + implementation plan for handoff hardening + null columns

### Changed
- nimble, single-source ETL build skill (#44)## [0.1.0] - 2026-08-30
### Added
- Initial public release of the vibe-model-skills suite: the four-station modeling loop
  (`domain-model-assessment` → `etl-development-framework` → `domain-model-validation` →
  `domain-documentation`) plus the cross-cutting `autonomous-validation` and steady-state
  `domain-sync` skills, the `conventions.yml` config surface with its six `etl_type` ×
  `output_model` variants, and the runnable Meridian example dataset.
