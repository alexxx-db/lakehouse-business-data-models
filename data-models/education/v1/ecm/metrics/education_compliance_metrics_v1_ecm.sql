-- Metric views for domain: compliance | Business: Education | Version: 1 | Generated on: 2026-05-06 12:16:12

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_accreditation_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic accreditation review metrics tracking institutional compliance, financial impact, and review cycle performance for higher education accreditation bodies"
  source: "`education_ecm`.`compliance`.`accreditation_review`"
  dimensions:
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation status (e.g., Accredited, Probation, Denied) for filtering and segmentation"
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (e.g., Institutional, Programmatic, Specialized) for strategic analysis"
    - name: "review_cycle_type"
      expr: review_cycle_type
      comment: "Review cycle classification (e.g., Initial, Reaffirmation, Interim) for operational planning"
    - name: "conditions_issued_flag"
      expr: conditions_issued_flag
      comment: "Whether conditions were issued, indicating areas requiring corrective action"
    - name: "recommendations_issued_flag"
      expr: recommendations_issued_flag
      comment: "Whether recommendations were issued, indicating improvement opportunities"
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed, indicating contested decisions"
    - name: "decision_year"
      expr: YEAR(accreditation_decision_date)
      comment: "Year of accreditation decision for trend analysis"
    - name: "decision_quarter"
      expr: CONCAT('Q', QUARTER(accreditation_decision_date), '-', YEAR(accreditation_decision_date))
      comment: "Quarter of accreditation decision for seasonal analysis"
  measures:
    - name: "total_accreditation_reviews"
      expr: COUNT(1)
      comment: "Total number of accreditation reviews conducted, baseline volume metric for institutional oversight"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact across all accreditation reviews, critical for budget planning and risk assessment"
    - name: "avg_financial_impact_per_review"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per review, indicating typical cost of accreditation compliance"
    - name: "reviews_with_conditions"
      expr: SUM(CASE WHEN conditions_issued_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reviews resulting in conditions, key quality indicator for institutional compliance"
    - name: "condition_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN conditions_issued_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in conditions, critical quality metric for accreditation risk"
    - name: "reviews_with_appeals"
      expr: SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reviews where appeals were filed, indicating contested decisions and potential process issues"
    - name: "appeal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in appeals, key indicator of decision quality and stakeholder satisfaction"
    - name: "distinct_programs_reviewed"
      expr: COUNT(DISTINCT academic_program_id)
      comment: "Number of unique academic programs under review, indicating breadth of accreditation activity"
    - name: "distinct_accrediting_bodies"
      expr: COUNT(DISTINCT accrediting_body_id)
      comment: "Number of unique accrediting bodies involved, indicating regulatory complexity"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comprehensive audit performance metrics tracking audit efficiency, finding severity, remediation effectiveness, and compliance risk for institutional governance"
  source: "`education_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., Financial, Compliance, Operational, IT) for strategic audit planning"
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status (e.g., Planned, In Progress, Complete, Closed) for operational tracking"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status outcome (e.g., Compliant, Non-Compliant, Partially Compliant) for risk assessment"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to audit area (e.g., High, Medium, Low) for prioritization"
    - name: "overall_opinion"
      expr: overall_opinion
      comment: "Auditor's overall opinion (e.g., Satisfactory, Needs Improvement, Unsatisfactory) for executive reporting"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up audit is required, indicating severity of findings"
    - name: "audit_year"
      expr: YEAR(actual_start_date)
      comment: "Year audit started for trend analysis"
    - name: "scheduled_quarter"
      expr: CONCAT('Q', QUARTER(scheduled_start_date), '-', YEAR(scheduled_start_date))
      comment: "Quarter audit was scheduled for capacity planning"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted, baseline metric for audit program volume"
    - name: "total_audit_cost"
      expr: SUM(CAST(audit_cost AS DOUBLE))
      comment: "Total cost of all audits, critical for audit program budget management"
    - name: "avg_audit_cost"
      expr: AVG(CAST(audit_cost AS DOUBLE))
      comment: "Average cost per audit, key efficiency metric for audit operations"
    - name: "total_audit_hours"
      expr: SUM(CAST(audit_hours AS DOUBLE))
      comment: "Total hours spent on audits, resource utilization metric for capacity planning"
    - name: "avg_audit_hours"
      expr: AVG(CAST(audit_hours AS DOUBLE))
      comment: "Average hours per audit, efficiency metric for audit process optimization"
    - name: "total_external_auditor_fees"
      expr: SUM(CAST(external_auditor_fee AS DOUBLE))
      comment: "Total external auditor fees paid, critical cost metric for vendor management"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_finding_count AS BIGINT))
      comment: "Total critical findings across all audits, highest-priority risk indicator for executive action"
    - name: "total_high_findings"
      expr: SUM(CAST(high_finding_count AS BIGINT))
      comment: "Total high-severity findings, key risk metric for compliance steering"
    - name: "total_findings"
      expr: SUM(CAST(finding_count AS BIGINT))
      comment: "Total findings across all audits, overall compliance health indicator"
    - name: "avg_findings_per_audit"
      expr: AVG(CAST(finding_count AS BIGINT))
      comment: "Average findings per audit, quality metric for institutional compliance maturity"
    - name: "audits_requiring_followup"
      expr: SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits requiring follow-up, indicator of unresolved compliance issues"
    - name: "followup_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up, key metric for audit effectiveness and institutional risk"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding resolution metrics tracking questioned costs, repeat findings, remediation effectiveness, and compliance risk for institutional accountability"
  source: "`education_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding (e.g., Material Weakness, Significant Deficiency, Control Deficiency) for severity classification"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of finding (e.g., Financial, Compliance, Operational) for thematic analysis"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to finding (e.g., Critical, High, Medium, Low) for prioritization"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status (e.g., Open, In Progress, Resolved, Closed) for tracking remediation"
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Whether finding is a repeat from prior audit, indicating systemic compliance issues"
    - name: "reported_to_federal_agency_flag"
      expr: reported_to_federal_agency_flag
      comment: "Whether finding was reported to federal agency, indicating regulatory severity"
    - name: "reported_to_governing_board_flag"
      expr: reported_to_governing_board_flag
      comment: "Whether finding was reported to governing board, indicating institutional significance"
    - name: "finding_year"
      expr: YEAR(finding_issued_date)
      comment: "Year finding was issued for trend analysis"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit that generated finding for cross-audit analysis"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings, baseline metric for institutional compliance health"
    - name: "total_questioned_costs"
      expr: SUM(CAST(questioned_costs_amount AS DOUBLE))
      comment: "Total questioned costs across all findings, critical financial risk metric for executive action"
    - name: "avg_questioned_costs_per_finding"
      expr: AVG(CAST(questioned_costs_amount AS DOUBLE))
      comment: "Average questioned costs per finding, indicating typical financial exposure per issue"
    - name: "findings_with_questioned_costs"
      expr: SUM(CASE WHEN questioned_costs_amount > 0 THEN 1 ELSE 0 END)
      comment: "Count of findings with questioned costs, indicating financial compliance issues"
    - name: "repeat_findings"
      expr: SUM(CASE WHEN repeat_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of repeat findings, critical indicator of systemic compliance failures"
    - name: "repeat_finding_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN repeat_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeats, key metric for remediation effectiveness and institutional learning"
    - name: "findings_reported_to_federal_agency"
      expr: SUM(CASE WHEN reported_to_federal_agency_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of findings reported to federal agencies, indicating regulatory compliance risk"
    - name: "findings_reported_to_board"
      expr: SUM(CASE WHEN reported_to_governing_board_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of findings reported to governing board, indicating institutional governance escalation"
    - name: "resolved_findings"
      expr: SUM(CASE WHEN resolution_status = 'Resolved' THEN 1 ELSE 0 END)
      comment: "Count of resolved findings, key metric for remediation progress"
    - name: "resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_status = 'Resolved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings resolved, critical metric for compliance remediation effectiveness"
    - name: "distinct_audits_with_findings"
      expr: COUNT(DISTINCT audit_id)
      comment: "Number of unique audits with findings, indicating breadth of compliance issues"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training effectiveness metrics tracking completion rates, assessment performance, overdue training, and certification status for regulatory adherence"
  source: "`education_ecm`.`compliance`.`compliance_training_completion`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Training completion status (e.g., Complete, In Progress, Not Started) for tracking progress"
    - name: "trainee_type"
      expr: trainee_type
      comment: "Type of trainee (e.g., Faculty, Staff, Student, Contractor) for audience segmentation"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category (e.g., Title IX, FERPA, HIPAA, Safety) for regulatory reporting"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether training is mandatory, critical for compliance risk assessment"
    - name: "overdue_flag"
      expr: overdue_flag
      comment: "Whether training is overdue, indicating compliance risk"
    - name: "pass_fail_indicator"
      expr: pass_fail_indicator
      comment: "Whether trainee passed assessment, indicating training effectiveness"
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Whether certificate was issued, indicating successful completion"
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether waiver was granted, indicating exceptions to training requirements"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year training was completed for trend analysis"
    - name: "completion_quarter"
      expr: CONCAT('Q', QUARTER(completion_date), '-', YEAR(completion_date))
      comment: "Quarter training was completed for seasonal analysis"
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total number of training completions, baseline metric for training program volume"
    - name: "completed_trainings"
      expr: SUM(CASE WHEN completion_status = 'Complete' THEN 1 ELSE 0 END)
      comment: "Count of completed trainings, key metric for compliance adherence"
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_status = 'Complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of trainings completed, critical compliance metric for regulatory reporting"
    - name: "overdue_trainings"
      expr: SUM(CASE WHEN overdue_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of overdue trainings, critical risk indicator for compliance violations"
    - name: "overdue_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN overdue_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of trainings overdue, key risk metric for compliance management"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all completions, indicating training effectiveness and learner comprehension"
    - name: "trainings_passed"
      expr: SUM(CASE WHEN pass_fail_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of trainings passed, indicating successful knowledge transfer"
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of trainings passed, key quality metric for training program effectiveness"
    - name: "certificates_issued"
      expr: SUM(CASE WHEN certificate_issued_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of certificates issued, indicating formal completion and credential attainment"
    - name: "waivers_granted"
      expr: SUM(CASE WHEN waiver_granted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of waivers granted, indicating exceptions and potential compliance gaps"
    - name: "waiver_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_granted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of trainings waived, metric for exception management and policy adherence"
    - name: "distinct_trainees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees completing training, indicating program reach"
    - name: "distinct_training_programs"
      expr: COUNT(DISTINCT training_program_id)
      comment: "Number of unique training programs completed, indicating program diversity"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action plan effectiveness metrics tracking remediation progress, cost variance, milestone completion, and escalation for institutional accountability"
  source: "`education_ecm`.`compliance`.`corrective_action`"
  dimensions:
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of corrective action (e.g., Open, In Progress, Complete, Closed) for tracking remediation"
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status (e.g., Closed, Pending Verification, Reopened) for final resolution tracking"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level (e.g., Critical, High, Medium, Low) for prioritization and resource allocation"
    - name: "finding_source"
      expr: finding_source
      comment: "Source of finding (e.g., Internal Audit, External Audit, Accreditation Review) for root cause analysis"
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether escalation is required, indicating unresolved or high-risk issues"
    - name: "board_notification_required"
      expr: board_notification_required
      comment: "Whether board notification is required, indicating institutional significance"
    - name: "external_reporting_required"
      expr: external_reporting_required
      comment: "Whether external reporting is required, indicating regulatory implications"
    - name: "recurrence_risk"
      expr: recurrence_risk
      comment: "Risk of recurrence (e.g., High, Medium, Low) for preventive action planning"
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year corrective action is targeted for completion for planning"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions, baseline metric for remediation program volume"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all corrective actions, critical for budget planning"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of all corrective actions, key metric for cost control and variance analysis"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per corrective action, indicating typical remediation investment"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action, indicating realized remediation expense"
    - name: "completed_corrective_actions"
      expr: SUM(CASE WHEN corrective_action_status = 'Complete' THEN 1 ELSE 0 END)
      comment: "Count of completed corrective actions, key metric for remediation progress"
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_status = 'Complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions completed, critical metric for institutional accountability and compliance effectiveness"
    - name: "actions_requiring_escalation"
      expr: SUM(CASE WHEN escalation_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of actions requiring escalation, indicating unresolved high-risk issues"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of actions requiring escalation, key indicator of remediation challenges and institutional risk"
    - name: "actions_requiring_board_notification"
      expr: SUM(CASE WHEN board_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of actions requiring board notification, indicating governance-level issues"
    - name: "actions_requiring_external_reporting"
      expr: SUM(CASE WHEN external_reporting_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of actions requiring external reporting, indicating regulatory compliance obligations"
    - name: "total_milestones"
      expr: SUM(CAST(milestone_count AS BIGINT))
      comment: "Total milestones across all corrective actions, indicating program complexity"
    - name: "total_milestones_completed"
      expr: SUM(CAST(milestones_completed AS BIGINT))
      comment: "Total milestones completed, key metric for remediation progress tracking"
    - name: "distinct_responsible_units"
      expr: COUNT(DISTINCT org_unit_id)
      comment: "Number of unique organizational units responsible for corrective actions, indicating breadth of accountability"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_ferpa_disclosure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FERPA disclosure compliance metrics tracking consent adherence, redisclosure restrictions, student notification, and audit review for student privacy protection"
  source: "`education_ecm`.`compliance`.`ferpa_disclosure`"
  dimensions:
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Status of disclosure (e.g., Approved, Pending, Denied) for tracking authorization workflow"
    - name: "disclosure_purpose"
      expr: disclosure_purpose
      comment: "Purpose of disclosure (e.g., Academic, Financial Aid, Research) for compliance categorization"
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of recipient (e.g., Parent, School Official, Third Party) for risk assessment"
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for disclosure (e.g., Consent, FERPA Exception, Court Order) for regulatory compliance"
    - name: "consent_obtained_flag"
      expr: consent_obtained_flag
      comment: "Whether student consent was obtained, critical for FERPA compliance"
    - name: "redisclosure_restriction_flag"
      expr: redisclosure_restriction_flag
      comment: "Whether redisclosure restrictions apply, indicating privacy protection level"
    - name: "student_notification_flag"
      expr: student_notification_flag
      comment: "Whether student was notified of disclosure, required for certain FERPA exceptions"
    - name: "audit_review_flag"
      expr: audit_review_flag
      comment: "Whether disclosure was subject to audit review, indicating compliance oversight"
    - name: "disclosure_year"
      expr: YEAR(disclosure_date)
      comment: "Year of disclosure for trend analysis"
    - name: "disclosure_method"
      expr: disclosure_method
      comment: "Method of disclosure (e.g., Email, Portal, Mail, In Person) for process analysis"
  measures:
    - name: "total_disclosures"
      expr: COUNT(1)
      comment: "Total number of FERPA disclosures, baseline metric for student privacy program volume"
    - name: "disclosures_with_consent"
      expr: SUM(CASE WHEN consent_obtained_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disclosures with student consent, key compliance metric for FERPA adherence"
    - name: "consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures with consent, critical metric for privacy compliance and risk management"
    - name: "disclosures_with_redisclosure_restriction"
      expr: SUM(CASE WHEN redisclosure_restriction_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disclosures with redisclosure restrictions, indicating enhanced privacy protection"
    - name: "redisclosure_restriction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN redisclosure_restriction_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures with redisclosure restrictions, metric for privacy control effectiveness"
    - name: "disclosures_with_student_notification"
      expr: SUM(CASE WHEN student_notification_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disclosures where student was notified, compliance metric for transparency"
    - name: "student_notification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN student_notification_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures with student notification, key metric for FERPA transparency requirements"
    - name: "disclosures_audited"
      expr: SUM(CASE WHEN audit_review_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disclosures subject to audit review, indicating compliance oversight coverage"
    - name: "audit_review_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN audit_review_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures audited, metric for compliance monitoring effectiveness"
    - name: "distinct_students_disclosed"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students whose records were disclosed, indicating privacy exposure breadth"
    - name: "distinct_recipient_organizations"
      expr: COUNT(DISTINCT recipient_organization)
      comment: "Number of unique recipient organizations, indicating third-party data sharing scope"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_ipeds_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IPEDS submission quality and timeliness metrics tracking data quality scores, late submissions, revisions, and imputation for federal reporting compliance"
  source: "`education_ecm`.`compliance`.`ipeds_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of IPEDS submission (e.g., Draft, Submitted, Accepted, Locked) for tracking workflow"
    - name: "survey_component"
      expr: survey_component
      comment: "IPEDS survey component (e.g., Enrollment, Finance, Graduation Rates) for reporting segmentation"
    - name: "survey_year"
      expr: survey_year
      comment: "Survey year for trend analysis and year-over-year comparison"
    - name: "is_late_submission"
      expr: is_late_submission
      comment: "Whether submission was late, indicating compliance risk and process issues"
    - name: "is_revision"
      expr: is_revision
      comment: "Whether submission is a revision, indicating data quality issues"
    - name: "imputation_flag"
      expr: imputation_flag
      comment: "Whether NCES imputed data, indicating incomplete or missing data"
    - name: "submission_method"
      expr: submission_method
      comment: "Method of submission (e.g., Web, Upload, API) for process analysis"
    - name: "responsible_office"
      expr: responsible_office
      comment: "Office responsible for submission for accountability tracking"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of IPEDS submissions, baseline metric for federal reporting volume"
    - name: "late_submissions"
      expr: SUM(CASE WHEN is_late_submission = TRUE THEN 1 ELSE 0 END)
      comment: "Count of late submissions, critical compliance risk indicator for federal reporting"
    - name: "late_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_late_submission = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions that were late, key metric for compliance timeliness and process effectiveness"
    - name: "revisions"
      expr: SUM(CASE WHEN is_revision = TRUE THEN 1 ELSE 0 END)
      comment: "Count of revised submissions, indicating data quality issues and rework"
    - name: "revision_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_revision = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions requiring revision, key quality metric for data accuracy and process maturity"
    - name: "submissions_with_imputation"
      expr: SUM(CASE WHEN imputation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of submissions with NCES imputation, indicating incomplete data submission"
    - name: "imputation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN imputation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions with imputation, metric for data completeness and collection effectiveness"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across submissions, critical metric for institutional data integrity"
    - name: "total_edit_errors"
      expr: SUM(CAST(edit_report_error_count AS BIGINT))
      comment: "Total edit report errors across all submissions, key quality indicator for data validation"
    - name: "total_edit_warnings"
      expr: SUM(CAST(edit_report_warning_count AS BIGINT))
      comment: "Total edit report warnings across all submissions, quality metric for data review"
    - name: "avg_errors_per_submission"
      expr: AVG(CAST(edit_report_error_count AS BIGINT))
      comment: "Average errors per submission, indicating typical data quality issues"
    - name: "distinct_survey_components"
      expr: COUNT(DISTINCT survey_component)
      comment: "Number of unique survey components submitted, indicating reporting breadth"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_regulatory_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory requirement compliance metrics tracking active requirements, compliance status, training adherence, and audit results for institutional risk management"
  source: "`education_ecm`.`compliance`.`regulatory_requirement`"
  dimensions:
    - name: "requirement_type"
      expr: requirement_type
      comment: "Type of requirement (e.g., Federal, State, Accreditation, Institutional) for regulatory segmentation"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body imposing requirement (e.g., ED, HHS, DOL, State Agency) for oversight tracking"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (e.g., Compliant, Non-Compliant, Partially Compliant) for risk assessment"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level (e.g., Critical, High, Medium, Low) for prioritization and resource allocation"
    - name: "active_flag"
      expr: active_flag
      comment: "Whether requirement is currently active, for filtering current obligations"
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Whether training is required for compliance, indicating education obligations"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of required reporting (e.g., Annual, Quarterly, Monthly) for workload planning"
    - name: "last_audit_result"
      expr: last_audit_result
      comment: "Result of last audit (e.g., Satisfactory, Needs Improvement, Unsatisfactory) for performance tracking"
  measures:
    - name: "total_requirements"
      expr: COUNT(1)
      comment: "Total number of regulatory requirements, baseline metric for compliance program scope"
    - name: "active_requirements"
      expr: SUM(CASE WHEN active_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active requirements, key metric for current compliance obligations"
    - name: "compliant_requirements"
      expr: SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END)
      comment: "Count of compliant requirements, critical metric for institutional compliance health"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requirements in compliance, key executive metric for regulatory risk and institutional performance"
    - name: "non_compliant_requirements"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Count of non-compliant requirements, critical risk indicator for immediate action"
    - name: "non_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requirements non-compliant, key risk metric for executive escalation"
    - name: "requirements_requiring_training"
      expr: SUM(CASE WHEN training_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requirements requiring training, indicating education program scope"
    - name: "training_requirement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN training_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requirements requiring training, metric for training program planning"
    - name: "high_risk_requirements"
      expr: SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high-risk requirements, critical metric for risk prioritization"
    - name: "critical_risk_requirements"
      expr: SUM(CASE WHEN risk_level = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical-risk requirements, highest-priority metric for executive attention"
    - name: "distinct_regulatory_bodies"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Number of unique regulatory bodies, indicating regulatory complexity and oversight breadth"
    - name: "distinct_responsible_units"
      expr: COUNT(DISTINCT org_unit_id)
      comment: "Number of unique organizational units responsible for requirements, indicating accountability distribution"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enterprise risk assessment metrics tracking inherent and residual risk scores, financial impact, control effectiveness, and mitigation progress for institutional risk management"
  source: "`education_ecm`.`compliance`.`risk_assessment`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g., Compliance, Financial, Operational, Reputational) for strategic risk segmentation"
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Subcategory of risk for detailed risk taxonomy"
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of risk (e.g., Active, Mitigated, Closed, Monitoring) for tracking lifecycle"
    - name: "inherent_risk_score"
      expr: inherent_risk_score
      comment: "Inherent risk score before controls (e.g., High, Medium, Low) for baseline risk assessment"
    - name: "residual_risk_score"
      expr: residual_risk_score
      comment: "Residual risk score after controls (e.g., High, Medium, Low) for current risk exposure"
    - name: "control_effectiveness"
      expr: control_effectiveness
      comment: "Effectiveness of controls (e.g., Effective, Partially Effective, Ineffective) for mitigation assessment"
    - name: "risk_trend"
      expr: risk_trend
      comment: "Trend of risk over time (e.g., Increasing, Stable, Decreasing) for monitoring"
    - name: "active_flag"
      expr: active_flag
      comment: "Whether risk is currently active, for filtering current risk portfolio"
    - name: "accreditation_impact_flag"
      expr: accreditation_impact_flag
      comment: "Whether risk impacts accreditation, indicating strategic significance"
    - name: "board_reporting_required_flag"
      expr: board_reporting_required_flag
      comment: "Whether risk requires board reporting, indicating governance-level concern"
    - name: "external_reporting_required_flag"
      expr: external_reporting_required_flag
      comment: "Whether risk requires external reporting, indicating regulatory implications"
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of identified risks, baseline metric for enterprise risk portfolio size"
    - name: "active_risks"
      expr: SUM(CASE WHEN active_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active risks, key metric for current risk exposure"
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact across all risks, critical metric for financial risk exposure and capital planning"
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average estimated financial impact per risk, indicating typical risk magnitude"
    - name: "risks_with_accreditation_impact"
      expr: SUM(CASE WHEN accreditation_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risks impacting accreditation, critical strategic metric for institutional viability"
    - name: "accreditation_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accreditation_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks impacting accreditation, key metric for strategic risk concentration"
    - name: "risks_requiring_board_reporting"
      expr: SUM(CASE WHEN board_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risks requiring board reporting, indicating governance-level risk exposure"
    - name: "risks_requiring_external_reporting"
      expr: SUM(CASE WHEN external_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risks requiring external reporting, indicating regulatory risk exposure"
    - name: "high_inherent_risks"
      expr: SUM(CASE WHEN inherent_risk_score = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high inherent risks, baseline metric for uncontrolled risk exposure"
    - name: "high_residual_risks"
      expr: SUM(CASE WHEN residual_risk_score = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high residual risks after controls, critical metric for current risk exposure requiring action"
    - name: "effective_controls"
      expr: SUM(CASE WHEN control_effectiveness = 'Effective' THEN 1 ELSE 0 END)
      comment: "Count of risks with effective controls, key metric for risk mitigation success"
    - name: "control_effectiveness_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN control_effectiveness = 'Effective' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks with effective controls, critical metric for risk management program effectiveness"
    - name: "distinct_risk_owners"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique risk owners, indicating accountability distribution across organization"
$$;


CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_title_ix_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Title IX case management metrics tracking case resolution, appeal rates, investigation timeliness, and sanctions for institutional compliance and student safety"
  source: "`education_ecm`.`compliance`.`title_ix_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current case status (e.g., Open, Under Investigation, Closed) for tracking workflow"
    - name: "case_type"
      expr: case_type
      comment: "Type of case (e.g., Sexual Harassment, Sexual Assault, Dating Violence) for categorization"
    - name: "complainant_type"
      expr: complainant_type
      comment: "Type of complainant (e.g., Student, Employee, Third Party) for demographic analysis"
    - name: "respondent_type"
      expr: respondent_type
      comment: "Type of respondent (e.g., Student, Employee, Third Party) for demographic analysis"
    - name: "determination_outcome"
      expr: determination_outcome
      comment: "Outcome of investigation (e.g., Responsible, Not Responsible, Insufficient Evidence) for resolution tracking"
    - name: "grievance_process_type"
      expr: grievance_process_type
      comment: "Type of grievance process (e.g., Formal, Informal, Alternative Resolution) for process analysis"
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether appeal was filed, indicating contested determinations"
    - name: "clery_reportable_flag"
      expr: clery_reportable_flag
      comment: "Whether case is Clery reportable, indicating public disclosure requirements"
    - name: "law_enforcement_notified_flag"
      expr: law_enforcement_notified_flag
      comment: "Whether law enforcement was notified, indicating criminal implications"
    - name: "interim_measures_flag"
      expr: interim_measures_flag
      comment: "Whether interim measures were implemented, indicating immediate protective actions"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year of incident for trend analysis"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of Title IX cases, baseline metric for institutional sexual misconduct volume"
    - name: "open_cases"
      expr: SUM(CASE WHEN case_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of open cases, key metric for current caseload and resource planning"
    - name: "closed_cases"
      expr: SUM(CASE WHEN case_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of closed cases, metric for case resolution progress"
    - name: "cases_with_responsible_finding"
      expr: SUM(CASE WHEN determination_outcome = 'Responsible' THEN 1 ELSE 0 END)
      comment: "Count of cases with responsible finding, key metric for policy violation rate"
    - name: "responsible_finding_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN determination_outcome = 'Responsible' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with responsible finding, critical metric for institutional accountability and investigation effectiveness"
    - name: "cases_with_appeals"
      expr: SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases with appeals filed, indicating contested determinations"
    - name: "appeal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases appealed, key metric for determination quality and process fairness"
    - name: "clery_reportable_cases"
      expr: SUM(CASE WHEN clery_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Clery reportable cases, critical metric for federal compliance and public disclosure"
    - name: "cases_with_law_enforcement_notification"
      expr: SUM(CASE WHEN law_enforcement_notified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases where law enforcement was notified, indicating criminal investigation coordination"
    - name: "cases_with_interim_measures"
      expr: SUM(CASE WHEN interim_measures_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases with interim measures, indicating immediate protective action taken"
    - name: "interim_measures_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN interim_measures_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with interim measures, metric for proactive student safety response"
    - name: "distinct_complainants"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique complainants, indicating breadth of individuals reporting misconduct"
$$;
