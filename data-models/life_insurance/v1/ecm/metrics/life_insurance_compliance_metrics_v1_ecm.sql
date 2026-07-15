-- Metric views for domain: compliance | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_aml_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anti-Money Laundering alert monitoring and investigation effectiveness metrics"
  source: "`life_insurance_ecm`.`compliance`.`aml_alert`"
  dimensions:
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity classification of the AML alert (High, Medium, Low)"
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert (Open, Under Investigation, Closed, Escalated)"
    - name: "alert_type"
      expr: alert_type
      comment: "Type of suspicious activity detected"
    - name: "detection_scenario"
      expr: detection_scenario_name
      comment: "Name of the detection scenario that triggered the alert"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Final disposition classification of the alert"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing this alert"
    - name: "detection_year"
      expr: YEAR(detection_timestamp)
      comment: "Year the alert was detected"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month the alert was detected"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the alert was escalated for further review"
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Whether the alert was determined to be a false positive"
    - name: "sar_filed_flag"
      expr: sar_filed_flag
      comment: "Whether a Suspicious Activity Report was filed"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of AML alerts generated"
    - name: "total_alert_amount"
      expr: SUM(CAST(alert_amount AS DOUBLE))
      comment: "Total dollar amount across all alerts"
    - name: "avg_alert_amount"
      expr: AVG(CAST(alert_amount AS DOUBLE))
      comment: "Average dollar amount per alert"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across alerts"
    - name: "escalated_alerts"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of alerts escalated for further investigation"
    - name: "false_positive_alerts"
      expr: SUM(CASE WHEN false_positive_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of alerts determined to be false positives"
    - name: "sar_filed_alerts"
      expr: SUM(CASE WHEN sar_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of alerts resulting in SAR filings"
    - name: "false_positive_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN false_positive_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts that are false positives - key efficiency metric"
    - name: "sar_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sar_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts that result in SAR filings - key effectiveness metric"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts escalated - indicates detection quality"
    - name: "unique_parties"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique parties involved in alerts"
    - name: "unique_policies"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of unique policies flagged in alerts"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing timeliness, accuracy, and compliance performance metrics"
  source: "`life_insurance_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing"
    - name: "filing_form_name"
      expr: filing_form_name
      comment: "Name of the regulatory form being filed"
    - name: "lead_state_code"
      expr: lead_state_code
      comment: "Lead state jurisdiction for the filing"
    - name: "filing_channel"
      expr: filing_channel
      comment: "Channel used for filing submission"
    - name: "late_filing_flag"
      expr: late_filing_flag
      comment: "Whether the filing was submitted late"
    - name: "is_amended"
      expr: is_amended
      comment: "Whether this is an amended filing"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the filing was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the filing was submitted"
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings"
    - name: "late_filings"
      expr: SUM(CASE WHEN late_filing_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of filings submitted after the due date"
    - name: "amended_filings"
      expr: SUM(CASE WHEN is_amended = TRUE THEN 1 ELSE 0 END)
      comment: "Number of amended filings - indicates initial filing quality issues"
    - name: "rejected_filings"
      expr: SUM(CASE WHEN rejection_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of filings rejected by regulators"
    - name: "total_penalties"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total dollar amount of penalties assessed"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per filing"
    - name: "on_time_filing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN late_filing_flag = FALSE OR late_filing_flag IS NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings submitted on time - key compliance metric"
    - name: "first_time_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_amended = FALSE OR is_amended IS NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings accepted without amendment - quality metric"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rejection_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings rejected - indicates submission quality"
    - name: "unique_legal_entities"
      expr: COUNT(DISTINCT legal_entity_id)
      comment: "Number of unique legal entities filing"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_exam_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory examination findings, remediation effectiveness, and compliance risk metrics"
  source: "`life_insurance_ecm`.`compliance`.`exam_finding`"
  dimensions:
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the examination finding"
    - name: "finding_type"
      expr: finding_type
      comment: "Type of examination finding"
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity level of the finding (Critical, High, Medium, Low)"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority that issued the finding"
    - name: "jurisdiction_state_code"
      expr: jurisdiction_state_code
      comment: "State jurisdiction of the finding"
    - name: "affected_business_process"
      expr: affected_business_process
      comment: "Business process impacted by the finding"
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Whether this is a repeat finding from prior examinations"
    - name: "identified_year"
      expr: YEAR(finding_identified_date)
      comment: "Year the finding was identified"
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', finding_identified_date)
      comment: "Month the finding was identified"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of examination findings"
    - name: "repeat_findings"
      expr: SUM(CASE WHEN is_repeat_finding = TRUE THEN 1 ELSE 0 END)
      comment: "Number of repeat findings - indicates persistent compliance gaps"
    - name: "critical_findings"
      expr: SUM(CASE WHEN severity_classification = 'Critical' THEN 1 ELSE 0 END)
      comment: "Number of critical severity findings"
    - name: "high_severity_findings"
      expr: SUM(CASE WHEN severity_classification = 'High' THEN 1 ELSE 0 END)
      comment: "Number of high severity findings"
    - name: "total_penalty_amount"
      expr: SUM(CAST(actual_penalty_amount AS DOUBLE))
      comment: "Total dollar amount of penalties assessed"
    - name: "total_financial_exposure"
      expr: SUM(CAST(estimated_financial_exposure AS DOUBLE))
      comment: "Total estimated financial exposure from findings"
    - name: "avg_penalty_per_finding"
      expr: AVG(CAST(actual_penalty_amount AS DOUBLE))
      comment: "Average penalty amount per finding"
    - name: "remediated_findings"
      expr: SUM(CASE WHEN actual_remediation_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of findings that have been remediated"
    - name: "overdue_findings"
      expr: SUM(CASE WHEN target_remediation_date < CURRENT_DATE() AND actual_remediation_date IS NULL THEN 1 ELSE 0 END)
      comment: "Number of findings past their target remediation date"
    - name: "repeat_finding_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_finding = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeats - key remediation effectiveness metric"
    - name: "timely_remediation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_remediation_date <= target_remediation_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN actual_remediation_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of findings remediated by target date - remediation efficiency metric"
    - name: "unique_exams"
      expr: COUNT(DISTINCT market_conduct_exam_id)
      comment: "Number of unique market conduct examinations"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training completion, effectiveness, and regulatory education metrics"
  source: "`life_insurance_ecm`.`compliance`.`compliance_training_completion`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Status of the training completion"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Whether the trainee passed or failed"
    - name: "course_category"
      expr: course_category
      comment: "Category of the compliance training course"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the training"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the training is mandatory"
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Whether the training is required by regulation"
    - name: "jurisdiction_state_code"
      expr: jurisdiction_state_code
      comment: "State jurisdiction requiring the training"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the training requirement"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year the training was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the training was completed"
  measures:
    - name: "total_completions"
      expr: COUNT(1)
      comment: "Total number of training completions"
    - name: "passed_completions"
      expr: SUM(CASE WHEN pass_fail_status = 'Pass' THEN 1 ELSE 0 END)
      comment: "Number of training completions with passing status"
    - name: "failed_completions"
      expr: SUM(CASE WHEN pass_fail_status = 'Fail' THEN 1 ELSE 0 END)
      comment: "Number of training completions with failing status"
    - name: "overdue_completions"
      expr: SUM(CASE WHEN completion_date > due_date THEN 1 ELSE 0 END)
      comment: "Number of training completions submitted after due date"
    - name: "total_credit_hours"
      expr: SUM(CAST(credit_hours AS DOUBLE))
      comment: "Total continuing education credit hours earned"
    - name: "avg_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average score across all training completions"
    - name: "avg_credit_hours"
      expr: AVG(CAST(credit_hours AS DOUBLE))
      comment: "Average credit hours per completion"
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_status = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions with passing status - training effectiveness metric"
    - name: "on_time_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_date <= due_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completed by due date - compliance adherence metric"
    - name: "first_attempt_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_status = 'Pass' AND attempt_number = '1' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN attempt_number = '1' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage passing on first attempt - training quality metric"
    - name: "unique_trainees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees completing training"
    - name: "unique_courses"
      expr: COUNT(DISTINCT training_course_id)
      comment: "Number of unique training courses completed"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy breach and data incident response effectiveness metrics"
  source: "`life_insurance_ecm`.`compliance`.`privacy_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the privacy incident"
    - name: "incident_type"
      expr: incident_type
      comment: "Type of privacy incident"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the incident"
    - name: "is_breach_determined"
      expr: is_breach_determined
      comment: "Whether the incident was determined to be a reportable breach"
    - name: "includes_ssn"
      expr: includes_ssn
      comment: "Whether the incident involved Social Security Numbers"
    - name: "includes_health_information"
      expr: includes_health_information
      comment: "Whether the incident involved protected health information"
    - name: "includes_financial_account"
      expr: includes_financial_account
      comment: "Whether the incident involved financial account information"
    - name: "jurisdiction_state_code"
      expr: jurisdiction_state_code
      comment: "State jurisdiction of the incident"
    - name: "discovery_year"
      expr: YEAR(discovery_date)
      comment: "Year the incident was discovered"
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month the incident was discovered"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of privacy incidents"
    - name: "reportable_breaches"
      expr: SUM(CASE WHEN is_breach_determined = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents determined to be reportable breaches"
    - name: "incidents_with_ssn"
      expr: SUM(CASE WHEN includes_ssn = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents involving Social Security Numbers"
    - name: "incidents_with_phi"
      expr: SUM(CASE WHEN includes_health_information = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents involving protected health information"
    - name: "incidents_requiring_media_notification"
      expr: SUM(CASE WHEN media_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents requiring media notification - indicates severity"
    - name: "overdue_remediations"
      expr: SUM(CASE WHEN remediation_due_date < CURRENT_DATE() AND remediation_completed_date IS NULL THEN 1 ELSE 0 END)
      comment: "Number of incidents with overdue remediation"
    - name: "breach_determination_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_breach_determined = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents determined to be reportable breaches - severity metric"
    - name: "timely_remediation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_completed_date <= remediation_due_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN remediation_completed_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of incidents remediated by due date - response effectiveness metric"
    - name: "unique_affected_parties"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique parties affected by incidents"
    - name: "unique_involved_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors involved in incidents"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_sox_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sarbanes-Oxley internal control effectiveness and testing metrics"
  source: "`life_insurance_ecm`.`compliance`.`sox_control`"
  dimensions:
    - name: "control_status"
      expr: control_status
      comment: "Current status of the SOX control"
    - name: "control_type"
      expr: control_type
      comment: "Type of SOX control (Preventive, Detective, Corrective)"
    - name: "control_category"
      expr: control_category
      comment: "Category of the SOX control"
    - name: "control_level"
      expr: control_level
      comment: "Level of the control (Entity, Process, Transaction)"
    - name: "is_key_control"
      expr: is_key_control
      comment: "Whether this is a key control"
    - name: "is_itgc"
      expr: is_itgc
      comment: "Whether this is an IT General Control"
    - name: "last_test_result"
      expr: last_test_result
      comment: "Result of the most recent control test"
    - name: "deficiency_rating"
      expr: deficiency_rating
      comment: "Severity rating of any identified deficiency"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the control"
    - name: "financial_statement_area"
      expr: financial_statement_area
      comment: "Financial statement area covered by the control"
    - name: "business_process"
      expr: business_process
      comment: "Business process covered by the control"
    - name: "sox_scope_year"
      expr: sox_scope_year
      comment: "SOX scope year for the control"
  measures:
    - name: "total_controls"
      expr: COUNT(1)
      comment: "Total number of SOX controls"
    - name: "key_controls"
      expr: SUM(CASE WHEN is_key_control = TRUE THEN 1 ELSE 0 END)
      comment: "Number of key controls - critical for financial reporting"
    - name: "itgc_controls"
      expr: SUM(CASE WHEN is_itgc = TRUE THEN 1 ELSE 0 END)
      comment: "Number of IT General Controls"
    - name: "controls_with_deficiencies"
      expr: SUM(CASE WHEN deficiency_rating IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of controls with identified deficiencies"
    - name: "controls_requiring_remediation"
      expr: SUM(CASE WHEN remediation_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of controls requiring remediation"
    - name: "overdue_remediations"
      expr: SUM(CASE WHEN remediation_due_date < CURRENT_DATE() AND remediation_completion_date IS NULL AND remediation_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of controls with overdue remediation"
    - name: "controls_tested"
      expr: SUM(CASE WHEN last_test_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of controls that have been tested"
    - name: "controls_passed"
      expr: SUM(CASE WHEN last_test_result = 'Pass' OR last_test_result = 'Effective' THEN 1 ELSE 0 END)
      comment: "Number of controls that passed testing"
    - name: "control_effectiveness_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN last_test_result = 'Pass' OR last_test_result = 'Effective' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN last_test_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of tested controls that are effective - key SOX compliance metric"
    - name: "deficiency_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN deficiency_rating IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls with deficiencies - control quality metric"
    - name: "timely_remediation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_completion_date <= remediation_due_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN remediation_completion_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of remediations completed by due date - remediation effectiveness metric"
    - name: "unique_legal_entities"
      expr: COUNT(DISTINCT legal_entity_id)
      comment: "Number of unique legal entities with SOX controls"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_policy_form_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insurance policy form and rate filing approval efficiency and regulatory compliance metrics"
  source: "`life_insurance_ecm`.`compliance`.`policy_form_approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the policy form"
    - name: "form_type"
      expr: form_type
      comment: "Type of policy form"
    - name: "product_line"
      expr: product_line
      comment: "Product line of the policy form"
    - name: "jurisdiction_state_code"
      expr: jurisdiction_state_code
      comment: "State jurisdiction for the filing"
    - name: "filing_method"
      expr: filing_method
      comment: "Method used for filing (File and Use, Prior Approval, etc.)"
    - name: "is_currently_approved"
      expr: is_currently_approved
      comment: "Whether the form is currently approved for use"
    - name: "is_in_use"
      expr: is_in_use
      comment: "Whether the form is currently in use"
    - name: "variable_product_flag"
      expr: variable_product_flag
      comment: "Whether this is a variable product requiring SEC registration"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the form was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the form was submitted"
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of policy form filings"
    - name: "approved_filings"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Number of filings with approved status"
    - name: "disapproved_filings"
      expr: SUM(CASE WHEN approval_status = 'Disapproved' THEN 1 ELSE 0 END)
      comment: "Number of filings that were disapproved"
    - name: "withdrawn_filings"
      expr: SUM(CASE WHEN withdrawal_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of filings that were withdrawn"
    - name: "forms_in_use"
      expr: SUM(CASE WHEN is_in_use = TRUE THEN 1 ELSE 0 END)
      comment: "Number of forms currently in use"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings approved - regulatory approval effectiveness metric"
    - name: "disapproval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'Disapproved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings disapproved - indicates filing quality issues"
    - name: "withdrawal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN withdrawal_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings withdrawn - indicates pre-approval issues"
    - name: "unique_plans"
      expr: COUNT(DISTINCT plan_id)
      comment: "Number of unique insurance plans filed"
    - name: "unique_legal_entities"
      expr: COUNT(DISTINCT legal_entity_id)
      comment: "Number of unique legal entities filing forms"
$$;


CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`compliance_suitability_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insurance product suitability and best interest standard compliance metrics"
  source: "`life_insurance_ecm`.`compliance`.`suitability_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the suitability review"
    - name: "review_type"
      expr: review_type
      comment: "Type of suitability review conducted"
    - name: "suitability_determination"
      expr: suitability_determination
      comment: "Final suitability determination (Suitable, Not Suitable, Conditional)"
    - name: "product_type"
      expr: product_type
      comment: "Type of insurance product reviewed"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the review (Reg BI, NAIC, State)"
    - name: "is_replacement"
      expr: is_replacement
      comment: "Whether this is a replacement transaction"
    - name: "is_1035_exchange"
      expr: is_1035_exchange
      comment: "Whether this is a 1035 exchange"
    - name: "override_flag"
      expr: override_flag
      comment: "Whether a suitability override was applied"
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Whether remediation is required"
    - name: "jurisdiction_state_code"
      expr: jurisdiction_state_code
      comment: "State jurisdiction of the review"
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year the review was conducted"
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month the review was conducted"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of suitability reviews conducted"
    - name: "suitable_determinations"
      expr: SUM(CASE WHEN suitability_determination = 'Suitable' THEN 1 ELSE 0 END)
      comment: "Number of reviews with suitable determination"
    - name: "not_suitable_determinations"
      expr: SUM(CASE WHEN suitability_determination = 'Not Suitable' THEN 1 ELSE 0 END)
      comment: "Number of reviews with not suitable determination"
    - name: "reviews_with_override"
      expr: SUM(CASE WHEN override_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reviews with suitability override - indicates exception processing"
    - name: "reviews_requiring_remediation"
      expr: SUM(CASE WHEN remediation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reviews requiring remediation"
    - name: "replacement_transactions"
      expr: SUM(CASE WHEN is_replacement = TRUE THEN 1 ELSE 0 END)
      comment: "Number of replacement transactions - higher regulatory scrutiny"
    - name: "total_investment_amount"
      expr: SUM(CAST(investment_amount AS DOUBLE))
      comment: "Total dollar amount of investments reviewed"
    - name: "avg_investment_amount"
      expr: AVG(CAST(investment_amount AS DOUBLE))
      comment: "Average investment amount per review"
    - name: "suitability_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN suitability_determination = 'Suitable' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews with suitable determination - key compliance metric"
    - name: "override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews requiring override - indicates process friction"
    - name: "replacement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_replacement = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions that are replacements - regulatory risk indicator"
    - name: "unique_producers"
      expr: COUNT(DISTINCT producer_id)
      comment: "Number of unique producers with suitability reviews"
    - name: "unique_parties"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique parties reviewed for suitability"
$$;
