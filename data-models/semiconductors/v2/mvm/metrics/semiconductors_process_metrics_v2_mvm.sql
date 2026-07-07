-- Metric views for domain: process | Business: Semiconductors | Version: 2 | Generated on: 2026-06-27 11:25:39

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_defect_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect inspection quality and yield metrics for wafer-level defect detection and classification"
  source: "`vibe_semiconductors_v1`.`process`.`defect_inspection_result`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of defect inspection performed (e.g., optical, e-beam)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., completed, in-progress, failed)"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the inspected lot (e.g., pass, fail, rework)"
    - name: "layer_name"
      expr: layer_name
      comment: "Semiconductor layer where defects were inspected"
    - name: "inspection_mode"
      expr: inspection_mode
      comment: "Mode of inspection operation"
    - name: "excursion_detected"
      expr: excursion_detected
      comment: "Flag indicating whether a process excursion was detected"
    - name: "review_required"
      expr: review_required
      comment: "Flag indicating whether manual review is required"
    - name: "inspection_year"
      expr: YEAR(inspection_timestamp)
      comment: "Year of inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of inspection"
    - name: "inspection_date"
      expr: DATE(inspection_timestamp)
      comment: "Date of inspection"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of defect inspections performed"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per square centimeter across inspections"
    - name: "total_inspected_area_cm2"
      expr: SUM(CAST(inspected_area_cm2 AS DOUBLE))
      comment: "Total area inspected in square centimeters"
    - name: "excursion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN excursion_detected = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections where process excursions were detected"
    - name: "review_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN review_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring manual review"
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections with pass disposition"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_lot_process_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process execution performance metrics for wafer lot processing runs including yield, quality, and efficiency"
  source: "`vibe_semiconductors_v1`.`process`.`lot_process_run`"
  dimensions:
    - name: "lot_disposition"
      expr: lot_disposition
      comment: "Final disposition of the lot after processing (e.g., pass, fail, hold, scrap)"
    - name: "process_qualification_status"
      expr: process_qualification_status
      comment: "Qualification status of the process run"
    - name: "control_chart_violation_flag"
      expr: control_chart_violation_flag
      comment: "Flag indicating whether SPC control chart rules were violated"
    - name: "control_chart_rule_violated"
      expr: control_chart_rule_violated
      comment: "Specific control chart rule that was violated"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for lot hold"
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for lot scrap"
    - name: "recipe_version"
      expr: recipe_version
      comment: "Version of the recipe used for processing"
    - name: "run_year"
      expr: YEAR(actual_start_timestamp)
      comment: "Year of process run start"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month of process run start"
    - name: "run_date"
      expr: DATE(actual_start_timestamp)
      comment: "Date of process run start"
  measures:
    - name: "total_process_runs"
      expr: COUNT(1)
      comment: "Total number of lot process runs executed"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per square centimeter across process runs"
    - name: "avg_process_temperature"
      expr: AVG(CAST(process_temperature_c AS DOUBLE))
      comment: "Average process temperature in Celsius"
    - name: "avg_process_pressure"
      expr: AVG(CAST(process_pressure_torr AS DOUBLE))
      comment: "Average process pressure in Torr"
    - name: "avg_process_power"
      expr: AVG(CAST(process_power_watts AS DOUBLE))
      comment: "Average process power in Watts"
    - name: "avg_gas_flow_rate"
      expr: AVG(CAST(process_gas_flow_sccm AS DOUBLE))
      comment: "Average process gas flow rate in standard cubic centimeters per minute"
    - name: "total_waste_heat_recovered"
      expr: SUM(CAST(waste_heat_recovered_kwh AS DOUBLE))
      comment: "Total waste heat recovered in kilowatt-hours across all process runs"
    - name: "control_violation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN control_chart_violation_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process runs with SPC control chart violations"
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lot_disposition = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process runs with pass disposition"
    - name: "scrap_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lot_disposition = 'scrap' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process runs resulting in scrap"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_metrology`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process capability and measurement quality metrics for wafer metrology including Cpk, uniformity, and SPC performance"
  source: "`vibe_semiconductors_v1`.`process`.`metrology_measurement`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of metrology measurement (e.g., thickness, CD, overlay)"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (e.g., completed, failed, aborted)"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision based on measurement results"
    - name: "layer_name"
      expr: layer_name
      comment: "Semiconductor layer being measured"
    - name: "measurement_parameter"
      expr: measurement_parameter
      comment: "Specific parameter being measured"
    - name: "measurement_mode"
      expr: measurement_mode
      comment: "Mode of measurement operation"
    - name: "spc_rule_violation"
      expr: spc_rule_violation
      comment: "SPC rule violation detected during measurement"
    - name: "fab_site_code"
      expr: fab_site_code
      comment: "Fabrication site where measurement was performed"
    - name: "measurement_year"
      expr: YEAR(measurement_timestamp)
      comment: "Year of measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement"
    - name: "measurement_date"
      expr: DATE(measurement_timestamp)
      comment: "Date of measurement"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of metrology measurements performed"
    - name: "avg_cpk"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average process capability index (Cpk) across measurements"
    - name: "avg_cp"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average process capability index (Cp) across measurements"
    - name: "avg_uniformity"
      expr: AVG(CAST(uniformity_percent AS DOUBLE))
      comment: "Average uniformity percentage across wafers"
    - name: "avg_mean_value"
      expr: AVG(CAST(mean_value AS DOUBLE))
      comment: "Average of mean measurement values"
    - name: "avg_std_deviation"
      expr: AVG(CAST(std_deviation AS DOUBLE))
      comment: "Average standard deviation of measurements"
    - name: "avg_three_sigma"
      expr: AVG(CAST(three_sigma AS DOUBLE))
      comment: "Average three-sigma value across measurements"
    - name: "capable_process_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cpk_value >= 1.33 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements with Cpk >= 1.33 indicating capable process"
    - name: "spc_violation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN spc_rule_violation IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements with SPC rule violations"
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements with pass disposition"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_spc_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical process control metrics for real-time process monitoring and control limit violations"
  source: "`vibe_semiconductors_v1`.`process`.`spc_measurement`"
  dimensions:
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the parameter being monitored"
    - name: "parameter_code"
      expr: parameter_code
      comment: "Code identifier for the monitored parameter"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of SPC measurement"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the SPC measurement"
    - name: "out_of_control_flag"
      expr: out_of_control_flag
      comment: "Flag indicating whether measurement is out of statistical control"
    - name: "out_of_spec_flag"
      expr: out_of_spec_flag
      comment: "Flag indicating whether measurement is out of specification limits"
    - name: "rule_violation_flags"
      expr: rule_violation_flags
      comment: "Flags indicating which SPC rules were violated"
    - name: "process_action_taken"
      expr: process_action_taken
      comment: "Corrective action taken in response to SPC violation"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the parameter"
    - name: "measurement_year"
      expr: YEAR(measurement_timestamp)
      comment: "Year of SPC measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of SPC measurement"
    - name: "measurement_date"
      expr: DATE(measurement_timestamp)
      comment: "Date of SPC measurement"
  measures:
    - name: "total_spc_measurements"
      expr: COUNT(1)
      comment: "Total number of SPC measurements recorded"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all SPC measurements"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value for the monitored parameters"
    - name: "avg_deviation_from_target"
      expr: AVG(CAST(deviation_from_target AS DOUBLE))
      comment: "Average deviation from target value"
    - name: "avg_sigma_level"
      expr: AVG(CAST(sigma_level AS DOUBLE))
      comment: "Average sigma level indicating process capability"
    - name: "out_of_control_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN out_of_control_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements that are out of statistical control"
    - name: "out_of_spec_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN out_of_spec_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements that are out of specification limits"
    - name: "rule_violation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rule_violation_flags IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements with SPC rule violations"
    - name: "action_taken_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN process_action_taken IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements where corrective action was taken"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_yield_loss`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield loss and defect impact metrics for root cause analysis and yield improvement initiatives"
  source: "`vibe_semiconductors_v1`.`process`.`yield_loss_event`"
  dimensions:
    - name: "yield_loss_mode"
      expr: yield_loss_mode
      comment: "Mode or category of yield loss"
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect causing yield loss"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause for yield loss"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the yield loss event"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the yield loss event"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the yield loss event"
    - name: "disposition_action"
      expr: disposition_action
      comment: "Disposition action taken for the affected material"
    - name: "layer_name"
      expr: layer_name
      comment: "Semiconductor layer where yield loss occurred"
    - name: "lot_hold_applied"
      expr: lot_hold_applied
      comment: "Flag indicating whether lot hold was applied"
    - name: "fab_site_code"
      expr: fab_site_code
      comment: "Fabrication site where yield loss occurred"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year of yield loss event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of yield loss event"
    - name: "event_date"
      expr: DATE(event_timestamp)
      comment: "Date of yield loss event"
  measures:
    - name: "total_yield_loss_events"
      expr: COUNT(1)
      comment: "Total number of yield loss events recorded"
    - name: "avg_yield_impact"
      expr: AVG(CAST(estimated_yield_impact_percent AS DOUBLE))
      comment: "Average estimated yield impact percentage per event"
    - name: "total_yield_impact"
      expr: SUM(CAST(estimated_yield_impact_percent AS DOUBLE))
      comment: "Total cumulative yield impact percentage across all events"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per square centimeter for yield loss events"
    - name: "avg_defect_size"
      expr: AVG(CAST(defect_size_nm AS DOUBLE))
      comment: "Average defect size in nanometers"
    - name: "avg_cpk"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average process capability index (Cpk) for yield loss events"
    - name: "lot_hold_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lot_hold_applied = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of yield loss events resulting in lot hold"
    - name: "resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_status = 'resolved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of yield loss events that have been resolved"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process flow design and performance metrics including cycle time, yield targets, and technology complexity"
  source: "`vibe_semiconductors_v1`.`process`.`flow`"
  dimensions:
    - name: "flow_type"
      expr: flow_type
      comment: "Type of process flow (e.g., standard, custom, prototype)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the process flow"
    - name: "is_baseline_flow"
      expr: is_baseline_flow
      comment: "Flag indicating whether this is a baseline reference flow"
    - name: "cool_optimization_enabled"
      expr: cool_optimization_enabled
      comment: "Flag indicating whether cooling optimization is enabled"
    - name: "waste_heat_recovery_enabled"
      expr: waste_heat_recovery_enabled
      comment: "Flag indicating whether waste heat recovery is enabled"
    - name: "supports_multi_patterning"
      expr: supports_multi_patterning
      comment: "Flag indicating whether flow supports multi-patterning lithography"
    - name: "fab_site_code"
      expr: fab_site_code
      comment: "Fabrication site code where flow is used"
    - name: "owner_organization"
      expr: owner_organization
      comment: "Organization responsible for the process flow"
    - name: "qualification_year"
      expr: YEAR(qualification_date)
      comment: "Year of flow qualification"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year when flow became effective"
  measures:
    - name: "total_flows"
      expr: COUNT(1)
      comment: "Total number of process flows defined"
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average cycle time in days across all process flows"
    - name: "avg_target_yield"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage across all process flows"
    - name: "avg_baseline_cpk"
      expr: AVG(CAST(baseline_cpk AS DOUBLE))
      comment: "Average baseline process capability index (Cpk) across flows"
    - name: "qualified_flow_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qualification_status = 'qualified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of flows that are fully qualified"
    - name: "baseline_flow_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_baseline_flow = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of flows designated as baseline flows"
    - name: "cooling_optimization_adoption"
      expr: ROUND(100.0 * SUM(CASE WHEN cool_optimization_enabled = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of flows with cooling optimization enabled"
    - name: "heat_recovery_adoption"
      expr: ROUND(100.0 * SUM(CASE WHEN waste_heat_recovery_enabled = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of flows with waste heat recovery enabled"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process and product qualification metrics including Cpk achievement, yield performance, and customer approval"
  source: "`vibe_semiconductors_v1`.`process`.`qualification`"
  dimensions:
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g., process, product, tool, customer)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current status of the qualification"
    - name: "customer_approval_status"
      expr: customer_approval_status
      comment: "Customer approval status for the qualification"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the qualification"
    - name: "requires_customer_approval"
      expr: requires_customer_approval
      comment: "Flag indicating whether customer approval is required"
    - name: "cooling_optimization_evaluated"
      expr: cooling_optimization_evaluated
      comment: "Flag indicating whether cooling optimization was evaluated"
    - name: "owner_organization"
      expr: owner_organization
      comment: "Organization responsible for the qualification"
    - name: "fab_site_code"
      expr: fab_site_code
      comment: "Fabrication site where qualification was performed"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year qualification started"
    - name: "completion_year"
      expr: YEAR(actual_completion_date)
      comment: "Year qualification was completed"
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of qualification activities"
    - name: "avg_actual_cpk"
      expr: AVG(CAST(actual_cpk AS DOUBLE))
      comment: "Average actual process capability index (Cpk) achieved"
    - name: "avg_target_cpk"
      expr: AVG(CAST(target_cpk AS DOUBLE))
      comment: "Average target process capability index (Cpk)"
    - name: "avg_actual_yield"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percentage achieved"
    - name: "avg_target_yield"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage"
    - name: "cpk_achievement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_cpk >= target_cpk THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN actual_cpk IS NOT NULL AND target_cpk IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of qualifications meeting or exceeding target Cpk"
    - name: "yield_achievement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_yield_percent >= target_yield_percent THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN actual_yield_percent IS NOT NULL AND target_yield_percent IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of qualifications meeting or exceeding target yield"
    - name: "customer_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_approval_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN requires_customer_approval = true THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of qualifications requiring customer approval that were approved"
    - name: "qualification_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qualification_status = 'passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications that passed successfully"
$$;