-- Metric views for domain: quality | Business: Construction | Version: 2 | Generated on: 2026-06-27 01:50:09

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational quality inspection KPIs tracking pass/fail outcomes, defect rates, reinspection burden, and environmental conditions across all site inspections. Used by Quality Managers and Project Directors to steer inspection performance and identify systemic failure patterns."
  source: "`vibe_construction_v1`.`quality`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g. pre-pour, structural, electrical) — primary grouping for quality performance analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g. Pending, Completed, Rejected) — used to filter active vs closed inspections."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final pass/fail/conditional outcome of the inspection — key dimension for quality outcome trending."
    - name: "location_type"
      expr: location_type
      comment: "Type of site location inspected (e.g. structural zone, MEP corridor) — enables spatial quality analysis."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection date — supports time-series trending of inspection volumes and outcomes."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether a corrective action was mandated from this inspection — used to segment high-risk inspections."
    - name: "ncr_raised"
      expr: ncr_raised
      comment: "Flag indicating whether a Non-Conformance Report was raised during this inspection — critical quality signal."
    - name: "reinspection_required"
      expr: reinspection_required
      comment: "Flag indicating whether a reinspection was required — proxy for first-time quality failure rate."
    - name: "inspector_certification"
      expr: inspector_certification
      comment: "Certification level of the inspector — enables quality outcome analysis by inspector qualification tier."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections conducted. Baseline volume metric for quality activity tracking."
    - name: "inspections_with_ncr"
      expr: COUNT(CASE WHEN ncr_raised = TRUE THEN inspection_id END)
      comment: "Count of inspections that resulted in a Non-Conformance Report being raised. Directly measures quality failure events."
    - name: "ncr_raise_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_raised = TRUE THEN inspection_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that triggered an NCR. Key quality KPI — high rates signal systemic workmanship or process failures requiring executive intervention."
    - name: "reinspection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reinspection_required = TRUE THEN inspection_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring reinspection. Measures first-time quality pass rate — a core construction quality efficiency KPI."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN inspection_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections mandating corrective action. Indicates the proportion of inspections revealing non-compliant work requiring remediation."
    - name: "avg_temperature_celsius"
      expr: ROUND(AVG(CAST(temperature_celsius AS DOUBLE)), 2)
      comment: "Average ambient temperature at time of inspection. Environmental context metric — extreme temperatures correlate with concrete and material quality failures."
    - name: "avg_humidity_percent"
      expr: ROUND(AVG(CAST(humidity_percent AS DOUBLE)), 2)
      comment: "Average humidity at time of inspection. Environmental quality control metric — high humidity impacts curing, coatings, and electrical work quality."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-Conformance Report (NCR) KPIs measuring the volume, cost impact, severity distribution, and closure performance of quality non-conformances. Used by Quality Directors, Project Managers, and Clients to assess quality risk exposure and corrective action effectiveness."
  source: "`vibe_construction_v1`.`quality`.`ncr`"
  dimensions:
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current lifecycle status of the NCR (e.g. Open, Under Review, Closed) — primary filter for active quality risk exposure."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the non-conformance (e.g. Critical, Major, Minor) — essential for risk-weighted quality reporting."
    - name: "category"
      expr: category
      comment: "Category of non-conformance (e.g. Material, Workmanship, Design) — enables root-cause category analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or trade discipline associated with the NCR (e.g. Civil, Structural, MEP) — supports discipline-level quality benchmarking."
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the NCR (e.g. Repair, Replace, Accept-as-is, Reject) — indicates remediation strategy and cost implications."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the NCR was identified — supports time-series trending of non-conformance occurrence rates."
    - name: "hold_status"
      expr: hold_status
      comment: "Whether the NCR has placed work on hold — critical operational flag indicating active production blockage."
    - name: "is_systemic_issue_flag"
      expr: CASE WHEN root_cause_analysis IS NOT NULL AND root_cause_analysis != '' THEN TRUE ELSE FALSE END
      comment: "Derived flag indicating whether a root cause analysis has been documented, as a proxy for systemic issue identification."
    - name: "cost_impact_currency"
      expr: cost_impact_currency
      comment: "Currency of the estimated cost impact — required for multi-currency quality cost reporting."
  measures:
    - name: "total_ncrs"
      expr: COUNT(1)
      comment: "Total number of Non-Conformance Reports raised. Baseline quality failure volume metric used in all quality dashboards."
    - name: "open_ncrs"
      expr: COUNT(CASE WHEN ncr_status != 'Closed' THEN ncr_id END)
      comment: "Count of NCRs not yet closed. Measures active quality risk backlog — a key executive quality health indicator."
    - name: "ncr_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_status = 'Closed' THEN ncr_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NCRs that have been closed. Measures quality management effectiveness and backlog clearance rate."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated financial cost of all non-conformances. Directly quantifies quality failure cost exposure for executive and client reporting."
    - name: "avg_estimated_cost_impact"
      expr: ROUND(AVG(CAST(estimated_cost_impact AS DOUBLE)), 2)
      comment: "Average estimated cost impact per NCR. Benchmarks the typical cost of a quality failure — used to prioritise prevention investment."
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total quantity of material or work affected by non-conformances. Measures the physical scale of quality failures beyond financial cost."
    - name: "ncrs_on_hold"
      expr: COUNT(CASE WHEN hold_status = TRUE THEN ncr_id END)
      comment: "Count of NCRs currently placing work on hold. Measures active production blockage caused by quality failures — directly impacts schedule."
    - name: "critical_ncrs"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN ncr_id END)
      comment: "Count of NCRs classified as Critical severity. Highest-priority quality risk metric — triggers immediate executive escalation."
    - name: "ncrs_requiring_client_notification"
      expr: COUNT(CASE WHEN client_notification_required = TRUE THEN ncr_id END)
      comment: "Count of NCRs requiring client notification. Measures client-facing quality exposure and contractual notification obligations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action KPIs measuring cost, timeliness, effectiveness, and closure performance of quality remediation activities. Used by Quality Managers and Finance to track remediation spend and verify that corrective actions are preventing recurrence."
  source: "`vibe_construction_v1`.`quality`.`corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (e.g. Open, In Progress, Closed, Overdue) — primary lifecycle dimension."
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (e.g. Rework, Repair, Replace, Process Change) — enables cost and effort analysis by remediation strategy."
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action — used to assess whether high-priority remediations are being resolved faster."
    - name: "effectiveness_review_outcome"
      expr: effectiveness_review_outcome
      comment: "Outcome of the effectiveness review (e.g. Effective, Partially Effective, Ineffective) — measures whether corrective actions are actually preventing recurrence."
    - name: "is_systemic_issue"
      expr: is_systemic_issue
      comment: "Flag indicating whether the corrective action addresses a systemic (recurring) issue — critical for quality improvement programme prioritisation."
    - name: "requires_design_change"
      expr: requires_design_change
      comment: "Flag indicating whether the corrective action requires a design change — signals design-origin quality failures with broader project impact."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of corrective action costs — required for multi-currency financial reporting."
    - name: "assigned_date_month"
      expr: DATE_TRUNC('MONTH', assigned_date)
      comment: "Month the corrective action was assigned — supports time-series analysis of remediation workload."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions raised. Baseline remediation activity volume metric."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred on corrective actions. Measures the true financial cost of quality failures — a key quality economics KPI."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of corrective actions. Used alongside actual cost to measure cost estimation accuracy for quality remediation."
    - name: "avg_actual_cost"
      expr: ROUND(AVG(CAST(actual_cost AS DOUBLE)), 2)
      comment: "Average actual cost per corrective action. Benchmarks remediation cost per event — used to set quality cost budgets."
    - name: "cost_overrun_total"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(cost_estimate AS DOUBLE))
      comment: "Total cost overrun across all corrective actions (actual minus estimate). Measures quality remediation budget discipline and estimation accuracy."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN action_status != 'Closed' THEN corrective_action_id END)
      comment: "Count of corrective actions not yet closed. Measures active remediation backlog — a key quality risk exposure indicator."
    - name: "effectiveness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_review_outcome = 'Effective' THEN corrective_action_id END) / NULLIF(COUNT(CASE WHEN effectiveness_review_outcome IS NOT NULL THEN corrective_action_id END), 0), 2)
      comment: "Percentage of reviewed corrective actions rated as Effective. Measures whether quality remediation is actually preventing recurrence — a leading quality improvement KPI."
    - name: "systemic_issue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_systemic_issue = TRUE THEN corrective_action_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions addressing systemic issues. High rates indicate recurring quality failures requiring process-level intervention."
    - name: "requires_client_approval_count"
      expr: COUNT(CASE WHEN requires_client_approval = TRUE THEN corrective_action_id END)
      comment: "Count of corrective actions requiring client approval. Measures client-facing remediation exposure and potential schedule dependency on client sign-off."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_punch_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch list item KPIs measuring pre-handover defect volumes, cost impact, closure rates, and DLP deferral rates. Used by Project Directors and Commissioning Managers to ensure handover readiness and manage defect liability exposure."
  source: "`vibe_construction_v1`.`quality`.`punch_item`"
  dimensions:
    - name: "punch_item_status"
      expr: punch_item_status
      comment: "Current status of the punch item (e.g. Open, Closed, Deferred) — primary lifecycle dimension for handover readiness tracking."
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the punch item — used to distinguish formally closed items from those still pending verification."
    - name: "category"
      expr: category
      comment: "Category of the punch item defect (e.g. Structural, Finishing, MEP) — enables defect type analysis for targeted remediation."
    - name: "priority"
      expr: priority
      comment: "Priority level of the punch item — used to assess whether critical pre-handover defects are being resolved on time."
    - name: "deferred_to_dlp"
      expr: deferred_to_dlp
      comment: "Flag indicating whether the punch item has been deferred to the Defect Liability Period — measures handover quality risk."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the punch item was identified — supports time-series analysis of defect discovery rates."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of the punch item cost impact — required for multi-currency financial reporting."
    - name: "location"
      expr: location
      comment: "Physical location of the punch item defect — enables spatial analysis of defect concentration areas."
  measures:
    - name: "total_punch_items"
      expr: COUNT(1)
      comment: "Total number of punch items raised. Baseline pre-handover defect volume metric."
    - name: "open_punch_items"
      expr: COUNT(CASE WHEN punch_item_status != 'Closed' THEN punch_item_id END)
      comment: "Count of punch items not yet closed. Measures outstanding pre-handover defect backlog — a direct handover readiness KPI."
    - name: "punch_item_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN punch_item_status = 'Closed' THEN punch_item_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch items closed. Primary handover readiness KPI — must approach 100% before practical completion."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total financial cost impact of all punch items. Quantifies the monetary value of pre-handover defects — used in client negotiations and DLP provisioning."
    - name: "avg_cost_impact"
      expr: ROUND(AVG(CAST(cost_impact AS DOUBLE)), 2)
      comment: "Average cost impact per punch item. Benchmarks defect remediation cost — used to estimate DLP reserve requirements."
    - name: "dlp_deferred_items"
      expr: COUNT(CASE WHEN deferred_to_dlp = TRUE THEN punch_item_id END)
      comment: "Count of punch items deferred to the Defect Liability Period. Measures handover quality risk — high deferral counts indicate incomplete pre-handover remediation."
    - name: "dlp_deferred_cost_impact"
      expr: SUM(CASE WHEN deferred_to_dlp = TRUE THEN cost_impact ELSE 0 END)
      comment: "Total cost impact of punch items deferred to DLP. Quantifies the financial liability carried into the defect liability period."
    - name: "dlp_deferral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deferred_to_dlp = TRUE THEN punch_item_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch items deferred to DLP. High rates signal poor pre-handover quality and increased client satisfaction risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_punch_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch list-level KPIs measuring overall completion progress, handover gate readiness, and closeout timeliness across all punch lists. Used by Project Directors and Commissioning Managers to track milestone-level handover quality status."
  source: "`vibe_construction_v1`.`quality`.`punch_list`"
  dimensions:
    - name: "punch_list_status"
      expr: punch_list_status
      comment: "Current status of the punch list (e.g. Open, In Progress, Closed) — primary lifecycle dimension."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline associated with the punch list — enables discipline-level handover readiness comparison."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone the punch list is associated with (e.g. Practical Completion, Handover) — critical for gate-based quality reporting."
    - name: "handover_gate"
      expr: handover_gate
      comment: "Flag indicating whether this punch list is a handover gate — used to filter and prioritise handover-critical punch lists."
    - name: "dlp_commencement_gate"
      expr: dlp_commencement_gate
      comment: "Flag indicating whether this punch list gates DLP commencement — measures DLP readiness."
    - name: "project_area"
      expr: project_area
      comment: "Project area or zone associated with the punch list — enables spatial handover readiness analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the punch list — used to focus management attention on highest-priority closeout activities."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of punch list inspection — supports time-series tracking of punch list creation and closeout activity."
  measures:
    - name: "total_punch_lists"
      expr: COUNT(1)
      comment: "Total number of punch lists. Baseline volume metric for handover management scope."
    - name: "avg_completion_percentage"
      expr: ROUND(AVG(CAST(completion_percentage AS DOUBLE)), 2)
      comment: "Average completion percentage across all punch lists. Primary handover readiness KPI — directly indicates overall pre-handover defect clearance progress."
    - name: "punch_lists_at_100_pct"
      expr: COUNT(CASE WHEN completion_percentage = 100 THEN punch_list_id END)
      comment: "Count of punch lists fully completed (100%). Measures the number of areas/systems cleared for handover."
    - name: "fully_closed_punch_lists_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN punch_list_status = 'Closed' THEN punch_list_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch lists formally closed. Measures overall handover completion rate at the list level."
    - name: "handover_gate_punch_lists"
      expr: COUNT(CASE WHEN handover_gate = TRUE THEN punch_list_id END)
      comment: "Count of punch lists that are handover gates. Measures the scope of handover-critical quality closeout activities."
    - name: "overdue_closeout_punch_lists"
      expr: COUNT(CASE WHEN actual_closeout_date > target_closeout_date THEN punch_list_id END)
      comment: "Count of punch lists where actual closeout exceeded the target date. Measures schedule adherence for quality closeout — overruns directly impact practical completion milestones."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_test_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test certificate KPIs measuring pass/fail rates, certificate validity, and expiry risk across all material and system test certifications. Used by Quality Engineers and Procurement Managers to ensure material compliance and avoid regulatory non-conformance."
  source: "`vibe_construction_v1`.`quality`.`test_certificate`"
  dimensions:
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of test certificate (e.g. Mill Certificate, Hydrostatic Test, NDT) — primary grouping for compliance analysis."
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the certificate (e.g. Valid, Expired, Pending) — critical for compliance risk monitoring."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail result of the test — primary quality outcome dimension for test certificate analysis."
    - name: "test_method"
      expr: test_method
      comment: "Test method applied (e.g. tensile, compressive, ultrasonic) — enables analysis of failure rates by test methodology."
    - name: "issuing_laboratory"
      expr: issuing_laboratory
      comment: "Laboratory that issued the certificate — enables laboratory performance and accreditation benchmarking."
    - name: "test_date_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month of test date — supports time-series trending of test volumes and pass rates."
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accreditation body that certified the issuing laboratory — used for regulatory compliance verification."
  measures:
    - name: "total_test_certificates"
      expr: COUNT(1)
      comment: "Total number of test certificates on record. Baseline compliance documentation volume metric."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN test_certificate_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test certificates with a Pass result. Primary material and system quality compliance KPI — low pass rates trigger procurement and engineering review."
    - name: "failed_certificates"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN test_certificate_id END)
      comment: "Count of test certificates with a Fail result. Measures the volume of non-compliant materials or systems requiring disposition."
    - name: "expired_certificates"
      expr: COUNT(CASE WHEN certificate_status = 'Expired' THEN test_certificate_id END)
      comment: "Count of expired test certificates. Measures compliance documentation risk — expired certificates can block regulatory approvals and handover."
    - name: "expiry_risk_certificates"
      expr: COUNT(CASE WHEN certificate_expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND certificate_status != 'Expired' THEN test_certificate_id END)
      comment: "Count of certificates expiring within 30 days. Leading indicator of upcoming compliance risk — enables proactive renewal management."
    - name: "distinct_issuing_laboratories"
      expr: COUNT(DISTINCT issuing_laboratory)
      comment: "Count of distinct laboratories issuing test certificates. Measures supply chain diversity for testing — concentration risk indicator for quality assurance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_itp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection and Test Plan (ITP) KPIs measuring approval status, hold point coverage, and plan currency across all ITPs. Used by Quality Managers and Project Engineers to ensure inspection regimes are approved, current, and appropriately rigorous."
  source: "`vibe_construction_v1`.`quality`.`itp`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the ITP (e.g. Draft, Approved, Superseded) — primary governance dimension for ITP readiness."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline covered by the ITP — enables discipline-level ITP coverage and approval analysis."
    - name: "hold_point_required"
      expr: hold_point_required
      comment: "Flag indicating whether the ITP mandates hold points — measures the rigour of the inspection regime."
    - name: "fat_required"
      expr: fat_required
      comment: "Flag indicating whether Factory Acceptance Testing is required — used to track FAT coverage across ITPs."
    - name: "sat_required"
      expr: sat_required
      comment: "Flag indicating whether Site Acceptance Testing is required — used to track SAT coverage across ITPs."
    - name: "witness_point_required"
      expr: witness_point_required
      comment: "Flag indicating whether witness points are required — measures client and third-party oversight intensity."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the ITP became effective — supports time-series analysis of ITP issuance and renewal activity."
  measures:
    - name: "total_itps"
      expr: COUNT(1)
      comment: "Total number of Inspection and Test Plans. Baseline ITP coverage volume metric."
    - name: "approved_itps"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN itp_id END)
      comment: "Count of ITPs with Approved status. Measures quality governance readiness — unapproved ITPs represent a compliance risk."
    - name: "itp_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN itp_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ITPs that are approved. Key quality governance KPI — low approval rates indicate quality planning gaps that could block construction activities."
    - name: "itps_with_hold_points"
      expr: COUNT(CASE WHEN hold_point_required = TRUE THEN itp_id END)
      comment: "Count of ITPs requiring hold points. Measures the scope of mandatory inspection gates — critical for regulatory and client compliance."
    - name: "expired_itps"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() THEN itp_id END)
      comment: "Count of ITPs past their expiry date. Measures quality documentation currency risk — expired ITPs may not reflect current design or regulatory requirements."
    - name: "itps_requiring_fat"
      expr: COUNT(CASE WHEN fat_required = TRUE THEN itp_id END)
      comment: "Count of ITPs requiring Factory Acceptance Testing. Measures the scope of off-site quality verification obligations — relevant for procurement and logistics planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_checklist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality checklist KPIs measuring checklist utilisation, pass rates, hold point coverage, and approval status. Used by Quality Engineers and Site Supervisors to ensure inspection checklists are current, approved, and performing effectively."
  source: "`vibe_construction_v1`.`quality`.`checklist`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the checklist (e.g. Draft, Approved, Superseded) — primary governance dimension."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of construction activity the checklist covers — enables activity-level quality performance analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline associated with the checklist — supports discipline-level quality coverage analysis."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection the checklist is designed for — used to segment checklists by inspection regime."
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of construction at which the checklist is applied (e.g. Pre-pour, Post-pour, Commissioning) — enables stage-gate quality analysis."
    - name: "hold_point_flag"
      expr: hold_point_flag
      comment: "Flag indicating whether the checklist includes a hold point — measures the proportion of checklists with mandatory inspection gates."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Flag indicating whether the checklist is mandatory — used to prioritise compliance monitoring."
    - name: "frequency"
      expr: frequency
      comment: "Inspection frequency defined in the checklist (e.g. Daily, Per Pour, Per Lift) — used to assess inspection regime intensity."
  measures:
    - name: "total_checklists"
      expr: COUNT(1)
      comment: "Total number of quality checklists in the register. Baseline quality documentation coverage metric."
    - name: "approved_checklists"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN checklist_id END)
      comment: "Count of approved checklists. Measures quality documentation governance — unapproved checklists represent a compliance risk."
    - name: "checklist_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN checklist_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checklists that are approved. Quality governance KPI — low rates indicate documentation gaps."
    - name: "avg_pass_rate"
      expr: ROUND(AVG(CAST(average_pass_rate AS DOUBLE)), 2)
      comment: "Average pass rate across all checklists. Measures overall checklist-level quality performance — declining rates signal workmanship or process deterioration."
    - name: "checklists_with_hold_points"
      expr: COUNT(CASE WHEN hold_point_flag = TRUE THEN checklist_id END)
      comment: "Count of checklists containing hold points. Measures the scope of mandatory inspection gates in the quality regime."
    - name: "mandatory_checklists"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE THEN checklist_id END)
      comment: "Count of mandatory checklists. Measures the non-negotiable quality inspection scope — used to ensure mandatory checks are not bypassed."
$$;