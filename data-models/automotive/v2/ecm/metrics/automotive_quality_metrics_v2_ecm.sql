-- Metric views for domain: quality | Business: Automotive | Version: 2 | Generated on: 2026-07-14 01:46:32

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_defect_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core quality defect metrics tracking defect rates, severity distribution, and containment effectiveness across production, field, and supply chain"
  source: "`vibe_automotive_v1`.`quality`.`defect_record`"
  dimensions:
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defect (e.g., paint, assembly, electrical)"
    - name: "defect_type"
      expr: defect_type
      comment: "Type classification of the defect"
    - name: "severity"
      expr: severity
      comment: "Severity level of the defect (critical, major, minor)"
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the defect was detected (inspection, test, field return)"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision (scrap, rework, use-as-is, return to supplier)"
    - name: "defect_record_status"
      expr: defect_record_status
      comment: "Current status of the defect record (open, investigating, closed)"
    - name: "is_repeat_defect"
      expr: is_repeat_defect
      comment: "Flag indicating whether this is a repeat occurrence of the same defect"
    - name: "location_zone"
      expr: location_zone
      comment: "Physical zone or area where defect was detected"
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month when defect was detected"
    - name: "detected_quarter"
      expr: DATE_TRUNC('QUARTER', detected_timestamp)
      comment: "Quarter when defect was detected"
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total number of defect records"
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total quantity of units affected by defects"
    - name: "avg_ppm_rate"
      expr: AVG(CAST(ppm_rate AS DOUBLE))
      comment: "Average parts-per-million defect rate across all defect records"
    - name: "repeat_defect_count"
      expr: SUM(CAST(CASE WHEN is_repeat_defect = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of defects flagged as repeat occurrences"
    - name: "critical_defect_count"
      expr: SUM(CAST(CASE WHEN severity = 'Critical' THEN 1 ELSE 0 END AS INT))
      comment: "Count of defects with critical severity"
    - name: "avg_investigation_duration_days"
      expr: AVG(DATEDIFF(investigation_end_timestamp, investigation_start_timestamp))
      comment: "Average duration in days from investigation start to end"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot quality metrics tracking acceptance rates, rejection rates, and inspection effectiveness for incoming and in-process materials"
  source: "`vibe_automotive_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "decision"
      expr: decision
      comment: "Inspection decision (accept, reject, conditional accept)"
    - name: "inspection_lot_status"
      expr: inspection_lot_status
      comment: "Current status of the inspection lot"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of inspection lot (incoming, in-process, final)"
    - name: "lot_origin"
      expr: lot_origin
      comment: "Origin of the lot (supplier, internal production)"
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (visual, dimensional, functional)"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required"
    - name: "measurement_result_status"
      expr: measurement_result_status
      comment: "Status of measurement results (pass, fail, conditional)"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where inspection was performed"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month when inspection was performed"
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots"
    - name: "total_quantity_inspected"
      expr: SUM(CAST(quantity_inspected AS DOUBLE))
      comment: "Total quantity of units inspected across all lots"
    - name: "total_quantity_accepted"
      expr: SUM(CAST(quantity_accepted AS DOUBLE))
      comment: "Total quantity of units accepted"
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity of units rejected"
    - name: "lots_requiring_corrective_action"
      expr: SUM(CAST(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of inspection lots requiring corrective action"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value across all inspection results"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_spc_data_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Process Control metrics tracking process capability, control limits, and out-of-control conditions for real-time quality monitoring"
  source: "`vibe_automotive_v1`.`quality`.`spc_data_point`"
  dimensions:
    - name: "spc_data_point_status"
      expr: spc_data_point_status
      comment: "Status of the SPC data point"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement being tracked"
    - name: "process_step"
      expr: process_step
      comment: "Process step where measurement was taken"
    - name: "out_of_control_flag"
      expr: out_of_control_flag
      comment: "Flag indicating whether the data point is out of control limits"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether this is a critical measurement"
    - name: "western_electric_rule_violation"
      expr: western_electric_rule_violation
      comment: "Western Electric rule violation detected (if any)"
    - name: "shift"
      expr: shift
      comment: "Production shift when measurement was taken"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month when measurement was taken"
    - name: "measurement_week"
      expr: DATE_TRUNC('WEEK', measurement_timestamp)
      comment: "Week when measurement was taken"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of SPC measurements"
    - name: "out_of_control_count"
      expr: SUM(CAST(CASE WHEN out_of_control_flag = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of measurements flagged as out of control"
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average process capability index (Cpk) indicating process centering and spread"
    - name: "avg_cp_value"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average process capability index (Cp) indicating process spread"
    - name: "avg_ppk_value"
      expr: AVG(CAST(ppk_value AS DOUBLE))
      comment: "Average process performance index (Ppk)"
    - name: "avg_pp_value"
      expr: AVG(CAST(pp_value AS DOUBLE))
      comment: "Average process performance index (Pp)"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value across all data points"
    - name: "critical_measurement_count"
      expr: SUM(CAST(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of critical measurements"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_ppm_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parts-per-million defect rate metrics tracking supplier and internal quality performance against targets"
  source: "`vibe_automotive_v1`.`quality`.`ppm_record`"
  dimensions:
    - name: "ppm_record_status"
      expr: ppm_record_status
      comment: "Status of the PPM record"
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defects contributing to PPM"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection that generated the PPM data"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where PPM was measured"
    - name: "region_code"
      expr: region_code
      comment: "Region code for geographic analysis"
    - name: "quality_gate_passed"
      expr: quality_gate_passed
      comment: "Flag indicating whether quality gate was passed"
    - name: "is_outlier"
      expr: is_outlier
      comment: "Flag indicating whether this PPM value is a statistical outlier"
    - name: "trend_indicator"
      expr: trend_indicator
      comment: "Trend indicator (improving, stable, degrading)"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month when PPM was measured"
  measures:
    - name: "total_ppm_records"
      expr: COUNT(1)
      comment: "Total number of PPM records"
    - name: "avg_ppm_value"
      expr: AVG(CAST(ppm_value AS DOUBLE))
      comment: "Average parts-per-million defect rate"
    - name: "avg_target_ppm"
      expr: AVG(CAST(target_ppm AS DOUBLE))
      comment: "Average target PPM threshold"
    - name: "total_defective_parts"
      expr: SUM(CAST(total_defective_parts AS BIGINT))
      comment: "Total count of defective parts across all records"
    - name: "total_parts_received"
      expr: SUM(CAST(total_parts_received AS BIGINT))
      comment: "Total count of parts received across all records"
    - name: "quality_gate_pass_count"
      expr: SUM(CAST(CASE WHEN quality_gate_passed = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of records where quality gate was passed"
    - name: "outlier_count"
      expr: SUM(CAST(CASE WHEN is_outlier = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of PPM records flagged as statistical outliers"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit metrics tracking audit findings, compliance scores, and corrective action effectiveness across plants and suppliers"
  source: "`vibe_automotive_v1`.`quality`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, supplier, process, product)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the audit"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level identified by the audit"
    - name: "score_category"
      expr: score_category
      comment: "Category of audit score (excellent, good, needs improvement)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body conducting or requiring the audit"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month when audit was conducted"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score"
    - name: "total_findings_major"
      expr: SUM(CAST(findings_major AS DOUBLE))
      comment: "Total count of major findings across all audits"
    - name: "total_findings_minor"
      expr: SUM(CAST(findings_minor AS DOUBLE))
      comment: "Total count of minor findings across all audits"
    - name: "total_findings_severe"
      expr: SUM(CAST(findings_severe AS DOUBLE))
      comment: "Total count of severe findings across all audits"
    - name: "audits_requiring_corrective_action"
      expr: SUM(CAST(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of audits requiring corrective action"
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average audit duration in minutes"
    - name: "closed_audits"
      expr: SUM(CAST(CASE WHEN closure_status = 'Closed' THEN 1 ELSE 0 END AS INT))
      comment: "Count of audits that have been closed"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_fmea`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure Mode and Effects Analysis metrics tracking risk priority numbers, severity, occurrence, and detection ratings for proactive quality risk management"
  source: "`vibe_automotive_v1`.`quality`.`fmea`"
  dimensions:
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of FMEA analysis (DFMEA, PFMEA, system, component)"
    - name: "fmea_status"
      expr: fmea_status
      comment: "Current status of the FMEA"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Description of the failure mode"
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating (1-10 scale)"
    - name: "occurrence_rating"
      expr: occurrence_rating
      comment: "Occurrence rating (1-10 scale)"
    - name: "detection_rating"
      expr: detection_rating
      comment: "Detection rating (1-10 scale)"
    - name: "subsystem"
      expr: subsystem
      comment: "Subsystem or component being analyzed"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month when FMEA was approved"
  measures:
    - name: "total_fmeas"
      expr: COUNT(1)
      comment: "Total number of FMEA records"
    - name: "avg_rpn"
      expr: AVG(CAST(rpn AS DOUBLE))
      comment: "Average Risk Priority Number (RPN = Severity x Occurrence x Detection)"
    - name: "high_rpn_count"
      expr: SUM(CASE WHEN CAST(rpn AS DOUBLE) >= 100 THEN 1 ELSE 0 END)
      comment: "Count of FMEAs with RPN >= 100 (high risk threshold)"
    - name: "critical_severity_count"
      expr: SUM(CASE WHEN CAST(severity_rating AS INT) >= 8 THEN 1 ELSE 0 END)
      comment: "Count of failure modes with critical severity (rating >= 8)"
    - name: "approved_fmeas"
      expr: SUM(CAST(CASE WHEN approval_date IS NOT NULL THEN 1 ELSE 0 END AS INT))
      comment: "Count of approved FMEAs"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_warranty_quality_signal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty quality signal metrics tracking field failure patterns, systemic issues, and early warning indicators from warranty claims"
  source: "`vibe_automotive_v1`.`quality`.`warranty_quality_signal`"
  dimensions:
    - name: "signal_status"
      expr: signal_status
      comment: "Current status of the quality signal"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the quality signal"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level for management attention"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode identified from warranty data"
    - name: "is_systemic"
      expr: is_systemic
      comment: "Flag indicating whether the issue is systemic across multiple units"
    - name: "is_repeat_signal"
      expr: is_repeat_signal
      comment: "Flag indicating whether this is a repeat signal"
    - name: "source_type"
      expr: source_type
      comment: "Source type of the signal (warranty claim, field return, TSB)"
    - name: "model_year"
      expr: model_year
      comment: "Model year of affected vehicles"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month when signal was detected"
  measures:
    - name: "total_quality_signals"
      expr: COUNT(1)
      comment: "Total number of warranty quality signals"
    - name: "total_affected_vins"
      expr: SUM(CAST(affected_vin_count AS BIGINT))
      comment: "Total count of VINs affected by quality signals"
    - name: "total_occurrence_count"
      expr: SUM(CAST(occurrence_count AS BIGINT))
      comment: "Total count of occurrences across all signals"
    - name: "total_impact_amount"
      expr: SUM(CAST(impact_amount AS DOUBLE))
      comment: "Total financial impact amount across all quality signals"
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score across all signals"
    - name: "systemic_issue_count"
      expr: SUM(CAST(CASE WHEN is_systemic = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of signals flagged as systemic issues"
    - name: "repeat_signal_count"
      expr: SUM(CAST(CASE WHEN is_repeat_signal = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of repeat quality signals"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_supplier_quality_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality event metrics tracking supplier nonconformances, containment actions, and supplier quality performance"
  source: "`vibe_automotive_v1`.`quality`.`supplier_quality_event`"
  dimensions:
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the supplier quality event"
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity of the supplier defect"
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the supplier quality issue was detected"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether this is a critical supplier quality event"
    - name: "is_repeat_issue"
      expr: is_repeat_issue
      comment: "Flag indicating whether this is a repeat issue from the supplier"
    - name: "sca_requested"
      expr: sca_requested
      comment: "Flag indicating whether a Supplier Corrective Action (SCA) was requested"
    - name: "supplier_response_status"
      expr: supplier_response_status
      comment: "Status of supplier response to the quality event"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the supplier quality event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when supplier quality event occurred"
  measures:
    - name: "total_supplier_quality_events"
      expr: COUNT(1)
      comment: "Total number of supplier quality events"
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity affected by supplier quality events"
    - name: "total_defect_quantity"
      expr: SUM(CAST(defect_quantity AS DOUBLE))
      comment: "Total quantity of defective parts from suppliers"
    - name: "critical_event_count"
      expr: SUM(CAST(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of critical supplier quality events"
    - name: "repeat_issue_count"
      expr: SUM(CAST(CASE WHEN is_repeat_issue = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of repeat supplier quality issues"
    - name: "sca_requested_count"
      expr: SUM(CAST(CASE WHEN sca_requested = TRUE THEN 1 ELSE 0 END AS INT))
      comment: "Count of events where Supplier Corrective Action was requested"
    - name: "avg_resolution_time_days"
      expr: AVG(CAST(actual_resolution_time_days AS DOUBLE))
      comment: "Average time in days to resolve supplier quality events"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_apqp_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advanced Product Quality Planning metrics tracking APQP gate completion, PPM performance vs targets, and program quality readiness"
  source: "`vibe_automotive_v1`.`quality`.`apqp_plan`"
  dimensions:
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "Current APQP phase (Plan, Design, Process, Product/Process Validation, Launch)"
    - name: "milestone_gate"
      expr: milestone_gate
      comment: "APQP milestone gate (Gate 1-5)"
    - name: "gate_status"
      expr: gate_status
      comment: "Status of the APQP gate (not started, in progress, passed, failed)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the APQP plan"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the APQP plan"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assessment for the APQP plan"
    - name: "model_year"
      expr: model_year
      comment: "Model year for the vehicle program"
    - name: "sop_month"
      expr: DATE_TRUNC('MONTH', sop_date)
      comment: "Start of Production (SOP) month"
  measures:
    - name: "total_apqp_plans"
      expr: COUNT(1)
      comment: "Total number of APQP plans"
    - name: "avg_target_ppm"
      expr: AVG(CAST(target_ppm AS DOUBLE))
      comment: "Average target parts-per-million defect rate"
    - name: "avg_actual_ppm"
      expr: AVG(CAST(actual_ppm AS DOUBLE))
      comment: "Average actual parts-per-million defect rate achieved"
    - name: "avg_quality_goal_ppm"
      expr: AVG(CAST(quality_goal_ppm AS DOUBLE))
      comment: "Average quality goal PPM threshold"
    - name: "gates_passed"
      expr: SUM(CAST(CASE WHEN gate_status = 'Passed' THEN 1 ELSE 0 END AS INT))
      comment: "Count of APQP gates that have been passed"
    - name: "gates_failed"
      expr: SUM(CAST(CASE WHEN gate_status = 'Failed' THEN 1 ELSE 0 END AS INT))
      comment: "Count of APQP gates that have failed"
    - name: "high_risk_plans"
      expr: SUM(CAST(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END AS INT))
      comment: "Count of APQP plans with high risk level"
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`quality_field_return`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field return metrics tracking customer returns, root cause analysis, and field quality performance"
  source: "`vibe_automotive_v1`.`quality`.`field_return`"
  dimensions:
    - name: "field_return_status"
      expr: field_return_status
      comment: "Current status of the field return"
    - name: "return_type"
      expr: return_type
      comment: "Type of field return (warranty, goodwill, recall)"
    - name: "return_reason"
      expr: return_reason
      comment: "Reason for the field return"
    - name: "defect_code"
      expr: defect_code
      comment: "Defect code assigned to the field return"
    - name: "repair_status"
      expr: repair_status
      comment: "Status of repair for the returned item"
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause identified for the field return"
    - name: "return_month"
      expr: DATE_TRUNC('MONTH', return_timestamp)
      comment: "Month when field return occurred"
  measures:
    - name: "total_field_returns"
      expr: COUNT(1)
      comment: "Total number of field returns"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount for all field returns"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount for all field returns"
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours spent on field returns"
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate for field return repairs"
    - name: "total_parts_replaced"
      expr: SUM(CAST(parts_replaced_count AS DOUBLE))
      comment: "Total count of parts replaced in field returns"
$$;