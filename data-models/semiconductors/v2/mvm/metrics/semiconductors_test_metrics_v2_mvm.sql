-- Metric views for domain: test | Business: Semiconductors | Version: 2 | Generated on: 2026-06-27 11:25:39

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_final_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Final test execution performance metrics tracking yield, throughput, and quality outcomes for packaged semiconductor units"
  source: "`vibe_semiconductors_v1`.`test`.`final_test_run`"
  dimensions:
    - name: "test_location"
      expr: test_location
      comment: "Geographic or facility location where final test was performed"
    - name: "test_type"
      expr: test_type
      comment: "Category of final test executed (e.g., functional, parametric, burn-in)"
    - name: "final_test_run_status"
      expr: final_test_run_status
      comment: "Completion status of the final test run"
    - name: "test_result"
      expr: test_result
      comment: "Overall pass/fail outcome of the test run"
    - name: "test_shift"
      expr: test_shift
      comment: "Production shift during which test was executed"
    - name: "handler_model"
      expr: handler_model
      comment: "Model of automated test handler equipment used"
    - name: "test_program_version"
      expr: test_program_version
      comment: "Version of test program executed"
    - name: "run_timestamp_date"
      expr: DATE_TRUNC('day', run_timestamp)
      comment: "Date of test run execution for daily trending"
    - name: "run_timestamp_month"
      expr: DATE_TRUNC('month', run_timestamp)
      comment: "Month of test run execution for monthly trending"
  measures:
    - name: "total_final_test_runs"
      expr: COUNT(1)
      comment: "Total number of final test runs executed"
    - name: "total_units_tested"
      expr: SUM(CAST(units_tested AS BIGINT))
      comment: "Total semiconductor units subjected to final test"
    - name: "total_units_passed"
      expr: SUM(CAST(units_passed AS BIGINT))
      comment: "Total semiconductor units that passed final test"
    - name: "avg_final_test_yield"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average final test yield percentage across all runs"
    - name: "avg_test_time_seconds"
      expr: AVG(CAST(test_time_seconds AS DOUBLE))
      comment: "Average test execution time per run in seconds, key throughput metric"
    - name: "total_test_time_hours"
      expr: SUM(CAST(test_time_seconds AS DOUBLE)) / 3600.0
      comment: "Total test time consumed in hours, critical for capacity planning"
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption during test in milliwatts, quality and reliability indicator"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius, critical for thermal qualification"
    - name: "distinct_test_programs"
      expr: COUNT(DISTINCT test_program_version)
      comment: "Number of unique test program versions executed, indicates test coverage diversity"
    - name: "distinct_handlers"
      expr: COUNT(DISTINCT handler_name)
      comment: "Number of unique test handlers utilized, capacity and utilization metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_wafer_probe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer-level probe test performance metrics tracking die yield, contact quality, and early defect detection"
  source: "`vibe_semiconductors_v1`.`test`.`wafer_probe_run`"
  dimensions:
    - name: "wafer_probe_run_status"
      expr: wafer_probe_run_status
      comment: "Completion status of the wafer probe run"
    - name: "run_status"
      expr: run_status
      comment: "Operational status of the probe run execution"
    - name: "ate_configuration"
      expr: ate_configuration
      comment: "Automated test equipment configuration used for probing"
    - name: "bin_map_version"
      expr: bin_map_version
      comment: "Version of bin mapping used for die classification"
    - name: "run_timestamp_date"
      expr: DATE_TRUNC('day', run_timestamp)
      comment: "Date of probe run for daily yield trending"
    - name: "run_timestamp_month"
      expr: DATE_TRUNC('month', run_timestamp)
      comment: "Month of probe run for monthly yield trending"
    - name: "start_timestamp_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date probe run started"
  measures:
    - name: "total_wafer_probe_runs"
      expr: COUNT(1)
      comment: "Total number of wafer probe runs executed"
    - name: "total_die_tested"
      expr: SUM(CAST(total_die_tested AS BIGINT))
      comment: "Total die subjected to probe test across all wafers"
    - name: "total_good_die"
      expr: SUM(CAST(good_die_count AS BIGINT))
      comment: "Total die passing probe test, key yield numerator"
    - name: "total_gross_die"
      expr: SUM(CAST(gross_die_count AS BIGINT))
      comment: "Total gross die available on wafers before test"
    - name: "avg_probe_yield"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average wafer probe yield percentage, primary quality gate metric"
    - name: "avg_contact_yield"
      expr: AVG(CAST(contact_yield_percent AS DOUBLE))
      comment: "Average contact yield percentage, indicates probe card and pad quality"
    - name: "avg_test_coverage"
      expr: AVG(CAST(test_coverage_percent AS DOUBLE))
      comment: "Average test coverage percentage, measures completeness of probe test"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average probe test temperature in Celsius"
    - name: "distinct_ate_configs"
      expr: COUNT(DISTINCT ate_configuration)
      comment: "Number of unique ATE configurations used, capacity and flexibility metric"
    - name: "runs_with_parametric_data"
      expr: SUM(CASE WHEN parametric_test_data_available = TRUE THEN 1 ELSE 0 END)
      comment: "Count of probe runs with parametric test data available for deep analysis"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_parametric_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parametric test measurement quality and compliance metrics tracking electrical parameter performance against specifications"
  source: "`vibe_semiconductors_v1`.`test`.`parametric_measurement`"
  dimensions:
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the electrical parameter measured (e.g., Vdd, Idd, frequency)"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type or category of parametric measurement"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement execution"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of the parametric measurement"
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measure for the parameter (e.g., mV, mA, MHz)"
    - name: "measurement_location"
      expr: measurement_location
      comment: "Physical location on die or package where measurement was taken"
    - name: "measurement_mode"
      expr: measurement_mode
      comment: "Mode or condition under which measurement was performed"
    - name: "measurement_quality_flag"
      expr: measurement_quality_flag
      comment: "Quality indicator flag for measurement reliability"
    - name: "measurement_timestamp_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Date of measurement for daily trending"
    - name: "measurement_timestamp_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of measurement for monthly trending"
  measures:
    - name: "total_parametric_measurements"
      expr: COUNT(1)
      comment: "Total number of parametric measurements recorded"
    - name: "measurements_passed"
      expr: SUM(CASE WHEN pass_fail_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of measurements that passed specification limits"
    - name: "measurements_failed"
      expr: SUM(CASE WHEN pass_fail_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of measurements that failed specification limits, defect indicator"
    - name: "measurements_flagged"
      expr: SUM(CASE WHEN measurement_flagged = TRUE THEN 1 ELSE 0 END)
      comment: "Count of measurements flagged for review, quality alert metric"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all parametric measurements"
    - name: "avg_measurement_std_dev"
      expr: AVG(CAST(measurement_std_dev AS DOUBLE))
      comment: "Average standard deviation of measurements, process stability indicator"
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty, metrology quality metric"
    - name: "avg_condition_voltage_mv"
      expr: AVG(CAST(measurement_condition_voltage_mv AS DOUBLE))
      comment: "Average test voltage condition in millivolts"
    - name: "avg_condition_temperature_c"
      expr: AVG(CAST(measurement_condition_temperature_c AS DOUBLE))
      comment: "Average test temperature condition in Celsius"
    - name: "avg_condition_frequency_mhz"
      expr: AVG(CAST(measurement_condition_frequency_mhz AS DOUBLE))
      comment: "Average test frequency condition in MHz"
    - name: "distinct_parameters"
      expr: COUNT(DISTINCT parameter_name)
      comment: "Number of unique parameters measured, test coverage breadth metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_unit_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual unit-level test result metrics tracking per-die and per-package pass/fail outcomes and bin distributions"
  source: "`vibe_semiconductors_v1`.`test`.`unit_test_result`"
  dimensions:
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail status of the unit test"
    - name: "hard_bin_code"
      expr: hard_bin_code
      comment: "Hardware bin code assigned to the unit, final disposition"
    - name: "soft_bin_code"
      expr: soft_bin_code
      comment: "Software bin code assigned to the unit, detailed failure classification"
    - name: "test_stage"
      expr: test_stage
      comment: "Stage of test (e.g., wafer probe, final test, retest)"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status, critical for multi-chip packaging"
    - name: "retest_indicator"
      expr: retest_indicator
      comment: "Boolean flag indicating if unit was retested"
    - name: "test_yield_flag"
      expr: test_yield_flag
      comment: "Boolean flag indicating if unit contributes to yield calculation"
    - name: "test_condition"
      expr: test_condition
      comment: "Test condition or environment applied"
    - name: "test_timestamp_date"
      expr: DATE_TRUNC('day', test_timestamp)
      comment: "Date of unit test for daily yield tracking"
    - name: "test_timestamp_month"
      expr: DATE_TRUNC('month', test_timestamp)
      comment: "Month of unit test for monthly yield tracking"
  measures:
    - name: "total_units_tested"
      expr: COUNT(1)
      comment: "Total number of individual units tested"
    - name: "units_passed"
      expr: SUM(CASE WHEN pass_fail_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of units that passed test, yield numerator"
    - name: "units_failed"
      expr: SUM(CASE WHEN pass_fail_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of units that failed test, defect count"
    - name: "units_retested"
      expr: SUM(CASE WHEN retest_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of units subjected to retest, quality and process stability indicator"
    - name: "avg_test_time_ms"
      expr: AVG(CAST(test_time_ms AS DOUBLE))
      comment: "Average test time per unit in milliseconds, throughput metric"
    - name: "avg_test_time_seconds"
      expr: AVG(CAST(test_time_seconds AS DOUBLE))
      comment: "Average test time per unit in seconds"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius"
    - name: "avg_test_voltage_v"
      expr: AVG(CAST(test_voltage_v AS DOUBLE))
      comment: "Average test voltage in volts"
    - name: "distinct_hard_bins"
      expr: COUNT(DISTINCT hard_bin_code)
      comment: "Number of unique hard bins assigned, bin distribution diversity metric"
    - name: "distinct_soft_bins"
      expr: COUNT(DISTINCT soft_bin_code)
      comment: "Number of unique soft bins assigned, failure mode diversity metric"
    - name: "distinct_devices"
      expr: COUNT(DISTINCT device_serial_number)
      comment: "Number of unique device serial numbers tested, traceability metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_probe_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Probe card utilization and maintenance metrics tracking card health, usage, and lifecycle for wafer probing operations"
  source: "`vibe_semiconductors_v1`.`test`.`probe_card`"
  dimensions:
    - name: "card_name"
      expr: card_name
      comment: "Name or identifier of the probe card"
    - name: "probe_card_type"
      expr: probe_card_type
      comment: "Type or technology of the probe card (e.g., cantilever, vertical, MEMS)"
    - name: "probe_card_status"
      expr: probe_card_status
      comment: "Current operational status of the probe card"
    - name: "card_status"
      expr: card_status
      comment: "Detailed status of the card"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the probe card, readiness indicator"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status with quality and safety standards"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Manufacturer of the probe card"
    - name: "supplier"
      expr: supplier
      comment: "Supplier of the probe card"
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification of the probe card"
    - name: "last_maintenance_date"
      expr: last_maintenance_date
      comment: "Date of last maintenance performed on the card"
    - name: "next_maintenance_due"
      expr: next_maintenance_due
      comment: "Date when next maintenance is due"
  measures:
    - name: "total_probe_cards"
      expr: COUNT(1)
      comment: "Total number of probe cards in inventory"
    - name: "total_touchdowns"
      expr: SUM(CAST(touchdown_count AS DOUBLE))
      comment: "Total touchdowns across all probe cards, usage intensity metric"
    - name: "avg_touchdowns_per_card"
      expr: AVG(CAST(touchdown_count AS DOUBLE))
      comment: "Average touchdowns per probe card, utilization metric"
    - name: "avg_usage_hours"
      expr: AVG(CAST(usage_hours AS DOUBLE))
      comment: "Average usage hours per probe card, lifecycle metric"
    - name: "total_usage_hours"
      expr: SUM(CAST(usage_hours AS DOUBLE))
      comment: "Total usage hours across all probe cards, capacity utilization metric"
    - name: "avg_contact_resistance_ohm"
      expr: AVG(CAST(contact_resistance_ohm AS DOUBLE))
      comment: "Average contact resistance in ohms, electrical quality metric"
    - name: "avg_planarity_um"
      expr: AVG(CAST(planarity_um AS DOUBLE))
      comment: "Average planarity in micrometers, mechanical quality metric"
    - name: "avg_pitch_um"
      expr: AVG(CAST(pitch_um AS DOUBLE))
      comment: "Average pitch in micrometers, design density metric"
    - name: "avg_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per probe card in USD, capital investment metric"
    - name: "total_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost of all probe cards in USD, asset value metric"
    - name: "distinct_manufacturers"
      expr: COUNT(DISTINCT manufacturer)
      comment: "Number of unique probe card manufacturers, supply chain diversity metric"
    - name: "distinct_card_types"
      expr: COUNT(DISTINCT probe_card_type)
      comment: "Number of unique probe card types, technology diversity metric"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_ate_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Automated test equipment configuration and compliance metrics tracking ATE setup, calibration status, and operational readiness"
  source: "`vibe_semiconductors_v1`.`test`.`ate_configuration`"
  dimensions:
    - name: "configuration_name"
      expr: configuration_name
      comment: "Name of the ATE configuration"
    - name: "configuration_code"
      expr: configuration_code
      comment: "Unique code identifier for the ATE configuration"
    - name: "configuration_status"
      expr: configuration_status
      comment: "Current operational status of the ATE configuration"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status of the ATE, compliance and quality gate"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the ATE configuration"
    - name: "platform_type"
      expr: platform_type
      comment: "Type or platform of the ATE system"
    - name: "compliance_itar_status"
      expr: compliance_itar_status
      comment: "ITAR compliance status, regulatory requirement"
    - name: "compliance_ear_status"
      expr: compliance_ear_status
      comment: "EAR compliance status, regulatory requirement"
    - name: "load_board_qualification_status"
      expr: load_board_qualification_status
      comment: "Qualification status of the load board, readiness indicator"
    - name: "parametric_test_supported"
      expr: parametric_test_supported
      comment: "Boolean flag indicating if parametric testing is supported"
    - name: "calibration_due_date"
      expr: calibration_due_date
      comment: "Date when next calibration is due"
  measures:
    - name: "total_ate_configurations"
      expr: COUNT(1)
      comment: "Total number of ATE configurations defined"
    - name: "configurations_with_parametric_support"
      expr: SUM(CASE WHEN parametric_test_supported = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ATE configurations supporting parametric test, capability metric"
    - name: "avg_test_coverage_percentage"
      expr: AVG(CAST(test_coverage_percentage AS DOUBLE))
      comment: "Average test coverage percentage across ATE configurations, quality metric"
    - name: "avg_test_yield_target_percentage"
      expr: AVG(CAST(test_yield_target_percentage AS DOUBLE))
      comment: "Average yield target percentage set for ATE configurations, performance goal metric"
    - name: "distinct_platform_types"
      expr: COUNT(DISTINCT platform_type)
      comment: "Number of unique ATE platform types, technology diversity metric"
    - name: "distinct_hardware_revisions"
      expr: COUNT(DISTINCT hardware_revision)
      comment: "Number of unique hardware revisions, version management metric"
    - name: "distinct_load_board_revisions"
      expr: COUNT(DISTINCT load_board_revision)
      comment: "Number of unique load board revisions, configuration diversity metric"
$$;