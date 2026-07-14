-- Metric views for domain: quality | Business: Automotive | Version: 2 | Generated on: 2026-07-14 04:28:06

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_defect_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core quality defect metrics tracking defect rates, severity distribution, repeat defects, and PPM performance across manufacturing, supply chain, and field operations"
  source: "`vibe_automotive_v1`.`quality`.`defect_record`"
  dimensions:
    - name: "defect_category"
      expr: defect_category
      comment: "Category classification of the defect (e.g., paint, assembly, electrical)"
    - name: "defect_type"
      expr: defect_type
      comment: "Specific type of defect within category"
    - name: "severity"
      expr: severity
      comment: "Severity level of the defect (critical, major, minor)"
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which defect was detected (inspection, customer report, audit)"
    - name: "defect_record_status"
      expr: defect_record_status
      comment: "Current status of the defect record (open, investigating, closed)"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the defect (rework, scrap, use-as-is, return)"
    - name: "location_zone"
      expr: location_zone
      comment: "Physical zone or area where defect was detected"
    - name: "is_repeat_defect"
      expr: is_repeat_defect
      comment: "Flag indicating whether this is a recurring defect"
    - name: "detected_year"
      expr: YEAR(detected_timestamp)
      comment: "Year when defect was detected"
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month when defect was detected"
    - name: "detected_week"
      expr: DATE_TRUNC('WEEK', detected_timestamp)
      comment: "Week when defect was detected"
  measures:
    - name: "total_defects"
      expr: COUNT(defect_record_id)
      comment: "Total number of defect records"
    - name: "critical_defects"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN defect_record_id END)
      comment: "Count of critical severity defects requiring immediate action"
    - name: "repeat_defects"
      expr: COUNT(CASE WHEN is_repeat_defect = TRUE THEN defect_record_id END)
      comment: "Count of defects that are recurring issues"
    - name: "avg_ppm_rate"
      expr: AVG(CAST(ppm_rate AS DOUBLE))
      comment: "Average parts-per-million defect rate across all records"
    - name: "total_ppm_rate"
      expr: SUM(CAST(ppm_rate AS DOUBLE))
      comment: "Sum of PPM rates for aggregated quality performance"
    - name: "repeat_defect_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_defect = TRUE THEN defect_record_id END) / NULLIF(COUNT(defect_record_id), 0), 2)
      comment: "Percentage of defects that are repeat occurrences - key indicator of systemic quality issues"
    - name: "critical_defect_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity = 'Critical' THEN defect_record_id END) / NULLIF(COUNT(defect_record_id), 0), 2)
      comment: "Percentage of defects classified as critical severity"
    - name: "unique_defect_codes"
      expr: COUNT(DISTINCT defect_code)
      comment: "Number of distinct defect codes observed - indicates defect diversity"
    - name: "unique_vins_affected"
      expr: COUNT(DISTINCT vin)
      comment: "Number of unique vehicles affected by defects"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection quality metrics tracking measurement conformance, process capability (Cp/Cpk), out-of-spec rates, and measurement system performance"
  source: "`vibe_automotive_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Status of the inspection result (pass, fail, conditional)"
    - name: "record_status"
      expr: record_status
      comment: "Record lifecycle status"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used for measurement (manual, automated, CMM)"
    - name: "measurement_tool"
      expr: measurement_tool
      comment: "Specific tool or equipment used for measurement"
    - name: "measurement_location"
      expr: measurement_location
      comment: "Physical location where measurement was taken"
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source system or origin of measurement data"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether this is a critical characteristic"
    - name: "inspection_year"
      expr: YEAR(inspection_timestamp)
      comment: "Year of inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of inspection"
  measures:
    - name: "total_inspections"
      expr: COUNT(inspection_result_id)
      comment: "Total number of inspection results recorded"
    - name: "failed_inspections"
      expr: COUNT(CASE WHEN result_status = 'Fail' THEN inspection_result_id END)
      comment: "Count of inspections that failed acceptance criteria"
    - name: "critical_inspections"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN inspection_result_id END)
      comment: "Count of inspections on critical characteristics"
    - name: "fail_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN result_status = 'Fail' THEN inspection_result_id END) / NULLIF(COUNT(inspection_result_id), 0), 2)
      comment: "Percentage of inspections that fail - key quality gate metric"
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average process capability index (Cpk) - measures process centering and spread relative to specification limits"
    - name: "avg_cp_value"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average process capability (Cp) - measures process spread relative to specification width"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured value across all inspections"
    - name: "avg_deviation_amount"
      expr: AVG(CAST(deviation_amount AS DOUBLE))
      comment: "Average deviation from target - indicates process centering"
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty - key measurement system capability indicator"
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit across inspections"
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit across inspections"
    - name: "capable_processes_cpk_gt_1_33"
      expr: COUNT(CASE WHEN CAST(cpk_value AS DOUBLE) > 1.33 THEN inspection_result_id END)
      comment: "Count of inspections with Cpk > 1.33 indicating capable process (industry standard threshold)"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit performance metrics tracking audit scores, compliance rates, findings severity, corrective action effectiveness, and audit cycle times"
  source: "`vibe_automotive_v1`.`quality`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (process, product, system, layered)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in-progress, completed, closed)"
    - name: "closure_status"
      expr: closure_status
      comment: "Status of audit closure and corrective actions"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions from audit findings"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level identified by audit (high, medium, low)"
    - name: "score_category"
      expr: score_category
      comment: "Category classification of audit score"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body or standard being audited against"
    - name: "method"
      expr: method
      comment: "Audit method or approach used"
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year of audit"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month of audit"
  measures:
    - name: "total_audits"
      expr: COUNT(audit_id)
      comment: "Total number of audits conducted"
    - name: "audits_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN audit_id END)
      comment: "Count of audits that identified issues requiring corrective action"
    - name: "high_risk_audits"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN audit_id END)
      comment: "Count of audits identifying high risk issues"
    - name: "avg_audit_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average audit score - key indicator of overall quality system performance"
    - name: "min_audit_score"
      expr: MIN(CAST(overall_score AS DOUBLE))
      comment: "Minimum audit score - identifies worst-performing areas"
    - name: "max_audit_score"
      expr: MAX(CAST(overall_score AS DOUBLE))
      comment: "Maximum audit score - identifies best-performing areas"
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN audit_id END) / NULLIF(COUNT(audit_id), 0), 2)
      comment: "Percentage of audits requiring corrective action - indicates systemic compliance issues"
    - name: "high_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_level = 'High' THEN audit_id END) / NULLIF(COUNT(audit_id), 0), 2)
      comment: "Percentage of audits identifying high risk - critical escalation metric"
    - name: "unique_regulatory_bodies"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Number of distinct regulatory bodies audited against"
    - name: "unique_auditees"
      expr: COUNT(DISTINCT auditee_location)
      comment: "Number of distinct locations or entities audited"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action effectiveness metrics tracking closure rates, cycle times, overdue actions, and verification success rates"
  source: "`vibe_automotive_v1`.`quality`.`corrective_action`"
  dimensions:
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of corrective action (open, in-progress, closed, verified)"
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (immediate, interim, permanent)"
    - name: "priority"
      expr: priority
      comment: "Priority level of corrective action (critical, high, medium, low)"
    - name: "effectiveness_verified_flag"
      expr: effectiveness_verified_flag
      comment: "Flag indicating whether corrective action effectiveness has been verified"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year corrective action was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month corrective action was created"
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year corrective action is due"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month corrective action is due"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(corrective_action_id)
      comment: "Total number of corrective actions initiated"
    - name: "closed_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_status = 'Closed' THEN corrective_action_id END)
      comment: "Count of corrective actions that have been closed"
    - name: "verified_effective_actions"
      expr: COUNT(CASE WHEN effectiveness_verified_flag = TRUE THEN corrective_action_id END)
      comment: "Count of corrective actions verified as effective"
    - name: "critical_priority_actions"
      expr: COUNT(CASE WHEN priority = 'Critical' THEN corrective_action_id END)
      comment: "Count of critical priority corrective actions"
    - name: "closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_status = 'Closed' THEN corrective_action_id END) / NULLIF(COUNT(corrective_action_id), 0), 2)
      comment: "Percentage of corrective actions closed - key effectiveness metric"
    - name: "verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_verified_flag = TRUE THEN corrective_action_id END) / NULLIF(COUNT(corrective_action_id), 0), 2)
      comment: "Percentage of corrective actions with verified effectiveness - indicates quality of corrective action process"
    - name: "unique_defect_records"
      expr: COUNT(DISTINCT defect_record_id)
      comment: "Number of distinct defect records linked to corrective actions"
    - name: "unique_audits"
      expr: COUNT(DISTINCT audit_id)
      comment: "Number of distinct audits generating corrective actions"
    - name: "unique_root_cause_analyses"
      expr: COUNT(DISTINCT root_cause_analysis_id)
      comment: "Number of distinct root cause analyses linked to corrective actions"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot quality metrics tracking acceptance rates, rejection rates, lot closure performance, and inspection decision effectiveness"
  source: "`vibe_automotive_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_lot_status"
      expr: inspection_lot_status
      comment: "Current status of inspection lot (created, in-progress, completed, closed)"
    - name: "decision"
      expr: decision
      comment: "Inspection decision (accept, reject, conditional, rework)"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of inspection lot (goods receipt, in-process, final, audit)"
    - name: "lot_origin"
      expr: lot_origin
      comment: "Origin of the inspection lot (supplier, internal, customer return)"
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (sampling, 100%, skip-lot)"
    - name: "measurement_result_status"
      expr: measurement_result_status
      comment: "Status of measurement results (pass, fail, pending)"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required"
    - name: "inspection_year"
      expr: YEAR(inspection_timestamp)
      comment: "Year of inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of inspection"
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(inspection_lot_id)
      comment: "Total number of inspection lots processed"
    - name: "accepted_lots"
      expr: COUNT(CASE WHEN decision = 'Accept' THEN inspection_lot_id END)
      comment: "Count of inspection lots accepted"
    - name: "rejected_lots"
      expr: COUNT(CASE WHEN decision = 'Reject' THEN inspection_lot_id END)
      comment: "Count of inspection lots rejected"
    - name: "lots_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN inspection_lot_id END)
      comment: "Count of lots requiring corrective action"
    - name: "acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision = 'Accept' THEN inspection_lot_id END) / NULLIF(COUNT(inspection_lot_id), 0), 2)
      comment: "Percentage of inspection lots accepted - key supplier and process quality indicator"
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision = 'Reject' THEN inspection_lot_id END) / NULLIF(COUNT(inspection_lot_id), 0), 2)
      comment: "Percentage of inspection lots rejected - critical quality gate metric"
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN inspection_lot_id END) / NULLIF(COUNT(inspection_lot_id), 0), 2)
      comment: "Percentage of lots requiring corrective action - indicates systemic quality issues"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value across inspection lots"
    - name: "unique_suppliers"
      expr: COUNT(DISTINCT supply_supplier_id)
      comment: "Number of distinct suppliers with inspection lots"
    - name: "unique_skus"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs inspected"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_root_cause_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Root cause analysis effectiveness metrics tracking resolution rates, cycle times, risk ratings, and verification success"
  source: "`vibe_automotive_v1`.`quality`.`root_cause_analysis`"
  dimensions:
    - name: "root_cause_analysis_status"
      expr: root_cause_analysis_status
      comment: "Current status of root cause analysis (initiated, in-progress, completed, verified)"
    - name: "root_cause_analysis_type"
      expr: root_cause_analysis_type
      comment: "Type of root cause analysis method (5-Why, Fishbone, FMEA, 8D)"
    - name: "category"
      expr: category
      comment: "Category of root cause (material, method, machine, manpower, environment)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the issue (critical, high, medium, low)"
    - name: "priority"
      expr: priority
      comment: "Priority for resolution (urgent, high, medium, low)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk rating from analysis"
    - name: "detection_phase"
      expr: detection_phase
      comment: "Phase where issue was detected (design, manufacturing, field)"
    - name: "occurrence_phase"
      expr: occurrence_phase
      comment: "Phase where issue occurred"
    - name: "verification_result"
      expr: verification_result
      comment: "Result of corrective action verification (effective, ineffective, pending)"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year root cause analysis was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month root cause analysis was created"
  measures:
    - name: "total_root_cause_analyses"
      expr: COUNT(root_cause_analysis_id)
      comment: "Total number of root cause analyses conducted"
    - name: "completed_analyses"
      expr: COUNT(CASE WHEN root_cause_analysis_status = 'Completed' THEN root_cause_analysis_id END)
      comment: "Count of completed root cause analyses"
    - name: "verified_effective_analyses"
      expr: COUNT(CASE WHEN verification_result = 'Effective' THEN root_cause_analysis_id END)
      comment: "Count of analyses with verified effective corrective actions"
    - name: "critical_severity_analyses"
      expr: COUNT(CASE WHEN severity_level = 'Critical' THEN root_cause_analysis_id END)
      comment: "Count of critical severity root cause analyses"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN root_cause_analysis_status = 'Completed' THEN root_cause_analysis_id END) / NULLIF(COUNT(root_cause_analysis_id), 0), 2)
      comment: "Percentage of root cause analyses completed - indicates investigation effectiveness"
    - name: "verification_effectiveness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_result = 'Effective' THEN root_cause_analysis_id END) / NULLIF(COUNT(root_cause_analysis_id), 0), 2)
      comment: "Percentage of analyses with verified effective solutions - key quality improvement metric"
    - name: "unique_defect_records"
      expr: COUNT(DISTINCT defect_record_id)
      comment: "Number of distinct defect records analyzed"
    - name: "unique_root_cause_categories"
      expr: COUNT(DISTINCT category)
      comment: "Number of distinct root cause categories identified"
$$;