-- Metric views for domain: compliance | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:41:45

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic regulatory compliance tracking metrics including risk exposure, penalty exposure, and compliance rate across obligations"
  source: "`vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (e.g., reporting, licensing, accreditation)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic or regulatory jurisdiction (state, federal, multi-state)"
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory authority or governing body imposing the obligation"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (compliant, non-compliant, pending, remediation)"
    - name: "risk_impact"
      expr: risk_impact
      comment: "Business impact level of non-compliance risk (high, medium, low)"
    - name: "risk_likelihood"
      expr: risk_likelihood
      comment: "Likelihood of compliance failure or breach (high, medium, low)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework or standard (HIPAA, ACA, state insurance code)"
    - name: "is_federal"
      expr: is_federal
      comment: "Whether obligation is federal-level (True) or state/local (False)"
    - name: "frequency"
      expr: frequency
      comment: "Reporting or compliance frequency (annual, quarterly, monthly, ad-hoc)"
    - name: "obligation_year"
      expr: YEAR(effective_date)
      comment: "Year the obligation became effective"
    - name: "obligation_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the obligation became effective"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total count of regulatory obligations"
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty amount across all obligations"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across obligations (higher = greater risk)"
    - name: "max_risk_score"
      expr: MAX(CAST(risk_score AS DOUBLE))
      comment: "Maximum risk score indicating highest-risk obligation"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Number of unique jurisdictions with active obligations"
    - name: "distinct_governing_bodies"
      expr: COUNT(DISTINCT governing_body)
      comment: "Number of unique regulatory bodies imposing obligations"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_breach_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA breach incident metrics tracking exposure, notification compliance, and risk assessment for privacy and security incidents"
  source: "`vibe_health_insurance_v1`.`compliance`.`breach_incident`"
  dimensions:
    - name: "breach_type"
      expr: breach_type
      comment: "Type of breach (unauthorized access, theft, loss, hacking, improper disposal)"
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of breach incident (open, under investigation, resolved, closed)"
    - name: "breach_source"
      expr: breach_source
      comment: "Source or origin of the breach (internal, external, business associate)"
    - name: "business_associate_involved"
      expr: business_associate_involved
      comment: "Whether a business associate was involved in the breach"
    - name: "hhs_notified"
      expr: hhs_notified
      comment: "Whether HHS (Office for Civil Rights) was notified"
    - name: "state_notified"
      expr: state_notified
      comment: "Whether state authorities were notified"
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify affected individuals (mail, email, phone, media)"
    - name: "regulatory_filing_status"
      expr: regulatory_filing_status
      comment: "Status of regulatory filing (pending, submitted, accepted, rejected)"
    - name: "breach_discovery_year"
      expr: YEAR(breach_discovery_date)
      comment: "Year the breach was discovered"
    - name: "breach_discovery_month"
      expr: DATE_TRUNC('MONTH', breach_discovery_date)
      comment: "Month the breach was discovered"
    - name: "breach_occurrence_year"
      expr: YEAR(breach_occurrence_date)
      comment: "Year the breach occurred"
  measures:
    - name: "total_breach_incidents"
      expr: COUNT(1)
      comment: "Total count of breach incidents"
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across breach incidents"
    - name: "max_risk_assessment_score"
      expr: MAX(CAST(risk_assessment_score AS DOUBLE))
      comment: "Maximum risk assessment score indicating highest-risk breach"
    - name: "distinct_breach_types"
      expr: COUNT(DISTINCT breach_type)
      comment: "Number of unique breach types observed"
    - name: "hhs_notification_rate"
      expr: COUNT(CASE WHEN hhs_notified = TRUE THEN 1 END)
      comment: "Count of incidents where HHS was notified"
    - name: "state_notification_rate"
      expr: COUNT(CASE WHEN state_notified = TRUE THEN 1 END)
      comment: "Count of incidents where state authorities were notified"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_audit_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit engagement performance metrics tracking cost variance, remediation requirements, and audit outcomes for compliance oversight"
  source: "`vibe_health_insurance_v1`.`compliance`.`audit_engagement`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, regulatory, accreditation, financial)"
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit focus (clinical quality, financial, operational, compliance)"
    - name: "audit_engagement_status"
      expr: audit_engagement_status
      comment: "Current status of audit engagement (planning, fieldwork, reporting, closed)"
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Overall audit outcome (pass, pass with findings, fail, conditional)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to audit findings (high, medium, low)"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation efforts (not started, in progress, completed, overdue)"
    - name: "audit_followup_required"
      expr: audit_followup_required
      comment: "Whether follow-up audit is required"
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework audited against (HIPAA, SOC 2, NCQA, URAC)"
    - name: "audit_priority"
      expr: audit_priority
      comment: "Priority level of the audit (critical, high, medium, low)"
    - name: "engagement_start_year"
      expr: YEAR(engagement_start_date)
      comment: "Year the audit engagement started"
    - name: "engagement_start_month"
      expr: DATE_TRUNC('MONTH', engagement_start_date)
      comment: "Month the audit engagement started"
  measures:
    - name: "total_audit_engagements"
      expr: COUNT(1)
      comment: "Total count of audit engagements"
    - name: "total_audit_cost_actual"
      expr: SUM(CAST(audit_cost_actual AS DOUBLE))
      comment: "Total actual audit costs incurred"
    - name: "total_audit_cost_estimate"
      expr: SUM(CAST(audit_cost_estimate AS DOUBLE))
      comment: "Total estimated audit costs"
    - name: "avg_audit_cost_actual"
      expr: AVG(CAST(audit_cost_actual AS DOUBLE))
      comment: "Average actual cost per audit engagement"
    - name: "distinct_audit_types"
      expr: COUNT(DISTINCT audit_type)
      comment: "Number of unique audit types conducted"
    - name: "distinct_compliance_frameworks"
      expr: COUNT(DISTINCT compliance_framework)
      comment: "Number of unique compliance frameworks audited"
    - name: "followup_required_count"
      expr: COUNT(CASE WHEN audit_followup_required = TRUE THEN 1 END)
      comment: "Count of audits requiring follow-up"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding remediation metrics tracking severity, financial impact, and corrective action effectiveness for compliance risk management"
  source: "`vibe_health_insurance_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the finding (critical, high, medium, low)"
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding (deficiency, observation, best practice, non-compliance)"
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current status of the finding (open, in remediation, closed, verified)"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action plan (not started, in progress, completed, overdue)"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the finding is classified as critical"
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Whether this is a repeat finding from prior audits"
    - name: "compliance_area"
      expr: compliance_area
      comment: "Area of compliance affected (privacy, security, clinical, financial)"
    - name: "affected_business_area"
      expr: affected_business_area
      comment: "Business area impacted by the finding"
    - name: "priority"
      expr: priority
      comment: "Remediation priority (urgent, high, medium, low)"
    - name: "identified_year"
      expr: YEAR(identified_timestamp)
      comment: "Year the finding was identified"
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_timestamp)
      comment: "Month the finding was identified"
  measures:
    - name: "total_audit_findings"
      expr: COUNT(1)
      comment: "Total count of audit findings"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact amount across all findings"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per finding"
    - name: "critical_findings_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of findings classified as critical"
    - name: "repeat_findings_count"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END)
      comment: "Count of repeat findings indicating systemic issues"
    - name: "distinct_compliance_areas"
      expr: COUNT(DISTINCT compliance_area)
      comment: "Number of unique compliance areas with findings"
    - name: "distinct_business_areas"
      expr: COUNT(DISTINCT affected_business_area)
      comment: "Number of unique business areas affected by findings"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action plan performance metrics tracking completion rates, cost variance, and remediation effectiveness for compliance risk mitigation"
  source: "`vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "corrective_action_plan_status"
      expr: corrective_action_plan_status
      comment: "Current status of corrective action plan (draft, approved, in progress, completed, overdue)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of corrective action plan (immediate, short-term, long-term, systemic)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the underlying issue (critical, high, medium, low)"
    - name: "priority"
      expr: priority
      comment: "Priority level for remediation (urgent, high, medium, low)"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Category of compliance issue being addressed"
    - name: "is_external_audit"
      expr: is_external_audit
      comment: "Whether the plan stems from an external audit"
    - name: "is_fwa_monitoring"
      expr: is_fwa_monitoring
      comment: "Whether the plan is related to fraud, waste, and abuse monitoring"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body requiring the corrective action"
    - name: "owner_role"
      expr: owner_role
      comment: "Role of the person or team accountable for the plan"
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year the plan is targeted for completion"
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month the plan is targeted for completion"
  measures:
    - name: "total_corrective_action_plans"
      expr: COUNT(1)
      comment: "Total count of corrective action plans"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost of all corrective action plans"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost incurred for corrective action plans"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Average estimated cost per corrective action plan"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per corrective action plan"
    - name: "distinct_regulatory_bodies"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Number of unique regulatory bodies requiring corrective actions"
    - name: "external_audit_plans_count"
      expr: COUNT(CASE WHEN is_external_audit = TRUE THEN 1 END)
      comment: "Count of plans stemming from external audits"
    - name: "fwa_monitoring_plans_count"
      expr: COUNT(CASE WHEN is_fwa_monitoring = TRUE THEN 1 END)
      comment: "Count of plans related to fraud, waste, and abuse monitoring"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_fwa_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fraud, waste, and abuse case metrics tracking exposure, recovery, and investigation outcomes for program integrity management"
  source: "`vibe_health_insurance_v1`.`compliance`.`fwa_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of FWA case (fraud, waste, abuse, billing error, upcoding)"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (open, under investigation, closed, referred)"
    - name: "case_disposition"
      expr: case_disposition
      comment: "Final disposition of the case (substantiated, unsubstantiated, pending, settled)"
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject under investigation (provider, member, facility, vendor)"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the case referral (internal audit, hotline, data analytics, external)"
    - name: "is_high_risk"
      expr: is_high_risk
      comment: "Whether the case is classified as high risk"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether the case must be reported to regulatory authorities"
    - name: "triage_outcome"
      expr: triage_outcome
      comment: "Outcome of initial triage (escalate, monitor, close, refer)"
    - name: "case_open_year"
      expr: YEAR(case_open_timestamp)
      comment: "Year the case was opened"
    - name: "case_open_month"
      expr: DATE_TRUNC('MONTH', case_open_timestamp)
      comment: "Month the case was opened"
    - name: "disposition_year"
      expr: YEAR(disposition_date)
      comment: "Year the case was dispositioned"
  measures:
    - name: "total_fwa_cases"
      expr: COUNT(1)
      comment: "Total count of fraud, waste, and abuse cases"
    - name: "total_estimated_exposure"
      expr: SUM(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Total estimated financial exposure across all FWA cases"
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from FWA cases"
    - name: "avg_estimated_exposure"
      expr: AVG(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Average estimated exposure per FWA case"
    - name: "avg_recovery_amount"
      expr: AVG(CAST(recovery_amount AS DOUBLE))
      comment: "Average recovery amount per FWA case"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across FWA cases"
    - name: "high_risk_cases_count"
      expr: COUNT(CASE WHEN is_high_risk = TRUE THEN 1 END)
      comment: "Count of cases classified as high risk"
    - name: "regulatory_reporting_cases_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Count of cases requiring regulatory reporting"
    - name: "distinct_subject_types"
      expr: COUNT(DISTINCT subject_type)
      comment: "Number of unique subject types under investigation"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_mlr_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical Loss Ratio calculation metrics tracking MLR percentage, rebate obligations, and premium/claims ratios for ACA compliance"
  source: "`vibe_health_insurance_v1`.`compliance`.`mlr_calculation`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "Year for which MLR is being calculated and reported"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (individual, small group, large group)"
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment code for MLR calculation"
    - name: "mlr_calculation_status"
      expr: mlr_calculation_status
      comment: "Status of MLR calculation (draft, final, submitted, approved)"
    - name: "rebate_eligibility_flag"
      expr: rebate_eligibility_flag
      comment: "Whether the calculation triggers rebate obligations"
    - name: "rebate_disbursement_status"
      expr: rebate_disbursement_status
      comment: "Status of rebate disbursement (pending, in progress, completed)"
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year the MLR calculation was performed"
    - name: "calculation_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month the MLR calculation was performed"
    - name: "rebate_disbursement_year"
      expr: YEAR(rebate_disbursement_date)
      comment: "Year rebates were disbursed"
  measures:
    - name: "total_mlr_calculations"
      expr: COUNT(1)
      comment: "Total count of MLR calculations"
    - name: "total_earned_premium"
      expr: SUM(CAST(earned_premium_amount AS DOUBLE))
      comment: "Total earned premium across all MLR calculations"
    - name: "total_incurred_claims"
      expr: SUM(CAST(incurred_claims_amount AS DOUBLE))
      comment: "Total incurred claims across all MLR calculations"
    - name: "total_quality_improvement_expenses"
      expr: SUM(CAST(quality_improvement_expenses_amount AS DOUBLE))
      comment: "Total quality improvement expenses across all MLR calculations"
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount owed to members"
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average MLR percentage across calculations"
    - name: "min_mlr_percentage"
      expr: MIN(CAST(mlr_percentage AS DOUBLE))
      comment: "Minimum MLR percentage indicating lowest claims-to-premium ratio"
    - name: "max_mlr_percentage"
      expr: MAX(CAST(mlr_percentage AS DOUBLE))
      comment: "Maximum MLR percentage indicating highest claims-to-premium ratio"
    - name: "rebate_eligible_count"
      expr: COUNT(CASE WHEN rebate_eligibility_flag = TRUE THEN 1 END)
      comment: "Count of calculations triggering rebate obligations"
    - name: "distinct_lines_of_business"
      expr: COUNT(DISTINCT line_of_business)
      comment: "Number of unique lines of business with MLR calculations"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission performance metrics tracking timeliness, filing fees, and submission outcomes for regulatory compliance management"
  source: "`vibe_health_insurance_v1`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (rate filing, form filing, financial report, MLR report)"
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Current status of submission (draft, submitted, under review, accepted, rejected)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the submission (state DOI, CMS, HHS)"
    - name: "submission_method"
      expr: submission_method
      comment: "Method of submission (electronic portal, mail, email, in-person)"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the submission is classified as critical"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Code indicating reason for rejection if applicable"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the submission was filed"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the submission was filed"
    - name: "due_date_year"
      expr: YEAR(due_date)
      comment: "Year the submission was due"
    - name: "filing_period_year"
      expr: YEAR(filing_period_start)
      comment: "Year of the filing period start"
  measures:
    - name: "total_regulatory_submissions"
      expr: COUNT(1)
      comment: "Total count of regulatory submissions"
    - name: "total_filing_fees"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total filing fees paid across all submissions"
    - name: "total_net_fees"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net fees after adjustments across all submissions"
    - name: "avg_filing_fee"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per submission"
    - name: "critical_submissions_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of submissions classified as critical"
    - name: "distinct_regulatory_bodies"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Number of unique regulatory bodies receiving submissions"
    - name: "distinct_submission_types"
      expr: COUNT(DISTINCT submission_type)
      comment: "Number of unique submission types filed"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_accreditation_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation program performance metrics tracking completion rates, scores, and survey outcomes for quality and compliance certification"
  source: "`vibe_health_insurance_v1`.`compliance`.`accreditation_program`"
  dimensions:
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (NCQA, URAC, AAAHC, Joint Commission)"
    - name: "accrediting_body"
      expr: accrediting_body
      comment: "Organization providing the accreditation"
    - name: "accreditation_program_status"
      expr: accreditation_program_status
      comment: "Current status of accreditation program (active, pending, expired, suspended)"
    - name: "level"
      expr: accreditation_program_level
      comment: "Accreditation level achieved (excellent, commendable, accredited, provisional)"
    - name: "rating"
      expr: rating
      comment: "Overall rating or score category"
    - name: "decision"
      expr: decision
      comment: "Accreditation decision (approved, denied, conditional, deferred)"
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey conducted (initial, renewal, follow-up, unannounced)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with accreditation status (high, medium, low)"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the accreditation is critical for business operations"
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Whether issues have been escalated to senior leadership"
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the accreditation became effective"
    - name: "survey_start_year"
      expr: YEAR(survey_start_date)
      comment: "Year the accreditation survey started"
  measures:
    - name: "total_accreditation_programs"
      expr: COUNT(1)
      comment: "Total count of accreditation programs"
    - name: "avg_final_score"
      expr: AVG(CAST(final_score AS DOUBLE))
      comment: "Average final accreditation score across programs"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across accreditation programs"
    - name: "min_final_score"
      expr: MIN(CAST(final_score AS DOUBLE))
      comment: "Minimum final score indicating lowest-performing program"
    - name: "max_final_score"
      expr: MAX(CAST(final_score AS DOUBLE))
      comment: "Maximum final score indicating highest-performing program"
    - name: "critical_programs_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of accreditation programs classified as critical"
    - name: "escalated_programs_count"
      expr: COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END)
      comment: "Count of programs with escalated issues"
    - name: "distinct_accrediting_bodies"
      expr: COUNT(DISTINCT accrediting_body)
      comment: "Number of unique accrediting bodies"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_hipaa_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA privacy request metrics tracking request volume, response timeliness, and disclosure compliance for patient rights management"
  source: "`vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of HIPAA privacy request (access, amendment, accounting of disclosures, restriction)"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request (received, in progress, completed, denied, appealed)"
    - name: "request_source"
      expr: request_source
      comment: "Source of the request (member, legal representative, provider, third party)"
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which request was received (mail, email, phone, portal, in-person)"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the request (granted, denied, partially granted)"
    - name: "is_appealed"
      expr: is_appealed
      comment: "Whether the request decision was appealed"
    - name: "is_confidential_communication"
      expr: is_confidential_communication
      comment: "Whether the request involves confidential communication"
    - name: "disclosure_logged"
      expr: disclosure_logged
      comment: "Whether disclosure was properly logged for accounting purposes"
    - name: "disclosure_recipient_type"
      expr: disclosure_recipient_type
      comment: "Type of recipient for disclosure (member, provider, legal, government)"
    - name: "request_received_year"
      expr: YEAR(request_received_timestamp)
      comment: "Year the request was received"
    - name: "request_received_month"
      expr: DATE_TRUNC('MONTH', request_received_timestamp)
      comment: "Month the request was received"
    - name: "response_due_year"
      expr: YEAR(response_due_date)
      comment: "Year the response is due"
  measures:
    - name: "total_privacy_requests"
      expr: COUNT(1)
      comment: "Total count of HIPAA privacy requests"
    - name: "appealed_requests_count"
      expr: COUNT(CASE WHEN is_appealed = TRUE THEN 1 END)
      comment: "Count of requests that were appealed"
    - name: "confidential_communication_count"
      expr: COUNT(CASE WHEN is_confidential_communication = TRUE THEN 1 END)
      comment: "Count of requests involving confidential communication"
    - name: "disclosure_logged_count"
      expr: COUNT(CASE WHEN disclosure_logged = TRUE THEN 1 END)
      comment: "Count of requests where disclosure was properly logged"
    - name: "distinct_request_types"
      expr: COUNT(DISTINCT request_type)
      comment: "Number of unique HIPAA privacy request types"
    - name: "distinct_request_channels"
      expr: COUNT(DISTINCT request_channel)
      comment: "Number of unique channels through which requests were received"
$$;
