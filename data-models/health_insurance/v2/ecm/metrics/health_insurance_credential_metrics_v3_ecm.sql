-- Metric views for domain: credential | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider credentialing application metrics tracking submission volume, cycle time, approval rates, and urgency patterns for network adequacy and compliance monitoring."
  source: "`vibe_health_insurance_v1`.`credential`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the credentialing application (submitted, under review, approved, denied, etc.)"
    - name: "application_type"
      expr: application_type
      comment: "Type of credentialing application (initial, recredential, reappointment, etc.)"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the application (approved, denied, withdrawn, etc.)"
    - name: "committee_decision"
      expr: committee_decision
      comment: "Credentialing committee decision outcome"
    - name: "is_delegated"
      expr: is_delegated
      comment: "Whether credentialing was delegated to a CVO or other entity"
    - name: "is_urgent"
      expr: is_urgent
      comment: "Whether the application was flagged as urgent due to clinical need"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the application was submitted (portal, email, fax, etc.)"
    - name: "credentialing_cycle_year"
      expr: credentialing_cycle_year
      comment: "Year of the credentialing cycle for trend analysis"
    - name: "ncqa_cycle"
      expr: ncqa_cycle
      comment: "NCQA credentialing cycle identifier for accreditation compliance"
    - name: "primary_psv_status"
      expr: primary_psv_status
      comment: "Primary source verification status (complete, pending, failed, etc.)"
    - name: "sanction_screening_status"
      expr: sanction_screening_status
      comment: "Status of OIG/SAM/state sanction screening"
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month of application submission for trend analysis"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month of credentialing decision for cycle time analysis"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of credentialing applications submitted"
    - name: "unique_providers_applying"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of providers with credentialing applications"
    - name: "avg_cycle_time_days"
      expr: AVG(DATEDIFF(decision_date, application_date))
      comment: "Average number of days from application submission to credentialing decision"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications approved out of all applications with a decision"
    - name: "urgent_application_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_urgent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications flagged as urgent, indicating network capacity pressure"
    - name: "delegation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_delegated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications delegated to CVOs or other entities"
    - name: "psv_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN primary_psv_status = 'complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications with completed primary source verification"
    - name: "sanction_screening_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sanction_screening_status = 'clear' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications passing OIG/SAM sanction screening"
    - name: "applications_requiring_additional_docs"
      expr: SUM(CASE WHEN requires_additional_documents = TRUE THEN 1 ELSE 0 END)
      comment: "Count of applications requiring additional documentation, indicating incomplete submissions"
    - name: "malpractice_flag_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN malpractice_history_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications with malpractice history flags requiring committee review"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_committee_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing committee review metrics tracking decision outcomes, compliance flags, and committee efficiency for governance and regulatory oversight."
  source: "`vibe_health_insurance_v1`.`credential`.`committee_review`"
  dimensions:
    - name: "committee_review_status"
      expr: committee_review_status
      comment: "Status of the committee review (scheduled, completed, deferred, etc.)"
    - name: "review_type"
      expr: review_type
      comment: "Type of committee review (initial, recredential, appeal, expedited, etc.)"
    - name: "decision_type"
      expr: decision_type
      comment: "Type of credentialing decision made by the committee"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized code for denial reason when application is denied"
    - name: "quorum_indicator"
      expr: quorum_indicator
      comment: "Whether the committee meeting had quorum for valid decision-making"
    - name: "compliance_flag_state_license_valid"
      expr: compliance_flag_state_license_valid
      comment: "Whether the provider's state license was valid at time of review"
    - name: "compliance_flag_dea_valid"
      expr: compliance_flag_dea_valid
      comment: "Whether the provider's DEA license was valid at time of review"
    - name: "compliance_flag_malpractice_history"
      expr: compliance_flag_malpractice_history
      comment: "Whether the provider had malpractice history requiring review"
    - name: "compliance_flag_oig_sanction"
      expr: compliance_flag_oig_sanction
      comment: "Whether the provider had OIG sanctions or exclusions"
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', meeting_timestamp)
      comment: "Month of committee meeting for trend analysis"
  measures:
    - name: "total_committee_reviews"
      expr: COUNT(1)
      comment: "Total number of credentialing committee reviews conducted"
    - name: "unique_providers_reviewed"
      expr: COUNT(DISTINCT record_id)
      comment: "Distinct count of provider credentialing records reviewed by committee"
    - name: "avg_decision_cycle_days"
      expr: AVG(DATEDIFF(decision_effective_date, meeting_timestamp))
      comment: "Average days from committee meeting to decision effective date"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN decision_type = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of committee reviews resulting in approval"
    - name: "denial_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN decision_type = 'denied' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of committee reviews resulting in denial"
    - name: "quorum_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quorum_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of committee meetings with valid quorum for regulatory compliance"
    - name: "license_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag_state_license_valid = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with valid state licenses at time of review"
    - name: "dea_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag_dea_valid = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with valid DEA licenses at time of review"
    - name: "oig_sanction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag_oig_sanction = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with OIG sanctions or exclusions flagged"
    - name: "malpractice_flag_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag_malpractice_history = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with malpractice history requiring committee review"
    - name: "appeal_rights_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_rights_notification_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse decisions with documented appeal rights notification for due process compliance"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing appeal metrics tracking appeal volume, outcomes, cycle time, and escalation patterns for due process compliance and quality assurance."
  source: "`vibe_health_insurance_v1`.`credential`.`credential_appeal`"
  dimensions:
    - name: "credential_appeal_status"
      expr: credential_appeal_status
      comment: "Current status of the credentialing appeal (submitted, under review, resolved, etc.)"
    - name: "credential_appeal_type"
      expr: credential_appeal_type
      comment: "Type of credentialing appeal (denial, suspension, termination, etc.)"
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Final outcome of the appeal (upheld, overturned, modified, etc.)"
    - name: "original_decision_type"
      expr: original_decision_type
      comment: "Type of original credentialing decision being appealed"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the appeal was escalated to higher authority or external review"
    - name: "hearing_panel_type"
      expr: hearing_panel_type
      comment: "Type of hearing panel convened for the appeal"
    - name: "outcome_reason"
      expr: outcome_reason
      comment: "Reason for the appeal outcome decision"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of appeal submission for trend analysis"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month of appeal decision for cycle time analysis"
  measures:
    - name: "total_appeals"
      expr: COUNT(1)
      comment: "Total number of credentialing appeals submitted"
    - name: "unique_providers_appealing"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of providers filing credentialing appeals"
    - name: "avg_appeal_cycle_days"
      expr: AVG(DATEDIFF(decision_date, submission_timestamp))
      comment: "Average number of days from appeal submission to final decision"
    - name: "overturn_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN decision_outcome = 'overturned' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals resulting in overturned original decisions, indicating potential quality issues"
    - name: "upheld_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN decision_outcome = 'upheld' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals where original decision was upheld"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals escalated to higher authority or external review"
    - name: "hearing_convened_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hearing_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals requiring formal hearing, indicating complexity or contentiousness"
    - name: "total_appeal_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total appeal processing fees collected"
    - name: "avg_appeal_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average appeal processing fee per appeal"
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN DATEDIFF(decision_date, submission_timestamp) > DATEDIFF(review_deadline, submission_timestamp) THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals exceeding review deadline SLA, indicating process efficiency issues"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider credentialing record metrics tracking credential status, expiration risk, recredentialing cycles, and compliance flags for network adequacy and regulatory oversight."
  source: "`vibe_health_insurance_v1`.`credential`.`record`"
  dimensions:
    - name: "credential_status"
      expr: credential_status
      comment: "Current status of the provider credential (active, expired, suspended, revoked, etc.)"
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential (initial, recredential, provisional, etc.)"
    - name: "credential_tier"
      expr: credential_tier
      comment: "Tier or level of credentialing (standard, expedited, etc.)"
    - name: "credentialing_committee_outcome"
      expr: credentialing_committee_outcome
      comment: "Outcome of credentialing committee review"
    - name: "delegated_credential_flag"
      expr: delegated_credential_flag
      comment: "Whether credentialing was delegated to a CVO or other entity"
    - name: "ncqa_compliance_flag"
      expr: ncqa_compliance_flag
      comment: "Whether the credential meets NCQA compliance standards"
    - name: "sanctions_screened_flag"
      expr: sanctions_screened_flag
      comment: "Whether the provider has been screened for OIG/SAM sanctions"
    - name: "malpractice_history_flag"
      expr: malpractice_history_flag
      comment: "Whether the provider has malpractice history on record"
    - name: "hospital_privileges_flag"
      expr: hospital_privileges_flag
      comment: "Whether the provider has hospital privileges verified"
    - name: "credential_expiration_reason"
      expr: credential_expiration_reason
      comment: "Reason for credential expiration or termination"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when credential became effective"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month when credential expires for renewal planning"
  measures:
    - name: "total_credential_records"
      expr: COUNT(1)
      comment: "Total number of provider credentialing records"
    - name: "unique_credentialed_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of providers with credentialing records"
    - name: "active_credential_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN credential_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credentials currently active, indicating network capacity"
    - name: "expired_credential_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN credential_status = 'expired' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credentials expired, indicating network attrition risk"
    - name: "suspended_credential_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN credential_status = 'suspended' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credentials suspended, indicating quality or compliance issues"
    - name: "revoked_credential_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN credential_status = 'revoked' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credentials revoked, indicating serious quality or compliance failures"
    - name: "ncqa_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ncqa_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credentials meeting NCQA compliance standards for accreditation"
    - name: "sanction_screening_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sanctions_screened_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers screened for OIG/SAM sanctions for regulatory compliance"
    - name: "malpractice_history_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN malpractice_history_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with malpractice history, indicating potential quality risk"
    - name: "delegation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN delegated_credential_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credentials delegated to CVOs or other entities"
    - name: "avg_credential_duration_days"
      expr: AVG(DATEDIFF(expiration_date, effective_date))
      comment: "Average duration of credential validity period in days"
    - name: "credentials_expiring_within_90_days"
      expr: SUM(CASE WHEN DATEDIFF(expiration_date, CURRENT_DATE()) <= 90 AND DATEDIFF(expiration_date, CURRENT_DATE()) > 0 THEN 1 ELSE 0 END)
      comment: "Count of credentials expiring within 90 days requiring proactive renewal"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_recredential_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recredentialing cycle metrics tracking renewal volume, cycle time, escalation patterns, and outreach effectiveness for continuous network adequacy."
  source: "`vibe_health_insurance_v1`.`credential`.`recredential_cycle`"
  dimensions:
    - name: "cycle_status"
      expr: cycle_status
      comment: "Current status of the recredentialing cycle (initiated, in progress, completed, overdue, etc.)"
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of recredentialing cycle (standard, expedited, etc.)"
    - name: "cycle_priority"
      expr: cycle_priority
      comment: "Priority level of the recredentialing cycle"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the recredentialing cycle has been escalated due to delays or non-response"
    - name: "cycle_start_month"
      expr: DATE_TRUNC('MONTH', cycle_start_date)
      comment: "Month when recredentialing cycle started"
    - name: "cycle_due_month"
      expr: DATE_TRUNC('MONTH', cycle_due_date)
      comment: "Month when recredentialing cycle is due for completion"
  measures:
    - name: "total_recredential_cycles"
      expr: COUNT(1)
      comment: "Total number of recredentialing cycles initiated"
    - name: "unique_providers_recredentialing"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of providers undergoing recredentialing"
    - name: "avg_cycle_duration_days"
      expr: AVG(DATEDIFF(cycle_completion_date, cycle_start_date))
      comment: "Average number of days to complete recredentialing cycle"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cycle_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recredentialing cycles completed"
    - name: "overdue_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cycle_status = 'overdue' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recredentialing cycles overdue, indicating process bottlenecks"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recredentialing cycles escalated due to delays or non-response"
    - name: "avg_outreach_attempts"
      expr: AVG(CAST(outreach_attempt_count AS DOUBLE))
      comment: "Average number of outreach attempts per recredentialing cycle"
    - name: "on_time_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cycle_completion_date <= cycle_due_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN cycle_completion_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of recredentialing cycles completed on or before due date"
    - name: "avg_days_to_first_outreach"
      expr: AVG(DATEDIFF(last_outreach_date, cycle_start_date))
      comment: "Average days from cycle start to first outreach attempt"
    - name: "application_received_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN application_received_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recredentialing cycles where provider application was received"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_sanction_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanction screening metrics tracking OIG/SAM exclusion checks, hit rates, resolution time, and compliance for regulatory risk mitigation."
  source: "`vibe_health_insurance_v1`.`credential`.`sanction_screening`"
  dimensions:
    - name: "overall_status"
      expr: overall_status
      comment: "Overall status of sanction screening (clear, flagged, under review, etc.)"
    - name: "screening_result"
      expr: screening_result
      comment: "Result of sanction screening (no match, match found, etc.)"
    - name: "screening_event_type"
      expr: screening_event_type
      comment: "Type of screening event (initial, monthly, ad-hoc, etc.)"
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction found (OIG exclusion, state license action, etc.)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of sanction or exclusion"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of sanction resolution (pending, resolved, escalated, etc.)"
    - name: "impact_on_credential_status"
      expr: impact_on_credential_status
      comment: "Impact of sanction on provider credential status"
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_timestamp)
      comment: "Month of sanction screening for trend analysis"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of sanction screenings performed"
    - name: "unique_providers_screened"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of providers screened for sanctions"
    - name: "sanction_hit_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN screening_result = 'match found' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings resulting in sanction matches, indicating network quality risk"
    - name: "clear_screening_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN overall_status = 'clear' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings with no sanctions found"
    - name: "avg_resolution_days"
      expr: AVG(DATEDIFF(last_review_timestamp, screening_timestamp))
      comment: "Average number of days to resolve sanction screening findings"
    - name: "unresolved_sanction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_status = 'pending' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sanction findings still pending resolution, indicating compliance risk"
    - name: "high_severity_sanction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN severity_level = 'high' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings with high-severity sanctions requiring immediate action"
    - name: "credential_impact_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN impact_on_credential_status IS NOT NULL AND impact_on_credential_status != 'none' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sanction findings impacting provider credential status"
    - name: "monthly_screening_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN screening_event_type = 'monthly' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings performed on monthly schedule for regulatory compliance"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_delegation_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CVO delegation audit metrics tracking audit volume, compliance rates, corrective action requirements, and oversight effectiveness for delegated credentialing quality assurance."
  source: "`vibe_health_insurance_v1`.`credential`.`delegation_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the delegation audit (scheduled, in progress, completed, etc.)"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of delegation audit (annual, focused, follow-up, etc.)"
    - name: "audit_disposition"
      expr: audit_disposition
      comment: "Final disposition of the audit (satisfactory, deficiencies noted, etc.)"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required based on audit findings"
    - name: "audit_year"
      expr: audit_year
      comment: "Year of the delegation audit for trend analysis"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month of delegation audit for trend analysis"
  measures:
    - name: "total_delegation_audits"
      expr: COUNT(1)
      comment: "Total number of delegation audits performed"
    - name: "unique_delegated_entities_audited"
      expr: COUNT(DISTINCT delegated_entity_id)
      comment: "Distinct count of delegated entities (CVOs) audited"
    - name: "avg_overall_compliance_rate_pct"
      expr: AVG(CAST(overall_compliance_rate AS DOUBLE))
      comment: "Average overall compliance rate across all delegation audits"
    - name: "satisfactory_audit_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN audit_disposition = 'satisfactory' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delegation audits with satisfactory disposition"
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delegation audits requiring corrective action, indicating quality issues"
    - name: "avg_files_reviewed"
      expr: AVG(CAST(files_reviewed_count AS DOUBLE))
      comment: "Average number of credentialing files reviewed per delegation audit"
    - name: "avg_audit_cycle_days"
      expr: AVG(DATEDIFF(audit_period_end, audit_period_start))
      comment: "Average duration of audit period in days"
    - name: "avg_corrective_action_turnaround_days"
      expr: AVG(DATEDIFF(corrective_action_due_date, audit_date))
      comment: "Average days allowed for corrective action completion"
    - name: "overdue_corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE AND corrective_action_due_date < CURRENT_DATE() THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of required corrective actions past due date, indicating oversight risk"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_expedited_credential`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expedited credentialing metrics tracking urgent provider onboarding, provisional approval rates, clinical justification patterns, and conversion to full credentials for network capacity management."
  source: "`vibe_health_insurance_v1`.`credential`.`expedited_credential`"
  dimensions:
    - name: "expedited_credential_status"
      expr: expedited_credential_status
      comment: "Current status of the expedited credentialing request"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Level of urgency for expedited credentialing (critical, high, standard, etc.)"
    - name: "expedited_reason_code"
      expr: expedited_reason_code
      comment: "Standardized code for reason expedited credentialing was requested"
    - name: "final_credentialing_outcome"
      expr: final_credentialing_outcome
      comment: "Final outcome of expedited credentialing (approved, denied, converted to standard, etc.)"
    - name: "attestation_received"
      expr: attestation_received
      comment: "Whether provider attestation was received for expedited credentialing"
    - name: "psv_verification_flag"
      expr: psv_verification_flag
      comment: "Whether primary source verification was completed for expedited credentialing"
    - name: "malpractice_history_flag"
      expr: malpractice_history_flag
      comment: "Whether provider has malpractice history flagged during expedited review"
    - name: "sanction_screening_flag"
      expr: sanction_screening_flag
      comment: "Whether sanction screening was completed for expedited credentialing"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month of expedited credentialing request for trend analysis"
  measures:
    - name: "total_expedited_requests"
      expr: COUNT(1)
      comment: "Total number of expedited credentialing requests submitted"
    - name: "unique_providers_expedited"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of providers requesting expedited credentialing"
    - name: "avg_expedited_cycle_days"
      expr: AVG(DATEDIFF(outcome_date, request_timestamp))
      comment: "Average number of days to complete expedited credentialing process"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN final_credentialing_outcome = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited credentialing requests approved"
    - name: "critical_urgency_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN urgency_level = 'critical' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited requests marked as critical urgency, indicating network capacity pressure"
    - name: "attestation_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN attestation_received = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited requests with provider attestation received"
    - name: "psv_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN psv_verification_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited requests with completed primary source verification"
    - name: "sanction_screening_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sanction_screening_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited requests with completed sanction screening"
    - name: "avg_provisional_duration_days"
      expr: AVG(CAST(provisional_duration_days AS DOUBLE))
      comment: "Average duration of provisional credentialing period in days"
    - name: "total_provisional_fees"
      expr: SUM(CAST(provisional_fee_amount AS DOUBLE))
      comment: "Total provisional credentialing fees collected"
    - name: "malpractice_flag_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN malpractice_history_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited requests with malpractice history flags"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_npdb_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NPDB query metrics tracking query volume, report hit rates, malpractice amounts, and processing time for practitioner data bank compliance and risk assessment."
  source: "`vibe_health_insurance_v1`.`credential`.`npdb_query`"
  dimensions:
    - name: "npdb_query_status"
      expr: npdb_query_status
      comment: "Status of the NPDB query (submitted, completed, failed, etc.)"
    - name: "query_type"
      expr: query_type
      comment: "Type of NPDB query (initial, continuous, ad-hoc, etc.)"
    - name: "is_continuous_enrollment"
      expr: is_continuous_enrollment
      comment: "Whether the provider is enrolled in continuous NPDB monitoring"
    - name: "hcqia_compliance_flag"
      expr: hcqia_compliance_flag
      comment: "Whether the query meets HCQIA compliance requirements"
    - name: "internal_review_disposition"
      expr: internal_review_disposition
      comment: "Internal review disposition of NPDB findings"
    - name: "query_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of NPDB query submission for trend analysis"
  measures:
    - name: "total_npdb_queries"
      expr: COUNT(1)
      comment: "Total number of NPDB queries submitted"
    - name: "unique_providers_queried"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct count of providers queried in NPDB"
    - name: "avg_query_processing_seconds"
      expr: AVG(CAST(report_processing_time_seconds AS DOUBLE))
      comment: "Average processing time for NPDB queries in seconds"
    - name: "report_hit_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(number_of_reports AS INT) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NPDB queries returning one or more reports, indicating potential quality risk"
    - name: "avg_reports_per_query"
      expr: AVG(CAST(number_of_reports AS DOUBLE))
      comment: "Average number of NPDB reports returned per query"
    - name: "total_malpractice_amount"
      expr: SUM(CAST(total_malpractice_amount AS DOUBLE))
      comment: "Total malpractice payment amounts reported in NPDB queries"
    - name: "avg_malpractice_amount_per_hit"
      expr: AVG(CAST(total_malpractice_amount AS DOUBLE))
      comment: "Average malpractice payment amount per NPDB query with reports"
    - name: "continuous_enrollment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_continuous_enrollment = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers enrolled in continuous NPDB monitoring for ongoing risk management"
    - name: "hcqia_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hcqia_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NPDB queries meeting HCQIA compliance requirements"
    - name: "avg_query_turnaround_days"
      expr: AVG(DATEDIFF(response_timestamp, submission_timestamp))
      comment: "Average days from NPDB query submission to response receipt"
$$;