-- Metric views for domain: automation | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_alarm_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for alarm events — tracks alarm frequency, acknowledgement performance, nuisance alarm rate, and average alarm duration to drive alarm rationalization and operator response improvement."
  source: "`vibe_manufacturing_v1`.`automation`.`alarm_event`"
  dimensions:
    - name: "alarm_priority"
      expr: alarm_priority
      comment: "Priority level of the alarm (e.g. High, Medium, Low) — used to segment alarm KPIs by criticality."
    - name: "alarm_category"
      expr: alarm_category
      comment: "Functional category of the alarm (e.g. Process, Equipment, Safety) — enables category-level alarm performance analysis."
    - name: "alarm_severity"
      expr: alarm_severity
      comment: "Severity classification of the alarm event — supports risk-based alarm management reporting."
    - name: "alarm_state"
      expr: alarm_state
      comment: "Current state of the alarm (e.g. Active, Cleared, Shelved) — used to filter live vs. historical alarm analysis."
    - name: "event_status"
      expr: event_status
      comment: "Processing status of the alarm event record — supports workflow and closure tracking."
    - name: "is_nuisance"
      expr: is_nuisance
      comment: "Flag indicating whether the alarm is classified as a nuisance alarm — key input for alarm rationalization programs."
    - name: "acknowledged_flag"
      expr: acknowledged_flag
      comment: "Whether the alarm was acknowledged by an operator — used to measure operator response compliance."
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Calendar day of the alarm event — enables daily trend analysis of alarm rates."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Calendar month of the alarm event — supports monthly alarm performance reporting."
  measures:
    - name: "total_alarm_events"
      expr: COUNT(1)
      comment: "Total number of alarm events — baseline KPI for alarm frequency monitoring and ISA-18.2 compliance reporting."
    - name: "nuisance_alarm_count"
      expr: COUNT(CASE WHEN is_nuisance = TRUE THEN 1 END)
      comment: "Count of alarms classified as nuisance — high nuisance rates indicate poor alarm rationalization and operator desensitization risk."
    - name: "nuisance_alarm_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_nuisance = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alarm events classified as nuisance — ISA-18.2 target is below 5%; drives alarm rationalization investment decisions."
    - name: "unacknowledged_alarm_count"
      expr: COUNT(CASE WHEN acknowledged_flag = FALSE THEN 1 END)
      comment: "Count of alarms that were not acknowledged — unacknowledged alarms represent operator response failures and safety risk."
    - name: "acknowledgement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledged_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alarms that were acknowledged — measures operator response discipline; low rates trigger safety and compliance review."
    - name: "avg_alarm_duration_seconds"
      expr: AVG(CAST(alarm_duration_seconds AS DOUBLE))
      comment: "Average duration of alarm events in seconds — prolonged alarms indicate unresolved process issues or inadequate operator response."
    - name: "total_alarm_duration_seconds"
      expr: SUM(CAST(alarm_duration_seconds AS DOUBLE))
      comment: "Total cumulative alarm duration in seconds — measures overall alarm burden on operators; high values indicate systemic process instability."
    - name: "avg_shelve_duration_seconds"
      expr: AVG(CAST(shelve_duration_seconds AS DOUBLE))
      comment: "Average duration alarms were shelved — excessive shelving may indicate operators bypassing safety alerts; triggers management review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_alarm_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alarm rationalization and lifecycle KPIs — tracks the health of the alarm library, rationalization progress, and compliance coverage to support ISA-18.2 alarm management programs."
  source: "`vibe_manufacturing_v1`.`automation`.`alarm_definition`"
  dimensions:
    - name: "alarm_priority"
      expr: alarm_priority
      comment: "Priority level assigned to the alarm definition — used to analyze alarm library composition by priority tier."
    - name: "alarm_category"
      expr: alarm_category
      comment: "Functional category of the alarm definition — supports category-level rationalization tracking."
    - name: "alarm_type"
      expr: alarm_type
      comment: "Type of alarm (e.g. Process, Equipment, Safety) — used to segment the alarm library for targeted rationalization."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle state of the alarm definition (e.g. Active, Deprecated, Under Review) — tracks alarm library currency."
    - name: "rationalization_status_band"
      expr: CASE WHEN rationalization_status >= 1 THEN 'Rationalized' ELSE 'Not Rationalized' END
      comment: "Derived band indicating whether the alarm has been rationalized — key metric for ISA-18.2 compliance programs."
    - name: "enabled_flag"
      expr: enabled_flag
      comment: "Whether the alarm definition is currently enabled — used to distinguish active from suppressed alarms in the library."
    - name: "process_area"
      expr: process_area
      comment: "Plant process area associated with the alarm — enables area-level alarm density and rationalization analysis."
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Regulatory or industry standard the alarm supports (e.g. ISA-18.2, IEC 62682) — used for compliance coverage reporting."
  measures:
    - name: "total_alarm_definitions"
      expr: COUNT(1)
      comment: "Total number of alarm definitions in the library — baseline for alarm density analysis (alarms per tag, per area)."
    - name: "enabled_alarm_count"
      expr: COUNT(CASE WHEN enabled_flag = TRUE THEN 1 END)
      comment: "Count of currently enabled alarm definitions — measures active alarm library size for operator workload assessment."
    - name: "rationalized_alarm_count"
      expr: COUNT(CASE WHEN rationalization_status >= 1 THEN 1 END)
      comment: "Count of alarms that have been rationalized — measures progress of the alarm rationalization program."
    - name: "rationalization_completion_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rationalization_status >= 1 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alarm definitions that have been rationalized — executive KPI for ISA-18.2 compliance program completion."
    - name: "avg_setpoint_value"
      expr: AVG(CAST(setpoint_value AS DOUBLE))
      comment: "Average setpoint value across alarm definitions — used to validate alarm setpoint consistency within process areas."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average threshold value across alarm definitions — supports process engineering review of alarm trigger levels."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_batch_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch manufacturing performance KPIs — tracks yield, OEE, energy consumption, scrap, and quality outcomes to drive continuous improvement in batch process operations."
  source: "`vibe_manufacturing_v1`.`automation`.`batch_execution`"
  dimensions:
    - name: "batch_execution_status"
      expr: batch_execution_status
      comment: "Current status of the batch execution (e.g. Running, Completed, Aborted) — used to filter performance analysis to completed batches."
    - name: "batch_disposition"
      expr: batch_disposition
      comment: "Final disposition of the batch (e.g. Released, Rejected, Rework) — key quality outcome dimension for batch performance analysis."
    - name: "batch_type"
      expr: batch_type
      comment: "Type of batch (e.g. Production, Validation, Trial) — used to segment performance KPIs by batch purpose."
    - name: "batch_priority"
      expr: batch_priority
      comment: "Priority level of the batch — used to analyze whether high-priority batches achieve better performance outcomes."
    - name: "quality_check_passed"
      expr: quality_check_passed
      comment: "Whether the batch passed quality checks — primary quality outcome dimension for batch yield analysis."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality status of the batch (e.g. Passed, Failed, Pending) — supports quality-driven batch performance segmentation."
    - name: "plant_area"
      expr: plant_area
      comment: "Plant area where the batch was executed — enables area-level performance benchmarking."
    - name: "batch_start_month"
      expr: DATE_TRUNC('month', start_timestamp)
      comment: "Month the batch started — supports monthly trend analysis of batch performance KPIs."
    - name: "maintenance_flag"
      expr: maintenance_flag
      comment: "Whether the batch was impacted by a maintenance event — used to isolate maintenance-driven performance degradation."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of batch executions — baseline volume metric for batch throughput analysis."
    - name: "avg_batch_yield_pct"
      expr: AVG(CAST(batch_yield_percentage AS DOUBLE))
      comment: "Average batch yield percentage — primary efficiency KPI for batch manufacturing; low yield drives recipe and process improvement actions."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity produced across all batches — measures production output volume for capacity and demand planning."
    - name: "total_target_yield_quantity"
      expr: SUM(CAST(target_yield_quantity AS DOUBLE))
      comment: "Total target yield quantity across all batches — baseline for yield gap analysis against actual production."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(batch_scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across all batches — measures material waste; high scrap drives cost reduction and process improvement programs."
    - name: "avg_oee"
      expr: AVG(CAST(overall_equipment_effectiveness AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE) across batch executions — the primary manufacturing efficiency KPI used in executive steering reviews."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(batch_energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumed across all batches in kWh — drives energy cost management and sustainability reporting."
    - name: "avg_energy_per_batch_kwh"
      expr: AVG(CAST(batch_energy_consumption_kwh AS DOUBLE))
      comment: "Average energy consumption per batch in kWh — used to benchmark energy efficiency across recipes and production lines."
    - name: "total_co2_emissions_kg"
      expr: SUM(CAST(batch_co2_emissions_kg AS DOUBLE))
      comment: "Total CO2 emissions from batch operations in kg — supports environmental sustainability reporting and emissions reduction targets."
    - name: "avg_batch_cycle_time_seconds"
      expr: AVG(CAST(batch_cycle_time_seconds AS DOUBLE))
      comment: "Average batch cycle time in seconds — measures process speed; deviations from target drive recipe optimization and scheduling decisions."
    - name: "quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_check_passed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches passing quality checks — executive quality KPI; low rates trigger quality investigation and corrective action."
    - name: "total_water_usage_liters"
      expr: SUM(CAST(batch_water_usage_liters AS DOUBLE))
      comment: "Total water consumed across all batches in liters — supports water stewardship and environmental compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_device_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Automation device fleet KPIs — tracks device lifecycle status, power consumption, and fleet composition to support asset management, cybersecurity, and maintenance planning decisions."
  source: "`vibe_manufacturing_v1`.`automation`.`device_registry`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Type of automation device (e.g. PLC, Sensor, Actuator, HMI) — primary segmentation dimension for fleet analysis."
    - name: "device_registry_status"
      expr: device_registry_status
      comment: "Current operational status of the device — used to identify active, decommissioned, or maintenance-required devices."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle phase of the device (e.g. Active, End-of-Life, Obsolete) — drives replacement planning and capital investment decisions."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Device manufacturer — used to analyze fleet composition by vendor for supplier risk and standardization decisions."
    - name: "communication_protocol"
      expr: communication_protocol
      comment: "Communication protocol used by the device (e.g. Modbus, PROFINET, OPC-UA) — supports network architecture and interoperability analysis."
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Current maintenance status of the device — used to identify devices requiring immediate maintenance attention."
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the device was commissioned — used to analyze fleet age distribution and plan lifecycle replacements."
  measures:
    - name: "total_devices"
      expr: COUNT(1)
      comment: "Total number of registered automation devices — baseline fleet size metric for capacity and maintenance planning."
    - name: "active_device_count"
      expr: COUNT(CASE WHEN device_registry_status = 'Active' THEN 1 END)
      comment: "Count of currently active devices — measures operational fleet size; declining active count signals decommissioning or failure trends."
    - name: "end_of_life_device_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'End-of-Life' THEN 1 END)
      comment: "Count of devices at end-of-life — drives capital replacement planning and cybersecurity risk mitigation investment."
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total installed power rating of the device fleet in kW — used for energy capacity planning and electrical infrastructure sizing."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating per device in kW — benchmarks energy consumption per device type for efficiency analysis."
    - name: "avg_operating_temperature_c"
      expr: AVG(CAST(operating_temperature_c AS DOUBLE))
      comment: "Average operating temperature rating across devices — used to validate environmental suitability of device fleet for plant conditions."
    - name: "distinct_manufacturer_count"
      expr: COUNT(DISTINCT manufacturer)
      comment: "Number of distinct device manufacturers in the fleet — measures vendor diversity; high counts indicate standardization opportunity and supply chain risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_firmware_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Firmware update compliance and performance KPIs — tracks update success rates, rollback frequency, and update duration to manage cybersecurity patch compliance and device reliability."
  source: "`vibe_manufacturing_v1`.`automation`.`firmware_update`"
  dimensions:
    - name: "update_status"
      expr: update_status
      comment: "Outcome status of the firmware update (e.g. Success, Failed, Rolled Back) — primary dimension for update success analysis."
    - name: "update_method"
      expr: update_method
      comment: "Method used to deploy the firmware update (e.g. Remote, Manual, OTA) — used to compare update success rates by deployment method."
    - name: "device_type"
      expr: device_type
      comment: "Type of device receiving the firmware update — used to segment update performance by device category."
    - name: "is_critical_update"
      expr: is_critical_update
      comment: "Whether the firmware update addresses a critical vulnerability — used to prioritize and track critical patch compliance."
    - name: "rollback_flag"
      expr: rollback_flag
      comment: "Whether the update was rolled back — high rollback rates indicate firmware quality or compatibility issues."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the firmware update record — used to filter completed vs. in-progress updates."
    - name: "post_update_validation_status"
      expr: post_update_validation_status
      comment: "Result of post-update validation testing — measures whether updates were properly validated before production use."
    - name: "update_month"
      expr: DATE_TRUNC('month', scheduled_timestamp)
      comment: "Month the firmware update was scheduled — supports monthly patch compliance trend reporting."
  measures:
    - name: "total_firmware_updates"
      expr: COUNT(1)
      comment: "Total number of firmware update records — baseline volume metric for patch management activity tracking."
    - name: "successful_update_count"
      expr: COUNT(CASE WHEN update_status = 'Success' THEN 1 END)
      comment: "Count of successfully completed firmware updates — measures patch deployment effectiveness."
    - name: "update_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN update_status = 'Success' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of firmware updates that succeeded — executive cybersecurity KPI; low rates trigger patch management process review."
    - name: "rollback_count"
      expr: COUNT(CASE WHEN rollback_flag = TRUE THEN 1 END)
      comment: "Count of firmware updates that were rolled back — high rollback rates indicate firmware quality issues or inadequate pre-deployment testing."
    - name: "rollback_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rollback_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of firmware updates that required rollback — measures firmware deployment risk; drives pre-deployment validation investment."
    - name: "avg_update_duration_seconds"
      expr: AVG(CAST(update_duration_seconds AS DOUBLE))
      comment: "Average time to complete a firmware update in seconds — measures update efficiency; long durations increase production downtime risk."
    - name: "total_update_size_mb"
      expr: SUM(CAST(update_size_mb AS DOUBLE))
      comment: "Total firmware update payload size in MB — used for network bandwidth planning and update scheduling optimization."
    - name: "critical_update_count"
      expr: COUNT(CASE WHEN is_critical_update = TRUE THEN 1 END)
      comment: "Count of critical firmware updates — measures cybersecurity patch urgency; high counts signal elevated vulnerability exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_control_system`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Control system fleet health and reliability KPIs — tracks uptime, MTBF, MTTR, and lifecycle status to support maintenance investment, reliability engineering, and cybersecurity governance decisions."
  source: "`vibe_manufacturing_v1`.`automation`.`control_system`"
  dimensions:
    - name: "control_system_type"
      expr: control_system_type
      comment: "Type of control system (e.g. DCS, PLC, SCADA, Safety) — primary segmentation for fleet reliability analysis."
    - name: "control_system_status"
      expr: control_system_status
      comment: "Current operational status of the control system — used to identify systems requiring immediate attention."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle phase of the control system (e.g. Active, End-of-Life, Obsolete) — drives replacement planning and capital investment."
    - name: "safety_integrity_level"
      expr: safety_integrity_level
      comment: "Safety Integrity Level (SIL) rating of the control system — used to prioritize maintenance and compliance activities for safety-critical systems."
    - name: "redundancy_level"
      expr: redundancy_level
      comment: "Redundancy configuration level of the control system — used to assess resilience and single-point-of-failure risk."
    - name: "security_classification"
      expr: security_classification
      comment: "Cybersecurity classification of the control system — used to prioritize security hardening and audit activities."
    - name: "plant_area"
      expr: plant_area
      comment: "Plant area where the control system is installed — enables area-level reliability and availability benchmarking."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the control system is classified as critical — used to apply differentiated maintenance and monitoring standards."
  measures:
    - name: "total_control_systems"
      expr: COUNT(1)
      comment: "Total number of control systems in the fleet — baseline for fleet size and coverage analysis."
    - name: "total_uptime_hours"
      expr: SUM(CAST(uptime_hours AS DOUBLE))
      comment: "Total cumulative uptime hours across all control systems — measures overall fleet availability for production operations."
    - name: "avg_uptime_hours"
      expr: AVG(CAST(uptime_hours AS DOUBLE))
      comment: "Average uptime hours per control system — benchmarks individual system availability against fleet norms."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures (MTBF) in hours — primary reliability KPI for control systems; low MTBF drives maintenance strategy review."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair (MTTR) in hours — measures maintenance responsiveness; high MTTR indicates resource or spare parts constraints."
    - name: "end_of_life_system_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'End-of-Life' THEN 1 END)
      comment: "Count of control systems at end-of-life — drives capital replacement planning and cybersecurity risk mitigation investment."
    - name: "critical_system_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of control systems classified as critical — used to scope high-priority maintenance and security programs."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_proof_test_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety function proof test compliance KPIs — tracks test pass rates, overdue tests, and test duration to ensure IEC 61511 functional safety compliance and SIL maintenance."
  source: "`vibe_manufacturing_v1`.`automation`.`proof_test_record`"
  dimensions:
    - name: "test_result"
      expr: test_result
      comment: "Outcome of the proof test (e.g. Pass, Fail, Conditional Pass) — primary quality dimension for safety compliance analysis."
    - name: "test_type"
      expr: test_type
      comment: "Type of proof test performed (e.g. Full, Partial, Functional) — used to segment test coverage and compliance by test methodology."
    - name: "safety_integrity_level"
      expr: safety_integrity_level
      comment: "SIL level of the safety function being tested — used to prioritize compliance reporting for highest-risk safety functions."
    - name: "proof_test_record_status"
      expr: proof_test_record_status
      comment: "Current status of the proof test record (e.g. Completed, Pending Review, Overdue) — used to track test closure compliance."
    - name: "test_environment"
      expr: test_environment
      comment: "Environment in which the proof test was conducted (e.g. Live Plant, Isolated, Simulated) — used to assess test validity."
    - name: "test_is_critical"
      expr: test_is_critical
      comment: "Whether the proof test is classified as critical — used to prioritize overdue test escalation."
    - name: "test_year"
      expr: YEAR(test_date)
      comment: "Year the proof test was conducted — supports annual safety compliance reporting."
    - name: "test_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month the proof test was conducted — enables monthly proof test completion rate tracking."
  measures:
    - name: "total_proof_tests"
      expr: COUNT(1)
      comment: "Total number of proof test records — baseline for safety compliance program coverage measurement."
    - name: "passed_test_count"
      expr: COUNT(CASE WHEN test_result = 'Pass' THEN 1 END)
      comment: "Count of proof tests that passed — measures safety function compliance; low pass rates trigger immediate safety review."
    - name: "test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proof tests that passed — executive safety KPI; below-target rates trigger regulatory reporting and corrective action programs."
    - name: "avg_test_duration_seconds"
      expr: AVG(CAST(test_duration_seconds AS DOUBLE))
      comment: "Average proof test duration in seconds — used to plan test scheduling and minimize production downtime from safety testing."
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average ambient temperature during proof tests — used to validate that tests were conducted within acceptable environmental conditions."
    - name: "avg_test_pressure_bar"
      expr: AVG(CAST(test_pressure_bar AS DOUBLE))
      comment: "Average test pressure during proof tests in bar — validates that pressure-based safety functions were tested at correct operating conditions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Automation change management KPIs — tracks change request volume, approval cycle times, emergency change rates, and post-change validation outcomes to govern automation change risk and compliance."
  source: "`vibe_manufacturing_v1`.`automation`.`automation_change_request`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of automation change (e.g. Software, Hardware, Configuration, Safety) — used to segment change risk and volume by category."
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change request (e.g. Open, Approved, Implemented, Closed) — used to track change pipeline and backlog."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval decision for the change request — used to measure change approval rates and identify bottlenecks."
    - name: "change_priority"
      expr: change_priority
      comment: "Priority level of the change request — used to analyze whether high-priority changes are processed faster."
    - name: "is_emergency_change"
      expr: is_emergency_change
      comment: "Whether the change was classified as an emergency — high emergency change rates indicate poor change planning and elevated risk."
    - name: "post_change_validation_status"
      expr: post_change_validation_status
      comment: "Result of post-implementation validation — measures whether changes were properly validated before production use."
    - name: "change_origin"
      expr: change_origin
      comment: "Origin of the change request (e.g. Maintenance, Engineering, Regulatory) — used to analyze change demand by source."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month the change request was submitted — supports monthly change volume trend analysis."
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total number of automation change requests — baseline volume metric for change management program oversight."
    - name: "emergency_change_count"
      expr: COUNT(CASE WHEN is_emergency_change = TRUE THEN 1 END)
      comment: "Count of emergency change requests — high emergency change rates indicate reactive change management and elevated operational risk."
    - name: "emergency_change_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency_change = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change requests classified as emergency — executive governance KPI; high rates trigger change management process improvement."
    - name: "approved_change_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of approved change requests — measures change approval throughput for capacity planning of change review boards."
    - name: "post_validation_pass_count"
      expr: COUNT(CASE WHEN post_change_validation_status = 'Passed' THEN 1 END)
      comment: "Count of changes that passed post-implementation validation — measures change quality; low pass rates indicate inadequate testing before implementation."
    - name: "post_validation_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN post_change_validation_status = 'Passed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of implemented changes passing post-validation — quality KPI for automation change management; low rates trigger process review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_scada_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SCADA operator session KPIs — tracks session activity, control action volume, alarm acknowledgement rates, and setpoint change frequency to support operator performance management and cybersecurity audit."
  source: "`vibe_manufacturing_v1`.`automation`.`scada_session`"
  dimensions:
    - name: "session_type"
      expr: session_type
      comment: "Type of SCADA session (e.g. Operator, Engineer, Supervisor) — used to segment activity metrics by user role."
    - name: "session_status"
      expr: session_status
      comment: "Current status of the SCADA session (e.g. Active, Terminated, Expired) — used to filter analysis to completed sessions."
    - name: "user_role"
      expr: user_role
      comment: "Role of the user during the SCADA session — used to analyze control action and alarm acknowledgement rates by operator role."
    - name: "login_method"
      expr: login_method
      comment: "Authentication method used to log in (e.g. Password, Smart Card, Biometric) — used for cybersecurity audit and access control analysis."
    - name: "plant_area"
      expr: plant_area
      comment: "Plant area associated with the SCADA session — enables area-level operator activity analysis."
    - name: "session_month"
      expr: DATE_TRUNC('month', session_start_timestamp)
      comment: "Month the SCADA session started — supports monthly operator activity trend reporting."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of SCADA sessions — baseline metric for operator activity volume and system utilization."
    - name: "avg_session_duration_seconds"
      expr: AVG(CAST(session_duration_seconds AS DOUBLE))
      comment: "Average SCADA session duration in seconds — measures operator engagement; very short sessions may indicate login issues or unauthorized access."
    - name: "total_session_duration_seconds"
      expr: SUM(CAST(session_duration_seconds AS DOUBLE))
      comment: "Total cumulative SCADA session time in seconds — measures overall operator system engagement for workforce planning."
    - name: "distinct_operator_count"
      expr: COUNT(DISTINCT scada_employee_id)
      comment: "Number of distinct operators with SCADA sessions — measures system user base size for license and access management."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_setpoint_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process setpoint change KPIs — tracks setpoint change frequency, approval compliance, and out-of-limits changes to support process discipline, quality management, and regulatory compliance."
  source: "`vibe_manufacturing_v1`.`automation`.`setpoint_change`"
  dimensions:
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for the setpoint change — used to analyze the primary drivers of process parameter adjustments."
    - name: "change_status"
      expr: change_status
      comment: "Current status of the setpoint change record — used to track pending vs. completed changes."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the setpoint change — used to measure change authorization compliance."
    - name: "is_approved"
      expr: is_approved
      comment: "Whether the setpoint change was formally approved — key compliance dimension for regulated manufacturing environments."
    - name: "within_normal_limits"
      expr: within_normal_limits
      comment: "Whether the new setpoint is within normal operating limits — out-of-limits changes indicate process excursions requiring investigation."
    - name: "initiated_by_type"
      expr: initiated_by_type
      comment: "Type of initiator for the setpoint change (e.g. Operator, System, Recipe) — used to distinguish manual from automated process adjustments."
    - name: "change_month"
      expr: DATE_TRUNC('month', change_timestamp)
      comment: "Month the setpoint change was made — supports monthly process discipline trend analysis."
  measures:
    - name: "total_setpoint_changes"
      expr: COUNT(1)
      comment: "Total number of setpoint changes — baseline metric for process discipline monitoring; high frequency may indicate process instability."
    - name: "unapproved_change_count"
      expr: COUNT(CASE WHEN is_approved = FALSE THEN 1 END)
      comment: "Count of setpoint changes made without formal approval — measures process control compliance; high counts trigger regulatory and quality audit actions."
    - name: "unapproved_change_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_approved = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of setpoint changes made without approval — compliance KPI for regulated manufacturing; any non-zero rate triggers investigation."
    - name: "out_of_limits_change_count"
      expr: COUNT(CASE WHEN within_normal_limits = FALSE THEN 1 END)
      comment: "Count of setpoint changes that placed the process outside normal operating limits — measures process excursion frequency; drives process stability improvement."
    - name: "out_of_limits_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN within_normal_limits = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of setpoint changes resulting in out-of-limits conditions — process quality KPI; high rates indicate poor process control and product quality risk."
    - name: "avg_new_setpoint_value"
      expr: AVG(CAST(new_setpoint_value AS DOUBLE))
      comment: "Average new setpoint value across all changes — used to detect systematic drift in process parameter targets over time."
    - name: "avg_setpoint_delta"
      expr: AVG(ABS(new_setpoint_value - previous_setpoint_value))
      comment: "Average magnitude of setpoint changes — large average deltas indicate significant process adjustments that may signal instability or recipe changes."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_device_connectivity_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Device connectivity reliability KPIs — tracks connectivity failure rates, recovery times, and communication protocol performance to support OT network reliability and cybersecurity monitoring."
  source: "`vibe_manufacturing_v1`.`automation`.`device_connectivity_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of connectivity event (e.g. Disconnection, Reconnection, Timeout) — primary dimension for connectivity failure analysis."
    - name: "connectivity_status"
      expr: connectivity_status
      comment: "Current connectivity status of the device — used to identify devices with persistent connectivity issues."
    - name: "device_connectivity_event_status"
      expr: device_connectivity_event_status
      comment: "Processing status of the connectivity event record — used to track open vs. resolved connectivity incidents."
    - name: "communication_protocol"
      expr: communication_protocol
      comment: "Communication protocol involved in the connectivity event — used to identify protocol-specific reliability issues."
    - name: "detection_source"
      expr: detection_source
      comment: "Source that detected the connectivity event (e.g. Watchdog, Heartbeat, Manual) — used to assess monitoring coverage effectiveness."
    - name: "device_model"
      expr: device_model
      comment: "Model of the device experiencing connectivity issues — used to identify device models with systemic connectivity problems."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the connectivity event — supports monthly network reliability trend reporting."
  measures:
    - name: "total_connectivity_events"
      expr: COUNT(1)
      comment: "Total number of device connectivity events — baseline metric for OT network reliability monitoring."
    - name: "distinct_affected_device_count"
      expr: COUNT(DISTINCT device_registry_id)
      comment: "Number of distinct devices experiencing connectivity events — measures breadth of connectivity issues across the device fleet."
    - name: "disconnection_event_count"
      expr: COUNT(CASE WHEN event_type = 'Disconnection' THEN 1 END)
      comment: "Count of device disconnection events — measures network reliability failures; high counts trigger OT network infrastructure review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_fat_sat_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Factory Acceptance Test (FAT) and Site Acceptance Test (SAT) KPIs — tracks test pass rates, retest frequency, and corrective action requirements to govern automation project commissioning quality."
  source: "`vibe_manufacturing_v1`.`automation`.`fat_sat_record`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of acceptance test (e.g. FAT, SAT, IFAT) — primary dimension for commissioning test performance analysis."
    - name: "test_result"
      expr: test_result
      comment: "Outcome of the acceptance test (e.g. Pass, Fail, Conditional) — primary quality dimension for commissioning readiness assessment."
    - name: "fat_sat_record_status"
      expr: fat_sat_record_status
      comment: "Current status of the FAT/SAT record (e.g. Completed, Pending, Overdue) — used to track commissioning test closure."
    - name: "retest_required"
      expr: retest_required
      comment: "Whether a retest is required — high retest rates indicate poor first-time quality in automation commissioning."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required following the test — measures commissioning defect rate and rework burden."
    - name: "test_year"
      expr: YEAR(test_date)
      comment: "Year the acceptance test was conducted — supports annual commissioning quality trend reporting."
  measures:
    - name: "total_fat_sat_records"
      expr: COUNT(1)
      comment: "Total number of FAT/SAT test records — baseline for commissioning test coverage measurement."
    - name: "passed_test_count"
      expr: COUNT(CASE WHEN test_result = 'Pass' THEN 1 END)
      comment: "Count of acceptance tests that passed — measures commissioning quality; low pass rates delay project handover and increase costs."
    - name: "first_time_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'Pass' AND retest_required = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acceptance tests passing on first attempt without retest — executive commissioning quality KPI; low rates indicate design or build quality issues."
    - name: "retest_required_count"
      expr: COUNT(CASE WHEN retest_required = TRUE THEN 1 END)
      comment: "Count of tests requiring a retest — measures commissioning rework burden; high counts increase project schedule and cost risk."
    - name: "corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of tests requiring corrective action — measures commissioning defect rate; drives quality improvement in automation engineering and build processes."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Automation project portfolio KPIs — tracks budget performance, schedule adherence, and project completion rates to support capital investment governance and portfolio management decisions."
  source: "`vibe_manufacturing_v1`.`automation`.`automation_project`"
  dimensions:
    - name: "automation_project_type"
      expr: automation_project_type
      comment: "Type of automation project (e.g. Upgrade, New Installation, Cybersecurity) — used to segment portfolio performance by project category."
    - name: "automation_project_status"
      expr: automation_project_status
      comment: "Current status of the automation project (e.g. Active, Completed, On Hold) — used to filter portfolio analysis to active or completed projects."
    - name: "priority"
      expr: priority
      comment: "Priority level of the automation project — used to analyze whether high-priority projects receive adequate resources and achieve better outcomes."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the automation project — used to segment portfolio by risk level for executive risk management reporting."
    - name: "safety_integrity_level"
      expr: safety_integrity_level
      comment: "Safety Integrity Level associated with the project — used to prioritize safety-critical automation projects in portfolio reviews."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the project is classified as critical — used to apply differentiated governance and monitoring standards."
    - name: "is_cybersecurity_hardening"
      expr: is_cybersecurity_hardening
      comment: "Whether the project is a cybersecurity hardening initiative — used to track cybersecurity investment portfolio performance."
    - name: "project_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the project was planned to start — supports annual capital investment portfolio analysis."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of automation projects in the portfolio — baseline for portfolio size and workload analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted investment across all automation projects — measures total capital commitment for automation programs."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend across all automation projects — measures capital consumption; compared against budget to assess portfolio cost performance."
    - name: "budget_variance"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE) - CAST(budget_amount AS DOUBLE))
      comment: "Total budget variance (actual minus budget) across all projects — negative values indicate under-spend; positive values indicate cost overruns requiring executive attention."
    - name: "avg_budget_utilization_pct"
      expr: ROUND(100.0 * AVG(actual_spend_amount / NULLIF(budget_amount, 0)), 2)
      comment: "Average budget utilization percentage across projects — measures capital deployment efficiency; very low utilization indicates planning or execution issues."
    - name: "avg_actual_duration_days"
      expr: AVG(CAST(actual_duration_days AS DOUBLE))
      comment: "Average actual project duration in days — measures project execution speed; compared against estimated duration to assess schedule performance."
    - name: "avg_estimated_duration_days"
      expr: AVG(CAST(estimated_duration_days AS DOUBLE))
      comment: "Average estimated project duration in days — baseline for schedule performance benchmarking."
    - name: "critical_project_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of critical automation projects — used to scope high-priority governance and resource allocation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`automation_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe management KPIs — tracks recipe library health, yield performance, and approval status to support process standardization, quality management, and regulatory compliance in batch manufacturing."
  source: "`vibe_manufacturing_v1`.`automation`.`recipe`"
  dimensions:
    - name: "recipe_status"
      expr: recipe_status
      comment: "Current status of the recipe (e.g. Active, Obsolete, Under Review) — used to track recipe library currency and compliance."
    - name: "recipe_type"
      expr: recipe_type
      comment: "Type of recipe (e.g. Master, Control, General) — used to segment recipe library by ISA-88 recipe hierarchy level."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the recipe — used to ensure only approved recipes are used in production."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the recipe — used to track recipe lifecycle from development through production release."
    - name: "equipment_class"
      expr: equipment_class
      comment: "Equipment class the recipe is designed for — used to analyze recipe coverage across equipment types."
    - name: "safety_integrity_level"
      expr: safety_integrity_level
      comment: "Safety Integrity Level associated with the recipe — used to prioritize safety-critical recipe reviews and validations."
  measures:
    - name: "total_recipes"
      expr: COUNT(1)
      comment: "Total number of recipes in the library — baseline for recipe portfolio size and coverage analysis."
    - name: "approved_recipe_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of approved recipes — measures recipe compliance readiness; unapproved recipes in production trigger quality and regulatory risk."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recipes with approved status — recipe governance KPI; low rates indicate backlog in recipe validation and approval processes."
    - name: "avg_max_yield"
      expr: AVG(CAST(max_yield AS DOUBLE))
      comment: "Average maximum yield across all recipes — used to benchmark recipe efficiency and identify improvement opportunities."
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE target across all recipes — used to assess whether recipe-level OEE targets are aligned with plant performance goals."
    - name: "avg_total_process_time"
      expr: AVG(CAST(total_process_time AS DOUBLE))
      comment: "Average total process time across all recipes — used to benchmark recipe cycle times and identify scheduling optimization opportunities."
    - name: "avg_yield_tolerance"
      expr: AVG(CAST(yield_tolerance AS DOUBLE))
      comment: "Average yield tolerance across all recipes — measures how tightly recipes constrain acceptable yield variation; low tolerance indicates high-precision processes."
$$;