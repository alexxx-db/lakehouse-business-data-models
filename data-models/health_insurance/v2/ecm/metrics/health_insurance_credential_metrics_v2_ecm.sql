-- Metric views for domain: credential | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider credentialing application lifecycle metrics tracking application volume, cycle time, approval rates, and delegated entity performance"
  source: "`vibe_health_insurance_v1`.`credential`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the credentialing application (e.g., Submitted, Under Review, Approved, Denied)"
    - name: "application_type"
      expr: application_type
      comment: "Type of credentialing application (e.g., Initial, Recredential, Expedited)"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the application (e.g., Approved, Denied, Withdrawn)"
    - name: "credentialing_cycle_year"
      expr: credentialing_cycle_year
      comment: "Year of the credentialing cycle for trend analysis"
    - name: "is_delegated"
      expr: is_delegated
      comment: "Whether the application is processed by a delegated credentialing entity"
    - name: "is_urgent"
      expr: is_urgent
      comment: "Whether the application is flagged as urgent/expedited"
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month when the application was submitted for time-series analysis"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month when the credentialing decision was made"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the application was submitted (e.g., Portal, Email, Fax)"
    - name: "sanction_screening_status"
      expr: sanction_screening_status
      comment: "Status of sanction screening for the application"
    - name: "malpractice_history_flag"
      expr: malpractice_history_flag
      comment: "Whether the provider has a malpractice history"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of credentialing applications submitted"
    - name: "unique_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Number of unique providers with credentialing applications"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications approved out of all applications with a final disposition"
    - name: "avg_cycle_time_days"
      expr: AVG(DATEDIFF(decision_date, application_date))
      comment: "Average number of days from application submission to decision"
    - name: "delegated_application_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_delegated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications processed through delegated credentialing entities"
    - name: "urgent_application_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_urgent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications flagged as urgent or expedited"
    - name: "malpractice_flag_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN malpractice_history_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications with malpractice history flags"
    - name: "applications_requiring_additional_docs"
      expr: SUM(CASE WHEN requires_additional_documents = TRUE THEN 1 ELSE 0 END)
      comment: "Number of applications requiring additional documentation"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_credentialing_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks credentialing application pipeline health, throughput, and quality — key operational KPIs for credentialing leadership to monitor cycle efficiency, approval rates, and compliance posture."
  source: "`vibe_health_insurance_v1`.`credential`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the credentialing application (e.g. Pending, Approved, Denied) — primary grouping for pipeline analysis."
    - name: "application_type"
      expr: application_type
      comment: "Type of credentialing application (initial, recredentialing, expedited) — drives workload segmentation."
    - name: "credentialing_cycle_year"
      expr: credentialing_cycle_year
      comment: "The credentialing cycle year — enables year-over-year trend analysis."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the application was submitted (paper, portal, delegated) — informs channel efficiency."
    - name: "is_delegated"
      expr: is_delegated
      comment: "Whether the application is processed under a delegation arrangement — critical for delegation oversight reporting."
    - name: "is_urgent"
      expr: is_urgent
      comment: "Whether the application was flagged as urgent — used to prioritize expedited processing queues."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the application (approved, denied, withdrawn) — used for outcome analysis."
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month the application was submitted — enables monthly volume and trend reporting."
    - name: "primary_psv_status"
      expr: primary_psv_status
      comment: "Primary source verification status — indicates readiness for committee review."
    - name: "sanction_screening_status"
      expr: sanction_screening_status
      comment: "Sanction screening result — compliance gate for credentialing approval."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of credentialing applications submitted — baseline volume KPI for capacity planning and throughput monitoring."
    - name: "approved_applications"
      expr: COUNT(CASE WHEN application_status = 'Approved' THEN 1 END)
      comment: "Count of applications with Approved status — numerator for approval rate calculation."
    - name: "denied_applications"
      expr: COUNT(CASE WHEN application_status = 'Denied' THEN 1 END)
      comment: "Count of denied applications — tracks denial volume for quality and compliance review."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN application_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications approved — key quality KPI; low rates signal credentialing pipeline issues or provider quality concerns."
    - name: "sanction_flagged_applications"
      expr: COUNT(CASE WHEN sanction_screening_status NOT IN ('Clear', 'Passed') AND sanction_screening_status IS NOT NULL THEN 1 END)
      comment: "Applications with non-clear sanction screening results — compliance risk indicator requiring immediate leadership attention."
    - name: "malpractice_history_flagged_count"
      expr: COUNT(CASE WHEN malpractice_history_flag = TRUE THEN 1 END)
      comment: "Applications where provider has a malpractice history — risk management KPI for credentialing committee oversight."
    - name: "requires_additional_docs_count"
      expr: COUNT(CASE WHEN requires_additional_documents = TRUE THEN 1 END)
      comment: "Applications pending additional documentation — operational bottleneck metric driving outreach prioritization."
    - name: "hospital_privileges_verified_count"
      expr: COUNT(CASE WHEN hospital_privileges_verified = TRUE THEN 1 END)
      comment: "Applications where hospital privileges have been verified — PSV completion rate indicator."
    - name: "delegated_application_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_delegated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications processed under delegation — tracks delegation program utilization and oversight exposure."
    - name: "urgent_application_count"
      expr: COUNT(CASE WHEN is_urgent = TRUE THEN 1 END)
      comment: "Count of urgent/expedited applications — operational load metric for expedited credentialing queue management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_committee_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures credentialing committee review outcomes, compliance flag rates, and decision quality — essential for NCQA compliance and governance reporting."
  source: "`vibe_health_insurance_v1`.`credential`.`committee_review`"
  dimensions:
    - name: "committee_review_status"
      expr: committee_review_status
      comment: "Current status of the committee review (Pending, Complete, Deferred) — primary pipeline grouping."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of committee decision (Approve, Deny, Defer, Conditional) — outcome classification for governance reporting."
    - name: "review_type"
      expr: review_type
      comment: "Type of review (Initial, Recredentialing, Focused) — drives workload segmentation."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for denial decisions — enables root cause analysis of denial patterns."
    - name: "decision_month"
      expr: DATE_TRUNC('month', decision_effective_date)
      comment: "Month the committee decision became effective — enables trend analysis of decision throughput."
    - name: "quorum_indicator"
      expr: quorum_indicator
      comment: "Whether quorum was achieved for the review — NCQA compliance requirement tracking."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total committee reviews conducted — baseline throughput KPI for committee capacity planning."
    - name: "approval_decisions"
      expr: COUNT(CASE WHEN decision_type = 'Approve' THEN 1 END)
      comment: "Count of approval decisions — numerator for committee approval rate."
    - name: "denial_decisions"
      expr: COUNT(CASE WHEN decision_type = 'Deny' THEN 1 END)
      comment: "Count of denial decisions — tracks denial volume for quality oversight."
    - name: "committee_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_type = 'Approve' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in approval — key governance KPI; significant drops trigger quality investigation."
    - name: "oig_sanction_flagged_reviews"
      expr: COUNT(CASE WHEN compliance_flag_oig_sanction = TRUE THEN 1 END)
      comment: "Reviews where OIG sanction flag was raised — critical compliance KPI; any positive flags require immediate escalation."
    - name: "state_license_invalid_reviews"
      expr: COUNT(CASE WHEN compliance_flag_state_license_valid = FALSE THEN 1 END)
      comment: "Reviews where state license was found invalid — compliance risk indicator for credentialing integrity."
    - name: "dea_invalid_reviews"
      expr: COUNT(CASE WHEN compliance_flag_dea_valid = FALSE THEN 1 END)
      comment: "Reviews where DEA license was found invalid — regulatory compliance KPI for controlled substance prescribing oversight."
    - name: "malpractice_history_flagged_reviews"
      expr: COUNT(CASE WHEN compliance_flag_malpractice_history = TRUE THEN 1 END)
      comment: "Reviews with malpractice history flags — risk management KPI for provider quality oversight."
    - name: "compliance_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag_oig_sanction = TRUE OR compliance_flag_state_license_valid = FALSE OR compliance_flag_dea_valid = FALSE OR compliance_flag_malpractice_history = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews with at least one compliance flag — composite compliance risk rate for executive dashboard."
    - name: "quorum_achieved_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quorum_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews where quorum was achieved — NCQA-required governance metric; below threshold triggers corrective action."
    - name: "distinct_providers_reviewed"
      expr: COUNT(DISTINCT record_id)
      comment: "Count of distinct credentialing records reviewed — measures breadth of committee review coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks credentialing appeal volume, outcomes, and escalation rates — governance KPI for due process compliance and provider relations management."
  source: "`vibe_health_insurance_v1`.`credential`.`credential_appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the credentialing appeal (Pending, Resolved, Escalated) — primary pipeline grouping."
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of credentialing appeal (denial, suspension, termination) — drives appeal program analysis."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Outcome of the appeal decision (Upheld, Overturned, Modified) — key governance metric."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the appeal was escalated — identifies high-risk appeals requiring senior review."
    - name: "hearing_panel_type"
      expr: hearing_panel_type
      comment: "Type of hearing panel convened — governance process classification."
    - name: "appeal_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the appeal was initiated — enables monthly appeal volume trending."
    - name: "original_decision_type"
      expr: original_decision_type
      comment: "Type of original credentialing decision being appealed — root cause analysis dimension."
  measures:
    - name: "total_appeals"
      expr: COUNT(1)
      comment: "Total credentialing appeals filed — baseline volume KPI for due process program monitoring."
    - name: "overturned_decisions"
      expr: COUNT(CASE WHEN decision_outcome = 'Overturned' THEN 1 END)
      comment: "Count of appeals resulting in overturned decisions — quality KPI; high rates signal initial decision quality issues."
    - name: "overturn_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_outcome = 'Overturned' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals resulting in overturned decisions — credentialing decision quality KPI; rising rates trigger process review."
    - name: "escalated_appeal_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of escalated appeals — high-priority governance risk metric requiring leadership attention."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals that were escalated — due process risk KPI for credentialing governance."
    - name: "total_appeal_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees associated with credentialing appeals — financial impact KPI for credentialing program cost management."
    - name: "avg_appeal_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee per credentialing appeal — cost benchmarking metric for appeal program financial management."
    - name: "distinct_providers_appealing"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of distinct providers who filed appeals — measures appeal program utilization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors credentialing lifecycle event volume, escalation rates, and compliance flags — operational intelligence for credentialing program management and audit readiness."
  source: "`vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of credentialing lifecycle event (status change, expiration, renewal) — primary event classification."
    - name: "event_category"
      expr: event_category
      comment: "Category of the lifecycle event — groups related events for trend analysis."
    - name: "new_status"
      expr: new_status
      comment: "New credential status after the event — tracks status transition patterns."
    - name: "prior_status"
      expr: prior_status
      comment: "Prior credential status before the event — enables transition matrix analysis."
    - name: "is_escalated"
      expr: is_escalated
      comment: "Whether the event was escalated — identifies high-priority credentialing issues."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the event is flagged as critical — drives prioritization of credentialing interventions."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the event has a compliance flag — regulatory risk indicator."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month the lifecycle event occurred — enables monthly event volume trending."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the event — data governance and access control dimension."
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(1)
      comment: "Total credentialing lifecycle events — baseline activity volume for operational monitoring."
    - name: "escalated_event_count"
      expr: COUNT(CASE WHEN is_escalated = TRUE THEN 1 END)
      comment: "Count of escalated lifecycle events — operational risk KPI requiring management attention."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_escalated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lifecycle events that were escalated — program health KPI; rising rates indicate systemic credentialing issues."
    - name: "critical_event_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of critical lifecycle events — high-priority compliance and risk management KPI."
    - name: "compliance_flagged_event_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Count of lifecycle events with compliance flags — regulatory risk inventory for audit readiness."
    - name: "compliance_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lifecycle events with compliance flags — composite compliance risk rate for credentialing program governance."
    - name: "distinct_providers_with_events"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of distinct providers with lifecycle events — measures breadth of credentialing activity across the provider network."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing outreach metrics tracking communication volume, response rates, SLA adherence, and outreach effectiveness to optimize provider engagement during the credentialing process."
  source: "`vibe_health_insurance_v1`.`credential`.`credential_outreach`"
  dimensions:
    - name: "credential_outreach_status"
      expr: credential_outreach_status
      comment: "Current status of the outreach attempt."
    - name: "outreach_type"
      expr: outreach_type
      comment: "Type of outreach (e.g., Document Request, Follow-up, Reminder)."
    - name: "outreach_method"
      expr: outreach_method
      comment: "Method of outreach (e.g., Email, Phone, Fax, Mail)."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the outreach attempt (e.g., Responded, No Response, Partial)."
    - name: "priority"
      expr: priority
      comment: "Priority level of the outreach."
    - name: "sla_met"
      expr: CAST(sla_met AS STRING)
      comment: "Whether the outreach SLA was met."
    - name: "outreach_year_month"
      expr: DATE_TRUNC('month', outreach_timestamp)
      comment: "Month of outreach for trend analysis."
  measures:
    - name: "total_outreach_attempts"
      expr: COUNT(1)
      comment: "Total outreach attempts — measures communication volume and provider engagement effort."
    - name: "distinct_providers_contacted"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers contacted — measures outreach coverage."
    - name: "response_received_count"
      expr: COUNT(CASE WHEN response_received_date IS NOT NULL THEN 1 END)
      comment: "Outreach attempts that received a response — measures provider responsiveness."
    - name: "response_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN response_received_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach attempts receiving a response — provider engagement effectiveness metric."
    - name: "sla_met_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach attempts meeting SLA targets — operational timeliness and compliance metric."
    - name: "avg_response_time_days"
      expr: AVG(CAST(DATEDIFF(response_received_date, CAST(outreach_timestamp AS DATE)) AS DOUBLE))
      comment: "Average days from outreach to provider response — measures provider engagement speed."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_delegated_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delegated entity metrics tracking delegation program size, compliance posture, audit readiness, and NCQA accreditation status for oversight of outsourced credentialing functions."
  source: "`vibe_health_insurance_v1`.`credential`.`delegated_entity`"
  dimensions:
    - name: "delegated_entity_status"
      expr: delegated_entity_status
      comment: "Current status of the delegated entity (e.g., Active, Terminated, Under Review)."
    - name: "delegation_type"
      expr: delegation_type
      comment: "Type of delegation arrangement (e.g., Full, Partial)."
    - name: "delegation_scope"
      expr: delegation_scope
      comment: "Scope of delegated credentialing activities."
    - name: "ncqa_accreditation_status"
      expr: ncqa_accreditation_status
      comment: "NCQA accreditation status of the delegated entity."
    - name: "audit_result"
      expr: audit_result
      comment: "Result of the most recent oversight audit."
    - name: "organization_name"
      expr: organization_name
      comment: "Name of the delegated credentialing organization."
  measures:
    - name: "total_delegated_entities"
      expr: COUNT(1)
      comment: "Total delegated entities — measures delegation program scope and oversight burden."
    - name: "active_delegated_entities"
      expr: COUNT(CASE WHEN delegated_entity_status = 'Active' THEN 1 END)
      comment: "Number of currently active delegated entities."
    - name: "ncqa_accredited_count"
      expr: COUNT(CASE WHEN ncqa_accreditation_status = 'Accredited' THEN 1 END)
      comment: "Delegated entities with NCQA accreditation — quality assurance indicator."
    - name: "ncqa_accreditation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncqa_accreditation_status = 'Accredited' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delegated entities with NCQA accreditation — delegation quality and compliance readiness metric."
    - name: "overdue_audit_count"
      expr: COUNT(CASE WHEN last_audit_date IS NOT NULL AND DATEDIFF(CURRENT_DATE(), last_audit_date) > 365 THEN 1 END)
      comment: "Delegated entities with audits older than 12 months — oversight compliance gap indicator."
    - name: "terminated_entity_count"
      expr: COUNT(CASE WHEN delegated_entity_status = 'Terminated' THEN 1 END)
      comment: "Number of terminated delegated entities — monitors delegation program churn and risk events."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_delegation_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks delegation oversight audit outcomes, compliance rates, and corrective action requirements — essential for NCQA delegation oversight program compliance."
  source: "`vibe_health_insurance_v1`.`credential`.`delegation_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the delegation audit (Scheduled, In Progress, Complete) — pipeline grouping."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of delegation audit (initial, annual oversight, for-cause) — drives audit program analysis."
    - name: "audit_disposition"
      expr: audit_disposition
      comment: "Final disposition of the audit (Pass, Fail, Conditional) — outcome classification for governance reporting."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required — compliance risk flag for delegation oversight."
    - name: "audit_year"
      expr: audit_year
      comment: "Year of the audit — enables year-over-year delegation compliance trend analysis."
    - name: "audit_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month the audit was conducted — enables monthly audit throughput reporting."
  measures:
    - name: "total_delegation_audits"
      expr: COUNT(1)
      comment: "Total delegation audits conducted — baseline oversight activity volume."
    - name: "failed_audits"
      expr: COUNT(CASE WHEN audit_disposition = 'Fail' THEN 1 END)
      comment: "Count of failed delegation audits — critical compliance KPI; failures require immediate corrective action plans."
    - name: "audit_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_disposition = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delegation audits passed — NCQA delegation oversight KPI; below threshold triggers delegation agreement review."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of audits requiring corrective action — open compliance risk inventory for delegation oversight program."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action — delegation quality KPI; rising rates signal systemic delegated entity performance issues."
    - name: "avg_overall_compliance_rate"
      expr: AVG(CAST(overall_compliance_rate AS DOUBLE))
      comment: "Average compliance rate across delegation audits — composite quality score for delegated credentialing entities."
    - name: "distinct_delegated_entities_audited"
      expr: COUNT(DISTINCT delegated_entity_id)
      comment: "Count of distinct delegated entities audited — measures delegation oversight program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_expedited_credential`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expedited credentialing performance metrics tracking expedited request volume, approval rates, provisional period utilization, and urgency justification"
  source: "`vibe_health_insurance_v1`.`credential`.`expedited_credential`"
  dimensions:
    - name: "expedited_credential_status"
      expr: expedited_credential_status
      comment: "Current status of the expedited credentialing request (e.g., Approved, Denied, Pending)"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the expedited request (e.g., Critical, High, Medium)"
    - name: "expedited_reason_code"
      expr: expedited_reason_code
      comment: "Reason code for the expedited credentialing request (e.g., Clinical Urgency, Network Gap, Locum Coverage)"
    - name: "final_credentialing_outcome"
      expr: final_credentialing_outcome
      comment: "Final outcome of the full credentialing process after provisional period (e.g., Approved, Denied, Withdrawn)"
    - name: "psv_verification_flag"
      expr: psv_verification_flag
      comment: "Whether primary source verification was completed for the expedited credential"
    - name: "sanction_screening_flag"
      expr: sanction_screening_flag
      comment: "Whether sanction screening was completed for the expedited credential"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month when the expedited credentialing request was submitted"
  measures:
    - name: "total_expedited_requests"
      expr: COUNT(1)
      comment: "Total number of expedited credentialing requests submitted"
    - name: "unique_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Number of unique providers with expedited credentialing requests"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN expedited_credential_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited credentialing requests that were approved"
    - name: "final_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN final_credentialing_outcome = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited credentials that achieved final approval after provisional period"
    - name: "psv_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN psv_verification_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited credentials with completed primary source verification"
    - name: "sanction_screening_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sanction_screening_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited credentials with completed sanction screening"
    - name: "avg_provisional_duration_days"
      expr: AVG(CAST(provisional_duration_days AS DOUBLE))
      comment: "Average duration in days of the provisional credentialing period"
    - name: "total_provisional_fees"
      expr: SUM(CAST(provisional_fee_amount AS DOUBLE))
      comment: "Total provisional credentialing fees collected across all expedited requests"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_npdb_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors NPDB query activity, report findings, and malpractice exposure — mandatory regulatory compliance KPIs for health plan credentialing programs under HCQIA."
  source: "`vibe_health_insurance_v1`.`credential`.`npdb_query`"
  dimensions:
    - name: "npdb_query_status"
      expr: npdb_query_status
      comment: "Current status of the NPDB query (Submitted, Responded, Pending) — pipeline monitoring dimension."
    - name: "query_type"
      expr: query_type
      comment: "Type of NPDB query (initial credentialing, recredentialing, continuous enrollment) — compliance program classification."
    - name: "is_continuous_enrollment"
      expr: is_continuous_enrollment
      comment: "Whether the query is part of continuous enrollment monitoring — distinguishes ongoing vs. point-in-time queries."
    - name: "hcqia_compliance_flag"
      expr: hcqia_compliance_flag
      comment: "Whether the query meets HCQIA compliance requirements — regulatory compliance gate."
    - name: "internal_review_disposition"
      expr: internal_review_disposition
      comment: "Internal disposition of NPDB report findings — drives credentialing action decisions."
    - name: "query_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month the NPDB query was submitted — enables monthly query volume trending."
  measures:
    - name: "total_npdb_queries"
      expr: COUNT(1)
      comment: "Total NPDB queries submitted — baseline HCQIA compliance activity volume."
    - name: "queries_with_reports"
      expr: COUNT(CASE WHEN CAST(number_of_reports AS INT) > 0 THEN 1 END)
      comment: "Count of NPDB queries that returned one or more reports — compliance risk indicator for provider quality review."
    - name: "hcqia_compliant_query_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hcqia_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NPDB queries meeting HCQIA compliance requirements — regulatory compliance KPI; below 100% triggers immediate remediation."
    - name: "total_malpractice_exposure"
      expr: SUM(CAST(total_malpractice_amount AS DOUBLE))
      comment: "Total malpractice payment amounts identified across NPDB queries — aggregate financial risk exposure metric for network quality management."
    - name: "avg_malpractice_amount_per_query"
      expr: AVG(CAST(total_malpractice_amount AS DOUBLE))
      comment: "Average malpractice payment amount per NPDB query — benchmarking metric for provider risk profiling."
    - name: "distinct_providers_queried"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of distinct providers with NPDB queries — measures HCQIA compliance program coverage."
    - name: "continuous_enrollment_query_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_continuous_enrollment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of queries using continuous enrollment monitoring — measures adoption of proactive NPDB monitoring vs. point-in-time queries."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_obligation_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks credentialing regulatory obligation fulfillment rates, evidence receipt, and compliance gaps — essential for regulatory compliance program management and audit readiness."
  source: "`vibe_health_insurance_v1`.`credential`.`obligation_mapping`"
  dimensions:
    - name: "mapping_status_code"
      expr: mapping_status_code
      comment: "Status code of the obligation mapping (Active, Fulfilled, Overdue) — primary compliance status grouping."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (NCQA, state licensure, CMS) — regulatory framework classification."
    - name: "mapping_type"
      expr: mapping_type
      comment: "Type of obligation mapping (direct, delegated, shared) — governance structure dimension."
    - name: "evidence_received_flag"
      expr: evidence_received_flag
      comment: "Whether evidence of compliance has been received — compliance gate indicator."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the obligation (Met, Unmet, Partial) — compliance outcome grouping."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority mandating the obligation (CMS, NCQA, state DOI) — enables authority-level compliance reporting."
    - name: "next_due_month"
      expr: DATE_TRUNC('month', next_due_date)
      comment: "Month the obligation is next due — enables forward-looking compliance calendar management."
  measures:
    - name: "total_obligation_mappings"
      expr: COUNT(1)
      comment: "Total regulatory obligation mappings — baseline compliance program scope metric."
    - name: "fulfilled_obligations"
      expr: COUNT(CASE WHEN fulfillment_status = 'Met' THEN 1 END)
      comment: "Count of fulfilled regulatory obligations — numerator for compliance fulfillment rate."
    - name: "unfulfilled_obligations"
      expr: COUNT(CASE WHEN fulfillment_status = 'Unmet' THEN 1 END)
      comment: "Count of unfulfilled regulatory obligations — open compliance risk inventory requiring remediation."
    - name: "obligation_fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'Met' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory obligations fulfilled — composite compliance KPI for executive and regulatory reporting."
    - name: "evidence_receipt_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN evidence_received_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligation mappings with evidence received — audit readiness KPI; below threshold triggers evidence collection campaigns."
    - name: "required_obligation_count"
      expr: COUNT(CASE WHEN required_flag = TRUE THEN 1 END)
      comment: "Count of mandatory regulatory obligations — scope of required compliance activities."
    - name: "distinct_records_with_obligations"
      expr: COUNT(DISTINCT record_id)
      comment: "Count of distinct credentialing records with obligation mappings — measures compliance program coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_psv_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors primary source verification (PSV) completion, element-level pass rates, and malpractice insurance adequacy — core NCQA credentialing compliance metrics."
  source: "`vibe_health_insurance_v1`.`credential`.`psv_verification`"
  dimensions:
    - name: "verification_result"
      expr: verification_result
      comment: "Result of the PSV verification (Verified, Failed, Pending) — primary outcome grouping."
    - name: "credential_element_type"
      expr: credential_element_type
      comment: "Type of credential element being verified (license, DEA, board cert, malpractice) — enables element-level pass rate analysis."
    - name: "element_category"
      expr: element_category
      comment: "Category of the credential element — groups related verification types for reporting."
    - name: "element_status"
      expr: element_status
      comment: "Current status of the credential element (Active, Expired, Suspended) — compliance gate indicator."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for verification (direct source, CAQH, NPDB) — efficiency and cost analysis dimension."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the credential — enables source-level verification analysis."
    - name: "verification_month"
      expr: DATE_TRUNC('month', verification_date)
      comment: "Month verification was completed — enables monthly PSV throughput trending."
  measures:
    - name: "total_psv_verifications"
      expr: COUNT(1)
      comment: "Total PSV verification events — baseline throughput KPI for credentialing operations."
    - name: "verified_elements"
      expr: COUNT(CASE WHEN verification_result = 'Verified' THEN 1 END)
      comment: "Count of successfully verified credential elements — numerator for PSV pass rate."
    - name: "failed_verifications"
      expr: COUNT(CASE WHEN verification_result = 'Failed' THEN 1 END)
      comment: "Count of failed PSV verifications — compliance risk indicator requiring follow-up action."
    - name: "psv_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_result = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PSV verifications that passed — NCQA compliance KPI; below threshold triggers credentialing program review."
    - name: "expired_elements_count"
      expr: COUNT(CASE WHEN element_status = 'Expired' THEN 1 END)
      comment: "Count of expired credential elements identified during PSV — network risk indicator for provider participation eligibility."
    - name: "total_malpractice_insurance_limit"
      expr: SUM(CAST(malpractice_insurance_limit AS DOUBLE))
      comment: "Sum of malpractice insurance limits across verified providers — aggregate risk exposure metric for network adequacy assessment."
    - name: "avg_malpractice_insurance_limit"
      expr: AVG(CAST(malpractice_insurance_limit AS DOUBLE))
      comment: "Average malpractice insurance limit per verification record — benchmarking metric for minimum coverage adequacy standards."
    - name: "distinct_providers_psv_verified"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of distinct providers with PSV verifications — measures PSV program coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider credential record lifecycle metrics tracking credential status, expiration risk, recredentialing cycles, and compliance flags"
  source: "`vibe_health_insurance_v1`.`credential`.`record`"
  dimensions:
    - name: "credential_status"
      expr: credential_status
      comment: "Current status of the credential record (e.g., Active, Expired, Suspended, Revoked)"
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential (e.g., Medical License, Board Certification, DEA Registration)"
    - name: "credential_tier"
      expr: credential_tier
      comment: "Tier or level of the credential (e.g., Tier 1, Tier 2, Specialty)"
    - name: "delegated_credential_flag"
      expr: delegated_credential_flag
      comment: "Whether the credential is managed by a delegated credentialing entity"
    - name: "ncqa_compliance_flag"
      expr: ncqa_compliance_flag
      comment: "Whether the credential meets NCQA compliance standards"
    - name: "sanctions_screened_flag"
      expr: sanctions_screened_flag
      comment: "Whether the provider has been screened for sanctions"
    - name: "malpractice_history_flag"
      expr: malpractice_history_flag
      comment: "Whether the provider has a malpractice history"
    - name: "hospital_privileges_flag"
      expr: hospital_privileges_flag
      comment: "Whether the provider has hospital privileges"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when the credential became effective"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month when the credential expires"
  measures:
    - name: "total_credential_records"
      expr: COUNT(1)
      comment: "Total number of credential records in the system"
    - name: "unique_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Number of unique providers with credential records"
    - name: "active_credential_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN credential_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credential records with active status"
    - name: "expired_credential_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN credential_status = 'Expired' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credential records that have expired"
    - name: "suspended_credential_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN credential_status = 'Suspended' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credential records that are suspended"
    - name: "ncqa_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ncqa_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credential records meeting NCQA compliance standards"
    - name: "sanction_screening_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sanctions_screened_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers who have been screened for sanctions"
    - name: "malpractice_history_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN malpractice_history_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with malpractice history"
    - name: "hospital_privileges_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hospital_privileges_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with hospital privileges"
    - name: "delegated_credential_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN delegated_credential_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credentials managed by delegated credentialing entities"
    - name: "avg_malpractice_claims_count"
      expr: AVG(CAST(malpractice_claims_count AS DOUBLE))
      comment: "Average number of malpractice claims per provider credential record"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_recredential_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors recredentialing cycle completion rates, escalation rates, and SLA adherence — critical for NCQA compliance and provider network continuity."
  source: "`vibe_health_insurance_v1`.`credential`.`recredential_cycle`"
  dimensions:
    - name: "cycle_status"
      expr: cycle_status
      comment: "Current status of the recredentialing cycle (Active, Complete, Overdue) — primary operational grouping."
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of recredentialing cycle (standard 3-year, focused, expedited) — drives workload segmentation."
    - name: "cycle_priority"
      expr: cycle_priority
      comment: "Priority level of the cycle — used to triage high-risk recredentialing cases."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the cycle has been escalated — identifies at-risk providers requiring intervention."
    - name: "cycle_due_month"
      expr: DATE_TRUNC('month', cycle_due_date)
      comment: "Month the recredentialing cycle is due — enables forward-looking capacity planning."
    - name: "cycle_start_year"
      expr: DATE_TRUNC('year', cycle_start_date)
      comment: "Year the cycle started — enables cohort-based completion rate analysis."
  measures:
    - name: "total_recredential_cycles"
      expr: COUNT(1)
      comment: "Total recredentialing cycles in the system — baseline volume for capacity and workload planning."
    - name: "completed_cycles"
      expr: COUNT(CASE WHEN cycle_status = 'Complete' THEN 1 END)
      comment: "Count of completed recredentialing cycles — numerator for completion rate."
    - name: "overdue_cycles"
      expr: COUNT(CASE WHEN cycle_status = 'Overdue' THEN 1 END)
      comment: "Count of overdue recredentialing cycles — critical compliance KPI; overdue cycles risk NCQA deficiency findings."
    - name: "cycle_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cycle_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recredentialing cycles completed — NCQA compliance KPI; below 95% triggers regulatory risk."
    - name: "escalated_cycle_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycles that have been escalated — operational risk indicator for credentialing leadership."
    - name: "avg_outreach_attempts"
      expr: AVG(CAST(outreach_attempt_count AS DOUBLE))
      comment: "Average number of outreach attempts per recredentialing cycle — efficiency KPI; high averages indicate provider non-responsiveness."
    - name: "distinct_providers_in_cycle"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of distinct providers with active recredentialing cycles — network coverage metric for credentialing program scope."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_sanction_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks sanction screening outcomes, severity distribution, and compliance posture across providers and vendors — a critical regulatory compliance KPI for health plan credentialing programs."
  source: "`vibe_health_insurance_v1`.`credential`.`sanction_screening`"
  dimensions:
    - name: "screening_result"
      expr: screening_result
      comment: "Result of the sanction screening (Clear, Match, Pending) — primary outcome grouping."
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction identified (OIG exclusion, state board action, DEA revocation) — drives regulatory response."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the sanction finding — used to prioritize remediation actions."
    - name: "screening_event_type"
      expr: screening_event_type
      comment: "Type of screening event (initial, monthly, triggered) — enables frequency-based compliance analysis."
    - name: "overall_status"
      expr: overall_status
      comment: "Overall screening status — used for dashboard-level compliance posture reporting."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of identified sanctions — tracks remediation progress."
    - name: "screening_month"
      expr: DATE_TRUNC('month', screening_timestamp)
      comment: "Month the screening was conducted — enables monthly compliance trend analysis."
    - name: "impact_on_credential_status"
      expr: impact_on_credential_status
      comment: "How the sanction impacts the provider credential status — direct link to network participation decisions."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total sanction screenings conducted — baseline compliance activity volume."
    - name: "sanction_match_count"
      expr: COUNT(CASE WHEN screening_result = 'Match' THEN 1 END)
      comment: "Count of screenings with a sanction match — critical compliance KPI; any matches require immediate credentialing action."
    - name: "sanction_match_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN screening_result = 'Match' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings resulting in a sanction match — network integrity KPI; rising rates signal provider quality deterioration."
    - name: "unresolved_sanction_count"
      expr: COUNT(CASE WHEN resolution_status NOT IN ('Resolved', 'Closed') AND resolution_status IS NOT NULL THEN 1 END)
      comment: "Count of sanctions not yet resolved — open compliance risk inventory requiring leadership attention."
    - name: "distinct_providers_screened"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of distinct providers screened — measures breadth of sanction screening program coverage."
    - name: "high_severity_sanction_count"
      expr: COUNT(CASE WHEN severity_level IN ('High', 'Critical') THEN 1 END)
      comment: "Count of high or critical severity sanction findings — top-priority compliance risk metric for executive escalation."
    - name: "credential_impact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN impact_on_credential_status IS NOT NULL AND impact_on_credential_status != 'None' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings that impacted credential status — measures the downstream effect of sanction screening on network participation."
$$;
