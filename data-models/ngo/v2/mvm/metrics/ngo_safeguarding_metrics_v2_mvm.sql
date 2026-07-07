-- Metric views for domain: safeguarding | Business: Ngo | Version: 2 | Generated on: 2026-07-03 06:15:30

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for safeguarding incidents — tracks volume, severity distribution, donor notification compliance, referral rates, and response timeliness to steer organizational safeguarding performance."
  source: "`vibe_ngo_v1`.`safeguarding`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safeguarding incident (e.g. SEA, child safeguarding, harassment) for categorical analysis."
    - name: "incident_category"
      expr: category
      comment: "Incident category for sub-classification within incident types."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident (e.g. low, medium, high, critical) — key dimension for prioritization dashboards."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (e.g. open, under investigation, closed) for pipeline and backlog analysis."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the incident record for access-control and reporting segmentation."
    - name: "involves_minor"
      expr: involves_minor_flag
      comment: "Flag indicating whether the incident involves a minor — critical dimension for child safeguarding compliance reporting."
    - name: "donor_notification_required"
      expr: donor_notification_required_flag
      comment: "Flag indicating whether donor notification is required — used to track compliance obligations."
    - name: "referred_to_authorities"
      expr: referred_to_authorities_flag
      comment: "Flag indicating whether the incident was referred to external authorities."
    - name: "incident_year_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident occurrence for trend analysis over time."
    - name: "reported_year_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month the incident was reported — used to track reporting lag and timeliness trends."
    - name: "closure_reason"
      expr: closure_reason
      comment: "Reason for incident closure — used to assess resolution quality and patterns."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safeguarding incidents recorded. Baseline KPI for incident volume monitoring at executive and operational levels."
    - name: "open_incidents"
      expr: COUNT(CASE WHEN incident_status = 'open' THEN 1 END)
      comment: "Number of currently open incidents. Tracks unresolved caseload — a key operational risk indicator."
    - name: "critical_severity_incidents"
      expr: COUNT(CASE WHEN severity_level = 'critical' THEN 1 END)
      comment: "Count of incidents classified as critical severity. Directly informs escalation decisions and resource allocation."
    - name: "incidents_involving_minors"
      expr: COUNT(CASE WHEN involves_minor_flag = TRUE THEN 1 END)
      comment: "Number of incidents involving minors. Mandatory child safeguarding KPI for board and donor reporting."
    - name: "donor_notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN donor_notification_required_flag = TRUE AND donor_notification_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of incidents requiring donor notification where notification was actually sent. Measures compliance with donor reporting obligations — a critical accountability KPI."
    - name: "authority_referral_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN referred_to_authorities_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents referred to external authorities. Indicates organizational compliance with mandatory reporting requirements."
    - name: "avg_days_to_report"
      expr: AVG(DATEDIFF(reported_date, incident_date))
      comment: "Average number of days between incident occurrence and formal reporting. Measures reporting timeliness — a key safeguarding accountability indicator."
    - name: "avg_days_to_closure"
      expr: AVG(DATEDIFF(closure_date, incident_date))
      comment: "Average number of days from incident occurrence to closure. Measures case resolution speed — informs staffing and process efficiency decisions."
    - name: "minor_involvement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN involves_minor_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all incidents that involve minors. Strategic child protection KPI for board-level safeguarding oversight."
    - name: "distinct_affected_interventions"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct program interventions affected by safeguarding incidents. Measures breadth of safeguarding risk exposure across the program portfolio."
    - name: "distinct_affected_country_offices"
      expr: COUNT(DISTINCT country_office_id)
      comment: "Number of distinct country offices with recorded incidents. Informs geographic risk concentration and resource allocation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for safeguarding investigations — tracks investigation throughput, timeliness, completion rates, and quality indicators to steer accountability and case management performance."
  source: "`vibe_ngo_v1`.`safeguarding`.`investigation`"
  dimensions:
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (e.g. open, in progress, closed) for pipeline monitoring."
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation (e.g. internal, external, joint) for process and resource analysis."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the investigation for access-control segmentation."
    - name: "evidence_collected"
      expr: evidence_collected_flag
      comment: "Flag indicating whether evidence was collected during the investigation — quality indicator."
    - name: "external_referral"
      expr: external_referral_flag
      comment: "Flag indicating whether the investigation was referred externally — tracks escalation patterns."
    - name: "initiation_year_month"
      expr: DATE_TRUNC('MONTH', initiation_date)
      comment: "Month the investigation was initiated — used for trend and cohort analysis."
    - name: "conclusion"
      expr: conclusion
      comment: "Conclusion of the investigation (e.g. substantiated, unsubstantiated) — key outcome dimension for quality and accountability reporting."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of investigations opened. Baseline KPI for investigation workload and accountability system capacity."
    - name: "open_investigations"
      expr: COUNT(CASE WHEN investigation_status = 'open' THEN 1 END)
      comment: "Number of currently open investigations. Tracks active caseload and potential accountability backlog."
    - name: "overdue_investigations"
      expr: COUNT(CASE WHEN investigation_status != 'closed' AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of investigations that have passed their target completion date without closure. Critical operational risk KPI for leadership escalation."
    - name: "on_time_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_completion_date IS NOT NULL AND actual_completion_date <= target_completion_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed investigations finished on or before the target date. Measures investigation process efficiency and accountability system performance."
    - name: "avg_investigation_duration_days"
      expr: AVG(DATEDIFF(actual_completion_date, initiation_date))
      comment: "Average number of days from investigation initiation to actual completion. Informs staffing, process improvement, and survivor experience decisions."
    - name: "external_referral_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN external_referral_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations referred to external bodies. Tracks escalation patterns and compliance with mandatory external reporting obligations."
    - name: "evidence_collection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN evidence_collected_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations where evidence was formally collected. Measures investigation quality and procedural compliance."
    - name: "substantiation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN conclusion = 'substantiated' THEN 1 END) / NULLIF(COUNT(CASE WHEN conclusion IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of concluded investigations with a substantiated finding. Strategic KPI for understanding the severity and credibility of reported incidents."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for safeguarding risk assessments — tracks risk score levels, assessment coverage, overdue reviews, and mitigation status to steer proactive risk management across country offices and program sites."
  source: "`vibe_ngo_v1`.`safeguarding`.`risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g. SEA, child safeguarding, SH) for categorical risk analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (e.g. draft, completed, under review) for pipeline monitoring."
    - name: "overall_risk_level"
      expr: overall_risk_level
      comment: "Overall risk level assigned to the assessment (e.g. low, medium, high, critical) — primary executive risk dimension."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after mitigation measures — indicates effectiveness of safeguarding controls."
    - name: "assessment_year_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the assessment was conducted — used for trend and coverage analysis over time."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office associated with the risk assessment — enables geographic risk concentration analysis."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments conducted. Baseline KPI for safeguarding risk management coverage."
    - name: "high_risk_assessments"
      expr: COUNT(CASE WHEN overall_risk_level IN ('high', 'critical') THEN 1 END)
      comment: "Number of assessments rated high or critical risk. Directly informs resource allocation and escalation decisions."
    - name: "overdue_review_assessments"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND assessment_status != 'closed' THEN 1 END)
      comment: "Number of risk assessments past their scheduled review date. Tracks compliance with review cycles — a governance and accountability KPI."
    - name: "avg_sea_risk_score"
      expr: AVG(CAST(sea_risk_score AS DOUBLE))
      comment: "Average Sexual Exploitation and Abuse (SEA) risk score across assessments. Strategic KPI for monitoring organizational SEA risk exposure."
    - name: "avg_child_safeguarding_risk_score"
      expr: AVG(CAST(child_safeguarding_risk_score AS DOUBLE))
      comment: "Average child safeguarding risk score across assessments. Board-level KPI for child protection risk monitoring."
    - name: "avg_sh_risk_score"
      expr: AVG(CAST(sh_risk_score AS DOUBLE))
      comment: "Average sexual harassment (SH) risk score across assessments. Informs workplace safeguarding policy and HR intervention decisions."
    - name: "max_sea_risk_score"
      expr: MAX(sea_risk_score)
      comment: "Maximum SEA risk score recorded across all assessments. Identifies worst-case risk exposure for executive escalation."
    - name: "high_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_risk_level IN ('high', 'critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments rated high or critical risk. Tracks organizational risk profile trend over time — a key board-level safeguarding KPI."
    - name: "distinct_country_offices_assessed"
      expr: COUNT(DISTINCT country_office_id)
      comment: "Number of distinct country offices with at least one risk assessment. Measures geographic coverage of the safeguarding risk management program."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_focal_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for safeguarding focal points — tracks network coverage, training compliance, and active focal point capacity to ensure adequate safeguarding infrastructure across country offices."
  source: "`vibe_ngo_v1`.`safeguarding`.`focal_point`"
  dimensions:
    - name: "focal_point_type"
      expr: focal_point_type
      comment: "Type of focal point role (e.g. country, regional, global) for network structure analysis."
    - name: "is_active"
      expr: is_active_flag
      comment: "Flag indicating whether the focal point is currently active — used to filter and segment active vs. inactive capacity."
    - name: "training_completed"
      expr: training_completed_flag
      comment: "Flag indicating whether the focal point has completed required safeguarding training — compliance dimension."
    - name: "designation_year_month"
      expr: DATE_TRUNC('MONTH', designation_date)
      comment: "Month the focal point was designated — used for cohort and tenure analysis."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office the focal point is assigned to — enables geographic coverage analysis."
  measures:
    - name: "total_focal_points"
      expr: COUNT(1)
      comment: "Total number of safeguarding focal points on record. Baseline KPI for safeguarding network capacity."
    - name: "active_focal_points"
      expr: COUNT(CASE WHEN is_active_flag = TRUE THEN 1 END)
      comment: "Number of currently active safeguarding focal points. Measures operational safeguarding capacity available to the organization."
    - name: "training_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_completed_flag = TRUE AND is_active_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active focal points who have completed required safeguarding training. Critical compliance KPI for donor reporting and regulatory requirements."
    - name: "untrained_active_focal_points"
      expr: COUNT(CASE WHEN training_completed_flag = FALSE AND is_active_flag = TRUE THEN 1 END)
      comment: "Number of active focal points who have not completed required training. Identifies compliance gaps requiring immediate remediation."
    - name: "distinct_country_offices_covered"
      expr: COUNT(DISTINCT country_office_id)
      comment: "Number of distinct country offices with at least one focal point. Measures geographic coverage of the safeguarding focal point network."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_survivor_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for survivor records — tracks survivor demographics, consent compliance, support status, and safety planning to steer survivor-centred safeguarding response quality."
  source: "`vibe_ngo_v1`.`safeguarding`.`survivor_record`"
  dimensions:
    - name: "sex"
      expr: sex
      comment: "Sex of the survivor — key demographic dimension for gender-disaggregated safeguarding reporting."
    - name: "age_group"
      expr: age_group
      comment: "Age group of the survivor (e.g. child, adolescent, adult) for demographic and child protection analysis."
    - name: "is_minor"
      expr: is_minor_flag
      comment: "Flag indicating whether the survivor is a minor — mandatory child safeguarding dimension."
    - name: "disability_flag"
      expr: disability_flag
      comment: "Flag indicating whether the survivor has a disability — used for inclusive safeguarding response analysis."
    - name: "displacement_status"
      expr: displacement_status
      comment: "Displacement status of the survivor (e.g. IDP, refugee, host community) — contextual vulnerability dimension."
    - name: "support_status"
      expr: support_status
      comment: "Current support status of the survivor (e.g. active, closed, referred) — tracks case management pipeline."
    - name: "consent_obtained"
      expr: consent_obtained_flag
      comment: "Flag indicating whether informed consent was obtained from the survivor — ethical compliance dimension."
    - name: "safety_plan_in_place"
      expr: safety_plan_in_place_flag
      comment: "Flag indicating whether a safety plan is in place for the survivor — measures immediate protection response quality."
    - name: "record_year_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the survivor record was created — used for intake trend analysis."
  measures:
    - name: "total_survivors"
      expr: COUNT(1)
      comment: "Total number of survivor records. Baseline KPI for understanding the scale of safeguarding impact on individuals."
    - name: "minor_survivors"
      expr: COUNT(CASE WHEN is_minor_flag = TRUE THEN 1 END)
      comment: "Number of survivors who are minors. Mandatory child protection KPI for board and donor reporting."
    - name: "consent_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of survivor records where informed consent was obtained. Measures ethical compliance in survivor data management — a critical accountability KPI."
    - name: "safety_plan_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_plan_in_place_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of survivors with a safety plan in place. Measures immediate protection response quality — directly linked to survivor safety outcomes."
    - name: "survivors_without_safety_plan"
      expr: COUNT(CASE WHEN safety_plan_in_place_flag = FALSE OR safety_plan_in_place_flag IS NULL THEN 1 END)
      comment: "Number of survivors without a safety plan. Identifies unprotected survivors requiring urgent intervention — a critical operational risk KPI."
    - name: "active_support_cases"
      expr: COUNT(CASE WHEN support_status = 'active' THEN 1 END)
      comment: "Number of survivors currently receiving active support. Measures current caseload and resource demand for survivor support services."
    - name: "minor_survivor_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_minor_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all survivors who are minors. Strategic child protection KPI for executive and board-level safeguarding oversight."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_psea_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for PSEA policies — tracks policy currency, compliance framework coverage, mandatory training requirements, and review cycle adherence to ensure organizational safeguarding policy governance."
  source: "`vibe_ngo_v1`.`safeguarding`.`psea_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the PSEA policy (e.g. active, expired, under review) — primary governance dimension."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework the policy aligns to (e.g. UN PSEA, CHS) — used for regulatory alignment analysis."
    - name: "mandatory_training_required"
      expr: mandatory_training_flag
      comment: "Flag indicating whether the policy mandates training — used to track training obligation coverage."
    - name: "whistleblower_protection"
      expr: whistleblower_protection_flag
      comment: "Flag indicating whether the policy includes whistleblower protection provisions — governance quality indicator."
    - name: "zero_tolerance_statement"
      expr: zero_tolerance_statement_flag
      comment: "Flag indicating whether the policy includes a zero-tolerance statement — measures policy strength and alignment with best practice."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the policy became effective — used for policy vintage and currency analysis."
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of PSEA policies on record. Baseline KPI for policy portfolio size."
    - name: "active_policies"
      expr: COUNT(CASE WHEN policy_status = 'active' THEN 1 END)
      comment: "Number of currently active PSEA policies. Measures operational policy coverage — a governance accountability KPI."
    - name: "expired_policies"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND policy_status != 'superseded' THEN 1 END)
      comment: "Number of policies that have passed their expiry date. Identifies governance gaps requiring immediate remediation — a compliance risk KPI."
    - name: "overdue_review_policies"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND policy_status = 'active' THEN 1 END)
      comment: "Number of active policies past their scheduled review date. Tracks policy governance compliance — informs board-level accountability decisions."
    - name: "whistleblower_protection_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN whistleblower_protection_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN policy_status = 'active' THEN 1 END), 0), 2)
      comment: "Percentage of active policies that include whistleblower protection. Measures policy quality and alignment with international safeguarding standards."
    - name: "zero_tolerance_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN zero_tolerance_statement_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN policy_status = 'active' THEN 1 END), 0), 2)
      comment: "Percentage of active policies containing a zero-tolerance statement. Strategic governance KPI for board and donor accountability reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_survivor_support_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for survivor support plans — tracks plan coverage, review timeliness, priority distribution, and outcome quality to steer survivor-centred case management performance."
  source: "`vibe_ngo_v1`.`safeguarding`.`survivor_support_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the support plan (e.g. active, completed, suspended) — primary case management dimension."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the support plan (e.g. low, medium, high, urgent) — used for caseload prioritization analysis."
    - name: "review_frequency"
      expr: review_frequency
      comment: "Scheduled review frequency of the support plan — used to assess case management intensity."
    - name: "plan_start_year_month"
      expr: DATE_TRUNC('MONTH', plan_start_date)
      comment: "Month the support plan was initiated — used for intake trend and cohort analysis."
  measures:
    - name: "total_support_plans"
      expr: COUNT(1)
      comment: "Total number of survivor support plans. Baseline KPI for survivor case management volume."
    - name: "active_support_plans"
      expr: COUNT(CASE WHEN plan_status = 'active' THEN 1 END)
      comment: "Number of currently active survivor support plans. Measures current case management workload and resource demand."
    - name: "overdue_review_plans"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND plan_status = 'active' THEN 1 END)
      comment: "Number of active support plans past their scheduled review date. Identifies survivors at risk of inadequate follow-up — a critical case management quality KPI."
    - name: "high_priority_plans"
      expr: COUNT(CASE WHEN priority_level IN ('high', 'urgent') THEN 1 END)
      comment: "Number of support plans classified as high or urgent priority. Informs resource allocation and escalation decisions for the most vulnerable survivors."
    - name: "plan_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of support plans that have been completed. Measures case management throughput and survivor journey completion rate."
    - name: "avg_plan_duration_days"
      expr: AVG(DATEDIFF(plan_end_date, plan_start_date))
      comment: "Average duration of survivor support plans in days. Informs resource planning and benchmarking of case management intensity."
    - name: "overdue_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND plan_status = 'active' THEN 1 END) / NULLIF(COUNT(CASE WHEN plan_status = 'active' THEN 1 END), 0), 2)
      comment: "Percentage of active support plans that are overdue for review. Strategic quality KPI — high rates indicate systemic case management failures requiring leadership intervention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`safeguarding_reporting_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for safeguarding reporting channels — tracks channel availability, anonymity and confidentiality coverage, and accessibility to ensure survivors and witnesses have adequate, safe reporting mechanisms."
  source: "`vibe_ngo_v1`.`safeguarding`.`reporting_channel`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Type of reporting channel (e.g. hotline, email, in-person, online form) for channel mix analysis."
    - name: "channel_status"
      expr: channel_status
      comment: "Current operational status of the channel (e.g. active, inactive) — used to assess available reporting infrastructure."
    - name: "is_anonymous"
      expr: is_anonymous_flag
      comment: "Flag indicating whether the channel supports anonymous reporting — critical for survivor safety and willingness to report."
    - name: "is_confidential"
      expr: is_confidential_flag
      comment: "Flag indicating whether the channel guarantees confidentiality — key trust and safety dimension."
    - name: "country_office_id"
      expr: country_office_id
      comment: "Country office the reporting channel serves — enables geographic coverage analysis."
  measures:
    - name: "total_reporting_channels"
      expr: COUNT(1)
      comment: "Total number of safeguarding reporting channels. Baseline KPI for reporting infrastructure capacity."
    - name: "active_reporting_channels"
      expr: COUNT(CASE WHEN channel_status = 'active' THEN 1 END)
      comment: "Number of currently active reporting channels. Measures operational reporting infrastructure available to survivors and witnesses."
    - name: "anonymous_channel_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_anonymous_flag = TRUE AND channel_status = 'active' THEN 1 END) / NULLIF(COUNT(CASE WHEN channel_status = 'active' THEN 1 END), 0), 2)
      comment: "Percentage of active channels that support anonymous reporting. Measures the organization's commitment to safe, barrier-free reporting — a key survivor protection KPI."
    - name: "confidential_channel_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_confidential_flag = TRUE AND channel_status = 'active' THEN 1 END) / NULLIF(COUNT(CASE WHEN channel_status = 'active' THEN 1 END), 0), 2)
      comment: "Percentage of active channels that guarantee confidentiality. Informs trust and safety infrastructure quality — directly linked to reporting rates."
    - name: "distinct_country_offices_with_channels"
      expr: COUNT(DISTINCT country_office_id)
      comment: "Number of distinct country offices with at least one reporting channel. Measures geographic coverage of the safeguarding reporting infrastructure."
$$;