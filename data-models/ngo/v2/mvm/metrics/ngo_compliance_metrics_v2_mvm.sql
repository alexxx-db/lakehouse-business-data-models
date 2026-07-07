-- Metric views for domain: compliance | Business: Ngo | Version: 2 | Generated on: 2026-07-03 06:15:30

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding KPIs tracking financial exposure from questioned costs, severity distribution, repeat findings, and resolution timeliness — core inputs for executive risk oversight and federal compliance steering."
  source: "`vibe_ngo_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the audit finding (e.g., internal control, compliance, financial) used to segment risk exposure by category."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity tier of the finding (e.g., critical, high, medium, low) enabling prioritization of remediation resources."
    - name: "finding_status"
      expr: finding_status
      comment: "Current lifecycle status of the finding (e.g., open, resolved, in-progress) for pipeline and aging analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk domain the finding belongs to, enabling cross-domain risk aggregation."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Organizational unit accountable for the finding, enabling departmental accountability reporting."
    - name: "compliance_requirement_type"
      expr: compliance_requirement_type
      comment: "Federal or donor compliance requirement type associated with the finding."
    - name: "federal_agency_name"
      expr: federal_agency_name
      comment: "Federal agency associated with the award under audit, enabling agency-level compliance tracking."
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Flag indicating whether the finding recurred from a prior audit period — a key indicator of systemic control failure."
    - name: "is_material_weakness"
      expr: is_material_weakness
      comment: "Flag indicating a material weakness in internal controls, a critical governance signal."
    - name: "audit_period_year"
      expr: YEAR(audit_period_start_date)
      comment: "Audit period year for trend analysis across fiscal cycles."
    - name: "finding_identified_month"
      expr: DATE_TRUNC('MONTH', finding_identified_date)
      comment: "Month the finding was identified, enabling temporal trend analysis."
  measures:
    - name: "total_questioned_cost_amount"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total dollar value of costs questioned by auditors. A primary financial risk indicator for federal award compliance — directly informs executive decisions on remediation investment and federal reporting."
    - name: "open_finding_count"
      expr: COUNT(CASE WHEN finding_status = 'Open' THEN audit_finding_id END)
      comment: "Number of currently open audit findings. Drives urgency of corrective action and is a key metric for compliance dashboards and board risk reporting."
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN audit_finding_id END)
      comment: "Count of findings that recurred from prior audit periods, signaling systemic control failures that require structural intervention."
    - name: "material_weakness_count"
      expr: COUNT(CASE WHEN is_material_weakness = TRUE THEN audit_finding_id END)
      comment: "Number of findings classified as material weaknesses — a critical governance KPI reported to boards and federal agencies."
    - name: "significant_deficiency_count"
      expr: COUNT(CASE WHEN is_significant_deficiency = TRUE THEN audit_finding_id END)
      comment: "Number of significant deficiency findings, a leading indicator of potential material weakness escalation."
    - name: "fraud_indicator_finding_count"
      expr: COUNT(CASE WHEN is_fraud_indicator = TRUE THEN audit_finding_id END)
      comment: "Count of findings with a fraud indicator flag — a zero-tolerance risk metric requiring immediate executive escalation."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(actual_resolution_date, finding_identified_date))
      comment: "Average calendar days from finding identification to resolution. Measures remediation velocity and compliance operational efficiency."
    - name: "overdue_finding_count"
      expr: COUNT(CASE WHEN finding_status != 'Resolved' AND expected_resolution_date < CURRENT_DATE() THEN audit_finding_id END)
      comment: "Number of findings past their expected resolution date without closure — a direct operational risk and donor accountability signal."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action plan (CAP) KPIs measuring remediation cost, timeliness, recurrence risk, and completion rates — enabling leadership to steer post-audit remediation and prevent repeat findings."
  source: "`vibe_ngo_v1`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "cap_status"
      expr: cap_status
      comment: "Current status of the corrective action plan (e.g., open, in-progress, completed, overdue)."
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding the CAP addresses, enabling analysis of remediation effort by finding category."
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity of the underlying finding driving the CAP, for prioritization of remediation resources."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for executing the corrective action, enabling departmental performance tracking."
    - name: "recurrence_risk"
      expr: recurrence_risk
      comment: "Assessed risk level that the finding will recur, a forward-looking risk indicator."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Flag indicating whether the donor must be notified of the finding and remediation plan."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Flag indicating whether regulatory reporting is required for this corrective action."
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year the CAP is targeted for completion, enabling annual remediation pipeline planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which CAP costs are denominated."
  measures:
    - name: "total_actual_remediation_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to execute corrective actions. A direct measure of remediation financial burden informing budget allocation and donor reporting."
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of planned corrective actions, enabling budget forecasting for compliance remediation."
    - name: "cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Aggregate cost overrun or underrun across corrective action plans. Positive values indicate budget overruns requiring executive attention."
    - name: "completed_cap_count"
      expr: COUNT(CASE WHEN cap_status = 'Completed' THEN corrective_action_plan_id END)
      comment: "Number of corrective action plans successfully completed — a primary remediation throughput KPI."
    - name: "overdue_cap_count"
      expr: COUNT(CASE WHEN cap_status != 'Completed' AND target_completion_date < CURRENT_DATE() THEN corrective_action_plan_id END)
      comment: "Number of CAPs past their target completion date without closure — signals remediation execution risk and potential donor/regulatory exposure."
    - name: "donor_notification_pending_count"
      expr: COUNT(CASE WHEN donor_notification_required = TRUE AND donor_notification_date IS NULL THEN corrective_action_plan_id END)
      comment: "Count of CAPs requiring donor notification where notification has not yet been sent — a compliance obligation risk metric."
    - name: "avg_days_to_cap_completion"
      expr: AVG(DATEDIFF(actual_completion_date, created_timestamp))
      comment: "Average calendar days from CAP creation to actual completion. Measures remediation velocity and operational efficiency."
    - name: "high_recurrence_risk_cap_count"
      expr: COUNT(CASE WHEN recurrence_risk = 'High' THEN corrective_action_plan_id END)
      comment: "Number of CAPs assessed as high recurrence risk — a leading indicator of future audit findings requiring proactive intervention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_donor_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor compliance requirement KPIs tracking fulfillment rates, effort variance, waiver activity, and overdue obligations — critical for maintaining donor relationships and grant eligibility."
  source: "`vibe_ngo_v1`.`compliance`.`donor_requirement`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the donor requirement (e.g., compliant, non-compliant, pending)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier of the requirement, enabling triage of compliance effort."
    - name: "non_compliance_risk_level"
      expr: non_compliance_risk_level
      comment: "Assessed risk level of non-compliance consequences, enabling risk-weighted prioritization."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for fulfilling the requirement."
    - name: "submission_method"
      expr: submission_method
      comment: "Channel through which the requirement deliverable is submitted (e.g., portal, email, paper)."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Indicates whether a waiver was granted for this requirement, enabling waiver rate analysis."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the requirement is due, for annual compliance pipeline planning."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the requirement is due, for near-term compliance workload forecasting."
  measures:
    - name: "non_compliant_requirement_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN donor_requirement_id END)
      comment: "Number of donor requirements currently in non-compliant status — a direct measure of donor relationship and grant eligibility risk."
    - name: "overdue_requirement_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' AND due_date < CURRENT_DATE() THEN donor_requirement_id END)
      comment: "Count of requirements past their due date without compliance — signals immediate donor reporting risk."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total staff hours actually expended on donor compliance requirements — informs resource planning and cost allocation."
    - name: "total_estimated_effort_hours"
      expr: SUM(CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total estimated staff hours for donor compliance requirements, enabling capacity planning."
    - name: "effort_hour_variance"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE) - CAST(estimated_effort_hours AS DOUBLE))
      comment: "Aggregate variance between actual and estimated effort hours. Positive values indicate underestimation of compliance burden, informing future planning."
    - name: "waiver_granted_count"
      expr: COUNT(CASE WHEN waiver_granted_flag = TRUE THEN donor_requirement_id END)
      comment: "Number of requirements for which a waiver was granted — a governance signal monitored by donors and auditors."
    - name: "high_risk_non_compliant_count"
      expr: COUNT(CASE WHEN non_compliance_risk_level = 'High' AND compliance_status != 'Compliant' THEN donor_requirement_id END)
      comment: "Count of high-risk non-compliant requirements — the most critical subset requiring immediate executive escalation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_governance_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance policy KPIs tracking policy currency, review cycle compliance, conflict-of-interest disclosures, and IRS reporting obligations — essential for board governance and regulatory standing."
  source: "`vibe_ngo_v1`.`compliance`.`governance_policy`"
  dimensions:
    - name: "governance_policy_status"
      expr: governance_policy_status
      comment: "Current status of the governance policy (e.g., active, draft, superseded, expired)."
    - name: "category"
      expr: category
      comment: "Policy category (e.g., financial, HR, safeguarding) for portfolio-level governance analysis."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Regulatory or standards framework the policy aligns to (e.g., GAAP, GDPR, Sphere)."
    - name: "document_type"
      expr: document_type
      comment: "Type of governance document (e.g., policy, procedure, board resolution)."
    - name: "approving_authority"
      expr: approving_authority
      comment: "Body or individual that approved the policy, enabling governance accountability tracking."
    - name: "irs_990_disclosure_required"
      expr: irs_990_disclosure_required
      comment: "Flag indicating whether the policy requires IRS Form 990 disclosure — a regulatory compliance dimension."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Indicates whether the policy is publicly disclosed, relevant for transparency and donor trust."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the policy became effective, for policy vintage and currency analysis."
  measures:
    - name: "expired_policy_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND governance_policy_status = 'Active' THEN governance_policy_id END)
      comment: "Number of policies that have passed their expiry date but remain active — a critical governance gap indicating stale policy risk."
    - name: "overdue_review_policy_count"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND governance_policy_status = 'Active' THEN governance_policy_id END)
      comment: "Count of active policies overdue for their scheduled review — signals governance hygiene risk and potential regulatory non-compliance."
    - name: "conflict_of_interest_disclosure_count"
      expr: COUNT(CASE WHEN nature_of_conflict IS NOT NULL AND nature_of_conflict != '' THEN governance_policy_id END)
      comment: "Number of governance records with a documented conflict of interest — a board-level transparency and IRS compliance metric."
    - name: "irs_990_disclosure_required_count"
      expr: COUNT(CASE WHEN irs_990_disclosure_required = TRUE THEN governance_policy_id END)
      comment: "Count of policies requiring IRS 990 disclosure — informs annual tax filing completeness and regulatory risk."
    - name: "active_policy_count"
      expr: COUNT(CASE WHEN governance_policy_status = 'Active' THEN governance_policy_id END)
      comment: "Total number of currently active governance policies — a baseline portfolio health metric for board reporting."
    - name: "avg_days_since_last_review"
      expr: AVG(DATEDIFF(CURRENT_DATE(), last_review_date))
      comment: "Average age in days since policies were last reviewed. High values indicate governance staleness risk requiring board attention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance obligation KPIs tracking regulatory and donor obligation status, overdue rates, single audit requirements, and IATI publication compliance — foundational for organizational legal standing and donor eligibility."
  source: "`vibe_ngo_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current fulfillment status of the obligation (e.g., active, fulfilled, overdue, waived)."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (e.g., regulatory, donor, statutory) for portfolio segmentation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the obligation, enabling risk-weighted compliance prioritization."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the obligation, for multi-country compliance portfolio management."
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory or donor body that mandates the obligation."
    - name: "frequency"
      expr: frequency
      comment: "Recurrence frequency of the obligation (e.g., annual, quarterly, monthly)."
    - name: "single_audit_required"
      expr: single_audit_required
      comment: "Flag indicating whether a federal single audit is required — a critical federal compliance dimension."
    - name: "iati_publication_required"
      expr: iati_publication_required
      comment: "Flag indicating whether IATI aid transparency publication is required."
    - name: "next_due_year"
      expr: YEAR(next_due_date)
      comment: "Year of the next obligation due date for forward-looking compliance pipeline planning."
  measures:
    - name: "overdue_obligation_count"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND obligation_status NOT IN ('Fulfilled', 'Waived') THEN obligation_id END)
      comment: "Number of obligations past their due date without fulfillment — a primary legal and regulatory risk indicator."
    - name: "high_risk_obligation_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN obligation_id END)
      comment: "Count of obligations rated high risk — the critical subset requiring executive prioritization and resource allocation."
    - name: "single_audit_required_count"
      expr: COUNT(CASE WHEN single_audit_required = TRUE THEN obligation_id END)
      comment: "Number of obligations requiring a federal single audit — informs audit planning and federal compliance budget."
    - name: "iati_publication_required_count"
      expr: COUNT(CASE WHEN iati_publication_required = TRUE THEN obligation_id END)
      comment: "Count of obligations requiring IATI publication — tracks aid transparency compliance obligations."
    - name: "chs_self_assessment_required_count"
      expr: COUNT(CASE WHEN chs_self_assessment_required = TRUE THEN obligation_id END)
      comment: "Number of obligations requiring a Core Humanitarian Standard self-assessment — a key accountability framework metric."
    - name: "active_obligation_count"
      expr: COUNT(CASE WHEN obligation_status = 'Active' THEN obligation_id END)
      comment: "Total active obligations in the compliance portfolio — baseline for workload and resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_obligation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Obligation schedule KPIs measuring deadline adherence, escalation rates, penalty exposure, and effort efficiency — enabling operational compliance management and proactive risk mitigation."
  source: "`vibe_ngo_v1`.`compliance`.`obligation_schedule`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Current completion status of the scheduled obligation instance (e.g., completed, pending, overdue)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the scheduled obligation for workload triage."
    - name: "non_compliance_risk"
      expr: non_compliance_risk
      comment: "Risk level of non-compliance for this schedule instance."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction governing this obligation schedule instance."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework applicable to this obligation schedule."
    - name: "recurrence_pattern"
      expr: recurrence_pattern
      comment: "Recurrence pattern of the obligation (e.g., annual, quarterly) for workload forecasting."
    - name: "escalation_triggered_flag"
      expr: escalation_triggered_flag
      comment: "Indicates whether an escalation was triggered for this schedule instance."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Indicates whether a deadline extension was granted."
    - name: "planned_due_month"
      expr: DATE_TRUNC('MONTH', planned_due_date)
      comment: "Month of the planned due date for near-term compliance workload analysis."
  measures:
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalty exposure across obligation schedule instances. A direct financial risk metric for executive and finance leadership."
    - name: "overdue_schedule_count"
      expr: COUNT(CASE WHEN completion_status != 'Completed' AND effective_due_date < CURRENT_DATE() THEN obligation_schedule_id END)
      comment: "Number of obligation schedule instances past their effective due date — a primary operational compliance risk indicator."
    - name: "escalation_triggered_count"
      expr: COUNT(CASE WHEN escalation_triggered_flag = TRUE THEN obligation_schedule_id END)
      comment: "Count of schedule instances where escalation was triggered — signals systemic compliance execution failures requiring management intervention."
    - name: "extension_granted_count"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN obligation_schedule_id END)
      comment: "Number of deadline extensions granted — a governance metric indicating compliance capacity constraints or negotiation activity."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total staff hours actually spent fulfilling scheduled obligations — informs compliance resource planning and cost allocation."
    - name: "effort_hour_variance"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE) - CAST(estimated_effort_hours AS DOUBLE))
      comment: "Aggregate variance between actual and estimated effort hours for obligation schedules. Persistent overruns signal under-resourced compliance functions."
    - name: "avg_days_overdue"
      expr: AVG(CASE WHEN completion_status != 'Completed' AND effective_due_date < CURRENT_DATE() THEN DATEDIFF(CURRENT_DATE(), effective_due_date) END)
      comment: "Average number of days overdue for past-due obligation schedule instances — measures severity of compliance backlog."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing KPIs tracking submission timeliness, rejection rates, filing fee costs, and amendment activity — essential for statutory compliance and regulatory relationship management."
  source: "`vibe_ngo_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing (e.g., submitted, accepted, rejected, pending)."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel used to submit the filing (e.g., online portal, mail, in-person)."
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Indicates whether this is an amended filing — amendments signal prior errors and regulatory scrutiny risk."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Indicates whether a filing deadline extension was granted."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Indicates whether the filing is publicly disclosed."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason code for filing rejection, enabling root cause analysis of submission quality issues."
    - name: "filing_period_year"
      expr: YEAR(filing_period_start_date)
      comment: "Fiscal year of the filing period for annual compliance trend analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of filing submission for workload and timeliness trend analysis."
  measures:
    - name: "total_filing_fee_amount"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total filing fees paid across regulatory submissions — a direct compliance cost metric for budget management."
    - name: "rejected_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Rejected' THEN regulatory_filing_id END)
      comment: "Number of filings rejected by regulatory authorities — a quality and compliance risk metric requiring root cause analysis."
    - name: "late_submission_count"
      expr: COUNT(CASE WHEN submission_date > due_date AND submission_date IS NOT NULL THEN regulatory_filing_id END)
      comment: "Number of filings submitted after their due date — a primary regulatory compliance timeliness KPI."
    - name: "amendment_filing_count"
      expr: COUNT(CASE WHEN amendment_flag = TRUE THEN regulatory_filing_id END)
      comment: "Count of amended filings — elevated amendment rates signal data quality or process issues in original submissions."
    - name: "avg_days_to_acceptance"
      expr: AVG(DATEDIFF(acceptance_date, submission_date))
      comment: "Average calendar days from submission to regulatory acceptance — measures regulatory processing efficiency and filing quality."
    - name: "extension_granted_count"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN regulatory_filing_id END)
      comment: "Number of filings for which deadline extensions were granted — indicates compliance capacity constraints."
    - name: "avg_resubmission_count"
      expr: AVG(CAST(resubmission_count AS DOUBLE))
      comment: "Average number of resubmissions per filing — high values indicate systemic quality issues in the filing preparation process."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_single_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Federal single audit KPIs tracking questioned costs, material weakness rates, audit opinion quality, and corrective action plan submission — core metrics for federal award compliance and OMB Uniform Guidance adherence."
  source: "`vibe_ngo_v1`.`compliance`.`single_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the single audit engagement (e.g., in-progress, completed, submitted to FAC)."
    - name: "compliance_opinion_type"
      expr: compliance_opinion_type
      comment: "Auditor's compliance opinion type (e.g., unmodified, qualified, adverse, disclaimer) — a critical federal compliance signal."
    - name: "financial_statement_opinion_type"
      expr: financial_statement_opinion_type
      comment: "Auditor's financial statement opinion type — a key indicator of financial reporting integrity."
    - name: "internal_control_opinion_type"
      expr: internal_control_opinion_type
      comment: "Auditor's internal control opinion type — signals systemic control environment quality."
    - name: "material_weakness_identified_flag"
      expr: material_weakness_identified_flag
      comment: "Indicates whether a material weakness was identified in the audit — a critical governance and federal reporting flag."
    - name: "low_risk_auditee_flag"
      expr: low_risk_auditee_flag
      comment: "Indicates whether the organization qualifies as a low-risk auditee under OMB Uniform Guidance — affects audit scope and frequency."
    - name: "going_concern_issue_flag"
      expr: going_concern_issue_flag
      comment: "Indicates whether a going concern issue was identified — a critical organizational viability signal."
    - name: "audit_year"
      expr: audit_year
      comment: "Federal fiscal year of the single audit for year-over-year trend analysis."
    - name: "auditor_firm_name"
      expr: auditor_firm_name
      comment: "Name of the audit firm, enabling auditor performance and independence analysis."
  measures:
    - name: "total_federal_expenditure_amount"
      expr: SUM(CAST(federal_expenditure_amount AS DOUBLE))
      comment: "Total federal expenditures subject to single audit — the primary scope metric determining audit requirements under OMB Uniform Guidance."
    - name: "total_questioned_cost_amount"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total questioned costs identified across single audits — a direct measure of federal award financial risk and potential repayment liability."
    - name: "total_audit_cost_amount"
      expr: SUM(CAST(audit_cost_amount AS DOUBLE))
      comment: "Total cost of single audit engagements — informs compliance budget planning and auditor fee benchmarking."
    - name: "material_weakness_audit_count"
      expr: COUNT(CASE WHEN material_weakness_identified_flag = TRUE THEN single_audit_id END)
      comment: "Number of single audits where a material weakness was identified — a critical federal compliance and governance KPI."
    - name: "going_concern_audit_count"
      expr: COUNT(CASE WHEN going_concern_issue_flag = TRUE THEN single_audit_id END)
      comment: "Count of audits with a going concern issue — an existential organizational risk metric requiring immediate board attention."
    - name: "cap_not_submitted_count"
      expr: COUNT(CASE WHEN corrective_action_plan_submitted_flag = FALSE AND audit_status = 'Completed' THEN single_audit_id END)
      comment: "Number of completed audits where a corrective action plan has not been submitted — a federal compliance obligation gap metric."
    - name: "avg_audit_cost_amount"
      expr: AVG(CAST(audit_cost_amount AS DOUBLE))
      comment: "Average cost per single audit engagement — enables benchmarking of audit fees and procurement efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_statutory_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statutory registration KPIs tracking registration currency, renewal risk, donor eligibility, and operating authority status — foundational for legal standing, fundraising eligibility, and cross-border operations."
  source: "`vibe_ngo_v1`.`compliance`.`statutory_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the statutory registration (e.g., active, expired, pending renewal, lapsed)."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of statutory registration (e.g., charity, NGO, foundation, branch) for portfolio segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the registration with applicable regulatory requirements."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction code where the registration is held, enabling multi-country compliance portfolio management."
    - name: "tax_exempt_status"
      expr: tax_exempt_status
      comment: "Tax exemption status of the registered entity — affects donor deductibility and fundraising eligibility."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Indicates whether periodic renewal is required for this registration."
    - name: "donor_eligibility_verified_flag"
      expr: donor_eligibility_verified_flag
      comment: "Indicates whether donor eligibility has been verified for this registration — critical for grant applications."
    - name: "foreign_operations_permitted_flag"
      expr: foreign_operations_permitted_flag
      comment: "Indicates whether the registration permits foreign operations — a key operational authority dimension."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year of registration expiry for renewal pipeline planning."
  measures:
    - name: "expiring_registration_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND registration_status = 'Active' THEN statutory_registration_id END)
      comment: "Number of active registrations expiring within 90 days — a critical operational risk metric requiring immediate renewal action to maintain legal standing."
    - name: "expired_registration_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND registration_status = 'Active' THEN statutory_registration_id END)
      comment: "Number of registrations that have lapsed without renewal — signals immediate legal and operational risk in affected jurisdictions."
    - name: "non_compliant_registration_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN statutory_registration_id END)
      comment: "Count of registrations in non-compliant status — a direct measure of regulatory standing risk across jurisdictions."
    - name: "donor_eligibility_unverified_count"
      expr: COUNT(CASE WHEN donor_eligibility_verified_flag = FALSE AND registration_status = 'Active' THEN statutory_registration_id END)
      comment: "Number of active registrations where donor eligibility has not been verified — risks grant ineligibility and fundraising disruption."
    - name: "operating_authority_not_granted_count"
      expr: COUNT(CASE WHEN operating_authority_granted_flag = FALSE AND registration_status = 'Active' THEN statutory_registration_id END)
      comment: "Count of active registrations without operating authority granted — signals jurisdictions where program delivery may be legally at risk."
    - name: "avg_days_to_next_renewal"
      expr: AVG(DATEDIFF(next_renewal_date, CURRENT_DATE()))
      comment: "Average days until next renewal deadline across active registrations — a forward-looking compliance pipeline health metric."
$$;