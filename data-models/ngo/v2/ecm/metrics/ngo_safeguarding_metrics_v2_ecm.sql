-- Metric views for domain: safeguarding | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core safeguarding incident KPIs tracking volume, severity distribution, investigation rates, survivor involvement, and donor notification compliance. Drives executive oversight of organizational safeguarding performance."
  source: "`vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`"
  dimensions:
    - name: "incident_type"
      expr: safeguarding_incident_type
      comment: "Type of safeguarding incident (e.g. SEA, child protection, harassment) for categorical breakdown."
    - name: "incident_severity_level"
      expr: severity_level
      comment: "Severity classification of the incident (critical, high, medium, low) for risk-tiered reporting."
    - name: "incident_status"
      expr: safeguarding_incident_status
      comment: "Current workflow status of the incident (open, under investigation, closed) for pipeline monitoring."
    - name: "incident_subtype"
      expr: subtype
      comment: "Sub-classification of the incident type for granular categorization."
    - name: "location_country"
      expr: location_country
      comment: "Country where the incident occurred, enabling geographic risk analysis."
    - name: "location_region"
      expr: location_region
      comment: "Region where the incident occurred for regional performance monitoring."
    - name: "reporter_type"
      expr: reporter_type
      comment: "Category of person who reported the incident (staff, beneficiary, partner, anonymous) to assess reporting culture."
    - name: "reporting_channel"
      expr: reporting_channel
      comment: "Channel through which the incident was reported (hotline, email, in-person) for channel effectiveness analysis."
    - name: "survivor_gender"
      expr: survivor_gender
      comment: "Gender of the survivor for equity and disaggregated safeguarding analysis."
    - name: "survivor_age_group"
      expr: survivor_age_group
      comment: "Age group of the survivor (child, adult, elderly) for vulnerability-focused reporting."
    - name: "incident_year"
      expr: DATE_TRUNC('YEAR', safeguarding_incident_date)
      comment: "Year the incident occurred for annual trend analysis."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', safeguarding_incident_date)
      comment: "Month the incident occurred for seasonal and monthly trend analysis."
    - name: "investigation_outcome"
      expr: investigation_outcome
      comment: "Outcome of the investigation (substantiated, unsubstantiated, inconclusive) for accountability tracking."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safeguarding incidents recorded. Baseline KPI for organizational safeguarding load and trend monitoring."
    - name: "incidents_requiring_investigation"
      expr: COUNT(CASE WHEN investigation_required_flag = TRUE THEN 1 END)
      comment: "Number of incidents flagged as requiring formal investigation. Indicates severity and accountability burden."
    - name: "investigation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN investigation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that triggered a formal investigation. High rates signal systemic risk; low rates may indicate under-reporting or under-response."
    - name: "incidents_with_survivor_involved"
      expr: COUNT(CASE WHEN survivor_involved_flag = TRUE THEN 1 END)
      comment: "Number of incidents where a survivor was directly involved. Critical for survivor-centered response planning and resource allocation."
    - name: "survivor_support_provided_count"
      expr: COUNT(CASE WHEN survivor_support_provided_flag = TRUE THEN 1 END)
      comment: "Number of incidents where survivor support was provided. Measures organizational duty-of-care fulfillment."
    - name: "survivor_support_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN survivor_support_provided_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN survivor_involved_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of survivor-involved incidents where support was provided. Key accountability metric for survivor-centered safeguarding standards."
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of incidents requiring donor notification. Drives compliance tracking against donor safeguarding requirements."
    - name: "donor_notified_count"
      expr: COUNT(CASE WHEN donor_notified_date IS NOT NULL THEN 1 END)
      comment: "Number of incidents where the donor was actually notified. Paired with donor_notification_required_count to compute compliance rate."
    - name: "donor_notification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN donor_notified_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required donor notifications that were completed. Directly tied to grant compliance risk and donor relationship management."
    - name: "law_enforcement_notified_count"
      expr: COUNT(CASE WHEN law_enforcement_notified_flag = TRUE THEN 1 END)
      comment: "Number of incidents escalated to law enforcement. Indicates severity of the incident portfolio and legal risk exposure."
    - name: "open_incidents"
      expr: COUNT(CASE WHEN safeguarding_incident_status NOT IN ('closed', 'Closed') THEN 1 END)
      comment: "Number of incidents not yet closed. Operational backlog metric for safeguarding team capacity planning."
    - name: "avg_days_to_investigation_start"
      expr: AVG(DATEDIFF(investigation_start_date, safeguarding_incident_date))
      comment: "Average number of days between incident date and investigation start. Measures organizational response speed against safeguarding standards."
    - name: "avg_days_to_investigation_completion"
      expr: AVG(DATEDIFF(investigation_completion_date, investigation_start_date))
      comment: "Average number of days to complete an investigation once started. Tracks investigation efficiency and compliance with timeframe commitments."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigation-level KPIs covering caseload, cost, completion rates, and external reporting compliance. Enables leadership to assess investigation capacity, quality, and accountability outcomes."
  source: "`vibe_ngo_v1`.`safeguarding`.`investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation (internal, external, joint) for resource and methodology analysis."
    - name: "investigation_category"
      expr: investigation_category
      comment: "Category of misconduct being investigated for thematic trend analysis."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (open, in progress, closed) for pipeline management."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the investigation for access control and reporting segmentation."
    - name: "final_determination"
      expr: final_determination
      comment: "Final outcome determination (substantiated, unsubstantiated, inconclusive) for accountability reporting."
    - name: "law_enforcement_referral_flag"
      expr: law_enforcement_referral_flag
      comment: "Whether the investigation was referred to law enforcement, indicating severity tier."
    - name: "investigation_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the investigation was initiated for annual trend and capacity analysis."
    - name: "investigation_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the investigation was initiated for monthly workload tracking."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of investigations opened. Baseline measure of investigation caseload and organizational accountability activity."
    - name: "open_investigations"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('closed', 'Closed', 'completed', 'Completed') THEN 1 END)
      comment: "Number of investigations currently open. Operational backlog metric for investigation team capacity planning."
    - name: "completed_investigations"
      expr: COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of investigations that have been formally completed. Measures throughput and closure rate."
    - name: "investigation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations that have been completed. Key performance indicator for investigation team effectiveness."
    - name: "total_investigation_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total financial cost of all investigations in USD. Drives budget planning and cost-per-case analysis for safeguarding operations."
    - name: "avg_investigation_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per investigation in USD. Benchmarking metric for investigation efficiency and resource allocation decisions."
    - name: "external_reporting_required_count"
      expr: COUNT(CASE WHEN external_reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of investigations requiring external reporting to regulators or donors. Compliance risk indicator."
    - name: "external_reporting_completed_count"
      expr: COUNT(CASE WHEN external_reporting_required_flag = TRUE AND external_reporting_date IS NOT NULL THEN 1 END)
      comment: "Number of investigations where required external reporting was completed. Paired with required count to compute compliance rate."
    - name: "external_reporting_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN external_reporting_required_flag = TRUE AND external_reporting_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN external_reporting_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of investigations requiring external reporting where reporting was completed on time. Critical compliance KPI for donor and regulatory accountability."
    - name: "law_enforcement_referral_count"
      expr: COUNT(CASE WHEN law_enforcement_referral_flag = TRUE THEN 1 END)
      comment: "Number of investigations referred to law enforcement. Indicates severity of the investigation portfolio and legal risk exposure."
    - name: "avg_days_to_completion"
      expr: AVG(DATEDIFF(actual_completion_date, start_date))
      comment: "Average number of days from investigation start to completion. Measures investigation cycle time against organizational and donor standards."
    - name: "overdue_investigations"
      expr: COUNT(CASE WHEN actual_completion_date IS NULL AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of investigations past their target completion date without being closed. Operational risk metric requiring immediate management attention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_alleged_perpetrator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alleged perpetrator case KPIs tracking allegation volume, severity, investigation outcomes, disciplinary actions, and misconduct database reporting. Supports accountability and organizational risk management decisions."
  source: "`vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator`"
  dimensions:
    - name: "allegation_type"
      expr: allegation_type
      comment: "Type of allegation (SEA, harassment, abuse of authority) for thematic analysis of misconduct patterns."
    - name: "allegation_severity"
      expr: allegation_severity
      comment: "Severity level of the allegation for risk-tiered case management."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation related to this alleged perpetrator."
    - name: "investigation_outcome"
      expr: investigation_outcome
      comment: "Outcome of the investigation (substantiated, unsubstantiated) for accountability reporting."
    - name: "case_outcome"
      expr: case_outcome
      comment: "Final case outcome including disciplinary result for executive accountability reporting."
    - name: "employment_status_at_incident"
      expr: employment_status_at_incident
      comment: "Employment status of the alleged perpetrator at the time of the incident for workforce risk analysis."
    - name: "relationship_to_organization"
      expr: relationship_to_organization
      comment: "Relationship of the alleged perpetrator to the organization (staff, volunteer, partner, contractor) for systemic risk identification."
    - name: "rehire_eligibility"
      expr: rehire_eligibility
      comment: "Whether the individual is eligible for rehire, critical for preventing re-engagement of substantiated perpetrators."
    - name: "allegation_year"
      expr: DATE_TRUNC('YEAR', allegation_date)
      comment: "Year of the allegation for annual trend analysis."
    - name: "country_office_at_incident"
      expr: country_office_at_incident
      comment: "Country office where the incident occurred for geographic risk analysis."
  measures:
    - name: "total_alleged_perpetrators"
      expr: COUNT(1)
      comment: "Total number of alleged perpetrator records. Baseline measure of accountability caseload."
    - name: "criminal_referral_count"
      expr: COUNT(CASE WHEN criminal_referral_made = TRUE THEN 1 END)
      comment: "Number of cases where a criminal referral was made. Indicates severity of substantiated misconduct and legal risk exposure."
    - name: "criminal_referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN criminal_referral_made = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alleged perpetrator cases resulting in criminal referral. Tracks severity profile of the misconduct portfolio."
    - name: "misconduct_database_reported_count"
      expr: COUNT(CASE WHEN misconduct_database_reported = TRUE THEN 1 END)
      comment: "Number of cases reported to the inter-agency misconduct disclosure database. Measures compliance with inter-agency accountability obligations."
    - name: "misconduct_database_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN misconduct_database_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases reported to the misconduct database. Critical compliance KPI for inter-agency safeguarding standards."
    - name: "cases_with_disciplinary_action"
      expr: COUNT(CASE WHEN disciplinary_action_date IS NOT NULL THEN 1 END)
      comment: "Number of cases where disciplinary action was taken. Measures organizational accountability follow-through."
    - name: "disciplinary_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disciplinary_action_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alleged perpetrator cases resulting in disciplinary action. Key accountability metric for organizational culture and donor reporting."
    - name: "cases_with_termination"
      expr: COUNT(CASE WHEN termination_date IS NOT NULL THEN 1 END)
      comment: "Number of cases resulting in termination of employment. Tracks the most severe disciplinary outcome for executive accountability reporting."
    - name: "avg_days_investigation_duration"
      expr: AVG(DATEDIFF(investigation_completion_date, investigation_start_date))
      comment: "Average number of days from investigation start to completion for alleged perpetrator cases. Measures investigation timeliness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safeguarding training compliance KPIs tracking completion rates, pass rates, cost efficiency, and overdue training. Enables leadership to assess organizational readiness and compliance with mandatory safeguarding training requirements."
  source: "`vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion`"
  dimensions:
    - name: "participant_type"
      expr: participant_type
      comment: "Type of participant (staff, volunteer, partner) for disaggregated compliance reporting."
    - name: "training_status"
      expr: safeguarding_training_completion_status
      comment: "Current status of the training completion record (completed, in progress, overdue) for pipeline monitoring."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Whether the participant passed or failed the training assessment for quality analysis."
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Whether the training was mandatory, enabling compliance rate calculation for required vs optional training."
    - name: "overdue_flag"
      expr: overdue_flag
      comment: "Whether the training completion is overdue, for immediate operational escalation."
    - name: "channel"
      expr: channel
      comment: "Delivery channel of the training (online, in-person, blended) for modality effectiveness analysis."
    - name: "language"
      expr: language
      comment: "Language in which training was delivered for accessibility and inclusion analysis."
    - name: "completion_year"
      expr: DATE_TRUNC('YEAR', safeguarding_training_completion_date)
      comment: "Year of training completion for annual compliance trend analysis."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', safeguarding_training_completion_date)
      comment: "Month of training completion for monthly compliance monitoring."
    - name: "refresher_required_flag"
      expr: refresher_required_flag
      comment: "Whether a refresher training is required, for forward-looking compliance planning."
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total number of safeguarding training completion records. Baseline measure of training activity volume."
    - name: "mandatory_training_completions"
      expr: COUNT(CASE WHEN mandatory_training_flag = TRUE THEN 1 END)
      comment: "Number of mandatory safeguarding training completions. Core compliance metric for organizational safeguarding standards."
    - name: "passed_training_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'pass' OR pass_fail_status = 'Pass' OR pass_fail_status = 'PASS' THEN 1 END)
      comment: "Number of training completions where the participant passed the assessment. Measures training effectiveness."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status IN ('pass', 'Pass', 'PASS') THEN 1 END) / NULLIF(COUNT(CASE WHEN pass_fail_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of assessed training completions where participants passed. Indicates training quality and participant preparedness."
    - name: "overdue_training_count"
      expr: COUNT(CASE WHEN overdue_flag = TRUE THEN 1 END)
      comment: "Number of training completions that are overdue. Operational risk metric requiring immediate management intervention."
    - name: "overdue_mandatory_training_count"
      expr: COUNT(CASE WHEN overdue_flag = TRUE AND mandatory_training_flag = TRUE THEN 1 END)
      comment: "Number of mandatory training completions that are overdue. Critical compliance risk metric for donor and regulatory reporting."
    - name: "total_training_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost of safeguarding training in USD. Drives budget planning and cost-per-participant analysis."
    - name: "avg_training_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per training completion in USD. Benchmarking metric for training efficiency and modality cost comparison."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training completions. Measures overall participant knowledge retention and training effectiveness."
    - name: "avg_training_duration_hours"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average duration of training in hours. Used for capacity planning and comparing modality efficiency."
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total safeguarding training hours delivered. Measures organizational investment in safeguarding capacity building."
    - name: "waiver_granted_count"
      expr: COUNT(CASE WHEN waiver_granted_flag = TRUE THEN 1 END)
      comment: "Number of training waivers granted. High waiver rates may indicate compliance gaps requiring executive attention."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_granted_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN mandatory_training_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of mandatory training completions where a waiver was granted instead of actual completion. Risk indicator for compliance culture."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safeguarding audit KPIs covering compliance scores, finding rates, corrective action requirements, and follow-up audit rates. Enables leadership to assess organizational safeguarding maturity and audit-driven improvement."
  source: "`vibe_ngo_v1`.`safeguarding`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, donor-commissioned) for source and methodology analysis."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit (PSEA, child protection, general safeguarding) for thematic analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in progress, completed) for pipeline management."
    - name: "overall_safeguarding_maturity_rating"
      expr: overall_safeguarding_maturity_rating
      comment: "Overall safeguarding maturity rating assigned by the audit for organizational benchmarking."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the audit for access control and reporting segmentation."
    - name: "corrective_action_plan_required_flag"
      expr: corrective_action_plan_required_flag
      comment: "Whether a corrective action plan was required as a result of the audit."
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required_flag
      comment: "Whether a follow-up audit was required, indicating unresolved findings."
    - name: "audit_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the audit was initiated for annual trend analysis."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of safeguarding audits conducted. Baseline measure of audit activity and organizational oversight intensity."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all audits. Primary KPI for organizational safeguarding compliance health, tracked by leadership and donors."
    - name: "total_audit_cost_usd"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of safeguarding audits in USD. Drives budget planning for the safeguarding oversight function."
    - name: "avg_audit_cost_usd"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per audit in USD. Benchmarking metric for audit efficiency and vendor management."
    - name: "audits_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 END)
      comment: "Number of audits that required a corrective action plan. Indicates the volume of compliance gaps identified."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in a corrective action plan requirement. Key indicator of systemic compliance weaknesses."
    - name: "audits_requiring_follow_up"
      expr: COUNT(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 END)
      comment: "Number of audits requiring a follow-up audit due to unresolved findings. Measures persistence of compliance gaps."
    - name: "follow_up_audit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up. High rates indicate systemic issues not being resolved between audit cycles."
    - name: "management_response_received_count"
      expr: COUNT(CASE WHEN management_response_received_flag = TRUE THEN 1 END)
      comment: "Number of audits where management formally responded to findings. Measures organizational accountability and engagement with audit outcomes."
    - name: "management_response_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN management_response_received_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits where management provided a formal response. Tracks organizational accountability culture."
    - name: "avg_days_to_completion"
      expr: AVG(DATEDIFF(actual_completion_date, start_date))
      comment: "Average number of days from audit start to completion. Measures audit efficiency and timeliness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safeguarding risk assessment KPIs tracking risk levels, mitigation costs, and reassessment compliance. Enables leadership to prioritize safeguarding investments and monitor organizational risk exposure."
  source: "`vibe_ngo_v1`.`safeguarding`.`risk_assessment`"
  dimensions:
    - name: "risk_assessment_type"
      expr: risk_assessment_type
      comment: "Type of risk assessment (program, organizational, partner) for scope-based analysis."
    - name: "risk_assessment_status"
      expr: risk_assessment_status
      comment: "Current status of the risk assessment (draft, approved, expired) for pipeline management."
    - name: "overall_safeguarding_risk_level"
      expr: overall_safeguarding_risk_level
      comment: "Overall safeguarding risk level (critical, high, medium, low) for risk-tiered portfolio management."
    - name: "mitigation_plan_status"
      expr: mitigation_plan_status
      comment: "Status of the mitigation plan (in place, partial, not started) for action tracking."
    - name: "beneficiary_consultation_conducted"
      expr: beneficiary_consultation_conducted
      comment: "Whether beneficiary consultation was conducted as part of the assessment, for participatory safeguarding standards compliance."
    - name: "assessment_year"
      expr: DATE_TRUNC('YEAR', risk_assessment_date)
      comment: "Year the risk assessment was conducted for annual trend analysis."
    - name: "power_imbalance_risk_rating"
      expr: power_imbalance_risk_rating
      comment: "Rating of power imbalance risk, a key driver of SEA incidents, for targeted mitigation planning."
    - name: "operational_environment_risk_rating"
      expr: operational_environment_risk_rating
      comment: "Rating of operational environment risk for context-sensitive safeguarding planning."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of safeguarding risk assessments conducted. Baseline measure of organizational risk management activity."
    - name: "high_critical_risk_assessments"
      expr: COUNT(CASE WHEN overall_safeguarding_risk_level IN ('high', 'High', 'critical', 'Critical') THEN 1 END)
      comment: "Number of assessments rated high or critical risk. Drives prioritization of safeguarding investments and interventions."
    - name: "high_critical_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_safeguarding_risk_level IN ('high', 'High', 'critical', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk assessments rated high or critical. Key portfolio risk indicator for executive safeguarding oversight."
    - name: "total_estimated_mitigation_cost_usd"
      expr: SUM(CAST(estimated_mitigation_cost_usd AS DOUBLE))
      comment: "Total estimated cost of safeguarding risk mitigation across all assessments. Drives budget planning for safeguarding risk management."
    - name: "avg_estimated_mitigation_cost_usd"
      expr: AVG(CAST(estimated_mitigation_cost_usd AS DOUBLE))
      comment: "Average estimated mitigation cost per risk assessment. Benchmarking metric for safeguarding investment planning."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all assessments. Tracks overall organizational safeguarding risk level over time."
    - name: "assessments_with_mitigation_in_place"
      expr: COUNT(CASE WHEN mitigation_plan_status IN ('in place', 'In Place', 'complete', 'Complete') THEN 1 END)
      comment: "Number of assessments where a mitigation plan is fully in place. Measures risk management follow-through."
    - name: "mitigation_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mitigation_plan_status IN ('in place', 'In Place', 'complete', 'Complete') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk assessments with a mitigation plan fully in place. Key indicator of organizational risk management maturity."
    - name: "overdue_reassessments"
      expr: COUNT(CASE WHEN reassessment_due_date < CURRENT_DATE() AND risk_assessment_status NOT IN ('expired', 'Expired', 'superseded', 'Superseded') THEN 1 END)
      comment: "Number of risk assessments past their reassessment due date. Operational risk metric indicating gaps in ongoing risk monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_partner_psea_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner PSEA capacity assessment KPIs tracking partner safeguarding readiness, capacity scores, critical gaps, and reassessment compliance. Enables leadership to manage partner safeguarding risk and capacity building investments."
  source: "`vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: partner_psea_assessment_type
      comment: "Type of partner PSEA assessment (initial, periodic, triggered) for assessment lifecycle analysis."
    - name: "assessment_status"
      expr: partner_psea_assessment_status
      comment: "Current status of the assessment (completed, in progress, expired) for pipeline management."
    - name: "overall_capacity_rating"
      expr: overall_capacity_rating
      comment: "Overall PSEA capacity rating assigned to the partner for risk-tiered partner management."
    - name: "partnership_approval_status"
      expr: partnership_approval_status
      comment: "Whether the partnership was approved, conditionally approved, or rejected based on the assessment."
    - name: "critical_gap_flag"
      expr: critical_gap_flag
      comment: "Whether a critical safeguarding gap was identified, requiring immediate capacity building or partnership suspension."
    - name: "capacity_building_plan_triggered_flag"
      expr: capacity_building_plan_triggered_flag
      comment: "Whether the assessment triggered a capacity building plan for the partner."
    - name: "reassessment_required_flag"
      expr: reassessment_required_flag
      comment: "Whether a reassessment is required, for forward-looking compliance planning."
    - name: "assessment_year"
      expr: DATE_TRUNC('YEAR', partner_psea_assessment_date)
      comment: "Year the assessment was conducted for annual trend analysis."
  measures:
    - name: "total_partner_assessments"
      expr: COUNT(1)
      comment: "Total number of partner PSEA assessments conducted. Baseline measure of partner safeguarding due diligence activity."
    - name: "partners_with_critical_gaps"
      expr: COUNT(CASE WHEN critical_gap_flag = TRUE THEN 1 END)
      comment: "Number of partner assessments identifying critical safeguarding gaps. Drives immediate risk management decisions on partnership continuation."
    - name: "critical_gap_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_gap_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partner assessments identifying critical gaps. Key risk indicator for the partner portfolio safeguarding health."
    - name: "avg_capacity_score"
      expr: AVG(CAST(capacity_score AS DOUBLE))
      comment: "Average PSEA capacity score across all partner assessments. Tracks overall partner portfolio safeguarding readiness."
    - name: "avg_capacity_score_pct"
      expr: ROUND(100.0 * AVG(CAST(capacity_score AS DOUBLE)) / NULLIF(AVG(CAST(maximum_possible_score AS DOUBLE)), 0), 2)
      comment: "Average capacity score as a percentage of the maximum possible score. Normalized benchmark for partner safeguarding capacity across different assessment frameworks."
    - name: "capacity_building_plans_triggered"
      expr: COUNT(CASE WHEN capacity_building_plan_triggered_flag = TRUE THEN 1 END)
      comment: "Number of assessments that triggered a capacity building plan. Measures the volume of partners requiring safeguarding investment."
    - name: "capacity_building_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN capacity_building_plan_triggered_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partner assessments triggering a capacity building plan. Indicates the proportion of partners below acceptable safeguarding standards."
    - name: "overdue_reassessments"
      expr: COUNT(CASE WHEN reassessment_due_date < CURRENT_DATE() AND partner_psea_assessment_status NOT IN ('expired', 'Expired') THEN 1 END)
      comment: "Number of partner assessments past their reassessment due date. Compliance risk metric for partner safeguarding oversight."
    - name: "approved_partnerships"
      expr: COUNT(CASE WHEN partnership_approval_status IN ('approved', 'Approved') THEN 1 END)
      comment: "Number of partner assessments resulting in full partnership approval. Measures the volume of safeguarding-cleared partners."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_disciplinary_outcome`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary outcome KPIs tracking accountability actions, appeal rates, law enforcement referrals, and restitution. Enables leadership to assess the effectiveness and consistency of the organizational accountability system."
  source: "`vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome`"
  dimensions:
    - name: "disciplinary_outcome_type"
      expr: disciplinary_outcome_type
      comment: "Type of disciplinary outcome (termination, suspension, warning, demotion) for accountability pattern analysis."
    - name: "disciplinary_outcome_status"
      expr: disciplinary_outcome_status
      comment: "Current status of the disciplinary outcome (pending, final, appealed) for pipeline management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the disciplinary outcome for risk-tiered accountability reporting."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed against the disciplinary outcome, for due process monitoring."
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the appeal (upheld, overturned, modified) for accountability system quality assessment."
    - name: "law_enforcement_referral_flag"
      expr: law_enforcement_referral_flag
      comment: "Whether the case was referred to law enforcement for criminal prosecution."
    - name: "mds_reported_flag"
      expr: mds_reported_flag
      comment: "Whether the outcome was reported to the misconduct disclosure scheme, for inter-agency accountability compliance."
    - name: "outcome_year"
      expr: DATE_TRUNC('YEAR', disciplinary_outcome_date)
      comment: "Year the disciplinary outcome was issued for annual accountability trend analysis."
  measures:
    - name: "total_disciplinary_outcomes"
      expr: COUNT(1)
      comment: "Total number of disciplinary outcomes issued. Baseline measure of organizational accountability activity."
    - name: "appeal_filed_count"
      expr: COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END)
      comment: "Number of disciplinary outcomes where an appeal was filed. High appeal rates may indicate inconsistency in disciplinary decisions."
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disciplinary outcomes that were appealed. Indicator of perceived fairness and consistency in the accountability system."
    - name: "law_enforcement_referral_count"
      expr: COUNT(CASE WHEN law_enforcement_referral_flag = TRUE THEN 1 END)
      comment: "Number of disciplinary outcomes resulting in law enforcement referral. Tracks the most severe accountability actions."
    - name: "mds_reported_count"
      expr: COUNT(CASE WHEN mds_reported_flag = TRUE THEN 1 END)
      comment: "Number of outcomes reported to the misconduct disclosure scheme. Measures inter-agency accountability compliance."
    - name: "mds_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mds_reported_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disciplinary outcomes reported to the misconduct disclosure scheme. Critical compliance KPI for inter-agency safeguarding standards."
    - name: "total_restitution_amount_usd"
      expr: SUM(CAST(restitution_amount_usd AS DOUBLE))
      comment: "Total restitution amount ordered across all disciplinary outcomes in USD. Financial accountability metric."
    - name: "restitution_required_count"
      expr: COUNT(CASE WHEN restitution_required_flag = TRUE THEN 1 END)
      comment: "Number of disciplinary outcomes requiring financial restitution. Tracks financial accountability actions."
    - name: "training_required_count"
      expr: COUNT(CASE WHEN training_required_flag = TRUE THEN 1 END)
      comment: "Number of disciplinary outcomes requiring remedial training. Measures rehabilitative accountability actions alongside punitive ones."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_policy_acknowledgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy acknowledgment compliance KPIs tracking acknowledgment rates, renewal compliance, and training completion linkage. Enables leadership to monitor organizational compliance with mandatory safeguarding policy acknowledgment requirements."
  source: "`vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment`"
  dimensions:
    - name: "acknowledger_type"
      expr: acknowledger_type
      comment: "Type of acknowledger (staff, volunteer, partner) for disaggregated compliance reporting."
    - name: "acknowledgment_status"
      expr: safeguarding_policy_acknowledgment_status
      comment: "Current status of the acknowledgment (active, expired, pending renewal) for compliance pipeline management."
    - name: "method"
      expr: method
      comment: "Method of acknowledgment (digital, paper, in-person) for process efficiency analysis."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether periodic renewal of the acknowledgment is required."
    - name: "training_completion_required_flag"
      expr: training_completion_required_flag
      comment: "Whether training completion was required alongside the policy acknowledgment."
    - name: "language"
      expr: language
      comment: "Language in which the policy was acknowledged for accessibility and inclusion analysis."
    - name: "acknowledgment_year"
      expr: DATE_TRUNC('YEAR', safeguarding_policy_acknowledgment_date)
      comment: "Year of acknowledgment for annual compliance trend analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the acknowledgment was made for geographic compliance analysis."
  measures:
    - name: "total_acknowledgments"
      expr: COUNT(1)
      comment: "Total number of safeguarding policy acknowledgments recorded. Baseline compliance measure."
    - name: "active_acknowledgments"
      expr: COUNT(CASE WHEN safeguarding_policy_acknowledgment_status IN ('active', 'Active') THEN 1 END)
      comment: "Number of currently active policy acknowledgments. Measures current compliance coverage."
    - name: "expired_acknowledgments"
      expr: COUNT(CASE WHEN valid_until_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of acknowledgments that have expired. Compliance gap metric requiring renewal action."
    - name: "expiry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN valid_until_date < CURRENT_DATE() THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acknowledgments that have expired. Tracks the scale of the compliance renewal backlog."
    - name: "training_completion_linked_count"
      expr: COUNT(CASE WHEN training_completion_required_flag = TRUE AND training_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of acknowledgments where required training was also completed. Measures holistic compliance with safeguarding policy requirements."
    - name: "training_completion_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_completion_required_flag = TRUE AND training_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN training_completion_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of acknowledgments requiring training where training was also completed. Measures end-to-end safeguarding compliance."
    - name: "consent_to_process_data_count"
      expr: COUNT(CASE WHEN consent_to_process_data_flag = TRUE THEN 1 END)
      comment: "Number of acknowledgments where data processing consent was obtained. Tracks GDPR and data protection compliance alongside safeguarding compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_community_awareness_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Community safeguarding awareness session KPIs tracking reach, participation, incident reporting rates, and referral rates. Enables leadership to assess the effectiveness of community-level safeguarding prevention activities."
  source: "`vibe_ngo_v1`.`safeguarding`.`community_awareness_session`"
  dimensions:
    - name: "session_type"
      expr: community_awareness_session_type
      comment: "Type of awareness session (PSEA, child protection, GBV) for thematic reach analysis."
    - name: "session_status"
      expr: community_awareness_session_status
      comment: "Current status of the session (planned, completed, cancelled) for activity pipeline management."
    - name: "location_country_code"
      expr: location_country_code
      comment: "Country where the session was held for geographic reach analysis."
    - name: "location_region"
      expr: location_region
      comment: "Region where the session was held for sub-national reach analysis."
    - name: "language_used"
      expr: language_used
      comment: "Language used in the session for accessibility and inclusion analysis."
    - name: "translation_provided_flag"
      expr: translation_provided_flag
      comment: "Whether translation was provided, for language accessibility monitoring."
    - name: "incident_reported_flag"
      expr: incident_reported_flag
      comment: "Whether an incident was reported during or following the session, linking awareness activities to reporting outcomes."
    - name: "referral_made_flag"
      expr: referral_made_flag
      comment: "Whether a referral was made as a result of the session, measuring session-to-action conversion."
    - name: "session_year"
      expr: DATE_TRUNC('YEAR', community_awareness_session_date)
      comment: "Year the session was held for annual reach trend analysis."
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', community_awareness_session_date)
      comment: "Month the session was held for monthly activity monitoring."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of community awareness sessions conducted. Baseline measure of prevention activity volume."
    - name: "sessions_with_incident_reported"
      expr: COUNT(CASE WHEN incident_reported_flag = TRUE THEN 1 END)
      comment: "Number of sessions where an incident was reported. Measures the disclosure-enabling effect of awareness sessions."
    - name: "incident_reporting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_reported_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that resulted in an incident report. Tracks the effectiveness of sessions in enabling safe disclosure."
    - name: "sessions_with_referral"
      expr: COUNT(CASE WHEN referral_made_flag = TRUE THEN 1 END)
      comment: "Number of sessions resulting in a referral to support services. Measures session-to-action conversion rate."
    - name: "referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_made_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions resulting in a referral. Tracks the practical impact of awareness sessions on survivor support pathways."
    - name: "sessions_with_translation"
      expr: COUNT(CASE WHEN translation_provided_flag = TRUE THEN 1 END)
      comment: "Number of sessions where translation was provided. Measures language accessibility of safeguarding awareness activities."
    - name: "translation_provision_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN translation_provided_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions where translation was provided. Tracks inclusion and accessibility standards compliance."
$$;