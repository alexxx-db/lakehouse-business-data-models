-- Metric views for domain: foodsafety | Business: Restaurants | Version: 2 | Generated on: 2026-07-01 14:04:56

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_health_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health inspection performance and compliance metrics tracking inspection outcomes, violations, and regulatory compliance across restaurant units."
  source: "`vibe_restaurants_v1`.`foodsafety`.`health_inspection`"
  dimensions:
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date the health inspection was conducted"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year of health inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of health inspection for trending"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of health inspection (routine, follow-up, complaint-driven)"
    - name: "overall_grade"
      expr: overall_grade
      comment: "Overall letter grade assigned by health inspector"
    - name: "pass_fail"
      expr: pass_fail
      comment: "Binary pass/fail outcome of inspection"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level classification assigned during inspection"
    - name: "agency_name"
      expr: agency_name
      comment: "Name of regulatory agency conducting inspection"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of inspection record"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required"
    - name: "closure_order_flag"
      expr: closure_order_flag
      comment: "Flag indicating whether a closure order was issued"
    - name: "follow_up_inspection_required"
      expr: follow_up_inspection_required
      comment: "Flag indicating whether follow-up inspection is required"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of health inspections conducted"
    - name: "failed_inspections"
      expr: COUNT(CASE WHEN pass_fail = 'Fail' THEN 1 END)
      comment: "Number of inspections that resulted in failure"
    - name: "inspection_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail = 'Fail' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that failed - key compliance KPI"
    - name: "closure_orders_issued"
      expr: COUNT(CASE WHEN closure_order_flag = true THEN 1 END)
      comment: "Number of inspections resulting in closure orders - critical risk indicator"
    - name: "closure_order_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN closure_order_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in closure orders - executive risk metric"
    - name: "avg_violations_per_inspection"
      expr: AVG(CAST(violations_count AS DOUBLE))
      comment: "Average number of violations per inspection - operational quality indicator"
    - name: "total_inspection_fees"
      expr: SUM(CAST(inspection_fee_amount AS DOUBLE))
      comment: "Total inspection fees paid - financial impact of compliance"
    - name: "inspections_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = true THEN 1 END)
      comment: "Number of inspections requiring corrective action"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring corrective action - operational efficiency metric"
    - name: "follow_up_inspection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_inspection_required = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring follow-up - quality persistence indicator"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_allergen_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allergen incident tracking and response metrics measuring incident frequency, severity, regulatory compliance, and resolution effectiveness."
  source: "`vibe_restaurants_v1`.`foodsafety`.`allergen_incident`"
  dimensions:
    - name: "incident_date"
      expr: DATE(incident_timestamp)
      comment: "Date the allergen incident occurred"
    - name: "incident_year"
      expr: YEAR(incident_timestamp)
      comment: "Year of allergen incident"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_timestamp)
      comment: "Month of allergen incident for trending"
    - name: "allergen_name"
      expr: allergen_name
      comment: "Name of allergen involved in incident"
    - name: "allergen_code"
      expr: allergen_code
      comment: "Standardized allergen code"
    - name: "severity_score"
      expr: severity_score
      comment: "Severity score of allergen incident"
    - name: "incident_category"
      expr: incident_category
      comment: "Category classification of allergen incident"
    - name: "allergen_incident_status"
      expr: allergen_incident_status
      comment: "Current status of allergen incident"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating compliance with allergen protocols"
    - name: "fda_medwatch_filed"
      expr: fda_medwatch_filed
      comment: "Flag indicating whether FDA MedWatch report was filed"
    - name: "is_repeat_incident"
      expr: is_repeat_incident
      comment: "Flag indicating whether this is a repeat incident"
    - name: "investigation_complete"
      expr: investigation_complete
      comment: "Flag indicating whether investigation is complete"
    - name: "regulatory_notification_status"
      expr: regulatory_notification_status
      comment: "Status of regulatory notification"
  measures:
    - name: "total_allergen_incidents"
      expr: COUNT(1)
      comment: "Total number of allergen incidents - primary safety volume metric"
    - name: "non_compliant_incidents"
      expr: COUNT(CASE WHEN compliance_flag = false THEN 1 END)
      comment: "Number of incidents that were non-compliant with protocols"
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents handled in compliance with protocols - key quality metric"
    - name: "fda_reporting_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fda_medwatch_filed = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents reported to FDA MedWatch - regulatory compliance metric"
    - name: "repeat_incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_incident = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are repeats - process effectiveness indicator"
    - name: "investigation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN investigation_complete = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents with completed investigations - operational thoroughness metric"
    - name: "unique_allergens_involved"
      expr: COUNT(DISTINCT allergen_code)
      comment: "Number of distinct allergens involved in incidents - risk diversity indicator"
    - name: "incidents_with_corrective_action"
      expr: COUNT(CASE WHEN corrective_action IS NOT NULL THEN 1 END)
      comment: "Number of incidents where corrective action was documented"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_temperature_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Temperature monitoring and critical control point compliance metrics tracking temperature deviations, equipment calibration, and HACCP compliance."
  source: "`vibe_restaurants_v1`.`foodsafety`.`temperature_log`"
  dimensions:
    - name: "reading_date"
      expr: DATE(reading_timestamp)
      comment: "Date of temperature reading"
    - name: "reading_year"
      expr: YEAR(reading_timestamp)
      comment: "Year of temperature reading"
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of temperature reading for trending"
    - name: "reading_type"
      expr: reading_type
      comment: "Type of temperature reading (storage, cooking, holding, etc.)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of temperature reading"
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Flag indicating temperature deviation from critical limits"
    - name: "temperature_log_status"
      expr: temperature_log_status
      comment: "Status of temperature log entry"
    - name: "monitoring_method"
      expr: monitoring_method
      comment: "Method used for temperature monitoring"
    - name: "temperature_trend"
      expr: temperature_trend
      comment: "Trend classification of temperature readings"
    - name: "maintenance_required"
      expr: maintenance_required
      comment: "Flag indicating whether equipment maintenance is required"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Flag indicating data quality of temperature reading"
  measures:
    - name: "total_temperature_readings"
      expr: COUNT(1)
      comment: "Total number of temperature readings logged"
    - name: "temperature_deviations"
      expr: COUNT(CASE WHEN deviation_flag = true THEN 1 END)
      comment: "Number of temperature readings outside critical limits - critical safety metric"
    - name: "deviation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN deviation_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readings with temperature deviations - key HACCP compliance KPI"
    - name: "avg_temperature_value"
      expr: AVG(CAST(temperature_value AS DOUBLE))
      comment: "Average temperature value across all readings"
    - name: "equipment_requiring_maintenance"
      expr: COUNT(DISTINCT CASE WHEN maintenance_required = true THEN primary_temperature_equipment_asset_id END)
      comment: "Number of distinct equipment assets requiring maintenance - operational action metric"
    - name: "data_quality_issue_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_quality_flag = false THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readings with data quality issues - monitoring system effectiveness"
    - name: "unique_monitoring_locations"
      expr: COUNT(DISTINCT stock_location_id)
      comment: "Number of distinct locations being monitored"
    - name: "unique_equipment_monitored"
      expr: COUNT(DISTINCT primary_temperature_equipment_asset_id)
      comment: "Number of distinct equipment assets being monitored"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_illness_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Foodborne illness reporting and investigation metrics tracking illness incidents, investigation outcomes, pathogen identification, and regulatory notification."
  source: "`vibe_restaurants_v1`.`foodsafety`.`illness_report`"
  dimensions:
    - name: "report_date"
      expr: DATE(report_timestamp)
      comment: "Date the illness was reported"
    - name: "report_year"
      expr: YEAR(report_timestamp)
      comment: "Year of illness report"
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_timestamp)
      comment: "Month of illness report for trending"
    - name: "onset_date"
      expr: onset_date
      comment: "Date of illness onset"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level classification of illness"
    - name: "severity_score"
      expr: severity_score
      comment: "Numeric severity score of illness"
    - name: "suspected_pathogen"
      expr: suspected_pathogen
      comment: "Suspected pathogen causing illness"
    - name: "illness_report_status"
      expr: illness_report_status
      comment: "Current status of illness report"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of illness investigation"
    - name: "health_department_notified"
      expr: health_department_notified
      comment: "Flag indicating whether health department was notified"
    - name: "exclusion_decision"
      expr: exclusion_decision
      comment: "Flag indicating whether employee exclusion was decided"
    - name: "report_method"
      expr: report_method
      comment: "Method by which illness was reported"
  measures:
    - name: "total_illness_reports"
      expr: COUNT(1)
      comment: "Total number of illness reports filed - primary public health metric"
    - name: "health_dept_notification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN health_department_notified = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of illness reports notified to health department - regulatory compliance KPI"
    - name: "employee_exclusion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusion_decision = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports resulting in employee exclusion - safety protocol adherence"
    - name: "unique_suspected_pathogens"
      expr: COUNT(DISTINCT suspected_pathogen)
      comment: "Number of distinct pathogens suspected - epidemiological diversity indicator"
    - name: "reports_with_identified_pathogen"
      expr: COUNT(CASE WHEN suspected_pathogen IS NOT NULL THEN 1 END)
      comment: "Number of reports with identified pathogen"
    - name: "pathogen_identification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN suspected_pathogen IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports with identified pathogen - investigation effectiveness metric"
    - name: "reports_with_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_taken IS NOT NULL THEN 1 END)
      comment: "Number of reports with documented corrective action"
    - name: "unique_affected_units"
      expr: COUNT(DISTINCT primary_illness_restaurant_unit_id)
      comment: "Number of distinct restaurant units with illness reports - geographic spread indicator"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_sanitation_task_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanitation task execution and compliance metrics tracking task completion, pass/fail rates, chemical usage, and operational adherence to sanitation schedules."
  source: "`vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log`"
  dimensions:
    - name: "task_date"
      expr: DATE(task_timestamp)
      comment: "Date the sanitation task was performed"
    - name: "task_year"
      expr: YEAR(task_timestamp)
      comment: "Year of sanitation task"
    - name: "task_month"
      expr: DATE_TRUNC('MONTH', task_timestamp)
      comment: "Month of sanitation task for trending"
    - name: "task_type"
      expr: task_type
      comment: "Type of sanitation task performed"
    - name: "task_status"
      expr: task_status
      comment: "Status of sanitation task"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of sanitation task"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether task is critical control point"
    - name: "location_area"
      expr: location_area
      comment: "Area or location where sanitation task was performed"
    - name: "chemical_name"
      expr: chemical_name
      comment: "Name of chemical used in sanitation"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify sanitation task completion"
    - name: "compliance_regulation"
      expr: compliance_regulation
      comment: "Regulatory compliance standard for task"
  measures:
    - name: "total_sanitation_tasks"
      expr: COUNT(1)
      comment: "Total number of sanitation tasks logged"
    - name: "completed_tasks"
      expr: COUNT(CASE WHEN task_status = 'Completed' THEN 1 END)
      comment: "Number of sanitation tasks completed"
    - name: "task_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN task_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sanitation tasks completed - operational execution metric"
    - name: "failed_tasks"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Number of sanitation tasks that failed verification"
    - name: "task_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sanitation tasks that failed - quality control KPI"
    - name: "critical_task_count"
      expr: COUNT(CASE WHEN is_critical = true THEN 1 END)
      comment: "Number of critical control point sanitation tasks"
    - name: "critical_task_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = true AND pass_fail_status = 'Fail' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_critical = true THEN 1 END), 0), 2)
      comment: "Failure rate for critical sanitation tasks - high-priority safety metric"
    - name: "tasks_with_corrective_action"
      expr: COUNT(CASE WHEN corrective_action IS NOT NULL THEN 1 END)
      comment: "Number of tasks requiring corrective action"
    - name: "avg_chemical_concentration"
      expr: AVG(CAST(chemical_concentration AS DOUBLE))
      comment: "Average chemical concentration used in sanitation tasks"
    - name: "unique_chemicals_used"
      expr: COUNT(DISTINCT chemical_name)
      comment: "Number of distinct chemicals used in sanitation"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_inspection_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health inspection violation tracking and remediation metrics measuring violation frequency, severity, financial penalties, and corrective action effectiveness."
  source: "`vibe_restaurants_v1`.`foodsafety`.`inspection_violation`"
  dimensions:
    - name: "violation_date"
      expr: DATE(violation_timestamp)
      comment: "Date the violation was identified"
    - name: "violation_year"
      expr: YEAR(violation_timestamp)
      comment: "Year of violation"
    - name: "violation_month"
      expr: DATE_TRUNC('MONTH', violation_timestamp)
      comment: "Month of violation for trending"
    - name: "violation_type"
      expr: violation_type
      comment: "Type of health code violation"
    - name: "violation_code"
      expr: violation_code
      comment: "Standardized violation code"
    - name: "severity"
      expr: severity
      comment: "Severity classification of violation"
    - name: "area_of_concern"
      expr: area_of_concern
      comment: "Area or domain of concern for violation"
    - name: "inspection_violation_status"
      expr: inspection_violation_status
      comment: "Current status of violation"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action for violation"
    - name: "regulatory_citation"
      expr: regulatory_citation
      comment: "Regulatory code citation for violation"
    - name: "reinspection_outcome"
      expr: reinspection_outcome
      comment: "Outcome of reinspection after corrective action"
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of health code violations - primary compliance volume metric"
    - name: "critical_violations"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Number of critical severity violations - high-priority safety indicator"
    - name: "critical_violation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity = 'Critical' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations that are critical - executive risk metric"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties assessed for violations - direct cost impact"
    - name: "avg_penalty_per_violation"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per violation - cost severity indicator"
    - name: "violations_with_penalties"
      expr: COUNT(CASE WHEN penalty_amount > 0 THEN 1 END)
      comment: "Number of violations resulting in financial penalties"
    - name: "corrective_action_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations with completed corrective action - remediation effectiveness"
    - name: "unique_violation_types"
      expr: COUNT(DISTINCT violation_type)
      comment: "Number of distinct violation types - compliance risk diversity"
    - name: "reinspection_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reinspection_outcome = 'Pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN reinspection_outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of reinspections that passed - corrective action effectiveness KPI"
$$;