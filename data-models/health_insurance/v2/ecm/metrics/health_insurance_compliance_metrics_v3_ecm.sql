-- Metric views for domain: compliance | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the regulatory obligation registry — tracks obligation risk posture, penalty exposure, and compliance deadline adherence across all governing bodies and jurisdictions."
  source: "`vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (e.g., reporting, filing, attestation) for segmenting compliance burden."
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body that issued the obligation (e.g., CMS, state DOI) for jurisdictional analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic or legal jurisdiction of the obligation for state vs. federal breakdown."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Overarching regulatory framework (e.g., ACA, HIPAA, ERISA) for framework-level compliance tracking."
    - name: "obligation_status"
      expr: compliance_regulatory_obligation_status
      comment: "Current status of the obligation (active, expired, waived) for pipeline health monitoring."
    - name: "is_federal"
      expr: is_federal
      comment: "Flag distinguishing federal vs. state obligations for regulatory tier analysis."
    - name: "risk_impact"
      expr: risk_impact
      comment: "Assessed risk impact level of the obligation for prioritization."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the obligation became effective for trend analysis."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations tracked — baseline measure for compliance inventory sizing."
    - name: "total_penalty_exposure_usd"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty exposure in USD across all obligations — critical for CFO-level financial risk reporting."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all obligations — indicates overall regulatory risk posture for executive steering."
    - name: "max_risk_score"
      expr: MAX(CAST(risk_score AS DOUBLE))
      comment: "Highest individual obligation risk score — flags the most critical single regulatory exposure."
    - name: "obligations_with_exemption_allowed"
      expr: COUNT(CASE WHEN exemption_allowed = TRUE THEN 1 END)
      comment: "Count of obligations where exemption is permitted — informs compliance strategy for waiver opportunities."
    - name: "federal_obligation_count"
      expr: COUNT(CASE WHEN is_federal = TRUE THEN 1 END)
      comment: "Number of federal-level obligations — used to size federal compliance program investment."
    - name: "state_specific_obligation_count"
      expr: COUNT(CASE WHEN is_state_specific = TRUE THEN 1 END)
      comment: "Number of state-specific obligations — drives state compliance team resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_audit_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for audit engagements — tracks audit cost efficiency, finding severity, remediation status, and audit cycle performance for compliance leadership."
  source: "`vibe_health_insurance_v1`.`compliance`.`audit_engagement`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, regulatory) for segmenting audit program composition."
    - name: "audit_category"
      expr: audit_category
      comment: "Business category of the audit (financial, operational, clinical) for domain-level analysis."
    - name: "audit_status"
      expr: audit_engagement_status
      comment: "Current lifecycle status of the audit engagement for pipeline monitoring."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the audit engagement for prioritization and escalation."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the audit (pass, fail, conditional) for quality reporting."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Regulatory framework under which the audit was conducted (HIPAA, SOX, etc.)."
    - name: "engagement_start_month"
      expr: DATE_TRUNC('MONTH', engagement_start_date)
      comment: "Month the audit engagement started for trend and seasonality analysis."
    - name: "audit_followup_required"
      expr: audit_followup_required
      comment: "Flag indicating whether follow-up action is required — used to track open remediation obligations."
  measures:
    - name: "total_audit_engagements"
      expr: COUNT(1)
      comment: "Total number of audit engagements — baseline measure for audit program volume."
    - name: "total_actual_audit_cost_usd"
      expr: SUM(CAST(audit_cost_actual AS DOUBLE))
      comment: "Total actual spend on audit engagements — key input for compliance budget management."
    - name: "total_estimated_audit_cost_usd"
      expr: SUM(CAST(audit_cost_estimate AS DOUBLE))
      comment: "Total estimated audit cost — used to compare against actuals for budget variance analysis."
    - name: "avg_actual_audit_cost_usd"
      expr: AVG(CAST(audit_cost_actual AS DOUBLE))
      comment: "Average cost per audit engagement — benchmarks audit efficiency and vendor cost management."
    - name: "audits_requiring_followup"
      expr: COUNT(CASE WHEN audit_followup_required = TRUE THEN 1 END)
      comment: "Number of audits with open follow-up requirements — tracks remediation backlog for compliance officers."
    - name: "followup_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_followup_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up — a high rate signals systemic compliance gaps requiring executive attention."
    - name: "avg_audit_period_days"
      expr: AVG(CAST(DATEDIFF(audit_period_end, audit_period_start) AS DOUBLE))
      comment: "Average duration of audit periods in days — measures audit scope breadth and planning efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for audit findings — tracks finding severity, financial impact, remediation timeliness, and repeat-finding rates to drive corrective action prioritization."
  source: "`vibe_health_insurance_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the finding (deficiency, observation, recommendation) for severity segmentation."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the finding (critical, high, medium, low) — primary dimension for executive escalation dashboards."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action for the finding — tracks remediation pipeline health."
    - name: "finding_status"
      expr: audit_finding_status
      comment: "Current lifecycle status of the audit finding (open, closed, in-progress)."
    - name: "compliance_area"
      expr: compliance_area
      comment: "Business compliance area affected by the finding for domain-level gap analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical findings requiring immediate executive attention."
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Flag indicating whether this is a repeat finding — repeat findings signal systemic control failures."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_timestamp)
      comment: "Month the finding was identified for trend analysis of compliance gaps over time."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings — baseline measure for compliance gap inventory."
    - name: "total_financial_impact_usd"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of audit findings in USD — critical for CFO risk quantification and reserve planning."
    - name: "avg_financial_impact_usd"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per finding — benchmarks finding materiality for audit scoping decisions."
    - name: "critical_finding_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical findings — a primary KPI for board-level compliance risk reporting."
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END)
      comment: "Number of repeat findings — high repeat rate indicates systemic control failures requiring structural remediation."
    - name: "repeat_finding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeats — a leading indicator of control environment quality for audit committees."
    - name: "open_finding_count"
      expr: COUNT(CASE WHEN audit_finding_status = 'open' THEN 1 END)
      comment: "Number of currently open findings — tracks remediation backlog for compliance program management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for corrective action plans (CAPs) — measures remediation cost, completion rates, overdue plans, and FWA monitoring coverage to drive accountability and risk reduction."
  source: "`vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of corrective action plan (regulatory, operational, clinical) for program segmentation."
    - name: "cap_status"
      expr: corrective_action_plan_status
      comment: "Current status of the CAP (open, in-progress, closed) for pipeline health monitoring."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category the CAP addresses for domain-level remediation tracking."
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAP for resource allocation and escalation decisions."
    - name: "severity"
      expr: severity
      comment: "Severity of the underlying issue driving the CAP — used to triage remediation effort."
    - name: "is_fwa_monitoring"
      expr: is_fwa_monitoring
      comment: "Flag indicating whether the CAP is related to fraud, waste, and abuse monitoring."
    - name: "is_external_audit"
      expr: is_external_audit
      comment: "Flag distinguishing externally-driven CAPs from internal ones for regulatory reporting."
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month the CAP is targeted for completion — used for deadline management dashboards."
  measures:
    - name: "total_caps"
      expr: COUNT(1)
      comment: "Total number of corrective action plans — baseline measure for remediation program volume."
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual remediation spend across all CAPs — key input for compliance cost management and budgeting."
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated remediation cost — used for budget forecasting and resource planning."
    - name: "avg_actual_cost_usd"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average cost per corrective action plan — benchmarks remediation efficiency."
    - name: "fwa_monitoring_cap_count"
      expr: COUNT(CASE WHEN is_fwa_monitoring = TRUE THEN 1 END)
      comment: "Number of CAPs tied to FWA monitoring — tracks anti-fraud program remediation activity."
    - name: "external_audit_cap_count"
      expr: COUNT(CASE WHEN is_external_audit = TRUE THEN 1 END)
      comment: "Number of CAPs driven by external audits — indicates regulatory scrutiny level and external compliance pressure."
    - name: "open_cap_count"
      expr: COUNT(CASE WHEN corrective_action_plan_status = 'open' THEN 1 END)
      comment: "Number of currently open CAPs — a primary operational KPI for compliance officers managing remediation backlog."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_breach_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA and security breach incident KPIs — tracks breach volume, risk scores, notification compliance, and regulatory filing status for privacy officers and executive leadership."
  source: "`vibe_health_insurance_v1`.`compliance`.`breach_incident`"
  dimensions:
    - name: "breach_type"
      expr: breach_type
      comment: "Type of breach (unauthorized access, theft, loss) for incident classification and trend analysis."
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach incident (open, resolved, under investigation) for pipeline monitoring."
    - name: "breach_source"
      expr: breach_source
      comment: "Source of the breach (internal, external, business associate) for root cause analysis."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify affected individuals (mail, email, media) for notification program analysis."
    - name: "hhs_notified"
      expr: hhs_notified
      comment: "Flag indicating whether HHS was notified — critical for HIPAA regulatory compliance tracking."
    - name: "business_associate_involved"
      expr: business_associate_involved
      comment: "Flag indicating business associate involvement — drives BAA enforcement and vendor risk management."
    - name: "breach_discovery_month"
      expr: DATE_TRUNC('MONTH', breach_discovery_date)
      comment: "Month the breach was discovered for trend analysis and regulatory timeline tracking."
  measures:
    - name: "total_breach_incidents"
      expr: COUNT(1)
      comment: "Total number of breach incidents — primary KPI for privacy program health and regulatory exposure."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across breach incidents — measures overall breach severity for executive risk reporting."
    - name: "max_risk_assessment_score"
      expr: MAX(CAST(risk_assessment_score AS DOUBLE))
      comment: "Highest breach risk score — identifies the most severe incident for immediate executive attention."
    - name: "hhs_notified_count"
      expr: COUNT(CASE WHEN hhs_notified = TRUE THEN 1 END)
      comment: "Number of breaches where HHS was notified — tracks HIPAA large-breach reporting compliance."
    - name: "hhs_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hhs_notified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaches with HHS notification — a regulatory compliance rate KPI for privacy officers."
    - name: "business_associate_breach_count"
      expr: COUNT(CASE WHEN business_associate_involved = TRUE THEN 1 END)
      comment: "Number of breaches involving business associates — drives vendor risk management and BAA enforcement decisions."
    - name: "avg_breach_resolution_days"
      expr: AVG(CAST(DATEDIFF(breach_resolution_date, breach_discovery_date) AS DOUBLE))
      comment: "Average days from breach discovery to resolution — measures incident response efficiency against regulatory timelines."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_fwa_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fraud, Waste, and Abuse (FWA) case KPIs — tracks case volume, financial exposure, recovery rates, and high-risk case concentration for SIU and compliance leadership."
  source: "`vibe_health_insurance_v1`.`compliance`.`fwa_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of FWA case (fraud, waste, abuse) for program segmentation and regulatory reporting."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the FWA case (open, closed, referred) for pipeline management."
    - name: "case_disposition"
      expr: case_disposition
      comment: "Final disposition of the case (substantiated, unsubstantiated, referred to law enforcement) for outcome analysis."
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the FWA referral (claims analytics, hotline, audit) for detection channel effectiveness."
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject under investigation (provider, member, vendor) for FWA program targeting."
    - name: "is_high_risk"
      expr: is_high_risk
      comment: "Flag for high-risk FWA cases requiring expedited investigation and executive escalation."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag indicating whether the case requires regulatory reporting — tracks mandatory disclosure obligations."
    - name: "case_open_month"
      expr: DATE_TRUNC('MONTH', case_open_timestamp)
      comment: "Month the FWA case was opened for trend analysis and program performance tracking."
  measures:
    - name: "total_fwa_cases"
      expr: COUNT(1)
      comment: "Total number of FWA cases — baseline measure for anti-fraud program volume and activity level."
    - name: "total_estimated_exposure_usd"
      expr: SUM(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Total estimated financial exposure from FWA cases — critical for CFO risk quantification and reserve planning."
    - name: "total_recovery_amount_usd"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from FWA cases — measures anti-fraud program ROI for executive reporting."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across FWA cases — indicates overall fraud risk concentration in the portfolio."
    - name: "high_risk_case_count"
      expr: COUNT(CASE WHEN is_high_risk = TRUE THEN 1 END)
      comment: "Number of high-risk FWA cases — a primary KPI for SIU resource allocation and escalation decisions."
    - name: "high_risk_case_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_high_risk = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of FWA cases classified as high-risk — tracks fraud risk concentration trend for compliance leadership."
    - name: "recovery_to_exposure_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_exposure_amount AS DOUBLE)), 0), 2)
      comment: "Recovery rate as a percentage of estimated exposure — measures FWA program effectiveness and ROI for board reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_mlr_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical Loss Ratio (MLR) KPIs — tracks MLR percentages, premium and claims amounts, rebate obligations, and ACA compliance status by market segment and health plan for actuarial and regulatory reporting."
  source: "`vibe_health_insurance_v1`.`compliance`.`mlr_calculation`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (individual, small group, large group) — primary MLR segmentation dimension per ACA requirements."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment code for ACA MLR reporting segmentation."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for MLR calculation — enables year-over-year trend analysis and regulatory filing tracking."
    - name: "mlr_status"
      expr: mlr_calculation_status
      comment: "Status of the MLR calculation (draft, submitted, final) for regulatory submission pipeline monitoring."
    - name: "rebate_eligibility_flag"
      expr: rebate_eligibility_flag
      comment: "Flag indicating whether a rebate is owed — critical for ACA rebate obligation tracking."
    - name: "rebate_disbursement_status"
      expr: rebate_disbursement_status
      comment: "Status of rebate disbursement (pending, paid, waived) for cash flow and compliance tracking."
    - name: "calculation_date_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month of MLR calculation for trend analysis."
  measures:
    - name: "total_mlr_calculations"
      expr: COUNT(1)
      comment: "Total number of MLR calculations — baseline measure for regulatory reporting volume."
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average MLR percentage across calculations — primary ACA compliance KPI; must meet 80%/85% thresholds by market segment."
    - name: "total_earned_premium_usd"
      expr: SUM(CAST(earned_premium_amount AS DOUBLE))
      comment: "Total earned premium across MLR calculations — denominator for MLR ratio and revenue baseline."
    - name: "total_incurred_claims_usd"
      expr: SUM(CAST(incurred_claims_amount AS DOUBLE))
      comment: "Total incurred claims across MLR calculations — primary numerator component for MLR compliance."
    - name: "total_quality_improvement_expenses_usd"
      expr: SUM(CAST(quality_improvement_expenses_amount AS DOUBLE))
      comment: "Total quality improvement expenses — second numerator component for ACA MLR calculation."
    - name: "total_rebate_obligation_usd"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount owed to members — critical financial liability KPI for CFO and regulatory reporting."
    - name: "rebate_eligible_calculation_count"
      expr: COUNT(CASE WHEN rebate_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of MLR calculations triggering a rebate obligation — tracks ACA rebate program scope."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training completion KPIs — tracks training completion rates, assessment performance, cost efficiency, and regulatory requirement fulfillment for workforce compliance management."
  source: "`vibe_health_insurance_v1`.`compliance`.`training_completion`"
  dimensions:
    - name: "training_category"
      expr: training_category
      comment: "Category of compliance training (HIPAA, FWA, ethics) for program-level completion tracking."
    - name: "training_type"
      expr: training_type
      comment: "Type of training delivery (mandatory, elective, remedial) for compliance obligation segmentation."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (online, in-person, blended) for channel effectiveness analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the training assessment — primary quality dimension for training effectiveness."
    - name: "training_status"
      expr: training_completion_status
      comment: "Current status of the training completion record (completed, in-progress, overdue)."
    - name: "compliance_requirements_met_flag"
      expr: compliance_requirements_met_flag
      comment: "Flag indicating whether the completion satisfies regulatory requirements — key compliance attestation dimension."
    - name: "is_external_training"
      expr: is_external_training
      comment: "Flag distinguishing external vendor training from internal programs for cost and sourcing analysis."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_timestamp)
      comment: "Month training was completed for trend analysis and regulatory deadline tracking."
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total training completion records — baseline measure for compliance training program volume."
    - name: "total_training_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total spend on compliance training — key input for training budget management and cost-per-completion analysis."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across completions — measures training effectiveness and knowledge retention."
    - name: "total_hours_completed"
      expr: SUM(CAST(hours_completed AS DOUBLE))
      comment: "Total compliance training hours completed — tracks regulatory training hour requirements fulfillment."
    - name: "compliance_requirements_met_count"
      expr: COUNT(CASE WHEN compliance_requirements_met_flag = TRUE THEN 1 END)
      comment: "Number of completions satisfying regulatory requirements — primary KPI for compliance training program effectiveness."
    - name: "compliance_requirements_met_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_requirements_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions meeting regulatory requirements — a board-level workforce compliance KPI."
    - name: "avg_cost_per_completion_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per training completion — benchmarks training program efficiency and vendor value."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission KPIs — tracks submission timeliness, filing fees, on-time rates, and rejection rates across governing bodies for compliance program performance management."
  source: "`vibe_health_insurance_v1`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (rate filing, network adequacy, financial report) for program segmentation."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the submission (CMS, state DOI) for jurisdictional compliance tracking."
    - name: "submission_status"
      expr: regulatory_submission_status
      comment: "Current status of the submission (pending, accepted, rejected) for pipeline health monitoring."
    - name: "submission_method"
      expr: submission_method
      comment: "Method of submission (electronic, paper, portal) for process efficiency analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical submissions with significant regulatory consequences if missed."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for trend analysis and regulatory calendar management."
    - name: "filing_period_year"
      expr: YEAR(filing_period_start)
      comment: "Year of the filing period for annual regulatory reporting cycle analysis."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions — baseline measure for compliance filing program volume."
    - name: "total_filing_fees_usd"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total regulatory filing fees paid — tracks compliance program cost for budget management."
    - name: "total_net_fees_usd"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net filing fees after adjustments — accurate cost basis for regulatory compliance budgeting."
    - name: "critical_submission_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical regulatory submissions — tracks high-stakes filing obligations for executive oversight."
    - name: "on_time_submission_count"
      expr: COUNT(CASE WHEN submission_date <= due_date THEN 1 END)
      comment: "Number of submissions filed on or before the due date — measures regulatory timeliness compliance."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_date <= due_date THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions filed on time — a primary regulatory compliance KPI for executive and board reporting."
    - name: "avg_filing_fee_usd"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per submission — benchmarks regulatory cost efficiency across submission types."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_accreditation_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation program KPIs — tracks accreditation scores, completion rates, critical program status, and survey cycle performance for quality and compliance leadership."
  source: "`vibe_health_insurance_v1`.`compliance`.`accreditation_program`"
  dimensions:
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (NCQA, URAC, HEDIS) for program-level performance segmentation."
    - name: "accrediting_body"
      expr: accrediting_body
      comment: "Accrediting organization for benchmarking and external reporting."
    - name: "accreditation_status"
      expr: accreditation_program_status
      comment: "Current accreditation status (accredited, provisional, denied) for program health monitoring."
    - name: "rating"
      expr: rating
      comment: "Accreditation rating level for quality tier analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the accreditation program for prioritization."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for accreditation programs with critical business or regulatory impact."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the accreditation for domain-level quality tracking."
    - name: "survey_start_month"
      expr: DATE_TRUNC('MONTH', survey_start_date)
      comment: "Month the accreditation survey started for cycle planning and trend analysis."
  measures:
    - name: "total_accreditation_programs"
      expr: COUNT(1)
      comment: "Total number of accreditation programs — baseline measure for quality program portfolio size."
    - name: "avg_final_score"
      expr: AVG(CAST(final_score AS DOUBLE))
      comment: "Average final accreditation score — primary quality KPI for executive and board quality reporting."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across accreditation programs — tracks readiness for upcoming surveys."
    - name: "critical_program_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical accreditation programs — flags highest-stakes quality obligations for executive attention."
    - name: "escalated_program_count"
      expr: COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END)
      comment: "Number of accreditation programs with escalated issues — tracks programs requiring immediate intervention."
    - name: "avg_survey_duration_days"
      expr: AVG(CAST(DATEDIFF(survey_end_date, survey_start_date) AS DOUBLE))
      comment: "Average survey duration in days — measures accreditation process efficiency and resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_baa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business Associate Agreement (BAA) KPIs — tracks BAA coverage, subcontractor risk, agreement lifecycle, and HIPAA compliance posture across vendor relationships."
  source: "`vibe_health_insurance_v1`.`compliance`.`baa`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the BAA (active, expired, terminated) for vendor compliance monitoring."
    - name: "business_associate_type"
      expr: business_associate_type
      comment: "Type of business associate (TPA, clearinghouse, IT vendor) for risk segmentation."
    - name: "subcontractor_allowed"
      expr: subcontractor_allowed
      comment: "Flag indicating whether subcontracting is permitted — tracks downstream PHI risk exposure."
    - name: "governing_law"
      expr: governing_law
      comment: "Governing law jurisdiction for the BAA — used for legal and regulatory analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the BAA became effective for lifecycle trend analysis."
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month the BAA expires — used for renewal pipeline management."
  measures:
    - name: "total_baas"
      expr: COUNT(1)
      comment: "Total number of Business Associate Agreements — baseline measure for HIPAA vendor compliance coverage."
    - name: "active_baa_count"
      expr: COUNT(CASE WHEN agreement_status = 'active' THEN 1 END)
      comment: "Number of currently active BAAs — tracks live HIPAA vendor coverage for privacy officer reporting."
    - name: "subcontractor_allowed_count"
      expr: COUNT(CASE WHEN subcontractor_allowed = TRUE THEN 1 END)
      comment: "Number of BAAs permitting subcontracting — quantifies downstream PHI risk exposure requiring monitoring."
    - name: "subcontractor_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN subcontractor_allowed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BAAs with subcontractor permission — a HIPAA risk concentration KPI for privacy leadership."
    - name: "expired_baa_count"
      expr: COUNT(CASE WHEN agreement_status = 'expired' THEN 1 END)
      comment: "Number of expired BAAs — identifies vendors operating without current HIPAA agreements, a critical compliance gap."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_cap_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective Action Plan milestone KPIs — tracks milestone completion rates, escalation frequency, and on-time delivery to measure remediation program execution quality."
  source: "`vibe_health_insurance_v1`.`compliance`.`cap_milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of CAP milestone (evidence submission, review, sign-off) for remediation phase analysis."
    - name: "milestone_status"
      expr: cap_milestone_status
      comment: "Current status of the milestone (pending, in-progress, completed) for execution tracking."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the milestone for domain-level remediation tracking."
    - name: "priority"
      expr: priority
      comment: "Priority level of the milestone for resource allocation decisions."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the milestone for escalation prioritization."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical milestones whose delay would trigger regulatory consequences."
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Flag indicating the milestone has been escalated — tracks remediation program stress points."
    - name: "planned_completion_month"
      expr: DATE_TRUNC('MONTH', planned_completion_date)
      comment: "Month the milestone was planned for completion — used for deadline adherence analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of CAP milestones — baseline measure for remediation program granularity."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average milestone completion percentage — tracks overall CAP execution progress for compliance leadership."
    - name: "critical_milestone_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical milestones — flags highest-risk remediation steps for executive oversight."
    - name: "escalated_milestone_count"
      expr: COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END)
      comment: "Number of escalated milestones — measures remediation program stress and intervention needs."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones escalated — a leading indicator of CAP execution quality and organizational accountability."
    - name: "on_time_completion_count"
      expr: COUNT(CASE WHEN actual_completion_date <= planned_completion_date AND actual_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of milestones completed on or before planned date — measures remediation execution discipline."
    - name: "on_time_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_completion_date <= planned_completion_date AND actual_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed milestones delivered on time — primary CAP execution KPI for compliance program management."
$$;