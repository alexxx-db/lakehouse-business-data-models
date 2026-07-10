-- Metric views for domain: compliance | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks audit findings across awards and interventions, measuring financial exposure from questioned costs, severity distribution, repeat findings, and resolution timeliness. Core KPI surface for compliance officers and executive leadership to assess audit risk posture."
  source: "`vibe_ngo_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the audit finding (e.g., critical, high, medium, low) — used to prioritize remediation effort."
    - name: "audit_finding_type"
      expr: audit_finding_type
      comment: "Category of audit finding (e.g., internal control, compliance, financial) — enables trend analysis by finding type."
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current lifecycle status of the finding (e.g., open, in-remediation, closed) — drives workload and backlog reporting."
    - name: "compliance_requirement_type"
      expr: compliance_requirement_type
      comment: "The regulatory or donor compliance requirement category the finding relates to — supports compliance framework gap analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk domain classification of the finding — used to aggregate exposure by risk type."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Organizational department accountable for resolving the finding — enables departmental compliance scorecards."
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Flag indicating whether this finding recurred from a prior audit cycle — repeat findings signal systemic control failures."
    - name: "is_material_weakness"
      expr: is_material_weakness
      comment: "Flag indicating the finding constitutes a material weakness — material weaknesses require board-level disclosure."
    - name: "is_fraud_indicator"
      expr: is_fraud_indicator
      comment: "Flag indicating the finding has fraud indicators — fraud-flagged findings require escalation and legal review."
    - name: "identified_year"
      expr: DATE_TRUNC('YEAR', identified_date)
      comment: "Year the finding was identified — supports year-over-year trend analysis of audit findings."
    - name: "audit_period_year"
      expr: DATE_TRUNC('YEAR', audit_period_start_date)
      comment: "Fiscal year of the audit period — enables cohort analysis of findings by audit cycle."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings — baseline volume metric for audit workload and risk exposure tracking."
    - name: "total_questioned_cost_amount"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total dollar value of costs questioned by auditors — directly measures financial risk and potential clawback exposure from donors."
    - name: "avg_questioned_cost_per_finding"
      expr: AVG(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Average questioned cost per audit finding — indicates the average financial severity of findings and helps benchmark against prior periods."
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END)
      comment: "Number of findings that are repeats from prior audits — repeat findings indicate persistent control failures requiring systemic intervention."
    - name: "material_weakness_count"
      expr: COUNT(CASE WHEN is_material_weakness = TRUE THEN 1 END)
      comment: "Number of findings classified as material weaknesses — material weaknesses trigger mandatory board disclosure and remediation plans."
    - name: "fraud_indicator_finding_count"
      expr: COUNT(CASE WHEN is_fraud_indicator = TRUE THEN 1 END)
      comment: "Number of findings with fraud indicators — fraud-flagged findings require immediate escalation and legal review."
    - name: "open_finding_count"
      expr: COUNT(CASE WHEN audit_finding_status = 'open' THEN 1 END)
      comment: "Number of currently open audit findings — open findings represent unresolved compliance risk and remediation backlog."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(actual_resolution_date, identified_date))
      comment: "Average number of days from finding identification to actual resolution — measures remediation velocity and compliance responsiveness."
    - name: "overdue_finding_count"
      expr: COUNT(CASE WHEN audit_finding_status != 'closed' AND expected_resolution_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of findings past their expected resolution date without closure — overdue findings signal remediation delays and escalation risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors corrective action plans (CAPs) raised against audit findings, compliance incidents, and safeguarding events. Tracks cost, timeliness, and escalation rates to give leadership visibility into remediation effectiveness and organizational accountability."
  source: "`vibe_ngo_v1`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "cap_status"
      expr: cap_status
      comment: "Current lifecycle status of the corrective action plan (e.g., draft, in-progress, completed, overdue) — drives remediation backlog reporting."
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity of the underlying finding that triggered the CAP — enables prioritization of high-severity remediation efforts."
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding (e.g., financial, operational, compliance) — supports root cause trend analysis across finding categories."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for executing the corrective action — enables departmental compliance performance scorecards."
    - name: "recurrence_risk"
      expr: recurrence_risk
      comment: "Assessed risk that the underlying issue will recur — high recurrence risk CAPs require additional monitoring and systemic fixes."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Flag indicating whether the CAP required escalation — escalated CAPs signal governance failures needing executive attention."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Flag indicating whether the donor must be notified of the corrective action — donor notifications carry reputational and contractual implications."
    - name: "target_completion_year"
      expr: DATE_TRUNC('YEAR', target_completion_date)
      comment: "Year the CAP is targeted for completion — supports annual compliance planning and resource allocation."
  measures:
    - name: "total_caps"
      expr: COUNT(1)
      comment: "Total number of corrective action plans — baseline volume metric for compliance remediation workload."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to execute corrective action plans — measures the financial burden of compliance remediation."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective action plans — used for compliance remediation budget planning and variance analysis."
    - name: "avg_actual_cost_per_cap"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action plan — benchmarks remediation cost efficiency across departments and finding types."
    - name: "cost_overrun_amount"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total cost overrun across all CAPs (actual minus estimated) — identifies systemic underestimation of remediation effort and budget risk."
    - name: "escalated_cap_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Number of CAPs that required escalation — escalated CAPs indicate governance failures and require executive intervention."
    - name: "donor_notification_cap_count"
      expr: COUNT(CASE WHEN donor_notification_required = TRUE THEN 1 END)
      comment: "Number of CAPs requiring donor notification — donor-notified CAPs carry reputational and contractual risk for the organization."
    - name: "avg_days_to_completion"
      expr: AVG(DATEDIFF(actual_completion_date, created_timestamp))
      comment: "Average days from CAP creation to actual completion — measures remediation velocity and organizational responsiveness to compliance failures."
    - name: "overdue_cap_count"
      expr: COUNT(CASE WHEN cap_status != 'completed' AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of CAPs past their target completion date — overdue CAPs represent unresolved compliance risk and potential donor/regulatory exposure."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks compliance incidents across the organization, measuring financial impact, investigation timeliness, regulatory reporting obligations, and resolution rates. This is the primary SSOT for compliance incidents per VREQ-003 domain designation. Provides executive leadership with a real-time risk posture view."
  source: "`vibe_ngo_v1`.`compliance`.`compliance_incident`"
  dimensions:
    - name: "compliance_incident_type"
      expr: compliance_incident_type
      comment: "Category of compliance incident (e.g., financial misconduct, data breach, donor violation) — enables trend analysis by incident type."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident — drives prioritization of investigation resources and escalation decisions."
    - name: "compliance_incident_status"
      expr: compliance_incident_status
      comment: "Current lifecycle status of the incident (e.g., reported, under investigation, resolved) — tracks remediation pipeline."
    - name: "reporting_channel"
      expr: reporting_channel
      comment: "Channel through which the incident was reported (e.g., hotline, manager, audit) — informs effectiveness of reporting mechanisms."
    - name: "triage_outcome"
      expr: triage_outcome
      comment: "Outcome of initial triage (e.g., substantiated, unsubstantiated, referred) — measures quality of incident intake process."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Flag indicating whether the incident requires regulatory reporting — regulatory incidents carry legal and reputational consequences."
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Flag indicating whether the donor must be notified — donor-notified incidents affect grant relationships and future funding."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Flag indicating whether the incident requires public disclosure — public disclosures carry significant reputational risk."
    - name: "incident_year"
      expr: DATE_TRUNC('YEAR', compliance_incident_date)
      comment: "Year the compliance incident occurred — supports year-over-year trend analysis of incident frequency and severity."
    - name: "allegation_category"
      expr: allegation_category
      comment: "Category of the allegation underlying the incident — enables analysis of which allegation types are most prevalent."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of compliance incidents — baseline volume metric for organizational compliance risk exposure."
    - name: "total_estimated_financial_impact_usd"
      expr: SUM(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Total estimated financial impact of compliance incidents in USD — directly measures the financial risk exposure from compliance failures."
    - name: "avg_financial_impact_per_incident"
      expr: AVG(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Average estimated financial impact per compliance incident — benchmarks incident severity and informs risk provisioning."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of incidents requiring regulatory reporting — regulatory incidents carry legal obligations and potential penalties for non-compliance."
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of incidents requiring donor notification — donor-notified incidents risk grant suspension or clawback."
    - name: "avg_days_to_investigation_completion"
      expr: AVG(DATEDIFF(investigation_completion_date, investigation_start_date))
      comment: "Average days from investigation start to completion — measures investigation efficiency and compliance with internal SLAs."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, reported_date))
      comment: "Average days from incident report to resolution — measures end-to-end compliance incident response speed."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN compliance_incident_status NOT IN ('resolved', 'closed') THEN 1 END)
      comment: "Number of currently open compliance incidents — open incidents represent active organizational risk requiring management attention."
    - name: "public_disclosure_incident_count"
      expr: COUNT(CASE WHEN public_disclosure_flag = TRUE THEN 1 END)
      comment: "Number of incidents requiring public disclosure — public disclosures carry significant reputational and stakeholder trust implications."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_donor_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks donor-imposed compliance requirements across awards, measuring fulfillment rates, effort, cost, and risk of non-compliance. Enables grant managers and compliance officers to proactively manage donor obligations and avoid grant clawbacks or relationship damage."
  source: "`vibe_ngo_v1`.`compliance`.`donor_requirement`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the donor requirement (e.g., compliant, non-compliant, pending) — primary indicator of donor obligation health."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the requirement — high-priority requirements carry greater risk of grant impact if unfulfilled."
    - name: "non_compliance_risk_level"
      expr: non_compliance_risk_level
      comment: "Assessed risk level of non-compliance — high-risk requirements require proactive monitoring and escalation."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for fulfilling the requirement — enables departmental compliance performance tracking."
    - name: "submission_method"
      expr: submission_method
      comment: "Method by which the requirement is submitted to the donor — informs process efficiency and automation opportunities."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Flag indicating whether a waiver was granted for this requirement — waiver rates indicate negotiation effectiveness with donors."
    - name: "due_year"
      expr: DATE_TRUNC('YEAR', due_date)
      comment: "Year the requirement is due — supports annual compliance planning and resource allocation."
    - name: "deliverable_format"
      expr: deliverable_format
      comment: "Format of the required deliverable (e.g., report, audit, certification) — enables workload planning by deliverable type."
  measures:
    - name: "total_requirements"
      expr: COUNT(1)
      comment: "Total number of donor requirements — baseline volume metric for compliance obligation workload."
    - name: "total_associated_cost"
      expr: SUM(CAST(associated_cost_amount AS DOUBLE))
      comment: "Total cost associated with fulfilling donor requirements — measures the financial burden of donor compliance obligations."
    - name: "avg_associated_cost_per_requirement"
      expr: AVG(CAST(associated_cost_amount AS DOUBLE))
      comment: "Average cost per donor requirement — benchmarks compliance cost efficiency and informs grant budget planning."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual staff hours spent fulfilling donor requirements — measures true compliance labor cost and capacity consumption."
    - name: "effort_variance_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE) - CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total variance between actual and estimated effort hours — identifies systemic underestimation of compliance workload."
    - name: "non_compliant_requirement_count"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Number of requirements currently in non-compliant status — non-compliant requirements risk grant penalties, clawbacks, or relationship damage."
    - name: "waiver_granted_count"
      expr: COUNT(CASE WHEN waiver_granted_flag = TRUE THEN 1 END)
      comment: "Number of requirements for which a waiver was granted — waiver rates indicate donor flexibility and negotiation outcomes."
    - name: "overdue_requirement_count"
      expr: COUNT(CASE WHEN compliance_status != 'compliant' AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of requirements past their due date without compliance — overdue requirements represent immediate donor relationship and contractual risk."
    - name: "avg_days_to_submission"
      expr: AVG(DATEDIFF(submission_date, effective_start_date))
      comment: "Average days from requirement effective start to submission — measures compliance process speed and early warning of bottlenecks."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_obligation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks scheduled compliance obligation instances, measuring on-time completion rates, escalation frequency, penalty exposure, and effort efficiency. Provides operations and compliance leadership with a forward-looking view of obligation fulfillment health."
  source: "`vibe_ngo_v1`.`compliance`.`obligation_schedule`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the scheduled obligation instance (e.g., completed, pending, overdue) — primary indicator of obligation fulfillment health."
    - name: "workflow_stage"
      expr: workflow_stage
      comment: "Current workflow stage of the obligation schedule — enables pipeline analysis of obligations in progress."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the obligation schedule — high-priority obligations require proactive monitoring."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the obligation — enables compliance posture analysis by regulatory regime."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the obligation — supports geographic compliance risk analysis."
    - name: "escalation_triggered_flag"
      expr: escalation_triggered_flag
      comment: "Flag indicating whether escalation was triggered for this obligation — escalation rates indicate systemic compliance process failures."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Flag indicating whether a deadline extension was granted — extension rates indicate capacity constraints or complexity in fulfillment."
    - name: "non_compliance_risk"
      expr: non_compliance_risk
      comment: "Assessed risk level of non-compliance for this obligation — high-risk obligations require proactive intervention."
    - name: "planned_due_year"
      expr: DATE_TRUNC('YEAR', planned_due_date)
      comment: "Year the obligation is planned to be due — supports annual compliance calendar planning."
  measures:
    - name: "total_scheduled_obligations"
      expr: COUNT(1)
      comment: "Total number of scheduled obligation instances — baseline volume metric for compliance calendar workload."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts incurred from obligation non-compliance — directly measures the financial cost of compliance failures."
    - name: "avg_penalty_per_obligation"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per obligation schedule instance — benchmarks penalty severity and informs risk provisioning."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual staff hours spent fulfilling scheduled obligations — measures true compliance labor cost and capacity consumption."
    - name: "effort_variance_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE) - CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total variance between actual and estimated effort hours for obligations — identifies systemic underestimation of compliance workload."
    - name: "escalated_obligation_count"
      expr: COUNT(CASE WHEN escalation_triggered_flag = TRUE THEN 1 END)
      comment: "Number of obligation schedules that triggered escalation — escalated obligations indicate process failures requiring systemic remediation."
    - name: "extension_granted_count"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN 1 END)
      comment: "Number of obligation schedules granted deadline extensions — high extension rates signal capacity constraints or process inefficiencies."
    - name: "overdue_obligation_count"
      expr: COUNT(CASE WHEN completion_status != 'completed' AND effective_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of obligation schedules past their effective due date without completion — overdue obligations represent active regulatory and donor risk."
    - name: "avg_days_overdue"
      expr: AVG(CASE WHEN completion_status != 'completed' AND effective_due_date < CURRENT_DATE() THEN DATEDIFF(CURRENT_DATE(), effective_due_date) END)
      comment: "Average number of days overdue for incomplete past-due obligations — measures severity of compliance backlog and urgency of intervention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_single_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks OMB Uniform Guidance single audits for federal award recipients, measuring questioned costs, finding rates, audit opinion quality, and low-risk auditee status. Critical for CFOs and compliance officers managing federal funding compliance and FAC submission obligations."
  source: "`vibe_ngo_v1`.`compliance`.`single_audit`"
  dimensions:
    - name: "single_audit_status"
      expr: single_audit_status
      comment: "Current status of the single audit (e.g., in-progress, submitted, accepted, rejected) — tracks audit lifecycle and FAC submission pipeline."
    - name: "compliance_opinion_type"
      expr: compliance_opinion_type
      comment: "Auditor's compliance opinion type (e.g., unmodified, qualified, adverse) — adverse opinions trigger donor and regulatory escalation."
    - name: "financial_statement_opinion_type"
      expr: financial_statement_opinion_type
      comment: "Auditor's financial statement opinion type — qualified or adverse opinions signal material financial reporting concerns."
    - name: "internal_control_opinion_type"
      expr: internal_control_opinion_type
      comment: "Auditor's internal control opinion type — material weaknesses in internal controls require board-level disclosure and remediation."
    - name: "low_risk_auditee_flag"
      expr: low_risk_auditee_flag
      comment: "Flag indicating whether the organization qualifies as a low-risk auditee — low-risk status reduces audit scope and cost."
    - name: "material_weakness_identified_flag"
      expr: material_weakness_identified_flag
      comment: "Flag indicating a material weakness was identified — material weaknesses require immediate remediation and donor notification."
    - name: "significant_deficiency_identified_flag"
      expr: significant_deficiency_identified_flag
      comment: "Flag indicating a significant deficiency was identified — significant deficiencies require corrective action plans."
    - name: "going_concern_issue_flag"
      expr: going_concern_issue_flag
      comment: "Flag indicating a going concern issue was raised — going concern findings have severe implications for donor confidence and future funding."
    - name: "audit_year"
      expr: DATE_TRUNC('YEAR', period_start_date)
      comment: "Fiscal year of the audit period — supports year-over-year trend analysis of audit quality and findings."
  measures:
    - name: "total_single_audits"
      expr: COUNT(1)
      comment: "Total number of single audits — baseline volume metric for federal compliance audit activity."
    - name: "total_federal_expenditure_amount"
      expr: SUM(CAST(federal_expenditure_amount AS DOUBLE))
      comment: "Total federal expenditure subject to single audit — measures the scale of federal funding under audit scrutiny."
    - name: "total_questioned_cost_amount"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total questioned costs identified across single audits — directly measures financial risk of federal fund misuse and potential clawback."
    - name: "avg_questioned_cost_per_audit"
      expr: AVG(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Average questioned cost per single audit — benchmarks audit quality and financial compliance across audit cycles."
    - name: "total_audit_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost incurred for single audits — measures the financial burden of federal compliance audit requirements."
    - name: "material_weakness_audit_count"
      expr: COUNT(CASE WHEN material_weakness_identified_flag = TRUE THEN 1 END)
      comment: "Number of audits where a material weakness was identified — material weaknesses require board disclosure and remediation plans."
    - name: "going_concern_audit_count"
      expr: COUNT(CASE WHEN going_concern_issue_flag = TRUE THEN 1 END)
      comment: "Number of audits with going concern issues — going concern findings severely impact donor confidence and future federal funding eligibility."
    - name: "avg_days_fieldwork_duration"
      expr: AVG(DATEDIFF(fieldwork_end_date, fieldwork_start_date))
      comment: "Average duration of audit fieldwork in days — measures audit efficiency and resource planning for future audit cycles."
    - name: "corrective_action_plan_submitted_count"
      expr: COUNT(CASE WHEN corrective_action_plan_submitted_flag = TRUE THEN 1 END)
      comment: "Number of audits for which a corrective action plan was submitted — CAP submission rates indicate organizational responsiveness to audit findings."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_sanctions_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks sanctions screening activity for counterparties, measuring match rates, false positive rates, risk ratings, and rescreening compliance. Critical for compliance officers and legal teams to demonstrate due diligence and manage regulatory exposure from prohibited party transactions."
  source: "`vibe_ngo_v1`.`compliance`.`sanctions_screening`"
  dimensions:
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Current status of the screening (e.g., pending, cleared, flagged, escalated) — tracks screening pipeline and unresolved risk."
    - name: "match_result"
      expr: match_result
      comment: "Result of the sanctions list match (e.g., no match, potential match, confirmed match) — primary indicator of sanctions risk."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the screened subject — high-risk subjects require enhanced due diligence and escalation."
    - name: "subject_type"
      expr: subject_type
      comment: "Type of entity screened (e.g., individual, organization, vendor) — enables analysis of screening coverage by counterparty type."
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Flag indicating the match was a false positive — high false positive rates indicate screening tool calibration issues."
    - name: "rescreening_required_flag"
      expr: rescreening_required_flag
      comment: "Flag indicating periodic rescreening is required — rescreening obligations must be tracked to maintain ongoing compliance."
    - name: "method"
      expr: method
      comment: "Screening method used (e.g., automated, manual, third-party) — informs process efficiency and coverage analysis."
    - name: "screening_year"
      expr: DATE_TRUNC('YEAR', sanctions_screening_date)
      comment: "Year the screening was conducted — supports year-over-year trend analysis of screening volume and match rates."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of sanctions screenings conducted — baseline volume metric for due diligence coverage."
    - name: "confirmed_match_count"
      expr: COUNT(CASE WHEN match_result = 'confirmed match' THEN 1 END)
      comment: "Number of screenings resulting in confirmed sanctions matches — confirmed matches require immediate transaction blocking and regulatory reporting."
    - name: "potential_match_count"
      expr: COUNT(CASE WHEN match_result = 'potential match' THEN 1 END)
      comment: "Number of screenings with potential matches requiring review — potential matches represent active compliance risk pending resolution."
    - name: "false_positive_count"
      expr: COUNT(CASE WHEN false_positive_flag = TRUE THEN 1 END)
      comment: "Number of false positive matches — high false positive rates indicate screening tool over-sensitivity requiring calibration."
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across all screenings — tracks screening sensitivity and helps calibrate match thresholds to reduce false positives."
    - name: "rescreening_required_count"
      expr: COUNT(CASE WHEN rescreening_required_flag = TRUE THEN 1 END)
      comment: "Number of subjects requiring periodic rescreening — rescreening obligations must be fulfilled to maintain ongoing sanctions compliance."
    - name: "overdue_rescreening_count"
      expr: COUNT(CASE WHEN rescreening_required_flag = TRUE AND next_screening_due_date < CURRENT_DATE() AND sanctions_screening_status != 'completed' THEN 1 END)
      comment: "Number of subjects with overdue rescreening obligations — overdue rescreenings represent active regulatory compliance gaps."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, sanctions_screening_date))
      comment: "Average days from screening to resolution — measures sanctions review process efficiency and compliance with internal SLAs."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_chs_self_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks Core Humanitarian Standard (CHS) self-assessments, measuring conformity scores across the nine CHS commitments. Enables leadership to benchmark humanitarian accountability performance, identify commitment gaps, and track improvement over assessment cycles."
  source: "`vibe_ngo_v1`.`compliance`.`chs_self_assessment`"
  dimensions:
    - name: "chs_self_assessment_status"
      expr: chs_self_assessment_status
      comment: "Current status of the CHS self-assessment (e.g., in-progress, submitted, verified) — tracks assessment lifecycle."
    - name: "overall_conformity_rating"
      expr: overall_conformity_rating
      comment: "Overall CHS conformity rating (e.g., strong, adequate, weak) — primary indicator of humanitarian accountability performance."
    - name: "certification_target_flag"
      expr: certification_target_flag
      comment: "Flag indicating whether this assessment is targeting CHS certification — certification-track assessments require higher rigor and external verification."
    - name: "methodology"
      expr: methodology
      comment: "Assessment methodology used (e.g., self-assessment, peer review, external verification) — informs reliability and comparability of scores."
    - name: "assessment_year"
      expr: DATE_TRUNC('YEAR', period_start_date)
      comment: "Year of the assessment period — supports year-over-year trend analysis of CHS conformity improvement."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of CHS self-assessments conducted — baseline volume metric for humanitarian accountability coverage."
    - name: "avg_overall_conformity_score"
      expr: AVG(CAST(overall_conformity_score AS DOUBLE))
      comment: "Average overall CHS conformity score across assessments — primary KPI for organizational humanitarian accountability performance."
    - name: "avg_commitment_1_rating"
      expr: AVG(CAST(commitment_1_rating AS DOUBLE))
      comment: "Average rating for CHS Commitment 1 (humanitarian response meets needs) — identifies specific commitment gaps requiring targeted improvement."
    - name: "avg_commitment_2_rating"
      expr: AVG(CAST(commitment_2_rating AS DOUBLE))
      comment: "Average rating for CHS Commitment 2 (relevant and appropriate response) — tracks performance on relevance and appropriateness standards."
    - name: "avg_commitment_5_rating"
      expr: AVG(CAST(commitment_5_rating AS DOUBLE))
      comment: "Average rating for CHS Commitment 5 (complaints are welcomed and addressed) — accountability to affected populations is a core donor and sector requirement."
    - name: "avg_commitment_6_rating"
      expr: AVG(CAST(commitment_6_rating AS DOUBLE))
      comment: "Average rating for CHS Commitment 6 (coordinated and complementary response) — coordination performance affects sector standing and donor confidence."
    - name: "certification_track_assessment_count"
      expr: COUNT(CASE WHEN certification_target_flag = TRUE THEN 1 END)
      comment: "Number of assessments targeting CHS certification — certification pursuit signals organizational commitment to humanitarian accountability standards."
    - name: "avg_days_between_assessments"
      expr: AVG(DATEDIFF(next_assessment_due_date, submission_date))
      comment: "Average days between assessment submission and next due date — measures assessment cycle frequency and compliance with CHS review cadence."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory filings across jurisdictions, measuring on-time submission rates, rejection rates, fee expenditure, and amendment frequency. Provides compliance and legal teams with visibility into regulatory filing health and risk of non-compliance penalties."
  source: "`vibe_ngo_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "regulatory_filing_status"
      expr: regulatory_filing_status
      comment: "Current status of the regulatory filing (e.g., draft, submitted, accepted, rejected) — primary indicator of filing compliance."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel used to submit the filing (e.g., online portal, mail, in-person) — informs process efficiency and automation opportunities."
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Flag indicating this is an amended filing — high amendment rates signal data quality issues in original submissions."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Flag indicating the filing is subject to public disclosure — public filings carry reputational implications and require accuracy."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Flag indicating a filing deadline extension was granted — extension rates indicate capacity constraints or complexity."
    - name: "filing_year"
      expr: DATE_TRUNC('YEAR', submission_date)
      comment: "Year of filing submission — supports year-over-year trend analysis of filing volume and compliance rates."
    - name: "period_year"
      expr: DATE_TRUNC('YEAR', period_start_date)
      comment: "Reporting period year of the filing — enables analysis of filing compliance by reporting period."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings — baseline volume metric for regulatory compliance activity."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees paid for regulatory filings — measures the financial cost of regulatory compliance obligations."
    - name: "avg_fee_per_filing"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee per regulatory filing — benchmarks compliance cost efficiency and informs budget planning."
    - name: "rejected_filing_count"
      expr: COUNT(CASE WHEN regulatory_filing_status = 'rejected' THEN 1 END)
      comment: "Number of rejected regulatory filings — rejections indicate data quality or process failures and risk compliance penalties."
    - name: "amendment_filing_count"
      expr: COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END)
      comment: "Number of amended filings — high amendment rates signal systemic data quality issues in original submissions."
    - name: "avg_days_to_submission"
      expr: AVG(DATEDIFF(submission_date, period_end_date))
      comment: "Average days from period end to filing submission — measures filing timeliness and early warning of deadline risk."
    - name: "overdue_filing_count"
      expr: COUNT(CASE WHEN regulatory_filing_status NOT IN ('accepted', 'submitted') AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of filings past their due date without submission or acceptance — overdue filings represent active regulatory penalty risk."
    - name: "extension_granted_count"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN 1 END)
      comment: "Number of filings granted deadline extensions — extension rates indicate capacity constraints and inform future deadline planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_internal_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks internal compliance reviews across country offices, awards, and interventions, measuring finding severity distribution, corrective action rates, and review cycle timeliness. Provides compliance leadership with a systematic view of internal control quality across the organization."
  source: "`vibe_ngo_v1`.`compliance`.`internal_review`"
  dimensions:
    - name: "internal_review_type"
      expr: internal_review_type
      comment: "Type of internal review (e.g., financial, operational, programmatic) — enables analysis of compliance posture by review category."
    - name: "internal_review_status"
      expr: internal_review_status
      comment: "Current status of the internal review (e.g., planned, in-progress, completed) — tracks review pipeline and backlog."
    - name: "overall_compliance_rating"
      expr: overall_compliance_rating
      comment: "Overall compliance rating assigned by the review (e.g., satisfactory, needs improvement, unsatisfactory) — primary indicator of compliance health."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Flag indicating whether corrective action is required — CAP-triggering reviews require follow-up tracking."
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Flag indicating whether the donor must be notified of review findings — donor-notified reviews carry grant relationship implications."
    - name: "follow_up_review_required_flag"
      expr: follow_up_review_required_flag
      comment: "Flag indicating a follow-up review is required — follow-up reviews indicate unresolved compliance issues."
    - name: "methodology"
      expr: methodology
      comment: "Review methodology used (e.g., desk review, field visit, sampling) — informs review rigor and comparability."
    - name: "review_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the internal review commenced — supports year-over-year trend analysis of review activity and findings."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of internal reviews conducted — baseline volume metric for compliance oversight activity."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across internal reviews — measures overall organizational compliance risk level and tracks improvement over time."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of reviews requiring corrective action — CAP-triggering reviews represent active compliance deficiencies requiring remediation."
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of reviews requiring donor notification — donor-notified reviews carry grant relationship and funding risk."
    - name: "follow_up_review_required_count"
      expr: COUNT(CASE WHEN follow_up_review_required_flag = TRUE THEN 1 END)
      comment: "Number of reviews requiring follow-up — high follow-up rates indicate persistent compliance issues not resolved in initial reviews."
    - name: "avg_days_review_duration"
      expr: AVG(DATEDIFF(end_date, start_date))
      comment: "Average duration of internal reviews in days — measures review efficiency and resource planning for future review cycles."
    - name: "avg_days_to_report_issuance"
      expr: AVG(DATEDIFF(report_issued_date, end_date))
      comment: "Average days from review completion to report issuance — measures reporting timeliness and compliance with internal SLAs."
    - name: "avg_total_findings_count"
      expr: AVG(CAST(total_findings_count AS DOUBLE))
      comment: "Average number of findings per internal review — benchmarks review thoroughness and organizational compliance health over time."
$$;