-- Metric views for domain: compliance | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 20:21:36

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for regulatory violations — tracks volume, permit linkage, and inspection-driven deficiencies to steer compliance risk management and enforcement prioritisation."
  source: "`vibe_water_utilities_v1`.`compliance`.`violation`"
  dimensions:
    - name: "compliance_permit_id"
      expr: compliance_permit_id
      comment: "Permit under which the violation was recorded — enables per-permit compliance risk ranking."
    - name: "facility_id"
      expr: facility_id
      comment: "Treatment facility associated with the violation — supports facility-level compliance scorecards."
    - name: "regulatory_requirement_id"
      expr: regulatory_requirement_id
      comment: "Regulatory requirement that was violated — identifies which rules are most frequently breached."
    - name: "regulatory_inspection_id"
      expr: regulatory_inspection_id
      comment: "Inspection that surfaced the violation — links violations to their discovery event."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of regulatory violations recorded. A rising count signals deteriorating compliance posture and triggers executive review."
    - name: "distinct_permits_with_violations"
      expr: COUNT(DISTINCT compliance_permit_id)
      comment: "Number of unique permits that have at least one violation. Indicates breadth of compliance exposure across the permit portfolio."
    - name: "distinct_facilities_with_violations"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities implicated in violations. Drives facility-level remediation prioritisation."
    - name: "distinct_requirements_violated"
      expr: COUNT(DISTINCT regulatory_requirement_id)
      comment: "Number of unique regulatory requirements breached. A high count indicates systemic compliance gaps rather than isolated incidents."
    - name: "inspection_triggered_violations"
      expr: COUNT(CASE WHEN regulatory_inspection_id IS NOT NULL THEN 1 END)
      comment: "Violations discovered through a regulatory inspection. Measures inspection effectiveness and regulator-identified risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_enforcement_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPIs for enforcement actions — tracks penalty exposure, payment performance, and resolution efficiency to inform legal strategy and regulatory relationship management."
  source: "`vibe_water_utilities_v1`.`compliance`.`enforcement_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Category of enforcement action (e.g., NOV, consent order, administrative penalty) — enables analysis by enforcement severity."
    - name: "action_status"
      expr: action_status
      comment: "Current lifecycle status of the enforcement action — distinguishes open, resolved, and appealed actions."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility subject to the enforcement action — supports facility-level enforcement risk scoring."
    - name: "regulatory_agency_id"
      expr: regulatory_agency_id
      comment: "Regulatory agency issuing the enforcement action — enables agency-level relationship and risk tracking."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Indicates whether the utility filed an appeal — segments contested vs. accepted enforcement outcomes."
    - name: "supplemental_environmental_project_flag"
      expr: supplemental_environmental_project_flag
      comment: "Flags actions resolved via a supplemental environmental project (SEP) — tracks alternative compliance pathways."
  measures:
    - name: "total_enforcement_actions"
      expr: COUNT(1)
      comment: "Total enforcement actions issued. A leading indicator of regulatory relationship health and compliance programme effectiveness."
    - name: "total_civil_penalty_assessed"
      expr: SUM(CAST(civil_penalty_amount AS DOUBLE))
      comment: "Total civil penalties assessed across all enforcement actions. Directly quantifies financial liability from non-compliance."
    - name: "total_penalty_paid"
      expr: SUM(CAST(penalty_paid_amount AS DOUBLE))
      comment: "Total penalties actually paid. Compared against assessed penalties to measure settlement efficiency and outstanding liability."
    - name: "total_sep_estimated_cost"
      expr: SUM(CAST(sep_estimated_cost AS DOUBLE))
      comment: "Total estimated cost of supplemental environmental projects committed as part of enforcement resolutions. Quantifies alternative compliance investment."
    - name: "avg_civil_penalty_per_action"
      expr: AVG(CAST(civil_penalty_amount AS DOUBLE))
      comment: "Average civil penalty per enforcement action. Benchmarks penalty severity and informs settlement negotiation strategy."
    - name: "open_enforcement_actions"
      expr: COUNT(CASE WHEN action_status NOT IN ('Resolved','Closed','Dismissed') THEN 1 END)
      comment: "Number of enforcement actions not yet resolved. Represents active regulatory liability requiring management attention."
    - name: "appealed_actions"
      expr: COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END)
      comment: "Number of enforcement actions where the utility filed an appeal. Indicates contested enforcement exposure and legal resource demand."
    - name: "penalty_outstanding"
      expr: SUM(CAST(civil_penalty_amount AS DOUBLE) - CAST(penalty_paid_amount AS DOUBLE))
      comment: "Total unpaid penalty balance (assessed minus paid). Represents current financial liability on the balance sheet."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for corrective actions — tracks completion rates, cost performance, and verification outcomes to steer remediation programme effectiveness and regulatory closure."
  source: "`vibe_water_utilities_v1`.`compliance`.`corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (e.g., Open, In Progress, Closed) — primary dimension for workload and backlog analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the corrective action — enables risk-weighted backlog management."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for completing the corrective action — supports departmental performance accountability."
    - name: "verification_status"
      expr: verification_status
      comment: "Outcome of the verification review — distinguishes verified-closed from unverified actions."
    - name: "regulatory_agency_notified"
      expr: regulatory_agency_notified
      comment: "Whether the regulatory agency was notified of the corrective action — flags regulatory communication compliance."
    - name: "preventive_action_implemented"
      expr: preventive_action_implemented
      comment: "Whether a preventive action was implemented alongside the corrective action — measures root-cause closure quality."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total corrective actions on record. Baseline measure of remediation workload volume."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual expenditure on corrective actions. Quantifies the financial cost of non-compliance remediation."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective actions. Used alongside actual cost to assess budget accuracy and cost overrun risk."
    - name: "avg_actual_cost_per_action"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action. Benchmarks remediation cost efficiency across departments and violation types."
    - name: "overdue_corrective_actions"
      expr: COUNT(CASE WHEN planned_completion_date < CURRENT_DATE AND action_status NOT IN ('Closed','Completed') THEN 1 END)
      comment: "Corrective actions past their planned completion date and not yet closed. A critical operational risk indicator for regulatory deadline management."
    - name: "verified_closed_actions"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Actions confirmed as effectively resolved through formal verification. Measures true closure quality, not just status updates."
    - name: "preventive_action_implementation_rate"
      expr: COUNT(CASE WHEN preventive_action_implemented = TRUE THEN 1 END)
      comment: "Count of corrective actions where a preventive measure was also implemented. Higher rates indicate a mature, root-cause-focused compliance programme."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_dmr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge Monitoring Report (DMR) submission KPIs — tracks reporting timeliness, non-compliance flags, and exceedance patterns to manage NPDES permit obligations and avoid enforcement escalation."
  source: "`vibe_water_utilities_v1`.`compliance`.`dmr`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility submitting the DMR — enables per-facility submission performance tracking."
    - name: "regulatory_agency_id"
      expr: regulatory_agency_id
      comment: "Regulatory agency receiving the DMR — supports agency-specific reporting compliance analysis."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the DMR submission (e.g., Submitted, Accepted, Rejected) — primary dimension for submission pipeline monitoring."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency at which DMRs are required (e.g., Monthly, Quarterly) — segments reporting obligations by cadence."
    - name: "noncompliance_flag"
      expr: noncompliance_flag
      comment: "Indicates the DMR reported a non-compliance condition — key filter for regulatory risk dashboards."
    - name: "late_submission_flag"
      expr: late_submission_flag
      comment: "Flags DMRs submitted after the due date — drives timeliness performance management."
    - name: "no_discharge_flag"
      expr: no_discharge_flag
      comment: "Indicates a no-discharge reporting period — distinguishes active discharge periods from dry periods in trend analysis."
    - name: "reporting_period_start_date"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Reporting period start truncated to month — enables time-series trend analysis of DMR submissions."
  measures:
    - name: "total_dmr_submissions"
      expr: COUNT(1)
      comment: "Total DMR submissions on record. Baseline measure of reporting volume and permit obligation fulfilment."
    - name: "late_submissions"
      expr: COUNT(CASE WHEN late_submission_flag = TRUE THEN 1 END)
      comment: "Number of DMRs submitted after the regulatory due date. Late submissions risk enforcement action and penalty assessment."
    - name: "noncompliance_reports"
      expr: COUNT(CASE WHEN noncompliance_flag = TRUE THEN 1 END)
      comment: "Number of DMRs flagging a non-compliance condition. Directly measures permit exceedance frequency and regulatory exposure."
    - name: "rejected_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN 1 END)
      comment: "Number of DMRs rejected by the regulatory agency. Rejected reports require resubmission and signal data quality or procedural issues."
    - name: "resubmitted_reports"
      expr: COUNT(CASE WHEN resubmission_flag = TRUE THEN 1 END)
      comment: "Number of DMRs that were resubmitted (amended). High resubmission rates indicate upstream data quality or process control problems."
    - name: "distinct_facilities_reporting"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities that have submitted DMRs. Measures permit reporting coverage across the facility portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_regulatory_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory inspection KPIs — tracks inspection outcomes, deficiency rates, and enforcement escalation to manage regulator relationships and drive proactive compliance improvement."
  source: "`vibe_water_utilities_v1`.`compliance`.`regulatory_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection conducted (e.g., Routine, Complaint-driven, Follow-up) — segments inspection outcomes by trigger category."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., Scheduled, Completed, Pending Report) — tracks inspection pipeline progress."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility inspected — enables facility-level inspection performance and deficiency tracking."
    - name: "regulatory_agency_id"
      expr: regulatory_agency_id
      comment: "Agency conducting the inspection — supports agency-specific inspection outcome analysis."
    - name: "significant_deficiency_flag"
      expr: significant_deficiency_flag
      comment: "Flags inspections where a significant deficiency was identified — critical filter for high-risk inspection outcomes."
    - name: "enforcement_action_flag"
      expr: enforcement_action_flag
      comment: "Indicates the inspection resulted in an enforcement action — measures inspection-to-enforcement escalation rate."
    - name: "inspection_date"
      expr: DATE_TRUNC('quarter', inspection_date)
      comment: "Inspection date truncated to quarter — enables quarterly trend analysis of inspection activity and outcomes."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total regulatory inspections conducted. Baseline measure of regulatory scrutiny intensity."
    - name: "inspections_with_significant_deficiency"
      expr: COUNT(CASE WHEN significant_deficiency_flag = TRUE THEN 1 END)
      comment: "Inspections resulting in a significant deficiency finding. A key risk indicator — significant deficiencies often precede enforcement actions."
    - name: "inspections_triggering_enforcement"
      expr: COUNT(CASE WHEN enforcement_action_flag = TRUE THEN 1 END)
      comment: "Inspections that escalated to a formal enforcement action. Measures the rate at which inspections convert to enforcement liability."
    - name: "inspections_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Inspections that mandated a corrective action response. Drives corrective action workload forecasting."
    - name: "inspections_with_violation_identified"
      expr: COUNT(CASE WHEN violation_identified_flag = TRUE THEN 1 END)
      comment: "Inspections where at least one violation was identified. Measures inspection-driven violation discovery rate."
    - name: "follow_up_inspections_required"
      expr: COUNT(CASE WHEN follow_up_inspection_required_flag = TRUE THEN 1 END)
      comment: "Inspections requiring a follow-up visit. Indicates unresolved findings and ongoing regulatory scrutiny burden."
    - name: "distinct_facilities_inspected"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities inspected. Measures inspection coverage breadth across the asset portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_mor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monthly Operations Report (MOR) KPIs for drinking water treatment — tracks turbidity compliance, CT value achievement, disinfectant residuals, and flow performance to ensure Safe Drinking Water Act obligations are met."
  source: "`vibe_water_utilities_v1`.`compliance`.`mor`"
  dimensions:
    - name: "regulatory_agency_id"
      expr: regulatory_agency_id
      comment: "Regulatory agency receiving the MOR — supports agency-specific reporting compliance tracking."
    - name: "turbidity_compliance_status"
      expr: turbidity_compliance_status
      comment: "Whether the facility met turbidity limits during the reporting period — key Surface Water Treatment Rule compliance indicator."
    - name: "ct_compliance_status"
      expr: ct_compliance_status
      comment: "Whether the required CT (concentration × time) disinfection value was achieved — critical pathogen inactivation compliance dimension."
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status of the MOR submission — distinguishes certified, pending, and rejected reports."
    - name: "disinfectant_type"
      expr: disinfectant_type
      comment: "Type of disinfectant used (e.g., Chlorine, UV, Ozone) — enables disinfection technology performance comparison."
    - name: "source_water_type"
      expr: source_water_type
      comment: "Source water classification (e.g., Surface, Groundwater) — segments treatment performance by source water risk profile."
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_month)
      comment: "Reporting month truncated to month — enables monthly and seasonal trend analysis of treatment performance."
  measures:
    - name: "total_mor_reports"
      expr: COUNT(1)
      comment: "Total MOR reports submitted. Baseline measure of monthly reporting obligation fulfilment."
    - name: "avg_finished_water_turbidity_ntu"
      expr: AVG(CAST(finished_water_turbidity_avg_ntu AS DOUBLE))
      comment: "Average finished water turbidity across reporting periods. Turbidity is the primary Surface Water Treatment Rule compliance parameter — exceedances trigger public notification."
    - name: "max_finished_water_turbidity_ntu"
      expr: MAX(CAST(finished_water_turbidity_max_ntu AS DOUBLE))
      comment: "Maximum single-period finished water turbidity peak. Identifies worst-case treatment performance events requiring investigation."
    - name: "avg_ct_value_achieved"
      expr: AVG(CAST(ct_value_achieved AS DOUBLE))
      comment: "Average CT value achieved across reporting periods. CT achievement is the primary disinfection efficacy metric under the Surface Water Treatment Rule."
    - name: "avg_ct_value_required"
      expr: AVG(CAST(ct_value_required AS DOUBLE))
      comment: "Average CT value required by permit. Used alongside achieved CT to compute compliance margin."
    - name: "avg_disinfectant_residual_mg_l"
      expr: AVG(CAST(disinfectant_residual_avg_mg_l AS DOUBLE))
      comment: "Average disinfectant residual in finished water. Residual maintenance is a distribution system protection requirement — low values trigger regulatory response."
    - name: "avg_daily_flow_mgd"
      expr: AVG(CAST(average_daily_flow_mgd AS DOUBLE))
      comment: "Average daily production flow in million gallons per day. Contextualises treatment performance relative to plant loading."
    - name: "total_water_produced_mgd_sum"
      expr: SUM(CAST(total_water_produced_mgd AS DOUBLE))
      comment: "Total water produced across all reporting periods. Measures cumulative production volume for capacity and demand planning."
    - name: "turbidity_non_compliant_periods"
      expr: COUNT(CASE WHEN turbidity_compliance_status NOT IN ('Compliant','Met') THEN 1 END)
      comment: "Number of reporting periods where turbidity compliance was not achieved. Directly measures Surface Water Treatment Rule violation frequency."
    - name: "ct_non_compliant_periods"
      expr: COUNT(CASE WHEN ct_compliance_status NOT IN ('Compliant','Met') THEN 1 END)
      comment: "Number of reporting periods where the required CT value was not achieved. CT failures represent the highest-risk disinfection compliance events."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_permit_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit condition KPIs — tracks the composition, status, and numeric limit profile of permit conditions to support permit management, renewal planning, and compliance schedule oversight."
  source: "`vibe_water_utilities_v1`.`compliance`.`permit_condition`"
  dimensions:
    - name: "compliance_permit_id"
      expr: compliance_permit_id
      comment: "Permit to which the condition belongs — primary grouping for per-permit condition portfolio analysis."
    - name: "condition_type"
      expr: condition_type
      comment: "Type of permit condition (e.g., Effluent Limit, Monitoring, Reporting) — enables analysis by condition category."
    - name: "condition_status"
      expr: condition_status
      comment: "Current status of the permit condition (e.g., Active, Expired, Superseded) — distinguishes enforceable from inactive conditions."
    - name: "limit_type"
      expr: limit_type
      comment: "Type of numeric limit (e.g., Daily Maximum, Monthly Average) — segments conditions by limit stringency."
    - name: "compliance_schedule_flag"
      expr: compliance_schedule_flag
      comment: "Indicates the condition has an associated compliance schedule — flags conditions with milestone-based obligations."
    - name: "seasonal_variation_flag"
      expr: seasonal_variation_flag
      comment: "Indicates the condition has seasonal limit variations — important for operational planning and seasonal compliance management."
    - name: "enforcement_priority"
      expr: enforcement_priority
      comment: "Regulatory enforcement priority assigned to the condition — enables risk-weighted condition management."
  measures:
    - name: "total_permit_conditions"
      expr: COUNT(1)
      comment: "Total permit conditions across all permits. Measures the overall regulatory obligation burden on the utility."
    - name: "active_permit_conditions"
      expr: COUNT(CASE WHEN condition_status = 'Active' THEN 1 END)
      comment: "Number of currently enforceable permit conditions. Represents the live compliance obligation inventory."
    - name: "conditions_with_compliance_schedule"
      expr: COUNT(CASE WHEN compliance_schedule_flag = TRUE THEN 1 END)
      comment: "Permit conditions that include a compliance schedule with milestones. These require active tracking to avoid schedule violation enforcement."
    - name: "avg_numeric_limit"
      expr: AVG(CAST(numeric_limit AS DOUBLE))
      comment: "Average numeric effluent or quality limit across permit conditions. Benchmarks limit stringency across the permit portfolio."
    - name: "avg_violation_threshold"
      expr: AVG(CAST(violation_threshold AS DOUBLE))
      comment: "Average violation threshold across permit conditions. Compared against numeric limits to assess compliance headroom."
    - name: "conditions_requiring_public_notification"
      expr: COUNT(CASE WHEN public_notification_required_flag = TRUE THEN 1 END)
      comment: "Permit conditions that trigger public notification requirements upon exceedance. High counts indicate significant public-facing compliance risk."
    - name: "distinct_permits_with_conditions"
      expr: COUNT(DISTINCT compliance_permit_id)
      comment: "Number of distinct permits that have at least one condition on record. Measures permit portfolio coverage in the conditions register."
$$;