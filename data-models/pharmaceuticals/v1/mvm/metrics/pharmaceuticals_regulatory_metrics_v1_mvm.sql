-- Metric views for domain: regulatory | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory submission pipeline health, throughput, and review performance across health authorities, therapeutic areas, and submission types. Enables leadership to monitor filing velocity, validation quality, and review clock management."
  source: "`pharmaceuticals_ecm`.`regulatory`.`submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g., NDA, BLA, IND, MAA) used to segment filing activity by regulatory pathway."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the submission, enabling portfolio-level regulatory performance analysis."
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Regulatory pathway (e.g., standard, accelerated, 505(b)(2)) used to assess strategic filing choices."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Calendar year of submission date, used for year-over-year filing trend analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission date for monthly filing cadence tracking."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the submission (e.g., submitted, under review, approved, withdrawn)."
    - name: "review_division"
      expr: review_division
      comment: "Health authority review division handling the submission, used to identify bottlenecks by division."
    - name: "priority_designation"
      expr: priority_designation
      comment: "Priority review designation (e.g., Priority, Standard, Breakthrough) to segment high-urgency filings."
    - name: "dossier_format"
      expr: dossier_format
      comment: "Format of the submitted dossier (e.g., eCTD, NeeS, paper) for format compliance tracking."
    - name: "validation_status"
      expr: validation_status
      comment: "Technical validation outcome of the submission package, used to monitor submission quality."
    - name: "rems_required"
      expr: rems_required
      comment: "Indicates whether a Risk Evaluation and Mitigation Strategy is required for this submission."
    - name: "pai_required"
      expr: pai_required
      comment: "Indicates whether a Pre-Approval Inspection is required, flagging submissions with manufacturing scrutiny."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions filed. Core throughput KPI for regulatory operations."
    - name: "submissions_with_validation_errors"
      expr: COUNT(CASE WHEN validation_status = 'FAILED' THEN 1 END)
      comment: "Number of submissions that failed technical validation. High values indicate dossier quality issues requiring remediation."
    - name: "validation_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN validation_status = 'FAILED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions failing technical validation. A rising rate signals systemic dossier quality degradation."
    - name: "priority_review_submissions"
      expr: COUNT(CASE WHEN priority_designation IN ('Priority', 'Breakthrough', 'PRIME') THEN 1 END)
      comment: "Count of submissions with priority or accelerated review designations, reflecting pipeline strategic value."
    - name: "rems_required_submissions"
      expr: COUNT(CASE WHEN rems_required = TRUE THEN 1 END)
      comment: "Number of submissions requiring a REMS program, indicating risk management burden on the regulatory team."
    - name: "fee_waiver_granted_submissions"
      expr: COUNT(CASE WHEN fee_waiver_granted = TRUE THEN 1 END)
      comment: "Count of submissions where regulatory filing fees were waived, relevant for financial planning and cost tracking."
    - name: "distinct_health_authorities"
      expr: COUNT(DISTINCT health_authority_id)
      comment: "Number of distinct health authorities receiving submissions, reflecting global regulatory footprint breadth."
    - name: "distinct_products_submitted"
      expr: COUNT(DISTINCT drug_product_id)
      comment: "Number of distinct drug products with active submissions, indicating pipeline breadth under regulatory review."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures the regulatory application portfolio across approval pathways, special designations, and review timelines. Enables executives to track pipeline progression, designation leverage, and approval cycle performance."
  source: "`pharmaceuticals_ecm`.`regulatory`.`application`"
  dimensions:
    - name: "application_type"
      expr: application_type
      comment: "Type of regulatory application (e.g., NDA, BLA, ANDA, MAA) for portfolio segmentation."
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (e.g., submitted, under review, approved, withdrawn) for pipeline stage analysis."
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Regulatory pathway selected for the application, used to assess strategic filing approach."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the drug product in the application (e.g., tablet, injection, capsule)."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration (e.g., oral, intravenous, subcutaneous) for product-level segmentation."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the application was submitted, enabling year-over-year pipeline trend analysis."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the application received approval, used for approval cohort analysis."
    - name: "breakthrough_therapy_flag"
      expr: breakthrough_therapy_flag
      comment: "Indicates whether the application has Breakthrough Therapy designation, a key strategic differentiator."
    - name: "fast_track_flag"
      expr: fast_track_flag
      comment: "Indicates Fast Track designation, enabling segmentation of expedited development programs."
    - name: "priority_review_flag"
      expr: priority_review_flag
      comment: "Indicates Priority Review designation, used to track high-urgency applications."
    - name: "orphan_designation_flag"
      expr: orphan_designation_flag
      comment: "Indicates Orphan Drug designation, relevant for rare disease portfolio tracking and incentive management."
    - name: "new_molecular_entity_flag"
      expr: new_molecular_entity_flag
      comment: "Indicates whether the application is for a New Molecular Entity, the highest-value innovation category."
    - name: "rems_required_flag"
      expr: rems_required_flag
      comment: "Indicates whether a REMS program is required, flagging applications with elevated risk management obligations."
    - name: "submission_format"
      expr: submission_format
      comment: "Format of the application submission (e.g., eCTD) for compliance and process tracking."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of regulatory applications in the portfolio. Core pipeline volume KPI."
    - name: "approved_applications"
      expr: COUNT(CASE WHEN application_status = 'APPROVED' THEN 1 END)
      comment: "Number of applications that have received regulatory approval. Key outcome metric for pipeline success."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN application_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications achieving approval. A primary indicator of regulatory strategy effectiveness."
    - name: "breakthrough_therapy_applications"
      expr: COUNT(CASE WHEN breakthrough_therapy_flag = TRUE THEN 1 END)
      comment: "Number of applications with Breakthrough Therapy designation, reflecting the strategic value of the pipeline."
    - name: "new_molecular_entity_applications"
      expr: COUNT(CASE WHEN new_molecular_entity_flag = TRUE THEN 1 END)
      comment: "Count of NME applications, the highest-value innovation category driving long-term revenue and exclusivity."
    - name: "orphan_designation_applications"
      expr: COUNT(CASE WHEN orphan_designation_flag = TRUE THEN 1 END)
      comment: "Number of applications with Orphan Drug designation, relevant for rare disease strategy and incentive tracking."
    - name: "priority_review_applications"
      expr: COUNT(CASE WHEN priority_review_flag = TRUE THEN 1 END)
      comment: "Count of applications under Priority Review, indicating the proportion of the pipeline with expedited timelines."
    - name: "rems_required_applications"
      expr: COUNT(CASE WHEN rems_required_flag = TRUE THEN 1 END)
      comment: "Number of applications requiring a REMS program, quantifying risk management program burden."
    - name: "pai_required_applications"
      expr: COUNT(CASE WHEN pai_required_flag = TRUE THEN 1 END)
      comment: "Count of applications requiring a Pre-Approval Inspection, flagging manufacturing readiness risk."
    - name: "post_approval_commitment_applications"
      expr: COUNT(CASE WHEN post_approval_commitment_flag = TRUE THEN 1 END)
      comment: "Number of applications with post-approval commitments, indicating ongoing regulatory obligations after approval."
    - name: "distinct_health_authorities_applied"
      expr: COUNT(DISTINCT health_authority_id)
      comment: "Number of distinct health authorities to which applications have been filed, measuring global regulatory reach."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the regulatory approval portfolio including approval status, label characteristics, post-approval obligations, and market coverage. Enables executives to monitor approval health, label quality, and compliance obligations across markets."
  source: "`pharmaceuticals_ecm`.`regulatory`.`approval`"
  dimensions:
    - name: "approval_type"
      expr: approval_type
      comment: "Type of regulatory approval (e.g., full, conditional, accelerated) for portfolio segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval (e.g., active, withdrawn, suspended) for portfolio health monitoring."
    - name: "regulatory_region"
      expr: regulatory_region
      comment: "Geographic regulatory region of the approval (e.g., US, EU, APAC) for regional portfolio analysis."
    - name: "approved_dosage_form"
      expr: approved_dosage_form
      comment: "Approved dosage form of the product for product-level segmentation."
    - name: "approved_route_of_administration"
      expr: approved_route_of_administration
      comment: "Approved route of administration for clinical and commercial segmentation."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of approval for cohort and trend analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the approval became effective, used for market entry timeline analysis."
    - name: "orphan_drug_designation"
      expr: orphan_drug_designation
      comment: "Indicates Orphan Drug designation on the approval, relevant for rare disease portfolio tracking."
    - name: "pediatric_indication"
      expr: pediatric_indication
      comment: "Indicates whether the approval covers a pediatric indication, relevant for pediatric exclusivity and compliance."
    - name: "has_rems"
      expr: has_rems
      comment: "Indicates whether the approval requires a REMS program, flagging risk management obligations."
    - name: "review_division"
      expr: review_division
      comment: "Health authority review division that granted the approval, used for division-level performance analysis."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission that led to this approval (e.g., original, supplement, variation)."
  measures:
    - name: "total_approvals"
      expr: COUNT(1)
      comment: "Total number of regulatory approvals in the portfolio. Core measure of commercial authorization breadth."
    - name: "active_approvals"
      expr: COUNT(CASE WHEN approval_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active approvals. Directly reflects the commercially authorized product portfolio."
    - name: "active_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'ACTIVE' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approvals that are currently active. A declining rate signals portfolio attrition risk."
    - name: "rems_required_approvals"
      expr: COUNT(CASE WHEN has_rems = TRUE THEN 1 END)
      comment: "Number of approvals with active REMS requirements, quantifying ongoing risk management program obligations."
    - name: "orphan_drug_approvals"
      expr: COUNT(CASE WHEN orphan_drug_designation = TRUE THEN 1 END)
      comment: "Count of approvals with Orphan Drug designation, tracking rare disease portfolio and associated exclusivity benefits."
    - name: "pediatric_indication_approvals"
      expr: COUNT(CASE WHEN pediatric_indication = TRUE THEN 1 END)
      comment: "Number of approvals covering pediatric indications, relevant for pediatric exclusivity and compliance obligations."
    - name: "distinct_markets_approved"
      expr: COUNT(DISTINCT country_id)
      comment: "Number of distinct markets (countries) with active approvals, measuring global commercial authorization footprint."
    - name: "distinct_products_approved"
      expr: COUNT(DISTINCT drug_product_id)
      comment: "Number of distinct drug products with at least one approval, reflecting the breadth of the authorized portfolio."
    - name: "pai_required_approvals"
      expr: COUNT(CASE WHEN pai_required = TRUE THEN 1 END)
      comment: "Number of approvals with outstanding Pre-Approval Inspection requirements, flagging manufacturing compliance risk."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_variation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors post-approval variation activity including change types, safety-driven changes, labeling updates, and implementation compliance. Enables regulatory and commercial leadership to track label evolution, safety-driven change burden, and variation cycle times."
  source: "`pharmaceuticals_ecm`.`regulatory`.`variation`"
  dimensions:
    - name: "variation_type"
      expr: variation_type
      comment: "Type of variation (e.g., Type IA, Type IB, Type II, Major, Minor) for regulatory complexity segmentation."
    - name: "variation_status"
      expr: variation_status
      comment: "Current status of the variation (e.g., submitted, approved, withdrawn) for pipeline stage analysis."
    - name: "change_category"
      expr: change_category
      comment: "Category of the change being made (e.g., CMC, labeling, clinical) for workload analysis by change type."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the product being varied, enabling portfolio-level variation burden analysis."
    - name: "is_safety_driven"
      expr: is_safety_driven
      comment: "Indicates whether the variation is driven by a safety signal, a critical flag for pharmacovigilance-regulatory integration."
    - name: "is_labeling_change"
      expr: is_labeling_change
      comment: "Indicates whether the variation involves a labeling change, relevant for commercial and medical affairs impact."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Status of variation implementation (e.g., pending, in progress, completed) for compliance tracking."
    - name: "regulatory_basis"
      expr: regulatory_basis
      comment: "Regulatory basis for the variation (e.g., Article 61(3), CBE-30) for procedural compliance analysis."
    - name: "acceptance_year"
      expr: YEAR(acceptance_date)
      comment: "Year the variation was accepted by the health authority, used for annual variation volume trending."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the variation was approved, used for approval cycle time cohort analysis."
    - name: "is_grouped"
      expr: is_grouped
      comment: "Indicates whether the variation is part of a grouped submission, relevant for filing efficiency analysis."
  measures:
    - name: "total_variations"
      expr: COUNT(1)
      comment: "Total number of post-approval variations filed. Core measure of post-approval regulatory workload."
    - name: "approved_variations"
      expr: COUNT(CASE WHEN variation_status = 'APPROVED' THEN 1 END)
      comment: "Number of variations that have received regulatory approval. Measures post-approval change execution success."
    - name: "variation_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN variation_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of variations achieving approval. A declining rate may indicate quality or strategy issues."
    - name: "safety_driven_variations"
      expr: COUNT(CASE WHEN is_safety_driven = TRUE THEN 1 END)
      comment: "Number of variations driven by safety signals. A rising count indicates increasing pharmacovigilance-driven regulatory burden."
    - name: "safety_driven_variation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_safety_driven = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of variations that are safety-driven. A key risk indicator for product safety profile management."
    - name: "labeling_change_variations"
      expr: COUNT(CASE WHEN is_labeling_change = TRUE THEN 1 END)
      comment: "Number of variations involving labeling changes, quantifying label evolution activity and commercial impact."
    - name: "pending_implementation_variations"
      expr: COUNT(CASE WHEN implementation_status IN ('PENDING', 'IN_PROGRESS') THEN 1 END)
      comment: "Number of approved variations not yet fully implemented. A high backlog signals compliance risk."
    - name: "distinct_products_with_variations"
      expr: COUNT(DISTINCT drug_product_id)
      comment: "Number of distinct drug products with post-approval variation activity, measuring portfolio-wide change burden."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_post_approval_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks post-approval commitment fulfillment, overdue obligations, and pediatric and REMS-related commitments. Enables regulatory and compliance leadership to manage FDA/EMA-mandated obligations and avoid enforcement actions."
  source: "`pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment`"
  dimensions:
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of post-approval commitment (e.g., PMR, PMC, PASS) for obligation category analysis."
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current fulfillment status of the commitment (e.g., pending, ongoing, fulfilled, overdue) for compliance monitoring."
    - name: "commitment_category"
      expr: commitment_category
      comment: "Category of the commitment (e.g., clinical, CMC, labeling) for workload distribution analysis."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the commitment for portfolio-level obligation tracking."
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Regulatory agency that issued the commitment (e.g., FDA, EMA) for agency-level compliance tracking."
    - name: "is_pediatric_commitment"
      expr: is_pediatric_commitment
      comment: "Indicates whether the commitment is a pediatric study requirement (PMR/PMC), relevant for PREA compliance."
    - name: "is_rems_related"
      expr: is_rems_related
      comment: "Indicates whether the commitment is related to a REMS program, flagging risk management obligations."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the commitment (e.g., high, medium, low) for resource allocation decisions."
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable required (e.g., study report, protocol, labeling update) for workload planning."
    - name: "original_due_year"
      expr: YEAR(original_due_date)
      comment: "Year the commitment was originally due, used for aging and overdue analysis."
    - name: "responsible_function"
      expr: responsible_function
      comment: "Internal function responsible for fulfilling the commitment (e.g., Clinical, CMC, Regulatory Affairs)."
  measures:
    - name: "total_commitments"
      expr: COUNT(1)
      comment: "Total number of post-approval commitments. Core measure of regulatory obligation portfolio size."
    - name: "fulfilled_commitments"
      expr: COUNT(CASE WHEN commitment_status = 'FULFILLED' THEN 1 END)
      comment: "Number of commitments successfully fulfilled. Measures regulatory compliance execution effectiveness."
    - name: "commitment_fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN commitment_status = 'FULFILLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of post-approval commitments fulfilled. A critical compliance KPI monitored by regulatory agencies."
    - name: "overdue_commitments"
      expr: COUNT(CASE WHEN commitment_status = 'OVERDUE' THEN 1 END)
      comment: "Number of commitments past their due date. A high count signals enforcement risk and agency relationship strain."
    - name: "overdue_commitment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN commitment_status = 'OVERDUE' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of commitments that are overdue. A rising rate is a leading indicator of regulatory enforcement risk."
    - name: "pediatric_commitments"
      expr: COUNT(CASE WHEN is_pediatric_commitment = TRUE THEN 1 END)
      comment: "Number of pediatric post-approval commitments (PMR/PMC), tracking PREA compliance obligations."
    - name: "rems_related_commitments"
      expr: COUNT(CASE WHEN is_rems_related = TRUE THEN 1 END)
      comment: "Number of commitments tied to REMS programs, quantifying risk management program maintenance burden."
    - name: "high_priority_open_commitments"
      expr: COUNT(CASE WHEN priority_level = 'HIGH' AND commitment_status NOT IN ('FULFILLED', 'WITHDRAWN') THEN 1 END)
      comment: "Number of high-priority commitments not yet fulfilled. A key executive escalation metric for compliance risk."
    - name: "distinct_products_with_commitments"
      expr: COUNT(DISTINCT drug_product_id)
      comment: "Number of distinct drug products with active post-approval commitments, measuring portfolio-wide obligation breadth."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_designation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks special regulatory designations (Orphan, Breakthrough, Fast Track, PRIME, Sakigake) across the pipeline. Enables executives to quantify designation leverage, exclusivity benefits, and strategic pathway utilization."
  source: "`pharmaceuticals_ecm`.`regulatory`.`designation`"
  dimensions:
    - name: "designation_type"
      expr: designation_type
      comment: "Type of regulatory designation (e.g., Orphan Drug, Breakthrough Therapy, Fast Track, PRIME) for portfolio segmentation."
    - name: "designation_status"
      expr: designation_status
      comment: "Current status of the designation (e.g., granted, withdrawn, pending) for active designation tracking."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the designation for portfolio-level strategic analysis."
    - name: "development_phase"
      expr: development_phase
      comment: "Development phase at which the designation was granted (e.g., Phase 1, Phase 2) for pipeline stage analysis."
    - name: "strategic_importance"
      expr: strategic_importance
      comment: "Internal strategic importance rating of the designation for prioritization and resource allocation."
    - name: "accelerated_approval_pathway"
      expr: accelerated_approval_pathway
      comment: "Indicates whether the designation enables an accelerated approval pathway, a key strategic differentiator."
    - name: "confirmatory_trial_required"
      expr: confirmatory_trial_required
      comment: "Indicates whether a confirmatory trial is required post-designation, flagging ongoing clinical obligations."
    - name: "priority_review_voucher_eligible"
      expr: priority_review_voucher_eligible
      comment: "Indicates eligibility for a Priority Review Voucher, which has significant monetizable value."
    - name: "grant_year"
      expr: YEAR(grant_date)
      comment: "Year the designation was granted, used for annual designation activity trending."
    - name: "rolling_review_enabled"
      expr: rolling_review_enabled
      comment: "Indicates whether rolling review is enabled under this designation, accelerating the review timeline."
  measures:
    - name: "total_designations"
      expr: COUNT(1)
      comment: "Total number of regulatory designations granted. Measures the breadth of special pathway utilization across the pipeline."
    - name: "active_designations"
      expr: COUNT(CASE WHEN designation_status = 'GRANTED' THEN 1 END)
      comment: "Number of currently active (granted) designations. Reflects the pipeline's current strategic designation leverage."
    - name: "withdrawn_designations"
      expr: COUNT(CASE WHEN designation_status = 'WITHDRAWN' THEN 1 END)
      comment: "Number of designations that have been withdrawn. A rising count may signal pipeline attrition or strategy failures."
    - name: "designation_retention_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN designation_status = 'GRANTED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of designations that remain active (not withdrawn or expired). Measures designation strategy durability."
    - name: "priority_review_voucher_eligible_designations"
      expr: COUNT(CASE WHEN priority_review_voucher_eligible = TRUE THEN 1 END)
      comment: "Number of designations eligible for a Priority Review Voucher. PRVs have significant monetizable value (>$100M)."
    - name: "confirmatory_trial_required_designations"
      expr: COUNT(CASE WHEN confirmatory_trial_required = TRUE THEN 1 END)
      comment: "Number of designations requiring confirmatory trials, quantifying ongoing clinical commitment burden."
    - name: "avg_exclusivity_period_years"
      expr: ROUND(AVG(CAST(exclusivity_period_years AS DOUBLE)), 2)
      comment: "Average exclusivity period (in years) granted across designations. Longer exclusivity directly protects revenue."
    - name: "total_exclusivity_years_granted"
      expr: ROUND(SUM(CAST(exclusivity_period_years AS DOUBLE)), 2)
      comment: "Total exclusivity years granted across all designations. A proxy for the aggregate IP protection value of the pipeline."
    - name: "distinct_products_with_designations"
      expr: COUNT(DISTINCT medicinal_product_id)
      comment: "Number of distinct medicinal products with at least one regulatory designation, measuring pipeline designation coverage."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory milestone achievement, schedule adherence, and critical path performance across the development and approval lifecycle. Enables program management and executives to monitor timeline risk and regulatory execution quality."
  source: "`pharmaceuticals_ecm`.`regulatory`.`milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of regulatory milestone (e.g., submission, approval, PDUFA date, meeting) for lifecycle stage analysis."
    - name: "milestone_category"
      expr: milestone_category
      comment: "Category of the milestone (e.g., filing, review, approval, post-approval) for portfolio stage segmentation."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g., planned, completed, delayed, at-risk) for execution monitoring."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the milestone for portfolio-level timeline analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the milestone is on the critical path, used to prioritize escalation and resource allocation."
    - name: "meeting_type"
      expr: meeting_type
      comment: "Type of health authority meeting (e.g., Type A, Type B, Type C, pre-BLA) for interaction planning."
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Year the milestone was planned, used for annual planning and forecast accuracy analysis."
    - name: "actual_year"
      expr: YEAR(actual_date)
      comment: "Year the milestone was actually completed, used for plan-vs-actual timeline analysis."
    - name: "responsible_owner"
      expr: responsible_owner
      comment: "Internal owner responsible for the milestone, used for accountability and workload analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of regulatory milestones tracked. Core measure of regulatory program activity volume."
    - name: "completed_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'COMPLETED' THEN 1 END)
      comment: "Number of milestones successfully completed. Measures regulatory execution throughput."
    - name: "milestone_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones completed. A primary indicator of regulatory program execution effectiveness."
    - name: "delayed_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'DELAYED' THEN 1 END)
      comment: "Number of milestones that are delayed. A rising count is a leading indicator of approval timeline risk."
    - name: "critical_path_milestones"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of milestones on the critical path. Used to focus executive attention on highest-impact timeline risks."
    - name: "critical_path_delayed_milestones"
      expr: COUNT(CASE WHEN is_critical_path = TRUE AND milestone_status = 'DELAYED' THEN 1 END)
      comment: "Number of critical path milestones that are delayed. The highest-urgency regulatory timeline risk indicator."
    - name: "critical_path_delay_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical_path = TRUE AND milestone_status = 'DELAYED' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of critical path milestones that are delayed. Directly predicts approval date slippage risk."
    - name: "distinct_products_with_active_milestones"
      expr: COUNT(DISTINCT medicinal_product_id)
      comment: "Number of distinct medicinal products with active regulatory milestones, measuring active pipeline breadth."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_product_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the global product registration portfolio including registration status, renewal obligations, and market coverage. Enables commercial and regulatory leadership to manage market authorization continuity and renewal compliance."
  source: "`pharmaceuticals_ecm`.`regulatory`.`product_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the product registration (e.g., active, expired, withdrawn, suspended) for portfolio health monitoring."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the registered product for portfolio-level market coverage analysis."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the registered product for product-level segmentation."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration of the registered product."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of registration renewal (e.g., standard, conditional) for renewal process analysis."
    - name: "renewal_fee_status"
      expr: renewal_fee_status
      comment: "Status of the renewal fee payment (e.g., paid, outstanding, waived) for financial compliance tracking."
    - name: "renewal_outcome"
      expr: renewal_outcome
      comment: "Outcome of the most recent renewal (e.g., approved, refused, pending) for renewal success analysis."
    - name: "orphan_designation_flag"
      expr: orphan_designation_flag
      comment: "Indicates Orphan Drug designation on the registration for rare disease portfolio tracking."
    - name: "rems_required_flag"
      expr: rems_required_flag
      comment: "Indicates whether a REMS program is required for this registration."
    - name: "registration_year"
      expr: YEAR(registration_date)
      comment: "Year of initial registration for cohort and market entry trend analysis."
    - name: "renewal_fee_currency"
      expr: renewal_fee_currency
      comment: "Currency of the renewal fee for multi-currency financial analysis."
  measures:
    - name: "total_registrations"
      expr: COUNT(1)
      comment: "Total number of product registrations in the global portfolio. Core measure of market authorization breadth."
    - name: "active_registrations"
      expr: COUNT(CASE WHEN registration_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active product registrations. Directly reflects the commercially authorized market footprint."
    - name: "active_registration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN registration_status = 'ACTIVE' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrations that are currently active. A declining rate signals market authorization attrition."
    - name: "expired_registrations"
      expr: COUNT(CASE WHEN registration_status = 'EXPIRED' THEN 1 END)
      comment: "Number of expired registrations. Expired registrations represent lost market access and revenue risk."
    - name: "total_renewal_fees"
      expr: ROUND(SUM(CAST(renewal_fee_amount AS DOUBLE)), 2)
      comment: "Total renewal fees across all registrations. Key input for regulatory budget planning and cost management."
    - name: "avg_renewal_fee_amount"
      expr: ROUND(AVG(CAST(renewal_fee_amount AS DOUBLE)), 2)
      comment: "Average renewal fee per registration. Used for per-market cost benchmarking and budget forecasting."
    - name: "distinct_markets_registered"
      expr: COUNT(DISTINCT country_id)
      comment: "Number of distinct countries with active product registrations, measuring global commercial market coverage."
    - name: "distinct_products_registered"
      expr: COUNT(DISTINCT drug_product_id)
      comment: "Number of distinct drug products with at least one registration, measuring portfolio commercial authorization breadth."
    - name: "post_approval_commitment_registrations"
      expr: COUNT(CASE WHEN post_approval_commitment_flag = TRUE THEN 1 END)
      comment: "Number of registrations with outstanding post-approval commitments, quantifying ongoing regulatory obligations."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_rems`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks Risk Evaluation and Mitigation Strategy (REMS) programs including program elements, assessment compliance, and modification activity. Enables regulatory and safety leadership to manage REMS obligations and patient safety program performance."
  source: "`pharmaceuticals_ecm`.`regulatory`.`rems`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the REMS program (e.g., active, under review, withdrawn) for portfolio monitoring."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the REMS program for portfolio-level risk management analysis."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the product under REMS for product-level segmentation."
    - name: "has_etasu"
      expr: has_etasu
      comment: "Indicates whether the REMS includes Elements to Assure Safe Use (ETASU), the most restrictive REMS element."
    - name: "has_medication_guide"
      expr: has_medication_guide
      comment: "Indicates whether the REMS requires a Medication Guide for patient communication."
    - name: "has_communication_plan"
      expr: has_communication_plan
      comment: "Indicates whether the REMS includes a healthcare provider communication plan."
    - name: "requires_certified_prescriber"
      expr: requires_certified_prescriber
      comment: "Indicates whether prescribers must be certified to prescribe the product, a significant access restriction."
    - name: "requires_certified_pharmacy"
      expr: requires_certified_pharmacy
      comment: "Indicates whether pharmacies must be certified to dispense the product, a significant distribution restriction."
    - name: "requires_patient_enrollment"
      expr: requires_patient_enrollment
      comment: "Indicates whether patients must be enrolled in the REMS program before receiving the product."
    - name: "requires_lab_monitoring"
      expr: requires_lab_monitoring
      comment: "Indicates whether the REMS requires laboratory monitoring, adding clinical burden to prescribers."
    - name: "shared_rems_indicator"
      expr: shared_rems_indicator
      comment: "Indicates whether this is a shared REMS program across multiple sponsors, relevant for collaboration management."
    - name: "last_assessment_outcome"
      expr: last_assessment_outcome
      comment: "Outcome of the most recent REMS assessment (e.g., approved, modification required) for compliance tracking."
  measures:
    - name: "total_rems_programs"
      expr: COUNT(1)
      comment: "Total number of REMS programs managed. Core measure of risk management program portfolio size."
    - name: "active_rems_programs"
      expr: COUNT(CASE WHEN program_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active REMS programs. Reflects the ongoing patient safety program management burden."
    - name: "etasu_rems_programs"
      expr: COUNT(CASE WHEN has_etasu = TRUE THEN 1 END)
      comment: "Number of REMS programs with ETASU elements. ETASU programs are the most restrictive and operationally complex."
    - name: "etasu_rems_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_etasu = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of REMS programs with ETASU elements. A high rate indicates significant patient access and operational complexity."
    - name: "certified_prescriber_required_programs"
      expr: COUNT(CASE WHEN requires_certified_prescriber = TRUE THEN 1 END)
      comment: "Number of REMS programs requiring prescriber certification. Directly impacts prescriber access and commercial uptake."
    - name: "patient_enrollment_required_programs"
      expr: COUNT(CASE WHEN requires_patient_enrollment = TRUE THEN 1 END)
      comment: "Number of REMS programs requiring patient enrollment. A key metric for patient access program management."
    - name: "distinct_products_with_rems"
      expr: COUNT(DISTINCT drug_product_id)
      comment: "Number of distinct drug products with active REMS programs, measuring the breadth of risk management obligations."
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`regulatory_label_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks label change activity including safety-driven changes, black box warning additions, REMS-related changes, and implementation compliance. Enables regulatory, safety, and commercial leadership to monitor label evolution risk and compliance."
  source: "`pharmaceuticals_ecm`.`regulatory`.`label_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of label change (e.g., safety update, new indication, dosing change) for change category analysis."
    - name: "change_status"
      expr: change_status
      comment: "Current status of the label change (e.g., pending, approved, implemented) for pipeline tracking."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the product with the label change for portfolio-level analysis."
    - name: "initiator_type"
      expr: initiator_type
      comment: "Who initiated the label change (e.g., FDA, sponsor, safety signal) for root cause analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the label change (e.g., urgent, routine) for prioritization and resource allocation."
    - name: "is_pv_driven"
      expr: is_pv_driven
      comment: "Indicates whether the label change is driven by pharmacovigilance findings, a key safety signal indicator."
    - name: "is_black_box_warning"
      expr: is_black_box_warning
      comment: "Indicates whether the change adds or modifies a black box warning, the most serious safety label change."
    - name: "is_rems_related"
      expr: is_rems_related
      comment: "Indicates whether the label change is related to a REMS program modification."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Status of label change implementation (e.g., pending, in progress, completed) for compliance tracking."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the label change became effective, used for annual label change volume trending."
    - name: "regulatory_basis"
      expr: regulatory_basis
      comment: "Regulatory basis for the label change (e.g., CBE-30, PAS, Article 61(3)) for procedural compliance analysis."
  measures:
    - name: "total_label_changes"
      expr: COUNT(1)
      comment: "Total number of label changes. Core measure of label evolution activity and regulatory workload."
    - name: "pv_driven_label_changes"
      expr: COUNT(CASE WHEN is_pv_driven = TRUE THEN 1 END)
      comment: "Number of label changes driven by pharmacovigilance findings. A rising count signals increasing product safety concerns."
    - name: "pv_driven_label_change_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_pv_driven = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of label changes that are pharmacovigilance-driven. A key safety risk indicator for the product portfolio."
    - name: "black_box_warning_changes"
      expr: COUNT(CASE WHEN is_black_box_warning = TRUE THEN 1 END)
      comment: "Number of label changes involving black box warnings. The most serious safety label changes with significant commercial impact."
    - name: "urgent_label_changes"
      expr: COUNT(CASE WHEN urgency_level = 'URGENT' THEN 1 END)
      comment: "Number of urgent label changes requiring expedited implementation. High counts indicate elevated safety risk management burden."
    - name: "pending_implementation_label_changes"
      expr: COUNT(CASE WHEN implementation_status IN ('PENDING', 'IN_PROGRESS') THEN 1 END)
      comment: "Number of approved label changes not yet fully implemented. A compliance risk indicator for regulatory agencies."
    - name: "distinct_products_with_label_changes"
      expr: COUNT(DISTINCT drug_product_id)
      comment: "Number of distinct drug products with label change activity, measuring portfolio-wide label evolution breadth."
$$;
