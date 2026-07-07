-- Metric views for domain: compliance | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:56:40

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for water utility compliance permits. Tracks permit portfolio health, fee obligations, capacity authorizations, and renewal pipeline to support regulatory risk management and capital planning decisions."
  source: "`vibe_water_utilities_v1`.`compliance`.`compliance_permit`"
  filter: record_status = 'ACTIVE' OR record_status IS NULL
  dimensions:
    - name: "permit_type"
      expr: compliance_permit_type
      comment: "Type of compliance permit (e.g., NPDES, SDWA, discharge) — primary segmentation for permit portfolio analysis."
    - name: "permit_status"
      expr: compliance_permit_status
      comment: "Current lifecycle status of the permit (e.g., Active, Expired, Pending Renewal) — drives renewal urgency and risk flags."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction governing the permit — enables geographic and regulatory-body segmentation."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Governing regulatory framework (e.g., Clean Water Act, EU IED) — supports multi-framework compliance reporting."
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Name of the agency that issued the permit — used to segment workload and relationship management by regulator."
    - name: "is_major_permit"
      expr: is_major_permit
      comment: "Flag indicating whether the permit is classified as a major permit — major permits carry higher scrutiny and penalty exposure."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating the permit is currently active — used to filter live permit portfolio."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the permit became effective — supports cohort and vintage analysis of permit issuances."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the permit expires — critical for renewal pipeline planning and avoiding lapses."
    - name: "permit_category"
      expr: permit_category
      comment: "Categorical classification of the permit (e.g., wastewater, drinking water) — supports domain-level portfolio segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance standing of the permit — key risk indicator for regulatory exposure."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Specific regulatory program under which the permit was issued (e.g., NPDES, SDWA) — supports program-level compliance tracking."
  measures:
    - name: "total_active_permits"
      expr: COUNT(CASE WHEN is_active = TRUE THEN compliance_permit_id END)
      comment: "Total number of currently active permits. Baseline KPI for permit portfolio size — a sudden drop signals lapses or expirations requiring immediate action."
    - name: "total_annual_fee_obligation_usd"
      expr: SUM(CAST(annual_fee_usd AS DOUBLE))
      comment: "Total annual regulatory fee obligation across all permits in USD. Directly informs budgeting and cost-of-compliance reporting for finance leadership."
    - name: "total_permitted_capacity_mgd"
      expr: SUM(CAST(permitted_capacity_mgd AS DOUBLE))
      comment: "Total permitted discharge/treatment capacity in million gallons per day (MGD). Drives capacity planning and infrastructure investment decisions."
    - name: "avg_permitted_capacity_mgd"
      expr: AVG(CAST(permitted_capacity_mgd AS DOUBLE))
      comment: "Average permitted capacity per permit in MGD. Benchmarks individual permit scale against portfolio average for capacity allocation analysis."
    - name: "permits_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiration_date >= CURRENT_DATE() AND is_active = TRUE THEN compliance_permit_id END)
      comment: "Number of active permits expiring within the next 90 days. Critical renewal pipeline KPI — triggers proactive renewal workflows to prevent operational lapses."
    - name: "permits_with_compliance_schedule"
      expr: COUNT(CASE WHEN compliance_schedule_flag = TRUE THEN compliance_permit_id END)
      comment: "Number of permits subject to a compliance schedule. Indicates the volume of permits with outstanding corrective milestones — a key regulatory risk indicator."
    - name: "major_permit_count"
      expr: COUNT(CASE WHEN is_major_permit = TRUE THEN compliance_permit_id END)
      comment: "Count of major permits in the portfolio. Major permits carry the highest regulatory scrutiny and penalty exposure — tracked separately for executive risk reporting."
    - name: "total_permit_fee_amount_usd"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total one-time or periodic permit fee amounts in USD. Supports cost-of-compliance financial reporting and budget variance analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for tracking water utility regulatory violations — covering volume, severity, financial exposure, resolution performance, and health-based risk. Core dashboard for compliance officers, legal, and executive leadership."
  source: "`vibe_water_utilities_v1`.`compliance`.`violation`"
  filter: record_status = 'ACTIVE' OR record_status IS NULL
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Type of regulatory violation (e.g., monitoring, reporting, MCL exceedance) — primary segmentation for root-cause and trend analysis."
    - name: "violation_status"
      expr: violation_status
      comment: "Current status of the violation (e.g., Open, Resolved, Under Review) — drives workload prioritization and resolution tracking."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the violation — used to prioritize response resources and escalation decisions."
    - name: "compliance_violation_category"
      expr: compliance_violation_category
      comment: "Regulatory category of the violation — supports program-level compliance performance reporting."
    - name: "is_health_based"
      expr: is_health_based
      comment: "Flag indicating the violation poses a direct public health risk — health-based violations require immediate escalation and public notification."
    - name: "is_significant_noncompliance"
      expr: is_significant_noncompliance
      comment: "Flag for Significant Non-Compliance (SNC) designation — SNC violations trigger mandatory regulatory escalation and public reporting."
    - name: "is_repeat_violation"
      expr: is_repeat_violation
      comment: "Flag indicating this is a repeat violation — repeat violations signal systemic process failures and carry elevated penalty risk."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction of the violation — enables geographic and regulatory-body segmentation for multi-jurisdiction utilities."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Governing regulatory framework (e.g., SDWA, CWA, EU WFD) — supports cross-framework compliance performance comparison."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the regulated parameter that was violated (e.g., Lead, Nitrates, Turbidity) — identifies which contaminants drive the most violations."
    - name: "violation_date_month"
      expr: DATE_TRUNC('month', violation_date)
      comment: "Month the violation occurred — supports trend analysis and seasonal pattern detection."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the violation — tracks progress toward return-to-compliance."
    - name: "enforcement_action_flag"
      expr: enforcement_action_flag
      comment: "Flag indicating an enforcement action has been initiated — used to segment violations by regulatory escalation level."
  measures:
    - name: "total_violations"
      expr: COUNT(violation_id)
      comment: "Total number of regulatory violations recorded. Baseline compliance performance KPI — trends drive regulatory relationship and investment decisions."
    - name: "open_violations"
      expr: COUNT(CASE WHEN is_resolved = FALSE OR is_resolved IS NULL THEN violation_id END)
      comment: "Number of currently unresolved violations. Directly measures outstanding regulatory exposure — a rising count triggers immediate compliance intervention."
    - name: "health_based_violations"
      expr: COUNT(CASE WHEN is_health_based = TRUE THEN violation_id END)
      comment: "Number of violations classified as health-based. The most critical public safety KPI — any increase demands immediate executive and operational response."
    - name: "significant_noncompliance_violations"
      expr: COUNT(CASE WHEN is_significant_noncompliance = TRUE THEN violation_id END)
      comment: "Count of Significant Non-Compliance (SNC) violations. SNC status triggers mandatory regulatory escalation, public reporting, and potential consent orders."
    - name: "repeat_violations"
      expr: COUNT(CASE WHEN is_repeat_violation = TRUE THEN violation_id END)
      comment: "Number of repeat violations. Repeat violations indicate systemic process failures and carry elevated penalty risk — a key process quality KPI."
    - name: "total_penalty_amount_usd"
      expr: SUM(CAST(penalty_amount_usd AS DOUBLE))
      comment: "Total financial penalties assessed for violations in USD. Direct measure of regulatory financial exposure — tracked by finance and legal leadership."
    - name: "avg_penalty_amount_usd"
      expr: AVG(CAST(penalty_amount_usd AS DOUBLE))
      comment: "Average penalty amount per violation in USD. Benchmarks penalty severity and informs cost-benefit analysis of compliance investment vs. penalty risk."
    - name: "violations_with_enforcement_action"
      expr: COUNT(CASE WHEN enforcement_action_flag = TRUE THEN violation_id END)
      comment: "Number of violations that have escalated to formal enforcement action. Measures regulatory escalation rate — a leading indicator of consent order and litigation risk."
    - name: "violations_requiring_public_notification"
      expr: COUNT(CASE WHEN public_notification_required_flag = TRUE THEN violation_id END)
      comment: "Number of violations requiring public notification. Tracks public communication obligations — missed notifications carry independent regulatory penalties."
    - name: "resolved_violations"
      expr: COUNT(CASE WHEN is_resolved = TRUE THEN violation_id END)
      comment: "Number of violations successfully resolved. Measures compliance remediation throughput — used alongside open violations to compute resolution rate in BI."
    - name: "total_mcl_exceedance_value"
      expr: SUM(CAST(mcl_value AS DOUBLE))
      comment: "Sum of measured MCL (Maximum Contaminant Level) values across violations. Quantifies the aggregate magnitude of contaminant exceedances for public health risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_enforcement_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPIs for regulatory enforcement actions against the water utility. Tracks penalty exposure, recovery, resolution timelines, and escalation patterns to support legal, finance, and executive risk management."
  source: "`vibe_water_utilities_v1`.`compliance`.`enforcement_action`"
  filter: record_status = 'ACTIVE' OR record_status IS NULL
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of enforcement action (e.g., Notice of Violation, Consent Order, Administrative Order) — primary segmentation for severity and legal exposure analysis."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the enforcement action (e.g., Open, Resolved, Appealed) — drives legal workload and resolution tracking."
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Regulatory agency that issued the enforcement action — used to segment enforcement activity by regulator relationship."
    - name: "issuing_agency_region"
      expr: issuing_agency_region
      comment: "Regional office of the issuing agency — supports geographic segmentation of enforcement exposure."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Final outcome of the enforcement action (e.g., Penalty Paid, Consent Order, Dismissed) — tracks resolution quality and legal strategy effectiveness."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Flag indicating an appeal was filed — tracks contested enforcement actions and associated legal costs."
    - name: "compliance_schedule_required_flag"
      expr: compliance_schedule_required_flag
      comment: "Flag indicating a compliance schedule was required as part of the enforcement action — tracks remediation obligations."
    - name: "supplemental_environmental_project_flag"
      expr: supplemental_environmental_project_flag
      comment: "Flag indicating a Supplemental Environmental Project (SEP) was included — SEPs reduce cash penalties in exchange for environmental investments."
    - name: "action_date_month"
      expr: DATE_TRUNC('month', action_date)
      comment: "Month the enforcement action was issued — supports trend analysis of enforcement activity over time."
    - name: "public_notice_required_flag"
      expr: public_notice_required_flag
      comment: "Flag indicating public notice was required for the enforcement action — tracks public communication obligations."
  measures:
    - name: "total_enforcement_actions"
      expr: COUNT(enforcement_action_id)
      comment: "Total number of enforcement actions received. Baseline regulatory risk KPI — trends directly inform executive risk assessments and regulatory relationship strategy."
    - name: "total_civil_penalty_assessed_usd"
      expr: SUM(CAST(civil_penalty_amount AS DOUBLE))
      comment: "Total civil penalties assessed across all enforcement actions in USD. Primary financial risk KPI for legal and finance leadership — drives penalty reserve provisioning."
    - name: "total_penalty_paid_usd"
      expr: SUM(CAST(penalty_paid_amount AS DOUBLE))
      comment: "Total penalties actually paid in USD. Used alongside total assessed to compute payment completion rate and outstanding liability in BI."
    - name: "total_sep_estimated_cost_usd"
      expr: SUM(CAST(sep_estimated_cost AS DOUBLE))
      comment: "Total estimated cost of Supplemental Environmental Projects (SEPs) committed as part of enforcement resolutions. Measures environmental investment obligations arising from enforcement."
    - name: "avg_civil_penalty_usd"
      expr: AVG(CAST(civil_penalty_amount AS DOUBLE))
      comment: "Average civil penalty per enforcement action in USD. Benchmarks penalty severity over time and across agencies — informs legal strategy and settlement negotiations."
    - name: "open_enforcement_actions"
      expr: COUNT(CASE WHEN action_status NOT IN ('Resolved', 'Closed', 'Dismissed') THEN enforcement_action_id END)
      comment: "Number of currently open enforcement actions. Measures outstanding regulatory legal exposure — a rising count triggers legal resource escalation."
    - name: "appealed_enforcement_actions"
      expr: COUNT(CASE WHEN appeal_filed_flag = TRUE THEN enforcement_action_id END)
      comment: "Number of enforcement actions where an appeal was filed. Tracks contested regulatory decisions — informs legal resource planning and litigation risk."
    - name: "enforcement_actions_with_compliance_schedule"
      expr: COUNT(CASE WHEN compliance_schedule_required_flag = TRUE THEN enforcement_action_id END)
      comment: "Number of enforcement actions requiring a compliance schedule. Measures the volume of active remediation obligations — each represents an ongoing operational commitment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_dmr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge Monitoring Report (DMR) submission performance and compliance KPIs. Tracks on-time submission rates, noncompliance flags, exceedances, and reporting quality to support NPDES and EU UWWTD regulatory obligations."
  source: "`vibe_water_utilities_v1`.`compliance`.`dmr`"
  filter: record_status = 'ACTIVE' OR record_status IS NULL
  dimensions:
    - name: "dmr_status"
      expr: dmr_status
      comment: "Current status of the DMR (e.g., Submitted, Accepted, Rejected, Pending) — primary operational status dimension for submission workflow management."
    - name: "submission_status"
      expr: submission_status
      comment: "Regulatory submission status of the DMR — tracks whether the report has been accepted by the regulatory authority."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction for the DMR — enables geographic and regulatory-body segmentation."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Governing regulatory framework (e.g., NPDES, EU UWWTD) — supports cross-framework DMR performance comparison."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of DMR reporting obligation (e.g., Monthly, Quarterly) — used to segment submission performance by reporting cycle."
    - name: "noncompliance_flag"
      expr: noncompliance_flag
      comment: "Flag indicating the DMR contains a noncompliance finding — primary compliance risk indicator for DMR submissions."
    - name: "late_submission_flag"
      expr: late_submission_flag
      comment: "Flag indicating the DMR was submitted after the due date — late submissions are independent regulatory violations."
    - name: "eu_uwwtd_reporting_flag"
      expr: eu_uwwtd_reporting_flag
      comment: "Flag indicating the DMR is subject to EU Urban Wastewater Treatment Directive reporting — segments EU-specific compliance obligations."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Month of the DMR reporting period start — supports time-series analysis of submission and compliance trends."
    - name: "resubmission_flag"
      expr: resubmission_flag
      comment: "Flag indicating this DMR is a resubmission — high resubmission rates signal data quality or process issues."
    - name: "jurisdictional_report_type"
      expr: jurisdictional_report_type
      comment: "Type of jurisdictional report (e.g., state, federal, EU) — supports multi-jurisdiction reporting performance analysis."
  measures:
    - name: "total_dmrs"
      expr: COUNT(dmr_id)
      comment: "Total number of Discharge Monitoring Reports. Baseline KPI for DMR reporting volume — used to normalize compliance rates and benchmark reporting workload."
    - name: "dmrs_with_noncompliance"
      expr: COUNT(CASE WHEN noncompliance_flag = TRUE THEN dmr_id END)
      comment: "Number of DMRs containing a noncompliance finding. Core regulatory performance KPI — directly measures discharge compliance failures reported to regulators."
    - name: "late_dmr_submissions"
      expr: COUNT(CASE WHEN late_submission_flag = TRUE THEN dmr_id END)
      comment: "Number of DMRs submitted after the regulatory due date. Late submissions are independent violations — a rising count triggers process improvement and penalty risk."
    - name: "dmr_resubmissions"
      expr: COUNT(CASE WHEN resubmission_flag = TRUE THEN dmr_id END)
      comment: "Number of DMRs that required resubmission. High resubmission rates indicate data quality or process failures — drives investment in reporting automation."
    - name: "dmrs_no_discharge"
      expr: COUNT(CASE WHEN no_discharge_flag = TRUE THEN dmr_id END)
      comment: "Number of DMRs reporting no discharge during the period. Tracks operational periods with zero discharge — relevant for capacity utilization and permit condition compliance."
    - name: "dmrs_accepted"
      expr: COUNT(CASE WHEN submission_status = 'Accepted' THEN dmr_id END)
      comment: "Number of DMRs accepted by the regulatory authority. Used alongside total DMRs to compute acceptance rate in BI — measures submission quality."
    - name: "dmrs_rejected"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN dmr_id END)
      comment: "Number of DMRs rejected by the regulatory authority. Rejection triggers resubmission obligations and may constitute a reporting violation — a key quality KPI."
    - name: "eu_uwwtd_dmrs"
      expr: COUNT(CASE WHEN eu_uwwtd_reporting_flag = TRUE THEN dmr_id END)
      comment: "Number of DMRs subject to EU Urban Wastewater Treatment Directive reporting. Tracks EU-specific reporting volume for utilities operating under EU regulatory frameworks."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_dmr_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parameter-level DMR result KPIs tracking exceedances, measured values, detection limits, and violation rates. Enables parameter-by-parameter compliance performance analysis to drive treatment process improvements and regulatory risk management."
  source: "`vibe_water_utilities_v1`.`compliance`.`dmr_result`"
  filter: record_status = 'ACTIVE' OR record_status IS NULL
  dimensions:
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the regulated parameter measured (e.g., BOD, TSS, Phosphorus) — primary dimension for parameter-level compliance performance analysis."
    - name: "parameter_code"
      expr: parameter_code
      comment: "Regulatory code for the measured parameter — used for cross-system parameter matching and regulatory reporting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the individual result (e.g., In Compliance, Exceedance) — primary compliance classification dimension."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Flag indicating the measured value exceeded the permit limit — primary exceedance indicator for parameter-level risk analysis."
    - name: "is_violation"
      expr: is_violation
      comment: "Flag indicating the result constitutes a regulatory violation — distinguishes exceedances that rise to the level of a formal violation."
    - name: "enforcement_action_required"
      expr: enforcement_action_required
      comment: "Flag indicating the result requires an enforcement action — highest severity classification for DMR results."
    - name: "monitoring_location_code"
      expr: monitoring_location_code
      comment: "Code identifying the monitoring location (e.g., outfall, influent, effluent) — enables location-level compliance performance analysis."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample collected (e.g., Grab, Composite) — used to segment results by sampling methodology."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "Frequency at which the parameter is monitored — used to assess monitoring compliance and data completeness."
    - name: "analysis_date_month"
      expr: DATE_TRUNC('month', analysis_date)
      comment: "Month of sample analysis — supports time-series trend analysis of parameter compliance performance."
    - name: "violation_category"
      expr: violation_category
      comment: "Category of violation associated with the result — supports violation type distribution analysis at the parameter level."
  measures:
    - name: "total_dmr_results"
      expr: COUNT(dmr_result_id)
      comment: "Total number of DMR parameter results. Baseline KPI for monitoring data volume — used to normalize exceedance and violation rates."
    - name: "total_exceedances"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN dmr_result_id END)
      comment: "Total number of permit limit exceedances across all parameters. Core discharge compliance KPI — directly measures treatment process performance against regulatory limits."
    - name: "total_violations"
      expr: COUNT(CASE WHEN is_violation = TRUE THEN dmr_result_id END)
      comment: "Number of DMR results that constitute formal regulatory violations. Measures the subset of exceedances that trigger regulatory consequences — key legal and compliance risk KPI."
    - name: "results_requiring_enforcement"
      expr: COUNT(CASE WHEN enforcement_action_required = TRUE THEN dmr_result_id END)
      comment: "Number of DMR results flagged as requiring enforcement action. Highest-severity operational KPI — each result represents a potential formal enforcement proceeding."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured parameter value across results. Tracks central tendency of discharge quality — used to assess treatment process performance relative to permit limits."
    - name: "avg_exceedance_percentage"
      expr: AVG(CAST(exceedance_percentage AS DOUBLE))
      comment: "Average percentage by which measured values exceed permit limits. Quantifies the magnitude of exceedances — a high average signals systemic treatment underperformance."
    - name: "max_exceedance_percentage"
      expr: MAX(CAST(exceedance_percentage AS DOUBLE))
      comment: "Maximum single exceedance percentage recorded. Identifies worst-case discharge events — used for regulatory risk assessment and incident investigation prioritization."
    - name: "avg_detection_limit"
      expr: AVG(CAST(detection_limit AS DOUBLE))
      comment: "Average analytical detection limit across results. Monitors laboratory analytical capability — detection limits above regulatory thresholds indicate analytical method compliance issues."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_regulatory_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory inspection outcomes, deficiency rates, enforcement escalations, and follow-up obligations. Supports operational readiness management and regulatory relationship strategy for water utility leadership."
  source: "`vibe_water_utilities_v1`.`compliance`.`regulatory_inspection`"
  filter: record_status = 'ACTIVE' OR record_status IS NULL
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of regulatory inspection (e.g., Routine, Complaint-Driven, Follow-Up) — primary segmentation for inspection program analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., Scheduled, Completed, Pending Report) — tracks inspection lifecycle and outstanding obligations."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the inspection (e.g., Satisfactory, Deficient, Significant Deficiency) — primary performance outcome dimension."
    - name: "inspecting_agency"
      expr: inspecting_agency
      comment: "Name of the regulatory agency conducting the inspection — used to segment inspection performance by regulator."
    - name: "significant_deficiency_flag"
      expr: significant_deficiency_flag
      comment: "Flag indicating a significant deficiency was identified — significant deficiencies trigger mandatory corrective action and potential enforcement."
    - name: "enforcement_action_flag"
      expr: enforcement_action_flag
      comment: "Flag indicating the inspection resulted in an enforcement action — highest severity inspection outcome."
    - name: "violation_identified_flag"
      expr: violation_identified_flag
      comment: "Flag indicating a regulatory violation was identified during the inspection — key compliance risk indicator."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Flag indicating corrective action was required as a result of the inspection — tracks remediation obligations arising from inspections."
    - name: "follow_up_inspection_required_flag"
      expr: follow_up_inspection_required_flag
      comment: "Flag indicating a follow-up inspection was required — tracks unresolved inspection findings requiring re-verification."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of the inspection — supports trend analysis of inspection frequency and outcomes over time."
    - name: "inspection_scope"
      expr: inspection_scope
      comment: "Scope of the inspection (e.g., Full Facility, Focused, Records Only) — used to segment inspection depth and associated finding rates."
  measures:
    - name: "total_inspections"
      expr: COUNT(regulatory_inspection_id)
      comment: "Total number of regulatory inspections conducted. Baseline KPI for inspection activity volume — used to normalize deficiency and violation rates."
    - name: "inspections_with_significant_deficiency"
      expr: COUNT(CASE WHEN significant_deficiency_flag = TRUE THEN regulatory_inspection_id END)
      comment: "Number of inspections resulting in a significant deficiency finding. Significant deficiencies are the most serious inspection outcomes — each triggers mandatory corrective action and potential enforcement."
    - name: "inspections_with_violation"
      expr: COUNT(CASE WHEN violation_identified_flag = TRUE THEN regulatory_inspection_id END)
      comment: "Number of inspections where a regulatory violation was identified. Measures inspection-driven violation discovery rate — a key operational compliance performance KPI."
    - name: "inspections_resulting_in_enforcement"
      expr: COUNT(CASE WHEN enforcement_action_flag = TRUE THEN regulatory_inspection_id END)
      comment: "Number of inspections that escalated to formal enforcement action. Measures the most severe inspection outcomes — directly informs regulatory risk and legal exposure."
    - name: "inspections_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN regulatory_inspection_id END)
      comment: "Number of inspections requiring corrective action. Tracks the volume of active remediation obligations arising from inspections — drives operational improvement planning."
    - name: "inspections_requiring_follow_up"
      expr: COUNT(CASE WHEN follow_up_inspection_required_flag = TRUE THEN regulatory_inspection_id END)
      comment: "Number of inspections requiring a follow-up inspection. Measures unresolved inspection findings — a high count signals persistent compliance gaps."
    - name: "completed_inspections"
      expr: COUNT(CASE WHEN inspection_status = 'Completed' THEN regulatory_inspection_id END)
      comment: "Number of inspections with a completed status. Used alongside total inspections to compute completion rate in BI — tracks inspection program throughput."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`compliance_regulatory_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for the regulatory requirement portfolio — tracking active obligations, MCL/MCLG standards, compliance deadlines, and requirement coverage by framework and jurisdiction. Supports regulatory change management and compliance program planning."
  source: "`vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`"
  filter: record_status = 'ACTIVE' OR record_status IS NULL
  dimensions:
    - name: "requirement_category"
      expr: requirement_category
      comment: "Category of the regulatory requirement (e.g., Monitoring, Reporting, Treatment Technique, MCL) — primary segmentation for compliance program analysis."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Governing regulatory framework (e.g., SDWA, CWA, EU WFD) — supports cross-framework requirement portfolio analysis."
    - name: "regulatory_program"
      expr: regulatory_program
      comment: "Specific regulatory program (e.g., Lead and Copper Rule, Surface Water Treatment Rule) — enables program-level compliance obligation tracking."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction of the requirement — supports multi-jurisdiction compliance obligation management."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating the requirement is currently active and enforceable — used to filter the live compliance obligation portfolio."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status against the requirement — primary performance indicator for requirement-level compliance tracking."
    - name: "enforcement_priority"
      expr: enforcement_priority
      comment: "Regulatory enforcement priority level of the requirement — used to prioritize compliance investment and resource allocation."
    - name: "public_notification_required"
      expr: public_notification_required
      comment: "Flag indicating public notification is required for violations of this requirement — tracks public communication obligations in the requirement portfolio."
    - name: "ccr_reporting_required"
      expr: ccr_reporting_required
      comment: "Flag indicating the requirement triggers Consumer Confidence Report (CCR) reporting obligations — tracks annual public reporting requirements."
    - name: "effective_date_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the requirement became effective — supports vintage analysis of the regulatory obligation portfolio."
  measures:
    - name: "total_active_requirements"
      expr: COUNT(CASE WHEN is_active = TRUE THEN regulatory_requirement_id END)
      comment: "Total number of active regulatory requirements. Baseline KPI for compliance obligation portfolio size — growth signals increasing regulatory burden requiring resource investment."
    - name: "requirements_in_compliance"
      expr: COUNT(CASE WHEN compliance_status = 'In Compliance' THEN regulatory_requirement_id END)
      comment: "Number of requirements currently in compliance. Used alongside total active requirements to compute compliance rate in BI — primary regulatory performance KPI."
    - name: "requirements_out_of_compliance"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('In Compliance') AND compliance_status IS NOT NULL THEN regulatory_requirement_id END)
      comment: "Number of requirements currently out of compliance. Directly measures the breadth of regulatory non-compliance — each represents an active violation risk."
    - name: "requirements_with_upcoming_deadline"
      expr: COUNT(CASE WHEN compliance_deadline >= CURRENT_DATE() AND compliance_deadline <= DATE_ADD(CURRENT_DATE(), 90) THEN regulatory_requirement_id END)
      comment: "Number of requirements with compliance deadlines within the next 90 days. Critical forward-looking KPI — drives proactive compliance action planning."
    - name: "avg_mcl_value"
      expr: AVG(CAST(mcl_value AS DOUBLE))
      comment: "Average Maximum Contaminant Level (MCL) value across requirements. Benchmarks the stringency of water quality standards in the active requirement portfolio."
    - name: "requirements_requiring_public_notification"
      expr: COUNT(CASE WHEN public_notification_required = TRUE THEN regulatory_requirement_id END)
      comment: "Number of requirements that mandate public notification upon violation. Tracks public communication obligations — violations of these requirements carry reputational and regulatory risk."
    - name: "ccr_reportable_requirements"
      expr: COUNT(CASE WHEN ccr_reporting_required = TRUE THEN regulatory_requirement_id END)
      comment: "Number of requirements subject to Consumer Confidence Report (CCR) annual reporting. Tracks the scope of annual public water quality reporting obligations."
$$;