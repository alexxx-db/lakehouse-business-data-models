**Model Quality Score: {N}/100**

**PRIORITY {n} — {action}: {target}**
- Problem: {what is wrong in the model, in business terms}
- Change: {the exact model edit}
- Affected: {entity, entity}
- Impact if skipped: {what breaks or degrades downstream if you build without this}
- Urgency: {before_build | during_build | later}
- Confidence: {0–1}
- Decision: {D{n} from pending_decisions.md — accepting this vibe answers it | — (static analysis only)}

(Repeat the block for each priority.)

<!-- actions: connect_table | remove_fk | rename_product | rename_attribute | add_column |
     remove_product | remove_attribute — coherence/additions only; NEVER "drop for no data" -->

Other known issues from static analysis ({M}):
  - {finding}

Recommendation: {iterate before build | proceed to build} — {one-sentence reason, naming the before_build priorities}

How to use this file: edit, drop or keep each priority, then run the vibe. That answers every
structure decision named on a `Decision:` line. Re-assess on the new model version. Source decisions
in `pending_decisions.md` wait until that re-assessment shows every entity Structure: Sound.

Deterministic score: {N}/100
<!-- Perfect-model case: emit with a high score, zero/low PRIORITY lines, and the line:
     "No structural refinements recommended; the model is coherent against the profiled data." -->

<!-- A before_build priority puts every entity in its Affected line at Structure: Review (source-to-target-mapping.md "Structure"). -->
