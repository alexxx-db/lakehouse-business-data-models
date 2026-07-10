-- Metric views for domain: compliance | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory and internal audits: outcomes, findings burden, penalties, and cycle timeliness — used by compliance leadership to steer audit programs."
  source: "`vibe_healthcare_v1`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, regulatory) for portfolio segmentation."
    - name: "audit_status"
      expr: audit_status
      comment: "Current lifecycle status of the audit."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Overall audit outcome (pass/fail/conditional) for outcome analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the audit for prioritization."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Governing regulatory framework (e.g., CMS, TJC)."
    - name: "auditing_body"
      expr: auditing_body
      comment: "Body conducting the audit."
    - name: "audit_scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Scheduled start month for trend analysis."
  measures:
    - name: "Audit Count"
      expr: COUNT(1)
      comment: "Total number of audits — baseline volume for the audit program."
    - name: "Total Monetary Penalty Amount"
      expr: SUM(CAST(monetary_penalty_amount AS DOUBLE))
      comment: "Total monetary penalties incurred — direct financial risk exposure from audits."
    - name: "Total Audit Cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of conducting audits — audit program spend for budgeting decisions."
    - name: "Avg Audit Cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per audit — efficiency benchmark for audit resourcing."
    - name: "CAP Required Audit Count"
      expr: COUNT(CASE WHEN corrective_action_plan_required = TRUE THEN 1 END)
      comment: "Audits requiring a corrective action plan — signals control gaps needing remediation."
    - name: "Unannounced Audit Count"
      expr: COUNT(CASE WHEN is_unannounced = TRUE THEN 1 END)
      comment: "Number of unannounced audits — readiness exposure indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding severity, resolution timeliness, and risk indicators — steers remediation prioritization and regulatory exposure management."
  source: "`vibe_healthcare_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (open, resolved, disputed)."
    - name: "finding_type"
      expr: finding_type
      comment: "Category of the finding for thematic analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the finding for prioritization."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic pattern detection."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework cited in the finding."
    - name: "affected_department"
      expr: affected_department
      comment: "Department affected by the finding."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the finding was identified for trend tracking."
  measures:
    - name: "Finding Count"
      expr: COUNT(1)
      comment: "Total audit findings — baseline compliance risk volume."
    - name: "Patient Safety Impact Finding Count"
      expr: COUNT(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 END)
      comment: "Findings with patient safety impact — critical quality-of-care risk requiring intervention."
    - name: "Financial Penalty Risk Finding Count"
      expr: COUNT(CASE WHEN financial_penalty_risk_flag = TRUE THEN 1 END)
      comment: "Findings carrying financial penalty risk — direct exposure for leadership."
    - name: "Recurrence Finding Count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Recurring findings — indicates ineffective prior remediation."
    - name: "Open Finding Count"
      expr: COUNT(CASE WHEN finding_status = 'Open' THEN 1 END)
      comment: "Findings still open — active remediation backlog."
    - name: "Corrective Action Required Count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Findings requiring corrective action — remediation workload driver."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_hipaa_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA privacy incident and breach KPIs: breach volume, affected individuals, and notification/reporting obligations — critical for privacy risk governance."
  source: "`vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the privacy incident."
    - name: "incident_type"
      expr: incident_type
      comment: "Type of privacy incident for categorization."
    - name: "incident_category"
      expr: incident_category
      comment: "Category of incident for thematic analysis."
    - name: "breach_determination_outcome"
      expr: breach_determination_outcome
      comment: "Outcome of the breach determination analysis."
    - name: "ocr_reporting_status"
      expr: ocr_reporting_status
      comment: "Status of OCR reporting for regulatory obligation tracking."
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month the incident was discovered for trend monitoring."
  measures:
    - name: "Incident Count"
      expr: COUNT(1)
      comment: "Total privacy incidents — baseline privacy risk volume."
    - name: "PHI Involved Incident Count"
      expr: COUNT(CASE WHEN phi_involved_flag = TRUE THEN 1 END)
      comment: "Incidents involving PHI — core breach exposure driver."
    - name: "OCR Reportable Incident Count"
      expr: COUNT(CASE WHEN ocr_reporting_required_flag = TRUE THEN 1 END)
      comment: "Incidents requiring OCR reporting — regulatory obligation and reputational risk."
    - name: "Notification Required Incident Count"
      expr: COUNT(CASE WHEN notification_required_flag = TRUE THEN 1 END)
      comment: "Incidents requiring individual notification — compliance obligation workload."
    - name: "Disciplinary Action Incident Count"
      expr: COUNT(CASE WHEN disciplinary_action_taken_flag = TRUE THEN 1 END)
      comment: "Incidents resulting in disciplinary action — accountability indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_hipaa_security_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA security risk register KPIs: inherent vs residual risk posture, mitigation progress, and control effectiveness — steers security investment decisions."
  source: "`vibe_healthcare_v1`.`compliance`.`hipaa_security_risk`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the security risk."
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the security risk."
    - name: "inherent_risk_level"
      expr: inherent_risk_level
      comment: "Inherent risk level before controls."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls for prioritization."
    - name: "risk_treatment_decision"
      expr: risk_treatment_decision
      comment: "Risk treatment decision (mitigate, accept, transfer)."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the risk was identified for trend analysis."
  measures:
    - name: "Risk Count"
      expr: COUNT(1)
      comment: "Total security risks in the register — baseline security risk volume."
    - name: "Open Risk Count"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Open security risks — active exposure requiring treatment."
    - name: "Accepted Risk Count"
      expr: COUNT(CASE WHEN risk_treatment_decision = 'Accept' THEN 1 END)
      comment: "Risks formally accepted — residual risk the organization carries knowingly."
    - name: "High Inherent Risk Count"
      expr: COUNT(CASE WHEN inherent_risk_level = 'High' THEN 1 END)
      comment: "High inherent risks — priority items for control investment."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance investigation KPIs: volume, financial impact, confirmed violations, and self-disclosure obligations — steers compliance enforcement resourcing."
  source: "`vibe_healthcare_v1`.`compliance`.`investigation`"
  dimensions:
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation."
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation for categorization."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for triage."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the investigation."
    - name: "trigger_source"
      expr: trigger_source
      comment: "Source that triggered the investigation."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the investigation started for trend tracking."
  measures:
    - name: "Investigation Count"
      expr: COUNT(1)
      comment: "Total investigations — baseline enforcement workload."
    - name: "Total Financial Impact Amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of investigations — direct exposure for leadership."
    - name: "Avg Financial Impact Amount"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per investigation — severity benchmark."
    - name: "Violation Confirmed Count"
      expr: COUNT(CASE WHEN violation_confirmed_flag = TRUE THEN 1 END)
      comment: "Investigations with confirmed violations — substantiated compliance failures."
    - name: "Self Disclosure Required Count"
      expr: COUNT(CASE WHEN self_disclosure_required_flag = TRUE THEN 1 END)
      comment: "Investigations requiring self-disclosure — regulatory obligation exposure."
    - name: "Breach Notification Required Count"
      expr: COUNT(CASE WHEN breach_notification_required_flag = TRUE THEN 1 END)
      comment: "Investigations triggering breach notification obligations."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training completion KPIs: completion rates, scores, overdue and waived training — steers workforce compliance readiness."
  source: "`vibe_healthcare_v1`.`compliance`.`training_completion`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Status of the training completion record."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the training."
    - name: "employee_department"
      expr: employee_department
      comment: "Department of the employee for cohort analysis."
    - name: "employee_role"
      expr: employee_role
      comment: "Role of the employee for cohort analysis."
    - name: "training_method"
      expr: training_method
      comment: "Delivery method of the training."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of completion for trend tracking."
  measures:
    - name: "Completion Record Count"
      expr: COUNT(1)
      comment: "Total training completion records — baseline training volume."
    - name: "Avg Score Achieved"
      expr: AVG(CAST(score_achieved AS DOUBLE))
      comment: "Average assessment score — training effectiveness indicator."
    - name: "Total Continuing Education Credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total CE credits earned — regulatory credentialing coverage."
    - name: "Passed Completion Count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Passed completions — successful compliance readiness."
    - name: "Escalated Completion Count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Escalated (overdue) completions — non-compliance risk requiring follow-up."
    - name: "Waived Completion Count"
      expr: COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END)
      comment: "Waived trainings — exceptions that carry compliance risk if excessive."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action plan (CAP) KPIs: remediation backlog, closure, escalation, and patient-safety-linked CAPs — steers remediation governance."
  source: "`vibe_healthcare_v1`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "cap_status"
      expr: cap_status
      comment: "Current status of the corrective action plan."
    - name: "cap_type"
      expr: cap_type
      comment: "Type of corrective action plan."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for triage."
    - name: "responsible_owner_department"
      expr: responsible_owner_department
      comment: "Department owning the CAP."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the CAP was created for trend tracking."
  measures:
    - name: "CAP Count"
      expr: COUNT(1)
      comment: "Total corrective action plans — baseline remediation workload."
    - name: "Open CAP Count"
      expr: COUNT(CASE WHEN cap_status = 'Open' THEN 1 END)
      comment: "Open CAPs — active remediation backlog."
    - name: "Escalation Required CAP Count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "CAPs requiring escalation — at-risk remediation items."
    - name: "Patient Safety CAP Count"
      expr: COUNT(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 END)
      comment: "CAPs linked to patient safety impact — high-priority remediation."
    - name: "External Consultant CAP Count"
      expr: COUNT(CASE WHEN external_consultant_engaged_flag = TRUE THEN 1 END)
      comment: "CAPs requiring external consultants — complexity and cost signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission KPIs: submission volume, penalties, rejection/resubmission burden, and timeliness — steers regulatory filing operations."
  source: "`vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the regulatory submission."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission for categorization."
    - name: "submission_priority"
      expr: submission_priority
      comment: "Priority of the submission."
    - name: "receiving_agency"
      expr: receiving_agency
      comment: "Agency receiving the submission."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the submission."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for trend tracking."
  measures:
    - name: "Submission Count"
      expr: COUNT(1)
      comment: "Total regulatory submissions — baseline filing volume."
    - name: "Total Penalty Amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties tied to submissions — financial exposure indicator."
    - name: "Resubmission Required Count"
      expr: COUNT(CASE WHEN resubmission_required_flag = TRUE THEN 1 END)
      comment: "Submissions requiring resubmission — filing quality/rework indicator."
    - name: "Corrective Action Required Count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Submissions requiring corrective action — compliance follow-up workload."
    - name: "Acknowledgment Received Count"
      expr: COUNT(CASE WHEN acknowledgment_received_flag = TRUE THEN 1 END)
      comment: "Submissions acknowledged by the agency — completion confirmation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_hotline_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance hotline report KPIs: report volume, anonymity, retaliation concerns, and regulatory escalation — steers whistleblower program health."
  source: "`vibe_healthcare_v1`.`compliance`.`hotline_report`"
  dimensions:
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the hotline report investigation."
    - name: "allegation_category"
      expr: allegation_category
      comment: "Category of the allegation for thematic analysis."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the report."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the allegation."
    - name: "report_channel"
      expr: report_channel
      comment: "Channel through which the report was received."
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_date)
      comment: "Month the report was filed for trend tracking."
  measures:
    - name: "Report Count"
      expr: COUNT(1)
      comment: "Total hotline reports — baseline whistleblower program volume."
    - name: "Anonymous Report Count"
      expr: COUNT(CASE WHEN reporter_anonymity_flag = TRUE THEN 1 END)
      comment: "Anonymous reports — indicator of trust and reporting culture."
    - name: "Retaliation Concern Count"
      expr: COUNT(CASE WHEN retaliation_concern_flag = TRUE THEN 1 END)
      comment: "Reports raising retaliation concerns — program integrity risk."
    - name: "Regulatory Reporting Required Count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Reports requiring regulatory notification — escalation obligation."
    - name: "Corrective Action Required Count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Reports resulting in corrective action — substantiated issue indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_osha_exposure_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSHA exposure incident KPIs: recordable incidents, lost work time, PEP initiation, and source-patient testing — steers workforce safety programs."
  source: "`vibe_healthcare_v1`.`compliance`.`osha_exposure_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Status of the exposure incident."
    - name: "exposure_type"
      expr: exposure_type
      comment: "Type of exposure for categorization."
    - name: "exposure_route"
      expr: exposure_route
      comment: "Route of exposure."
    - name: "exposed_employee_department"
      expr: exposed_employee_department
      comment: "Department of the exposed employee for cohort analysis."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of the incident for trend tracking."
  measures:
    - name: "Exposure Incident Count"
      expr: COUNT(1)
      comment: "Total exposure incidents — baseline workforce safety volume."
    - name: "OSHA Recordable Count"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END)
      comment: "OSHA-recordable incidents — regulatory reporting and safety KPI."
    - name: "PEP Initiated Count"
      expr: COUNT(CASE WHEN pep_initiated_flag = TRUE THEN 1 END)
      comment: "Incidents where post-exposure prophylaxis was initiated — clinical response indicator."
    - name: "Workers Comp Claim Count"
      expr: COUNT(CASE WHEN workers_comp_claim_filed_flag = TRUE THEN 1 END)
      comment: "Incidents resulting in workers comp claims — financial and safety impact."
    - name: "Safety Engineered Device Count"
      expr: COUNT(CASE WHEN safety_engineered_device_flag = TRUE THEN 1 END)
      comment: "Incidents involving safety-engineered devices — control effectiveness signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance obligation KPIs: compliance rates, active obligations, findings burden, and overdue obligations — steers obligation management program."
  source: "`vibe_healthcare_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Status of the obligation."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of obligation for categorization."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for triage."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the obligation."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority governing the obligation."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the obligation is due for scheduling analysis."
  measures:
    - name: "Obligation Count"
      expr: COUNT(1)
      comment: "Total obligations tracked — baseline obligation volume."
    - name: "Avg Compliance Percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average compliance percentage across obligations — overall program adherence KPI."
    - name: "Active Obligation Count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Active obligations — current compliance workload."
    - name: "Corrective Action Required Count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Obligations requiring corrective action — remediation driver."
    - name: "Escalation Required Count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Obligations requiring escalation — at-risk compliance items."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_exclusion_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OIG/SAM exclusion screening KPIs: match rate, unresolved matches, and screening cadence — steers sanction-screening compliance program."
  source: "`vibe_healthcare_v1`.`compliance`.`exclusion_screening`"
  dimensions:
    - name: "screening_result"
      expr: screening_result
      comment: "Result of the exclusion screening."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of any match."
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (employee, vendor)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the screening."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month of screening for cadence tracking."
  measures:
    - name: "Screening Count"
      expr: COUNT(1)
      comment: "Total exclusion screenings performed — baseline screening volume."
    - name: "Match Found Count"
      expr: COUNT(CASE WHEN match_found_flag = TRUE THEN 1 END)
      comment: "Screenings with a potential match — sanction exposure requiring resolution."
    - name: "Notification Sent Count"
      expr: COUNT(CASE WHEN notification_sent_flag = TRUE THEN 1 END)
      comment: "Screenings where notification was sent — follow-up action indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_stark_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stark/anti-kickback arrangement KPIs: compensation exposure, FMV compliance, and disclosure obligations — steers physician-arrangement risk governance."
  source: "`vibe_healthcare_v1`.`compliance`.`stark_arrangement`"
  dimensions:
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Status of the arrangement."
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of arrangement for categorization."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the arrangement."
    - name: "legal_approval_status"
      expr: legal_approval_status
      comment: "Legal approval status of the arrangement."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Effective month for trend tracking."
  measures:
    - name: "Arrangement Count"
      expr: COUNT(1)
      comment: "Total Stark arrangements tracked — baseline arrangement volume."
    - name: "Total Compensation Amount"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation across arrangements — financial exposure under Stark/AKS."
    - name: "Avg Compensation Amount"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per arrangement — FMV benchmark reference."
    - name: "FMV Compliant Count"
      expr: COUNT(CASE WHEN fmv_compliant_flag = TRUE THEN 1 END)
      comment: "Arrangements determined FMV-compliant — compliance posture indicator."
    - name: "Disclosure Required Count"
      expr: COUNT(CASE WHEN disclosure_required_flag = TRUE THEN 1 END)
      comment: "Arrangements requiring disclosure — regulatory obligation exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic view of policy inventory and attestation obligations"
  source: "`vibe_healthcare_v1`.`compliance`.`compliance_policy`"
  dimensions:
    - name: "policy_category"
      expr: policy_category
      comment: "High‑level category of the policy (e.g., Data Privacy, Security)"
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of compliance policies in the catalog"
    - name: "active_policy_count"
      expr: SUM(CASE WHEN policy_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of policies currently active"
    - name: "policies_requiring_attestation"
      expr: SUM(CASE WHEN attestation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of policies that require employee attestation"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy incident volume and resolution speed for compliance leadership"
  source: "`vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of privacy incident"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of HIPAA privacy incidents reported"
    - name: "average_days_to_close"
      expr: AVG(CAST(DATEDIFF(closed_date, incident_date) AS DOUBLE))
      comment: "Average days from incident occurrence to closure"
$$;