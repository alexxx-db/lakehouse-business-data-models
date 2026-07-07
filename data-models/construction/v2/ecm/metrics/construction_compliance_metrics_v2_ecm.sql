-- Metric views for domain: compliance | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures compliance assessment outcomes, ratings, and financial penalties. Enables leadership to track assessment performance, identify critical compliance gaps, and manage penalty exposure."
  source: "`vibe_construction_v1`.`compliance`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (internal, external, regulatory) for portfolio segmentation."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment for pipeline management."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category assessed (environmental, safety, financial) for cross-domain analysis."
    - name: "compliance_rating"
      expr: compliance_rating
      comment: "Rating outcome of the assessment for performance benchmarking."
    - name: "compliance_status_overall"
      expr: compliance_status_overall
      comment: "Overall compliance status resulting from the assessment."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level identified in the assessment for executive risk reporting."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the assessment identified critical compliance issues."
    - name: "is_external_audit"
      expr: is_external_audit
      comment: "Flag indicating whether the assessment was conducted by an external auditor."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the assessment for geographic compliance analysis."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment for trend and scheduling analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for penalty amount reporting."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments conducted. Baseline measure of compliance program activity."
    - name: "critical_assessment_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of assessments flagged as critical. Drives executive escalation and remediation prioritisation."
    - name: "external_audit_count"
      expr: COUNT(CASE WHEN is_external_audit = TRUE THEN 1 END)
      comment: "Number of external audits conducted. Indicates regulatory scrutiny level."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts identified across assessments. Core financial risk KPI for compliance management."
    - name: "avg_rating_score"
      expr: AVG(CAST(rating_score AS DOUBLE))
      comment: "Average compliance rating score. Tracks overall compliance performance trend for executive reporting."
    - name: "avg_penalty_per_assessment"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per assessment. Benchmarks financial risk per compliance review cycle."
    - name: "high_risk_assessment_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk assessments. Informs risk mitigation investment decisions."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_assessment_by_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assessment counts broken out by type, status and jurisdiction for operational monitoring"
  source: "`construction_ecm`.`compliance`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Category of assessment (e.g., Safety, Environmental)"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Number of assessments"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_pci_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks PCI DSS assessment outcomes, control pass/fail rates, and compliance costs. Enables leadership to manage payment card data security compliance and associated financial risk."
  source: "`vibe_construction_v1`.`compliance`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of PCI assessment (SAQ, QSA, ISA) for compliance program segmentation."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment for compliance cycle management."
  measures:
    - name: "total_pci_assessments"
      expr: COUNT(1)
      comment: "Total PCI DSS assessments conducted. Baseline measure of payment security compliance program activity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_audit_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks audit report outcomes, scores, and finding volumes. Enables leadership to monitor audit program effectiveness, compliance health trends, and remediation urgency."
  source: "`vibe_construction_v1`.`compliance`.`audit_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of audit report (internal, external, regulatory) for portfolio segmentation."
    - name: "audit_report_status"
      expr: audit_report_status
      comment: "Current status of the audit report for pipeline management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status resulting from the audit."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the audit report for executive risk reporting."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the audit report."
    - name: "audit_period_start_month"
      expr: DATE_TRUNC('month', audit_period_start)
      comment: "Month the audit period started for trend analysis."
    - name: "approval_date_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month the audit report was approved for reporting cycle analysis."
  measures:
    - name: "total_audit_reports"
      expr: COUNT(1)
      comment: "Total number of audit reports produced. Baseline measure of audit program activity."
    - name: "avg_audit_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score. Primary KPI for tracking compliance health trend across the organisation."
    - name: "max_audit_score"
      expr: MAX(CAST(overall_score AS DOUBLE))
      comment: "Maximum audit score achieved. Benchmarks best-in-class compliance performance."
    - name: "min_audit_score"
      expr: MIN(CAST(overall_score AS DOUBLE))
      comment: "Minimum audit score recorded. Identifies worst-performing compliance areas requiring intervention."
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS BIGINT))
      comment: "Total critical findings across all audit reports. High counts signal systemic compliance failures requiring executive action."
    - name: "total_noncritical_findings"
      expr: SUM(CAST(noncritical_findings_count AS BIGINT))
      comment: "Total non-critical findings. Tracks overall finding volume for compliance improvement programs."
    - name: "reports_pending_remediation"
      expr: COUNT(CASE WHEN audit_report_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of audit reports with open remediation. Indicates outstanding compliance obligations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_authority_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory authority notices, penalty exposure, and response compliance. Enables leadership to manage enforcement actions, financial penalties, and regulatory relationships."
  source: "`vibe_construction_v1`.`compliance`.`authority_notice`"
  dimensions:
    - name: "notice_type"
      expr: notice_type
      comment: "Type of authority notice (infringement, direction, improvement notice) for enforcement analysis."
    - name: "authority_notice_status"
      expr: authority_notice_status
      comment: "Current status of the notice for resolution pipeline management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the notice for executive risk prioritisation."
    - name: "authority_type"
      expr: authority_type
      comment: "Type of issuing authority (environmental, safety, financial) for regulatory relationship management."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the notice for cross-domain analysis."
    - name: "appeal_lodged_flag"
      expr: appeal_lodged_flag
      comment: "Flag indicating whether an appeal has been lodged against the notice."
    - name: "response_submitted_flag"
      expr: response_submitted_flag
      comment: "Flag indicating whether a response has been submitted to the authority."
    - name: "penalty_currency"
      expr: penalty_currency
      comment: "Currency of the penalty for financial reporting."
    - name: "notice_date_month"
      expr: DATE_TRUNC('month', CAST(notice_date AS DATE))
      comment: "Month the notice was issued for enforcement trend analysis."
  measures:
    - name: "total_authority_notices"
      expr: COUNT(1)
      comment: "Total authority notices received. Baseline measure of regulatory enforcement exposure."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties from authority notices. Core financial risk KPI for executive reporting."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per authority notice. Benchmarks enforcement severity trend."
    - name: "unresponded_notice_count"
      expr: COUNT(CASE WHEN response_submitted_flag = FALSE OR response_submitted_flag IS NULL THEN 1 END)
      comment: "Number of notices without a submitted response. Indicates regulatory non-compliance risk requiring immediate action."
    - name: "appealed_notice_count"
      expr: COUNT(CASE WHEN appeal_lodged_flag = TRUE THEN 1 END)
      comment: "Number of notices under appeal. Tracks legal challenge activity and associated cost exposure."
    - name: "response_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN response_submitted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of authority notices with a submitted response. KPI for regulatory responsiveness and compliance culture."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_env_impact_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks environmental impact assessment outcomes, approval status, and regulatory submission compliance. Enables leadership to manage environmental approval pipelines and project delivery risk."
  source: "`vibe_construction_v1`.`compliance`.`env_impact_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of environmental impact assessment (EIA, ESIA, screening) for regulatory process management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the assessment for project delivery risk management."
    - name: "overall_status"
      expr: overall_status
      comment: "Overall status of the environmental assessment for portfolio health monitoring."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level identified in the assessment for executive prioritisation."
    - name: "environmental_category"
      expr: environmental_category
      comment: "Environmental category of the assessment (air, water, biodiversity) for impact analysis."
    - name: "epa_report_submitted"
      expr: epa_report_submitted
      comment: "Flag indicating whether the EPA report has been submitted."
    - name: "iso_14001_compliant"
      expr: iso_14001_compliant
      comment: "Flag indicating ISO 14001 compliance status of the assessment."
    - name: "project_phase"
      expr: project_phase
      comment: "Project phase during which the assessment was conducted."
    - name: "assessment_date_year"
      expr: DATE_TRUNC('year', assessment_date)
      comment: "Year of assessment for portfolio trend analysis."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total environmental impact assessments conducted. Baseline measure of environmental compliance program scope."
    - name: "approved_assessment_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved environmental assessments. Tracks regulatory approval pipeline throughput."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('Approved', 'Rejected', 'Withdrawn') THEN 1 END)
      comment: "Number of assessments pending regulatory approval. Indicates project delivery risk from environmental approval delays."
    - name: "epa_submitted_count"
      expr: COUNT(CASE WHEN epa_report_submitted = TRUE THEN 1 END)
      comment: "Number of assessments with EPA reports submitted. Tracks regulatory reporting compliance."
    - name: "iso_14001_compliant_count"
      expr: COUNT(CASE WHEN iso_14001_compliant = TRUE THEN 1 END)
      comment: "Number of assessments meeting ISO 14001 requirements. Tracks environmental management system compliance."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of environmental assessments approved. Strategic KPI for environmental regulatory relationship health."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_env_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks environmental monitoring measurements, exceedances, and compliance status. Enables leadership to manage environmental regulatory compliance and identify sites with threshold breaches."
  source: "`vibe_construction_v1`.`compliance`.`env_monitoring`"
  dimensions:
    - name: "monitoring_type"
      expr: monitoring_type
      comment: "Type of environmental monitoring (air quality, noise, water, soil) for parameter-specific analysis."
    - name: "parameter"
      expr: parameter
      comment: "Environmental parameter being monitored (PM2.5, NOx, pH) for regulatory threshold tracking."
    - name: "env_monitoring_status"
      expr: env_monitoring_status
      comment: "Current status of the monitoring record for compliance pipeline management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the monitoring result against regulatory thresholds."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Flag indicating whether the measured value exceeded the regulatory threshold. Critical for enforcement risk management."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for the monitored parameter."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action taken following an exceedance."
    - name: "monitoring_date_month"
      expr: DATE_TRUNC('month', CAST(monitoring_timestamp AS DATE))
      comment: "Month of monitoring for trend and seasonal analysis."
  measures:
    - name: "total_monitoring_records"
      expr: COUNT(1)
      comment: "Total environmental monitoring records. Baseline measure of monitoring program coverage."
    - name: "exceedance_count"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Number of threshold exceedances recorded. Core environmental compliance KPI — high counts trigger regulatory enforcement risk."
    - name: "exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring readings that exceeded regulatory thresholds. Strategic KPI for environmental compliance health."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across monitoring records. Tracks environmental parameter trends against thresholds."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average regulatory threshold value. Provides context for measured value analysis."
    - name: "max_measured_value"
      expr: MAX(CAST(measured_value AS DOUBLE))
      comment: "Maximum measured value recorded. Identifies worst-case environmental exposure for regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks compliance findings by severity, type, and resolution status. Enables leadership to assess systemic compliance gaps, financial exposure from findings, and remediation velocity."
  source: "`vibe_construction_v1`.`compliance`.`finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding (non-conformance, observation, major, minor) for severity-based analysis."
    - name: "finding_status"
      expr: finding_status
      comment: "Current resolution status of the finding for pipeline management."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the finding for executive risk reporting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status associated with the finding."
    - name: "is_financial_related"
      expr: is_financial_related
      comment: "Flag indicating whether the finding has financial implications."
    - name: "is_privacy_related"
      expr: is_privacy_related
      comment: "Flag indicating whether the finding relates to privacy/data protection obligations."
    - name: "reported_date_month"
      expr: DATE_TRUNC('month', reported_date)
      comment: "Month the finding was reported for trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial impact reporting."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of compliance findings. Baseline measure of compliance gap volume."
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN finding_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Number of unresolved findings. High open counts indicate unmitigated compliance risk."
    - name: "high_risk_findings_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk findings. Directly informs executive risk escalation decisions."
    - name: "financial_findings_count"
      expr: COUNT(CASE WHEN is_financial_related = TRUE THEN 1 END)
      comment: "Number of findings with financial implications. Quantifies financial compliance exposure."
    - name: "privacy_findings_count"
      expr: COUNT(CASE WHEN is_privacy_related = TRUE THEN 1 END)
      comment: "Number of privacy-related findings. Informs data protection risk management."
    - name: "total_financial_impact"
      expr: SUM(CAST(impact_amount AS DOUBLE))
      comment: "Total financial impact of findings. Core KPI for quantifying cost of non-compliance."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score across findings. Tracks overall compliance health trend over time."
    - name: "max_severity_score"
      expr: MAX(CAST(severity_score AS DOUBLE))
      comment: "Maximum severity score recorded. Identifies worst-case compliance exposure for executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_iso_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks ISO audit performance, non-conformance volumes, and corrective action requirements. Enables leadership to manage ISO certification health and continuous improvement programs."
  source: "`vibe_construction_v1`.`compliance`.`iso_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of ISO audit (surveillance, recertification, internal) for program management."
    - name: "iso_audit_status"
      expr: iso_audit_status
      comment: "Current status of the ISO audit for pipeline management."
    - name: "audit_outcome"
      expr: audit_outcome
      comment: "Outcome of the audit (pass, conditional pass, fail) for certification health tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status resulting from the audit."
    - name: "standard_audited"
      expr: standard_audited
      comment: "ISO standard audited (ISO 9001, ISO 14001, ISO 45001) for standard-specific performance analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level identified in the audit for executive risk reporting."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Flag indicating whether corrective action is required following the audit."
    - name: "follow_up_audit_scheduled_flag"
      expr: follow_up_audit_scheduled_flag
      comment: "Flag indicating whether a follow-up audit has been scheduled."
    - name: "audit_date_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month of audit for scheduling and trend analysis."
  measures:
    - name: "total_iso_audits"
      expr: COUNT(1)
      comment: "Total ISO audits conducted. Baseline measure of ISO compliance program activity."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average ISO audit score. Primary KPI for tracking ISO compliance performance trend."
    - name: "total_non_conformances"
      expr: SUM(CAST(non_conformances_count AS BIGINT))
      comment: "Total non-conformances identified across ISO audits. High counts signal systemic quality or compliance failures."
    - name: "total_observations"
      expr: SUM(CAST(observations_count AS BIGINT))
      comment: "Total observations raised in ISO audits. Tracks improvement opportunity volume."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of audits requiring corrective action. Drives remediation workload planning."
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average audit duration in hours. Informs audit resource planning and efficiency benchmarking."
    - name: "total_audit_hours"
      expr: SUM(CAST(audit_duration_hours AS DOUBLE))
      comment: "Total hours invested in ISO audits. Quantifies compliance program resource consumption."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_leed_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks LEED certification progress, points performance, and sustainability compliance. Enables leadership to manage green building certification targets and sustainability commitments."
  source: "`vibe_construction_v1`.`compliance`.`leed_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of LEED certification (BD+C, ID+C, O+M) for program segmentation."
    - name: "certification_level_target"
      expr: certification_level_target
      comment: "Target certification level (Certified, Silver, Gold, Platinum) for ambition tracking."
    - name: "certification_level_awarded"
      expr: certification_level_awarded
      comment: "Actual certification level awarded for performance vs target analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the certification for portfolio health monitoring."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the certification (in-progress, submitted, awarded, expired)."
    - name: "review_status"
      expr: review_status
      comment: "Review status of the certification submission."
    - name: "project_phase"
      expr: project_phase
      comment: "Project phase during which certification is being pursued."
    - name: "award_date_year"
      expr: DATE_TRUNC('year', award_date)
      comment: "Year of certification award for portfolio trend analysis."
  measures:
    - name: "total_leed_certifications"
      expr: COUNT(1)
      comment: "Total LEED certifications in the portfolio. Baseline measure of sustainability certification program scale."
    - name: "total_points_awarded"
      expr: SUM(CAST(total_points_awarded AS DOUBLE))
      comment: "Total LEED points awarded across all certifications. Quantifies sustainability achievement portfolio-wide."
    - name: "total_points_targeted"
      expr: SUM(CAST(total_points_targeted AS DOUBLE))
      comment: "Total LEED points targeted across all certifications. Enables target vs actual gap analysis."
    - name: "avg_points_awarded"
      expr: AVG(CAST(total_points_awarded AS DOUBLE))
      comment: "Average LEED points awarded per certification. Benchmarks sustainability performance per project."
    - name: "avg_points_achievement_pct"
      expr: ROUND(100.0 * SUM(CAST(total_points_awarded AS DOUBLE)) / NULLIF(SUM(CAST(total_points_targeted AS DOUBLE)), 0), 2)
      comment: "Percentage of targeted LEED points actually awarded. Core KPI for sustainability target attainment."
    - name: "total_points_available"
      expr: SUM(CAST(total_points_available AS DOUBLE))
      comment: "Total LEED points available across all certifications. Defines the maximum achievable sustainability score."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_leed_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks LEED credit achievement by category and eligibility. Enables sustainability managers and executives to identify credit gaps and optimise green building point strategies."
  source: "`vibe_construction_v1`.`compliance`.`leed_credit`"
  dimensions:
    - name: "credit_category"
      expr: credit_category
      comment: "LEED credit category (energy, water, materials, indoor quality) for sustainability strategy analysis."
    - name: "leed_credit_status"
      expr: leed_credit_status
      comment: "Current status of the credit (submitted, approved, rejected, pending) for pipeline management."
    - name: "review_status"
      expr: review_status
      comment: "Review status of the credit submission."
    - name: "is_eligible"
      expr: is_eligible
      comment: "Flag indicating whether the project is eligible for this credit."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit credit evidence for process analysis."
    - name: "evidence_submission_date_month"
      expr: DATE_TRUNC('month', evidence_submission_date)
      comment: "Month evidence was submitted for credit submission pipeline analysis."
  measures:
    - name: "total_credits"
      expr: COUNT(1)
      comment: "Total LEED credits tracked. Baseline measure of sustainability credit portfolio scope."
    - name: "eligible_credit_count"
      expr: COUNT(CASE WHEN is_eligible = TRUE THEN 1 END)
      comment: "Number of credits the project is eligible for. Defines the achievable sustainability ceiling."
    - name: "total_points_awarded"
      expr: SUM(CAST(points_awarded AS DOUBLE))
      comment: "Total LEED points awarded across all credits. Core sustainability achievement KPI."
    - name: "total_points_targeted"
      expr: SUM(CAST(points_targeted AS DOUBLE))
      comment: "Total LEED points targeted across all credits. Enables gap analysis against sustainability goals."
    - name: "total_points_available"
      expr: SUM(CAST(points_available AS DOUBLE))
      comment: "Total LEED points available across all credits. Defines maximum achievable score."
    - name: "credit_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(points_awarded AS DOUBLE)) / NULLIF(SUM(CAST(points_available AS DOUBLE)), 0), 2)
      comment: "Percentage of available LEED points actually awarded. Strategic KPI for sustainability performance vs potential."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_permit_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks permit condition compliance, financial penalties, and inspection status. Enables leadership to manage permit condition obligations and avoid enforcement actions."
  source: "`vibe_construction_v1`.`compliance`.`permit_condition`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of permit condition (reporting, monitoring, operational restriction) for obligation categorisation."
    - name: "condition_category"
      expr: condition_category
      comment: "Category of the condition for cross-domain compliance analysis."
    - name: "permit_condition_status"
      expr: permit_condition_status
      comment: "Current status of the condition for compliance pipeline management."
    - name: "condition_priority"
      expr: condition_priority
      comment: "Priority level of the condition for resource allocation."
    - name: "condition_is_mandatory"
      expr: condition_is_mandatory
      comment: "Flag indicating whether the condition is mandatory."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Flag indicating whether inspection is required to verify condition compliance."
    - name: "condition_fine_currency"
      expr: condition_fine_currency
      comment: "Currency of the condition fine for financial reporting."
    - name: "compliance_deadline_month"
      expr: DATE_TRUNC('month', compliance_deadline)
      comment: "Month the condition compliance deadline falls for workload planning."
  measures:
    - name: "total_permit_conditions"
      expr: COUNT(1)
      comment: "Total permit conditions tracked. Baseline measure of permit compliance obligation volume."
    - name: "mandatory_condition_count"
      expr: COUNT(CASE WHEN condition_is_mandatory = TRUE THEN 1 END)
      comment: "Number of mandatory permit conditions. Mandatory conditions carry highest enforcement risk if breached."
    - name: "inspection_required_count"
      expr: COUNT(CASE WHEN inspection_required = TRUE THEN 1 END)
      comment: "Number of conditions requiring inspection. Drives inspection scheduling and resource planning."
    - name: "total_condition_fines"
      expr: SUM(CAST(condition_fine_amount AS DOUBLE))
      comment: "Total fines associated with permit conditions. Quantifies financial penalty exposure from permit non-compliance."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts across permit conditions. Core financial risk KPI for permit compliance management."
    - name: "non_compliant_condition_count"
      expr: COUNT(CASE WHEN permit_condition_status NOT IN ('Compliant', 'Closed', 'Met') THEN 1 END)
      comment: "Number of permit conditions not in compliance. Directly informs enforcement risk escalation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks privacy incidents by severity, breach type, and regulatory notification status. Enables leadership to manage data protection risk, regulatory reporting obligations, and remediation costs."
  source: "`vibe_construction_v1`.`compliance`.`privacy_incident`"
  dimensions:
    - name: "breach_type"
      expr: breach_type
      comment: "Type of privacy breach (unauthorised access, data loss, disclosure) for incident classification."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of the breach for executive risk prioritisation."
    - name: "privacy_incident_status"
      expr: privacy_incident_status
      comment: "Current status of the privacy incident for resolution pipeline management."
    - name: "data_category"
      expr: data_category
      comment: "Category of data involved in the breach for regulatory obligation assessment."
    - name: "data_subject_type"
      expr: data_subject_type
      comment: "Type of data subject affected (employee, customer, contractor) for impact scoping."
    - name: "regulatory_report_submitted"
      expr: regulatory_report_submitted
      comment: "Flag indicating whether the incident has been reported to the regulatory authority."
    - name: "individuals_notified_flag"
      expr: individuals_notified_flag
      comment: "Flag indicating whether affected individuals have been notified."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Flag indicating whether a legal hold has been placed on related data."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for fine and cost reporting."
    - name: "incident_date_month"
      expr: DATE_TRUNC('month', CAST(incident_timestamp AS DATE))
      comment: "Month of incident for trend analysis and regulatory reporting cycles."
  measures:
    - name: "total_privacy_incidents"
      expr: COUNT(1)
      comment: "Total privacy incidents recorded. Baseline measure of data protection risk exposure."
    - name: "unreported_incident_count"
      expr: COUNT(CASE WHEN regulatory_report_submitted = FALSE OR regulatory_report_submitted IS NULL THEN 1 END)
      comment: "Number of incidents not yet reported to regulators. Indicates potential regulatory non-compliance with mandatory notification obligations."
    - name: "total_estimated_fines"
      expr: SUM(CAST(estimated_fine_amount AS DOUBLE))
      comment: "Total estimated regulatory fines from privacy incidents. Core financial risk KPI for data protection governance."
    - name: "avg_estimated_fine"
      expr: AVG(CAST(estimated_fine_amount AS DOUBLE))
      comment: "Average estimated fine per privacy incident. Benchmarks financial exposure per breach event."
    - name: "total_records_affected"
      expr: SUM(CAST(data_volume_records AS DOUBLE))
      comment: "Total number of data records affected by privacy incidents. Quantifies breach scale for regulatory severity assessment."
    - name: "total_data_volume_bytes"
      expr: SUM(CAST(data_volume_bytes AS DOUBLE))
      comment: "Total data volume (bytes) involved in privacy incidents. Informs breach severity classification and regulatory notification thresholds."
    - name: "regulatory_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_report_submitted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privacy incidents reported to regulators. KPI for regulatory notification compliance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_regulatory_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory changes, their implementation status, and financial impact. Enables leadership to manage regulatory change risk, implementation workload, and associated costs."
  source: "`vibe_construction_v1`.`compliance`.`regulatory_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of regulatory change (new regulation, amendment, repeal) for impact classification."
    - name: "regulatory_change_status"
      expr: regulatory_change_status
      comment: "Current status of the regulatory change for implementation pipeline management."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation progress status for change management tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the regulatory change for executive prioritisation."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category affected by the change for cross-domain impact analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the regulatory change is currently active."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag indicating whether implementation is mandatory."
    - name: "jurisdiction_type"
      expr: jurisdiction_type
      comment: "Jurisdiction type of the regulatory change for geographic impact analysis."
    - name: "financial_impact_currency"
      expr: financial_impact_currency
      comment: "Currency of the financial impact estimate."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the regulatory change becomes effective for implementation deadline management."
  measures:
    - name: "total_regulatory_changes"
      expr: COUNT(1)
      comment: "Total regulatory changes tracked. Baseline measure of regulatory change management workload."
    - name: "active_change_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active regulatory changes requiring attention. Defines live change management burden."
    - name: "mandatory_change_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of mandatory regulatory changes. Mandatory changes carry highest non-compliance risk if not implemented."
    - name: "high_risk_change_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk regulatory changes. Drives executive escalation and resource allocation decisions."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of regulatory changes. Core KPI for compliance cost forecasting and budget planning."
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per regulatory change. Benchmarks cost of regulatory compliance per change event."
    - name: "pending_implementation_count"
      expr: COUNT(CASE WHEN implementation_status NOT IN ('Implemented', 'Closed', 'Completed') THEN 1 END)
      comment: "Number of regulatory changes not yet fully implemented. Indicates outstanding compliance implementation risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory obligations by status, risk, and financial exposure. Enables leadership to manage the organisation's regulatory compliance portfolio and associated penalty risk."
  source: "`vibe_construction_v1`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation for health monitoring."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the obligation for executive risk prioritisation."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the obligation for geographic compliance analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the obligation is currently active."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag indicating whether the obligation is mandatory (vs voluntary)."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty for non-compliance (financial, operational, criminal) for risk classification."
    - name: "penalty_currency"
      expr: penalty_currency
      comment: "Currency of the penalty for financial reporting."
    - name: "next_review_date_month"
      expr: DATE_TRUNC('month', next_review_date)
      comment: "Month of next scheduled review for compliance calendar management."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total regulatory obligations tracked. Baseline measure of compliance obligation portfolio size."
    - name: "active_obligation_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active regulatory obligations. Defines the live compliance burden."
    - name: "mandatory_obligation_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of mandatory obligations. Mandatory obligations carry highest non-compliance risk."
    - name: "high_risk_obligation_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk obligations. Drives executive prioritisation of compliance investment."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty exposure across all obligations. Core financial risk KPI for compliance portfolio management."
    - name: "avg_penalty_exposure"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty exposure per obligation. Benchmarks financial risk per regulatory requirement."
    - name: "non_compliant_obligation_count"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('Compliant', 'Closed') THEN 1 END)
      comment: "Number of obligations not currently in compliance. Directly informs regulatory risk escalation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory submission volumes, fees, and compliance with submission deadlines. Enables leadership to manage regulatory reporting obligations and associated financial costs."
  source: "`vibe_construction_v1`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (annual report, incident notification, permit renewal) for obligation tracking."
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Current status of the submission for pipeline management."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the submission for cross-domain analysis."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit (online portal, paper, email) for process efficiency analysis."
    - name: "acknowledgement_received"
      expr: acknowledgement_received
      comment: "Flag indicating whether the regulatory authority acknowledged receipt."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Flag indicating whether the submission is confidential."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for fee reporting."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of submission for regulatory calendar analysis."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total regulatory submissions made. Baseline measure of regulatory reporting compliance activity."
    - name: "acknowledged_submission_count"
      expr: COUNT(CASE WHEN acknowledgement_received = TRUE THEN 1 END)
      comment: "Number of submissions acknowledged by regulatory authorities. Tracks submission acceptance rate."
    - name: "unacknowledged_submission_count"
      expr: COUNT(CASE WHEN acknowledgement_received = FALSE OR acknowledgement_received IS NULL THEN 1 END)
      comment: "Number of submissions not yet acknowledged. Indicates potential regulatory compliance gaps."
    - name: "total_submission_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees paid for regulatory submissions. Core financial KPI for compliance cost management."
    - name: "avg_submission_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee per regulatory submission. Benchmarks regulatory cost per submission type."
    - name: "acknowledgement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgement_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions acknowledged by regulators. KPI for submission quality and completeness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`compliance_waiver_exemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory waivers and exemptions, their financial impact, and renewal status. Enables leadership to manage exemption portfolio value and renewal risk."
  source: "`vibe_construction_v1`.`compliance`.`waiver_exemption`"
  dimensions:
    - name: "waiver_type"
      expr: waiver_type
      comment: "Type of waiver or exemption (temporary, permanent, conditional) for portfolio classification."
    - name: "waiver_category"
      expr: waiver_category
      comment: "Category of the waiver for compliance domain analysis."
    - name: "waiver_exemption_status"
      expr: waiver_exemption_status
      comment: "Current status of the waiver for portfolio health monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status associated with the waiver conditions."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the waiver for executive risk reporting."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Flag indicating whether the waiver requires renewal."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Flag indicating whether the waiver is confidential."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the waiver for geographic compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial impact reporting."
    - name: "effective_from_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the waiver became effective for portfolio vintage analysis."
  measures:
    - name: "total_waivers"
      expr: COUNT(1)
      comment: "Total waivers and exemptions in the portfolio. Baseline measure of regulatory flexibility utilisation."
    - name: "renewal_required_count"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN 1 END)
      comment: "Number of waivers requiring renewal. Drives proactive renewal management to avoid compliance gaps."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of waivers and exemptions. Quantifies the financial value of the exemption portfolio."
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average financial impact per waiver. Benchmarks value per exemption for portfolio prioritisation."
    - name: "high_risk_waiver_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk waivers. High-risk waivers require enhanced monitoring and executive oversight."
$$;
