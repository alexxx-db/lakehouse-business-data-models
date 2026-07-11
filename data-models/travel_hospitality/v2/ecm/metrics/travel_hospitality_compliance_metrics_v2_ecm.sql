-- Metric views for domain: compliance | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:24:18

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit program performance metrics tracking audit execution, findings, costs, and compliance outcomes across properties and audit types"
  source: "`vibe_travel_hospitality_v1`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (internal, external, regulatory, certification)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (scheduled, in-progress, completed, follow-up required)"
    - name: "overall_audit_result"
      expr: overall_audit_result
      comment: "Overall audit outcome (pass, fail, conditional pass, certification awarded)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned based on audit findings (low, medium, high, critical)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework or standard audited against (ISO, SOC2, PCI-DSS, local regulations)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction where audit applies"
    - name: "auditor_organization"
      expr: auditor_organization
      comment: "Organization conducting the audit"
    - name: "certification_level"
      expr: certification_level
      comment: "Level of certification awarded if applicable"
    - name: "scheduled_year"
      expr: YEAR(scheduled_date)
      comment: "Year audit was scheduled"
    - name: "scheduled_quarter"
      expr: CONCAT('Q', QUARTER(scheduled_date))
      comment: "Quarter audit was scheduled"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month audit was scheduled"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required
      comment: "Whether corrective actions are required"
    - name: "certification_awarded_flag"
      expr: certification_awarded
      comment: "Whether certification was awarded"
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required
      comment: "Whether follow-up audit is required"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted"
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of audits conducted"
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per audit"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total number of critical findings across all audits"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Total number of major findings across all audits"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS DOUBLE))
      comment: "Total number of minor findings across all audits"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score"
    - name: "audits_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits requiring corrective action"
    - name: "audits_with_certification"
      expr: SUM(CASE WHEN certification_awarded = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits resulting in certification"
    - name: "audits_requiring_followup"
      expr: SUM(CASE WHEN follow_up_audit_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits requiring follow-up"
    - name: "distinct_properties_audited"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties audited"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding remediation metrics tracking finding severity, closure rates, financial impact, and regulatory reporting requirements"
  source: "`vibe_travel_hospitality_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (open, in-progress, closed, escalated)"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (operational, financial, safety, compliance)"
    - name: "compliance_domain"
      expr: compliance_domain
      comment: "Compliance domain affected (data privacy, health & safety, financial, environmental)"
    - name: "root_cause_classification"
      expr: root_cause_classification
      comment: "Root cause classification (process gap, training gap, system failure, human error)"
    - name: "regulatory_standard_violated"
      expr: regulatory_standard_violated
      comment: "Regulatory standard that was violated"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether finding has been escalated"
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Whether this is a repeat finding"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required"
    - name: "guest_impact_flag"
      expr: guest_impact_flag
      comment: "Whether finding impacts guests"
    - name: "external_auditor_flag"
      expr: external_auditor_flag
      comment: "Whether finding was identified by external auditor"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year finding was identified"
    - name: "identified_quarter"
      expr: CONCAT('Q', QUARTER(identified_date))
      comment: "Quarter finding was identified"
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month finding was identified"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of findings"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average financial impact per finding"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across findings"
    - name: "findings_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of findings requiring corrective action"
    - name: "escalated_findings"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of escalated findings"
    - name: "repeat_findings"
      expr: SUM(CASE WHEN repeat_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of repeat findings"
    - name: "findings_requiring_regulatory_reporting"
      expr: SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of findings requiring regulatory reporting"
    - name: "guest_impacting_findings"
      expr: SUM(CASE WHEN guest_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of findings impacting guests"
    - name: "external_auditor_findings"
      expr: SUM(CASE WHEN external_auditor_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of findings identified by external auditors"
    - name: "closed_findings"
      expr: SUM(CASE WHEN finding_status = 'closed' THEN 1 ELSE 0 END)
      comment: "Number of closed findings"
    - name: "distinct_audits_with_findings"
      expr: COUNT(DISTINCT audit_id)
      comment: "Number of distinct audits with findings"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and preventive action (CAPA) effectiveness metrics tracking action completion, cost, timeliness, and recurrence prevention"
  source: "`vibe_travel_hospitality_v1`.`compliance`.`corrective_action`"
  dimensions:
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of corrective action (planned, in-progress, completed, verified, overdue)"
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective, preventive, both)"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category (regulatory, operational, safety, quality)"
    - name: "priority"
      expr: priority
      comment: "Priority level (low, medium, high, critical)"
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department assigned to execute corrective action"
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "Effectiveness rating after review (ineffective, partially effective, effective, highly effective)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework requiring the action"
    - name: "escalation_required_flag"
      expr: escalation_required
      comment: "Whether escalation is required"
    - name: "recurrence_detected_flag"
      expr: recurrence_detected
      comment: "Whether recurrence of the issue has been detected"
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required"
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year of target completion date"
    - name: "target_completion_quarter"
      expr: CONCAT('Q', QUARTER(target_completion_date))
      comment: "Quarter of target completion date"
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month of target completion date"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of corrective actions"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective actions"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per corrective action"
    - name: "completed_actions"
      expr: SUM(CASE WHEN corrective_action_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Number of completed corrective actions"
    - name: "overdue_actions"
      expr: SUM(CASE WHEN corrective_action_status = 'overdue' THEN 1 ELSE 0 END)
      comment: "Number of overdue corrective actions"
    - name: "actions_requiring_escalation"
      expr: SUM(CASE WHEN escalation_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of actions requiring escalation"
    - name: "actions_with_recurrence"
      expr: SUM(CASE WHEN recurrence_detected = TRUE THEN 1 ELSE 0 END)
      comment: "Number of actions where issue recurrence was detected"
    - name: "actions_requiring_regulatory_notification"
      expr: SUM(CASE WHEN regulatory_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of actions requiring regulatory notification"
    - name: "distinct_audit_findings_addressed"
      expr: COUNT(DISTINCT audit_finding_id)
      comment: "Number of distinct audit findings addressed"
    - name: "distinct_properties_with_actions"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with corrective actions"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit and license management metrics tracking permit status, renewal timeliness, fees, violations, and regulatory compliance"
  source: "`vibe_travel_hospitality_v1`.`compliance`.`permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (business license, health permit, liquor license, building permit, environmental permit)"
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of permit (active, expired, suspended, revoked, pending renewal)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction issuing the permit"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority issuing the permit"
    - name: "holder_type"
      expr: holder_type
      comment: "Type of permit holder (property, legal entity, individual)"
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether inspection is required for this permit"
    - name: "inspection_frequency"
      expr: inspection_frequency
      comment: "Frequency of required inspections"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year permit was issued"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year permit expires"
    - name: "expiration_quarter"
      expr: CONCAT('Q', QUARTER(expiration_date))
      comment: "Quarter permit expires"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month permit expires"
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits"
    - name: "total_permit_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fees paid"
    - name: "total_renewal_fees"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees paid"
    - name: "avg_permit_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average permit fee"
    - name: "avg_renewal_fee"
      expr: AVG(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Average renewal fee"
    - name: "total_violations"
      expr: SUM(CAST(violation_count AS DOUBLE))
      comment: "Total number of permit violations"
    - name: "active_permits"
      expr: SUM(CASE WHEN permit_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of active permits"
    - name: "expired_permits"
      expr: SUM(CASE WHEN permit_status = 'expired' THEN 1 ELSE 0 END)
      comment: "Number of expired permits"
    - name: "suspended_permits"
      expr: SUM(CASE WHEN permit_status = 'suspended' THEN 1 ELSE 0 END)
      comment: "Number of suspended permits"
    - name: "revoked_permits"
      expr: SUM(CASE WHEN permit_status = 'revoked' THEN 1 ELSE 0 END)
      comment: "Number of revoked permits"
    - name: "permits_requiring_inspection"
      expr: SUM(CASE WHEN inspection_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of permits requiring inspection"
    - name: "distinct_properties_with_permits"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with permits"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_health_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health and safety incident metrics tracking incident frequency, severity, OSHA recordability, workers compensation, and regulatory reporting"
  source: "`vibe_travel_hospitality_v1`.`compliance`.`health_safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident (slip/fall, burn, cut, exposure, ergonomic, violence, other)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of incident (reported, under investigation, closed, pending regulatory review)"
    - name: "injury_severity"
      expr: injury_severity
      comment: "Severity of injury (first aid, medical treatment, lost time, fatality)"
    - name: "person_type_involved"
      expr: person_type_involved
      comment: "Type of person involved (employee, guest, contractor, vendor)"
    - name: "location_within_property"
      expr: location_within_property
      comment: "Location within property where incident occurred"
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether incident is OSHA recordable"
    - name: "medical_treatment_provided_flag"
      expr: medical_treatment_provided_flag
      comment: "Whether medical treatment was provided"
    - name: "workers_compensation_claim_flag"
      expr: workers_compensation_claim_flag
      comment: "Whether workers compensation claim was filed"
    - name: "liability_claim_filed_flag"
      expr: liability_claim_filed_flag
      comment: "Whether liability claim was filed"
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification is required"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year incident occurred"
    - name: "incident_quarter"
      expr: CONCAT('Q', QUARTER(incident_date))
      comment: "Quarter incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month incident occurred"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of health and safety incidents"
    - name: "total_days_away_from_work"
      expr: SUM(CAST(days_away_from_work AS DOUBLE))
      comment: "Total days away from work due to incidents"
    - name: "total_restricted_work_days"
      expr: SUM(CAST(restricted_work_days AS DOUBLE))
      comment: "Total restricted work days due to incidents"
    - name: "avg_days_away_from_work"
      expr: AVG(CAST(days_away_from_work AS DOUBLE))
      comment: "Average days away from work per incident"
    - name: "avg_restricted_work_days"
      expr: AVG(CAST(restricted_work_days AS DOUBLE))
      comment: "Average restricted work days per incident"
    - name: "osha_recordable_incidents"
      expr: SUM(CASE WHEN osha_recordable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of OSHA recordable incidents"
    - name: "incidents_with_medical_treatment"
      expr: SUM(CASE WHEN medical_treatment_provided_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents requiring medical treatment"
    - name: "workers_comp_claims"
      expr: SUM(CASE WHEN workers_compensation_claim_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of workers compensation claims filed"
    - name: "liability_claims"
      expr: SUM(CASE WHEN liability_claim_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of liability claims filed"
    - name: "incidents_requiring_regulatory_notification"
      expr: SUM(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents requiring regulatory notification"
    - name: "lost_time_incidents"
      expr: SUM(CASE WHEN injury_severity = 'lost time' THEN 1 ELSE 0 END)
      comment: "Number of lost time incidents"
    - name: "fatality_incidents"
      expr: SUM(CASE WHEN injury_severity = 'fatality' THEN 1 ELSE 0 END)
      comment: "Number of fatality incidents"
    - name: "distinct_properties_with_incidents"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with incidents"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy and data breach incident metrics tracking breach notification, subject impact, regulatory penalties, and remediation effectiveness"
  source: "`vibe_travel_hospitality_v1`.`compliance`.`privacy_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of privacy incident (unauthorized access, data loss, improper disclosure, ransomware, phishing)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of incident (reported, under investigation, contained, remediated, closed)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of incident (low, medium, high, critical)"
    - name: "discovery_method"
      expr: discovery_method
      comment: "How incident was discovered (internal audit, user report, automated monitoring, external notification)"
    - name: "data_categories_affected"
      expr: data_categories_affected
      comment: "Categories of data affected (PII, financial, health, credentials)"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of investigation (pending, in-progress, completed)"
    - name: "breach_notification_required_flag"
      expr: breach_notification_required_flag
      comment: "Whether breach notification is required"
    - name: "subject_notification_required_flag"
      expr: subject_notification_required_flag
      comment: "Whether data subject notification is required"
    - name: "dpo_notified_flag"
      expr: dpo_notified_flag
      comment: "Whether Data Protection Officer was notified"
    - name: "legal_counsel_engaged_flag"
      expr: legal_counsel_engaged_flag
      comment: "Whether legal counsel was engaged"
    - name: "regulatory_penalty_imposed_flag"
      expr: regulatory_penalty_imposed_flag
      comment: "Whether regulatory penalty was imposed"
    - name: "litigation_filed_flag"
      expr: litigation_filed_flag
      comment: "Whether litigation was filed"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year incident occurred"
    - name: "incident_quarter"
      expr: CONCAT('Q', QUARTER(incident_date))
      comment: "Quarter incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month incident occurred"
  measures:
    - name: "total_privacy_incidents"
      expr: COUNT(1)
      comment: "Total number of privacy incidents"
    - name: "total_estimated_subjects_affected"
      expr: SUM(CAST(estimated_subjects_affected AS DOUBLE))
      comment: "Total estimated data subjects affected"
    - name: "total_confirmed_subjects_affected"
      expr: SUM(CAST(confirmed_subjects_affected AS DOUBLE))
      comment: "Total confirmed data subjects affected"
    - name: "total_regulatory_penalties"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total regulatory penalties imposed"
    - name: "avg_estimated_subjects_affected"
      expr: AVG(CAST(estimated_subjects_affected AS DOUBLE))
      comment: "Average estimated subjects affected per incident"
    - name: "avg_regulatory_penalty"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average regulatory penalty per incident"
    - name: "incidents_requiring_breach_notification"
      expr: SUM(CASE WHEN breach_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents requiring breach notification"
    - name: "incidents_requiring_subject_notification"
      expr: SUM(CASE WHEN subject_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents requiring data subject notification"
    - name: "incidents_with_dpo_notification"
      expr: SUM(CASE WHEN dpo_notified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents where DPO was notified"
    - name: "incidents_with_legal_counsel"
      expr: SUM(CASE WHEN legal_counsel_engaged_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents with legal counsel engaged"
    - name: "incidents_with_regulatory_penalty"
      expr: SUM(CASE WHEN regulatory_penalty_imposed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents with regulatory penalty imposed"
    - name: "incidents_with_litigation"
      expr: SUM(CASE WHEN litigation_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents with litigation filed"
    - name: "critical_severity_incidents"
      expr: SUM(CASE WHEN severity_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Number of critical severity incidents"
    - name: "distinct_properties_with_incidents"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with privacy incidents"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_policy_acknowledgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy acknowledgment and training compliance metrics tracking acknowledgment rates, timeliness, escalations, and re-acknowledgment requirements"
  source: "`vibe_travel_hospitality_v1`.`compliance`.`policy_acknowledgment`"
  dimensions:
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Status of acknowledgment (pending, acknowledged, overdue, waived)"
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "Method of acknowledgment (electronic signature, in-person, email confirmation)"
    - name: "acknowledgment_channel"
      expr: acknowledgment_channel
      comment: "Channel used for acknowledgment (LMS, email, portal, in-person)"
    - name: "department_code"
      expr: department_code
      comment: "Department code of acknowledging employee"
    - name: "job_role_code"
      expr: job_role_code
      comment: "Job role code of acknowledging employee"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level for overdue acknowledgments"
    - name: "re_acknowledgment_required_flag"
      expr: re_acknowledgment_required_flag
      comment: "Whether re-acknowledgment is required"
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether waiver was granted"
    - name: "acknowledgment_year"
      expr: YEAR(acknowledgment_date)
      comment: "Year acknowledgment was completed"
    - name: "acknowledgment_quarter"
      expr: CONCAT('Q', QUARTER(acknowledgment_date))
      comment: "Quarter acknowledgment was completed"
    - name: "acknowledgment_month"
      expr: DATE_TRUNC('MONTH', acknowledgment_date)
      comment: "Month acknowledgment was completed"
    - name: "due_year"
      expr: YEAR(acknowledgment_due_date)
      comment: "Year acknowledgment is due"
    - name: "due_quarter"
      expr: CONCAT('Q', QUARTER(acknowledgment_due_date))
      comment: "Quarter acknowledgment is due"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', acknowledgment_due_date)
      comment: "Month acknowledgment is due"
  measures:
    - name: "total_acknowledgments"
      expr: COUNT(1)
      comment: "Total number of policy acknowledgments"
    - name: "total_reminder_sent"
      expr: SUM(CAST(reminder_sent_count AS DOUBLE))
      comment: "Total number of reminders sent"
    - name: "avg_reminder_sent"
      expr: AVG(CAST(reminder_sent_count AS DOUBLE))
      comment: "Average number of reminders sent per acknowledgment"
    - name: "acknowledged_count"
      expr: SUM(CASE WHEN acknowledgment_status = 'acknowledged' THEN 1 ELSE 0 END)
      comment: "Number of completed acknowledgments"
    - name: "overdue_count"
      expr: SUM(CASE WHEN acknowledgment_status = 'overdue' THEN 1 ELSE 0 END)
      comment: "Number of overdue acknowledgments"
    - name: "pending_count"
      expr: SUM(CASE WHEN acknowledgment_status = 'pending' THEN 1 ELSE 0 END)
      comment: "Number of pending acknowledgments"
    - name: "waived_count"
      expr: SUM(CASE WHEN waiver_granted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of waived acknowledgments"
    - name: "requiring_re_acknowledgment"
      expr: SUM(CASE WHEN re_acknowledgment_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of acknowledgments requiring re-acknowledgment"
    - name: "distinct_policies_acknowledged"
      expr: COUNT(DISTINCT policy_id)
      comment: "Number of distinct policies acknowledged"
    - name: "distinct_employees_acknowledging"
      expr: COUNT(DISTINCT primary_policy_employee_id)
      comment: "Number of distinct employees acknowledging policies"
    - name: "distinct_properties_with_acknowledgments"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with acknowledgments"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enterprise risk register metrics tracking risk identification, assessment, mitigation effectiveness, and residual risk exposure"
  source: "`vibe_travel_hospitality_v1`.`compliance`.`risk_register`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of risk (identified, assessed, mitigated, closed, escalated)"
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (operational, financial, strategic, compliance, reputational)"
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Subcategory of risk"
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating (negligible, minor, moderate, major, catastrophic)"
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating (rare, unlikely, possible, likely, almost certain)"
    - name: "residual_impact_rating"
      expr: residual_impact_rating
      comment: "Residual impact rating after controls"
    - name: "residual_likelihood_rating"
      expr: residual_likelihood_rating
      comment: "Residual likelihood rating after controls"
    - name: "control_effectiveness"
      expr: control_effectiveness
      comment: "Effectiveness of control measures (ineffective, partially effective, effective, highly effective)"
    - name: "risk_appetite_alignment"
      expr: risk_appetite_alignment
      comment: "Alignment with risk appetite (within appetite, near threshold, exceeds appetite)"
    - name: "scope_level"
      expr: scope_level
      comment: "Scope level of risk (property, regional, enterprise)"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation is required"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction code where risk applies"
    - name: "identification_year"
      expr: YEAR(identification_date)
      comment: "Year risk was identified"
    - name: "identification_quarter"
      expr: CONCAT('Q', QUARTER(identification_date))
      comment: "Quarter risk was identified"
    - name: "identification_month"
      expr: DATE_TRUNC('MONTH', identification_date)
      comment: "Month risk was identified"
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of risks in register"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of risks"
    - name: "total_mitigation_cost"
      expr: SUM(CAST(mitigation_cost_estimate AS DOUBLE))
      comment: "Total estimated mitigation cost"
    - name: "total_related_incidents"
      expr: SUM(CAST(related_incident_count AS DOUBLE))
      comment: "Total number of related incidents"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per risk"
    - name: "avg_mitigation_cost"
      expr: AVG(CAST(mitigation_cost_estimate AS DOUBLE))
      comment: "Average mitigation cost per risk"
    - name: "avg_inherent_risk_score"
      expr: AVG(CAST(inherent_risk_score AS DOUBLE))
      comment: "Average inherent risk score"
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after controls"
    - name: "high_impact_risks"
      expr: SUM(CASE WHEN impact_rating IN ('major', 'catastrophic') THEN 1 ELSE 0 END)
      comment: "Number of high impact risks"
    - name: "high_likelihood_risks"
      expr: SUM(CASE WHEN likelihood_rating IN ('likely', 'almost certain') THEN 1 ELSE 0 END)
      comment: "Number of high likelihood risks"
    - name: "risks_requiring_escalation"
      expr: SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of risks requiring escalation"
    - name: "risks_exceeding_appetite"
      expr: SUM(CASE WHEN risk_appetite_alignment = 'exceeds appetite' THEN 1 ELSE 0 END)
      comment: "Number of risks exceeding risk appetite"
    - name: "closed_risks"
      expr: SUM(CASE WHEN risk_status = 'closed' THEN 1 ELSE 0 END)
      comment: "Number of closed risks"
    - name: "distinct_properties_with_risks"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with risks"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing and reporting metrics tracking filing timeliness, acceptance rates, penalties, and regulatory response"
  source: "`vibe_travel_hospitality_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (tax, environmental, financial, operational, safety)"
    - name: "filing_status"
      expr: filing_status
      comment: "Status of filing (draft, submitted, accepted, rejected, amended)"
    - name: "filing_method"
      expr: filing_method
      comment: "Method of filing (electronic, paper, portal, third-party)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the filing"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction code for filing"
    - name: "jurisdiction_name"
      expr: jurisdiction_name
      comment: "Jurisdiction name for filing"
    - name: "penalty_assessed_flag"
      expr: penalty_assessed_flag
      comment: "Whether penalty was assessed"
    - name: "penalty_paid_flag"
      expr: penalty_paid_flag
      comment: "Whether penalty was paid"
    - name: "regulatory_response_received_flag"
      expr: regulatory_response_received_flag
      comment: "Whether regulatory response was received"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year filing was submitted"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_date))
      comment: "Quarter filing was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month filing was submitted"
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year filing is due"
    - name: "due_quarter"
      expr: CONCAT('Q', QUARTER(due_date))
      comment: "Quarter filing is due"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month filing is due"
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings"
    - name: "total_penalties_assessed"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties assessed"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per filing"
    - name: "submitted_filings"
      expr: SUM(CASE WHEN filing_status = 'submitted' THEN 1 ELSE 0 END)
      comment: "Number of submitted filings"
    - name: "accepted_filings"
      expr: SUM(CASE WHEN filing_status = 'accepted' THEN 1 ELSE 0 END)
      comment: "Number of accepted filings"
    - name: "rejected_filings"
      expr: SUM(CASE WHEN filing_status = 'rejected' THEN 1 ELSE 0 END)
      comment: "Number of rejected filings"
    - name: "amended_filings"
      expr: SUM(CASE WHEN filing_status = 'amended' THEN 1 ELSE 0 END)
      comment: "Number of amended filings"
    - name: "filings_with_penalty"
      expr: SUM(CASE WHEN penalty_assessed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of filings with penalty assessed"
    - name: "penalties_paid"
      expr: SUM(CASE WHEN penalty_paid_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of penalties paid"
    - name: "filings_with_regulatory_response"
      expr: SUM(CASE WHEN regulatory_response_received_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of filings with regulatory response received"
    - name: "distinct_regulatory_bodies"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Number of distinct regulatory bodies"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction_code)
      comment: "Number of distinct jurisdictions"
    - name: "distinct_properties_filing"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with filings"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`compliance_sanction_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanctions and watchlist screening metrics tracking screening coverage, match rates, false positives, and regulatory reporting requirements"
  source: "`vibe_travel_hospitality_v1`.`compliance`.`sanction_screening`"
  dimensions:
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (guest, employee, vendor, corporate account)"
    - name: "screening_status"
      expr: screening_status
      comment: "Status of screening (pending, completed, under review, escalated)"
    - name: "match_result"
      expr: match_result
      comment: "Result of screening match (no match, potential match, confirmed match)"
    - name: "match_disposition"
      expr: match_disposition
      comment: "Disposition of match (false positive, true positive, under investigation)"
    - name: "matched_list_name"
      expr: matched_list_name
      comment: "Name of sanctions list matched"
    - name: "screening_method"
      expr: screening_method
      comment: "Method of screening (automated, manual, hybrid)"
    - name: "screening_trigger"
      expr: screening_trigger
      comment: "Trigger for screening (onboarding, periodic review, transaction, alert)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned (low, medium, high, prohibited)"
    - name: "business_relationship_status"
      expr: business_relationship_status
      comment: "Status of business relationship (active, suspended, terminated, pending review)"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation is required"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction code for screening"
    - name: "screening_year"
      expr: YEAR(screening_date)
      comment: "Year screening was performed"
    - name: "screening_quarter"
      expr: CONCAT('Q', QUARTER(screening_date))
      comment: "Quarter screening was performed"
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month screening was performed"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of sanctions screenings performed"
    - name: "avg_match_confidence_score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average match confidence score"
    - name: "completed_screenings"
      expr: SUM(CASE WHEN screening_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Number of completed screenings"
    - name: "screenings_with_match"
      expr: SUM(CASE WHEN match_result IN ('potential match', 'confirmed match') THEN 1 ELSE 0 END)
      comment: "Number of screenings with potential or confirmed match"
    - name: "confirmed_matches"
      expr: SUM(CASE WHEN match_result = 'confirmed match' THEN 1 ELSE 0 END)
      comment: "Number of confirmed matches"
    - name: "false_positives"
      expr: SUM(CASE WHEN match_disposition = 'false positive' THEN 1 ELSE 0 END)
      comment: "Number of false positive matches"
    - name: "true_positives"
      expr: SUM(CASE WHEN match_disposition = 'true positive' THEN 1 ELSE 0 END)
      comment: "Number of true positive matches"
    - name: "high_risk_screenings"
      expr: SUM(CASE WHEN risk_level IN ('high', 'prohibited') THEN 1 ELSE 0 END)
      comment: "Number of high risk screenings"
    - name: "screenings_requiring_escalation"
      expr: SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of screenings requiring escalation"
    - name: "screenings_requiring_regulatory_reporting"
      expr: SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of screenings requiring regulatory reporting"
    - name: "relationships_suspended"
      expr: SUM(CASE WHEN business_relationship_status = 'suspended' THEN 1 ELSE 0 END)
      comment: "Number of business relationships suspended"
    - name: "relationships_terminated"
      expr: SUM(CASE WHEN business_relationship_status = 'terminated' THEN 1 ELSE 0 END)
      comment: "Number of business relationships terminated"
    - name: "distinct_entities_screened"
      expr: COUNT(DISTINCT screened_entity_name)
      comment: "Number of distinct entities screened"
    - name: "distinct_properties_screening"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties performing screenings"
$$;