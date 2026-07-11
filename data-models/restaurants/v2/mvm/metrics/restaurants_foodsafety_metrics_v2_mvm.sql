-- Metric views for domain: foodsafety | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 19:59:49

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_allergen_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allergen incident tracking and severity analysis for guest safety and regulatory compliance"
  source: "`vibe_restaurants_v1`.`foodsafety`.`allergen_incident`"
  dimensions:
    - name: "allergen_name"
      expr: allergen_name
      comment: "Name of the allergen involved in the incident"
    - name: "allergen_code"
      expr: allergen_code
      comment: "Standardized allergen classification code"
    - name: "severity_score"
      expr: severity_score
      comment: "Severity score assigned to the incident"
    - name: "incident_category"
      expr: incident_category
      comment: "Category classification of the allergen incident"
    - name: "allergen_incident_status"
      expr: allergen_incident_status
      comment: "Current status of the allergen incident"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the incident was handled in compliance with protocols"
    - name: "fda_medwatch_filed"
      expr: fda_medwatch_filed
      comment: "Whether FDA MedWatch report was filed"
    - name: "is_repeat_incident"
      expr: is_repeat_incident
      comment: "Flag indicating if this is a repeat incident"
    - name: "regulatory_notification_status"
      expr: regulatory_notification_status
      comment: "Status of regulatory body notification"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_timestamp)
      comment: "Month when the incident occurred"
    - name: "incident_year"
      expr: YEAR(incident_timestamp)
      comment: "Year when the incident occurred"
  measures:
    - name: "total_allergen_incidents"
      expr: COUNT(1)
      comment: "Total number of allergen incidents reported"
    - name: "unique_allergen_types"
      expr: COUNT(DISTINCT allergen_code)
      comment: "Number of distinct allergen types involved in incidents"
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents handled in compliance with protocols"
    - name: "fda_filing_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN fda_medwatch_filed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that resulted in FDA MedWatch filing"
    - name: "repeat_incident_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_incident = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are repeat occurrences"
    - name: "investigation_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN investigation_complete = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents with completed investigations"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_food_safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety audit performance and compliance tracking for operational excellence"
  source: "`vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of food safety audit conducted"
    - name: "pass_fail"
      expr: pass_fail
      comment: "Overall pass or fail result of the audit"
    - name: "food_safety_audit_status"
      expr: food_safety_audit_status
      comment: "Current status of the audit"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions from the audit"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body conducting or overseeing the audit"
    - name: "allergen_control_compliant"
      expr: allergen_control_compliant
      comment: "Whether allergen control measures were compliant"
    - name: "temperature_monitoring_compliant"
      expr: temperature_monitoring_compliant
      comment: "Whether temperature monitoring was compliant"
    - name: "sanitation_schedule_compliant"
      expr: sanitation_schedule_compliant
      comment: "Whether sanitation schedule adherence was compliant"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_timestamp)
      comment: "Month when the audit was conducted"
    - name: "audit_year"
      expr: YEAR(audit_timestamp)
      comment: "Year when the audit was conducted"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of food safety audits conducted"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all audits"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score"
    - name: "audit_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits that achieved a passing result"
    - name: "allergen_control_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN allergen_control_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with compliant allergen control"
    - name: "temperature_monitoring_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_monitoring_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with compliant temperature monitoring"
    - name: "sanitation_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sanitation_schedule_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with compliant sanitation schedule adherence"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_health_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health inspection outcomes and regulatory compliance tracking for risk management"
  source: "`vibe_restaurants_v1`.`foodsafety`.`health_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of health inspection conducted"
    - name: "pass_fail"
      expr: pass_fail
      comment: "Pass or fail result of the inspection"
    - name: "overall_grade"
      expr: overall_grade
      comment: "Overall grade assigned by the inspector"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level classification from the inspection"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required"
    - name: "follow_up_inspection_required"
      expr: follow_up_inspection_required
      comment: "Whether a follow-up inspection is required"
    - name: "closure_order_flag"
      expr: closure_order_flag
      comment: "Whether a closure order was issued"
    - name: "agency_name"
      expr: agency_name
      comment: "Name of the inspecting agency"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month when the inspection occurred"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year when the inspection occurred"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of health inspections conducted"
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that passed"
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring corrective action"
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_inspection_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring follow-up"
    - name: "closure_order_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closure_order_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in closure orders"
    - name: "total_inspection_fees"
      expr: SUM(CAST(inspection_fee_amount AS DOUBLE))
      comment: "Total inspection fees assessed across all inspections"
    - name: "avg_inspection_fee"
      expr: AVG(CAST(inspection_fee_amount AS DOUBLE))
      comment: "Average inspection fee per inspection"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_illness_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Foodborne illness reporting and investigation tracking for public health and risk mitigation"
  source: "`vibe_restaurants_v1`.`foodsafety`.`illness_report`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the reported illness"
    - name: "illness_report_status"
      expr: illness_report_status
      comment: "Current status of the illness report"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the illness investigation"
    - name: "suspected_pathogen"
      expr: suspected_pathogen
      comment: "Suspected pathogen causing the illness"
    - name: "health_department_notified"
      expr: health_department_notified
      comment: "Whether the health department was notified"
    - name: "exclusion_decision"
      expr: exclusion_decision
      comment: "Whether employee exclusion was decided"
    - name: "report_method"
      expr: report_method
      comment: "Method by which the illness was reported"
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_timestamp)
      comment: "Month when the illness was reported"
    - name: "report_year"
      expr: YEAR(report_timestamp)
      comment: "Year when the illness was reported"
  measures:
    - name: "total_illness_reports"
      expr: COUNT(1)
      comment: "Total number of illness reports filed"
    - name: "unique_suspected_pathogens"
      expr: COUNT(DISTINCT suspected_pathogen)
      comment: "Number of distinct suspected pathogens identified"
    - name: "health_dept_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN health_department_notified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of illness reports where health department was notified"
    - name: "employee_exclusion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN exclusion_decision = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of illness reports resulting in employee exclusion"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action effectiveness and closure tracking for continuous improvement"
  source: "`vibe_restaurants_v1`.`foodsafety`.`corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action taken"
    - name: "foodsafety_corrective_action_status"
      expr: foodsafety_corrective_action_status
      comment: "Current status of the corrective action"
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the corrective action"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the issue requiring corrective action"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the corrective action"
    - name: "is_effective"
      expr: is_effective
      comment: "Whether the corrective action was effective"
    - name: "ccp_deviation"
      expr: ccp_deviation
      comment: "Whether the action was due to a critical control point deviation"
    - name: "temperature_exceedance"
      expr: temperature_exceedance
      comment: "Whether the action was due to temperature exceedance"
    - name: "action_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when the corrective action event occurred"
    - name: "action_year"
      expr: YEAR(event_timestamp)
      comment: "Year when the corrective action event occurred"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions initiated"
    - name: "total_corrective_action_cost"
      expr: SUM(CAST(action_cost AS DOUBLE))
      comment: "Total cost of all corrective actions"
    - name: "avg_corrective_action_cost"
      expr: AVG(CAST(action_cost AS DOUBLE))
      comment: "Average cost per corrective action"
    - name: "effectiveness_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_effective = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that were effective"
    - name: "ccp_deviation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ccp_deviation = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions due to critical control point deviations"
    - name: "temperature_exceedance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_exceedance = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions due to temperature exceedances"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_temperature_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Temperature monitoring compliance and deviation tracking for critical control point management"
  source: "`vibe_restaurants_v1`.`foodsafety`.`temperature_log`"
  dimensions:
    - name: "reading_type"
      expr: reading_type
      comment: "Type of temperature reading taken"
    - name: "temperature_log_status"
      expr: temperature_log_status
      comment: "Status of the temperature log entry"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the temperature reading"
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Whether the reading represents a deviation from critical limits"
    - name: "monitoring_method"
      expr: monitoring_method
      comment: "Method used to monitor temperature"
    - name: "temperature_trend"
      expr: temperature_trend
      comment: "Trend direction of temperature readings"
    - name: "maintenance_required"
      expr: maintenance_required
      comment: "Whether equipment maintenance is required"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality flag for the temperature reading"
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month when the temperature reading was taken"
    - name: "reading_year"
      expr: YEAR(reading_timestamp)
      comment: "Year when the temperature reading was taken"
  measures:
    - name: "total_temperature_readings"
      expr: COUNT(1)
      comment: "Total number of temperature readings logged"
    - name: "avg_temperature_value"
      expr: AVG(CAST(temperature_value AS DOUBLE))
      comment: "Average temperature value across all readings"
    - name: "min_temperature_value"
      expr: MIN(CAST(temperature_value AS DOUBLE))
      comment: "Minimum temperature value recorded"
    - name: "max_temperature_value"
      expr: MAX(CAST(temperature_value AS DOUBLE))
      comment: "Maximum temperature value recorded"
    - name: "deviation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN deviation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of temperature readings that deviated from critical limits"
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of temperature readings in compliance"
    - name: "maintenance_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN maintenance_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readings indicating maintenance is required"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_critical_control_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical control point monitoring and deviation management for HACCP compliance"
  source: "`vibe_restaurants_v1`.`foodsafety`.`critical_control_point`"
  dimensions:
    - name: "ccp_name"
      expr: name
      comment: "Name of the critical control point"
    - name: "ccp_code"
      expr: code
      comment: "Code identifier for the critical control point"
    - name: "critical_control_point_status"
      expr: critical_control_point_status
      comment: "Current status of the critical control point"
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard controlled by this CCP"
    - name: "process_step"
      expr: process_step
      comment: "Process step where the CCP is applied"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether this control point is designated as critical"
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency at which the CCP is monitored"
    - name: "monitoring_method"
      expr: monitoring_method
      comment: "Method used to monitor the CCP"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify CCP effectiveness"
  measures:
    - name: "total_ccps"
      expr: COUNT(1)
      comment: "Total number of critical control points defined"
    - name: "avg_deviation_value"
      expr: AVG(CAST(average_deviation_value AS DOUBLE))
      comment: "Average deviation value across all CCPs"
    - name: "avg_critical_limit_max"
      expr: AVG(CAST(critical_limit_max AS DOUBLE))
      comment: "Average maximum critical limit across CCPs"
    - name: "avg_critical_limit_min"
      expr: AVG(CAST(critical_limit_min AS DOUBLE))
      comment: "Average minimum critical limit across CCPs"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_haccp_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HACCP plan compliance and lifecycle management for food safety program governance"
  source: "`vibe_restaurants_v1`.`foodsafety`.`haccp_plan`"
  dimensions:
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the HACCP plan"
    - name: "plan_code"
      expr: plan_code
      comment: "Code identifier for the HACCP plan"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of HACCP plan"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the HACCP plan"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the HACCP plan"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the HACCP plan"
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status of the HACCP plan"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level classification of the plan"
    - name: "allergen_control_flag"
      expr: allergen_control_flag
      comment: "Whether allergen control is included in the plan"
    - name: "temperature_monitoring_required_flag"
      expr: temperature_monitoring_required_flag
      comment: "Whether temperature monitoring is required by the plan"
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Whether training is required by the plan"
  measures:
    - name: "total_haccp_plans"
      expr: COUNT(1)
      comment: "Total number of HACCP plans defined"
    - name: "approved_plan_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HACCP plans that are approved"
    - name: "compliant_plan_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HACCP plans in compliance"
    - name: "allergen_control_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN allergen_control_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HACCP plans that include allergen control"
    - name: "temperature_monitoring_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_monitoring_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HACCP plans requiring temperature monitoring"
$$;