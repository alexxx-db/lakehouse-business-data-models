-- Metric views for domain: test | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_adaptive_test_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adaptive test flow KPIs for ML-driven test optimization, risk management, and test time reduction program effectiveness."
  source: "`vibe_semiconductors_v1`.`test`.`adaptive_test_flow`"
  dimensions:
    - name: "adaptive_test_flow_status"
      expr: adaptive_test_flow_status
      comment: "Current status of the adaptive test flow (e.g., Active, Deprecated, Under Review)."
    - name: "flow_type"
      expr: flow_type
      comment: "Type of adaptive flow (e.g., Skip-Lot, Limit Adjustment, Sequence Optimization) for strategy analysis."
    - name: "flow_status"
      expr: flow_status
      comment: "Execution status of the flow for operational monitoring."
    - name: "action_type"
      expr: action_type
      comment: "Action triggered by the adaptive rule (e.g., Skip, Adjust Limit, Retest) for impact analysis."
    - name: "ml_model_name"
      expr: ml_model_name
      comment: "Name of the ML model driving adaptive decisions; used to compare model performance and governance."
    - name: "is_deprecated"
      expr: is_deprecated
      comment: "Flag indicating deprecated flows; used to track technical debt in adaptive test infrastructure."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the adaptive flow became effective; used for adoption trend analysis."
  measures:
    - name: "total_adaptive_flows"
      expr: COUNT(1)
      comment: "Total adaptive test flows defined; baseline for adaptive test program maturity assessment."
    - name: "avg_test_time_reduction_target_percent"
      expr: AVG(CAST(test_time_reduction_target_percent AS DOUBLE))
      comment: "Average test time reduction target across adaptive flows; quantifies the cost savings potential of the adaptive test program."
    - name: "avg_quality_escape_risk_threshold"
      expr: AVG(CAST(quality_escape_risk_threshold AS DOUBLE))
      comment: "Average quality escape risk threshold; governs the aggressiveness of test skipping and limit relaxation decisions."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across adaptive flows; used to prioritize review and validation of high-risk flows."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average decision threshold value across adaptive flows; used to calibrate adaptive rule sensitivity."
    - name: "active_adaptive_flows"
      expr: COUNT(CASE WHEN adaptive_test_flow_status = 'Active' AND is_deprecated = FALSE THEN 1 END)
      comment: "Count of currently active, non-deprecated adaptive flows; measures the live footprint of the adaptive test program."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_ate_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ATE configuration KPIs for tester fleet management, calibration compliance, and test capability governance."
  source: "`vibe_semiconductors_v1`.`test`.`ate_configuration`"
  dimensions:
    - name: "configuration_status"
      expr: configuration_status
      comment: "Current status of the ATE configuration (e.g., Active, Retired, In-Calibration)."
    - name: "ate_platform"
      expr: ate_platform
      comment: "ATE platform type for fleet composition and capability analysis."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform category for grouping configurations by tester generation or capability tier."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration compliance status; non-compliant testers must be taken offline to prevent quality escapes."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle phase of the ATE configuration (e.g., Production, End-of-Life) for fleet renewal planning."
    - name: "load_board_qualification_status"
      expr: load_board_qualification_status
      comment: "Qualification status of the load board; unqualified load boards are a leading cause of test escapes."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the configuration became effective; used for fleet deployment trend analysis."
  measures:
    - name: "total_ate_configurations"
      expr: COUNT(1)
      comment: "Total ATE configurations in the fleet; baseline for capacity planning and capital asset management."
    - name: "avg_test_coverage_percentage"
      expr: AVG(CAST(test_coverage_percentage AS DOUBLE))
      comment: "Average test coverage percentage across ATE configurations; validates fleet-wide fault detection capability."
    - name: "avg_test_yield_target_percentage"
      expr: AVG(CAST(test_yield_target_percentage AS DOUBLE))
      comment: "Average yield target across ATE configurations; used to set performance expectations for each tester."
    - name: "calibration_overdue_count"
      expr: COUNT(CASE WHEN calibration_status != 'Current' THEN 1 END)
      comment: "Count of ATE configurations with non-current calibration; directly impacts measurement accuracy and quality compliance."
    - name: "parametric_capable_count"
      expr: COUNT(CASE WHEN parametric_test_supported = TRUE THEN 1 END)
      comment: "Count of ATE configurations supporting parametric test; measures fleet capability for advanced characterization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_correlation_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test correlation study KPIs tracking ATE-to-ATE correlation, guard-banding, and measurement consistency for multi-site test operations"
  source: "`vibe_semiconductors_v1`.`test`.`correlation_study`"
  dimensions:
    - name: "study_date"
      expr: DATE_TRUNC('day', study_date)
      comment: "Correlation study execution date"
    - name: "study_month"
      expr: DATE_TRUNC('month', study_date)
      comment: "Correlation study execution month"
    - name: "approval_date"
      expr: DATE_TRUNC('day', approval_date)
      comment: "Correlation study approval date"
    - name: "study_type"
      expr: study_type
      comment: "Type of correlation study (ATE-to-ATE, site-to-site, etc.)"
    - name: "correlation_study_status"
      expr: correlation_study_status
      comment: "Correlation study status"
    - name: "study_status"
      expr: study_status
      comment: "Overall study status"
    - name: "correlation_methodology"
      expr: correlation_methodology
      comment: "Statistical methodology used for correlation"
    - name: "test_platform"
      expr: test_platform
      comment: "Test platform being correlated"
    - name: "test_site"
      expr: test_site
      comment: "Test site location"
  measures:
    - name: "total_correlation_studies"
      expr: COUNT(1)
      comment: "Total number of correlation studies performed"
    - name: "avg_correlation_coefficient"
      expr: AVG(CAST(correlation_coefficient AS DOUBLE))
      comment: "Average correlation coefficient (R-value)"
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average statistical confidence level"
    - name: "avg_offset_value"
      expr: AVG(CAST(offset_value AS DOUBLE))
      comment: "Average measurement offset between platforms"
    - name: "avg_systematic_offset"
      expr: AVG(CAST(systematic_offset AS DOUBLE))
      comment: "Average systematic offset requiring guard-banding"
    - name: "avg_cpk_impact"
      expr: AVG(CAST(cpk_impact AS DOUBLE))
      comment: "Average impact on process capability index (Cpk)"
    - name: "distinct_parameters_studied"
      expr: COUNT(DISTINCT parameter_name)
      comment: "Number of unique parameters correlated"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test coverage KPIs tracking fault coverage, DFT structure coverage, and coverage effectiveness for design quality"
  source: "`vibe_semiconductors_v1`.`test`.`coverage`"
  dimensions:
    - name: "coverage_date"
      expr: DATE_TRUNC('day', coverage_date)
      comment: "Coverage analysis date"
    - name: "coverage_month"
      expr: DATE_TRUNC('month', coverage_date)
      comment: "Coverage analysis month"
    - name: "analysis_date"
      expr: DATE_TRUNC('day', analysis_date)
      comment: "Coverage analysis execution date"
    - name: "coverage_category"
      expr: coverage_category
      comment: "Category of coverage (functional, structural, parametric)"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage metric"
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage analysis status"
    - name: "method"
      expr: method
      comment: "Coverage analysis method"
    - name: "atpg_tool"
      expr: atpg_tool
      comment: "ATPG tool used for coverage analysis"
    - name: "is_approved"
      expr: is_approved
      comment: "Whether coverage is approved"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether coverage is for critical path"
    - name: "tapeout_ready"
      expr: tapeout_ready
      comment: "Whether coverage meets tapeout criteria"
  measures:
    - name: "total_coverage_analyses"
      expr: COUNT(1)
      comment: "Total number of coverage analyses performed"
    - name: "avg_fault_coverage_percent"
      expr: AVG(CAST(fault_coverage_percent AS DOUBLE))
      comment: "Average fault coverage percentage"
    - name: "avg_stuck_at_fault_coverage_percent"
      expr: AVG(CAST(stuck_at_fault_coverage_percent AS DOUBLE))
      comment: "Average stuck-at fault coverage percentage"
    - name: "avg_transition_fault_coverage_percent"
      expr: AVG(CAST(transition_fault_coverage_percent AS DOUBLE))
      comment: "Average transition fault coverage percentage"
    - name: "avg_path_delay_coverage_percent"
      expr: AVG(CAST(path_delay_coverage_percent AS DOUBLE))
      comment: "Average path delay coverage percentage"
    - name: "avg_dft_structure_coverage_percent"
      expr: AVG(CAST(dft_structure_coverage_percent AS DOUBLE))
      comment: "Average DFT structure coverage percentage"
    - name: "avg_iddq_coverage_percent"
      expr: AVG(CAST(iddq_coverage_percent AS DOUBLE))
      comment: "Average IDDQ coverage percentage"
    - name: "total_detected_faults"
      expr: SUM(CAST(detected_faults AS DOUBLE))
      comment: "Total number of faults detected"
    - name: "total_faults"
      expr: SUM(CAST(total_faults AS DOUBLE))
      comment: "Total number of faults in design"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density"
    - name: "avg_yield_estimate_percent"
      expr: AVG(CAST(yield_estimate_percent AS DOUBLE))
      comment: "Average estimated yield percentage based on coverage"
    - name: "avg_correlation_score"
      expr: AVG(CAST(correlation_score AS DOUBLE))
      comment: "Average correlation score between coverage and yield"
    - name: "tapeout_ready_count"
      expr: SUM(CASE WHEN tapeout_ready = true THEN 1 ELSE 0 END)
      comment: "Number of designs meeting tapeout coverage criteria"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_final_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Final test run KPIs tracking yield, throughput, and quality for packaged units at final test insertion"
  source: "`vibe_semiconductors_v1`.`test`.`final_test_run`"
  dimensions:
    - name: "test_date"
      expr: DATE_TRUNC('day', run_timestamp)
      comment: "Test run date for daily trending"
    - name: "test_week"
      expr: DATE_TRUNC('week', run_timestamp)
      comment: "Test run week for weekly trending"
    - name: "test_month"
      expr: DATE_TRUNC('month', run_timestamp)
      comment: "Test run month for monthly trending"
    - name: "test_location"
      expr: test_location
      comment: "Physical test site location"
    - name: "test_shift"
      expr: test_shift
      comment: "Manufacturing shift (day/night/swing)"
    - name: "test_type"
      expr: test_type
      comment: "Type of final test (burn-in, functional, parametric)"
    - name: "run_status"
      expr: run_status
      comment: "Test run completion status"
    - name: "final_test_run_status"
      expr: final_test_run_status
      comment: "Overall test run status"
    - name: "handler_model"
      expr: handler_model
      comment: "Test handler equipment model"
    - name: "ate_name"
      expr: ate_name
      comment: "Automatic test equipment identifier"
  measures:
    - name: "total_test_runs"
      expr: COUNT(1)
      comment: "Total number of final test runs executed"
    - name: "total_units_tested"
      expr: SUM(CAST(units_tested AS DOUBLE))
      comment: "Total units tested across all runs"
    - name: "total_units_passed"
      expr: SUM(CAST(units_passed AS DOUBLE))
      comment: "Total units that passed final test"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average final test yield percentage across runs"
    - name: "avg_test_time_seconds"
      expr: AVG(CAST(test_time_seconds AS DOUBLE))
      comment: "Average test time per unit in seconds"
    - name: "total_test_time_hours"
      expr: SUM(CAST(test_time_seconds AS DOUBLE)) / 3600.0
      comment: "Total test time in hours for capacity planning"
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption in milliwatts during test"
    - name: "distinct_lots_tested"
      expr: COUNT(DISTINCT lot_number)
      comment: "Number of unique wafer lots tested"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_insertion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test insertion KPIs for cost, yield gate management, and test flow optimization across semiconductor device insertions."
  source: "`vibe_semiconductors_v1`.`test`.`insertion`"
  dimensions:
    - name: "insertion_status"
      expr: insertion_status
      comment: "Current status of the insertion (e.g., Active, Inactive, Deprecated) for flow management."
    - name: "insertion_type"
      expr: insertion_type
      comment: "Type of insertion (e.g., Wafer Probe, Final Test, Burn-in) for cost and yield analysis by test stage."
    - name: "temperature_condition"
      expr: temperature_condition
      comment: "Temperature condition for the insertion (e.g., Cold, Hot, Ambient) for thermal coverage analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the insertion is currently active in production flows."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Flag indicating whether the insertion is mandatory; used to distinguish required vs. optional test steps."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the insertion became effective; used for insertion lifecycle trend analysis."
  measures:
    - name: "total_insertions"
      expr: COUNT(1)
      comment: "Total test insertions defined; baseline for test flow complexity and cost structure analysis."
    - name: "avg_cost_per_unit_usd"
      expr: AVG(CAST(cost_per_unit_usd AS DOUBLE))
      comment: "Average cost per unit for each insertion; primary driver of total test cost modeling and reduction programs."
    - name: "total_cost_per_unit_usd"
      expr: SUM(CAST(cost_per_unit_usd AS DOUBLE))
      comment: "Total cost per unit across all insertions; used for test cost benchmarking and OSAT negotiation."
    - name: "avg_expected_yield_percent"
      expr: AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average expected yield per insertion; used to model cumulative yield loss across the test flow."
    - name: "avg_test_coverage_percent"
      expr: AVG(CAST(test_coverage_percent AS DOUBLE))
      comment: "Average test coverage per insertion; ensures each insertion contributes meaningfully to overall fault detection."
    - name: "avg_yield_gate_criteria_percent"
      expr: AVG(CAST(yield_gate_criteria_percent AS DOUBLE))
      comment: "Average yield gate threshold across insertions; drives lot disposition and scrap decisions."
    - name: "avg_max_temperature_c"
      expr: AVG(CAST(max_temperature_c AS DOUBLE))
      comment: "Average maximum test temperature across insertions; validates thermal stress coverage in the test flow."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Limit definition metrics to monitor specification boundaries across programs."
  source: "`vibe_semiconductors_v1`.`test`.`limit`"
  dimensions:
    - name: "test_program_id"
      expr: test_program_id
      comment: "Test program associated with the limit"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Measurement type the limit applies to"
    - name: "limit_category"
      expr: limit_category
      comment: "Category of the limit (e.g., performance, reliability)"
    - name: "effective_date"
      expr: DATE_TRUNC('day', effective_date)
      comment: "Date when the limit became effective"
  measures:
    - name: "total_limits"
      expr: COUNT(1)
      comment: "Number of limit definitions"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target limit value"
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit"
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_parametric_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parametric test measurement KPIs tracking electrical parameter compliance, defect detection, and measurement quality"
  source: "`vibe_semiconductors_v1`.`test`.`parametric_measurement`"
  dimensions:
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Measurement date for daily trending"
    - name: "measurement_week"
      expr: DATE_TRUNC('week', measurement_timestamp)
      comment: "Measurement week for weekly trending"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Measurement month for monthly trending"
    - name: "parameter_name"
      expr: parameter_name
      comment: "Electrical parameter being measured"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of parametric measurement"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Measurement completion status"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail result of measurement"
    - name: "measurement_location"
      expr: measurement_location
      comment: "Physical location of measurement"
    - name: "measurement_mode"
      expr: measurement_mode
      comment: "Measurement mode (inline, offline, correlation)"
    - name: "measurement_quality_flag"
      expr: measurement_quality_flag
      comment: "Quality flag for measurement validity"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of parametric measurements taken"
    - name: "total_pass_measurements"
      expr: SUM(CASE WHEN pass_fail_flag = true THEN 1 ELSE 0 END)
      comment: "Total measurements passing specification limits"
    - name: "total_fail_measurements"
      expr: SUM(CASE WHEN pass_fail_flag = false THEN 1 ELSE 0 END)
      comment: "Total measurements failing specification limits"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all measurements"
    - name: "avg_measurement_std_dev"
      expr: AVG(CAST(measurement_std_dev AS DOUBLE))
      comment: "Average standard deviation of measurements"
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty"
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit"
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit"
    - name: "distinct_parameters_measured"
      expr: COUNT(DISTINCT parameter_name)
      comment: "Number of unique parameters measured"
    - name: "flagged_measurements"
      expr: SUM(CASE WHEN measurement_flagged = true THEN 1 ELSE 0 END)
      comment: "Number of measurements flagged for review"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_probe_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Probe card asset KPIs tracking utilization, maintenance cycles, and probe card lifecycle for wafer probe operations"
  source: "`vibe_semiconductors_v1`.`test`.`probe_card`"
  dimensions:
    - name: "last_maintenance_date"
      expr: DATE_TRUNC('day', last_maintenance_date)
      comment: "Last maintenance date"
    - name: "last_maintenance_month"
      expr: DATE_TRUNC('month', last_maintenance_date)
      comment: "Last maintenance month"
    - name: "qualification_date"
      expr: DATE_TRUNC('day', qualification_date)
      comment: "Probe card qualification date"
    - name: "probe_card_status"
      expr: probe_card_status
      comment: "Probe card operational status"
    - name: "card_status"
      expr: card_status
      comment: "Card status"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status"
    - name: "probe_card_type"
      expr: probe_card_type
      comment: "Type of probe card (cantilever, vertical, MEMS)"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Probe card manufacturer"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for probe card"
  measures:
    - name: "total_probe_cards"
      expr: COUNT(1)
      comment: "Total number of probe cards in inventory"
    - name: "total_touchdown_count"
      expr: SUM(CAST(touchdown_count AS DOUBLE))
      comment: "Total touchdowns across all probe cards"
    - name: "avg_touchdown_count"
      expr: AVG(CAST(touchdown_count AS DOUBLE))
      comment: "Average touchdown count per probe card"
    - name: "avg_usage_hours"
      expr: AVG(CAST(usage_hours AS DOUBLE))
      comment: "Average usage hours per probe card"
    - name: "avg_contact_resistance_ohm"
      expr: AVG(CAST(contact_resistance_ohm AS DOUBLE))
      comment: "Average contact resistance in ohms"
    - name: "avg_planarity_um"
      expr: AVG(CAST(planarity_um AS DOUBLE))
      comment: "Average planarity in micrometers"
    - name: "avg_pitch_um"
      expr: AVG(CAST(pitch_um AS DOUBLE))
      comment: "Average probe pitch in micrometers"
    - name: "total_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total probe card inventory cost in USD"
    - name: "avg_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average probe card cost in USD"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_reliability_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability test KPIs tracking stress test effectiveness, failure rates, and qualification status for product reliability"
  source: "`vibe_semiconductors_v1`.`test`.`reliability_test_run`"
  dimensions:
    - name: "test_start_date"
      expr: DATE_TRUNC('day', test_start_timestamp)
      comment: "Reliability test start date"
    - name: "test_start_week"
      expr: DATE_TRUNC('week', test_start_timestamp)
      comment: "Reliability test start week"
    - name: "test_start_month"
      expr: DATE_TRUNC('month', test_start_timestamp)
      comment: "Reliability test start month"
    - name: "test_type"
      expr: test_type
      comment: "Type of reliability test (HTOL, HAST, TC, etc.)"
    - name: "stress_type"
      expr: stress_type
      comment: "Type of stress applied (thermal, voltage, humidity)"
    - name: "stress_mode"
      expr: stress_mode
      comment: "Stress mode configuration"
    - name: "test_status"
      expr: test_status
      comment: "Test completion status"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Product qualification status"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Industry standard for reliability (JEDEC, AEC, etc.)"
    - name: "test_location"
      expr: test_location
      comment: "Physical location of reliability test"
  measures:
    - name: "total_reliability_runs"
      expr: COUNT(1)
      comment: "Total number of reliability test runs executed"
    - name: "avg_acceleration_factor"
      expr: AVG(CAST(acceleration_factor AS DOUBLE))
      comment: "Average acceleration factor for stress testing"
    - name: "avg_stress_temperature_c"
      expr: AVG(CAST(stress_temperature_c AS DOUBLE))
      comment: "Average stress temperature in Celsius"
    - name: "avg_stress_voltage_v"
      expr: AVG(CAST(stress_voltage_v AS DOUBLE))
      comment: "Average stress voltage in volts"
    - name: "avg_stress_humidity_percent"
      expr: AVG(CAST(stress_humidity_percent AS DOUBLE))
      comment: "Average stress humidity percentage"
    - name: "avg_test_failure_rate_percent"
      expr: AVG(CAST(test_failure_rate_percent AS DOUBLE))
      comment: "Average failure rate percentage during reliability test"
    - name: "avg_pre_stress_yield_percent"
      expr: AVG(CAST(pre_stress_yield_percent AS DOUBLE))
      comment: "Average yield before stress testing"
    - name: "avg_post_stress_yield_percent"
      expr: AVG(CAST(post_stress_yield_percent AS DOUBLE))
      comment: "Average yield after stress testing"
    - name: "avg_screen_effectiveness_percent"
      expr: AVG(CAST(screen_effectiveness_percent AS DOUBLE))
      comment: "Average screening effectiveness percentage"
    - name: "avg_infant_mortality_rate"
      expr: AVG(CAST(infant_mortality_rate AS DOUBLE))
      comment: "Average infant mortality rate detected"
    - name: "avg_temperature_ramp_rate"
      expr: AVG(CAST(temperature_ramp_rate_c_per_min AS DOUBLE))
      comment: "Average temperature ramp rate in Celsius per minute"
    - name: "avg_voltage_ramp_rate"
      expr: AVG(CAST(voltage_ramp_rate_v_per_sec AS DOUBLE))
      comment: "Average voltage ramp rate in volts per second"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test program KPIs tracking program coverage, validation status, and program lifecycle for test engineering"
  source: "`vibe_semiconductors_v1`.`test`.`test_program`"
  dimensions:
    - name: "release_date"
      expr: DATE_TRUNC('day', release_date)
      comment: "Test program release date"
    - name: "release_month"
      expr: DATE_TRUNC('month', release_date)
      comment: "Test program release month"
    - name: "approval_date"
      expr: DATE_TRUNC('day', approval_date)
      comment: "Test program approval date"
    - name: "test_program_status"
      expr: test_program_status
      comment: "Test program lifecycle status"
    - name: "validation_status"
      expr: validation_status
      comment: "Test program validation status"
    - name: "program_category"
      expr: program_category
      comment: "Test program category (production, engineering, qualification)"
    - name: "test_type"
      expr: test_type
      comment: "Type of test (functional, parametric, structural)"
    - name: "ate_platform"
      expr: ate_platform
      comment: "ATE platform for test program"
    - name: "target_device_family"
      expr: target_device_family
      comment: "Target device family for test program"
    - name: "is_deprecated"
      expr: is_deprecated
      comment: "Whether test program is deprecated"
  measures:
    - name: "total_test_programs"
      expr: COUNT(1)
      comment: "Total number of test programs"
    - name: "active_test_programs"
      expr: SUM(CASE WHEN is_deprecated = false THEN 1 ELSE 0 END)
      comment: "Number of active (non-deprecated) test programs"
    - name: "deprecated_test_programs"
      expr: SUM(CASE WHEN is_deprecated = true THEN 1 ELSE 0 END)
      comment: "Number of deprecated test programs"
    - name: "avg_actual_coverage_percent"
      expr: AVG(CAST(actual_coverage_percent AS DOUBLE))
      comment: "Average actual test coverage percentage achieved"
    - name: "avg_coverage_target_percent"
      expr: AVG(CAST(coverage_target_percent AS DOUBLE))
      comment: "Average target test coverage percentage"
    - name: "distinct_target_devices"
      expr: COUNT(DISTINCT target_device_family)
      comment: "Number of unique device families covered"
    - name: "distinct_ate_platforms"
      expr: COUNT(DISTINCT ate_platform)
      comment: "Number of unique ATE platforms used"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_unit_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unit-level test result KPIs tracking individual die/unit pass/fail, bin distribution, and retest rates"
  source: "`vibe_semiconductors_v1`.`test`.`unit_test_result`"
  dimensions:
    - name: "test_date"
      expr: DATE_TRUNC('day', test_timestamp)
      comment: "Test date for daily trending"
    - name: "test_week"
      expr: DATE_TRUNC('week', test_timestamp)
      comment: "Test week for weekly trending"
    - name: "test_month"
      expr: DATE_TRUNC('month', test_timestamp)
      comment: "Test month for monthly trending"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail status of unit"
    - name: "hard_bin_code"
      expr: hard_bin_code
      comment: "Hardware bin code for unit disposition"
    - name: "soft_bin_code"
      expr: soft_bin_code
      comment: "Software bin code for failure analysis"
    - name: "test_stage"
      expr: test_stage
      comment: "Test stage (probe, final, burn-in)"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status"
    - name: "retest_indicator"
      expr: retest_indicator
      comment: "Whether unit was retested"
  measures:
    - name: "total_units_tested"
      expr: COUNT(1)
      comment: "Total number of units tested"
    - name: "total_units_passed"
      expr: SUM(CASE WHEN pass_fail_flag = true THEN 1 ELSE 0 END)
      comment: "Total units passing test"
    - name: "total_units_failed"
      expr: SUM(CASE WHEN pass_fail_flag = false THEN 1 ELSE 0 END)
      comment: "Total units failing test"
    - name: "total_retested_units"
      expr: SUM(CASE WHEN retest_indicator = true THEN 1 ELSE 0 END)
      comment: "Total units that were retested"
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
      comment: "Number of unique hardware bins observed"
    - name: "distinct_soft_bins"
      expr: COUNT(DISTINCT soft_bin_code)
      comment: "Number of unique software bins observed"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_wafer_probe_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer probe test KPIs tracking die yield, gross die, and probe efficiency at wafer level"
  source: "`vibe_semiconductors_v1`.`test`.`wafer_probe_run`"
  dimensions:
    - name: "probe_date"
      expr: DATE_TRUNC('day', run_timestamp)
      comment: "Probe run date for daily trending"
    - name: "probe_week"
      expr: DATE_TRUNC('week', run_timestamp)
      comment: "Probe run week for weekly trending"
    - name: "probe_month"
      expr: DATE_TRUNC('month', run_timestamp)
      comment: "Probe run month for monthly trending"
    - name: "run_status"
      expr: run_status
      comment: "Probe run completion status"
    - name: "wafer_probe_run_status"
      expr: wafer_probe_run_status
      comment: "Overall wafer probe run status"
    - name: "ate_configuration"
      expr: ate_configuration
      comment: "ATE configuration used for probe"
    - name: "insertion_number"
      expr: insertion_number
      comment: "Test insertion sequence number"
  measures:
    - name: "total_probe_runs"
      expr: COUNT(1)
      comment: "Total number of wafer probe runs executed"
    - name: "total_gross_die"
      expr: SUM(CAST(gross_die_count AS DOUBLE))
      comment: "Total gross die count across all wafers"
    - name: "total_good_die"
      expr: SUM(CAST(good_die_count AS DOUBLE))
      comment: "Total good die passing probe test"
    - name: "total_fail_die"
      expr: SUM(CAST(fail_die_count AS DOUBLE))
      comment: "Total die failing probe test"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average wafer probe yield percentage"
    - name: "avg_contact_yield_percent"
      expr: AVG(CAST(contact_yield_percent AS DOUBLE))
      comment: "Average probe contact yield percentage"
    - name: "avg_test_coverage_percent"
      expr: AVG(CAST(test_coverage_percent AS DOUBLE))
      comment: "Average test coverage percentage at probe"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius"
    - name: "distinct_wafers_probed"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of unique wafers probed"
    - name: "distinct_lots_probed"
      expr: COUNT(DISTINCT wafer_lot_number)
      comment: "Number of unique wafer lots probed"
$$;
