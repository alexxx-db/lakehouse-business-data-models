-- Metric views for domain: compliance | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance audit execution KPIs: findings burden, penalty exposure, and audit cost efficiency used by compliance leadership to steer audit programs and manage regulatory risk."
  source: "`vibe_healthcare_v1`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, regulatory) for program mix analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current lifecycle status of the audit for pipeline monitoring."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Governing regulatory framework the audit assesses against."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the audit for prioritization."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Overall outcome/result of the audit."
    - name: "auditing_body"
      expr: auditing_body
      comment: "Body conducting the audit (regulator, accreditor, internal)."
    - name: "actual_completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Month the audit was completed for trend analysis."
  measures:
    - name: "Audit Count"
      expr: COUNT(1)
      comment: "Total number of audits — baseline volume of audit activity."
    - name: "Total Findings"
      expr: SUM(CAST(findings_count AS DOUBLE))
      comment: "Total findings across audits — overall compliance exposure."
    - name: "Total Critical Findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total critical findings — highest-priority regulatory risk to remediate."
    - name: "Avg Findings Per Audit"
      expr: AVG(CAST(findings_count AS DOUBLE))
      comment: "Average findings per audit — audit stringency / control health indicator."
    - name: "Total Monetary Penalty"
      expr: SUM(CAST(monetary_penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed — direct financial risk from non-compliance."
    - name: "Total Audit Cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total spend on audits — cost of the compliance program."
    - name: "Avg Audit Cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per audit — audit efficiency benchmark."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding remediation and severity KPIs used to track corrective-action throughput, patient-safety impact, and recurrence — core to compliance risk steering."
  source: "`vibe_healthcare_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the finding for prioritizing remediation."
    - name: "finding_status"
      expr: finding_status
      comment: "Current remediation status of the finding."
    - name: "finding_type"
      expr: finding_type
      comment: "Category/type of finding."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic risk analysis."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework cited for the finding."
    - name: "affected_department"
      expr: affected_department
      comment: "Department impacted by the finding for accountability."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the finding was identified for trend tracking."
  measures:
    - name: "Finding Count"
      expr: COUNT(1)
      comment: "Total findings — overall compliance issue volume."
    - name: "Patient Safety Impact Findings"
      expr: COUNT(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 END)
      comment: "Findings with patient-safety impact — critical quality/safety risk requiring intervention."
    - name: "Recurrence Findings"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Recurring findings — signals ineffective prior corrective actions."
    - name: "Financial Penalty Risk Findings"
      expr: COUNT(CASE WHEN financial_penalty_risk_flag = TRUE THEN 1 END)
      comment: "Findings posing financial penalty risk — direct cost exposure."
    - name: "Corrective Action Required Findings"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Findings requiring corrective action — remediation workload."
    - name: "Mandatory Reporting Findings"
      expr: COUNT(CASE WHEN mandatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Findings requiring mandatory external reporting — regulatory obligation exposure."
    - name: "Avg Days To Resolution"
      expr: AVG(CAST(days_to_resolution AS DOUBLE))
      comment: "Average days to resolve findings — remediation efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_hipaa_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA privacy incident and breach KPIs: breach volume, affected-individual scale, and OCR reporting posture — top-tier HIPAA compliance risk metrics for executives."
  source: "`vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of privacy incident."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident."
    - name: "incident_category"
      expr: incident_category
      comment: "Category of incident for pattern analysis."
    - name: "breach_determination_outcome"
      expr: breach_determination_outcome
      comment: "Outcome of the breach determination."
    - name: "phi_type"
      expr: phi_type
      comment: "Type of PHI involved in the incident."
    - name: "reported_by_department"
      expr: reported_by_department
      comment: "Department that reported the incident."
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month the incident was discovered for trend monitoring."
  measures:
    - name: "Incident Count"
      expr: COUNT(1)
      comment: "Total privacy incidents — overall HIPAA exposure volume."
    - name: "Confirmed Breach Count"
      expr: COUNT(CASE WHEN phi_involved_flag = TRUE THEN 1 END)
      comment: "Incidents involving PHI — potential reportable breaches driving risk."
    - name: "OCR Reportable Incidents"
      expr: COUNT(CASE WHEN ocr_reporting_required_flag = TRUE THEN 1 END)
      comment: "Incidents requiring OCR reporting — direct regulatory obligation and penalty exposure."
    - name: "Total Affected Individuals"
      expr: SUM(CAST(affected_individuals_count AS DOUBLE))
      comment: "Total individuals affected — breach magnitude and notification burden."
    - name: "Avg Affected Individuals Per Incident"
      expr: AVG(CAST(affected_individuals_count AS DOUBLE))
      comment: "Average affected individuals per incident — breach severity indicator."
    - name: "Media Notification Incidents"
      expr: COUNT(CASE WHEN media_notification_required_flag = TRUE THEN 1 END)
      comment: "Incidents requiring media notification — large breaches (500+) with reputational risk."
    - name: "Disciplinary Action Incidents"
      expr: COUNT(CASE WHEN disciplinary_action_taken_flag = TRUE THEN 1 END)
      comment: "Incidents resulting in disciplinary action — internal accountability tracking."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_hipaa_security_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA Security Rule risk register KPIs: inherent vs residual risk posture and mitigation throughput used by CISO/compliance to steer ePHI security investment."
  source: "`vibe_healthcare_v1`.`compliance`.`hipaa_security_risk`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the security risk."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk in the register."
    - name: "inherent_risk_level"
      expr: inherent_risk_level
      comment: "Inherent risk level before controls."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls."
    - name: "risk_treatment_decision"
      expr: risk_treatment_decision
      comment: "Treatment decision (mitigate, accept, transfer)."
    - name: "affected_ephi_system"
      expr: affected_ephi_system
      comment: "ePHI system affected by the risk."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the risk was identified for trend tracking."
  measures:
    - name: "Risk Count"
      expr: COUNT(1)
      comment: "Total risks in the register — overall ePHI security exposure."
    - name: "Open High Inherent Risks"
      expr: COUNT(CASE WHEN inherent_risk_level IN ('High','Critical') AND risk_status = 'Open' THEN 1 END)
      comment: "Open high/critical inherent risks — priority mitigation targets."
    - name: "Accepted Residual Risks"
      expr: COUNT(CASE WHEN risk_treatment_decision = 'Accept' THEN 1 END)
      comment: "Risks formally accepted — residual exposure leadership has signed off on."
    - name: "Mitigated Risks"
      expr: COUNT(CASE WHEN mitigation_actual_completion_date IS NOT NULL THEN 1 END)
      comment: "Risks with completed mitigation — remediation throughput."
    - name: "Avg Impact Score"
      expr: AVG(CAST(impact_score AS DOUBLE))
      comment: "Average impact score across risks — severity profile of the register."
    - name: "Avg Likelihood Score"
      expr: AVG(CAST(likelihood_score AS DOUBLE))
      comment: "Average likelihood score — threat probability profile of the register."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action plan (CAP) execution KPIs: open/overdue CAPs, escalation, and patient-safety-linked plans used to steer remediation performance."
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
      comment: "Priority level for remediation sequencing."
    - name: "responsible_owner_department"
      expr: responsible_owner_department
      comment: "Department owning the CAP for accountability."
    - name: "verification_outcome"
      expr: verification_outcome
      comment: "Outcome of remediation verification."
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month the CAP is targeted to complete for backlog planning."
  measures:
    - name: "CAP Count"
      expr: COUNT(1)
      comment: "Total corrective action plans — remediation workload."
    - name: "Escalated CAP Count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "CAPs requiring escalation — at-risk remediation needing leadership attention."
    - name: "Patient Safety CAP Count"
      expr: COUNT(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 END)
      comment: "CAPs tied to patient safety — highest-priority remediation."
    - name: "Completed CAP Count"
      expr: COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END)
      comment: "CAPs with actual completion — remediation throughput."
    - name: "External Consultant CAP Count"
      expr: COUNT(CASE WHEN external_consultant_engaged_flag = TRUE THEN 1 END)
      comment: "CAPs requiring external consultants — cost and complexity indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training completion KPIs: completion rate, pass rate, and escalations — core workforce compliance readiness metrics for leadership dashboards."
  source: "`vibe_healthcare_v1`.`compliance`.`training_completion`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Status of the training completion record."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail result of the training assessment."
    - name: "employee_department"
      expr: employee_department
      comment: "Employee department for departmental compliance analysis."
    - name: "employee_role"
      expr: employee_role
      comment: "Employee role for role-based compliance analysis."
    - name: "training_method"
      expr: training_method
      comment: "Delivery method of the training."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of training completion for trend tracking."
  measures:
    - name: "Training Record Count"
      expr: COUNT(1)
      comment: "Total training assignment records — workforce compliance training volume."
    - name: "Completed Count"
      expr: COUNT(CASE WHEN completion_status = 'Completed' THEN 1 END)
      comment: "Completed training records — count for completion-rate composition."
    - name: "Passed Count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Passed assessments — count for pass-rate composition."
    - name: "Escalated Count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Escalated overdue trainings — at-risk workforce compliance gaps."
    - name: "Waiver Count"
      expr: COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END)
      comment: "Waived trainings — exceptions requiring governance oversight."
    - name: "Avg Score Achieved"
      expr: AVG(CAST(score_achieved AS DOUBLE))
      comment: "Average assessment score — training effectiveness / knowledge retention indicator."
    - name: "Total CE Credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total continuing education credits earned — regulatory CE compliance tracking."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_phi_access_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PHI access monitoring KPIs: suspicious access, break-glass usage, and review backlog — critical HIPAA audit-control metrics for privacy and security officers."
  source: "`vibe_healthcare_v1`.`compliance`.`phi_access_log`"
  dimensions:
    - name: "access_type"
      expr: access_type
      comment: "Type of PHI access performed."
    - name: "user_role"
      expr: user_role
      comment: "Role of the accessing user for access-pattern analysis."
    - name: "user_department"
      expr: user_department
      comment: "Department of the accessing user."
    - name: "review_status"
      expr: review_status
      comment: "Review status of the access event."
    - name: "breach_determination"
      expr: breach_determination
      comment: "Breach determination outcome for the access event."
    - name: "access_month"
      expr: DATE_TRUNC('MONTH', access_timestamp)
      comment: "Month of access for monitoring trends."
  measures:
    - name: "Access Event Count"
      expr: COUNT(1)
      comment: "Total PHI access events — baseline monitoring volume."
    - name: "Suspicious Access Count"
      expr: COUNT(CASE WHEN suspicious_flag = TRUE THEN 1 END)
      comment: "Suspicious access events — potential unauthorized access requiring investigation."
    - name: "Break Glass Access Count"
      expr: COUNT(CASE WHEN break_glass_flag = TRUE THEN 1 END)
      comment: "Break-glass emergency accesses — elevated-risk events requiring justification review."
    - name: "Flagged For Review Count"
      expr: COUNT(CASE WHEN flagged_for_review = TRUE THEN 1 END)
      comment: "Accesses flagged for review — audit backlog driver."
    - name: "Emergency Access Count"
      expr: COUNT(CASE WHEN emergency_access_flag = TRUE THEN 1 END)
      comment: "Emergency access events — special-case monitoring."
    - name: "Distinct Patients Accessed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients whose PHI was accessed — scope of PHI exposure."
    - name: "Distinct Accessing Users"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct users accessing PHI — access footprint."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance investigation KPIs: confirmed violations, financial impact, and self-disclosure exposure — key metrics for compliance risk governance."
  source: "`vibe_healthcare_v1`.`compliance`.`investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the investigation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the investigation."
    - name: "department_involved"
      expr: department_involved
      comment: "Department involved for accountability analysis."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the investigation started for trend tracking."
  measures:
    - name: "Investigation Count"
      expr: COUNT(1)
      comment: "Total investigations — compliance issue caseload."
    - name: "Confirmed Violation Count"
      expr: COUNT(CASE WHEN violation_confirmed_flag = TRUE THEN 1 END)
      comment: "Investigations confirming violations — substantiated compliance risk."
    - name: "Self Disclosure Required Count"
      expr: COUNT(CASE WHEN self_disclosure_required_flag = TRUE THEN 1 END)
      comment: "Investigations requiring self-disclosure — regulatory exposure requiring reporting."
    - name: "Breach Notification Required Count"
      expr: COUNT(CASE WHEN breach_notification_required_flag = TRUE THEN 1 END)
      comment: "Investigations requiring breach notification — HIPAA notification obligation."
    - name: "Total Financial Impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of investigations — quantified compliance cost/risk."
    - name: "Avg Financial Impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per investigation — severity benchmark."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_exclusion_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OIG/SAM exclusion screening KPIs: match hits and unresolved matches — critical to prevent billing on excluded parties (False Claims Act exposure)."
  source: "`vibe_healthcare_v1`.`compliance`.`exclusion_screening`"
  dimensions:
    - name: "screening_result"
      expr: screening_result
      comment: "Result of the exclusion screening."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of a matched screening."
    - name: "screening_source"
      expr: screening_source
      comment: "Source list screened against (OIG LEIE, SAM, state)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the screening result."
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (individual, business)."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month of screening for trend tracking."
  measures:
    - name: "Screening Count"
      expr: COUNT(1)
      comment: "Total screenings performed — compliance screening coverage."
    - name: "Match Found Count"
      expr: COUNT(CASE WHEN match_found_flag = TRUE THEN 1 END)
      comment: "Screenings with a match — potential exclusion hits requiring resolution."
    - name: "Unresolved Match Count"
      expr: COUNT(CASE WHEN match_found_flag = TRUE AND resolution_status <> 'Resolved' THEN 1 END)
      comment: "Matches not yet resolved — active FCA/exclusion exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation fulfillment KPIs: compliance percentage, overdue obligations, and finding burden — core regulatory obligation management metrics."
  source: "`vibe_healthcare_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the obligation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the obligation."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority mandating the obligation."
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department assigned responsibility."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the obligation is due for backlog planning."
  measures:
    - name: "Obligation Count"
      expr: COUNT(1)
      comment: "Total obligations tracked — regulatory obligation inventory."
    - name: "Active Obligation Count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Currently active obligations — live compliance workload."
    - name: "Avg Compliance Percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average compliance percentage across obligations — overall obligation fulfillment health."
    - name: "Total Finding Count"
      expr: SUM(CAST(finding_count AS DOUBLE))
      comment: "Total findings tied to obligations — obligation-level risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_regulatory_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory change management KPIs: implementation backlog, cost, and penalty exposure — used to steer regulatory response and budget."
  source: "`vibe_healthcare_v1`.`compliance`.`regulatory_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of regulatory change."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation status of the change."
    - name: "impact_assessment_status"
      expr: impact_assessment_status
      comment: "Status of the impact assessment."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the regulatory change."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body issuing the change."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Framework the change pertains to."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the change becomes effective for planning."
  measures:
    - name: "Regulatory Change Count"
      expr: COUNT(1)
      comment: "Total regulatory changes tracked — change management workload."
    - name: "Total Estimated Cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated implementation cost — budget planning input."
    - name: "Total Actual Cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual implementation cost — spend vs plan tracking."
    - name: "Total Penalty Exposure"
      expr: SUM(CAST(penalty_exposure_amount AS DOUBLE))
      comment: "Total penalty exposure from changes — financial risk if not implemented."
    - name: "Policy Update Required Count"
      expr: COUNT(CASE WHEN policy_updates_required_flag = TRUE THEN 1 END)
      comment: "Changes requiring policy updates — downstream policy workload."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_osha_exposure_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSHA workplace exposure incident KPIs: recordable incidents, lost-work days, and workers' comp claims — core occupational safety metrics for leadership."
  source: "`vibe_healthcare_v1`.`compliance`.`osha_exposure_incident`"
  dimensions:
    - name: "exposure_type"
      expr: exposure_type
      comment: "Type of occupational exposure."
    - name: "exposure_route"
      expr: exposure_route
      comment: "Route of exposure (percutaneous, mucocutaneous)."
    - name: "incident_status"
      expr: incident_status
      comment: "Status of the exposure incident."
    - name: "exposed_employee_department"
      expr: exposed_employee_department
      comment: "Department of the exposed employee."
    - name: "exposed_employee_job_title"
      expr: exposed_employee_job_title
      comment: "Job title of the exposed employee for risk-role analysis."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of the incident for trend tracking."
  measures:
    - name: "Exposure Incident Count"
      expr: COUNT(1)
      comment: "Total exposure incidents — occupational safety event volume."
    - name: "OSHA Recordable Count"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END)
      comment: "OSHA-recordable incidents — regulatory recordkeeping and safety KPI."
    - name: "Total Days Away From Work"
      expr: SUM(CAST(days_away_from_work AS DOUBLE))
      comment: "Total lost workdays — productivity impact and OSHA severity metric."
    - name: "Workers Comp Claim Count"
      expr: COUNT(CASE WHEN workers_comp_claim_filed_flag = TRUE THEN 1 END)
      comment: "Workers' comp claims filed — direct cost exposure from exposures."
    - name: "PEP Initiated Count"
      expr: COUNT(CASE WHEN pep_initiated_flag = TRUE THEN 1 END)
      comment: "Incidents with post-exposure prophylaxis initiated — clinical follow-up burden."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_hotline_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance hotline KPIs: report volume, retaliation concerns, and corrective actions — measures the effectiveness of the compliance reporting culture."
  source: "`vibe_healthcare_v1`.`compliance`.`hotline_report`"
  dimensions:
    - name: "allegation_category"
      expr: allegation_category
      comment: "Category of allegation reported."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the report investigation."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the report."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the allegation."
    - name: "report_channel"
      expr: report_channel
      comment: "Channel through which the report was made."
    - name: "department_implicated"
      expr: department_implicated
      comment: "Department implicated in the allegation."
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_date)
      comment: "Month the report was made for trend tracking."
  measures:
    - name: "Report Count"
      expr: COUNT(1)
      comment: "Total hotline reports — compliance reporting activity and culture health."
    - name: "Anonymous Report Count"
      expr: COUNT(CASE WHEN reporter_anonymity_flag = TRUE THEN 1 END)
      comment: "Anonymous reports — indicator of reporter comfort/trust in the process."
    - name: "Retaliation Concern Count"
      expr: COUNT(CASE WHEN retaliation_concern_flag = TRUE THEN 1 END)
      comment: "Reports with retaliation concerns — culture and legal risk indicator."
    - name: "Corrective Action Required Count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Reports requiring corrective action — substantiated issue volume."
    - name: "Regulatory Reporting Required Count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Reports requiring regulatory notification — external exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_business_associate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business Associate Agreement (BAA) lifecycle KPIs: active agreements, review currency, and insurance coverage — HIPAA vendor risk management metrics."
  source: "`vibe_healthcare_v1`.`compliance`.`business_associate_agreement`"
  dimensions:
    - name: "baa_status"
      expr: business_associate_agreement_status
      comment: "Current status of the BAA."
    - name: "phi_types_shared"
      expr: phi_types_shared
      comment: "Types of PHI shared under the agreement."
    - name: "next_review_month"
      expr: DATE_TRUNC('MONTH', next_review_date)
      comment: "Month the next review is due for compliance planning."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the BAA expires for renewal planning."
  measures:
    - name: "BAA Count"
      expr: COUNT(1)
      comment: "Total business associate agreements — vendor PHI-sharing footprint."
    - name: "Insurance Required Count"
      expr: COUNT(CASE WHEN insurance_required_flag = TRUE THEN 1 END)
      comment: "BAAs requiring insurance — vendor risk mitigation coverage."
    - name: "Subcontractor BAA Required Count"
      expr: COUNT(CASE WHEN subcontractor_baa_required_flag = TRUE THEN 1 END)
      comment: "BAAs with subcontractor chain requirements — extended PHI risk surface."
    - name: "Total Insurance Coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage across BAAs — aggregate vendor risk protection."
    - name: "Breach Notification Required Count"
      expr: COUNT(CASE WHEN breach_notification_required_flag = TRUE THEN 1 END)
      comment: "BAAs with breach notification clauses — contractual HIPAA safeguards in place."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_stark_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stark Law / physician arrangement KPIs: FMV compliance, disclosure exposure, and compensation totals — core regulatory financial-relationship risk metrics."
  source: "`vibe_healthcare_v1`.`compliance`.`stark_arrangement`"
  dimensions:
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of physician arrangement."
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the arrangement."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the arrangement."
    - name: "stark_exception_applied"
      expr: stark_exception_applied
      comment: "Stark exception relied upon for the arrangement."
    - name: "legal_approval_status"
      expr: legal_approval_status
      comment: "Legal approval status of the arrangement."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the arrangement became effective."
  measures:
    - name: "Arrangement Count"
      expr: COUNT(1)
      comment: "Total physician arrangements — Stark compliance inventory."
    - name: "FMV Compliant Count"
      expr: COUNT(CASE WHEN fmv_compliant_flag = TRUE THEN 1 END)
      comment: "Arrangements with FMV compliance — count for FMV-compliance-rate composition."
    - name: "Disclosure Required Count"
      expr: COUNT(CASE WHEN disclosure_required_flag = TRUE THEN 1 END)
      comment: "Arrangements requiring disclosure — self-referral disclosure exposure."
    - name: "Total Compensation Amount"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation across arrangements — aggregate financial-relationship exposure."
    - name: "Avg Compensation Amount"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per arrangement — FMV benchmarking input."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_conflict_of_interest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conflict of interest disclosure KPIs: disclosure volume, mitigation coverage, and estimated value — governance and integrity risk metrics."
  source: "`vibe_healthcare_v1`.`compliance`.`conflict_of_interest`"
  dimensions:
    - name: "disclosure_type"
      expr: disclosure_type
      comment: "Type of COI disclosure."
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Status of the disclosure."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of relationship disclosed."
    - name: "disclosed_entity_type"
      expr: disclosed_entity_type
      comment: "Type of the disclosed entity."
    - name: "department_name"
      expr: department_name
      comment: "Department of the disclosing individual."
    - name: "disclosure_month"
      expr: DATE_TRUNC('MONTH', disclosure_date)
      comment: "Month of disclosure for trend tracking."
  measures:
    - name: "Disclosure Count"
      expr: COUNT(1)
      comment: "Total COI disclosures — integrity governance activity."
    - name: "Mitigation Required Count"
      expr: COUNT(CASE WHEN mitigation_required_flag = TRUE THEN 1 END)
      comment: "Disclosures requiring mitigation — active conflict-management workload."
    - name: "Total Estimated Value"
      expr: SUM(CAST(estimated_value_amount AS DOUBLE))
      comment: "Total estimated value of disclosed interests — magnitude of financial-conflict exposure."
    - name: "Avg Estimated Value"
      expr: AVG(CAST(estimated_value_amount AS DOUBLE))
      comment: "Average estimated value per disclosure — conflict severity benchmark."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission KPIs: on-time acknowledgment, rejections, and penalty exposure — measures regulatory filing reliability and risk."
  source: "`vibe_healthcare_v1`.`compliance`.`compliance_regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission."
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the submission."
    - name: "agency_name"
      expr: agency_name
      comment: "Receiving agency."
    - name: "submission_domain"
      expr: submission_domain
      comment: "Domain of the submission."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the submission."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the submission is due for filing calendar."
  measures:
    - name: "Submission Count"
      expr: COUNT(1)
      comment: "Total regulatory submissions — filing workload."
    - name: "Acknowledged Count"
      expr: COUNT(CASE WHEN acknowledgment_received_flag = TRUE THEN 1 END)
      comment: "Submissions acknowledged by agency — successful-filing count."
    - name: "Rejected Count"
      expr: COUNT(CASE WHEN rejection_date IS NOT NULL THEN 1 END)
      comment: "Rejected submissions — filing quality issues requiring rework."
    - name: "Resubmission Required Count"
      expr: COUNT(CASE WHEN resubmission_required_flag = TRUE THEN 1 END)
      comment: "Submissions requiring resubmission — rework burden and compliance risk."
    - name: "Total Penalty Amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties associated with submissions — financial risk from filing failures."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_monitoring_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ongoing compliance monitoring KPIs: compliance rate, critical issues, and CAP triggers — measures the effectiveness of continuous monitoring programs."
  source: "`vibe_healthcare_v1`.`compliance`.`monitoring_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of monitoring activity."
    - name: "activity_status"
      expr: activity_status
      comment: "Status of the monitoring activity."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the monitored area."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework monitored."
    - name: "department_monitored"
      expr: department_monitored
      comment: "Department under monitoring."
    - name: "period_end_month"
      expr: DATE_TRUNC('MONTH', monitoring_period_end_date)
      comment: "Month the monitoring period ended for trend tracking."
  measures:
    - name: "Monitoring Activity Count"
      expr: COUNT(1)
      comment: "Total monitoring activities — coverage of continuous compliance monitoring."
    - name: "Avg Compliance Rate"
      expr: AVG(CAST(compliance_rate_percentage AS DOUBLE))
      comment: "Average compliance rate across monitored areas — overall control effectiveness."
    - name: "Total Critical Issues"
      expr: SUM(CAST(critical_issues_count AS DOUBLE))
      comment: "Total critical issues identified — high-priority compliance risk surfaced by monitoring."
    - name: "CAP Required Count"
      expr: COUNT(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 END)
      comment: "Activities triggering corrective action plans — remediation demand generated by monitoring."
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