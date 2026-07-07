-- Metric views for domain: safeguarding | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI view over safeguarding incidents. Tracks incident volume, severity distribution, donor notification compliance, and closure rates. Primary steering dashboard for the Chief of Safeguarding and Country Directors. Incident data is highly sensitive (pii_beneficiary_protected); apply dynamic masking on location_description and incident_description in non-prod environments per VREQ-022."
  source: "`vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`"
  dimensions:
    - name: "incident_category"
      expr: incident_category
      comment: "Category of safeguarding incident (SEA, child protection, harassment, etc.) — primary grouping for trend analysis."
    - name: "incident_type"
      expr: incident_type
      comment: "Specific incident type within category, enabling granular breakdown for case management review."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification (critical, high, medium, low) — used to prioritise response resources."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident (open, under investigation, closed, etc.)."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification governing data access and sharing — critical for audit and donor reporting."
    - name: "involves_minor_flag"
      expr: involves_minor_flag
      comment: "Boolean flag indicating whether the incident involves a minor — triggers mandatory escalation protocols."
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Boolean flag indicating whether donor notification is contractually required for this incident."
    - name: "referred_to_authorities_flag"
      expr: referred_to_authorities_flag
      comment: "Boolean flag indicating whether the incident was referred to law enforcement or statutory authorities."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident occurrence — used for trend analysis and periodic reporting."
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year of incident occurrence — used for annual reporting and year-over-year comparison."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month the incident was reported — used to measure reporting timeliness."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safeguarding incidents recorded. Core volume KPI for executive dashboards and donor reporting."
    - name: "open_incidents"
      expr: COUNT(CASE WHEN incident_status NOT IN ('closed', 'Closed') THEN 1 END)
      comment: "Number of incidents currently open or under investigation. Drives resource allocation and case management prioritisation."
    - name: "critical_incidents"
      expr: COUNT(CASE WHEN severity_level IN ('critical', 'Critical') THEN 1 END)
      comment: "Count of critical-severity incidents. Triggers immediate escalation to senior leadership and donor notification review."
    - name: "incidents_involving_minors"
      expr: COUNT(CASE WHEN involves_minor_flag = TRUE THEN 1 END)
      comment: "Count of incidents involving minors. Mandatory child safeguarding KPI for CHS compliance and donor reporting."
    - name: "donor_notification_pending"
      expr: COUNT(CASE WHEN donor_notification_required_flag = TRUE AND donor_notification_date IS NULL THEN 1 END)
      comment: "Incidents requiring donor notification where notification has not yet been sent. Compliance risk indicator for grant management."
    - name: "referred_to_authorities_count"
      expr: COUNT(CASE WHEN referred_to_authorities_flag = TRUE THEN 1 END)
      comment: "Number of incidents referred to law enforcement or statutory authorities. Indicates severity and legal compliance posture."
    - name: "closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_status IN ('closed', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that have been closed. Key throughput metric for case management effectiveness."
    - name: "avg_days_to_report"
      expr: AVG(DATEDIFF(reported_date, incident_date))
      comment: "Average number of days between incident occurrence and formal reporting. Measures reporting timeliness — a core CHS accountability indicator."
    - name: "avg_days_to_close"
      expr: AVG(DATEDIFF(closure_date, reported_date))
      comment: "Average days from report to closure. Measures case resolution speed — used in operational steering reviews."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over safeguarding investigations. Tracks investigation throughput, timeliness, and outcome quality. Used by the Head of Safeguarding and Legal/Compliance teams to monitor case resolution and accountability. Investigation data is highly sensitive (pii_beneficiary_protected, pii_staff); apply masking on findings_summary and conclusion in non-prod per VREQ-022."
  source: "`vibe_ngo_v1`.`safeguarding`.`investigation`"
  dimensions:
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (open, in progress, concluded, closed) — primary lifecycle dimension."
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation (internal, external, joint) — determines resource requirements and governance."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification governing who can access investigation records."
    - name: "evidence_collected_flag"
      expr: evidence_collected_flag
      comment: "Boolean flag indicating whether evidence was formally collected — quality indicator for investigation rigour."
    - name: "external_referral_flag"
      expr: external_referral_flag
      comment: "Boolean flag indicating whether the investigation was referred to an external body (police, UN oversight, etc.)."
    - name: "initiation_month"
      expr: DATE_TRUNC('MONTH', initiation_date)
      comment: "Month the investigation was initiated — used for trend and workload analysis."
    - name: "initiation_year"
      expr: YEAR(initiation_date)
      comment: "Year the investigation was initiated — used for annual reporting."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of investigations opened. Core volume KPI for accountability reporting."
    - name: "open_investigations"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('closed', 'Closed', 'concluded', 'Concluded') THEN 1 END)
      comment: "Number of investigations currently open. Drives investigator workload management and resource allocation."
    - name: "concluded_investigations"
      expr: COUNT(CASE WHEN investigation_status IN ('concluded', 'Concluded', 'closed', 'Closed') THEN 1 END)
      comment: "Number of investigations that have reached a conclusion. Measures throughput and accountability delivery."
    - name: "external_referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN external_referral_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations referred to external bodies. Indicates severity profile and inter-agency accountability engagement."
    - name: "avg_days_to_complete"
      expr: AVG(DATEDIFF(actual_completion_date, initiation_date))
      comment: "Average days from investigation initiation to actual completion. Core timeliness KPI — CHS and donor requirements typically mandate completion within 30-90 days."
    - name: "overdue_investigations"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('closed', 'Closed', 'concluded', 'Concluded') AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Investigations past their target completion date and still open. Compliance risk indicator requiring immediate management attention."
    - name: "evidence_collection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN evidence_collected_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations where evidence was formally collected. Quality indicator for investigation rigour and legal defensibility."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over safeguarding training completions for staff and volunteers. Tracks training coverage, pass rates, and certification currency. Used by HR, Safeguarding Focal Points, and donors to verify mandatory training compliance. Training records may contain pii_staff data; apply masking on certificate_number in non-prod per VREQ-022."
  source: "`vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion`"
  dimensions:
    - name: "delivery_modality"
      expr: delivery_modality
      comment: "Training delivery method (in-person, e-learning, blended) — used to assess reach and cost-effectiveness."
    - name: "passed_flag"
      expr: passed_flag
      comment: "Boolean flag indicating whether the participant passed the training assessment."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of training completion — used for trend analysis and compliance reporting periods."
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year of training completion — used for annual compliance reporting."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month certification expires — used to forecast renewal workload."
  measures:
    - name: "total_completions"
      expr: COUNT(1)
      comment: "Total number of safeguarding training completions recorded. Core compliance volume KPI for donor and CHS reporting."
    - name: "passed_completions"
      expr: COUNT(CASE WHEN passed_flag = TRUE THEN 1 END)
      comment: "Number of training completions where the participant passed. Measures effective training coverage."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN passed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions resulting in a pass. Quality indicator for training effectiveness and participant preparedness."
    - name: "avg_score_pct"
      expr: AVG(CAST(score_percent AS DOUBLE))
      comment: "Average assessment score across all completions. Measures training comprehension quality — low scores may indicate curriculum gaps."
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND passed_flag = TRUE THEN 1 END)
      comment: "Number of certifications that have passed their expiry date. Compliance risk indicator — expired certifications may breach donor requirements."
    - name: "unique_staff_trained"
      expr: COUNT(DISTINCT staff_member_id)
      comment: "Number of distinct staff members who have completed safeguarding training. Measures organisational training coverage breadth."
    - name: "unique_volunteers_trained"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Number of distinct volunteers who have completed safeguarding training. Measures volunteer safeguarding coverage — critical for community-facing programmes."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_partner_psea_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over partner PSEA assessments. Tracks partner safeguarding capacity scores, assessment coverage, and capacity-building needs. Used by Partnership and Safeguarding teams to manage partner risk and comply with UN PSEA network requirements. Assessment scores are sensitive operational data."
  source: "`vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of PSEA assessment (initial, periodic, follow-up) — determines assessment depth and frequency requirements."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall PSEA capacity rating assigned to the partner (e.g., strong, adequate, needs improvement) — primary risk classification."
    - name: "capacity_building_required_flag"
      expr: capacity_building_required_flag
      comment: "Boolean flag indicating whether the partner requires capacity building following assessment."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment — used for annual partner risk review cycles."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment — used for workload planning and periodic reporting."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of partner PSEA assessments conducted. Measures assessment programme coverage."
    - name: "partners_requiring_capacity_building"
      expr: COUNT(CASE WHEN capacity_building_required_flag = TRUE THEN 1 END)
      comment: "Number of partner assessments where capacity building was identified as required. Drives capacity building programme planning and resource allocation."
    - name: "capacity_building_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN capacity_building_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessed partners requiring capacity building. Key risk indicator for the partner portfolio's overall PSEA readiness."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall PSEA score across all partner assessments. Portfolio-level safeguarding capacity benchmark."
    - name: "avg_policy_score"
      expr: AVG(CAST(policy_score AS DOUBLE))
      comment: "Average policy domain score. Identifies whether partners have adequate PSEA policies in place."
    - name: "avg_training_score"
      expr: AVG(CAST(training_score AS DOUBLE))
      comment: "Average training domain score. Identifies gaps in partner staff safeguarding training coverage."
    - name: "avg_reporting_score"
      expr: AVG(CAST(reporting_score AS DOUBLE))
      comment: "Average reporting domain score. Measures partner capacity to receive and process safeguarding complaints."
    - name: "avg_procedures_score"
      expr: AVG(CAST(procedures_score AS DOUBLE))
      comment: "Average procedures domain score. Measures partner operational safeguarding procedure quality."
    - name: "expired_assessments"
      expr: COUNT(CASE WHEN valid_until_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of partner assessments that have passed their validity date. Compliance risk — expired assessments may breach donor due diligence requirements."
    - name: "unique_partners_assessed"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of distinct partner organisations assessed. Measures PSEA assessment programme reach across the partner portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over safeguarding risk assessments at programme and site level. Tracks risk scores across SEA, child safeguarding, and sexual harassment dimensions. Used by programme managers and safeguarding leads to prioritise mitigation investments. Risk data is operationally sensitive."
  source: "`vibe_ngo_v1`.`safeguarding`.`risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (programme design, site-level, periodic review) — determines scope and methodology."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (draft, finalised, under review) — lifecycle tracking."
    - name: "overall_risk_level"
      expr: overall_risk_level
      comment: "Overall risk classification (critical, high, medium, low) — primary dimension for risk prioritisation."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after mitigation measures — measures effectiveness of safeguarding controls."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment — used for annual risk review and trend analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment — used for periodic reporting and workload planning."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of safeguarding risk assessments conducted. Measures risk management programme coverage."
    - name: "high_critical_risk_sites"
      expr: COUNT(CASE WHEN overall_risk_level IN ('high', 'High', 'critical', 'Critical') THEN 1 END)
      comment: "Number of assessments rated high or critical risk. Drives prioritisation of safeguarding resources and mitigation investment."
    - name: "avg_sea_risk_score"
      expr: AVG(CAST(sea_risk_score AS DOUBLE))
      comment: "Average SEA (Sexual Exploitation and Abuse) risk score across all assessed sites/programmes. Portfolio-level SEA risk benchmark."
    - name: "avg_child_safeguarding_risk_score"
      expr: AVG(CAST(child_safeguarding_risk_score AS DOUBLE))
      comment: "Average child safeguarding risk score. Critical KPI for child protection compliance and donor reporting."
    - name: "avg_sh_risk_score"
      expr: AVG(CAST(sh_risk_score AS DOUBLE))
      comment: "Average sexual harassment risk score. Measures workplace safeguarding risk across programme sites."
    - name: "overdue_reviews"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of risk assessments past their scheduled review date. Compliance risk indicator — outdated assessments may not reflect current operating context."
    - name: "risk_reduction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN residual_risk_level IN ('low', 'Low', 'medium', 'Medium') AND overall_risk_level IN ('high', 'High', 'critical', 'Critical') THEN 1 END) / NULLIF(COUNT(CASE WHEN overall_risk_level IN ('high', 'High', 'critical', 'Critical') THEN 1 END), 0), 2)
      comment: "Percentage of high/critical risk assessments where mitigation reduced residual risk to medium or low. Measures effectiveness of safeguarding mitigation measures."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_disciplinary_outcome`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over disciplinary outcomes from safeguarding investigations. Tracks outcome types, appeal rates, and misconduct disclosure rates. Used by HR leadership and the Board to assess accountability and deterrence effectiveness. Disciplinary data is highly sensitive (pii_staff); apply strict access controls and masking in non-prod per VREQ-022."
  source: "`vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome`"
  dimensions:
    - name: "outcome_type"
      expr: outcome_type
      comment: "Type of disciplinary outcome (dismissal, warning, suspension, no action, etc.) — primary accountability classification."
    - name: "outcome_status"
      expr: outcome_status
      comment: "Current status of the disciplinary outcome (pending, implemented, appealed, overturned)."
    - name: "appeal_flag"
      expr: appeal_flag
      comment: "Boolean flag indicating whether the disciplinary outcome was appealed."
    - name: "misconduct_disclosure_flag"
      expr: misconduct_disclosure_flag
      comment: "Boolean flag indicating whether a misconduct disclosure was made to future employers or inter-agency databases."
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the disciplinary decision was made — used for annual accountability reporting."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month of disciplinary decision — used for trend analysis."
  measures:
    - name: "total_disciplinary_outcomes"
      expr: COUNT(1)
      comment: "Total number of disciplinary outcomes recorded. Core accountability volume KPI."
    - name: "dismissals"
      expr: COUNT(CASE WHEN outcome_type IN ('dismissal', 'Dismissal', 'termination', 'Termination') THEN 1 END)
      comment: "Number of cases resulting in dismissal or termination. Strongest accountability signal — monitored by donors and oversight bodies."
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disciplinary outcomes that were appealed. High appeal rates may indicate procedural fairness concerns."
    - name: "misconduct_disclosure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN misconduct_disclosure_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outcomes where misconduct was disclosed to inter-agency databases. Measures compliance with inter-agency information-sharing commitments (e.g., UN ClearCheck)."
    - name: "implemented_outcomes"
      expr: COUNT(CASE WHEN outcome_status IN ('implemented', 'Implemented') THEN 1 END)
      comment: "Number of disciplinary outcomes that have been fully implemented. Measures follow-through on accountability decisions."
    - name: "implementation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome_status IN ('implemented', 'Implemented') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disciplinary outcomes that have been implemented. Accountability effectiveness KPI — low rates indicate systemic follow-through failures."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_psea_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over PSEA policies. Tracks policy currency, mandatory training coverage, and whistleblower protection provisions. Used by the Safeguarding Director and Compliance team to ensure policy governance meets CHS, UN, and donor standards. Policy metadata is operational data with no direct PII."
  source: "`vibe_ngo_v1`.`safeguarding`.`psea_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the PSEA policy (active, draft, expired, under review) — lifecycle governance dimension."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework the policy aligns to (CHS, UN PSEA, donor-specific) — used for framework-level compliance reporting."
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Boolean flag indicating whether the policy mandates training for all staff."
    - name: "whistleblower_protection_flag"
      expr: whistleblower_protection_flag
      comment: "Boolean flag indicating whether the policy includes whistleblower protection provisions — CHS requirement."
    - name: "zero_tolerance_statement_flag"
      expr: zero_tolerance_statement_flag
      comment: "Boolean flag indicating whether the policy contains an explicit zero-tolerance statement — donor and UN requirement."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the policy became effective — used for policy age and review cycle analysis."
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of PSEA policies on record. Governance coverage baseline."
    - name: "active_policies"
      expr: COUNT(CASE WHEN policy_status IN ('active', 'Active') THEN 1 END)
      comment: "Number of currently active PSEA policies. Ensures the organisation maintains current, enforceable safeguarding policy coverage."
    - name: "expired_policies"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND policy_status NOT IN ('expired', 'Expired') THEN 1 END)
      comment: "Policies past their expiry date that have not been formally marked expired. Compliance risk — expired policies may not meet donor requirements."
    - name: "policies_due_for_review"
      expr: COUNT(CASE WHEN next_review_date <= DATE_ADD(CURRENT_DATE(), 30) AND policy_status IN ('active', 'Active') THEN 1 END)
      comment: "Active policies due for review within the next 30 days. Proactive governance indicator for the Safeguarding Director."
    - name: "policies_with_whistleblower_protection_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN whistleblower_protection_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN policy_status IN ('active', 'Active') THEN 1 END), 0), 2)
      comment: "Percentage of active policies that include whistleblower protection. CHS Standard 5 compliance indicator."
    - name: "policies_with_zero_tolerance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN zero_tolerance_statement_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN policy_status IN ('active', 'Active') THEN 1 END), 0), 2)
      comment: "Percentage of active policies containing an explicit zero-tolerance statement. UN and major donor compliance requirement."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_policy_acknowledgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over safeguarding policy acknowledgments by staff and volunteers. Tracks acknowledgment coverage, renewal compliance, and method distribution. Used by HR and Safeguarding teams to demonstrate workforce compliance to donors and auditors. Acknowledgment records contain pii_staff data; apply masking in non-prod per VREQ-022."
  source: "`vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment`"
  dimensions:
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "Method used to acknowledge the policy (digital signature, paper, e-learning completion) — used for audit trail quality assessment."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Boolean flag indicating whether periodic renewal of acknowledgment is required."
    - name: "acknowledgment_year"
      expr: YEAR(acknowledgment_date)
      comment: "Year of acknowledgment — used for annual compliance reporting."
    - name: "acknowledgment_month"
      expr: DATE_TRUNC('MONTH', acknowledgment_date)
      comment: "Month of acknowledgment — used for trend analysis and onboarding compliance monitoring."
  measures:
    - name: "total_acknowledgments"
      expr: COUNT(1)
      comment: "Total number of policy acknowledgments recorded. Core compliance volume KPI for donor and CHS reporting."
    - name: "unique_staff_acknowledged"
      expr: COUNT(DISTINCT staff_member_id)
      comment: "Number of distinct staff members who have acknowledged a safeguarding policy. Measures staff compliance coverage."
    - name: "unique_volunteers_acknowledged"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Number of distinct volunteers who have acknowledged a safeguarding policy. Measures volunteer compliance coverage."
    - name: "renewals_overdue"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE AND next_renewal_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of acknowledgments where renewal is required and the renewal date has passed. Compliance risk indicator — overdue renewals may breach donor requirements."
    - name: "renewal_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_required_flag = TRUE AND next_renewal_date >= CURRENT_DATE() THEN 1 END) / NULLIF(COUNT(CASE WHEN renewal_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of renewal-required acknowledgments that are currently up to date. Key compliance KPI for HR and donor audits."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over safeguarding audits. Tracks audit completion, findings volume, and overall ratings. Used by the Safeguarding Director and Board to assess organisational safeguarding system quality. Audit data is governance-sensitive operational data."
  source: "`vibe_ngo_v1`.`safeguarding`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, donor-commissioned) — determines scope and authority of findings."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in progress, completed, report issued) — lifecycle tracking."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall audit rating (satisfactory, partially satisfactory, unsatisfactory) — primary quality classification."
    - name: "audit_year"
      expr: YEAR(start_date)
      comment: "Year the audit commenced — used for annual governance reporting."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the audit commenced — used for workload and scheduling analysis."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of safeguarding audits conducted. Governance coverage baseline."
    - name: "completed_audits"
      expr: COUNT(CASE WHEN audit_status IN ('completed', 'Completed', 'report issued', 'Report Issued') THEN 1 END)
      comment: "Number of audits that have been completed. Measures audit programme throughput."
    - name: "unsatisfactory_audits"
      expr: COUNT(CASE WHEN overall_rating IN ('unsatisfactory', 'Unsatisfactory') THEN 1 END)
      comment: "Number of audits rated unsatisfactory. Critical risk indicator requiring immediate corrective action planning."
    - name: "unsatisfactory_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_rating IN ('unsatisfactory', 'Unsatisfactory') THEN 1 END) / NULLIF(COUNT(CASE WHEN audit_status IN ('completed', 'Completed', 'report issued', 'Report Issued') THEN 1 END), 0), 2)
      comment: "Percentage of completed audits rated unsatisfactory. Trend in this metric signals systemic safeguarding system deterioration."
    - name: "avg_audit_duration_days"
      expr: AVG(DATEDIFF(end_date, start_date))
      comment: "Average duration of audits in days. Measures audit efficiency and resource planning accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_audit_recommendation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over audit recommendations. Tracks implementation status, overdue recommendations, and priority distribution. Used by the Safeguarding Director and Compliance team to drive corrective action follow-through. Recommendation data is governance-sensitive."
  source: "`vibe_ngo_v1`.`safeguarding`.`audit_recommendation`"
  dimensions:
    - name: "implementation_status"
      expr: implementation_status
      comment: "Current implementation status of the recommendation (open, in progress, implemented, overdue) — primary tracking dimension."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the recommendation (critical, high, medium, low) — drives sequencing of corrective actions."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify implementation (document review, site visit, management confirmation) — quality of evidence dimension."
    - name: "target_year"
      expr: YEAR(target_date)
      comment: "Year the recommendation is targeted for implementation — used for workload planning."
  measures:
    - name: "total_recommendations"
      expr: COUNT(1)
      comment: "Total number of audit recommendations issued. Measures corrective action workload."
    - name: "implemented_recommendations"
      expr: COUNT(CASE WHEN implementation_status IN ('implemented', 'Implemented', 'closed', 'Closed') THEN 1 END)
      comment: "Number of recommendations that have been fully implemented. Measures corrective action follow-through."
    - name: "implementation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN implementation_status IN ('implemented', 'Implemented', 'closed', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit recommendations that have been implemented. Core accountability KPI for Board and donor reporting."
    - name: "overdue_recommendations"
      expr: COUNT(CASE WHEN implementation_status NOT IN ('implemented', 'Implemented', 'closed', 'Closed') AND target_date < CURRENT_DATE() THEN 1 END)
      comment: "Recommendations past their target date and not yet implemented. Compliance risk indicator requiring escalation."
    - name: "critical_high_open_recommendations"
      expr: COUNT(CASE WHEN priority_level IN ('critical', 'Critical', 'high', 'High') AND implementation_status NOT IN ('implemented', 'Implemented', 'closed', 'Closed') THEN 1 END)
      comment: "Number of open critical or high priority recommendations. Immediate risk indicator for the Safeguarding Director and Board."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_community_awareness_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over community safeguarding awareness sessions. Tracks reach, participation, and feedback collection. Used by programme managers and safeguarding focal points to measure community engagement and PSEA awareness-raising effectiveness. Session data may contain location information sensitive in conflict contexts."
  source: "`vibe_ngo_v1`.`safeguarding`.`community_awareness_session`"
  dimensions:
    - name: "session_type"
      expr: session_type
      comment: "Type of awareness session (PSEA, child protection, GBV prevention, etc.) — used for thematic coverage analysis."
    - name: "topic"
      expr: topic
      comment: "Specific topic covered in the session — enables content-level analysis of awareness-raising activities."
    - name: "language_code"
      expr: language_code
      comment: "Language in which the session was conducted — measures linguistic accessibility of safeguarding messaging."
    - name: "feedback_collected_flag"
      expr: feedback_collected_flag
      comment: "Boolean flag indicating whether participant feedback was collected — quality indicator for session accountability."
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', session_date)
      comment: "Month the session was held — used for trend analysis and programme reporting."
    - name: "session_year"
      expr: YEAR(session_date)
      comment: "Year the session was held — used for annual reporting."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of community awareness sessions conducted. Core outreach volume KPI."
    - name: "sessions_with_feedback"
      expr: COUNT(CASE WHEN feedback_collected_flag = TRUE THEN 1 END)
      comment: "Number of sessions where participant feedback was collected. Measures accountability and quality assurance coverage."
    - name: "feedback_collection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN feedback_collected_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions where feedback was collected. Quality indicator for community accountability mechanisms."
    - name: "unique_communities_reached"
      expr: COUNT(DISTINCT community_id)
      comment: "Number of distinct communities reached through awareness sessions. Measures geographic and community coverage breadth."
    - name: "unique_reporting_channels_promoted"
      expr: COUNT(DISTINCT reporting_channel_id)
      comment: "Number of distinct reporting channels promoted across sessions. Measures diversity of safeguarding reporting pathways communicated to communities."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_donor_safeguarding_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over donor safeguarding requirements attached to awards. Tracks compliance status, overdue reporting, and requirement type distribution. Used by Grant Management and Safeguarding teams to ensure donor contractual safeguarding obligations are met. Requirement data is grant-sensitive operational data."
  source: "`vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the donor safeguarding requirement (compliant, non-compliant, pending, overdue)."
    - name: "requirement_type"
      expr: requirement_type
      comment: "Type of donor requirement (incident reporting, policy submission, training evidence, audit) — used for requirement category analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency (monthly, quarterly, annual, ad hoc) — used for workload planning."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the requirement is due — used for annual compliance planning."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the requirement is due — used for near-term compliance workload management."
  measures:
    - name: "total_requirements"
      expr: COUNT(1)
      comment: "Total number of donor safeguarding requirements tracked. Measures compliance obligation portfolio size."
    - name: "non_compliant_requirements"
      expr: COUNT(CASE WHEN compliance_status IN ('non-compliant', 'Non-Compliant', 'overdue', 'Overdue') THEN 1 END)
      comment: "Number of requirements currently non-compliant or overdue. Critical risk indicator — non-compliance may trigger donor sanctions or award suspension."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status IN ('compliant', 'Compliant') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of donor safeguarding requirements currently in compliance. Primary KPI for grant compliance dashboards."
    - name: "overdue_requirements"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND compliance_status NOT IN ('compliant', 'Compliant') THEN 1 END)
      comment: "Requirements past their due date and not yet compliant. Immediate escalation trigger for Grant Management."
    - name: "unique_awards_with_requirements"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct awards with active donor safeguarding requirements. Measures breadth of grant portfolio subject to safeguarding compliance obligations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_support_service_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over support service referrals for survivors. Tracks referral completion rates, consent compliance, and follow-up coverage. Used by case managers and safeguarding focal points to monitor survivor support quality. Referral data is highly sensitive (pii_beneficiary_protected); apply strict masking in non-prod per VREQ-022."
  source: "`vibe_ngo_v1`.`safeguarding`.`support_service_referral`"
  dimensions:
    - name: "referral_type"
      expr: referral_type
      comment: "Type of support service referral (medical, psychosocial, legal, shelter, livelihood) — used for service gap analysis."
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (pending, accepted, completed, declined) — lifecycle tracking."
    - name: "consent_obtained_flag"
      expr: consent_obtained_flag
      comment: "Boolean flag indicating whether survivor consent was obtained before referral — mandatory ethical and legal requirement."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Boolean flag indicating whether follow-up is required for this referral."
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month the referral was made — used for trend analysis and service demand planning."
    - name: "referral_year"
      expr: YEAR(referral_date)
      comment: "Year the referral was made — used for annual reporting."
  measures:
    - name: "total_referrals"
      expr: COUNT(1)
      comment: "Total number of support service referrals made. Core survivor support volume KPI."
    - name: "completed_referrals"
      expr: COUNT(CASE WHEN referral_status IN ('completed', 'Completed') THEN 1 END)
      comment: "Number of referrals that have been completed. Measures survivor support service delivery effectiveness."
    - name: "referral_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_status IN ('completed', 'Completed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals that have been completed. Key survivor support quality KPI."
    - name: "consent_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals where survivor consent was obtained. Ethical compliance KPI — any value below 100% requires immediate investigation."
    - name: "pending_follow_ups"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE AND referral_status NOT IN ('completed', 'Completed') THEN 1 END)
      comment: "Number of referrals requiring follow-up that have not yet been completed. Drives case manager workload prioritisation."
    - name: "avg_days_to_acceptance"
      expr: AVG(DATEDIFF(acceptance_date, referral_date))
      comment: "Average days from referral to service acceptance. Measures timeliness of survivor support service access — critical for trauma-informed care standards."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_alleged_perpetrator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alleged perpetrator case management metrics tracking investigation outcomes, disciplinary actions, criminal referrals, and misconduct database reporting for accountability and organizational protection"
  source: "`vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator`"
  dimensions:
    - name: "investigation_outcome"
      expr: investigation_outcome
      comment: "Outcome of the investigation (substantiated, unsubstantiated, etc.)"
  measures:
    - name: "total_alleged_perpetrators"
      expr: COUNT(1)
      comment: "Total number of alleged perpetrator records"
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_survivor_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Survivor support metrics tracking survivor demographics, support provision, case management, and confidentiality compliance for survivor-centered response"
  source: "`vibe_ngo_v1`.`safeguarding`.`survivor_record`"
  dimensions:
    - name: "age_group"
      expr: age_group
      comment: "Age group of the survivor"
    - name: "support_status"
      expr: support_status
      comment: "Current status of support provision (active, completed, declined, etc.)"
  measures:
    - name: "total_survivors"
      expr: COUNT(1)
      comment: "Total number of survivor records"
$$;