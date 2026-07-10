-- Metric views for domain: compliance | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI view over compliance violations. Tracks violation discovery trends, open enforcement exposure, and facility-level risk concentration for executive and regulatory reporting."
  source: "`vibe_water_utilities_v1`.`compliance`.`compliance_violation`"
  dimensions:
    - name: "compliance_permit_id"
      expr: compliance_permit_id
      comment: "Permit under which the violation was identified — enables permit-level violation rate analysis."
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility where the violation occurred — supports facility risk ranking."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of compliance violations recorded. Core KPI for regulatory risk dashboards and board reporting."
    - name: "distinct_permits_with_violations"
      expr: COUNT(DISTINCT compliance_permit_id)
      comment: "Number of distinct permits that have at least one violation. Indicates breadth of permit non-compliance exposure."
    - name: "distinct_facilities_with_violations"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with recorded violations. Drives facility-level risk prioritization for capital and operational investment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_enforcement_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive KPI view over enforcement actions. Tracks financial penalty exposure, resolution rates, and supplemental environmental project commitments to steer regulatory risk management."
  source: "`vibe_water_utilities_v1`.`compliance`.`enforcement_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of enforcement action (e.g., NOV, consent order, administrative order) — enables breakdown by enforcement severity."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the enforcement action (open, resolved, appealed) — drives workload and resolution tracking."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility subject to enforcement — supports facility-level regulatory risk concentration analysis."
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Regulatory agency that issued the enforcement action — enables agency-level relationship management."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed — distinguishes contested vs. accepted enforcement actions."
    - name: "supplemental_environmental_project_flag"
      expr: supplemental_environmental_project_flag
      comment: "Whether a supplemental environmental project (SEP) was committed — tracks SEP portfolio."
    - name: "issue_date"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the enforcement action was issued — enables trend analysis over time."
  measures:
    - name: "total_enforcement_actions"
      expr: COUNT(1)
      comment: "Total enforcement actions issued. Core regulatory risk KPI for executive and board reporting."
    - name: "total_civil_penalty_assessed"
      expr: SUM(CAST(civil_penalty_amount AS DOUBLE))
      comment: "Total civil penalty dollars assessed across all enforcement actions. Direct financial risk exposure metric for CFO and legal review."
    - name: "total_penalty_paid"
      expr: SUM(CAST(penalty_paid_amount AS DOUBLE))
      comment: "Total civil penalty dollars actually paid. Compared against assessed to track outstanding penalty liability."
    - name: "total_sep_estimated_cost"
      expr: SUM(CAST(sep_estimated_cost AS DOUBLE))
      comment: "Total estimated cost of supplemental environmental projects committed. Tracks SEP financial obligation for budget planning."
    - name: "avg_civil_penalty_per_action"
      expr: AVG(CAST(civil_penalty_amount AS DOUBLE))
      comment: "Average civil penalty per enforcement action. Benchmarks penalty severity trends over time and across agencies."
    - name: "open_enforcement_actions"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN 1 END)
      comment: "Number of currently open enforcement actions. Drives prioritization of legal and compliance resources."
    - name: "penalty_collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(penalty_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(civil_penalty_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of assessed civil penalties that have been collected. Measures enforcement resolution effectiveness and outstanding financial liability."
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enforcement actions that were appealed. High appeal rates signal contested regulatory relationships or over-enforcement."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPI view over corrective actions. Tracks cost performance, schedule adherence, and closure rates to steer remediation program effectiveness."
  source: "`vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (open, in-progress, closed, overdue) — core dimension for workload management."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the corrective action — enables risk-based triage and resource allocation."
    - name: "triggering_event_type"
      expr: triggering_event_type
      comment: "Type of event that triggered the corrective action (violation, inspection finding, overflow) — identifies systemic root cause patterns."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the corrective action has been verified as effective — tracks quality of closure."
    - name: "preventive_action_implemented"
      expr: preventive_action_implemented
      comment: "Whether a preventive action was implemented alongside the corrective action — measures proactive vs. reactive posture."
    - name: "planned_completion_date"
      expr: DATE_TRUNC('month', planned_completion_date)
      comment: "Month the corrective action was planned to be completed — enables schedule adherence trending."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total corrective actions recorded. Baseline KPI for compliance remediation program scope."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all corrective actions. Core financial KPI for compliance program budget management."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective actions. Used alongside actual cost to compute budget variance."
    - name: "avg_actual_cost_per_action"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action. Benchmarks remediation cost efficiency over time."
    - name: "cost_overrun_amount"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total cost overrun (actual minus estimated) across all corrective actions. Negative values indicate under-spend; positive values indicate budget pressure."
    - name: "cost_overrun_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE)) / NULLIF(SUM(CAST(estimated_cost AS DOUBLE)), 0), 2)
      comment: "Percentage by which actual costs exceeded estimates. Key project controls KPI for compliance program financial oversight."
    - name: "overdue_actions"
      expr: COUNT(CASE WHEN planned_completion_date < CURRENT_DATE AND action_status != 'Closed' THEN 1 END)
      comment: "Number of corrective actions past their planned completion date and not yet closed. Drives escalation and regulatory risk management."
    - name: "closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that have been closed. Measures remediation program throughput and effectiveness."
    - name: "verified_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions with verified effective closure. Higher-quality closure metric than simple status-based closure rate."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_dmr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory KPI view over Discharge Monitoring Reports. Tracks submission timeliness, non-compliance rates, and exceedance volumes for NPDES permit compliance management."
  source: "`vibe_water_utilities_v1`.`compliance`.`dmr`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the DMR submission (submitted, accepted, rejected, pending) — core dimension for submission pipeline management."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility that submitted the DMR — enables facility-level NPDES compliance tracking."
    - name: "compliance_permit_id"
      expr: compliance_permit_id
      comment: "NPDES permit under which the DMR was filed — links DMR performance to specific permit conditions."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency at which DMRs are required (monthly, quarterly, etc.) — supports workload planning."
    - name: "noncompliance_flag"
      expr: noncompliance_flag
      comment: "Whether the DMR reported a non-compliance condition — primary regulatory risk flag."
    - name: "late_submission_flag"
      expr: late_submission_flag
      comment: "Whether the DMR was submitted after the due date — tracks submission timeliness compliance."
    - name: "resubmission_flag"
      expr: resubmission_flag
      comment: "Whether this DMR is a resubmission — indicates data quality or rejection issues."
    - name: "reporting_period_start_date"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Reporting period month — enables trend analysis of DMR compliance over time."
  measures:
    - name: "total_dmrs"
      expr: COUNT(1)
      comment: "Total DMRs filed. Baseline volume metric for NPDES reporting program management."
    - name: "noncompliance_dmr_count"
      expr: COUNT(CASE WHEN noncompliance_flag = TRUE THEN 1 END)
      comment: "Number of DMRs reporting a non-compliance condition. Core NPDES regulatory risk KPI."
    - name: "noncompliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN noncompliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DMRs with non-compliance conditions. Tracks NPDES permit compliance rate — a primary regulatory performance indicator."
    - name: "late_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_submission_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DMRs submitted after the regulatory due date. Late submissions can trigger enforcement actions and penalty exposure."
    - name: "total_exceedances_reported"
      expr: COUNT(CASE WHEN noncompliance_flag = TRUE AND no_discharge_flag = FALSE THEN 1 END)
      comment: "Count of DMRs with active discharge exceedances (non-compliant and not a no-discharge period). Measures active effluent limit violations."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_status = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DMRs rejected by the regulatory agency. High rejection rates indicate data quality or procedural issues requiring corrective action."
    - name: "resubmission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resubmission_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DMRs that required resubmission. Measures first-time submission quality for the NPDES reporting program."
    - name: "distinct_facilities_with_noncompliance"
      expr: COUNT(DISTINCT CASE WHEN noncompliance_flag = TRUE THEN facility_id END)
      comment: "Number of distinct facilities with at least one non-compliant DMR. Identifies breadth of NPDES compliance issues across the utility."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPI view over regulatory obligations. Tracks cost performance, schedule adherence, and completion rates to manage the utility's regulatory compliance workload."
  source: "`vibe_water_utilities_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (open, completed, overdue, waived) — primary dimension for workload management."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (monitoring, reporting, operational, capital) — enables category-level resource planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the obligation — supports risk-based triage of compliance workload."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the obligation — enables risk-stratified compliance portfolio management."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Whether the obligation is on the critical path for permit compliance — flags highest-priority items."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility responsible for the obligation — enables facility-level compliance burden analysis."
    - name: "due_date"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the obligation is due — enables forward-looking compliance calendar management."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total regulatory obligations tracked. Baseline KPI for compliance program scope and workload."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to fulfill obligations. Core financial KPI for compliance program budget management."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all obligations. Used with actual cost to compute budget variance."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total staff hours expended on regulatory obligations. Drives workforce capacity planning for compliance teams."
    - name: "total_estimated_effort_hours"
      expr: SUM(CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total estimated staff hours for obligations. Compared against actual to assess effort estimation accuracy."
    - name: "overdue_obligations"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND obligation_status != 'Completed' THEN 1 END)
      comment: "Number of obligations past their due date and not yet completed. Critical regulatory risk KPI requiring immediate management attention."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN obligation_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations completed. Measures overall regulatory compliance program execution effectiveness."
    - name: "critical_path_overdue_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE AND due_date < CURRENT_DATE AND obligation_status != 'Completed' THEN 1 END)
      comment: "Number of critical-path obligations that are overdue. Highest-priority compliance risk indicator for executive escalation."
    - name: "cost_overrun_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE)) / NULLIF(SUM(CAST(estimated_cost AS DOUBLE)), 0), 2)
      comment: "Percentage by which actual obligation costs exceeded estimates. Measures compliance program financial control effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_regulatory_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI view over regulatory inspections. Tracks inspection outcomes, deficiency rates, and enforcement escalation to manage regulatory relationships and facility readiness."
  source: "`vibe_water_utilities_v1`.`compliance`.`regulatory_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of regulatory inspection (routine, complaint-driven, follow-up, comprehensive) — enables inspection program analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (scheduled, in-progress, completed, closed) — tracks inspection pipeline."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility inspected — enables facility-level inspection performance and readiness tracking."
    - name: "inspecting_agency"
      expr: inspecting_agency
      comment: "Regulatory agency conducting the inspection — supports agency relationship management."
    - name: "significant_deficiency_flag"
      expr: significant_deficiency_flag
      comment: "Whether the inspection identified a significant deficiency — primary risk flag for regulatory escalation."
    - name: "violation_identified_flag"
      expr: violation_identified_flag
      comment: "Whether the inspection identified a violation — links inspection outcomes to enforcement risk."
    - name: "enforcement_action_flag"
      expr: enforcement_action_flag
      comment: "Whether the inspection resulted in an enforcement action — measures inspection-to-enforcement conversion."
    - name: "inspection_date"
      expr: DATE_TRUNC('quarter', inspection_date)
      comment: "Quarter of inspection — enables quarterly inspection trend and outcome analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total regulatory inspections conducted. Baseline KPI for regulatory oversight intensity."
    - name: "inspections_with_violations"
      expr: COUNT(CASE WHEN violation_identified_flag = TRUE THEN 1 END)
      comment: "Number of inspections that identified at least one violation. Core regulatory risk KPI."
    - name: "violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN violation_identified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in a violation finding. Tracks facility compliance readiness and regulatory risk trend."
    - name: "significant_deficiency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN significant_deficiency_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections with significant deficiency findings. Significant deficiencies carry heightened enforcement risk and public health implications."
    - name: "enforcement_escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN enforcement_action_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that escalated to formal enforcement action. Measures regulatory relationship health and compliance program effectiveness."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of inspections requiring corrective action. Drives compliance remediation workload planning."
    - name: "follow_up_inspection_required_count"
      expr: COUNT(CASE WHEN follow_up_inspection_required_flag = TRUE THEN 1 END)
      comment: "Number of inspections requiring a follow-up inspection. Indicates unresolved compliance issues requiring continued regulatory attention."
    - name: "distinct_facilities_inspected"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities inspected. Measures regulatory oversight coverage across the utility's facility portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program management KPI view over compliance schedules. Tracks milestone completion rates, cost performance, and schedule extension patterns to manage consent order and permit schedule adherence."
  source: "`vibe_water_utilities_v1`.`compliance`.`compliance_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the compliance schedule (active, completed, overdue, extended) — primary dimension for schedule portfolio management."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of compliance schedule (consent order, permit condition, voluntary) — enables program-type analysis."
    - name: "compliance_permit_id"
      expr: compliance_permit_id
      comment: "Permit under which the schedule was established — links schedule performance to permit compliance."
    - name: "on_schedule_flag"
      expr: on_schedule_flag
      comment: "Whether the schedule is currently on track — primary operational health indicator."
    - name: "extension_approved_flag"
      expr: extension_approved_flag
      comment: "Whether a schedule extension was approved — tracks regulatory accommodation patterns."
    - name: "public_notification_required_flag"
      expr: public_notification_required_flag
      comment: "Whether public notification is required under this schedule — flags high-visibility compliance obligations."
    - name: "final_compliance_deadline"
      expr: DATE_TRUNC('quarter', final_compliance_deadline)
      comment: "Quarter of the final compliance deadline — enables forward-looking schedule risk analysis."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total compliance schedules tracked. Baseline KPI for consent order and permit schedule portfolio scope."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_total_cost AS DOUBLE))
      comment: "Total actual cost incurred across all compliance schedules. Core financial KPI for consent order program budget management."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost of compliance schedules. Used with actual cost to compute program-level budget variance."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(overall_completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all active compliance schedules. Measures overall consent order program progress."
    - name: "off_schedule_count"
      expr: COUNT(CASE WHEN on_schedule_flag = FALSE THEN 1 END)
      comment: "Number of compliance schedules currently off-track. Drives regulatory risk escalation and resource reallocation decisions."
    - name: "on_schedule_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN on_schedule_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance schedules currently on track. Primary consent order program health KPI for executive reporting."
    - name: "extension_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_requested_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance schedules for which an extension was requested. High extension rates signal systemic capacity or funding constraints."
    - name: "cost_overrun_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_total_cost AS DOUBLE) - CAST(estimated_total_cost AS DOUBLE)) / NULLIF(SUM(CAST(estimated_total_cost AS DOUBLE)), 0), 2)
      comment: "Percentage by which actual schedule costs exceeded estimates. Measures compliance program financial control effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory reporting KPI view over submissions to regulatory agencies. Tracks timeliness, amendment rates, and agency response patterns to manage the utility's regulatory reporting program."
  source: "`vibe_water_utilities_v1`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (DMR, CCR, MOR, permit application, etc.) — enables submission program analysis by report type."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (submitted, accepted, rejected, pending) — tracks submission pipeline health."
    - name: "regulatory_agency_id"
      expr: regulatory_agency_id
      comment: "Regulatory agency receiving the submission — enables agency-level submission performance analysis."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility associated with the submission — supports facility-level reporting compliance tracking."
    - name: "is_amendment"
      expr: is_amendment
      comment: "Whether this submission is an amendment to a prior submission — distinguishes original vs. corrective filings."
    - name: "is_late_submission"
      expr: is_late_submission
      comment: "Whether the submission was filed after the regulatory due date — primary timeliness compliance flag."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit (electronic, paper, portal) — tracks e-reporting adoption."
    - name: "submission_date"
      expr: DATE_TRUNC('quarter', submission_date)
      comment: "Quarter of submission — enables quarterly reporting compliance trend analysis."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total regulatory submissions filed. Baseline KPI for regulatory reporting program volume."
    - name: "late_submission_count"
      expr: COUNT(CASE WHEN is_late_submission = TRUE THEN 1 END)
      comment: "Number of submissions filed after the regulatory due date. Late submissions can trigger enforcement actions and penalty exposure."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_late_submission = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory submissions filed on time. Primary regulatory reporting compliance KPI for executive and board reporting."
    - name: "amendment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amendment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions that are amendments. High amendment rates indicate data quality issues in the original reporting process."
    - name: "resubmission_required_count"
      expr: COUNT(CASE WHEN resubmission_required = TRUE THEN 1 END)
      comment: "Number of submissions flagged as requiring resubmission. Measures first-time submission quality and regulatory acceptance rates."
    - name: "distinct_agencies_submitted_to"
      expr: COUNT(DISTINCT regulatory_agency_id)
      comment: "Number of distinct regulatory agencies receiving submissions. Measures breadth of regulatory reporting obligations."
    - name: "electronic_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_method = 'Electronic' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions filed electronically. Tracks e-reporting adoption, which reduces processing errors and improves audit trails."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_industrial_user`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pretreatment program KPI view over industrial users. Tracks compliance status, violation rates, and inspection coverage to manage the utility's industrial pretreatment program."
  source: "`vibe_water_utilities_v1`.`compliance`.`industrial_user`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the industrial user (compliant, non-compliant, SNC) — primary pretreatment program risk dimension."
    - name: "classification"
      expr: classification
      comment: "Industrial user classification (SIU, CIU, non-significant) — enables tiered oversight analysis."
    - name: "categorical_standard_applicable"
      expr: categorical_standard_applicable
      comment: "Whether a categorical pretreatment standard applies — distinguishes categorical vs. local limits compliance."
    - name: "pretreatment_system_installed"
      expr: pretreatment_system_installed
      comment: "Whether a pretreatment system is installed — tracks infrastructure compliance status."
    - name: "enforcement_action_pending"
      expr: enforcement_action_pending
      comment: "Whether an enforcement action is currently pending — flags highest-risk industrial users."
    - name: "is_active"
      expr: is_active
      comment: "Whether the industrial user permit is currently active — filters active vs. terminated users."
  measures:
    - name: "total_industrial_users"
      expr: COUNT(1)
      comment: "Total industrial users in the pretreatment program. Baseline KPI for program scope and regulatory reporting to the primacy agency."
    - name: "active_industrial_users"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active industrial users. Drives pretreatment program staffing and inspection resource planning."
    - name: "non_compliant_users"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of industrial users currently in non-compliance. Core pretreatment program risk KPI for regulatory reporting."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active industrial users in compliance. Primary pretreatment program performance KPI reported to the primacy agency annually."
    - name: "enforcement_action_pending_count"
      expr: COUNT(CASE WHEN enforcement_action_pending = TRUE THEN 1 END)
      comment: "Number of industrial users with pending enforcement actions. Tracks active regulatory enforcement workload in the pretreatment program."
    - name: "avg_discharge_volume_gpd"
      expr: AVG(CAST(estimated_discharge_volume_gpd AS DOUBLE))
      comment: "Average estimated daily discharge volume across industrial users. Measures industrial loading on the collection system for capacity planning."
    - name: "total_discharge_volume_gpd"
      expr: SUM(CAST(estimated_discharge_volume_gpd AS DOUBLE))
      comment: "Total estimated daily discharge volume from all industrial users. Critical capacity planning metric for the collection system and WWTP."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_public_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Public health KPI view over public notifications. Tracks notification timeliness, distribution reach, and deadline compliance to manage SDWA public notification program obligations."
  source: "`vibe_water_utilities_v1`.`compliance`.`compliance_public_notification`"
  dimensions:
    - name: "notification_tier"
      expr: notification_tier
      comment: "Tier of public notification (Tier 1 = 24hr, Tier 2 = 30 days, Tier 3 = annual) — determines urgency and regulatory deadline requirements."
    - name: "notification_status"
      expr: notification_status
      comment: "Current status of the notification (draft, issued, completed) — tracks notification pipeline."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify the public (mail, media, website, direct contact) — enables distribution channel analysis."
    - name: "violation_type"
      expr: violation_type
      comment: "Type of violation triggering the notification — enables analysis by contaminant or violation category."
    - name: "deadline_met_flag"
      expr: deadline_met_flag
      comment: "Whether the regulatory notification deadline was met — primary compliance flag for SDWA public notification requirements."
    - name: "repeat_notification_required_flag"
      expr: repeat_notification_required_flag
      comment: "Whether repeat notifications are required — identifies ongoing public health situations."
    - name: "public_meeting_held_flag"
      expr: public_meeting_held_flag
      comment: "Whether a public meeting was held — tracks community engagement for significant violations."
    - name: "distribution_start_date"
      expr: DATE_TRUNC('month', distribution_start_date)
      comment: "Month notification distribution began — enables trend analysis of public notification events."
  measures:
    - name: "total_public_notifications"
      expr: COUNT(1)
      comment: "Total public notifications issued. Baseline KPI for SDWA public notification program volume and public health event tracking."
    - name: "deadline_met_count"
      expr: COUNT(CASE WHEN deadline_met_flag = TRUE THEN 1 END)
      comment: "Number of notifications where the regulatory deadline was met. Core SDWA compliance KPI."
    - name: "deadline_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deadline_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of public notifications issued within the regulatory deadline. Failure to meet Tier 1 deadlines carries significant enforcement risk and public health consequences."
    - name: "total_distribution_cost"
      expr: SUM(CAST(distribution_cost_amount AS DOUBLE))
      comment: "Total cost of public notification distribution. Tracks financial impact of public health events on the compliance program budget."
    - name: "avg_distribution_cost_per_notification"
      expr: AVG(CAST(distribution_cost_amount AS DOUBLE))
      comment: "Average distribution cost per public notification. Benchmarks notification program cost efficiency."
    - name: "tier1_notifications"
      expr: COUNT(CASE WHEN notification_tier = 'Tier 1' THEN 1 END)
      comment: "Number of Tier 1 (24-hour) public notifications — the most urgent category indicating acute health risk. Tracked separately for executive and board visibility."
    - name: "repeat_notification_count"
      expr: COUNT(CASE WHEN repeat_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of notifications requiring repeat distribution. Indicates ongoing unresolved public health situations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_permit_grant_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPI view over permit grant allocations. Tracks grant utilization, drawdown rates, and remaining balances to optimize grant funding for compliance capital projects."
  source: "`vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the grant allocation (active, closed, pending) — primary dimension for grant portfolio management."
    - name: "grant_id"
      expr: grant_id
      comment: "Grant funding the allocation — enables grant-level utilization analysis."
    - name: "allocation_start_date"
      expr: DATE_TRUNC('year', allocation_start_date)
      comment: "Year the allocation period began — enables annual grant utilization trend analysis."
  measures:
    - name: "total_allocation_amount"
      expr: SUM(CAST(allocation_amount AS DOUBLE))
      comment: "Total grant dollars allocated to compliance permits. Core financial KPI for grant-funded compliance program management."
    - name: "total_amount_expended"
      expr: SUM(CAST(amount_expended_to_date AS DOUBLE))
      comment: "Total grant dollars expended to date. Tracks grant drawdown progress against allocation."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_allocation_balance AS DOUBLE))
      comment: "Total remaining unspent grant balance. Identifies at-risk grant funds that may lapse if not drawn down before expiration."
    - name: "grant_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_expended_to_date AS DOUBLE)) / NULLIF(SUM(CAST(allocation_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated grant funds expended. Low utilization rates risk grant lapse and loss of compliance funding — a critical financial management KPI."
    - name: "avg_allocation_amount"
      expr: AVG(CAST(allocation_amount AS DOUBLE))
      comment: "Average grant allocation per permit. Benchmarks grant funding levels across the compliance permit portfolio."
    - name: "distinct_grants_utilized"
      expr: COUNT(DISTINCT grant_id)
      comment: "Number of distinct grants funding compliance activities. Measures diversity of grant funding sources for compliance capital programs."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_inspection_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and risk KPI view over inspection findings. Tracks finding severity, resolution rates, and cost of remediation to manage regulatory inspection outcomes and corrective action programs."
  source: "`vibe_water_utilities_v1`.`compliance`.`inspection_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of inspection finding (deficiency, violation, observation, recommendation) — enables severity-based analysis."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (operational, infrastructure, documentation, monitoring) — identifies systemic issue patterns."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the finding (critical, high, medium, low) — drives prioritization of corrective action resources."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the finding (open, in-progress, resolved, verified) — tracks finding closure pipeline."
    - name: "enforcement_action_required"
      expr: enforcement_action_required
      comment: "Whether the finding requires formal enforcement action — flags highest-severity findings."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this finding is a recurrence of a prior finding — identifies systemic compliance failures requiring root cause intervention."
    - name: "identified_date"
      expr: DATE_TRUNC('quarter', identified_date)
      comment: "Quarter the finding was identified — enables trend analysis of inspection finding rates over time."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total inspection findings recorded. Baseline KPI for regulatory inspection program outcome tracking."
    - name: "critical_high_risk_findings"
      expr: COUNT(CASE WHEN risk_level IN ('Critical', 'High') THEN 1 END)
      comment: "Number of critical or high-risk findings. Drives immediate corrective action prioritization and executive escalation."
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are recurrences of prior findings. High recurrence rates indicate systemic compliance failures and ineffective corrective actions."
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_status = 'Resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspection findings that have been resolved. Measures corrective action program throughput and effectiveness."
    - name: "total_actual_remediation_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost to remediate inspection findings. Tracks financial impact of regulatory inspection outcomes on operations budget."
    - name: "avg_remediation_cost_per_finding"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average remediation cost per inspection finding. Benchmarks finding remediation cost efficiency and informs inspection readiness investment decisions."
    - name: "enforcement_escalation_count"
      expr: COUNT(CASE WHEN enforcement_action_required = TRUE THEN 1 END)
      comment: "Number of findings requiring formal enforcement action. Tracks the most severe inspection outcomes requiring legal and regulatory response."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_ccr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key compliance reporting metrics derived from CCR records"
  source: "`vibe_water_utilities_v1`.`compliance`.`ccr`"
  dimensions:
    - name: "report_year"
      expr: report_year
      comment: "Reporting year of the CCR"
    - name: "source_water_type"
      expr: source_water_type
      comment: "Type of source water reported"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the report"
    - name: "disinfection_byproduct_monitoring_flag"
      expr: disinfection_byproduct_monitoring_flag
      comment: "Flag indicating if DBP monitoring was performed"
    - name: "lead_copper_monitoring_flag"
      expr: lead_copper_monitoring_flag
      comment: "Flag indicating if lead/copper monitoring was performed"
    - name: "mcl_exceedance_flag"
      expr: mcl_exceedance_flag
      comment: "Flag for MCL exceedance"
    - name: "violation_included_flag"
      expr: violation_included_flag
      comment: "Flag indicating if a violation is included"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of CCR reports submitted"
    - name: "avg_lead_90th_ppb"
      expr: AVG(CAST(lead_90th_percentile_ppb AS DOUBLE))
      comment: "Average 90th percentile lead concentration (ppb) across reports"
    - name: "avg_copper_90th_ppm"
      expr: AVG(CAST(copper_90th_percentile_ppm AS DOUBLE))
      comment: "Average 90th percentile copper concentration (ppm) across reports"
    - name: "count_mcl_exceedances"
      expr: SUM(CASE WHEN mcl_exceedance_flag THEN 1 ELSE 0 END)
      comment: "Number of reports where MCL exceedance flag is true"
    - name: "count_violations"
      expr: SUM(CASE WHEN violation_included_flag THEN 1 ELSE 0 END)
      comment: "Number of reports that include a violation"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_mor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water quality performance metrics from Monthly Operational Reports (MOR)"
  source: "`vibe_water_utilities_v1`.`compliance`.`mor`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year of the MOR"
    - name: "source_water_type"
      expr: source_water_type
      comment: "Type of source water"
    - name: "disinfectant_type"
      expr: disinfectant_type
      comment: "Disinfectant type used"
    - name: "ct_compliance_status"
      expr: ct_compliance_status
      comment: "Chlorine residual compliance status"
    - name: "turbidity_compliance_status"
      expr: turbidity_compliance_status
      comment: "Turbidity compliance status"
  measures:
    - name: "avg_total_water_produced_mgd"
      expr: AVG(CAST(total_water_produced_mgd AS DOUBLE))
      comment: "Average total water produced (MGD) per MOR record"
    - name: "avg_ph"
      expr: AVG(CAST(ph_avg AS DOUBLE))
      comment: "Average pH across MOR records"
    - name: "avg_turbidity"
      expr: AVG(CAST(finished_water_turbidity_avg_ntu AS DOUBLE))
      comment: "Average finished water turbidity (NTU)"
    - name: "count_non_compliant"
      expr: SUM(CASE WHEN ct_compliance_status != 'Compliant' THEN 1 ELSE 0 END)
      comment: "Number of MOR records where CT compliance status is not compliant"
$$;