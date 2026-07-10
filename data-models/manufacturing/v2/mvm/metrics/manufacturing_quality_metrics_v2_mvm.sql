-- Metric views for domain: quality | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 14:39:56

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-Conformance Report (NCR) metrics tracking quality issues, defect rates, containment effectiveness, and regulatory compliance across production, procurement, and customer-facing operations."
  source: "`vibe_manufacturing_v1`.`quality`.`ncr`"
  dimensions:
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current status of the non-conformance report (open, closed, pending disposition, etc.)"
    - name: "ncr_type"
      expr: ncr_type
      comment: "Classification of non-conformance (supplier, internal, customer, field failure, etc.)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the non-conformance (critical, major, minor)"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision (use-as-is, rework, scrap, return to supplier, etc.)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level category of root cause (material, process, equipment, human error, design, etc.)"
    - name: "detection_source"
      expr: detection_source
      comment: "Where the non-conformance was detected (incoming inspection, in-process, final inspection, customer site, etc.)"
    - name: "defect_code"
      expr: defect_code
      comment: "Standardized defect code for categorization and trend analysis"
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Whether this NCR requires regulatory reporting (True/False)"
    - name: "is_8d_required"
      expr: is_8d_required
      comment: "Whether an 8D problem-solving report is required (True/False)"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Whether customer notification is required (True/False)"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month when the non-conformance was detected"
    - name: "detection_quarter"
      expr: DATE_TRUNC('QUARTER', detection_timestamp)
      comment: "Quarter when the non-conformance was detected"
    - name: "detection_year"
      expr: YEAR(detection_timestamp)
      comment: "Year when the non-conformance was detected"
    - name: "closure_month"
      expr: DATE_TRUNC('MONTH', actual_closure_date)
      comment: "Month when the NCR was closed"
  measures:
    - name: "total_ncr_count"
      expr: COUNT(1)
      comment: "Total number of non-conformance reports"
    - name: "total_nonconforming_quantity"
      expr: SUM(CAST(nonconforming_qty AS DOUBLE))
      comment: "Total quantity of nonconforming units across all NCRs"
    - name: "avg_nonconforming_quantity"
      expr: AVG(CAST(nonconforming_qty AS DOUBLE))
      comment: "Average quantity of nonconforming units per NCR"
    - name: "critical_ncr_count"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Count of NCRs classified as critical severity"
    - name: "regulatory_reportable_count"
      expr: COUNT(CASE WHEN regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of NCRs requiring regulatory reporting"
    - name: "customer_notification_count"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN 1 END)
      comment: "Count of NCRs requiring customer notification"
    - name: "eight_d_required_count"
      expr: COUNT(CASE WHEN is_8d_required = TRUE THEN 1 END)
      comment: "Count of NCRs requiring 8D problem-solving methodology"
    - name: "containment_completed_count"
      expr: COUNT(CASE WHEN containment_completed_date IS NOT NULL THEN 1 END)
      comment: "Count of NCRs with completed containment actions"
    - name: "closed_ncr_count"
      expr: COUNT(CASE WHEN actual_closure_date IS NOT NULL THEN 1 END)
      comment: "Count of NCRs that have been closed"
    - name: "avg_days_to_containment"
      expr: AVG(DATEDIFF(containment_completed_date, detection_timestamp))
      comment: "Average number of days from detection to containment completion"
    - name: "avg_days_to_closure"
      expr: AVG(DATEDIFF(actual_closure_date, detection_timestamp))
      comment: "Average number of days from detection to NCR closure"
    - name: "overdue_ncr_count"
      expr: COUNT(CASE WHEN target_closure_date < CURRENT_DATE() AND actual_closure_date IS NULL THEN 1 END)
      comment: "Count of NCRs past their target closure date and still open"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) metrics tracking quality improvement initiatives, root cause resolution effectiveness, and continuous improvement program performance."
  source: "`vibe_manufacturing_v1`.`quality`.`capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (open, in progress, closed, verified, etc.)"
    - name: "capa_type"
      expr: capa_type
      comment: "Type of action (corrective, preventive, or both)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAPA (high, medium, low)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level category of root cause identified"
    - name: "root_cause_analysis_method"
      expr: root_cause_analysis_method
      comment: "Method used for root cause analysis (5-Why, Fishbone, FMEA, etc.)"
    - name: "source_type"
      expr: source_type
      comment: "Source that triggered the CAPA (NCR, customer complaint, audit, internal review, etc.)"
    - name: "affected_process_code"
      expr: affected_process_code
      comment: "Process area affected by the issue"
    - name: "department_code"
      expr: department_code
      comment: "Department responsible for the CAPA"
    - name: "effectiveness_verified"
      expr: effectiveness_verified
      comment: "Whether the CAPA effectiveness has been verified (True/False)"
    - name: "effectiveness_verification_method"
      expr: effectiveness_verification_method
      comment: "Method used to verify CAPA effectiveness"
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Whether the CAPA has regulatory implications (True/False)"
    - name: "ppap_impact_flag"
      expr: ppap_impact_flag
      comment: "Whether the CAPA impacts Production Part Approval Process (True/False)"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring issue (True/False)"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Whether customer notification is required (True/False)"
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month when the CAPA was initiated"
    - name: "initiated_quarter"
      expr: DATE_TRUNC('QUARTER', initiated_date)
      comment: "Quarter when the CAPA was initiated"
    - name: "initiated_year"
      expr: YEAR(initiated_date)
      comment: "Year when the CAPA was initiated"
  measures:
    - name: "total_capa_count"
      expr: COUNT(1)
      comment: "Total number of CAPA records"
    - name: "open_capa_count"
      expr: COUNT(CASE WHEN actual_closure_date IS NULL THEN 1 END)
      comment: "Count of CAPAs that are still open"
    - name: "closed_capa_count"
      expr: COUNT(CASE WHEN actual_closure_date IS NOT NULL THEN 1 END)
      comment: "Count of CAPAs that have been closed"
    - name: "effectiveness_verified_count"
      expr: COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END)
      comment: "Count of CAPAs with verified effectiveness"
    - name: "recurrence_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs addressing recurring issues"
    - name: "regulatory_impact_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs with regulatory impact"
    - name: "ppap_impact_count"
      expr: COUNT(CASE WHEN ppap_impact_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs impacting PPAP"
    - name: "avg_days_to_closure"
      expr: AVG(DATEDIFF(actual_closure_date, initiated_date))
      comment: "Average number of days from CAPA initiation to closure"
    - name: "avg_days_to_action_implementation"
      expr: AVG(DATEDIFF(action_implementation_date, initiated_date))
      comment: "Average number of days from initiation to action implementation"
    - name: "avg_days_to_effectiveness_verification"
      expr: AVG(DATEDIFF(effectiveness_verification_date, action_implementation_date))
      comment: "Average number of days from action implementation to effectiveness verification"
    - name: "overdue_capa_count"
      expr: COUNT(CASE WHEN target_closure_date < CURRENT_DATE() AND actual_closure_date IS NULL THEN 1 END)
      comment: "Count of CAPAs past their target closure date and still open"
    - name: "containment_completed_count"
      expr: COUNT(CASE WHEN containment_completion_date IS NOT NULL THEN 1 END)
      comment: "Count of CAPAs with completed containment actions"
    - name: "avg_days_to_containment"
      expr: AVG(DATEDIFF(containment_completion_date, initiated_date))
      comment: "Average number of days from initiation to containment completion"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint metrics tracking external quality issues, customer satisfaction impact, response effectiveness, and field failure patterns."
  source: "`vibe_manufacturing_v1`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the customer complaint"
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type or category of customer complaint"
    - name: "complaint_source"
      expr: complaint_source
      comment: "Source channel of the complaint (phone, email, web portal, field service, etc.)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the complaint (critical, high, medium, low)"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Mode of failure reported by customer"
    - name: "failure_code"
      expr: failure_code
      comment: "Standardized failure code for categorization"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level category of root cause identified"
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution provided (replacement, repair, refund, credit, etc.)"
    - name: "customer_acceptance_status"
      expr: customer_acceptance_status
      comment: "Whether customer accepted the resolution"
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Whether the complaint involves safety concerns (True/False)"
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Whether the complaint requires regulatory reporting (True/False)"
    - name: "defect_location"
      expr: defect_location
      comment: "Location or component where defect was found"
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month when the complaint was reported"
    - name: "reported_quarter"
      expr: DATE_TRUNC('QUARTER', reported_date)
      comment: "Quarter when the complaint was reported"
    - name: "reported_year"
      expr: YEAR(reported_date)
      comment: "Year when the complaint was reported"
  measures:
    - name: "total_complaint_count"
      expr: COUNT(1)
      comment: "Total number of customer complaints"
    - name: "open_complaint_count"
      expr: COUNT(CASE WHEN closure_date IS NULL THEN 1 END)
      comment: "Count of customer complaints still open"
    - name: "closed_complaint_count"
      expr: COUNT(CASE WHEN closure_date IS NOT NULL THEN 1 END)
      comment: "Count of customer complaints that have been closed"
    - name: "safety_related_count"
      expr: COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END)
      comment: "Count of complaints involving safety concerns"
    - name: "regulatory_reportable_count"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of complaints requiring regulatory reporting"
    - name: "critical_severity_count"
      expr: COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END)
      comment: "Count of complaints with critical severity"
    - name: "customer_accepted_count"
      expr: COUNT(CASE WHEN customer_acceptance_status = 'Accepted' THEN 1 END)
      comment: "Count of complaints where customer accepted the resolution"
    - name: "containment_completed_count"
      expr: COUNT(CASE WHEN containment_date IS NOT NULL THEN 1 END)
      comment: "Count of complaints with completed containment actions"
    - name: "corrective_action_completed_count"
      expr: COUNT(CASE WHEN corrective_action_completed_date IS NOT NULL THEN 1 END)
      comment: "Count of complaints with completed corrective actions"
    - name: "avg_days_to_response"
      expr: AVG(DATEDIFF(customer_response_date, reported_date))
      comment: "Average number of days from complaint reported to customer response"
    - name: "avg_days_to_containment"
      expr: AVG(DATEDIFF(containment_date, reported_date))
      comment: "Average number of days from complaint reported to containment"
    - name: "avg_days_to_closure"
      expr: AVG(DATEDIFF(closure_date, reported_date))
      comment: "Average number of days from complaint reported to closure"
    - name: "avg_days_to_corrective_action"
      expr: AVG(DATEDIFF(corrective_action_completed_date, reported_date))
      comment: "Average number of days from complaint reported to corrective action completion"
    - name: "overdue_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_due_date < CURRENT_DATE() AND corrective_action_completed_date IS NULL THEN 1 END)
      comment: "Count of complaints with overdue corrective actions"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection result metrics tracking quality control performance, process capability, defect rates, and statistical process control effectiveness across production and procurement."
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Status of the inspection result (pass, fail, conditional, etc.)"
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of inspection (incoming, in-process, final, etc.)"
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (visual, dimensional, functional, etc.)"
    - name: "characteristic_type"
      expr: characteristic_type
      comment: "Type of characteristic inspected (variable, attribute, etc.)"
    - name: "usage_decision_code"
      expr: usage_decision_code
      comment: "Decision code for material usage (accept, reject, rework, etc.)"
    - name: "defect_code"
      expr: defect_code
      comment: "Standardized defect code when defects are found"
    - name: "is_out_of_spec"
      expr: is_out_of_spec
      comment: "Whether the result is out of specification limits (True/False)"
    - name: "is_out_of_control"
      expr: is_out_of_control
      comment: "Whether the result is out of statistical control limits (True/False)"
    - name: "spc_chart_type"
      expr: spc_chart_type
      comment: "Type of SPC chart used (X-bar, R, p-chart, c-chart, etc.)"
    - name: "shift_code"
      expr: shift_code
      comment: "Production shift when inspection was performed"
    - name: "sampling_procedure"
      expr: sampling_procedure
      comment: "Sampling procedure used for inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month when inspection was performed"
    - name: "inspection_quarter"
      expr: DATE_TRUNC('QUARTER', inspection_date)
      comment: "Quarter when inspection was performed"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year when inspection was performed"
  measures:
    - name: "total_inspection_count"
      expr: COUNT(1)
      comment: "Total number of inspection results"
    - name: "passed_inspection_count"
      expr: COUNT(CASE WHEN result_status = 'Pass' THEN 1 END)
      comment: "Count of inspections that passed"
    - name: "failed_inspection_count"
      expr: COUNT(CASE WHEN result_status = 'Fail' THEN 1 END)
      comment: "Count of inspections that failed"
    - name: "out_of_spec_count"
      expr: COUNT(CASE WHEN is_out_of_spec = TRUE THEN 1 END)
      comment: "Count of results outside specification limits"
    - name: "out_of_control_count"
      expr: COUNT(CASE WHEN is_out_of_control = TRUE THEN 1 END)
      comment: "Count of results outside statistical control limits"
    - name: "rejected_count"
      expr: COUNT(CASE WHEN usage_decision_code = 'Reject' THEN 1 END)
      comment: "Count of inspection results leading to rejection"
    - name: "rework_count"
      expr: COUNT(CASE WHEN usage_decision_code = 'Rework' THEN 1 END)
      comment: "Count of inspection results requiring rework"
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total number of defects found across all inspections"
    - name: "avg_defect_count"
      expr: AVG(CAST(defect_count AS DOUBLE))
      comment: "Average number of defects per inspection"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all inspections"
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average process capability index (Cp) across inspections"
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average process capability index (Cpk) across inspections"
    - name: "min_cpk_index"
      expr: MIN(CAST(cpk_index AS DOUBLE))
      comment: "Minimum process capability index (Cpk) observed"
    - name: "capable_process_count"
      expr: COUNT(CASE WHEN CAST(cpk_index AS DOUBLE) >= 1.33 THEN 1 END)
      comment: "Count of inspections where Cpk meets capability threshold (>=1.33)"
    - name: "total_sample_size"
      expr: SUM(CAST(sample_size AS DOUBLE))
      comment: "Total sample size across all inspections"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot metrics tracking batch-level quality performance, lot disposition effectiveness, and material acceptance rates across incoming, in-process, and final inspection stages."
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the inspection lot"
    - name: "inspection_type_code"
      expr: inspection_type_code
      comment: "Code representing the type of inspection"
    - name: "inspection_type_description"
      expr: inspection_type_description
      comment: "Description of the inspection type"
    - name: "inspection_level"
      expr: inspection_level
      comment: "Inspection level (normal, reduced, tightened, etc.)"
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Code representing the disposition decision"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition decision (accept, reject, conditional, etc.)"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall result of the inspection lot (pass, fail, etc.)"
    - name: "ncr_triggered"
      expr: ncr_triggered
      comment: "Whether an NCR was triggered by this lot (True/False)"
    - name: "certificate_of_conformance_required"
      expr: certificate_of_conformance_required
      comment: "Whether a certificate of conformance is required (True/False)"
    - name: "sample_drawing_procedure"
      expr: sample_drawing_procedure
      comment: "Procedure used for sample drawing"
    - name: "dynamic_modification_rule"
      expr: dynamic_modification_rule
      comment: "Dynamic modification rule applied to inspection"
    - name: "inspection_start_month"
      expr: DATE_TRUNC('MONTH', inspection_start_timestamp)
      comment: "Month when inspection started"
    - name: "inspection_start_quarter"
      expr: DATE_TRUNC('QUARTER', inspection_start_timestamp)
      comment: "Quarter when inspection started"
    - name: "inspection_start_year"
      expr: YEAR(inspection_start_timestamp)
      comment: "Year when inspection started"
  measures:
    - name: "total_lot_count"
      expr: COUNT(1)
      comment: "Total number of inspection lots"
    - name: "accepted_lot_count"
      expr: COUNT(CASE WHEN disposition_decision = 'Accept' THEN 1 END)
      comment: "Count of inspection lots accepted"
    - name: "rejected_lot_count"
      expr: COUNT(CASE WHEN disposition_decision = 'Reject' THEN 1 END)
      comment: "Count of inspection lots rejected"
    - name: "passed_lot_count"
      expr: COUNT(CASE WHEN overall_result = 'Pass' THEN 1 END)
      comment: "Count of inspection lots that passed"
    - name: "failed_lot_count"
      expr: COUNT(CASE WHEN overall_result = 'Fail' THEN 1 END)
      comment: "Count of inspection lots that failed"
    - name: "ncr_triggered_count"
      expr: COUNT(CASE WHEN ncr_triggered = TRUE THEN 1 END)
      comment: "Count of inspection lots that triggered an NCR"
    - name: "total_lot_quantity"
      expr: SUM(CAST(lot_quantity AS DOUBLE))
      comment: "Total quantity across all inspection lots"
    - name: "total_nonconforming_quantity"
      expr: SUM(CAST(nonconforming_quantity AS DOUBLE))
      comment: "Total nonconforming quantity across all inspection lots"
    - name: "avg_lot_quantity"
      expr: AVG(CAST(lot_quantity AS DOUBLE))
      comment: "Average lot quantity per inspection lot"
    - name: "avg_sample_size"
      expr: AVG(CAST(sample_size AS DOUBLE))
      comment: "Average sample size per inspection lot"
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total defect count across all inspection lots"
    - name: "avg_defect_count"
      expr: AVG(CAST(defect_count AS DOUBLE))
      comment: "Average defect count per inspection lot"
    - name: "avg_inspection_duration_hours"
      expr: AVG((UNIX_TIMESTAMP(inspection_end_timestamp) - UNIX_TIMESTAMP(inspection_start_timestamp)) / 3600.0)
      comment: "Average inspection duration in hours from start to end"
    - name: "coc_required_count"
      expr: COUNT(CASE WHEN certificate_of_conformance_required = TRUE THEN 1 END)
      comment: "Count of inspection lots requiring certificate of conformance"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_compliance_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance test metrics tracking regulatory testing performance, certification status, test pass rates, and compliance cost effectiveness for product and process validation."
  source: "`vibe_manufacturing_v1`.`quality`.`compliance_test`"
  dimensions:
    - name: "test_status"
      expr: test_status
      comment: "Current status of the compliance test"
    - name: "test_type"
      expr: test_type
      comment: "Type of compliance test (safety, environmental, performance, etc.)"
    - name: "test_result"
      expr: test_result
      comment: "Result of the compliance test (pass, fail, conditional, etc.)"
    - name: "test_scope"
      expr: test_scope
      comment: "Scope of the compliance test"
    - name: "applicable_standard"
      expr: applicable_standard
      comment: "Applicable regulatory or industry standard"
    - name: "regulation_reference"
      expr: regulation_reference
      comment: "Reference to specific regulation or requirement"
    - name: "ppap_submission_level"
      expr: ppap_submission_level
      comment: "PPAP submission level (1-5) if applicable"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required (True/False)"
    - name: "retest_required"
      expr: retest_required
      comment: "Whether retest is required (True/False)"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Whether customer notification is required (True/False)"
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Whether the test has regulatory impact (True/False)"
    - name: "laboratory_accreditation_number"
      expr: laboratory_accreditation_number
      comment: "Accreditation number of the testing laboratory"
    - name: "test_cost_currency_code"
      expr: test_cost_currency_code
      comment: "Currency code for test cost"
    - name: "test_start_month"
      expr: DATE_TRUNC('MONTH', test_start_date)
      comment: "Month when test started"
    - name: "test_start_quarter"
      expr: DATE_TRUNC('QUARTER', test_start_date)
      comment: "Quarter when test started"
    - name: "test_start_year"
      expr: YEAR(test_start_date)
      comment: "Year when test started"
  measures:
    - name: "total_test_count"
      expr: COUNT(1)
      comment: "Total number of compliance tests"
    - name: "passed_test_count"
      expr: COUNT(CASE WHEN test_result = 'Pass' THEN 1 END)
      comment: "Count of compliance tests that passed"
    - name: "failed_test_count"
      expr: COUNT(CASE WHEN test_result = 'Fail' THEN 1 END)
      comment: "Count of compliance tests that failed"
    - name: "completed_test_count"
      expr: COUNT(CASE WHEN test_completion_date IS NOT NULL THEN 1 END)
      comment: "Count of compliance tests that have been completed"
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of tests requiring corrective action"
    - name: "retest_required_count"
      expr: COUNT(CASE WHEN retest_required = TRUE THEN 1 END)
      comment: "Count of tests requiring retest"
    - name: "regulatory_impact_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Count of tests with regulatory impact"
    - name: "customer_notification_count"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN 1 END)
      comment: "Count of tests requiring customer notification"
    - name: "total_test_cost"
      expr: SUM(CAST(test_cost_amount AS DOUBLE))
      comment: "Total cost of all compliance tests"
    - name: "avg_test_cost"
      expr: AVG(CAST(test_cost_amount AS DOUBLE))
      comment: "Average cost per compliance test"
    - name: "avg_test_duration_days"
      expr: AVG(DATEDIFF(test_completion_date, test_start_date))
      comment: "Average duration in days from test start to completion"
    - name: "certificate_issued_count"
      expr: COUNT(CASE WHEN certificate_issued_date IS NOT NULL THEN 1 END)
      comment: "Count of tests where certificate was issued"
    - name: "avg_days_to_certificate"
      expr: AVG(DATEDIFF(certificate_issued_date, test_completion_date))
      comment: "Average number of days from test completion to certificate issuance"
$$;