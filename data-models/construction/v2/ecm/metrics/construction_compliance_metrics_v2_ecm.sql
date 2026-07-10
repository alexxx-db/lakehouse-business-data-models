-- Metric views for domain: compliance | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks compliance assessment outcomes, risk exposure, financial penalties, and rating scores across projects and jurisdictions. Enables leadership to monitor regulatory standing and prioritize remediation investment."
  source: "`vibe_construction_v1`.`compliance`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment (e.g. internal audit, regulatory review, third-party) for segmenting performance by assessment category."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Regulatory or compliance category (e.g. environmental, safety, financial) to group assessments by domain area."
    - name: "compliance_status_overall"
      expr: compliance_status_overall
      comment: "Overall compliance status of the assessment (e.g. compliant, non-compliant, partial) for executive-level status reporting."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the assessment (e.g. high, medium, low) for risk-tiered reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction applicable to the assessment, enabling geographic compliance analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the assessment is classified as critical, for prioritisation dashboards."
    - name: "is_external_audit"
      expr: is_external_audit
      comment: "Distinguishes external audits from internal assessments for benchmarking and governance reporting."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment date for trend analysis of compliance posture over time."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current workflow status of the assessment (e.g. open, closed, in-review) for pipeline management."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments conducted. Baseline volume metric for audit programme throughput."
    - name: "critical_assessments"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of assessments flagged as critical. Executives use this to gauge severity of the compliance portfolio."
    - name: "non_compliant_assessments"
      expr: COUNT(CASE WHEN compliance_status_overall = 'non-compliant' THEN 1 END)
      comment: "Count of assessments with a non-compliant overall status. Directly drives remediation prioritisation decisions."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties identified across all assessments. Key financial risk exposure metric for CFO and legal teams."
    - name: "avg_rating_score"
      expr: AVG(CAST(rating_score AS DOUBLE))
      comment: "Average compliance rating score across assessments. Tracks overall compliance maturity and improvement over time."
    - name: "avg_penalty_per_assessment"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per assessment. Indicates typical financial exposure per compliance event."
    - name: "external_audit_count"
      expr: COUNT(CASE WHEN is_external_audit = TRUE THEN 1 END)
      comment: "Number of external audits conducted. Tracks third-party scrutiny volume for governance reporting."
    - name: "high_risk_assessments"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN 1 END)
      comment: "Count of high-risk assessments. Triggers executive escalation and resource reallocation when elevated."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_audit_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures audit programme performance including findings volume, scores, remediation timelines, and risk ratings. Supports audit committee reporting and continuous improvement tracking."
  source: "`vibe_construction_v1`.`compliance`.`audit_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of audit report (e.g. internal, external, regulatory) for segmenting audit programme by category."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status recorded in the audit report for executive status dashboards."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the audit report (e.g. high, medium, low) for risk-tiered portfolio views."
    - name: "audit_report_status"
      expr: audit_report_status
      comment: "Current workflow status of the audit report (e.g. draft, issued, closed) for pipeline management."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the report for access control and governance reporting."
    - name: "audit_period_start_month"
      expr: DATE_TRUNC('MONTH', audit_period_start)
      comment: "Month of audit period start for temporal trend analysis of audit coverage."
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the audit (e.g. financial, operational, safety) for coverage analysis."
  measures:
    - name: "total_audit_reports"
      expr: COUNT(1)
      comment: "Total number of audit reports issued. Baseline measure of audit programme activity."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average audit score across all reports. Tracks overall compliance quality trend for executive steering."
    - name: "total_overall_score"
      expr: SUM(CAST(overall_score AS DOUBLE))
      comment: "Sum of audit scores used as denominator component for weighted scoring calculations in BI."
    - name: "high_risk_reports"
      expr: COUNT(CASE WHEN risk_rating = 'high' THEN 1 END)
      comment: "Number of audit reports rated high risk. Directly informs audit committee escalation decisions."
    - name: "open_reports"
      expr: COUNT(CASE WHEN audit_report_status NOT IN ('closed', 'issued') THEN 1 END)
      comment: "Count of audit reports not yet closed or issued. Indicates audit backlog requiring management attention."
    - name: "avg_days_to_remediation"
      expr: AVG(CAST(DATEDIFF(remediation_due_date, approval_date) AS DOUBLE))
      comment: "Average days between audit approval and remediation due date. Measures urgency and adequacy of remediation timelines."
    - name: "non_compliant_reports"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Count of audit reports with non-compliant status. Key indicator of systemic compliance failures requiring intervention."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors permit portfolio health including active permits, expiry risk, fee expenditure, and suspension rates. Critical for project delivery risk management and regulatory standing."
  source: "`vibe_construction_v1`.`compliance`.`compliance_permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g. environmental, building, occupancy) for portfolio segmentation."
    - name: "permit_category"
      expr: permit_category
      comment: "Category of permit for grouping by regulatory domain (e.g. planning, environmental, safety)."
    - name: "compliance_permit_status"
      expr: compliance_permit_status
      comment: "Current status of the permit (e.g. active, expired, suspended) for portfolio health dashboards."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance standing of the permit for regulatory reporting."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the permit for prioritised renewal and monitoring."
    - name: "is_active"
      expr: is_active
      comment: "Whether the permit is currently active, for active portfolio filtering."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Flag indicating permit requires renewal, for proactive renewal pipeline management."
    - name: "suspension_flag"
      expr: suspension_flag
      comment: "Flag indicating permit is currently suspended, a critical operational risk indicator."
    - name: "expiry_year_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of permit expiry for forward-looking renewal planning."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits in the portfolio. Baseline measure for permit management scope."
    - name: "active_permits"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active permits. Executives use this to confirm regulatory authorisation coverage."
    - name: "suspended_permits"
      expr: COUNT(CASE WHEN suspension_flag = TRUE THEN 1 END)
      comment: "Number of suspended permits. A suspended permit can halt project work — this is a critical operational risk metric."
    - name: "permits_requiring_renewal"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN 1 END)
      comment: "Count of permits flagged for renewal. Drives proactive renewal workload planning."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fees across the portfolio. Tracks regulatory compliance cost for budget management."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average permit fee. Benchmarks permit cost by type and jurisdiction for procurement planning."
    - name: "fee_paid_permits"
      expr: COUNT(CASE WHEN fee_paid_flag = TRUE THEN 1 END)
      comment: "Number of permits with fees paid. Unpaid fees risk permit suspension — this metric drives accounts payable prioritisation."
    - name: "high_risk_permits"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN 1 END)
      comment: "Count of high-risk permits. Informs executive escalation and dedicated compliance resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks compliance findings by severity, type, financial impact, and resolution status. Enables root-cause analysis, remediation prioritisation, and regulatory risk quantification."
  source: "`vibe_construction_v1`.`compliance`.`finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of compliance finding (e.g. non-conformance, observation, major finding) for categorised reporting."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the finding (e.g. high, medium, low) for risk-tiered remediation prioritisation."
    - name: "finding_status"
      expr: finding_status
      comment: "Current resolution status of the finding (e.g. open, in-progress, closed) for pipeline management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance standing associated with the finding for regulatory reporting."
    - name: "is_financial_related"
      expr: is_financial_related
      comment: "Flag indicating the finding has financial implications, for CFO-level risk reporting."
    - name: "is_privacy_related"
      expr: is_privacy_related
      comment: "Flag indicating the finding relates to privacy/data protection, for DPO and legal reporting."
    - name: "reported_date_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month findings were reported for trend analysis of compliance issue emergence."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of compliance findings. Baseline measure of compliance issue volume across the organisation."
    - name: "open_findings"
      expr: COUNT(CASE WHEN finding_status = 'open' THEN 1 END)
      comment: "Number of unresolved open findings. Directly measures outstanding compliance risk exposure."
    - name: "high_risk_findings"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN 1 END)
      comment: "Count of high-risk findings. Triggers executive escalation and priority remediation resource allocation."
    - name: "total_financial_impact"
      expr: SUM(CAST(impact_amount AS DOUBLE))
      comment: "Total financial impact of all findings. Quantifies the monetary cost of compliance failures for CFO reporting."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score across findings. Tracks overall compliance health trend for steering committees."
    - name: "privacy_related_findings"
      expr: COUNT(CASE WHEN is_privacy_related = TRUE THEN 1 END)
      comment: "Count of privacy-related findings. Critical for GDPR compliance reporting and DPO oversight."
    - name: "financial_related_findings"
      expr: COUNT(CASE WHEN is_financial_related = TRUE THEN 1 END)
      comment: "Count of findings with financial implications. Informs financial risk register and audit committee reporting."
    - name: "avg_days_to_resolution"
      expr: AVG(CAST(DATEDIFF(resolution_date, reported_date) AS DOUBLE))
      comment: "Average days from finding report to resolution. Measures remediation velocity — a key operational efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors the regulatory obligation portfolio including active obligations, penalty exposure, compliance status, and review cadence. Enables proactive regulatory risk management and resource planning."
  source: "`vibe_construction_v1`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation for regulatory standing dashboards."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the obligation for prioritised compliance management."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the regulatory obligation for geographic compliance analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the obligation is currently active, for active portfolio filtering."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the obligation is mandatory vs. voluntary, for prioritisation of compliance effort."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body issuing the obligation for authority-level compliance reporting."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty associated with non-compliance (e.g. fine, suspension, prosecution) for risk classification."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations tracked. Baseline measure of regulatory compliance scope."
    - name: "active_obligations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active regulatory obligations. Defines the live compliance workload."
    - name: "non_compliant_obligations"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Count of obligations currently in non-compliant status. Directly quantifies regulatory breach exposure."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty amount across all obligations. Key financial risk metric for CFO and legal counsel."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per obligation. Benchmarks typical regulatory financial exposure for risk provisioning."
    - name: "mandatory_obligations"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Count of mandatory obligations. Mandatory obligations carry highest compliance risk and must be prioritised."
    - name: "high_risk_obligations"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN 1 END)
      comment: "Count of high-risk obligations. Informs executive escalation and dedicated compliance resource allocation."
    - name: "obligations_due_for_review"
      expr: COUNT(CASE WHEN next_review_date <= CURRENT_DATE() THEN 1 END)
      comment: "Number of obligations where the next review date has passed. Drives compliance review scheduling and avoids lapses."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks compliance corrective actions including cost, completion rates, monitoring requirements, and repeat action patterns. Enables management to assess remediation effectiveness and cost of compliance."
  source: "`vibe_construction_v1`.`compliance`.`compliance_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of compliance action (e.g. corrective, preventive, monitoring) for categorised performance reporting."
    - name: "compliance_action_status"
      expr: compliance_action_status
      comment: "Current status of the compliance action (e.g. open, in-progress, closed) for pipeline management."
    - name: "compliance_area"
      expr: compliance_area
      comment: "Compliance area the action addresses (e.g. environmental, safety, financial) for domain-level analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the compliance action for prioritised resource allocation."
    - name: "priority"
      expr: priority
      comment: "Priority level of the action (e.g. critical, high, medium, low) for workload management."
    - name: "is_external"
      expr: is_external
      comment: "Whether the action involves an external authority or party, for external engagement tracking."
    - name: "is_repeat_action"
      expr: is_repeat_action
      comment: "Flag indicating this is a repeat compliance action, signalling systemic issues requiring root-cause intervention."
    - name: "monitoring_required"
      expr: monitoring_required
      comment: "Whether ongoing monitoring is required for the action, for resource planning."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the action is due for forward-looking workload and deadline management."
  measures:
    - name: "total_actions"
      expr: COUNT(1)
      comment: "Total number of compliance actions. Baseline measure of remediation workload."
    - name: "open_actions"
      expr: COUNT(CASE WHEN compliance_action_status = 'open' THEN 1 END)
      comment: "Number of open compliance actions. Measures outstanding remediation backlog requiring management attention."
    - name: "repeat_actions"
      expr: COUNT(CASE WHEN is_repeat_action = TRUE THEN 1 END)
      comment: "Count of repeat compliance actions. High repeat rates indicate systemic failures and ineffective root-cause remediation."
    - name: "total_actual_cost"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost incurred for compliance actions. Tracks the financial cost of compliance remediation."
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of compliance actions. Used for budget forecasting and cost-of-compliance reporting."
    - name: "avg_actual_cost"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost per compliance action. Benchmarks remediation cost efficiency."
    - name: "actions_requiring_monitoring"
      expr: COUNT(CASE WHEN monitoring_required = TRUE THEN 1 END)
      comment: "Count of actions requiring ongoing monitoring. Drives monitoring resource planning and scheduling."
    - name: "high_priority_open_actions"
      expr: COUNT(CASE WHEN priority IN ('critical', 'high') AND compliance_action_status = 'open' THEN 1 END)
      comment: "Count of open high-priority or critical compliance actions. Directly triggers executive escalation when elevated."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_iso_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures ISO audit programme performance including audit scores, non-conformances, corrective action rates, and certification body coverage. Supports quality management system governance and certification maintenance."
  source: "`vibe_construction_v1`.`compliance`.`iso_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of ISO audit (e.g. surveillance, recertification, internal) for programme segmentation."
    - name: "standard_audited"
      expr: standard_audited
      comment: "ISO standard being audited (e.g. ISO 9001, ISO 14001, ISO 45001) for standard-level compliance tracking."
    - name: "audit_outcome"
      expr: audit_outcome
      comment: "Outcome of the ISO audit (e.g. pass, conditional pass, fail) for certification risk assessment."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status resulting from the audit for regulatory standing dashboards."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the audit for prioritised follow-up management."
    - name: "iso_audit_status"
      expr: iso_audit_status
      comment: "Current workflow status of the audit (e.g. planned, in-progress, completed) for programme management."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required following the audit, for remediation pipeline management."
    - name: "audit_date_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month of audit for temporal trend analysis of ISO compliance performance."
  measures:
    - name: "total_iso_audits"
      expr: COUNT(1)
      comment: "Total number of ISO audits conducted. Baseline measure of audit programme activity."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average ISO audit score. Tracks quality management system maturity and improvement over time."
    - name: "total_audit_score"
      expr: SUM(CAST(audit_score AS DOUBLE))
      comment: "Sum of audit scores for weighted average calculations in BI layer."
    - name: "audits_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of audits requiring corrective action. Measures the volume of non-conformances requiring remediation."
    - name: "total_audit_duration_hours"
      expr: SUM(CAST(audit_duration_hours AS DOUBLE))
      comment: "Total hours spent on ISO audits. Tracks audit programme resource consumption for capacity planning."
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average audit duration in hours. Benchmarks audit efficiency and identifies outliers requiring investigation."
    - name: "follow_up_audits_scheduled"
      expr: COUNT(CASE WHEN follow_up_audit_scheduled_flag = TRUE THEN 1 END)
      comment: "Count of audits with a follow-up audit scheduled. Indicates volume of unresolved issues requiring re-audit."
    - name: "failed_audits"
      expr: COUNT(CASE WHEN audit_outcome = 'fail' THEN 1 END)
      comment: "Number of failed ISO audits. A critical metric — failed audits risk certification loss and project delivery impact."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_leed_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks LEED certification progress, points achievement, and certification level attainment across projects. Enables sustainability performance reporting and green building target management."
  source: "`vibe_construction_v1`.`compliance`.`leed_certification`"
  dimensions:
    - name: "certification_level_target"
      expr: certification_level_target
      comment: "Target LEED certification level (e.g. Certified, Silver, Gold, Platinum) for goal-setting and gap analysis."
    - name: "certification_level_awarded"
      expr: certification_level_awarded
      comment: "Actual LEED certification level awarded for achievement reporting and benchmarking."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of LEED certification (e.g. BD+C, ID+C, O+M) for programme segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the LEED certification process for regulatory and sustainability reporting."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the certification (e.g. registered, submitted, awarded) for pipeline management."
    - name: "project_phase"
      expr: project_phase
      comment: "Project phase during which certification is being pursued for phase-level sustainability tracking."
    - name: "award_year"
      expr: DATE_TRUNC('YEAR', award_date)
      comment: "Year of LEED award for annual sustainability achievement reporting."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of LEED certifications tracked. Baseline measure of green building programme scope."
    - name: "total_points_awarded"
      expr: SUM(CAST(total_points_awarded AS DOUBLE))
      comment: "Total LEED points awarded across all certifications. Quantifies overall sustainability achievement."
    - name: "avg_points_awarded"
      expr: AVG(CAST(total_points_awarded AS DOUBLE))
      comment: "Average LEED points awarded per certification. Benchmarks sustainability performance across projects."
    - name: "total_points_targeted"
      expr: SUM(CAST(total_points_targeted AS DOUBLE))
      comment: "Total LEED points targeted across certifications. Used as denominator for points achievement rate in BI."
    - name: "total_points_available"
      expr: SUM(CAST(total_points_available AS DOUBLE))
      comment: "Total LEED points available across certifications. Provides maximum achievable benchmark for gap analysis."
    - name: "avg_points_targeted"
      expr: AVG(CAST(total_points_targeted AS DOUBLE))
      comment: "Average points targeted per certification. Tracks ambition level of sustainability programme."
    - name: "certifications_awarded"
      expr: COUNT(CASE WHEN certification_level_awarded IS NOT NULL THEN 1 END)
      comment: "Number of certifications that have been awarded. Measures green building programme delivery success."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_leed_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks LEED credit achievement at the individual credit level, enabling detailed sustainability gap analysis and points optimisation across credit categories."
  source: "`vibe_construction_v1`.`compliance`.`leed_credit`"
  dimensions:
    - name: "credit_category"
      expr: credit_category
      comment: "LEED credit category (e.g. Energy & Atmosphere, Water Efficiency, Materials) for category-level sustainability analysis."
    - name: "leed_credit_status"
      expr: leed_credit_status
      comment: "Current status of the LEED credit (e.g. attempted, awarded, denied) for achievement tracking."
    - name: "review_status"
      expr: review_status
      comment: "Review status of the credit submission for pipeline management."
    - name: "is_eligible"
      expr: is_eligible
      comment: "Whether the project is eligible for this credit, for eligibility-adjusted gap analysis."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit credit evidence for process efficiency analysis."
  measures:
    - name: "total_credits"
      expr: COUNT(1)
      comment: "Total number of LEED credits tracked. Baseline measure of sustainability credit portfolio scope."
    - name: "total_points_awarded"
      expr: SUM(CAST(points_awarded AS DOUBLE))
      comment: "Total LEED points awarded across all credits. Core sustainability achievement metric."
    - name: "total_points_targeted"
      expr: SUM(CAST(points_targeted AS DOUBLE))
      comment: "Total points targeted across credits. Used as denominator for credit achievement rate in BI."
    - name: "total_points_available"
      expr: SUM(CAST(points_available AS DOUBLE))
      comment: "Total points available across credits. Provides maximum achievable benchmark for gap analysis."
    - name: "avg_points_awarded"
      expr: AVG(CAST(points_awarded AS DOUBLE))
      comment: "Average points awarded per credit. Benchmarks credit-level sustainability performance."
    - name: "eligible_credits"
      expr: COUNT(CASE WHEN is_eligible = TRUE THEN 1 END)
      comment: "Count of credits the project is eligible for. Defines the achievable sustainability ceiling."
    - name: "awarded_credits"
      expr: COUNT(CASE WHEN leed_credit_status = 'awarded' THEN 1 END)
      comment: "Number of credits successfully awarded. Measures sustainability delivery success at credit level."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_env_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks environmental monitoring measurements including exceedances, threshold breaches, and measurement values by parameter and location. Enables environmental compliance management and regulatory reporting."
  source: "`vibe_construction_v1`.`compliance`.`env_monitoring`"
  dimensions:
    - name: "monitoring_type"
      expr: monitoring_type
      comment: "Type of environmental monitoring (e.g. air quality, noise, water, soil) for parameter-level analysis."
    - name: "parameter"
      expr: parameter
      comment: "Environmental parameter being monitored (e.g. PM2.5, NOx, pH) for pollutant-level compliance tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the monitoring reading for regulatory standing dashboards."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Whether the measurement exceeded the regulatory threshold — the primary environmental compliance risk indicator."
    - name: "env_monitoring_status"
      expr: env_monitoring_status
      comment: "Current status of the monitoring record for data quality and completeness tracking."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action taken following an exceedance for remediation pipeline management."
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', monitoring_timestamp)
      comment: "Month of monitoring for temporal trend analysis of environmental performance."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for the monitored parameter for consistent cross-parameter reporting."
  measures:
    - name: "total_monitoring_records"
      expr: COUNT(1)
      comment: "Total number of environmental monitoring records. Baseline measure of monitoring programme coverage."
    - name: "exceedance_count"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Number of monitoring readings that exceeded regulatory thresholds. Critical environmental compliance risk metric."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across monitoring records. Tracks environmental parameter trends against thresholds."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average regulatory threshold value for context in exceedance analysis."
    - name: "max_measured_value"
      expr: MAX(CAST(measured_value AS DOUBLE))
      comment: "Maximum measured value recorded. Identifies worst-case environmental events for regulatory reporting."
    - name: "non_compliant_readings"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Count of non-compliant monitoring readings. Directly quantifies environmental regulatory breach frequency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors regulatory submission performance including submission volumes, fee expenditure, acknowledgement rates, and confidential submission tracking. Supports regulatory affairs management and reporting obligations."
  source: "`vibe_construction_v1`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g. annual report, incident notification, permit application) for portfolio segmentation."
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Current status of the submission (e.g. submitted, acknowledged, rejected) for pipeline management."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the submission for domain-level regulatory reporting."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit (e.g. online portal, post, email) for process efficiency analysis."
    - name: "acknowledgement_received"
      expr: acknowledgement_received
      comment: "Whether acknowledgement has been received from the regulatory authority — unacknowledged submissions carry compliance risk."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Whether the submission is confidential for access control and governance reporting."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for temporal trend analysis of regulatory reporting activity."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions. Baseline measure of regulatory reporting activity."
    - name: "acknowledged_submissions"
      expr: COUNT(CASE WHEN acknowledgement_received = TRUE THEN 1 END)
      comment: "Number of submissions acknowledged by the regulatory authority. Unacknowledged submissions may indicate compliance gaps."
    - name: "unacknowledged_submissions"
      expr: COUNT(CASE WHEN acknowledgement_received = FALSE OR acknowledgement_received IS NULL THEN 1 END)
      comment: "Count of submissions without acknowledgement. Drives follow-up actions with regulatory authorities."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees paid for regulatory submissions. Tracks cost of regulatory compliance for budget management."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee per regulatory submission. Benchmarks submission cost by type and authority."
    - name: "confidential_submissions"
      expr: COUNT(CASE WHEN is_confidential = TRUE THEN 1 END)
      comment: "Count of confidential regulatory submissions. Tracks sensitive regulatory communications for governance oversight."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks privacy and data breach incidents including severity, financial exposure, notification obligations, and remediation status. Critical for GDPR compliance, DPO reporting, and regulatory breach management."
  source: "`vibe_construction_v1`.`compliance`.`privacy_incident`"
  dimensions:
    - name: "breach_type"
      expr: breach_type
      comment: "Type of privacy breach (e.g. unauthorised access, data loss, accidental disclosure) for incident categorisation."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity level of the breach (e.g. critical, high, medium, low) for risk-tiered response management."
    - name: "privacy_incident_status"
      expr: privacy_incident_status
      comment: "Current status of the privacy incident (e.g. open, under investigation, closed) for pipeline management."
    - name: "data_subject_type"
      expr: data_subject_type
      comment: "Type of data subject affected (e.g. employee, customer, contractor) for impact scoping."
    - name: "data_category"
      expr: data_category
      comment: "Category of personal data involved (e.g. health, financial, identity) for regulatory classification."
    - name: "notification_obligation_triggered"
      expr: notification_obligation_triggered
      comment: "Whether the incident triggered a regulatory notification obligation (e.g. GDPR 72-hour rule) — a critical compliance flag."
    - name: "regulatory_report_submitted"
      expr: regulatory_report_submitted
      comment: "Whether the regulatory report has been submitted, for compliance deadline tracking."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_timestamp)
      comment: "Month of incident for temporal trend analysis of privacy breach frequency."
  measures:
    - name: "total_privacy_incidents"
      expr: COUNT(1)
      comment: "Total number of privacy incidents recorded. Baseline measure of data protection risk exposure."
    - name: "notification_obligation_incidents"
      expr: COUNT(CASE WHEN notification_obligation_triggered = TRUE THEN 1 END)
      comment: "Count of incidents triggering regulatory notification obligations. Directly measures GDPR breach reporting exposure."
    - name: "unreported_notifiable_incidents"
      expr: COUNT(CASE WHEN notification_obligation_triggered = TRUE AND regulatory_report_submitted = FALSE THEN 1 END)
      comment: "Count of notifiable incidents where regulatory report has not been submitted. Critical compliance gap — triggers immediate escalation."
    - name: "total_estimated_fine"
      expr: SUM(CAST(estimated_fine_amount AS DOUBLE))
      comment: "Total estimated regulatory fines across all privacy incidents. Quantifies financial exposure from data breaches."
    - name: "avg_estimated_fine"
      expr: AVG(CAST(estimated_fine_amount AS DOUBLE))
      comment: "Average estimated fine per privacy incident. Benchmarks typical financial exposure per breach event."
    - name: "total_data_volume_records"
      expr: SUM(CAST(data_volume_records AS DOUBLE))
      comment: "Total number of personal data records affected across all incidents. Measures scale of data exposure for regulatory reporting."
    - name: "individuals_notified_count"
      expr: COUNT(CASE WHEN individuals_notified_flag = TRUE THEN 1 END)
      comment: "Count of incidents where affected individuals have been notified. Tracks GDPR individual notification compliance."
    - name: "legal_hold_incidents"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Count of incidents under legal hold. Indicates active litigation or regulatory investigation exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_authority_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory authority notices including penalties, response compliance, appeal activity, and resolution outcomes. Enables proactive management of regulatory enforcement actions."
  source: "`vibe_construction_v1`.`compliance`.`authority_notice`"
  dimensions:
    - name: "notice_type"
      expr: notice_type
      comment: "Type of authority notice (e.g. infringement, stop-work, improvement) for enforcement action categorisation."
    - name: "authority_type"
      expr: authority_type
      comment: "Type of issuing authority (e.g. environmental, safety, planning) for authority-level analysis."
    - name: "authority_notice_status"
      expr: authority_notice_status
      comment: "Current status of the notice (e.g. open, appealed, resolved) for enforcement pipeline management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the notice (e.g. critical, major, minor) for risk-tiered response prioritisation."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the notice for domain-level enforcement analysis."
    - name: "appeal_lodged_flag"
      expr: appeal_lodged_flag
      comment: "Whether an appeal has been lodged against the notice, for legal proceedings tracking."
    - name: "response_submitted_flag"
      expr: response_submitted_flag
      comment: "Whether a response has been submitted to the authority, for deadline compliance tracking."
    - name: "notice_month"
      expr: DATE_TRUNC('MONTH', notice_date)
      comment: "Month the notice was issued for temporal trend analysis of enforcement activity."
  measures:
    - name: "total_notices"
      expr: COUNT(1)
      comment: "Total number of authority notices received. Baseline measure of regulatory enforcement exposure."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties across all authority notices. Key financial risk metric for CFO and legal teams."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per authority notice. Benchmarks typical enforcement financial exposure."
    - name: "notices_without_response"
      expr: COUNT(CASE WHEN response_submitted_flag = FALSE OR response_submitted_flag IS NULL THEN 1 END)
      comment: "Count of notices where no response has been submitted. Unresponded notices risk escalation and additional penalties."
    - name: "appealed_notices"
      expr: COUNT(CASE WHEN appeal_lodged_flag = TRUE THEN 1 END)
      comment: "Number of notices under appeal. Tracks legal challenge activity and associated cost exposure."
    - name: "open_notices"
      expr: COUNT(CASE WHEN authority_notice_status = 'open' THEN 1 END)
      comment: "Count of open authority notices. Measures outstanding enforcement exposure requiring active management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_pci_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks PCI DSS assessment performance including compliance levels, risk scores, remediation costs, and control pass/fail rates. Supports payment card security governance and audit readiness."
  source: "`vibe_construction_v1`.`compliance`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of PCI assessment (e.g. SAQ, QSA, ISA) for assessment programme segmentation."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for temporal trend analysis of PCI compliance posture."
  measures:
    - name: "total_pci_assessments"
      expr: COUNT(1)
      comment: "Total number of PCI assessments conducted. Baseline measure of payment security audit programme activity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_waiver_exemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors regulatory waivers and exemptions including financial impact, expiry risk, and monitoring compliance. Enables proactive management of conditional regulatory relief and associated obligations."
  source: "`vibe_construction_v1`.`compliance`.`waiver_exemption`"
  dimensions:
    - name: "waiver_type"
      expr: waiver_type
      comment: "Type of waiver or exemption (e.g. environmental, planning, safety) for portfolio segmentation."
    - name: "waiver_category"
      expr: waiver_category
      comment: "Category of the waiver for domain-level analysis of regulatory relief."
    - name: "waiver_exemption_status"
      expr: waiver_exemption_status
      comment: "Current status of the waiver (e.g. active, expired, revoked) for portfolio health monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the waiver conditions for regulatory standing reporting."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the waiver for prioritised monitoring and renewal management."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether the waiver requires renewal, for proactive renewal pipeline management."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the waiver for geographic compliance analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month waiver became effective for temporal portfolio analysis."
  measures:
    - name: "total_waivers"
      expr: COUNT(1)
      comment: "Total number of regulatory waivers and exemptions. Baseline measure of conditional regulatory relief portfolio."
    - name: "total_financial_impact_estimate"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of waivers. Quantifies the value of regulatory relief obtained."
    - name: "avg_financial_impact_estimate"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average financial impact per waiver. Benchmarks the value of individual regulatory exemptions."
    - name: "waivers_requiring_renewal"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN 1 END)
      comment: "Count of waivers flagged for renewal. Drives proactive renewal workload planning to avoid lapses."
    - name: "expiring_waivers"
      expr: COUNT(CASE WHEN effective_until <= DATE_ADD(CURRENT_DATE(), 90) AND waiver_exemption_status = 'active' THEN 1 END)
      comment: "Count of active waivers expiring within 90 days. Triggers proactive renewal actions to maintain regulatory relief."
    - name: "non_compliant_waivers"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Count of waivers where conditions are not being met. Non-compliance with waiver conditions risks revocation and penalties."
$$;