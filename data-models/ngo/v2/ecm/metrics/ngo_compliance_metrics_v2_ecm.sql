-- Metric views for domain: compliance | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks audit findings across awards and programs, measuring financial exposure from questioned costs, severity distribution, repeat findings, and resolution timeliness. Primary KPI surface for external audit management and OMB Uniform Guidance compliance (Single Audit Act). Sourced from FAC submissions and internal audit tracking systems (e.g., SAP Audit Management, eTools)."
  source: "`vibe_ngo_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the audit finding (e.g., material weakness, significant deficiency, questioned cost, compliance) — used to segment risk exposure by category."
    - name: "finding_status"
      expr: finding_status
      comment: "Current lifecycle status of the finding (e.g., open, in remediation, closed) — drives remediation pipeline reporting."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the finding (e.g., critical, high, medium, low) — used to prioritize corrective action resources."
    - name: "compliance_requirement_type"
      expr: compliance_requirement_type
      comment: "Federal or donor compliance requirement category the finding relates to (e.g., procurement, reporting, allowable costs) — aligns findings to regulatory frameworks."
    - name: "federal_agency_name"
      expr: federal_agency_name
      comment: "Name of the federal agency associated with the award under audit — enables agency-level risk segmentation."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Organizational department accountable for the finding — supports internal accountability reporting."
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Boolean flag indicating whether this finding recurred from a prior audit period — repeat findings signal systemic control weaknesses."
    - name: "is_material_weakness"
      expr: is_material_weakness
      comment: "Boolean flag indicating a material weakness in internal controls — highest-severity audit classification with donor and regulatory implications."
    - name: "finding_identified_year"
      expr: DATE_TRUNC('YEAR', finding_identified_date)
      comment: "Year the finding was identified — enables year-over-year trend analysis of audit quality."
    - name: "audit_period_end_year"
      expr: DATE_TRUNC('YEAR', audit_period_end_date)
      comment: "Fiscal year end of the audit period — aligns findings to the audited fiscal year for longitudinal comparison."
  measures:
    - name: "total_questioned_cost_usd"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total dollar value of costs questioned by auditors as potentially unallowable. A primary financial risk indicator for donor compliance and federal award management. High values trigger donor notifications and potential fund recovery actions."
    - name: "avg_questioned_cost_per_finding_usd"
      expr: AVG(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Average questioned cost per audit finding. Benchmarks the financial materiality of individual findings and informs risk-based audit planning."
    - name: "total_open_findings"
      expr: COUNT(CASE WHEN finding_status = 'open' THEN 1 END)
      comment: "Count of audit findings currently in open/unresolved status. A key operational risk metric — high open counts indicate remediation backlogs that may trigger donor sanctions or regulatory escalation."
    - name: "total_repeat_findings"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END)
      comment: "Count of findings that recurred from a prior audit cycle. Repeat findings are a leading indicator of systemic internal control failures and are specifically flagged in Single Audit reports to federal oversight bodies."
    - name: "total_material_weakness_findings"
      expr: COUNT(CASE WHEN is_material_weakness = TRUE THEN 1 END)
      comment: "Count of findings classified as material weaknesses. Material weaknesses carry the highest regulatory and reputational risk, often requiring immediate board notification and donor disclosure."
    - name: "total_fraud_indicator_findings"
      expr: COUNT(CASE WHEN is_fraud_indicator = TRUE THEN 1 END)
      comment: "Count of findings with a fraud indicator flag. Fraud-related findings require mandatory reporting to cognizant agencies and may trigger suspension of federal awards."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(actual_resolution_date, finding_identified_date))
      comment: "Average number of days from finding identification to actual resolution. Measures remediation velocity — slow resolution increases regulatory exposure and may breach corrective action plan deadlines."
    - name: "overdue_findings_count"
      expr: COUNT(CASE WHEN finding_status != 'closed' AND expected_resolution_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of open findings where the expected resolution date has passed. Directly measures compliance deadline breach risk and informs escalation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors corrective action plan (CAP) execution across audit findings and compliance incidents. Tracks cost, timeliness, and completion rates to ensure remediation commitments to donors and regulators are met. Relevant to OMB Uniform Guidance, CHS commitments, and donor grant conditions."
  source: "`vibe_ngo_v1`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "cap_status"
      expr: cap_status
      comment: "Current lifecycle status of the corrective action plan (e.g., draft, in progress, completed, overdue) — primary operational filter for remediation pipeline management."
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit or compliance finding that triggered this CAP — enables segmentation of remediation effort by finding category."
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity level of the underlying finding — used to prioritize high-severity CAPs for executive attention."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for executing the corrective action — supports departmental accountability reporting."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Boolean flag indicating whether the donor must be notified of this corrective action — flags CAPs with external disclosure obligations."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Boolean flag indicating whether regulatory reporting is required for this CAP — identifies CAPs with statutory disclosure obligations."
    - name: "target_completion_year"
      expr: DATE_TRUNC('YEAR', target_completion_date)
      comment: "Year the CAP is targeted for completion — enables annual remediation planning and resource allocation."
    - name: "recurrence_risk"
      expr: recurrence_risk
      comment: "Assessed risk level that the underlying issue will recur — informs preventive investment decisions."
  measures:
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to execute corrective action plans. Measures the financial burden of compliance remediation — a key input to cost-of-non-compliance analysis and budget planning."
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective action plans. Used for remediation budget forecasting and comparison against actual spend to assess cost estimation accuracy."
    - name: "avg_actual_cost_per_cap_usd"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action plan. Benchmarks remediation cost efficiency and informs future CAP budgeting."
    - name: "total_completed_caps"
      expr: COUNT(CASE WHEN cap_status = 'completed' THEN 1 END)
      comment: "Count of corrective action plans that have been fully completed. Measures remediation throughput — a key performance indicator for compliance program effectiveness."
    - name: "total_overdue_caps"
      expr: COUNT(CASE WHEN cap_status != 'completed' AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of CAPs that have passed their target completion date without closure. Overdue CAPs represent active regulatory and donor relationship risk requiring executive escalation."
    - name: "avg_days_to_cap_completion"
      expr: AVG(DATEDIFF(actual_completion_date, created_timestamp))
      comment: "Average number of days from CAP creation to actual completion. Measures remediation velocity — a leading indicator of compliance program responsiveness."
    - name: "cost_overrun_amount_usd"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total cost overrun across all corrective action plans (actual minus estimated). Negative values indicate under-spend; positive values indicate budget pressure on the compliance function."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks compliance incidents including fraud, misuse of funds, regulatory breaches, and policy violations. Measures financial impact, investigation timeliness, and donor notification compliance. Critical for organizational risk management, donor reporting, and regulatory obligations. Relevant to FCPA, anti-fraud policies, and donor grant conditions."
  source: "`vibe_ngo_v1`.`compliance`.`compliance_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of compliance incident (e.g., fraud, misuse of funds, conflict of interest, regulatory breach) — primary segmentation dimension for risk analysis."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident (e.g., reported, under investigation, resolved, closed) — drives incident pipeline management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident — used to prioritize investigation resources and escalation decisions."
    - name: "allegation_category"
      expr: allegation_category
      comment: "Specific allegation type within the incident category — enables granular risk pattern analysis."
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Boolean flag indicating whether the donor must be notified — identifies incidents with external disclosure obligations that affect donor relationships."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Boolean flag indicating whether regulatory reporting is required — identifies incidents with statutory disclosure obligations."
    - name: "reporting_channel"
      expr: reporting_channel
      comment: "Channel through which the incident was reported (e.g., hotline, manager, audit) — informs effectiveness of reporting mechanisms."
    - name: "incident_reported_year"
      expr: DATE_TRUNC('YEAR', reported_date)
      comment: "Year the incident was reported — enables year-over-year trend analysis of compliance incident rates."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Boolean flag indicating whether the incident required public disclosure — tracks reputational risk events."
  measures:
    - name: "total_estimated_financial_impact_usd"
      expr: SUM(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Total estimated financial impact of compliance incidents. The primary financial risk metric for the compliance function — directly informs reserve requirements, donor notifications, and board risk reporting."
    - name: "avg_financial_impact_per_incident_usd"
      expr: AVG(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Average estimated financial impact per compliance incident. Benchmarks incident severity and informs risk appetite thresholds."
    - name: "total_open_incidents"
      expr: COUNT(CASE WHEN incident_status NOT IN ('resolved', 'closed') THEN 1 END)
      comment: "Count of compliance incidents currently open or under investigation. A key operational risk indicator — high open counts signal investigation capacity constraints or systemic compliance failures."
    - name: "total_donor_notification_required"
      expr: COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of incidents requiring donor notification. Tracks the volume of donor relationship risk events — missed notifications can trigger grant suspension or clawback."
    - name: "avg_days_to_investigation_completion"
      expr: AVG(DATEDIFF(investigation_completion_date, investigation_start_date))
      comment: "Average number of days to complete an investigation from start to close. Measures investigation efficiency — slow investigations increase regulatory exposure and donor confidence risk."
    - name: "avg_days_to_donor_notification"
      expr: AVG(DATEDIFF(donor_notification_date, reported_date))
      comment: "Average days from incident report to donor notification. Many donor agreements require notification within 72 hours or 5 business days — this metric directly measures compliance with those contractual obligations."
    - name: "total_incidents_requiring_regulatory_report"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Count of incidents requiring regulatory reporting. Tracks the volume of statutory disclosure obligations arising from compliance incidents — missed filings carry legal penalties."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_obligation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors the execution of scheduled compliance obligations (regulatory filings, donor reports, statutory renewals). Tracks on-time delivery, penalty exposure, and workload distribution. A primary operational dashboard for the compliance calendar — missed obligations can trigger fines, grant suspension, or loss of operating authority. Relevant to OMB, IATI, statutory registration, and donor reporting requirements."
  source: "`vibe_ngo_v1`.`compliance`.`obligation_schedule`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Current completion status of the scheduled obligation (e.g., pending, in progress, completed, overdue) — primary filter for compliance calendar management."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the obligation schedule item — used to triage workload and focus resources on highest-risk deadlines."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory or donor framework governing this obligation (e.g., OMB Uniform Guidance, IATI, FCPA) — enables framework-level compliance posture reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction in which the obligation must be fulfilled — supports country-level compliance reporting for multi-country INGOs."
    - name: "recurrence_pattern"
      expr: recurrence_pattern
      comment: "Frequency pattern of the obligation (e.g., annual, quarterly, monthly) — informs compliance calendar planning and resource forecasting."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Boolean flag indicating whether a filing extension was granted — tracks reliance on extensions as a proxy for compliance capacity strain."
    - name: "escalation_triggered_flag"
      expr: escalation_triggered_flag
      comment: "Boolean flag indicating whether the obligation triggered an escalation — measures the frequency of compliance deadline breaches requiring management intervention."
    - name: "planned_due_year"
      expr: DATE_TRUNC('YEAR', planned_due_date)
      comment: "Year of the planned due date — enables annual compliance workload planning and capacity forecasting."
    - name: "workflow_stage"
      expr: workflow_stage
      comment: "Current workflow stage of the obligation execution (e.g., drafting, review, submitted) — provides pipeline visibility for compliance managers."
  measures:
    - name: "total_penalty_exposure_usd"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty amount across all obligation schedule items. The primary financial risk metric for the compliance calendar — quantifies the cost of non-compliance and informs prioritization of remediation resources."
    - name: "avg_penalty_per_obligation_usd"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per scheduled obligation. Benchmarks the financial stakes of individual compliance deadlines and informs risk-based prioritization."
    - name: "total_overdue_obligations"
      expr: COUNT(CASE WHEN completion_status != 'completed' AND effective_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of obligation schedule items that are past their effective due date and not yet completed. The primary operational risk metric for the compliance calendar — directly measures active regulatory breach exposure."
    - name: "total_escalated_obligations"
      expr: COUNT(CASE WHEN escalation_triggered_flag = TRUE THEN 1 END)
      comment: "Count of obligations that triggered an escalation due to deadline risk. Measures the frequency of compliance management interventions required — a leading indicator of systemic capacity issues."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual staff hours expended on compliance obligation execution. Measures the true operational cost of the compliance function and informs staffing and capacity planning."
    - name: "avg_actual_effort_hours_per_obligation"
      expr: AVG(CAST(actual_effort_hours AS DOUBLE))
      comment: "Average actual staff hours per compliance obligation. Benchmarks compliance workload per obligation type — informs resource allocation and process improvement decisions."
    - name: "effort_variance_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE) - CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total variance between actual and estimated effort hours across all obligations. Positive values indicate underestimation of compliance workload — a key input to capacity planning and budget accuracy improvement."
    - name: "on_time_completion_count"
      expr: COUNT(CASE WHEN completion_status = 'completed' AND actual_effort_hours > 0 AND effective_due_date >= planned_due_date THEN 1 END)
      comment: "Count of obligations completed on or before their effective due date. Measures compliance program delivery reliability — a key KPI for board and donor reporting on organizational compliance posture."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_single_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks Single Audit (OMB Uniform Guidance 2 CFR Part 200) execution and outcomes for federal award recipients. Monitors federal expenditure thresholds, audit findings, questioned costs, and audit opinion quality. Critical for organizations receiving >$750K in federal awards annually. Sourced from FAC (Federal Audit Clearinghouse) submissions."
  source: "`vibe_ngo_v1`.`compliance`.`single_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the single audit engagement (e.g., planned, fieldwork, report issued, submitted to FAC) — tracks audit pipeline progress."
    - name: "compliance_opinion_type"
      expr: compliance_opinion_type
      comment: "Auditor's compliance opinion type (e.g., unmodified, qualified, adverse, disclaimer) — the most critical audit quality indicator for federal award compliance."
    - name: "financial_statement_opinion_type"
      expr: financial_statement_opinion_type
      comment: "Auditor's financial statement opinion type — indicates the reliability of the organization's financial reporting."
    - name: "internal_control_opinion_type"
      expr: internal_control_opinion_type
      comment: "Auditor's opinion on internal controls over compliance — a key indicator of organizational control environment quality."
    - name: "audit_year"
      expr: audit_year
      comment: "Fiscal year covered by the single audit — primary time dimension for year-over-year audit quality trending."
    - name: "low_risk_auditee_flag"
      expr: low_risk_auditee_flag
      comment: "Boolean flag indicating low-risk auditee status under OMB Uniform Guidance — low-risk status reduces audit scope and cost, a key compliance program achievement."
    - name: "material_weakness_identified_flag"
      expr: material_weakness_identified_flag
      comment: "Boolean flag indicating a material weakness was identified — highest-severity internal control finding with mandatory donor and regulatory disclosure implications."
    - name: "going_concern_issue_flag"
      expr: going_concern_issue_flag
      comment: "Boolean flag indicating a going concern issue was identified — a critical organizational viability indicator affecting donor confidence and award eligibility."
    - name: "audit_period_end_year"
      expr: DATE_TRUNC('YEAR', audit_period_end_date)
      comment: "Year of the audit period end date — enables longitudinal analysis of audit outcomes across fiscal years."
  measures:
    - name: "total_federal_expenditure_usd"
      expr: SUM(CAST(federal_expenditure_amount AS DOUBLE))
      comment: "Total federal award expenditure subject to single audit. The primary threshold metric — organizations exceeding $750K annually are required to undergo a single audit. Tracks the scale of federal funding under audit scope."
    - name: "total_questioned_cost_usd"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total questioned costs identified across single audits. Represents potential fund recovery exposure — a primary financial risk metric for federal award management and donor relations."
    - name: "total_audit_cost_usd"
      expr: SUM(CAST(audit_cost_amount AS DOUBLE))
      comment: "Total cost of single audit engagements. Measures the direct financial cost of federal compliance — informs cost-benefit analysis of federal funding and audit firm procurement decisions."
    - name: "avg_audit_cost_usd"
      expr: AVG(CAST(audit_cost_amount AS DOUBLE))
      comment: "Average cost per single audit engagement. Benchmarks audit procurement efficiency and informs future audit budget planning."
    - name: "total_audits_with_material_weakness"
      expr: COUNT(CASE WHEN material_weakness_identified_flag = TRUE THEN 1 END)
      comment: "Count of single audits where a material weakness was identified. Material weaknesses trigger mandatory corrective action plans and may result in award suspension — a critical board-level risk indicator."
    - name: "total_low_risk_auditee_audits"
      expr: COUNT(CASE WHEN low_risk_auditee_flag = TRUE THEN 1 END)
      comment: "Count of audits where the organization qualified as a low-risk auditee. Low-risk status is a compliance program achievement that reduces audit scope and cost — tracks progress toward sustained compliance excellence."
    - name: "avg_days_fieldwork_duration"
      expr: AVG(DATEDIFF(fieldwork_end_date, fieldwork_start_date))
      comment: "Average duration of audit fieldwork in days. Measures audit execution efficiency — extended fieldwork may indicate control environment weaknesses or auditor access issues."
    - name: "avg_days_report_to_submission"
      expr: AVG(DATEDIFF(updated_timestamp, audit_report_date))
      comment: "Average days from audit report issuance to FAC submission. OMB Uniform Guidance requires submission within 30 days of report issuance — this metric directly measures compliance with that deadline."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory filing submissions including IRS Form 990, statutory registrations, IATI publications, and donor reports. Monitors on-time submission rates, rejection rates, and filing fee expenditure. Critical for maintaining tax-exempt status, operating authority, and donor transparency obligations. Relevant to IRS, state charity regulators, and international statutory bodies."
  source: "`vibe_ngo_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing (e.g., draft, submitted, accepted, rejected, overdue) — primary operational filter for filing pipeline management."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel used to submit the filing (e.g., electronic, mail, portal) — informs channel optimization and automation opportunities."
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Boolean flag indicating this is an amended filing — tracks the frequency of corrections, a proxy for filing quality."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Boolean flag indicating a filing extension was granted — tracks reliance on extensions as a compliance capacity indicator."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Boolean flag indicating the filing is subject to public disclosure — identifies filings with transparency and reputational implications."
    - name: "filing_period_end_year"
      expr: DATE_TRUNC('YEAR', filing_period_end_date)
      comment: "Fiscal year end of the filing period — enables year-over-year filing compliance trend analysis."
    - name: "submission_year"
      expr: DATE_TRUNC('YEAR', submission_date)
      comment: "Calendar year of filing submission — tracks filing volume and timeliness trends over time."
  measures:
    - name: "total_filing_fee_usd"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total filing fees paid across all regulatory filings. Measures the direct cost of regulatory compliance — informs compliance budget planning and cost reduction opportunities."
    - name: "total_rejected_filings"
      expr: COUNT(CASE WHEN filing_status = 'rejected' THEN 1 END)
      comment: "Count of regulatory filings that were rejected by the regulatory authority. Rejected filings require resubmission, incur additional cost, and may result in late filing penalties — a key quality metric for the compliance function."
    - name: "total_amended_filings"
      expr: COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END)
      comment: "Count of filings submitted as amendments to prior filings. High amendment rates indicate data quality or process issues in the original filing workflow."
    - name: "avg_days_to_acceptance"
      expr: AVG(DATEDIFF(acceptance_date, submission_date))
      comment: "Average days from filing submission to regulatory acceptance. Measures regulatory processing efficiency and informs planning for dependent compliance activities."
    - name: "total_overdue_filings"
      expr: COUNT(CASE WHEN filing_status NOT IN ('accepted', 'submitted') AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of filings that are past their due date and not yet accepted. Directly measures active regulatory breach exposure — overdue filings can result in penalties, loss of tax-exempt status, or operating authority revocation."
    - name: "total_resubmission_count"
      expr: COUNT(CASE WHEN resubmission_count IS NOT NULL THEN 1 END)
      comment: "Count of filings that required at least one resubmission. Resubmissions indicate quality failures in the initial filing process and incur additional staff cost and regulatory scrutiny."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_sanctions_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks sanctions screening activity for counterparties, vendors, partners, and beneficiaries against OFAC, UN, EU, and other sanctions lists. Monitors match rates, false positive rates, and screening coverage. Critical for anti-terrorism financing (ATF) compliance, donor requirements (especially US government awards), and organizational risk management."
  source: "`vibe_ngo_v1`.`compliance`.`sanctions_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the screening record (e.g., pending, cleared, flagged, escalated) — primary operational filter for sanctions compliance pipeline."
    - name: "match_result"
      expr: match_result
      comment: "Outcome of the sanctions list match check (e.g., no match, potential match, confirmed match) — the primary risk classification for each screening record."
    - name: "subject_type"
      expr: subject_type
      comment: "Type of entity screened (e.g., individual, organization, vendor, partner) — enables risk segmentation by counterparty category."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the screened subject — used to prioritize enhanced due diligence and rescreening frequency."
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Boolean flag indicating the match was determined to be a false positive — tracks screening tool accuracy and informs tool calibration decisions."
    - name: "rescreening_required_flag"
      expr: rescreening_required_flag
      comment: "Boolean flag indicating periodic rescreening is required — identifies subjects requiring ongoing monitoring."
    - name: "screening_method"
      expr: screening_method
      comment: "Method used for screening (e.g., automated, manual, batch) — informs automation coverage and manual review workload."
    - name: "screening_year"
      expr: DATE_TRUNC('YEAR', screening_date)
      comment: "Year of the screening event — enables year-over-year screening volume and match rate trend analysis."
    - name: "subject_nationality"
      expr: subject_nationality
      comment: "Nationality of the screened subject — enables geographic risk segmentation and country-level sanctions exposure analysis."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of sanctions screenings conducted. Measures screening program coverage — a key compliance program activity metric for donor audits and regulatory reviews."
    - name: "total_confirmed_matches"
      expr: COUNT(CASE WHEN match_result = 'confirmed match' THEN 1 END)
      comment: "Count of screenings resulting in a confirmed sanctions list match. Confirmed matches require immediate escalation, transaction blocking, and regulatory reporting — the highest-severity outcome in sanctions compliance."
    - name: "total_potential_matches"
      expr: COUNT(CASE WHEN match_result = 'potential match' THEN 1 END)
      comment: "Count of screenings with potential (unresolved) matches requiring further review. Measures the active investigation workload for the sanctions compliance team."
    - name: "total_false_positives"
      expr: COUNT(CASE WHEN false_positive_flag = TRUE THEN 1 END)
      comment: "Count of screenings determined to be false positives. High false positive rates indicate screening tool calibration issues — excessive false positives create operational burden and delay legitimate transactions."
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across all screening records. Tracks the overall confidence level of screening matches — informs threshold calibration decisions for the screening tool."
    - name: "total_overdue_rescreenings"
      expr: COUNT(CASE WHEN rescreening_required_flag = TRUE AND next_screening_due_date < CURRENT_DATE() AND screening_status != 'cleared' THEN 1 END)
      comment: "Count of subjects requiring rescreening where the next screening due date has passed. Overdue rescreenings represent active sanctions compliance gaps — many donor agreements require periodic rescreening of all counterparties."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, screening_date))
      comment: "Average days from screening to resolution of flagged matches. Measures sanctions review efficiency — slow resolution delays program activities and may breach donor-mandated timelines."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_chs_self_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks Core Humanitarian Standard (CHS) self-assessment scores and conformity ratings across country offices and programs. Monitors commitment-level performance, overall conformity, and assessment cycle compliance. The CHS is the primary accountability framework for INGOs — assessment results are reported to donors, clusters, and the CHS Alliance. Sourced from KoboToolbox, ODK, or dedicated CHS assessment platforms."
  source: "`vibe_ngo_v1`.`compliance`.`chs_self_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the CHS self-assessment (e.g., in progress, submitted, verified, certified) — tracks assessment pipeline completion."
    - name: "overall_conformity_rating"
      expr: overall_conformity_rating
      comment: "Overall CHS conformity rating (e.g., strong, adequate, weak, non-conforming) — the primary summary indicator of organizational CHS compliance posture."
    - name: "assessment_methodology"
      expr: assessment_methodology
      comment: "Methodology used for the assessment (e.g., self-assessment, third-party verification, peer review) — informs the credibility and rigor of the assessment results."
    - name: "certification_target_flag"
      expr: certification_target_flag
      comment: "Boolean flag indicating whether this assessment is targeting CHS certification — distinguishes certification-track assessments from routine self-assessments."
    - name: "assessment_period_end_year"
      expr: DATE_TRUNC('YEAR', assessment_period_end_date)
      comment: "Year of the assessment period end — enables year-over-year CHS performance trend analysis."
    - name: "verification_body"
      expr: verification_body
      comment: "External body that verified or certified the assessment — tracks third-party assurance coverage."
  measures:
    - name: "avg_overall_conformity_score"
      expr: AVG(CAST(overall_conformity_score AS DOUBLE))
      comment: "Average overall CHS conformity score across all assessments. The primary strategic KPI for CHS compliance — tracks organizational progress toward full CHS conformity and informs donor accountability reporting."
    - name: "avg_commitment_1_rating"
      expr: AVG(CAST(commitment_1_rating AS DOUBLE))
      comment: "Average score for CHS Commitment 1 (Humanitarian response is appropriate and relevant). Commitment-level scores identify specific areas of strength and weakness for targeted improvement investment."
    - name: "avg_commitment_2_rating"
      expr: AVG(CAST(commitment_2_rating AS DOUBLE))
      comment: "Average score for CHS Commitment 2 (Humanitarian response is effective and timely). Tracks timeliness and effectiveness of humanitarian delivery against the CHS standard."
    - name: "avg_commitment_3_rating"
      expr: AVG(CAST(commitment_3_rating AS DOUBLE))
      comment: "Average score for CHS Commitment 3 (Humanitarian response strengthens local capacities). Measures localization performance — a strategic priority for most INGO donors."
    - name: "avg_commitment_4_rating"
      expr: AVG(CAST(commitment_4_rating AS DOUBLE))
      comment: "Average score for CHS Commitment 4 (Humanitarian response is based on communication, participation and feedback). Tracks community engagement and accountability to affected populations (AAP)."
    - name: "avg_commitment_5_rating"
      expr: AVG(CAST(commitment_5_rating AS DOUBLE))
      comment: "Average score for CHS Commitment 5 (Complaints are welcomed and addressed). Measures feedback and complaints mechanism effectiveness — a key safeguarding and accountability indicator."
    - name: "avg_commitment_9_rating"
      expr: AVG(CAST(commitment_9_rating AS DOUBLE))
      comment: "Average score for CHS Commitment 9 (Resources are managed and used responsibly). Tracks financial accountability and resource stewardship — directly relevant to donor audit requirements."
    - name: "total_assessments_overdue_for_renewal"
      expr: COUNT(CASE WHEN next_assessment_due_date < CURRENT_DATE() AND assessment_status != 'submitted' THEN 1 END)
      comment: "Count of CHS assessments where the next assessment due date has passed without a new submission. Overdue assessments represent gaps in the CHS accountability cycle — some donors require current CHS assessments as a condition of award."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_iati_publication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks IATI (International Aid Transparency Initiative) publication quality, timeliness, and completeness. Monitors data quality scores, publication coverage, and budget/disbursement transparency. IATI publication is mandatory for most bilateral donors (USAID, FCDO, ECHO) and is publicly scored on the IATI Dashboard — poor scores affect donor eligibility and organizational reputation."
  source: "`vibe_ngo_v1`.`compliance`.`iati_publication`"
  dimensions:
    - name: "publication_status"
      expr: publication_status
      comment: "Current status of the IATI publication (e.g., draft, published, superseded, withdrawn) — tracks publication pipeline and active data coverage."
    - name: "publication_type"
      expr: publication_type
      comment: "Type of IATI publication (e.g., activity, organisation) — distinguishes activity-level from organisation-level transparency reporting."
    - name: "iati_version"
      expr: iati_version
      comment: "IATI standard version used for the publication — tracks version adoption and migration to current standards."
    - name: "timeliness_category"
      expr: timeliness_category
      comment: "IATI timeliness category (e.g., real-time, current, historical) — a key component of the IATI quality score that affects donor eligibility assessments."
    - name: "reporting_currency"
      expr: reporting_currency
      comment: "Currency used for financial reporting in the IATI publication — relevant for multi-currency transparency analysis."
    - name: "reporting_period_end_year"
      expr: DATE_TRUNC('YEAR', reporting_period_end_date)
      comment: "Year of the reporting period end — enables year-over-year IATI publication quality trend analysis."
  measures:
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average IATI data quality score across all publications. The primary IATI performance KPI — publicly visible on the IATI Dashboard and used by donors to assess organizational transparency. Low scores can affect award eligibility."
    - name: "avg_completeness_percentage"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average data completeness percentage across IATI publications. Measures the proportion of required IATI fields populated — a key component of the overall quality score."
    - name: "avg_timeliness_score"
      expr: AVG(CAST(timeliness_score AS DOUBLE))
      comment: "Average timeliness score across IATI publications. Timeliness is a scored dimension of IATI quality — measures how current the published data is relative to actual activities."
    - name: "total_budget_value_published_usd"
      expr: SUM(CAST(total_budget_value AS DOUBLE))
      comment: "Total budget value published through IATI. Measures the financial transparency coverage of the organization — a key indicator of commitment to aid transparency and donor accountability."
    - name: "total_disbursement_value_published_usd"
      expr: SUM(CAST(total_disbursement_value AS DOUBLE))
      comment: "Total disbursement value published through IATI. Tracks the volume of financial flows made transparent through IATI — directly measures financial transparency performance."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size of all IATI publications in bytes. Measures the volume of data published — large file sizes may indicate data quality issues or need for publication optimization."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_nicra_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks Negotiated Indirect Cost Rate Agreements (NICRAs) with cognizant federal agencies. Monitors indirect cost rates, fringe benefit rates, and agreement status. NICRAs directly determine the overhead recovery on all US government awards — rate changes have significant financial impact on organizational sustainability. Relevant to OMB 2 CFR Part 200 and USAID/State Department award management."
  source: "`vibe_ngo_v1`.`compliance`.`nicra_agreement`"
  dimensions:
    - name: "nicra_agreement_status"
      expr: nicra_agreement_status
      comment: "Current status of the NICRA (e.g., active, expired, under negotiation, superseded) — tracks the currency of indirect cost rate authority."
    - name: "cost_base_type"
      expr: cost_base_type
      comment: "Type of cost base used for indirect cost calculation (e.g., modified total direct costs, total direct costs) — determines the scope of indirect cost recovery."
    - name: "fiscal_year_basis"
      expr: fiscal_year_basis
      comment: "Fiscal year basis for the NICRA rates — aligns rate application to the correct fiscal period."
    - name: "de_minimis_rate_elected"
      expr: de_minimis_rate_elected
      comment: "Boolean flag indicating the organization elected the de minimis 10% indirect cost rate — organizations electing de minimis may be leaving indirect cost recovery on the table."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the NICRA became effective — enables longitudinal tracking of rate changes over time."
  measures:
    - name: "avg_indirect_cost_rate_pct"
      expr: AVG(CAST(indirect_cost_rate_percentage AS DOUBLE))
      comment: "Average negotiated indirect cost rate percentage across active NICRAs. The primary financial sustainability metric for indirect cost recovery — directly determines overhead funding on all US government awards. Rate trends inform negotiation strategy."
    - name: "max_indirect_cost_rate_pct"
      expr: MAX(indirect_cost_rate_percentage)
      comment: "Maximum negotiated indirect cost rate across all NICRAs. Identifies the highest rate achieved — a benchmark for negotiation targets and comparison against peer organizations."
    - name: "avg_fringe_benefit_rate_pct"
      expr: AVG(CAST(fringe_benefit_rate_percentage AS DOUBLE))
      comment: "Average negotiated fringe benefit rate percentage. Fringe rates directly affect the cost of staff charged to federal awards — rate accuracy is critical for budget development and award financial management."
    - name: "total_active_nicra_agreements"
      expr: COUNT(CASE WHEN nicra_agreement_status = 'active' THEN 1 END)
      comment: "Count of currently active NICRA agreements. Organizations should maintain at least one active NICRA to recover indirect costs on federal awards — zero active NICRAs represents a critical financial risk."
    - name: "total_expired_nicra_agreements"
      expr: COUNT(CASE WHEN nicra_agreement_status = 'expired' THEN 1 END)
      comment: "Count of expired NICRA agreements. Expired NICRAs without a successor agreement mean the organization cannot recover indirect costs on new federal awards — a significant financial sustainability risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_statutory_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks statutory registrations, tax-exempt status, and operating authority across all jurisdictions where the organization operates. Monitors registration currency, renewal deadlines, and compliance status. Lapsed registrations can result in loss of operating authority, tax-exempt status, or donor eligibility — a critical organizational risk for multi-country INGOs. Relevant to IRS, state charity regulators, and host country NGO registration authorities."
  source: "`vibe_ngo_v1`.`compliance`.`statutory_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the statutory registration (e.g., active, expired, suspended, pending renewal) — primary filter for registration compliance monitoring."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (e.g., federal tax-exempt, state charity, host country NGO, foreign qualification) — enables segmentation by regulatory category."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the registration (e.g., compliant, non-compliant, at risk) — the primary risk classification for each registration record."
    - name: "tax_exempt_status"
      expr: tax_exempt_status
      comment: "Tax-exempt status classification (e.g., 501(c)(3), 501(c)(4)) — critical for donor deductibility and grant eligibility."
    - name: "registered_country_code"
      expr: registered_country_code
      comment: "Country code of the registration jurisdiction — enables geographic segmentation of registration compliance posture."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Boolean flag indicating periodic renewal is required — identifies registrations requiring active lifecycle management."
    - name: "donor_eligibility_verified_flag"
      expr: donor_eligibility_verified_flag
      comment: "Boolean flag indicating donor eligibility has been verified for this registration — tracks the currency of donor eligibility verification."
    - name: "foreign_operations_permitted_flag"
      expr: foreign_operations_permitted_flag
      comment: "Boolean flag indicating foreign operations are permitted under this registration — critical for multi-country INGO operating authority."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the registration became effective — enables longitudinal analysis of registration portfolio growth."
  measures:
    - name: "total_active_registrations"
      expr: COUNT(CASE WHEN registration_status = 'active' THEN 1 END)
      comment: "Count of currently active statutory registrations. Measures the breadth of the organization's legal operating footprint — a key indicator of geographic program delivery capacity."
    - name: "total_expired_registrations"
      expr: COUNT(CASE WHEN registration_status = 'expired' THEN 1 END)
      comment: "Count of expired registrations. Expired registrations represent active legal and operational risk — the organization may be operating without legal authority in those jurisdictions."
    - name: "total_renewals_due_within_90_days"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE AND next_renewal_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Count of registrations requiring renewal within the next 90 days. A forward-looking risk metric that drives proactive renewal management — missed renewals can result in loss of operating authority."
    - name: "total_non_compliant_registrations"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Count of registrations in non-compliant status. Non-compliant registrations represent active regulatory risk — they may affect the organization's ability to receive grants, operate programs, or maintain tax-exempt status."
    - name: "total_jurisdictions_covered"
      expr: COUNT(DISTINCT registered_country_code)
      comment: "Count of distinct jurisdictions where the organization holds statutory registrations. Measures the geographic scope of legal operating authority — a key indicator of program delivery reach and regulatory complexity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_donor_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks donor-specific compliance requirements attached to awards, including reporting obligations, prior approval requirements, and special conditions. Monitors fulfillment status, effort burden, and waiver activity. Non-compliance with donor requirements can trigger grant suspension, clawback, or debarment — a critical risk management surface for grant-funded organizations."
  source: "`vibe_ngo_v1`.`compliance`.`donor_requirement`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the donor requirement (e.g., compliant, non-compliant, at risk, waived) — primary filter for donor compliance risk monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the donor requirement — used to focus compliance resources on highest-risk obligations."
    - name: "non_compliance_risk_level"
      expr: non_compliance_risk_level
      comment: "Assessed risk level of non-compliance (e.g., high, medium, low) — informs escalation and resource allocation decisions."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for fulfilling the requirement — supports departmental accountability reporting."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Boolean flag indicating a waiver was granted for this requirement — tracks the use of waivers as a compliance management tool."
    - name: "submission_method"
      expr: submission_method
      comment: "Method for submitting the required deliverable (e.g., portal, email, in-person) — informs process automation opportunities."
    - name: "due_year"
      expr: DATE_TRUNC('YEAR', due_date)
      comment: "Year the requirement is due — enables annual compliance workload planning."
  measures:
    - name: "total_associated_cost_usd"
      expr: SUM(CAST(associated_cost_amount AS DOUBLE))
      comment: "Total cost associated with fulfilling donor requirements. Measures the financial burden of donor compliance obligations — informs cost-of-compliance analysis and award budget adequacy assessment."
    - name: "avg_associated_cost_per_requirement_usd"
      expr: AVG(CAST(associated_cost_amount AS DOUBLE))
      comment: "Average cost per donor requirement. Benchmarks compliance cost efficiency and informs future award budget development for compliance activities."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual staff hours expended on donor requirement fulfillment. Measures the true labor cost of donor compliance — a key input to indirect cost rate calculations and compliance staffing decisions."
    - name: "effort_variance_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE) - CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total variance between actual and estimated effort hours for donor requirements. Positive values indicate underestimation of compliance burden — informs future award budget development."
    - name: "total_non_compliant_requirements"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Count of donor requirements currently in non-compliant status. Non-compliance with donor requirements is the primary trigger for grant suspension, clawback, and debarment — a critical board-level risk indicator."
    - name: "total_overdue_requirements"
      expr: COUNT(CASE WHEN compliance_status != 'compliant' AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of donor requirements past their due date without compliant status. Directly measures active donor relationship risk — overdue requirements require immediate escalation to award management."
    - name: "total_waivers_granted"
      expr: COUNT(CASE WHEN waiver_granted_flag = TRUE THEN 1 END)
      comment: "Count of donor requirements for which a waiver was granted. Tracks the use of waivers as a compliance management tool — high waiver counts may indicate systemic capacity issues or overly burdensome donor conditions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_internal_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Internal review and audit metrics tracking control effectiveness, finding severity distribution, risk scores, and management response timeliness"
  source: "`vibe_ngo_v1`.`compliance`.`internal_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of internal review (e.g., compliance, financial, operational, IT security)"
    - name: "review_status"
      expr: review_status
      comment: "Current status of the internal review (e.g., planning, fieldwork, reporting, completed)"
    - name: "overall_compliance_rating"
      expr: overall_compliance_rating
      comment: "Overall compliance rating assigned by the review (e.g., satisfactory, needs improvement, unsatisfactory)"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Flag indicating whether corrective action is required based on review findings"
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Flag indicating whether donor notification is required based on review findings"
    - name: "follow_up_review_required_flag"
      expr: follow_up_review_required_flag
      comment: "Flag indicating whether a follow-up review is required"
    - name: "external_auditor_coordination_flag"
      expr: external_auditor_coordination_flag
      comment: "Flag indicating whether coordination with external auditors is required"
    - name: "review_methodology"
      expr: review_methodology
      comment: "Methodology used for the internal review (e.g., risk-based, comprehensive, targeted)"
    - name: "compliance_framework_reference"
      expr: compliance_framework_reference
      comment: "Compliance framework or standard referenced in the review"
    - name: "review_year"
      expr: YEAR(review_start_date)
      comment: "Year the internal review started"
    - name: "review_quarter"
      expr: CONCAT('Q', QUARTER(review_start_date))
      comment: "Quarter the internal review started"
  measures:
    - name: "total_reviews_count"
      expr: COUNT(1)
      comment: "Total number of internal reviews conducted"
    - name: "completed_reviews_count"
      expr: COUNT(CASE WHEN review_status = 'Completed' THEN 1 END)
      comment: "Count of internal reviews that have been completed"
    - name: "in_progress_reviews_count"
      expr: COUNT(CASE WHEN review_status IN ('Planning', 'Fieldwork', 'Reporting') THEN 1 END)
      comment: "Count of internal reviews currently in progress"
    - name: "total_findings_count"
      expr: SUM(CAST(total_findings_count AS BIGINT))
      comment: "Total number of findings identified across all internal reviews"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS BIGINT))
      comment: "Total number of critical findings across all reviews"
    - name: "total_high_findings"
      expr: SUM(CAST(high_findings_count AS BIGINT))
      comment: "Total number of high-severity findings across all reviews"
    - name: "total_medium_findings"
      expr: SUM(CAST(medium_findings_count AS BIGINT))
      comment: "Total number of medium-severity findings across all reviews"
    - name: "total_low_findings"
      expr: SUM(CAST(low_findings_count AS BIGINT))
      comment: "Total number of low-severity findings across all reviews"
    - name: "avg_findings_per_review"
      expr: AVG(CAST(total_findings_count AS BIGINT))
      comment: "Average number of findings per internal review"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all internal reviews"
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Count of reviews requiring corrective action"
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of reviews requiring donor notification"
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_review_required_flag = TRUE THEN 1 END)
      comment: "Count of reviews requiring follow-up review"
    - name: "satisfactory_rating_count"
      expr: COUNT(CASE WHEN overall_compliance_rating = 'Satisfactory' THEN 1 END)
      comment: "Count of reviews receiving a satisfactory overall compliance rating"
    - name: "avg_review_duration_days"
      expr: AVG(DATEDIFF(review_end_date, review_start_date))
      comment: "Average duration of internal reviews in days from start to end"
    - name: "avg_days_to_management_response"
      expr: AVG(DATEDIFF(management_response_received_date, report_issued_date))
      comment: "Average number of days from report issuance to management response receipt"
$$;