-- Metric views for domain: automation | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_alarm_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for alarm events — tracks alarm frequency, nuisance alarm rate, and process deviation severity to support alarm rationalization and operator effectiveness programs."
  source: "`vibe_manufacturing_v1`.`automation`.`alarm_event`"
  dimensions:
    - name: "alarm_category"
      expr: alarm_category
      comment: "Category of the alarm (e.g. process, safety, equipment) for grouping alarm performance by type."
    - name: "alarm_priority"
      expr: alarm_priority
      comment: "Priority level of the alarm (e.g. critical, high, medium, low) used to assess alarm management compliance."
    - name: "alarm_severity"
      expr: alarm_severity
      comment: "Severity classification of the alarm event for risk-based analysis."
    - name: "alarm_state"
      expr: alarm_state
      comment: "Current state of the alarm (e.g. active, acknowledged, cleared) for operational monitoring."
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date the alarm event occurred, used for daily and trend analysis."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month the alarm event occurred, used for monthly alarm rate trending."
    - name: "is_nuisance"
      expr: is_nuisance
      comment: "Flag indicating whether the alarm is classified as a nuisance alarm, key for alarm rationalization KPIs."
  measures:
    - name: "total_alarm_events"
      expr: COUNT(1)
      comment: "Total number of alarm events fired. Baseline KPI for alarm frequency monitoring and ISA-18.2 compliance."
    - name: "nuisance_alarm_count"
      expr: COUNT(CASE WHEN is_nuisance = TRUE THEN 1 END)
      comment: "Count of alarms classified as nuisance. High nuisance rates indicate poor alarm rationalization and operator desensitization risk."
    - name: "nuisance_alarm_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_nuisance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alarm events that are nuisance alarms. ISA-18.2 target is below 5%; high rates drive rationalization projects."
    - name: "unacknowledged_alarm_count"
      expr: COUNT(CASE WHEN acknowledged_by IS NULL THEN 1 END)
      comment: "Count of alarm events with no acknowledgement recorded. Unacknowledged alarms represent operator response gaps and safety risk."
    - name: "avg_process_deviation"
      expr: AVG(CAST(process_value AS DOUBLE))
      comment: "Average process value at time of alarm, indicating typical magnitude of process deviations triggering alarms."
    - name: "avg_setpoint_at_alarm"
      expr: AVG(CAST(setpoint_value AS DOUBLE))
      comment: "Average setpoint value at time of alarm event, used to assess whether setpoints are appropriately configured relative to process behavior."
    - name: "distinct_devices_alarming"
      expr: COUNT(DISTINCT device_registry_id)
      comment: "Number of distinct devices that generated alarm events. High counts may indicate systemic equipment or configuration issues."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_alarm_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance KPIs for the alarm definition library — tracks rationalization completeness, lifecycle health, and setpoint configuration quality to support ISA-18.2 alarm management programs."
  source: "`vibe_manufacturing_v1`.`automation`.`alarm_definition`"
  dimensions:
    - name: "alarm_category"
      expr: alarm_category
      comment: "Category of the alarm definition for grouping rationalization status by alarm type."
    - name: "alarm_type"
      expr: alarm_type
      comment: "Type of alarm (e.g. process, equipment, safety) for classification analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the alarm definition (e.g. active, deprecated, under review)."
    - name: "rationalization_status"
      expr: rationalization_status
      comment: "ISA-18.2 rationalization status of the alarm definition — key dimension for alarm management compliance reporting."
    - name: "priority"
      expr: priority
      comment: "Configured priority of the alarm definition for priority distribution analysis."
    - name: "process_area"
      expr: process_area
      comment: "Process area the alarm definition belongs to, enabling area-level alarm density analysis."
  measures:
    - name: "total_alarm_definitions"
      expr: COUNT(1)
      comment: "Total number of alarm definitions in the library. Baseline for alarm density and rationalization coverage KPIs."
    - name: "rationalized_alarm_count"
      expr: COUNT(CASE WHEN rationalization_status = 'Rationalized' THEN 1 END)
      comment: "Count of alarm definitions that have completed ISA-18.2 rationalization. Drives compliance reporting."
    - name: "rationalization_completion_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rationalization_status = 'Rationalized' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alarm definitions that are fully rationalized. ISA-18.2 programs target 100%; gaps indicate rationalization backlog."
    - name: "auto_reset_alarm_count"
      expr: COUNT(CASE WHEN auto_reset = TRUE THEN 1 END)
      comment: "Count of alarms configured for automatic reset. High auto-reset rates may mask recurring process issues."
    - name: "shelving_allowed_count"
      expr: COUNT(CASE WHEN shelving_allowed = TRUE THEN 1 END)
      comment: "Count of alarm definitions where shelving is permitted. Excessive shelving allowance can suppress safety-critical alarms."
    - name: "avg_setpoint_value"
      expr: AVG(CAST(setpoint_value AS DOUBLE))
      comment: "Average configured setpoint value across alarm definitions, used for setpoint benchmarking and outlier detection."
    - name: "avg_deadband"
      expr: AVG(CAST(deadband AS DOUBLE))
      comment: "Average deadband configured across alarm definitions. Insufficient deadband causes chattering alarms; this KPI supports tuning programs."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_batch_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing batch performance KPIs — tracks yield, OEE, energy consumption, scrap, and quality outcomes to drive continuous improvement in batch manufacturing operations."
  source: "`vibe_manufacturing_v1`.`automation`.`batch_execution`"
  dimensions:
    - name: "batch_type"
      expr: batch_type
      comment: "Type of batch (e.g. production, trial, rework) for segmenting performance by batch category."
    - name: "batch_execution_status"
      expr: batch_execution_status
      comment: "Execution status of the batch (e.g. completed, aborted, in-progress) for filtering completed vs. failed batches."
    - name: "batch_disposition"
      expr: batch_disposition
      comment: "Final disposition of the batch (e.g. released, rejected, quarantined) for quality outcome analysis."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality status of the batch for pass/fail rate analysis."
    - name: "plant_area"
      expr: plant_area
      comment: "Plant area where the batch was executed, enabling area-level performance benchmarking."
    - name: "start_month"
      expr: DATE_TRUNC('month', start_timestamp)
      comment: "Month the batch started, used for monthly trend analysis of yield and OEE."
    - name: "quality_check_passed"
      expr: quality_check_passed
      comment: "Boolean flag indicating whether the batch passed quality checks, used for first-pass yield analysis."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of batch executions. Baseline throughput KPI for production capacity analysis."
    - name: "avg_batch_yield_pct"
      expr: AVG(CAST(batch_yield_percentage AS DOUBLE))
      comment: "Average batch yield percentage across all executions. Core manufacturing efficiency KPI — low yield drives waste reduction initiatives."
    - name: "total_actual_yield"
      expr: SUM(CAST(actual_yield_quantity AS DOUBLE))
      comment: "Total actual yield quantity produced across all batches. Measures production output volume."
    - name: "total_target_yield"
      expr: SUM(CAST(target_yield_quantity AS DOUBLE))
      comment: "Total target yield quantity planned across all batches. Used with actual yield to compute attainment rate."
    - name: "yield_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_yield_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_yield_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of target yield actually achieved. Key production attainment KPI — below 95% triggers root cause investigation."
    - name: "avg_oee"
      expr: AVG(CAST(overall_equipment_effectiveness AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE) across batch executions. World-class OEE is 85%+; this KPI drives asset utilization programs."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(batch_scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity generated across all batches. Direct cost driver — high scrap triggers process improvement and material waste reduction programs."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(batch_energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumed across all batch executions in kWh. Key sustainability and cost KPI for energy efficiency programs."
    - name: "avg_energy_per_batch_kwh"
      expr: AVG(CAST(batch_energy_consumption_kwh AS DOUBLE))
      comment: "Average energy consumption per batch in kWh. Enables energy intensity benchmarking across recipes and production lines."
    - name: "total_co2_emissions_kg"
      expr: SUM(CAST(batch_co2_emissions_kg AS DOUBLE))
      comment: "Total CO2 emissions from batch operations in kg. ESG reporting KPI — drives decarbonization target tracking."
    - name: "total_water_usage_liters"
      expr: SUM(CAST(batch_water_usage_liters AS DOUBLE))
      comment: "Total water consumed across batch executions in liters. Sustainability KPI for water stewardship programs."
    - name: "avg_batch_cycle_time_seconds"
      expr: AVG(CAST(batch_cycle_time_seconds AS DOUBLE))
      comment: "Average batch cycle time in seconds. Throughput efficiency KPI — reduction drives capacity improvement without capital investment."
    - name: "first_pass_quality_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_check_passed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches passing quality checks on first attempt. Core quality KPI — below target triggers process control review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Automation project portfolio KPIs — tracks budget performance, schedule adherence, and delivery health across automation capital and improvement projects."
  source: "`vibe_manufacturing_v1`.`automation`.`automation_project`"
  dimensions:
    - name: "automation_project_type"
      expr: automation_project_type
      comment: "Type of automation project (e.g. greenfield, upgrade, cybersecurity) for portfolio segmentation."
    - name: "automation_project_status"
      expr: automation_project_status
      comment: "Current status of the project (e.g. active, completed, on-hold) for portfolio health monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the automation project for regulatory and audit reporting."
    - name: "priority"
      expr: priority
      comment: "Project priority level for resource allocation and portfolio prioritization analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the project for risk-adjusted portfolio management."
    - name: "safety_integrity_level"
      expr: safety_integrity_level
      comment: "Safety Integrity Level (SIL) classification of the project for safety-critical project tracking."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the project is classified as critical, for prioritized executive oversight."
    - name: "is_cybersecurity_hardening"
      expr: is_cybersecurity_hardening
      comment: "Flag indicating whether the project is a cybersecurity hardening initiative, for OT security investment tracking."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month the project was planned to start, for pipeline and intake analysis."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of automation projects in the portfolio. Baseline for portfolio size and workload capacity analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted spend across all automation projects. Capital allocation KPI for investment planning."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend across all automation projects. Tracks capital consumption against budget."
    - name: "budget_variance"
      expr: SUM((CAST(actual_spend_amount AS DOUBLE)) - (CAST(budget_amount AS DOUBLE)))
      comment: "Total budget variance (actual minus budget) across all projects. Negative = under budget; positive = over budget. Key financial control KPI."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total budget consumed. Below 80% may indicate project delays; above 100% indicates cost overruns requiring executive action."
    - name: "critical_project_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of projects classified as critical. Drives executive prioritization and resource allocation decisions."
    - name: "cybersecurity_project_count"
      expr: COUNT(CASE WHEN is_cybersecurity_hardening = TRUE THEN 1 END)
      comment: "Number of cybersecurity hardening projects in the portfolio. Tracks OT security investment program progress."
    - name: "avg_actual_duration_days"
      expr: AVG(CAST(actual_duration_days AS DOUBLE))
      comment: "Average actual project duration in days. Benchmarks delivery speed and identifies schedule performance trends."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change management KPIs for automation systems — tracks change velocity, emergency change rate, approval cycle times, and post-change validation outcomes to govern OT change risk."
  source: "`vibe_manufacturing_v1`.`automation`.`automation_change_request`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of change request (e.g. software, hardware, configuration) for change category analysis."
    - name: "change_priority"
      expr: change_priority
      comment: "Priority of the change request for workload and risk prioritization."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the change request for change board pipeline monitoring."
    - name: "automation_change_request_status"
      expr: automation_change_request_status
      comment: "Overall status of the change request lifecycle for pipeline health monitoring."
    - name: "post_change_validation_status"
      expr: post_change_validation_status
      comment: "Outcome of post-change validation testing — critical for assessing change quality and rollback risk."
    - name: "is_emergency_change"
      expr: is_emergency_change
      comment: "Flag indicating whether the change was classified as an emergency change, for emergency change rate KPIs."
    - name: "change_origin"
      expr: change_origin
      comment: "Origin of the change request (e.g. planned, incident-driven, regulatory) for root cause analysis."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month the change request was submitted, for change velocity trending."
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total number of automation change requests. Baseline for change velocity and change management capacity analysis."
    - name: "emergency_change_count"
      expr: COUNT(CASE WHEN is_emergency_change = TRUE THEN 1 END)
      comment: "Count of emergency change requests. High emergency change rates indicate reactive change management and elevated OT risk."
    - name: "emergency_change_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency_change = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change requests classified as emergency. ITIL best practice targets below 10%; high rates trigger process improvement."
    - name: "post_change_validation_pass_count"
      expr: COUNT(CASE WHEN post_change_validation_status = 'Passed' THEN 1 END)
      comment: "Count of changes that passed post-implementation validation. Measures change quality and implementation effectiveness."
    - name: "post_change_validation_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN post_change_validation_status = 'Passed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changes passing post-implementation validation. Below 95% indicates systemic change quality issues requiring process review."
    - name: "approved_change_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of change requests that received approval. Used to track change board throughput and approval pipeline health."
    - name: "distinct_control_systems_changed"
      expr: COUNT(DISTINCT control_system_id)
      comment: "Number of distinct control systems affected by change requests. High counts indicate broad change scope and elevated operational risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_device_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OT device fleet health and lifecycle KPIs — tracks device population, warranty coverage, maintenance status, and power/electrical ratings to support asset lifecycle and reliability programs."
  source: "`vibe_manufacturing_v1`.`automation`.`device_registry`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Type of device (e.g. PLC, sensor, actuator, HMI) for fleet segmentation and type-specific analysis."
    - name: "device_registry_status"
      expr: device_registry_status
      comment: "Operational status of the device for active vs. decommissioned fleet analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the device (e.g. active, end-of-life, obsolete) for replacement planning."
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Current maintenance status of the device for maintenance backlog and compliance monitoring."
    - name: "communication_protocol"
      expr: communication_protocol
      comment: "Communication protocol used by the device (e.g. Modbus, PROFINET, EtherNet/IP) for protocol standardization analysis."
    - name: "commissioning_year"
      expr: DATE_TRUNC('year', commissioning_date)
      comment: "Year the device was commissioned, for fleet age distribution and replacement wave planning."
  measures:
    - name: "total_devices"
      expr: COUNT(1)
      comment: "Total number of registered OT devices. Baseline fleet size KPI for asset management and cybersecurity scope."
    - name: "active_device_count"
      expr: COUNT(CASE WHEN device_registry_status = 'Active' THEN 1 END)
      comment: "Count of currently active devices. Tracks operational fleet size for capacity and coverage planning."
    - name: "end_of_life_device_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'End-of-Life' THEN 1 END)
      comment: "Count of devices at end-of-life. High counts indicate replacement backlog and elevated cybersecurity/reliability risk."
    - name: "warranty_expired_device_count"
      expr: COUNT(CASE WHEN warranty_expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of devices with expired warranties. Drives maintenance cost exposure analysis and extended support contract decisions."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating in kW across the device fleet. Used for energy load planning and electrical infrastructure sizing."
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total installed power rating in kW across all registered devices. Baseline for electrical infrastructure capacity planning."
    - name: "avg_operating_temperature_c"
      expr: AVG(CAST(operating_temperature_c AS DOUBLE))
      comment: "Average operating temperature rating across devices. Used for environmental compliance and thermal management planning."
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct device suppliers in the fleet. High supplier count increases supply chain complexity and spare parts management cost."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_control_system`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Control system reliability and lifecycle KPIs — tracks MTBF, MTTR, uptime, and fleet health to support OT reliability engineering and cybersecurity governance programs."
  source: "`vibe_manufacturing_v1`.`automation`.`control_system`"
  dimensions:
    - name: "system_type"
      expr: system_type
      comment: "Type of control system (e.g. DCS, PLC, SCADA, SIS) for system-class performance benchmarking."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the control system for fleet health monitoring."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the control system for replacement and upgrade planning."
    - name: "safety_integrity_level"
      expr: safety_integrity_level
      comment: "SIL classification of the control system for safety-critical system tracking and IEC 61511 compliance."
    - name: "security_classification"
      expr: security_classification
      comment: "Security classification of the control system for cybersecurity risk segmentation."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the control system is classified as critical for prioritized maintenance and monitoring."
    - name: "commissioning_year"
      expr: DATE_TRUNC('year', commissioning_date)
      comment: "Year the control system was commissioned, for fleet age and obsolescence analysis."
  measures:
    - name: "total_control_systems"
      expr: COUNT(1)
      comment: "Total number of control systems in the fleet. Baseline for OT asset inventory and cybersecurity scope."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures in hours across control systems. Core reliability KPI — low MTBF drives maintenance strategy review."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair in hours across control systems. Measures maintenance responsiveness — high MTTR indicates spare parts or skills gaps."
    - name: "total_uptime_hours"
      expr: SUM(CAST(uptime_hours AS DOUBLE))
      comment: "Total accumulated uptime hours across all control systems. Measures fleet operational availability."
    - name: "avg_uptime_hours"
      expr: AVG(CAST(uptime_hours AS DOUBLE))
      comment: "Average uptime hours per control system. Benchmarks individual system availability against fleet average."
    - name: "critical_system_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of control systems classified as critical. Drives prioritized maintenance, cybersecurity, and redundancy investment decisions."
    - name: "reliability_ratio"
      expr: ROUND(AVG(CAST(mtbf_hours AS DOUBLE)) / NULLIF(AVG(CAST(mttr_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of average MTBF to average MTTR. Higher values indicate better reliability posture; used for fleet-level reliability benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_proof_test_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety instrumented system (SIS) proof test KPIs — tracks test pass rates, overdue tests, and test quality to ensure IEC 61511 compliance and safety function integrity."
  source: "`vibe_manufacturing_v1`.`automation`.`proof_test_record`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of proof test (e.g. full, partial, functional) for test coverage analysis."
    - name: "test_result"
      expr: test_result
      comment: "Outcome of the proof test (e.g. pass, fail, conditional pass) for safety compliance reporting."
    - name: "proof_test_record_status"
      expr: proof_test_record_status
      comment: "Administrative status of the proof test record for record completeness monitoring."
    - name: "safety_integrity_level"
      expr: safety_integrity_level
      comment: "SIL level of the safety function being tested, for SIL-stratified compliance analysis."
    - name: "test_environment"
      expr: test_environment
      comment: "Environment in which the test was conducted (e.g. live plant, test bench) for test validity analysis."
    - name: "test_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month the proof test was conducted, for test frequency and compliance trend analysis."
    - name: "test_is_critical"
      expr: test_is_critical
      comment: "Flag indicating whether the test covers a critical safety function, for prioritized compliance monitoring."
  measures:
    - name: "total_proof_tests"
      expr: COUNT(1)
      comment: "Total number of proof tests conducted. Baseline for SIS test program activity and IEC 61511 compliance coverage."
    - name: "proof_test_pass_count"
      expr: COUNT(CASE WHEN test_result = 'Pass' THEN 1 END)
      comment: "Count of proof tests with a passing result. Measures safety function integrity across the SIS fleet."
    - name: "proof_test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proof tests passing. Below 95% indicates systemic safety function degradation requiring urgent investigation."
    - name: "overdue_proof_test_count"
      expr: COUNT(CASE WHEN next_test_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of safety functions with overdue proof tests. Directly indicates IEC 61511 compliance gaps and regulatory exposure."
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average ambient temperature during proof tests. Used to assess whether environmental conditions may affect test validity."
    - name: "avg_test_pressure_bar"
      expr: AVG(CAST(test_pressure_bar AS DOUBLE))
      comment: "Average process pressure during proof tests. Validates that tests were conducted under representative operating conditions."
    - name: "distinct_safety_functions_tested"
      expr: COUNT(DISTINCT safety_function_id)
      comment: "Number of distinct safety functions covered by proof tests. Measures breadth of SIS test program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_firmware_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OT firmware update program KPIs — tracks update success rates, critical patch coverage, and rollback frequency to govern cybersecurity patching compliance across the device fleet."
  source: "`vibe_manufacturing_v1`.`automation`.`firmware_update`"
  dimensions:
    - name: "update_status"
      expr: update_status
      comment: "Status of the firmware update (e.g. completed, failed, rolled back) for update program health monitoring."
    - name: "update_method"
      expr: update_method
      comment: "Method used to deploy the firmware update (e.g. remote, manual, OTA) for deployment strategy analysis."
    - name: "post_update_validation_status"
      expr: post_update_validation_status
      comment: "Outcome of post-update validation for update quality and device stability assessment."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the firmware update record for pipeline and backlog management."
    - name: "is_critical_update"
      expr: is_critical_update
      comment: "Flag indicating whether the update addresses a critical vulnerability, for security patch compliance tracking."
    - name: "device_type"
      expr: device_type
      comment: "Type of device receiving the firmware update, for device-class patching coverage analysis."
    - name: "update_month"
      expr: DATE_TRUNC('month', scheduled_timestamp)
      comment: "Month the firmware update was scheduled, for patch cadence and compliance window analysis."
  measures:
    - name: "total_firmware_updates"
      expr: COUNT(1)
      comment: "Total number of firmware update records. Baseline for patch program activity and device coverage analysis."
    - name: "successful_update_count"
      expr: COUNT(CASE WHEN update_status = 'Completed' THEN 1 END)
      comment: "Count of firmware updates that completed successfully. Measures patch deployment effectiveness."
    - name: "update_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN update_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of firmware updates completing successfully. Below 90% indicates deployment process issues requiring investigation."
    - name: "rollback_count"
      expr: COUNT(CASE WHEN rollback_reason IS NOT NULL THEN 1 END)
      comment: "Count of firmware updates that required rollback. High rollback rates indicate poor pre-deployment testing or incompatible firmware."
    - name: "rollback_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rollback_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of firmware updates requiring rollback. Directly measures update quality and deployment risk."
    - name: "critical_update_count"
      expr: COUNT(CASE WHEN is_critical_update = TRUE THEN 1 END)
      comment: "Count of critical security firmware updates. Tracks cybersecurity patch program urgency and compliance."
    - name: "avg_update_size_mb"
      expr: AVG(CAST(update_size_mb AS DOUBLE))
      comment: "Average firmware update package size in MB. Used for network bandwidth planning and update window sizing."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_scada_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SCADA operator activity and security KPIs — tracks session frequency, control action volumes, and setpoint change activity to support operator performance monitoring and OT cybersecurity audit programs."
  source: "`vibe_manufacturing_v1`.`automation`.`scada_session`"
  dimensions:
    - name: "session_type"
      expr: session_type
      comment: "Type of SCADA session (e.g. operator, engineer, remote) for access pattern analysis."
    - name: "session_status"
      expr: session_status
      comment: "Status of the SCADA session (e.g. active, terminated, expired) for session lifecycle monitoring."
    - name: "user_role"
      expr: user_role
      comment: "Role of the user during the session (e.g. operator, supervisor, engineer) for role-based access analysis."
    - name: "login_method"
      expr: login_method
      comment: "Authentication method used (e.g. password, smart card, MFA) for security compliance monitoring."
    - name: "plant_area"
      expr: plant_area
      comment: "Plant area accessed during the session for area-level activity monitoring."
    - name: "session_source"
      expr: session_source
      comment: "Source of the session (e.g. local workstation, remote VPN) for remote access security analysis."
    - name: "login_month"
      expr: DATE_TRUNC('month', login_timestamp)
      comment: "Month of session login for activity trend analysis."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of SCADA sessions. Baseline for operator activity volume and access audit coverage."
    - name: "distinct_operators"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct operators with SCADA sessions. Measures active user base and access scope for security governance."
    - name: "total_alarm_acks"
      expr: SUM(CAST(alarm_ack_count AS BIGINT))
      comment: "Total alarm acknowledgements across all sessions. Measures operator alarm response workload and engagement."
    - name: "total_setpoint_changes"
      expr: SUM(CAST(setpoint_change_count AS BIGINT))
      comment: "Total setpoint changes made across all SCADA sessions. High volumes may indicate process instability or unauthorized adjustments."
    - name: "total_control_actions"
      expr: SUM(CAST(control_action_count AS BIGINT))
      comment: "Total control actions executed across all sessions. Measures operator intervention frequency and process automation effectiveness."
    - name: "avg_setpoint_changes_per_session"
      expr: ROUND(AVG(CAST(setpoint_change_count AS DOUBLE)), 2)
      comment: "Average number of setpoint changes per SCADA session. Benchmarks operator intervention intensity and process stability."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_setpoint_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process control setpoint change KPIs — tracks change frequency, approval compliance, and deviation from normal limits to support process stability and change governance programs."
  source: "`vibe_manufacturing_v1`.`automation`.`setpoint_change`"
  dimensions:
    - name: "change_status"
      expr: change_status
      comment: "Status of the setpoint change (e.g. pending, approved, applied) for change pipeline monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the setpoint change for change governance compliance analysis."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for the setpoint change for root cause and change driver analysis."
    - name: "initiated_by_type"
      expr: initiated_by_type
      comment: "Type of initiator (e.g. operator, automated system, recipe) for human vs. automated change analysis."
    - name: "within_normal_limits"
      expr: within_normal_limits
      comment: "Flag indicating whether the new setpoint is within normal operating limits, for out-of-limit change monitoring."
    - name: "is_approved"
      expr: is_approved
      comment: "Flag indicating whether the setpoint change was formally approved, for change governance compliance."
    - name: "change_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month the setpoint change occurred, for change frequency trend analysis."
  measures:
    - name: "total_setpoint_changes"
      expr: COUNT(1)
      comment: "Total number of setpoint changes. Baseline for process control intervention frequency and stability analysis."
    - name: "unapproved_change_count"
      expr: COUNT(CASE WHEN is_approved = FALSE THEN 1 END)
      comment: "Count of setpoint changes made without formal approval. Directly indicates change governance compliance gaps and audit risk."
    - name: "unapproved_change_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_approved = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of setpoint changes lacking formal approval. High rates indicate change control process breakdown requiring corrective action."
    - name: "out_of_limit_change_count"
      expr: COUNT(CASE WHEN within_normal_limits = FALSE THEN 1 END)
      comment: "Count of setpoint changes that moved the setpoint outside normal operating limits. Indicates process boundary violations requiring investigation."
    - name: "out_of_limit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN within_normal_limits = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of setpoint changes resulting in out-of-limit conditions. High rates indicate process instability or inadequate limit configuration."
    - name: "avg_setpoint_delta"
      expr: AVG(ABS(new_setpoint_value - previous_setpoint_value))
      comment: "Average absolute magnitude of setpoint changes. Large average deltas indicate aggressive process adjustments that may destabilize operations."
    - name: "distinct_parameters_changed"
      expr: COUNT(DISTINCT process_parameter_id)
      comment: "Number of distinct process parameters that received setpoint changes. Measures breadth of process control intervention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe management KPIs — tracks recipe library health, yield targets, and process time standards to support recipe governance and continuous improvement in batch manufacturing."
  source: "`vibe_manufacturing_v1`.`automation`.`recipe`"
  dimensions:
    - name: "recipe_type"
      expr: recipe_type
      comment: "Type of recipe (e.g. master, control, site) for recipe hierarchy and governance analysis."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the recipe (e.g. approved, draft, obsolete) for recipe lifecycle governance."
    - name: "safety_integrity_level"
      expr: safety_integrity_level
      comment: "SIL classification of the recipe for safety-critical recipe tracking."
    - name: "equipment_class"
      expr: equipment_class
      comment: "Equipment class the recipe is designed for, enabling equipment-recipe compatibility analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the recipe became effective, for recipe introduction trend analysis."
  measures:
    - name: "total_recipes"
      expr: COUNT(1)
      comment: "Total number of recipes in the library. Baseline for recipe portfolio size and governance coverage."
    - name: "approved_recipe_count"
      expr: COUNT(CASE WHEN release_status = 'Approved' THEN 1 END)
      comment: "Count of approved and released recipes. Measures recipe library readiness for production deployment."
    - name: "avg_max_yield"
      expr: AVG(CAST(max_yield AS DOUBLE))
      comment: "Average maximum yield across recipes. Benchmarks recipe yield potential for production planning and capacity analysis."
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE target configured in recipes. Measures the ambition level of production efficiency targets embedded in process design."
    - name: "avg_total_process_time"
      expr: AVG(CAST(total_process_time AS DOUBLE))
      comment: "Average total process time across recipes. Used for production scheduling, capacity planning, and cycle time benchmarking."
    - name: "avg_batch_size"
      expr: AVG(CAST(batch_size AS DOUBLE))
      comment: "Average batch size across recipes. Informs production lot sizing strategy and material planning."
    - name: "avg_yield_tolerance"
      expr: AVG(CAST(yield_tolerance AS DOUBLE))
      comment: "Average yield tolerance configured in recipes. Tight tolerances indicate high-precision processes; wide tolerances may indicate quality risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_fat_sat_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Factory and Site Acceptance Test (FAT/SAT) KPIs — tracks test pass rates, retest frequency, and corrective action requirements to govern automation system commissioning quality."
  source: "`vibe_manufacturing_v1`.`automation`.`fat_sat_record`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of acceptance test (FAT vs. SAT) for commissioning phase analysis."
    - name: "test_result"
      expr: test_result
      comment: "Outcome of the acceptance test (e.g. pass, fail, conditional) for commissioning quality reporting."
    - name: "fat_sat_record_status"
      expr: fat_sat_record_status
      comment: "Administrative status of the FAT/SAT record for record completeness and closure monitoring."
    - name: "retest_required"
      expr: retest_required
      comment: "Flag indicating whether a retest was required, for first-time pass rate analysis."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action was required following the test, for quality defect tracking."
    - name: "test_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month the acceptance test was conducted, for commissioning activity trend analysis."
  measures:
    - name: "total_fat_sat_records"
      expr: COUNT(1)
      comment: "Total number of FAT/SAT test records. Baseline for commissioning test program activity."
    - name: "test_pass_count"
      expr: COUNT(CASE WHEN test_result = 'Pass' THEN 1 END)
      comment: "Count of acceptance tests with a passing result. Measures commissioning quality and system readiness."
    - name: "first_time_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'Pass' AND retest_required = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acceptance tests passing on first attempt without retest. Core commissioning quality KPI — below 90% indicates design or build quality issues."
    - name: "retest_count"
      expr: COUNT(CASE WHEN retest_required = TRUE THEN 1 END)
      comment: "Count of tests requiring retest. High retest counts indicate commissioning quality issues and schedule risk."
    - name: "corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of tests requiring corrective action. Measures defect density in commissioned automation systems."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acceptance tests requiring corrective action. High rates indicate systemic design or build quality issues in automation projects."
    - name: "distinct_projects_tested"
      expr: COUNT(DISTINCT automation_project_id)
      comment: "Number of distinct automation projects with FAT/SAT records. Measures commissioning program breadth and project delivery pipeline."
$$;