-- Metric views for domain: compliance | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_ada_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ADA accessibility compliance assessment program — tracks compliance percentages, remediation costs, barrier counts, and certification rates to manage disability access obligations and litigation risk."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`ada_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of ADA assessment (e.g., initial, follow-up, complaint-driven) for program segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current ADA compliance status for regulatory posture tracking."
    - name: "certification_issued_flag"
      expr: certification_issued_flag
      comment: "Whether an ADA compliance certification was issued."
    - name: "guest_rooms_evaluated_flag"
      expr: guest_rooms_evaluated_flag
      comment: "Whether guest rooms were evaluated — core ADA requirement for hospitality properties."
    - name: "meeting_spaces_evaluated_flag"
      expr: meeting_spaces_evaluated_flag
      comment: "Whether meeting spaces were evaluated for ADA compliance."
    - name: "pools_evaluated_flag"
      expr: pools_evaluated_flag
      comment: "Whether pools were evaluated for ADA compliance."
    - name: "assessment_year"
      expr: DATE_TRUNC('YEAR', assessment_date)
      comment: "Year of ADA assessment for trend analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of ADA assessment for operational planning."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total ADA assessments conducted — baseline metric for accessibility compliance program activity."
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average ADA compliance percentage across assessments — primary KPI for accessibility program quality; low scores indicate litigation and regulatory risk."
    - name: "total_remediation_cost"
      expr: SUM(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Total estimated remediation cost for ADA barriers — directly informs CapEx planning and accessibility investment decisions."
    - name: "avg_remediation_cost"
      expr: AVG(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Average remediation cost per assessment — benchmarks accessibility investment requirements across the portfolio."
    - name: "certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN certification_issued_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments resulting in ADA certification — measures accessibility compliance achievement rate."
    - name: "properties_assessed"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with ADA assessments — measures accessibility compliance program coverage."
    - name: "overdue_assessments"
      expr: SUM(CASE WHEN next_assessment_due_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of properties with overdue ADA assessments — operational risk KPI for accessibility compliance currency."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit program performance metrics tracking audit outcomes, costs, findings severity, and compliance certification rates across properties. Enables compliance leadership to monitor audit health, resource spend, and regulatory posture."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, external, regulatory) for segmenting audit performance."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., planned, in-progress, closed) for pipeline analysis."
    - name: "overall_audit_result"
      expr: overall_audit_result
      comment: "Pass/fail/conditional result of the audit for outcome distribution analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the audit for risk-tiered performance views."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the audit was conducted (e.g., ISO, HACCP, PCI-DSS)."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the audit for geographic compliance segmentation."
    - name: "certification_awarded"
      expr: certification_awarded
      comment: "Whether a certification was awarded as a result of the audit."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required, indicating audit quality issues."
    - name: "audit_year"
      expr: YEAR(actual_start_date)
      comment: "Year the audit commenced for trend analysis."
    - name: "audit_month"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month the audit commenced for monthly trend analysis."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted. Baseline volume metric for audit program capacity planning."
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total spend on audits. Drives compliance budget allocation and cost-per-audit benchmarking."
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per audit. Used to benchmark audit efficiency and identify outlier engagements."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average compliance score across all audits. Key indicator of overall regulatory posture."
    - name: "certification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN certification_awarded = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in certification. Measures program effectiveness and regulatory standing."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action. High rates signal systemic compliance gaps requiring executive intervention."
    - name: "follow_up_audit_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_audit_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring a follow-up audit. Indicates unresolved compliance issues and repeat-failure risk."
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(DATEDIFF(actual_end_date, actual_start_date) AS DOUBLE))
      comment: "Average number of days to complete an audit. Measures audit execution efficiency and resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding analytics tracking severity, recurrence, financial impact, and closure performance. Enables compliance and risk leadership to prioritize remediation, track repeat failures, and quantify regulatory exposure."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the audit finding (e.g., safety, financial, operational) for risk-tiered analysis."
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (e.g., open, closed, in-remediation) for pipeline management."
    - name: "compliance_domain"
      expr: compliance_domain
      comment: "Compliance domain the finding belongs to for domain-level risk aggregation."
    - name: "root_cause_classification"
      expr: root_cause_classification
      comment: "Root cause category for systemic issue identification and prevention programs."
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Whether this is a repeat finding, indicating persistent non-compliance."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether the finding requires regulatory reporting, indicating high-severity exposure."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the finding has been escalated for executive attention."
    - name: "guest_impact_flag"
      expr: guest_impact_flag
      comment: "Whether the finding has guest-facing impact, linking compliance to guest experience."
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the finding was identified for trend analysis."
    - name: "identified_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month the finding was identified for monthly trend analysis."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings. Baseline volume for compliance risk exposure assessment."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of audit findings. Quantifies regulatory and remediation cost exposure for CFO-level decisions."
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average financial impact per finding. Benchmarks severity and prioritizes remediation investment."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across findings. Tracks overall compliance risk level over time."
    - name: "repeat_finding_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN repeat_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeat occurrences. High rates indicate systemic non-compliance and failed corrective actions — a critical board-level risk signal."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings escalated. Measures severity concentration and management response effectiveness."
    - name: "open_findings_count"
      expr: SUM(CASE WHEN finding_status != 'closed' THEN 1 ELSE 0 END)
      comment: "Count of findings not yet closed. Tracks remediation backlog and outstanding regulatory exposure."
    - name: "avg_days_to_closure"
      expr: AVG(CAST(DATEDIFF(closure_date, identified_date) AS DOUBLE))
      comment: "Average days from finding identification to closure. Measures remediation velocity and compliance responsiveness."
    - name: "regulatory_reporting_required_count"
      expr: SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of findings requiring regulatory reporting. Directly tracks regulatory notification obligations and legal exposure."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance calendar execution and workload management — tracks obligation completion rates, overdue items, estimated effort and cost, and escalation rates to manage the compliance program pipeline."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`compliance_calendar`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Current completion status of the compliance calendar item (e.g., pending, completed, overdue)."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation for workload categorization."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the compliance calendar item for resource allocation."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the compliance obligation for severity-based prioritization."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the compliance item for accountability tracking."
    - name: "scope_level"
      expr: scope_level
      comment: "Scope of the compliance obligation (e.g., property, portfolio, enterprise)."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation is required for this compliance item."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether a waiver has been granted for this compliance obligation."
    - name: "due_year"
      expr: DATE_TRUNC('YEAR', due_date)
      comment: "Year the compliance item is due for forward planning."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the compliance item is due for near-term workload management."
  measures:
    - name: "total_calendar_items"
      expr: COUNT(1)
      comment: "Total compliance calendar items — baseline metric for compliance program workload."
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance calendar items completed — primary KPI for compliance program execution effectiveness."
    - name: "overdue_items"
      expr: SUM(CASE WHEN completion_status NOT IN ('Completed', 'Waived') AND due_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of overdue compliance calendar items — critical operational risk KPI for compliance backlog management."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost of compliance calendar items — informs compliance budget planning and resource allocation."
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Average estimated cost per compliance item — benchmarks compliance program cost efficiency."
    - name: "total_estimated_effort_hours"
      expr: SUM(CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total estimated effort hours for compliance calendar items — informs staffing and capacity planning for the compliance team."
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance items requiring escalation — measures concentration of high-priority compliance obligations."
    - name: "properties_with_items"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with compliance calendar items — measures compliance program geographic coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training completion metrics tracking pass rates, scores, costs, waiver rates, and renewal compliance. Enables HR and compliance leadership to ensure workforce regulatory readiness, manage training costs, and identify certification gaps."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`compliance_training_completion`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training completion (e.g., compliant, non-compliant, expired) for workforce readiness tracking."
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Pass or fail result of the training for quality and effectiveness analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (e.g., online, classroom, on-the-job) for channel effectiveness analysis."
    - name: "regulatory_category"
      expr: regulatory_category
      comment: "Regulatory category of the training (e.g., food safety, fire safety, data privacy) for compliance domain tracking."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the training is mandatory, prioritizing compliance gap analysis."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether the certification requires renewal, driving recertification planning."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether a training waiver was granted, tracking exemption rates."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction of the training requirement for geographic compliance segmentation."
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month of training completion for trend and deadline analysis."
  measures:
    - name: "total_completions"
      expr: COUNT(1)
      comment: "Total training completions recorded. Baseline for workforce compliance training volume."
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost_amount AS DOUBLE))
      comment: "Total spend on compliance training. Drives training budget management and cost-per-completion benchmarking."
    - name: "avg_training_cost"
      expr: AVG(CAST(training_cost_amount AS DOUBLE))
      comment: "Average cost per training completion. Benchmarks training delivery efficiency across methods and providers."
    - name: "avg_score_achieved"
      expr: AVG(CAST(score_achieved AS DOUBLE))
      comment: "Average score achieved across training completions. Measures workforce knowledge quality and training effectiveness."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_result = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions that passed. Core measure of workforce compliance readiness and training program quality."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_granted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions where a waiver was granted. High rates may indicate compliance risk from undertrained staff."
    - name: "avg_training_duration_hours"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average training duration in hours. Used for workforce capacity planning and training program design."
    - name: "mandatory_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mandatory_flag = TRUE AND pass_fail_result = 'pass' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN mandatory_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Pass rate for mandatory training only. The most critical workforce compliance metric — directly measures regulatory obligation fulfillment."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and preventive action (CAPA) performance metrics tracking cost, timeliness, effectiveness, and recurrence. Enables compliance and operations leadership to evaluate remediation program quality and prevent repeat incidents."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`corrective_action`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of corrective action (e.g., corrective, preventive, both) for program segmentation."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of the corrective action for pipeline and backlog management."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category the corrective action addresses for domain-level remediation tracking."
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action for resource allocation decisions."
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "Rated effectiveness of the corrective action for program quality assessment."
    - name: "recurrence_detected"
      expr: recurrence_detected
      comment: "Whether the issue recurred after corrective action, indicating ineffective remediation."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification was required, indicating high-severity actions."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether escalation was required for this corrective action."
    - name: "target_year"
      expr: YEAR(target_completion_date)
      comment: "Year of target completion for planning and deadline tracking."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total corrective actions initiated. Baseline volume for CAPA program capacity and workload management."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of corrective actions. Quantifies remediation spend for budget and ROI analysis."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective actions. Used for budget forecasting and cost variance analysis."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action. Benchmarks remediation efficiency across categories."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(estimated_cost AS DOUBLE)))
      comment: "Total cost overrun (actual minus estimated) across corrective actions. Measures CAPA budget accuracy and planning quality."
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recurrence_detected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions where the issue recurred. High rates indicate systemic failure in root cause resolution — a critical compliance program quality signal."
    - name: "on_time_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_completion_date <= target_completion_date THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of corrective actions completed on or before target date. Measures remediation discipline and regulatory deadline adherence."
    - name: "avg_days_to_completion"
      expr: AVG(CAST(DATEDIFF(actual_completion_date, created_timestamp) AS DOUBLE))
      comment: "Average days from creation to actual completion. Tracks CAPA cycle time and operational responsiveness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_dpia`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data Protection Impact Assessment (DPIA) program — tracks assessment completion, residual risk levels, supervisory authority consultations, and review currency for GDPR Article 35 compliance."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`dpia`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the DPIA (e.g., approved, pending, rejected)."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after mitigation measures — primary risk KPI for data processing activities."
    - name: "risk_likelihood"
      expr: risk_likelihood
      comment: "Likelihood of privacy risk materializing for probability-weighted analysis."
    - name: "risk_severity"
      expr: risk_severity
      comment: "Severity of identified privacy risks for impact analysis."
    - name: "automated_decision_making_flag"
      expr: automated_decision_making_flag
      comment: "Whether the processing involves automated decision-making — triggers GDPR Article 22 obligations."
    - name: "cross_border_transfer_flag"
      expr: cross_border_transfer_flag
      comment: "Whether data is transferred cross-border — triggers additional GDPR transfer mechanism requirements."
    - name: "special_category_data_flag"
      expr: special_category_data_flag
      comment: "Whether special category data is processed — triggers enhanced GDPR protections."
    - name: "supervisory_authority_consultation_required_flag"
      expr: supervisory_authority_consultation_required_flag
      comment: "Whether supervisory authority consultation is required — indicates highest-risk processing activities."
    - name: "dpo_consultation_flag"
      expr: dpo_consultation_flag
      comment: "Whether the DPO was consulted — measures GDPR governance process adherence."
    - name: "assessment_year"
      expr: DATE_TRUNC('YEAR', assessment_date)
      comment: "Year of DPIA assessment for trend analysis."
  measures:
    - name: "total_dpias"
      expr: COUNT(1)
      comment: "Total DPIAs conducted — baseline metric for GDPR Article 35 compliance program activity."
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DPIAs approved — measures data processing compliance quality."
    - name: "high_residual_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN residual_risk_level IN ('High', 'Critical') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DPIAs with high or critical residual risk — primary KPI for data privacy risk concentration; high rates require DPO and executive attention."
    - name: "supervisory_authority_consultations_required"
      expr: SUM(CASE WHEN supervisory_authority_consultation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DPIAs requiring supervisory authority consultation — measures highest-risk processing activities requiring regulatory engagement."
    - name: "special_category_processing_count"
      expr: SUM(CASE WHEN special_category_data_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DPIAs involving special category data — measures enhanced-risk processing volume requiring additional safeguards."
    - name: "cross_border_transfer_count"
      expr: SUM(CASE WHEN cross_border_transfer_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DPIAs involving cross-border data transfers — drives transfer mechanism compliance requirements."
    - name: "overdue_reviews"
      expr: SUM(CASE WHEN approval_status = 'Approved' AND next_review_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of DPIAs with overdue periodic reviews — measures staleness of privacy risk assessments."
    - name: "dpo_consultation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dpo_consultation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DPIAs with DPO consultation — measures GDPR governance process adherence."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_environmental_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance metrics tracking violation rates, penalty exposure, ESG reporting coverage, and corrective action performance. Enables sustainability and compliance leadership to manage environmental obligations, reduce penalty exposure, and support ESG reporting."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`environmental_compliance`"
  dimensions:
    - name: "compliance_status"
      expr: corrective_action_status
      comment: "Status of corrective action for environmental compliance issues for remediation pipeline management."
    - name: "violation_flag"
      expr: violation_flag
      comment: "Whether a violation was recorded, segmenting compliant vs. non-compliant environmental records."
    - name: "violation_severity"
      expr: violation_severity
      comment: "Severity of the environmental violation for risk-tiered analysis and regulatory response."
    - name: "esg_reporting_flag"
      expr: esg_reporting_flag
      comment: "Whether the record is subject to ESG reporting, tracking sustainability disclosure obligations."
    - name: "energy_reporting_required_flag"
      expr: energy_reporting_required_flag
      comment: "Whether energy reporting is required, tracking energy compliance obligations."
    - name: "water_reporting_required_flag"
      expr: water_reporting_required_flag
      comment: "Whether water reporting is required, tracking water usage compliance obligations."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required for this environmental compliance record."
    - name: "carbon_emissions_framework"
      expr: carbon_emissions_framework
      comment: "Carbon emissions framework applied (e.g., GHG Protocol, CDP) for ESG program segmentation."
    - name: "inspection_year"
      expr: YEAR(last_inspection_date)
      comment: "Year of last inspection for environmental compliance trend analysis."
  measures:
    - name: "total_environmental_records"
      expr: COUNT(1)
      comment: "Total environmental compliance records. Baseline for environmental obligation portfolio management."
    - name: "total_penalties"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total environmental penalties incurred. Quantifies financial cost of environmental non-compliance for ESG and CFO reporting."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average environmental penalty per record. Benchmarks penalty severity and identifies high-risk environmental categories."
    - name: "violation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN violation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of environmental compliance records with violations. Primary ESG and regulatory posture metric for sustainability reporting."
    - name: "corrective_action_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records requiring corrective action. Measures environmental remediation backlog and compliance gap severity."
    - name: "esg_reporting_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN esg_reporting_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of environmental records subject to ESG reporting. Tracks sustainability disclosure coverage for investor and regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_fire_safety_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fire safety compliance program — tracks inspection currency, compliance status, drill frequency, and violation exposure to manage life safety obligations and insurance requirements."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`fire_safety_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current fire safety compliance status for regulatory posture tracking."
    - name: "fire_alarm_system_type"
      expr: fire_alarm_system_type
      comment: "Type of fire alarm system for asset management and compliance analysis."
    - name: "fire_suppression_system_type"
      expr: fire_suppression_system_type
      comment: "Type of fire suppression system for asset management."
    - name: "emergency_lighting_compliant_flag"
      expr: emergency_lighting_compliant_flag
      comment: "Whether emergency lighting is compliant — life safety requirement."
    - name: "exit_signage_compliant_flag"
      expr: exit_signage_compliant_flag
      comment: "Whether exit signage is compliant — life safety requirement."
    - name: "insurance_notification_required_flag"
      expr: insurance_notification_required_flag
      comment: "Whether insurance notification is required for violations."
    - name: "inspection_year"
      expr: DATE_TRUNC('YEAR', last_inspection_date)
      comment: "Year of last fire safety inspection for trend analysis."
  measures:
    - name: "total_fire_safety_records"
      expr: COUNT(1)
      comment: "Total fire safety records — baseline metric for fire safety compliance program coverage."
    - name: "compliant_properties_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of properties with compliant fire safety status — primary life safety KPI; non-compliance can result in property closure and insurance cancellation."
    - name: "avg_sprinkler_coverage_percentage"
      expr: AVG(CAST(sprinkler_coverage_percentage AS DOUBLE))
      comment: "Average sprinkler system coverage percentage — measures fire suppression adequacy across the portfolio."
    - name: "overdue_inspections"
      expr: SUM(CASE WHEN next_inspection_due_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of properties with overdue fire safety inspections — critical life safety and regulatory compliance KPI."
    - name: "overdue_fire_drills"
      expr: SUM(CASE WHEN fire_drill_next_scheduled_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of properties with overdue fire drills — life safety compliance KPI for emergency preparedness."
    - name: "insurance_notification_required_count"
      expr: SUM(CASE WHEN insurance_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of fire safety records requiring insurance notification — drives insurance relationship management and premium impact."
    - name: "properties_covered"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with fire safety records — measures life safety compliance program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_food_safety_cert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety certification and inspection program — tracks health inspection scores, violation rates, certification currency, and corrective action completion to manage food safety regulatory obligations."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`food_safety_cert`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of food safety certification (e.g., HACCP, ServSafe, local health permit) for program segmentation."
    - name: "certification_name"
      expr: certification_name
      comment: "Name of the food safety certification for portfolio management."
    - name: "health_inspection_grade"
      expr: health_inspection_grade
      comment: "Health inspection grade (e.g., A, B, C) — primary public-facing food safety KPI."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the food safety certification for prioritization."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction of the food safety certification for geographic compliance analysis."
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Whether food safety training is required for certification maintenance."
    - name: "corrective_actions_completed_flag"
      expr: corrective_actions_completed_flag
      comment: "Whether required corrective actions have been completed."
    - name: "inspection_year"
      expr: DATE_TRUNC('YEAR', last_inspection_date)
      comment: "Year of last food safety inspection for trend analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total food safety certifications — baseline metric for food safety compliance program coverage."
    - name: "avg_health_inspection_score"
      expr: AVG(CAST(health_inspection_score AS DOUBLE))
      comment: "Average health inspection score — primary KPI for food safety program quality; low scores trigger regulatory action and reputational damage."
    - name: "corrective_action_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_actions_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of food safety certifications with corrective actions completed — measures remediation effectiveness."
    - name: "overdue_inspections"
      expr: SUM(CASE WHEN next_inspection_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of food safety certifications with overdue inspections — critical operational risk KPI; overdue inspections can result in permit suspension."
    - name: "overdue_training"
      expr: SUM(CASE WHEN training_required_flag = TRUE AND next_training_due_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of certifications with overdue food safety training — measures workforce food safety readiness gaps."
    - name: "outlets_covered"
      expr: COUNT(DISTINCT fnb_outlet_id)
      comment: "Number of distinct F&B outlets with food safety certifications — measures food safety compliance program coverage."
    - name: "properties_covered"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with food safety certifications — measures geographic compliance coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_health_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health and safety incident metrics tracking incident volume, severity, regulatory notifications, and investigation outcomes. Enables safety leadership and executives to monitor workplace safety performance, manage OSHA obligations, and reduce liability exposure."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of health and safety incident (e.g., slip/fall, chemical exposure, equipment injury) for root cause analysis."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (e.g., open, under investigation, closed) for case management."
    - name: "injury_severity"
      expr: injury_severity
      comment: "Severity of injury (e.g., minor, moderate, severe, fatality) for risk-tiered safety analysis."
    - name: "person_type_involved"
      expr: person_type_involved
      comment: "Type of person involved (e.g., employee, guest, contractor) for liability and safety program segmentation."
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the incident is OSHA-recordable, directly tracking regulatory reporting obligations."
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification was required, indicating high-severity incidents."
    - name: "liability_claim_filed_flag"
      expr: liability_claim_filed_flag
      comment: "Whether a liability claim was filed, tracking legal and insurance exposure."
    - name: "workers_compensation_claim_flag"
      expr: workers_compensation_claim_flag
      comment: "Whether a workers compensation claim was filed, tracking workforce injury cost."
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month of incident for trend analysis and seasonal safety pattern identification."
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year of incident for annual safety performance reporting."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total health and safety incidents. Baseline for safety program performance and trend monitoring."
    - name: "osha_recordable_count"
      expr: SUM(CASE WHEN osha_recordable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OSHA-recordable incidents. Primary regulatory compliance metric for workplace safety reporting."
    - name: "osha_recordable_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN osha_recordable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are OSHA-recordable. Tracks regulatory exposure concentration and safety program effectiveness."
    - name: "liability_claim_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN liability_claim_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resulting in liability claims. Measures legal and financial exposure from safety incidents."
    - name: "workers_comp_claim_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN workers_compensation_claim_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resulting in workers compensation claims. Tracks workforce injury cost and insurance impact."
    - name: "regulatory_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring regulatory notification. Measures severity of safety incidents from a regulatory standpoint."
    - name: "avg_investigation_days"
      expr: AVG(CAST(DATEDIFF(investigation_completed_date, incident_date) AS DOUBLE))
      comment: "Average days from incident to investigation completion. Measures safety response speed and regulatory compliance with investigation timelines."
    - name: "medical_treatment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN medical_treatment_provided_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring medical treatment. Indicates physical severity of safety incidents and healthcare cost exposure."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance obligation portfolio metrics tracking status, penalty exposure, waiver rates, and certification compliance. Enables compliance leadership to manage the full obligation inventory, prioritize high-risk obligations, and report on regulatory posture to the board."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (e.g., active, expired, waived, superseded) for portfolio management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the obligation (e.g., compliant, non-compliant, at-risk) for regulatory posture reporting."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the obligation for prioritization and resource allocation."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction of the obligation for geographic compliance portfolio analysis."
    - name: "certification_required_flag"
      expr: certification_required_flag
      comment: "Whether the obligation requires certification, tracking certification-dependent compliance."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether a waiver was granted for the obligation, tracking exemption rates."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the obligation became effective for obligation vintage analysis."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total compliance obligations in the portfolio. Baseline for obligation inventory management and compliance program scope."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts associated with obligations. Quantifies financial exposure from non-compliance across the obligation portfolio."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per obligation. Benchmarks financial risk severity across obligation categories."
    - name: "non_compliant_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'non-compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations currently non-compliant. Primary measure of regulatory posture — high rates require immediate executive intervention."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_granted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations with waivers granted. Tracks exemption reliance and associated compliance risk."
    - name: "overdue_obligation_count"
      expr: SUM(CASE WHEN due_date < CURRENT_DATE AND compliance_status != 'compliant' THEN 1 ELSE 0 END)
      comment: "Count of obligations past due date and not yet compliant. Directly measures outstanding regulatory deadline failures."
    - name: "expiring_within_30_days_count"
      expr: SUM(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN 1 ELSE 0 END)
      comment: "Count of obligations expiring within 30 days. Drives proactive renewal and compliance action prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit portfolio metrics tracking fees, expiration risk, compliance status, and renewal performance. Enables compliance and property operations leadership to manage permit obligations, avoid lapses, and control licensing costs."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g., liquor, building, food service) for portfolio segmentation."
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g., active, expired, suspended, revoked) for compliance posture monitoring."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit for jurisdiction-level compliance tracking."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the permit for geographic compliance analysis."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether the permit requires periodic inspection, driving inspection scheduling."
    - name: "expiry_year"
      expr: YEAR(expiration_date)
      comment: "Year the permit expires for renewal pipeline planning."
    - name: "expiry_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the permit expires for near-term renewal workload forecasting."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits in the portfolio. Baseline for compliance obligation inventory management."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fees paid. Tracks licensing cost for budget management and cost optimization."
    - name: "total_renewal_fee_amount"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees across the permit portfolio. Drives annual compliance budget forecasting."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average permit fee. Benchmarks licensing cost efficiency across permit types and jurisdictions."
    - name: "active_permit_count"
      expr: SUM(CASE WHEN permit_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active permits. Measures compliance coverage and operational licensing health."
    - name: "expired_permit_count"
      expr: SUM(CASE WHEN permit_status = 'expired' THEN 1 ELSE 0 END)
      comment: "Count of expired permits. Directly indicates compliance lapses requiring immediate remediation."
    - name: "suspended_or_revoked_count"
      expr: SUM(CASE WHEN permit_status IN ('suspended', 'revoked') THEN 1 ELSE 0 END)
      comment: "Count of suspended or revoked permits. Critical risk signal indicating regulatory enforcement actions."
    - name: "expiring_within_90_days_count"
      expr: SUM(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 ELSE 0 END)
      comment: "Count of permits expiring within 90 days. Drives proactive renewal prioritization to prevent compliance lapses."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_permit_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit renewal process metrics tracking fees, cycle times, approval rates, and inspection outcomes. Enables compliance operations to optimize renewal workflows, reduce lapse risk, and control renewal costs."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`permit_renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal (e.g., submitted, approved, rejected, pending) for pipeline management."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the renewal inspection for quality and compliance assessment."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the renewal for workload triage and resource allocation."
    - name: "auto_renewal_eligible_flag"
      expr: auto_renewal_eligible_flag
      comment: "Whether the permit is eligible for auto-renewal, indicating process efficiency opportunity."
    - name: "renewal_fee_paid_flag"
      expr: renewal_fee_paid_flag
      comment: "Whether the renewal fee has been paid, tracking payment compliance."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed against a renewal decision, indicating contested renewals."
    - name: "renewal_year"
      expr: YEAR(renewal_request_date)
      comment: "Year of the renewal request for annual volume and cost trend analysis."
  measures:
    - name: "total_renewals"
      expr: COUNT(1)
      comment: "Total permit renewals processed. Baseline for renewal program workload and capacity planning."
    - name: "total_renewal_fees"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees across all renewals. Tracks licensing cost for budget management."
    - name: "avg_renewal_fee"
      expr: AVG(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Average renewal fee per permit. Benchmarks renewal cost efficiency across permit types."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN renewal_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of renewals approved. Measures renewal program success rate and regulatory relationship health."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN renewal_status = 'rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of renewals rejected. High rates signal compliance deficiencies requiring corrective investment."
    - name: "avg_renewal_cycle_days"
      expr: AVG(CAST(DATEDIFF(renewal_approval_date, renewal_request_date) AS DOUBLE))
      comment: "Average days from renewal request to approval. Measures renewal process efficiency and regulatory responsiveness."
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of renewals where an appeal was filed. Indicates contested regulatory decisions and legal exposure."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_policy_acknowledgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy acknowledgment compliance — tracks acknowledgment rates, overdue acknowledgments, and waiver rates to ensure workforce policy awareness and regulatory attestation requirements."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment`"
  dimensions:
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Current status of the acknowledgment (e.g., pending, completed, overdue) for compliance tracking."
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "Method of acknowledgment (e.g., electronic signature, in-person) for audit trail analysis."
    - name: "acknowledgment_channel"
      expr: acknowledgment_channel
      comment: "Channel through which acknowledgment was obtained (e.g., LMS, email, portal)."
    - name: "department_code"
      expr: department_code
      comment: "Department of the acknowledging employee for accountability tracking."
    - name: "re_acknowledgment_required_flag"
      expr: re_acknowledgment_required_flag
      comment: "Whether periodic re-acknowledgment is required — drives renewal pipeline management."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether a waiver was granted for the acknowledgment requirement."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level for overdue acknowledgments."
    - name: "acknowledgment_year"
      expr: DATE_TRUNC('YEAR', acknowledgment_date)
      comment: "Year of acknowledgment for trend analysis."
    - name: "acknowledgment_month"
      expr: DATE_TRUNC('MONTH', acknowledgment_date)
      comment: "Month of acknowledgment for operational planning."
  measures:
    - name: "total_acknowledgments"
      expr: COUNT(1)
      comment: "Total policy acknowledgment records — baseline metric for policy compliance program activity."
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN acknowledgment_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acknowledgments completed — primary KPI for policy compliance; low rates indicate workforce awareness gaps and regulatory risk."
    - name: "overdue_acknowledgments"
      expr: SUM(CASE WHEN acknowledgment_status NOT IN ('Completed', 'Waived') AND acknowledgment_due_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of overdue acknowledgments — operational risk KPI; overdue acknowledgments represent unattested policy exposure."
    - name: "waiver_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_granted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acknowledgments with waivers granted — high rates may indicate systemic compliance capacity issues."
    - name: "avg_days_to_acknowledge"
      expr: AVG(DATEDIFF(acknowledgment_date, acknowledgment_due_date))
      comment: "Average days between acknowledgment and due date (negative = early, positive = late) — measures policy compliance timeliness."
    - name: "employees_acknowledged"
      expr: COUNT(DISTINCT primary_policy_employee_id)
      comment: "Number of distinct employees who have acknowledged policies — measures workforce policy coverage."
    - name: "policies_covered"
      expr: COUNT(DISTINCT policy_id)
      comment: "Number of distinct policies with acknowledgment records — measures policy program breadth."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy incident and data breach metrics tracking severity, regulatory penalties, notification compliance, and investigation performance. Enables privacy, legal, and executive leadership to manage GDPR/CCPA obligations, quantify breach exposure, and demonstrate regulatory accountability."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`privacy_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of privacy incident (e.g., unauthorized access, data loss, phishing) for root cause and prevention analysis."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the privacy incident for case management and regulatory deadline tracking."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the privacy incident for risk-tiered response and reporting."
    - name: "breach_notification_required_flag"
      expr: breach_notification_required_flag
      comment: "Whether breach notification to regulators or subjects is required — a primary GDPR/CCPA compliance indicator."
    - name: "regulatory_penalty_imposed_flag"
      expr: regulatory_penalty_imposed_flag
      comment: "Whether a regulatory penalty was imposed, tracking enforcement actions and financial consequences."
    - name: "dpo_notified_flag"
      expr: dpo_notified_flag
      comment: "Whether the Data Protection Officer was notified, tracking internal governance compliance."
    - name: "subject_notification_required_flag"
      expr: subject_notification_required_flag
      comment: "Whether affected data subjects must be notified, tracking individual rights obligations."
    - name: "legal_counsel_engaged_flag"
      expr: legal_counsel_engaged_flag
      comment: "Whether legal counsel was engaged, indicating high-severity incidents with litigation risk."
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month of incident for trend analysis and regulatory reporting periods."
  measures:
    - name: "total_privacy_incidents"
      expr: COUNT(1)
      comment: "Total privacy incidents recorded. Baseline for data protection program performance monitoring."
    - name: "total_regulatory_penalties"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total regulatory penalties imposed from privacy incidents. Quantifies financial exposure from data protection failures — a critical board-level risk metric."
    - name: "avg_regulatory_penalty"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average regulatory penalty per incident. Benchmarks severity of privacy enforcement actions."
    - name: "breach_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN breach_notification_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privacy incidents requiring breach notification. Measures regulatory notification obligation frequency."
    - name: "penalty_imposition_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_penalty_imposed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resulting in regulatory penalties. Tracks enforcement action rate and regulatory relationship health."
    - name: "legal_engagement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN legal_counsel_engaged_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring legal counsel. Indicates litigation risk concentration and legal cost exposure."
    - name: "avg_investigation_days"
      expr: AVG(CAST(DATEDIFF(investigation_completion_date, incident_date) AS DOUBLE))
      comment: "Average days from incident to investigation completion. Measures privacy response speed against regulatory timelines (e.g., GDPR 72-hour notification)."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing performance metrics tracking submission timeliness, penalties, and filing volume by jurisdiction and type. Enables compliance and finance leadership to manage regulatory deadlines, quantify penalty exposure, and demonstrate filing program effectiveness."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g., tax, environmental, safety) for obligation portfolio segmentation."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (e.g., submitted, accepted, rejected, pending) for deadline management."
    - name: "filing_method"
      expr: filing_method
      comment: "Method of filing (e.g., electronic, paper, portal) for process efficiency analysis."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction of the filing for geographic compliance obligation tracking."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the filing for authority-level compliance management."
    - name: "penalty_assessed_flag"
      expr: penalty_assessed_flag
      comment: "Whether a penalty was assessed for this filing, indicating late or non-compliant submissions."
    - name: "penalty_paid_flag"
      expr: penalty_paid_flag
      comment: "Whether the assessed penalty has been paid, tracking outstanding financial obligations."
    - name: "filing_year"
      expr: YEAR(submission_date)
      comment: "Year of filing submission for annual compliance obligation trend analysis."
    - name: "filing_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of filing submission for monthly deadline and workload management."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total regulatory filings submitted. Baseline for compliance obligation volume and program capacity."
    - name: "total_penalties"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties assessed across all regulatory filings. Quantifies financial cost of non-compliant or late filings — a key CFO and board metric."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per filing. Benchmarks penalty severity and identifies high-risk filing categories."
    - name: "penalty_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN penalty_assessed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings resulting in a penalty. Primary measure of regulatory filing compliance quality."
    - name: "on_time_filing_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN submission_date <= due_date THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of filings submitted on or before the due date. Core compliance timeliness metric for regulatory relationship management."
    - name: "accepted_filing_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN filing_status = 'accepted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings accepted by the regulatory body. Measures filing quality and completeness."
    - name: "avg_days_to_submission"
      expr: AVG(CAST(DATEDIFF(submission_date, due_date) AS DOUBLE))
      comment: "Average days between submission and due date (negative = early, positive = late). Measures filing timeliness discipline across the compliance program."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enterprise risk register metrics tracking financial exposure, mitigation investment, risk distribution, and closure performance. Enables risk and compliance leadership to prioritize risk treatment, allocate mitigation budget, and report to the board on residual risk posture."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g., regulatory, operational, financial) for portfolio-level risk analysis."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g., open, mitigated, accepted, closed) for risk pipeline management."
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk materializing for risk matrix analysis."
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating if the risk materializes for risk matrix analysis."
    - name: "risk_appetite_alignment"
      expr: risk_appetite_alignment
      comment: "Whether the risk is within or outside risk appetite — critical for board-level risk governance."
    - name: "scope_level"
      expr: scope_level
      comment: "Scope level of the risk (e.g., property, portfolio, enterprise) for hierarchical risk aggregation."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether the risk requires escalation to senior leadership."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Subcategory of risk for granular risk taxonomy analysis."
    - name: "identification_year"
      expr: YEAR(identification_date)
      comment: "Year the risk was identified for trend and vintage analysis."
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of risks in the register. Baseline for risk portfolio size and trend monitoring."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of all risks. Quantifies aggregate monetary exposure for CFO and board risk reporting."
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per risk. Benchmarks risk severity and prioritizes mitigation investment."
    - name: "total_mitigation_cost_estimate"
      expr: SUM(CAST(mitigation_cost_estimate AS DOUBLE))
      comment: "Total estimated cost to mitigate all open risks. Drives risk mitigation budget planning and capital allocation."
    - name: "avg_mitigation_cost_estimate"
      expr: AVG(CAST(mitigation_cost_estimate AS DOUBLE))
      comment: "Average mitigation cost per risk. Used to benchmark treatment efficiency across risk categories."
    - name: "open_risk_count"
      expr: SUM(CASE WHEN risk_status != 'closed' THEN 1 ELSE 0 END)
      comment: "Count of open (unresolved) risks. Tracks outstanding risk exposure requiring management attention."
    - name: "outside_risk_appetite_count"
      expr: SUM(CASE WHEN risk_appetite_alignment = 'outside' THEN 1 ELSE 0 END)
      comment: "Count of risks outside the organization's risk appetite. A primary board-level governance metric requiring immediate executive action."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks requiring escalation. Measures severity concentration and governance responsiveness."
    - name: "avg_days_to_closure"
      expr: AVG(CAST(DATEDIFF(actual_closure_date, identification_date) AS DOUBLE))
      comment: "Average days from risk identification to closure. Measures risk treatment velocity and program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_sanction_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanction screening program metrics tracking match rates, risk levels, escalation frequency, and screening coverage. Enables compliance and AML/KYC leadership to manage regulatory screening obligations, quantify sanctions exposure, and demonstrate due diligence effectiveness."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`sanction_screening`"
  dimensions:
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (e.g., guest, vendor, employee, corporate account) for screening program segmentation."
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the screening (e.g., clear, match, pending review) for case management."
    - name: "match_result"
      expr: match_result
      comment: "Result of the screening match (e.g., no match, potential match, confirmed match) for risk analysis."
    - name: "match_disposition"
      expr: match_disposition
      comment: "Disposition of the match (e.g., false positive, true positive, escalated) for screening quality analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the screened entity for risk-tiered compliance management."
    - name: "screening_method"
      expr: screening_method
      comment: "Method used for screening (e.g., automated, manual, third-party) for process efficiency analysis."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting was required for this screening result."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether the screening result required escalation for senior review."
    - name: "screening_month"
      expr: DATE_TRUNC('month', screening_date)
      comment: "Month of screening for volume trend and compliance coverage analysis."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total sanction screenings performed. Baseline for screening program coverage and compliance obligation fulfillment."
    - name: "match_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN match_result != 'no match' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings resulting in a potential or confirmed match. Tracks sanctions exposure concentration in the business relationship portfolio."
    - name: "confirmed_match_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN match_disposition = 'true positive' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings with confirmed true-positive matches. Measures actual sanctions exposure and regulatory notification obligations."
    - name: "false_positive_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN match_disposition = 'false positive' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN match_result != 'no match' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of matches that were false positives. High rates indicate screening model tuning needs and operational inefficiency."
    - name: "avg_match_confidence_score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average confidence score of screening matches. Measures screening model quality and reliability."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings requiring escalation. Tracks high-risk entity concentration and compliance team workload."
    - name: "regulatory_reporting_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings requiring regulatory reporting. Measures sanctions compliance notification obligations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_third_party_due_diligence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Third-party due diligence metrics tracking approval rates, risk ratings, remediation performance, and PEP/sanctions exposure. Enables procurement, compliance, and legal leadership to manage vendor and partner risk, demonstrate regulatory due diligence, and protect the organization from third-party liability."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`third_party_due_diligence`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the due diligence assessment (e.g., approved, rejected, pending) for vendor onboarding management."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the third party for risk-tiered vendor management."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of due diligence assessment (e.g., initial, periodic, event-triggered) for program segmentation."
    - name: "pep_flag"
      expr: pep_flag
      comment: "Whether the third party is a Politically Exposed Person — a critical AML/KYC risk indicator."
    - name: "adverse_media_flag"
      expr: adverse_media_flag
      comment: "Whether adverse media was found during due diligence, indicating reputational risk."
    - name: "data_processor_flag"
      expr: data_processor_flag
      comment: "Whether the third party processes personal data, triggering GDPR data processing agreement requirements."
    - name: "data_processing_agreement_flag"
      expr: data_processing_agreement_flag
      comment: "Whether a data processing agreement is in place, tracking GDPR compliance for data processors."
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Whether remediation was required following due diligence findings."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment for due diligence program trend analysis."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total third-party due diligence assessments conducted. Baseline for vendor risk program coverage."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of third parties approved following due diligence. Measures vendor qualification rigor and risk acceptance rate."
    - name: "pep_exposure_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pep_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of third parties identified as Politically Exposed Persons. Tracks AML/KYC risk concentration in the vendor portfolio."
    - name: "adverse_media_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN adverse_media_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of third parties with adverse media findings. Measures reputational risk exposure in the vendor and partner portfolio."
    - name: "dpa_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN data_processing_agreement_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN data_processor_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of data-processing third parties with a DPA in place. Measures GDPR Article 28 compliance coverage — a critical data protection metric."
    - name: "remediation_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments requiring remediation. Measures third-party risk quality and vendor portfolio health."
    - name: "avg_days_to_approval"
      expr: AVG(CAST(DATEDIFF(approval_date, assessment_date) AS DOUBLE))
      comment: "Average days from assessment to approval decision. Measures due diligence process efficiency and vendor onboarding speed."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_whistleblower_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Whistleblower report analytics tracking allegation volume, investigation outcomes, regulatory escalations, and case resolution. Enables compliance, legal, and board audit committee to monitor ethics program health, manage retaliation risk, and demonstrate speak-up culture effectiveness."
  source: "`vibe_travel_hospitality_v1`.`compliance`.`whistleblower_report`"
  dimensions:
    - name: "allegation_category"
      expr: allegation_category
      comment: "Category of allegation (e.g., fraud, harassment, safety, bribery) for ethics risk portfolio analysis."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the whistleblower case for pipeline and backlog management."
    - name: "investigation_outcome"
      expr: investigation_outcome
      comment: "Outcome of the investigation (e.g., substantiated, unsubstantiated, inconclusive) for program effectiveness analysis."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality level of the report for governance and access control tracking."
    - name: "reporter_anonymity_flag"
      expr: reporter_anonymity_flag
      comment: "Whether the reporter chose anonymity, tracking speak-up culture and psychological safety."
    - name: "retaliation_concern_flag"
      expr: retaliation_concern_flag
      comment: "Whether retaliation concern was raised — a critical ethics and legal risk indicator."
    - name: "regulatory_escalation_required_flag"
      expr: regulatory_escalation_required_flag
      comment: "Whether regulatory escalation was required, indicating high-severity allegations."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether a legal hold was placed on the case, indicating litigation risk."
    - name: "report_channel"
      expr: report_channel
      comment: "Channel through which the report was submitted (e.g., hotline, email, in-person) for channel effectiveness analysis."
    - name: "report_year"
      expr: YEAR(report_date)
      comment: "Year the report was filed for annual ethics program trend analysis."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total whistleblower reports received. Baseline for ethics program activity and speak-up culture measurement."
    - name: "substantiation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN investigation_outcome = 'substantiated' THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN investigation_outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of investigated reports that were substantiated. Measures ethics risk materialization rate and program credibility."
    - name: "retaliation_concern_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN retaliation_concern_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports with retaliation concerns. A critical board-level ethics metric — high rates indicate toxic culture and legal exposure."
    - name: "regulatory_escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_escalation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports requiring regulatory escalation. Measures severity of ethics violations and regulatory notification obligations."
    - name: "anonymous_report_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reporter_anonymity_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports filed anonymously. Tracks speak-up culture health — very high rates may indicate fear of retaliation."
    - name: "open_case_count"
      expr: SUM(CASE WHEN case_status != 'closed' THEN 1 ELSE 0 END)
      comment: "Count of open whistleblower cases. Tracks investigation backlog and outstanding ethics risk exposure."
    - name: "avg_investigation_days"
      expr: AVG(CAST(DATEDIFF(investigation_completion_date, investigation_start_date) AS DOUBLE))
      comment: "Average days to complete a whistleblower investigation. Measures ethics program responsiveness and procedural fairness."
$$;
