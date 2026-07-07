-- Metric views for domain: equipment | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment calibration metrics tracking calibration compliance, results, and measurement accuracy"
  source: "`vibe_semiconductors_v1`.`equipment`.`calibration_record`"
  dimensions:
    - name: "calibration_type"
      expr: calibration_type
      comment: "Type of calibration performed"
    - name: "calibration_method"
      expr: calibration_method
      comment: "Method used for calibration"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Status of the calibration"
    - name: "calibration_record_status"
      expr: calibration_record_status
      comment: "Record status of the calibration"
    - name: "calibration_result"
      expr: calibration_result
      comment: "Result of the calibration (pass/fail)"
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Pass or fail result of calibration"
    - name: "calibration_standard"
      expr: calibration_standard
      comment: "Calibration standard used"
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for calibration"
    - name: "calibration_month"
      expr: DATE_TRUNC('MONTH', calibration_date)
      comment: "Month when calibration was performed"
    - name: "calibration_quarter"
      expr: CONCAT(YEAR(calibration_date), '-Q', QUARTER(calibration_date))
      comment: "Quarter when calibration was performed"
  measures:
    - name: "total_calibrations"
      expr: COUNT(DISTINCT calibration_record_id)
      comment: "Total number of calibration records"
    - name: "calibrations_passed"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_result = 'Pass' THEN calibration_record_id END)
      comment: "Number of calibrations that passed"
    - name: "calibrations_failed"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_result = 'Fail' THEN calibration_record_id END)
      comment: "Number of calibrations that failed"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across calibrations"
    - name: "avg_nominal_value"
      expr: AVG(CAST(nominal_value AS DOUBLE))
      comment: "Average nominal (expected) value across calibrations"
    - name: "avg_as_found_value"
      expr: AVG(CAST(as_found_value AS DOUBLE))
      comment: "Average as-found value before calibration adjustment"
    - name: "avg_as_left_value"
      expr: AVG(CAST(as_left_value AS DOUBLE))
      comment: "Average as-left value after calibration adjustment"
    - name: "avg_tolerance"
      expr: AVG(CAST(tolerance AS DOUBLE))
      comment: "Average tolerance specification"
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_process_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment process recipe governance KPIs — monitors recipe lifecycle, OEE targets, and yield performance across the recipe library."
  source: "`vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe`"
  dimensions:
    - name: "recipe_status"
      expr: recipe_status
      comment: "Current status of the recipe (active, deprecated, under-review) for recipe library governance."
    - name: "recipe_category"
      expr: recipe_category
      comment: "Category of the recipe (etch, deposition, litho) for process-type analysis."
    - name: "process_type"
      expr: process_type
      comment: "Process type associated with the recipe; enables process-level performance benchmarking."
    - name: "process_node_target"
      expr: process_node_target
      comment: "Target process node for the recipe; used for technology node capacity and readiness analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Recipe approval status (approved, pending, rejected) for change control compliance."
    - name: "is_active"
      expr: is_active
      comment: "Whether the recipe is currently active in production; used to filter the active recipe library."
    - name: "is_deprecated"
      expr: is_deprecated
      comment: "Whether the recipe has been deprecated; used to track recipe lifecycle and cleanup."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the recipe became effective; used for recipe vintage and lifecycle analysis."
  measures:
    - name: "total_recipes"
      expr: COUNT(1)
      comment: "Total equipment process recipes; baseline for recipe library size and governance scope."
    - name: "active_recipe_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active recipes; measures the active production recipe footprint."
    - name: "avg_oee_actual_percent"
      expr: AVG(CAST(oee_actual_percent AS DOUBLE))
      comment: "Average actual OEE achieved during recipe execution; measures recipe-level equipment productivity."
    - name: "avg_oee_target_percent"
      expr: AVG(CAST(oee_target_percent AS DOUBLE))
      comment: "Average OEE target for recipes; used to assess ambition level of recipe performance targets."
    - name: "avg_yield_actual_percent"
      expr: AVG(CAST(yield_actual_percent AS DOUBLE))
      comment: "Average actual yield achieved by recipes; primary recipe quality KPI linking process recipes to yield outcomes."
    - name: "avg_yield_target_percent"
      expr: AVG(CAST(yield_target_percent AS DOUBLE))
      comment: "Average yield target for recipes; used to assess yield gap between target and actual performance."
    - name: "avg_temperature_setpoint_c"
      expr: AVG(CAST(temperature_setpoint_c AS DOUBLE))
      comment: "Average temperature setpoint across recipes; used for process characterization and recipe library analysis."
    - name: "deprecated_recipe_count"
      expr: COUNT(CASE WHEN is_deprecated = TRUE THEN 1 END)
      comment: "Number of deprecated recipes still in the system; measures recipe library hygiene and governance effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_fab_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core equipment asset metrics tracking tool capacity, utilization, and operational efficiency for fab tools"
  source: "`vibe_semiconductors_v1`.`equipment`.`fab_tool`"
  dimensions:
    - name: "tool_type"
      expr: tool_type
      comment: "Type of fabrication tool (e.g., lithography, etch, deposition)"
    - name: "tool_subtype"
      expr: tool_subtype
      comment: "Subtype classification of the tool"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Equipment manufacturer name"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the tool (active, deprecated, decommissioned)"
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset"
    - name: "process_node_compatibility"
      expr: process_node_compatibility
      comment: "Technology nodes this tool can support"
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "Cleanroom classification requirement for the tool"
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Compliance and regulatory status of the tool"
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year the tool was installed"
    - name: "installation_quarter"
      expr: CONCAT(YEAR(installation_date), '-Q', QUARTER(installation_date))
      comment: "Quarter when the tool was installed"
  measures:
    - name: "total_fab_tools"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Total number of unique fab tools"
    - name: "total_capacity_wafers_per_hour"
      expr: SUM(CAST(capacity_wafer_per_hour AS DOUBLE))
      comment: "Total installed capacity in wafers per hour across all tools"
    - name: "avg_capacity_wafers_per_hour"
      expr: AVG(CAST(capacity_wafer_per_hour AS DOUBLE))
      comment: "Average capacity per tool in wafers per hour"
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total power rating across all tools in kilowatts"
    - name: "total_energy_consumption_kwh_per_year"
      expr: SUM(CAST(energy_consumption_kwh_per_year AS DOUBLE))
      comment: "Total annual energy consumption across all tools in kilowatt-hours"
    - name: "avg_oee_percent"
      expr: AVG(CAST(oee_percent AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness percentage across tools"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures in hours"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair in hours"
    - name: "total_capital_expenditure"
      expr: SUM(CAST(capital_expenditure_amount AS DOUBLE))
      comment: "Total capital expenditure for all tools"
    - name: "avg_capital_expenditure"
      expr: AVG(CAST(capital_expenditure_amount AS DOUBLE))
      comment: "Average capital expenditure per tool"
    - name: "tools_requiring_calibration"
      expr: COUNT(DISTINCT CASE WHEN calibration_due_date <= CURRENT_DATE() THEN fab_tool_id END)
      comment: "Number of tools with calibration due or overdue"
    - name: "tools_under_warranty"
      expr: COUNT(DISTINCT CASE WHEN warranty_expiration_date >= CURRENT_DATE() THEN fab_tool_id END)
      comment: "Number of tools currently under warranty"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_fdc_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fault Detection and Classification event metrics tracking equipment anomalies and process excursions"
  source: "`vibe_semiconductors_v1`.`equipment`.`fdc_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of FDC event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the FDC event"
    - name: "alarm_type"
      expr: alarm_type
      comment: "Type of alarm triggered"
    - name: "alarm_status"
      expr: alarm_status
      comment: "Status of the alarm"
    - name: "event_severity"
      expr: event_severity
      comment: "Severity level of the event"
    - name: "severity"
      expr: severity
      comment: "Severity classification"
    - name: "fault_classification"
      expr: fault_classification
      comment: "Classification of the detected fault"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the fault"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the event"
    - name: "source_category"
      expr: source_category
      comment: "Category of the event source"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when the FDC event occurred"
    - name: "event_quarter"
      expr: CONCAT(YEAR(event_timestamp), '-Q', QUARTER(event_timestamp))
      comment: "Quarter when the FDC event occurred"
  measures:
    - name: "total_fdc_events"
      expr: COUNT(DISTINCT fdc_event_id)
      comment: "Total number of FDC events"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual measured value"
    - name: "avg_expected_value"
      expr: AVG(CAST(expected_value AS DOUBLE))
      comment: "Average expected value"
    - name: "avg_parameter_value"
      expr: AVG(CAST(parameter_value AS DOUBLE))
      comment: "Average parameter value at time of event"
    - name: "avg_threshold_high"
      expr: AVG(CAST(threshold_high AS DOUBLE))
      comment: "Average high threshold value"
    - name: "avg_threshold_low"
      expr: AVG(CAST(threshold_low AS DOUBLE))
      comment: "Average low threshold value"
    - name: "avg_normal_range_high"
      expr: AVG(CAST(normal_range_high AS DOUBLE))
      comment: "Average normal range high limit"
    - name: "avg_normal_range_low"
      expr: AVG(CAST(normal_range_low AS DOUBLE))
      comment: "Average normal range low limit"
    - name: "avg_oee_impact_percentage"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average impact on Overall Equipment Effectiveness as percentage"
    - name: "escalated_events"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN fdc_event_id END)
      comment: "Number of events that were escalated"
    - name: "simulated_events"
      expr: COUNT(DISTINCT CASE WHEN is_simulated = TRUE THEN fdc_event_id END)
      comment: "Number of simulated (test) events"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_maintenance_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance contract financial and service level metrics tracking vendor performance and costs"
  source: "`vibe_semiconductors_v1`.`equipment`.`maintenance_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of maintenance contract"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "maintenance_contract_status"
      expr: maintenance_contract_status
      comment: "Detailed maintenance contract status"
    - name: "service_level"
      expr: service_level
      comment: "Service level tier of the contract"
    - name: "coverage_scope"
      expr: coverage_scope
      comment: "Scope of coverage provided"
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment covered"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of contract value"
    - name: "renewal_option"
      expr: renewal_option
      comment: "Contract renewal option terms"
    - name: "contract_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT maintenance_contract_id)
      comment: "Total number of maintenance contracts"
    - name: "total_annual_cost_usd"
      expr: SUM(CAST(annual_cost_usd AS DOUBLE))
      comment: "Total annual cost of all contracts in USD"
    - name: "avg_annual_cost_usd"
      expr: AVG(CAST(annual_cost_usd AS DOUBLE))
      comment: "Average annual cost per contract in USD"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total value of all contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value"
    - name: "avg_sla_response_hours"
      expr: AVG(CAST(sla_response_hours AS DOUBLE))
      comment: "Average SLA response time in hours"
    - name: "exclusive_contracts"
      expr: COUNT(DISTINCT CASE WHEN is_exclusive = TRUE THEN maintenance_contract_id END)
      comment: "Number of exclusive maintenance contracts"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_maintenance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance operations metrics tracking downtime, costs, and maintenance effectiveness"
  source: "`vibe_semiconductors_v1`.`equipment`.`maintenance_event`"
  dimensions:
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance performed (preventive, corrective, predictive)"
    - name: "maintenance_category"
      expr: maintenance_category
      comment: "Category classification of the maintenance event"
    - name: "event_type"
      expr: event_type
      comment: "Type of maintenance event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the maintenance event"
    - name: "maintenance_event_status"
      expr: maintenance_event_status
      comment: "Detailed status of the maintenance event"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for the maintenance need"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Mode of failure that triggered maintenance"
    - name: "requalification_status"
      expr: requalification_status
      comment: "Status of tool requalification after maintenance"
    - name: "upgrade_type"
      expr: upgrade_type
      comment: "Type of upgrade performed during maintenance"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month when the maintenance event started"
    - name: "event_quarter"
      expr: CONCAT(YEAR(start_timestamp), '-Q', QUARTER(start_timestamp))
      comment: "Quarter when the maintenance event started"
  measures:
    - name: "total_maintenance_events"
      expr: COUNT(DISTINCT maintenance_event_id)
      comment: "Total number of maintenance events"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime in hours due to maintenance"
    - name: "avg_downtime_hours"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average downtime per maintenance event in hours"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_usd AS DOUBLE))
      comment: "Total labor cost for maintenance in USD"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost_usd AS DOUBLE))
      comment: "Total parts cost for maintenance in USD"
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total maintenance cost including labor and parts"
    - name: "avg_maintenance_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per maintenance event"
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours spent on maintenance"
    - name: "avg_labor_hours"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per maintenance event"
    - name: "avg_oee_impact_percentage"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average impact on Overall Equipment Effectiveness as percentage"
    - name: "events_requiring_requalification"
      expr: COUNT(DISTINCT CASE WHEN requalification_required = TRUE THEN maintenance_event_id END)
      comment: "Number of maintenance events requiring tool requalification"
    - name: "safety_incidents"
      expr: COUNT(DISTINCT CASE WHEN safety_incident_flag = TRUE THEN maintenance_event_id END)
      comment: "Number of maintenance events with safety incidents"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_metrology_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrology run performance KPIs — monitors measurement quality, tool accuracy, and process control effectiveness."
  source: "`vibe_semiconductors_v1`.`equipment`.`metrology_run`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of metrology measurement (CD, overlay, film thickness) for parameter-specific analysis."
    - name: "measurement_mode"
      expr: measurement_mode
      comment: "Measurement mode (inline, offline, monitor) for coverage and sampling strategy analysis."
    - name: "metrology_run_status"
      expr: metrology_run_status
      comment: "Status of the metrology run (completed, failed, aborted) for data quality filtering."
    - name: "pass_fail"
      expr: pass_fail
      comment: "Pass/fail result of the metrology run; primary quality gate indicator."
    - name: "shift"
      expr: shift
      comment: "Production shift during which the metrology run was performed; enables shift-level measurement quality comparison."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for the metrology run; ensures dimensional consistency in analysis."
    - name: "run_timestamp"
      expr: DATE_TRUNC('month', run_timestamp)
      comment: "Month of the metrology run for time-series measurement quality trending."
  measures:
    - name: "total_metrology_runs"
      expr: COUNT(1)
      comment: "Total metrology runs; baseline volume for measurement coverage and sampling plan compliance."
    - name: "avg_measured_mean"
      expr: AVG(CAST(measured_mean AS DOUBLE))
      comment: "Average measured mean value across metrology runs; monitors process centering and drift over time."
    - name: "avg_measured_sigma"
      expr: AVG(CAST(measured_sigma AS DOUBLE))
      comment: "Average measured sigma (process variation); key process control KPI for yield prediction and SPC."
    - name: "avg_oee_percent"
      expr: AVG(CAST(oee_percent AS DOUBLE))
      comment: "Average OEE of the metrology tool during runs; measures metrology tool productivity and availability."
    - name: "pass_count"
      expr: COUNT(CASE WHEN pass_fail = 'PASS' THEN 1 END)
      comment: "Number of metrology runs that passed spec limits; numerator for metrology pass rate KPI."
    - name: "fail_count"
      expr: COUNT(CASE WHEN pass_fail = 'FAIL' THEN 1 END)
      comment: "Number of metrology runs that failed spec limits; identifies process excursions requiring engineering response."
    - name: "avg_spec_range"
      expr: AVG(spec_limit_high - spec_limit_low)
      comment: "Average specification window width; used to assess tightness of process control requirements."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall Equipment Effectiveness metrics tracking availability, performance, and quality rates"
  source: "`vibe_semiconductors_v1`.`equipment`.`oee_record`"
  dimensions:
    - name: "measurement_period"
      expr: measurement_period
      comment: "Time period for OEE measurement (shift, day, week)"
    - name: "shift_name"
      expr: shift_name
      comment: "Name of the production shift"
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (planned, unplanned, maintenance)"
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Coded reason for downtime"
    - name: "record_status"
      expr: record_status
      comment: "Status of the OEE record"
    - name: "oee_calculation_method"
      expr: oee_calculation_method
      comment: "Method used to calculate OEE"
    - name: "state_current"
      expr: state_current
      comment: "Current operational state of the equipment"
    - name: "record_month"
      expr: DATE_TRUNC('MONTH', record_date)
      comment: "Month of the OEE record"
    - name: "record_quarter"
      expr: CONCAT(YEAR(record_date), '-Q', QUARTER(record_date))
      comment: "Quarter of the OEE record"
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the production shift"
  measures:
    - name: "total_oee_records"
      expr: COUNT(DISTINCT oee_record_id)
      comment: "Total number of OEE measurement records"
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness percentage"
    - name: "avg_availability_rate"
      expr: AVG(CAST(availability_rate AS DOUBLE))
      comment: "Average equipment availability rate"
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average equipment performance rate"
    - name: "avg_quality_rate"
      expr: AVG(CAST(quality_rate AS DOUBLE))
      comment: "Average quality rate (good units / total units)"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime in hours"
    - name: "total_scheduled_downtime_hours"
      expr: SUM(CAST(scheduled_downtime_hours AS DOUBLE))
      comment: "Total scheduled downtime in hours"
    - name: "total_unscheduled_downtime_hours"
      expr: SUM(CAST(unscheduled_downtime_hours AS DOUBLE))
      comment: "Total unscheduled downtime in hours"
    - name: "total_productive_hours"
      expr: SUM(CAST(productive_hours AS DOUBLE))
      comment: "Total productive operating hours"
    - name: "total_available_hours"
      expr: SUM(CAST(available_hours AS DOUBLE))
      comment: "Total available hours for production"
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours (available but not producing)"
    - name: "total_engineering_hours"
      expr: SUM(CAST(engineering_hours AS DOUBLE))
      comment: "Total engineering hours (setup, qualification, etc.)"
    - name: "total_uptime_hours"
      expr: SUM(CAST(uptime_hours AS DOUBLE))
      comment: "Total uptime hours"
    - name: "avg_wafer_throughput"
      expr: AVG(CAST(wafer_throughput AS DOUBLE))
      comment: "Average wafer throughput rate"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance schedule compliance and planning KPIs — ensures PM program effectiveness and minimizes unplanned downtime."
  source: "`vibe_semiconductors_v1`.`equipment`.`pm_schedule`"
  dimensions:
    - name: "pm_type"
      expr: pm_type
      comment: "Type of preventive maintenance (daily, weekly, quarterly, annual) for schedule planning."
    - name: "pm_schedule_status"
      expr: pm_schedule_status
      comment: "Current status of the PM schedule (active, suspended, completed) for program management."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the PM is on a critical tool; prioritizes scheduling resources for maximum reliability impact."
    - name: "priority"
      expr: priority
      comment: "Priority level of the PM schedule; used to resolve scheduling conflicts."
    - name: "schedule_basis"
      expr: schedule_basis
      comment: "Basis for PM scheduling (time-based, usage-based, condition-based); reflects maintenance strategy maturity."
    - name: "next_due_date"
      expr: DATE_TRUNC('month', next_due_date)
      comment: "Month when PM is next due; used for forward-looking maintenance workload planning."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total active PM schedules; baseline for PM program coverage assessment."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated PM duration; used for maintenance window planning and production scheduling."
    - name: "avg_oee_impact_estimate"
      expr: AVG(CAST(oee_impact_estimate AS DOUBLE))
      comment: "Average estimated OEE impact per PM event; used to optimize PM scheduling to minimize production impact."
    - name: "critical_pm_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of PM schedules on critical tools; measures the scope of high-priority maintenance obligations."
    - name: "overdue_pm_count"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of overdue PM schedules; critical compliance and reliability risk indicator requiring immediate scheduling action."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_recipe_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process recipe execution metrics tracking recipe performance, compliance, and process control"
  source: "`vibe_semiconductors_v1`.`equipment`.`recipe_execution`"
  dimensions:
    - name: "execution_status"
      expr: execution_status
      comment: "Status of the recipe execution"
    - name: "execution_result"
      expr: execution_result
      comment: "Result of the recipe execution"
    - name: "result_disposition"
      expr: result_disposition
      comment: "Disposition of the execution result"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the execution"
    - name: "process_step"
      expr: process_step
      comment: "Process step where recipe was executed"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment used"
    - name: "recipe_version"
      expr: recipe_version
      comment: "Version of the recipe executed"
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month when execution started"
    - name: "execution_quarter"
      expr: CONCAT(YEAR(start_timestamp), '-Q', QUARTER(start_timestamp))
      comment: "Quarter when execution started"
  measures:
    - name: "total_recipe_executions"
      expr: COUNT(DISTINCT recipe_execution_id)
      comment: "Total number of recipe executions"
    - name: "avg_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average execution duration in seconds"
    - name: "total_duration_seconds"
      expr: SUM(CAST(duration_seconds AS DOUBLE))
      comment: "Total execution time in seconds"
    - name: "avg_temperature_actual_c"
      expr: AVG(CAST(temperature_actual_c AS DOUBLE))
      comment: "Average actual temperature in Celsius"
    - name: "avg_temperature_setpoint_c"
      expr: AVG(CAST(temperature_setpoint_c AS DOUBLE))
      comment: "Average temperature setpoint in Celsius"
    - name: "avg_pressure_actual_pa"
      expr: AVG(CAST(pressure_actual_pa AS DOUBLE))
      comment: "Average actual pressure in Pascals"
    - name: "avg_pressure_setpoint_pa"
      expr: AVG(CAST(pressure_setpoint_pa AS DOUBLE))
      comment: "Average pressure setpoint in Pascals"
    - name: "avg_power_actual_w"
      expr: AVG(CAST(power_actual_w AS DOUBLE))
      comment: "Average actual power in Watts"
    - name: "avg_power_setpoint_w"
      expr: AVG(CAST(power_setpoint_w AS DOUBLE))
      comment: "Average power setpoint in Watts"
    - name: "avg_gas_flow_actual_sccm"
      expr: AVG(CAST(gas_flow_actual_sccm AS DOUBLE))
      comment: "Average actual gas flow rate in standard cubic centimeters per minute"
    - name: "avg_gas_flow_setpoint_sccm"
      expr: AVG(CAST(gas_flow_setpoint_sccm AS DOUBLE))
      comment: "Average gas flow setpoint in standard cubic centimeters per minute"
    - name: "avg_oee_availability_percent"
      expr: AVG(CAST(oee_availability_percent AS DOUBLE))
      comment: "Average OEE availability percentage"
    - name: "avg_oee_performance_percent"
      expr: AVG(CAST(oee_performance_percent AS DOUBLE))
      comment: "Average OEE performance percentage"
    - name: "avg_oee_quality_percent"
      expr: AVG(CAST(oee_quality_percent AS DOUBLE))
      comment: "Average OEE quality percentage"
    - name: "calibrated_executions"
      expr: COUNT(DISTINCT CASE WHEN is_calibrated = TRUE THEN recipe_execution_id END)
      comment: "Number of executions on calibrated equipment"
    - name: "critical_executions"
      expr: COUNT(DISTINCT CASE WHEN is_critical = TRUE THEN recipe_execution_id END)
      comment: "Number of critical recipe executions"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_spc_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Process Control metrics tracking process stability, capability, and control violations"
  source: "`vibe_semiconductors_v1`.`equipment`.`spc_control`"
  dimensions:
    - name: "control_status"
      expr: control_status
      comment: "Status of the SPC control"
    - name: "spc_status"
      expr: spc_status
      comment: "SPC status classification"
    - name: "spc_control_status"
      expr: spc_control_status
      comment: "Detailed SPC control status"
    - name: "chart_type"
      expr: chart_type
      comment: "Type of control chart (X-bar, R, p, c, etc.)"
    - name: "control_chart_type"
      expr: control_chart_type
      comment: "Control chart type classification"
    - name: "violation_type"
      expr: violation_type
      comment: "Type of control limit violation"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the control violation"
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of process trend"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation actions"
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the controlled parameter"
    - name: "process_step"
      expr: process_step
      comment: "Process step being monitored"
    - name: "shift"
      expr: shift
      comment: "Production shift"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the SPC event"
    - name: "event_quarter"
      expr: CONCAT(YEAR(event_timestamp), '-Q', QUARTER(event_timestamp))
      comment: "Quarter of the SPC event"
  measures:
    - name: "total_spc_events"
      expr: COUNT(DISTINCT spc_control_id)
      comment: "Total number of SPC control events"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value"
    - name: "avg_center_line"
      expr: AVG(CAST(center_line AS DOUBLE))
      comment: "Average center line value"
    - name: "avg_upper_control_limit"
      expr: AVG(CAST(upper_control_limit AS DOUBLE))
      comment: "Average upper control limit"
    - name: "avg_lower_control_limit"
      expr: AVG(CAST(lower_control_limit AS DOUBLE))
      comment: "Average lower control limit"
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit"
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit"
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average process capability index (Cpk)"
    - name: "compliant_events"
      expr: COUNT(DISTINCT CASE WHEN compliance_flag = TRUE THEN spc_control_id END)
      comment: "Number of compliant SPC events"
    - name: "false_alarms"
      expr: COUNT(DISTINCT CASE WHEN is_false_alarm = TRUE THEN spc_control_id END)
      comment: "Number of false alarm events"
    - name: "repeat_violations"
      expr: COUNT(DISTINCT CASE WHEN is_repeat_violation = TRUE THEN spc_control_id END)
      comment: "Number of repeat violation events"
    - name: "regulatory_reported_events"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reported = TRUE THEN spc_control_id END)
      comment: "Number of events reported to regulatory authorities"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_alarm`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool alarm management KPIs — monitors alarm rates, severity distribution, and response effectiveness to improve equipment reliability."
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_alarm`"
  dimensions:
    - name: "alarm_type"
      expr: alarm_type
      comment: "Type of tool alarm (process, equipment, safety) for categorized alarm analysis."
    - name: "alarm_category"
      expr: alarm_category
      comment: "Category of the alarm for alarm rationalization and prioritization."
    - name: "alarm_severity"
      expr: alarm_severity
      comment: "Severity level of the alarm (critical, major, minor) for response prioritization."
    - name: "alarm_status"
      expr: alarm_status
      comment: "Current status of the alarm (active, acknowledged, cleared) for alarm management tracking."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause of the alarm; used to identify systemic equipment issues driving alarm rates."
    - name: "oee_impact_flag"
      expr: oee_impact_flag
      comment: "Whether the alarm impacted OEE; used to quantify the production impact of alarm events."
    - name: "predicted_failure_flag"
      expr: predicted_failure_flag
      comment: "Whether the alarm was a predictive failure indicator; measures predictive maintenance program effectiveness."
    - name: "alarm_timestamp"
      expr: DATE_TRUNC('month', alarm_timestamp)
      comment: "Month of alarm occurrence for time-series alarm rate trending."
  measures:
    - name: "total_alarms"
      expr: COUNT(1)
      comment: "Total tool alarms; baseline alarm rate KPI for equipment reliability and alarm management programs."
    - name: "acknowledged_alarm_count"
      expr: COUNT(CASE WHEN acknowledged_flag = TRUE THEN 1 END)
      comment: "Number of acknowledged alarms; measures alarm response compliance and operator engagement."
    - name: "oee_impacting_alarm_count"
      expr: COUNT(CASE WHEN oee_impact_flag = TRUE THEN 1 END)
      comment: "Number of alarms that impacted OEE; quantifies the production impact of the alarm landscape."
    - name: "predictive_alarm_count"
      expr: COUNT(CASE WHEN predicted_failure_flag = TRUE THEN 1 END)
      comment: "Number of predictive failure alarms; measures the effectiveness of the predictive maintenance program."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average alarm severity score; used to track overall equipment health and alarm criticality trends."
    - name: "distinct_tools_with_alarms"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Number of distinct tools generating alarms; measures breadth of equipment reliability issues across the fleet."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_capex`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure KPIs for equipment — tracks CAPEX investment, approval pipeline, and warranty claim exposure for the tool fleet."
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_capex`"
  dimensions:
    - name: "capex_status"
      expr: capex_status
      comment: "Current CAPEX approval status (pending, approved, rejected, capitalized) for investment pipeline management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the CAPEX request; used to track investment decision velocity."
    - name: "budget_year"
      expr: budget_year
      comment: "Fiscal year of the CAPEX budget; enables year-over-year investment comparison."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (straight-line, accelerated); impacts financial reporting and tax planning."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty coverage on the CAPEX item; used for risk and cost exposure analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of CAPEX funding (internal, government grant, JV); used for financial reporting and compliance."
    - name: "capex_date"
      expr: DATE_TRUNC('year', capex_date)
      comment: "Year of CAPEX transaction for investment trend analysis."
  measures:
    - name: "total_capex_amount_usd"
      expr: SUM(CAST(capex_amount_usd AS DOUBLE))
      comment: "Total CAPEX invested in equipment; primary financial KPI for capital allocation and board-level investment reporting."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved CAPEX amount; measures committed investment pipeline for financial planning."
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total requested CAPEX amount; used to assess investment demand vs. approved budget."
    - name: "total_installation_cost"
      expr: SUM(CAST(installation_cost AS DOUBLE))
      comment: "Total installation costs for equipment CAPEX; captures full cost of ownership beyond purchase price."
    - name: "total_warranty_claim_amount"
      expr: SUM(CAST(warranty_claim_total_amount AS DOUBLE))
      comment: "Total warranty claim amounts; measures warranty recovery value and vendor accountability."
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price per CAPEX item; used for benchmarking and vendor negotiation."
    - name: "pending_approval_amount"
      expr: SUM(CASE WHEN approval_status = 'PENDING' THEN requested_amount ELSE 0 END)
      comment: "Total CAPEX pending approval; measures investment decision backlog and financial commitment risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_chamber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool chamber operational metrics tracking chamber utilization, status, and performance"
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_chamber`"
  dimensions:
    - name: "chamber_type"
      expr: chamber_type
      comment: "Type of tool chamber"
    - name: "chamber_status"
      expr: chamber_status
      comment: "Current operational status of the chamber"
    - name: "tool_chamber_status"
      expr: tool_chamber_status
      comment: "Detailed tool chamber status"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the chamber"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status of the chamber"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the chamber"
    - name: "process_capability"
      expr: process_capability
      comment: "Process capability classification"
    - name: "safety_lock_status"
      expr: safety_lock_status
      comment: "Safety interlock status"
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year the chamber was installed"
  measures:
    - name: "total_chambers"
      expr: COUNT(DISTINCT tool_chamber_id)
      comment: "Total number of tool chambers"
    - name: "avg_chamber_lifetime_hours"
      expr: AVG(CAST(chamber_lifetime_hours AS DOUBLE))
      comment: "Average lifetime operating hours per chamber"
    - name: "total_chamber_lifetime_hours"
      expr: SUM(CAST(chamber_lifetime_hours AS DOUBLE))
      comment: "Total lifetime operating hours across all chambers"
    - name: "avg_max_temperature_c"
      expr: AVG(CAST(max_temperature_c AS DOUBLE))
      comment: "Average maximum temperature capability in Celsius"
    - name: "avg_max_pressure_torr"
      expr: AVG(CAST(max_pressure_torr AS DOUBLE))
      comment: "Average maximum pressure capability in Torr"
    - name: "avg_temperature_setpoint_c"
      expr: AVG(CAST(temperature_setpoint_c AS DOUBLE))
      comment: "Average temperature setpoint in Celsius"
    - name: "avg_pressure_setpoint_pa"
      expr: AVG(CAST(pressure_setpoint_pa AS DOUBLE))
      comment: "Average pressure setpoint in Pascals"
    - name: "avg_gas_flow_rate_sccm"
      expr: AVG(CAST(gas_flow_rate_sccm AS DOUBLE))
      comment: "Average gas flow rate in standard cubic centimeters per minute"
    - name: "avg_throughput_pph"
      expr: AVG(CAST(throughput_pph AS DOUBLE))
      comment: "Average throughput in parts per hour"
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness percentage"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures in hours"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair in hours"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment downtime analysis metrics tracking duration, causes, and impact of tool unavailability"
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_downtime`"
  dimensions:
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime (planned, unplanned, emergency)"
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category classification of downtime"
    - name: "tool_downtime_category"
      expr: tool_downtime_category
      comment: "Detailed downtime category for the tool"
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Coded reason for the downtime"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the downtime"
    - name: "downtime_state"
      expr: downtime_state
      comment: "State of the equipment during downtime"
    - name: "sematech_state"
      expr: sematech_state
      comment: "SEMATECH standard equipment state classification"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the downtime event"
    - name: "impact_severity"
      expr: impact_severity
      comment: "Impact severity on production"
    - name: "shift"
      expr: shift
      comment: "Production shift when downtime occurred"
    - name: "downtime_month"
      expr: DATE_TRUNC('MONTH', downtime_start_timestamp)
      comment: "Month when downtime started"
    - name: "downtime_quarter"
      expr: CONCAT(YEAR(downtime_start_timestamp), '-Q', QUARTER(downtime_start_timestamp))
      comment: "Quarter when downtime started"
  measures:
    - name: "total_downtime_events"
      expr: COUNT(DISTINCT tool_downtime_id)
      comment: "Total number of downtime events"
    - name: "total_downtime_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total downtime duration in hours"
    - name: "avg_downtime_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average downtime duration per event in hours"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes"
    - name: "avg_downtime_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event in minutes"
    - name: "avg_oee_impact_percentage"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average impact on Overall Equipment Effectiveness as percentage"
    - name: "scheduled_downtime_events"
      expr: COUNT(DISTINCT CASE WHEN is_scheduled = TRUE THEN tool_downtime_id END)
      comment: "Number of scheduled downtime events"
    - name: "unscheduled_downtime_events"
      expr: COUNT(DISTINCT CASE WHEN is_scheduled = FALSE THEN tool_downtime_id END)
      comment: "Number of unscheduled downtime events"
    - name: "events_with_oee_impact"
      expr: COUNT(DISTINCT CASE WHEN oee_impact_percentage > 0 THEN tool_downtime_id END)
      comment: "Number of downtime events that impacted OEE"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool qualification status and cycle-time KPIs — tracks readiness of tools for production and identifies qualification bottlenecks."
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_qualification`"
  dimensions:
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (initial, requalification, process change) for program tracking."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (qualified, in-progress, failed, expired) for fleet readiness assessment."
    - name: "process_node"
      expr: process_node
      comment: "Process node for which the tool is being qualified; critical for technology node capacity planning."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the tool is on the critical path; prioritizes qualification resources for maximum fab impact."
    - name: "qualification_reason"
      expr: qualification_reason
      comment: "Reason for qualification (new install, PM, process change); used to understand qualification demand drivers."
    - name: "result"
      expr: result
      comment: "Qualification result (pass, fail, conditional); measures qualification program effectiveness."
    - name: "qualification_date"
      expr: DATE_TRUNC('month', qualification_date)
      comment: "Month of qualification completion for cycle-time trending."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total tool qualification records; baseline volume for qualification program workload management."
    - name: "qualified_tool_count"
      expr: COUNT(CASE WHEN qualification_status = 'QUALIFIED' THEN 1 END)
      comment: "Number of currently qualified tools; directly measures production-ready tool capacity."
    - name: "failed_qualification_count"
      expr: COUNT(CASE WHEN result = 'FAIL' THEN 1 END)
      comment: "Number of failed qualifications; identifies tools blocking production ramp and requiring engineering intervention."
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk across tool qualifications; measures process capability and readiness for volume production."
    - name: "avg_oee_impact"
      expr: AVG(CAST(oee_impact AS DOUBLE))
      comment: "Average OEE impact during qualification; quantifies the production cost of qualification activities."
    - name: "avg_result_metric_value"
      expr: AVG(CAST(result_metric_value AS DOUBLE))
      comment: "Average qualification result metric value; tracks whether tools are meeting qualification acceptance criteria."
    - name: "expired_qualifications"
      expr: COUNT(CASE WHEN requalification_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of tools with expired qualifications; compliance risk indicator requiring immediate requalification scheduling."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_warranty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty financial exposure per tool"
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_warranty`"
  dimensions:
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty (e.g., extended, standard)"
    - name: "warranty_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the warranty became effective"
  measures:
    - name: "total_warranty_cost"
      expr: SUM(CAST(warranty_cost AS DOUBLE))
      comment: "Total cost covered by warranties"
    - name: "warranty_count"
      expr: COUNT(1)
      comment: "Number of warranty records"
$$;
