-- Metric views for domain: test | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for test program portfolio management: coverage attainment, deprecation rate, and program health across technology nodes and product families. Used by test engineering leadership to govern program lifecycle and resource allocation."
  source: "`vibe_semiconductors_v1`.`test`.`test_program`"
  dimensions:
    - name: "test_program_status"
      expr: test_program_status
      comment: "Lifecycle status of the test program (active, deprecated, in-development) for portfolio segmentation."
    - name: "program_category"
      expr: program_category
      comment: "Category of the test program (wafer probe, final test, reliability, etc.) for workload classification."
    - name: "test_type"
      expr: test_type
      comment: "Type of test executed by the program (parametric, functional, reliability) for coverage analysis."
    - name: "ate_platform"
      expr: ate_platform
      comment: "ATE hardware platform targeted by the program, used to assess platform utilization and migration needs."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation state of the test program (validated, pending, failed) for release readiness tracking."
    - name: "is_deprecated"
      expr: is_deprecated
      comment: "Flag indicating whether the program has been deprecated, used to filter active vs. retired programs."
    - name: "release_date_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month of program release for trend analysis of new program introductions."
  measures:
    - name: "total_test_programs"
      expr: COUNT(1)
      comment: "Total number of test programs in the portfolio. Baseline KPI for portfolio size governance."
    - name: "avg_actual_coverage_percent"
      expr: AVG(CAST(actual_coverage_percent AS DOUBLE))
      comment: "Average actual fault coverage percentage across all test programs. A key quality KPI — low coverage signals escape risk and drives re-investment in test content."
    - name: "avg_coverage_target_percent"
      expr: AVG(CAST(coverage_target_percent AS DOUBLE))
      comment: "Average target fault coverage percentage set for test programs. Compared against actual coverage to identify programs missing their quality gates."
    - name: "avg_test_limit_value"
      expr: AVG(CAST(test_limit_value AS DOUBLE))
      comment: "Average test limit value across programs, used to benchmark parametric tightness and guard-band strategy."
    - name: "deprecated_program_count"
      expr: COUNT(CASE WHEN is_deprecated = TRUE THEN 1 END)
      comment: "Count of deprecated test programs. High values indicate technical debt and potential maintenance burden on legacy platforms."
    - name: "coverage_attainment_rate"
      expr: ROUND(100.0 * AVG(CAST(actual_coverage_percent AS DOUBLE)) / NULLIF(AVG(CAST(coverage_target_percent AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to target fault coverage expressed as a percentage. The primary test quality KPI — values below 95% trigger engineering escalation and re-tapeout risk assessment."
    - name: "distinct_ic_products_covered"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC products covered by test programs. Measures breadth of test coverage across the product catalog."
    - name: "distinct_technology_nodes_covered"
      expr: COUNT(DISTINCT fabrication_technology_node_id)
      comment: "Number of distinct fabrication technology nodes for which test programs exist. Indicates test infrastructure readiness across the process node roadmap."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_wafer_probe_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and yield KPIs for wafer probe runs. Used by fab operations, test engineering, and yield management teams to monitor probe yield trends, contact quality, and throughput at the wafer level."
  source: "`vibe_semiconductors_v1`.`test`.`wafer_probe_run`"
  dimensions:
    - name: "wafer_probe_run_status"
      expr: wafer_probe_run_status
      comment: "Status of the wafer probe run (completed, aborted, in-progress) for operational filtering."
    - name: "run_start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the probe run started, used for yield trend analysis over time."
    - name: "parametric_test_data_available"
      expr: parametric_test_data_available
      comment: "Flag indicating whether parametric test data was captured during the run, used to assess data completeness."
  measures:
    - name: "total_probe_runs"
      expr: COUNT(1)
      comment: "Total number of wafer probe runs executed. Baseline throughput KPI for test operations capacity planning."
    - name: "avg_test_coverage_percent"
      expr: AVG(CAST(test_coverage_percent AS DOUBLE))
      comment: "Average fault coverage percentage achieved across wafer probe runs. Directly tied to outgoing quality and escape risk."
    - name: "avg_contact_yield_percent"
      expr: AVG(CAST(contact_yield_percent AS DOUBLE))
      comment: "Average probe contact yield percentage. Low contact yield indicates probe card degradation or handler alignment issues, driving maintenance decisions."
    - name: "distinct_wafer_lots_probed"
      expr: COUNT(DISTINCT inventory_wafer_lot_id)
      comment: "Number of distinct wafer lots processed through probe. Measures throughput breadth and lot coverage completeness."
    - name: "distinct_ic_products_probed"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC catalog products probed. Used to assess product mix and ATE configuration utilization."
    - name: "distinct_probe_cards_used"
      expr: COUNT(DISTINCT probe_card_id)
      comment: "Number of distinct probe cards used across runs. High counts relative to run volume may indicate excessive card rotation or qualification gaps."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_final_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Final test yield, throughput, and efficiency KPIs. Used by test operations, product engineering, and quality teams to monitor outgoing product quality, test time efficiency, and yield performance at the final test stage."
  source: "`vibe_semiconductors_v1`.`test`.`final_test_run`"
  dimensions:
    - name: "final_test_run_status"
      expr: final_test_run_status
      comment: "Status of the final test run (pass, fail, aborted) for yield and quality segmentation."
    - name: "test_type"
      expr: test_type
      comment: "Type of final test performed (functional, parametric, burn-in) for workload classification."
    - name: "test_result"
      expr: test_result
      comment: "Overall test result (pass/fail) for yield rate calculation and quality reporting."
    - name: "test_shift"
      expr: test_shift
      comment: "Production shift during which the test run occurred, used to identify shift-level yield variation."
    - name: "test_start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the final test run started, used for yield trend analysis over time."
    - name: "test_location"
      expr: test_location
      comment: "Physical location where final test was performed, used for site-level performance benchmarking."
  measures:
    - name: "total_final_test_runs"
      expr: COUNT(1)
      comment: "Total number of final test runs executed. Baseline throughput KPI for final test capacity planning."
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average final test yield percentage. The primary outgoing quality KPI — directly impacts revenue, customer satisfaction, and cost of poor quality."
    - name: "avg_test_time_seconds"
      expr: AVG(CAST(test_time_seconds AS DOUBLE))
      comment: "Average test time per run in seconds. A key cost efficiency KPI — reducing test time directly lowers cost-of-test and improves throughput."
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption during final test in milliwatts. Used to monitor device power compliance and identify outlier units for reliability risk."
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius across final test runs. Deviations from target temperature correlate with yield loss and are monitored for process control."
    - name: "distinct_products_tested"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC products that went through final test. Measures product mix breadth and test floor utilization."
    - name: "distinct_wafer_lots_tested"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of distinct fabrication wafer lots processed through final test. Tracks lot throughput and cycle time exposure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_unit_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unit-level test result KPIs for die/device disposition analysis. Used by yield engineering, quality, and product teams to analyze pass/fail distributions, retest rates, and KGD status at the individual unit level."
  source: "`vibe_semiconductors_v1`.`test`.`unit_test_result`"
  dimensions:
    - name: "pass_fail"
      expr: pass_fail
      comment: "Pass or fail disposition of the unit test result. Primary dimension for yield analysis."
    - name: "test_stage"
      expr: test_stage
      comment: "Stage of test at which the result was recorded (wafer probe, final test, burn-in) for stage-level yield decomposition."
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status of the unit. Critical for KGD supply chain decisions and advanced packaging qualification."
    - name: "hard_bin_code"
      expr: hard_bin_code
      comment: "Hard bin assignment for the unit. Used to analyze failure mode distribution and drive test content optimization."
    - name: "soft_bin_code"
      expr: soft_bin_code
      comment: "Soft bin assignment providing finer failure categorization. Used for parametric yield loss analysis."
    - name: "retest_indicator"
      expr: retest_indicator
      comment: "Flag indicating whether this result is from a retest. Used to calculate retest rate and assess test escape risk."
    - name: "test_timestamp_month"
      expr: DATE_TRUNC('MONTH', test_timestamp)
      comment: "Month of test execution for yield trend analysis over time."
  measures:
    - name: "total_units_tested"
      expr: COUNT(1)
      comment: "Total number of units tested. Baseline throughput KPI for test operations volume tracking."
    - name: "pass_unit_count"
      expr: COUNT(CASE WHEN pass_fail = 'PASS' THEN 1 END)
      comment: "Count of units that passed test. Used to compute yield and track outgoing quality volume."
    - name: "fail_unit_count"
      expr: COUNT(CASE WHEN pass_fail = 'FAIL' THEN 1 END)
      comment: "Count of units that failed test. Drives failure mode analysis and corrective action prioritization."
    - name: "retest_unit_count"
      expr: COUNT(CASE WHEN retest_indicator = TRUE THEN 1 END)
      comment: "Count of units that were retested. High retest rates indicate test instability or marginal devices requiring engineering investigation."
    - name: "avg_test_time_seconds"
      expr: AVG(CAST(test_time_seconds AS DOUBLE))
      comment: "Average test time per unit in seconds. Key cost-of-test efficiency metric — directly impacts test floor throughput and unit economics."
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature per unit in Celsius. Deviations from spec temperature correlate with yield loss and reliability risk."
    - name: "avg_test_voltage_v"
      expr: AVG(CAST(test_voltage_v AS DOUBLE))
      comment: "Average test voltage per unit in volts. Used to monitor parametric test conditions and identify voltage-related yield loss."
    - name: "distinct_wafers_tested"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of distinct wafers represented in unit test results. Used to assess wafer-level yield coverage and lot completeness."
    - name: "kgd_unit_count"
      expr: COUNT(CASE WHEN kgd_status = 'KGD' THEN 1 END)
      comment: "Count of units achieving Known Good Die status. Critical supply KPI for advanced packaging and chiplet programs."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_parametric_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parametric test measurement KPIs for process control and product quality. Used by process engineers, yield engineers, and quality teams to monitor measurement distributions, spec compliance, and parametric yield loss."
  source: "`vibe_semiconductors_v1`.`test`.`parametric_measurement`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of parametric measurement (voltage, current, frequency, etc.) for parameter-level analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail status of the parametric measurement against its specification limit."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement record (valid, suspect, invalidated) for data quality filtering."
    - name: "measurement_mode"
      expr: measurement_mode
      comment: "Mode under which the measurement was taken (DC, AC, functional) for test condition segmentation."
    - name: "measurement_flagged"
      expr: measurement_flagged
      comment: "Flag indicating the measurement was flagged for review. Used to track data quality issues and outlier rates."
    - name: "measurement_timestamp_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement for parametric trend analysis and SPC monitoring."
    - name: "test_parameter_name"
      expr: test_parameter_name
      comment: "Name of the parametric test parameter being measured. Primary grouping dimension for parameter-level yield analysis."
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of parametric measurements recorded. Baseline volume KPI for test data completeness assessment."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured parametric value. Used for process centering analysis and SPC monitoring — deviations from target trigger process engineering review."
    - name: "avg_measurement_std_dev"
      expr: AVG(CAST(measurement_std_dev AS DOUBLE))
      comment: "Average standard deviation of parametric measurements. Measures process variability — high std dev indicates process instability and drives yield loss investigation."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across parametric tests. Used to assess gauge R&R quality and calibration adequacy of test equipment."
    - name: "flagged_measurement_count"
      expr: COUNT(CASE WHEN measurement_flagged = TRUE THEN 1 END)
      comment: "Count of measurements flagged for review. High flagged counts indicate test instability or process excursions requiring immediate engineering response."
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit across parametric measurements. Used to benchmark guard-band tightness and spec alignment across product families."
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit across parametric measurements. Paired with upper spec limit to assess specification window width and test margin."
    - name: "distinct_products_measured"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC products with parametric measurements. Measures parametric test coverage breadth across the product catalog."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_reliability_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability qualification KPIs for stress testing and product qualification. Used by reliability engineering, quality, and product teams to monitor qualification pass rates, failure rates, and stress test effectiveness for JEDEC and customer qualification programs."
  source: "`vibe_semiconductors_v1`.`test`.`reliability_test_run`"
  dimensions:
    - name: "test_status"
      expr: test_status
      comment: "Status of the reliability test run (pass, fail, in-progress, aborted) for qualification tracking."
    - name: "test_type"
      expr: test_type
      comment: "Type of reliability stress test (HTOL, HAST, ESD, latch-up, etc.) for qualification program segmentation."
    - name: "stress_mode"
      expr: stress_mode
      comment: "Stress mode applied during the reliability test (temperature, voltage, humidity, combined) for failure mechanism analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification outcome status (qualified, conditionally qualified, failed) for product release decision support."
    - name: "test_start_month"
      expr: DATE_TRUNC('MONTH', test_start_timestamp)
      comment: "Month the reliability test started, used for qualification cycle time and throughput trend analysis."
    - name: "test_location"
      expr: test_location
      comment: "Physical location where reliability testing was performed, used for site-level capability benchmarking."
  measures:
    - name: "total_reliability_runs"
      expr: COUNT(1)
      comment: "Total number of reliability test runs executed. Baseline KPI for qualification throughput and lab utilization."
    - name: "avg_test_failure_rate_percent"
      expr: AVG(CAST(test_failure_rate_percent AS DOUBLE))
      comment: "Average failure rate percentage across reliability test runs. The primary reliability quality KPI — high failure rates block product qualification and customer shipments."
    - name: "avg_infant_mortality_rate"
      expr: AVG(CAST(infant_mortality_rate AS DOUBLE))
      comment: "Average infant mortality rate across reliability runs. Elevated infant mortality indicates latent defects that escape to customers, driving burn-in screening decisions."
    - name: "avg_pre_stress_yield_percent"
      expr: AVG(CAST(pre_stress_yield_percent AS DOUBLE))
      comment: "Average yield percentage before stress application. Baseline yield for stress delta calculation."
    - name: "avg_post_stress_yield_percent"
      expr: AVG(CAST(post_stress_yield_percent AS DOUBLE))
      comment: "Average yield percentage after stress application. Compared to pre-stress yield to quantify stress-induced degradation."
    - name: "avg_yield_improvement_percent"
      expr: AVG(CAST(test_yield_improvement_percent AS DOUBLE))
      comment: "Average yield improvement percentage achieved through reliability screening. Measures the effectiveness of burn-in and stress screening programs."
    - name: "avg_screen_effectiveness_percent"
      expr: AVG(CAST(screen_effectiveness_percent AS DOUBLE))
      comment: "Average screen effectiveness percentage. Quantifies how well the reliability screen removes defective units before customer shipment."
    - name: "avg_acceleration_factor"
      expr: AVG(CAST(acceleration_factor AS DOUBLE))
      comment: "Average acceleration factor applied in reliability tests. Used to validate that stress conditions adequately accelerate field failure mechanisms for qualification."
    - name: "avg_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average reliability test duration in hours. Used for lab scheduling, capacity planning, and cycle time optimization."
    - name: "distinct_products_qualified"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC products undergoing reliability qualification. Measures qualification pipeline breadth and new product introduction readiness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test coverage KPIs for DFT (Design for Test) effectiveness and fault coverage governance. Used by DFT engineers, test program managers, and product engineering to ensure adequate fault coverage before tapeout and production release."
  source: "`vibe_semiconductors_v1`.`test`.`coverage`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Status of the coverage record (approved, pending, rejected) for release gate tracking."
    - name: "coverage_category"
      expr: coverage_category
      comment: "Category of coverage measurement (stuck-at, transition, IDDQ, path delay) for DFT methodology analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type for which coverage was measured, used for product-level DFT benchmarking."
    - name: "is_approved"
      expr: is_approved
      comment: "Flag indicating whether the coverage record has been approved for tapeout release."
    - name: "tapeout_ready"
      expr: tapeout_ready
      comment: "Flag indicating whether the design is ready for tapeout based on coverage criteria. Critical gate for NPI cycle time."
    - name: "coverage_date_month"
      expr: DATE_TRUNC('MONTH', coverage_date)
      comment: "Month of coverage measurement for trend analysis of DFT improvement over design iterations."
  measures:
    - name: "total_coverage_records"
      expr: COUNT(1)
      comment: "Total number of coverage measurement records. Baseline KPI for DFT activity volume."
    - name: "avg_fault_coverage_percent"
      expr: AVG(CAST(fault_coverage_percent AS DOUBLE))
      comment: "Average overall fault coverage percentage. The primary DFT quality KPI — values below target block tapeout approval and increase escape risk."
    - name: "avg_stuck_at_fault_coverage_percent"
      expr: AVG(CAST(stuck_at_fault_coverage_percent AS DOUBLE))
      comment: "Average stuck-at fault coverage percentage. The foundational DFT metric required for all digital designs — industry standard target is 99%+."
    - name: "avg_transition_fault_coverage_percent"
      expr: AVG(CAST(transition_fault_coverage_percent AS DOUBLE))
      comment: "Average transition fault coverage percentage. Measures at-speed test quality — critical for high-frequency designs where timing faults dominate."
    - name: "avg_path_delay_coverage_percent"
      expr: AVG(CAST(path_delay_coverage_percent AS DOUBLE))
      comment: "Average path delay coverage percentage. Measures coverage of critical timing paths — low values indicate risk of speed-sort yield loss."
    - name: "avg_iddq_coverage_percent"
      expr: AVG(CAST(iddq_coverage_percent AS DOUBLE))
      comment: "Average IDDQ (quiescent current) coverage percentage. Used to detect bridging and leakage defects not caught by stuck-at patterns."
    - name: "avg_dft_structure_coverage_percent"
      expr: AVG(CAST(dft_structure_coverage_percent AS DOUBLE))
      comment: "Average DFT structure coverage percentage. Measures how well DFT structures (scan chains, BIST) cover the design — drives DFT architecture investment decisions."
    - name: "avg_yield_estimate_percent"
      expr: AVG(CAST(yield_estimate_percent AS DOUBLE))
      comment: "Average yield estimate percentage derived from coverage analysis. Used to project production yield before silicon is available, informing pricing and capacity planning."
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density across coverage records. A key process quality indicator — high defect density drives yield loss and cost-of-test escalation."
    - name: "tapeout_ready_count"
      expr: COUNT(CASE WHEN tapeout_ready = TRUE THEN 1 END)
      comment: "Count of designs meeting tapeout readiness criteria based on coverage. Tracks NPI pipeline health and release gate throughput."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_adaptive_test_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adaptive test flow KPIs for AI/ML-driven test optimization. Used by test engineering and operations leadership to monitor test time reduction, quality escape risk, and the effectiveness of adaptive test strategies in reducing cost-of-test."
  source: "`vibe_semiconductors_v1`.`test`.`adaptive_test_flow`"
  dimensions:
    - name: "adaptive_test_flow_status"
      expr: adaptive_test_flow_status
      comment: "Status of the adaptive test flow (active, deprecated, in-review) for portfolio management."
    - name: "flow_type"
      expr: flow_type
      comment: "Type of adaptive flow (skip-lot, limit-adjustment, sequence-optimization) for strategy classification."
    - name: "is_deprecated"
      expr: is_deprecated
      comment: "Flag indicating whether the adaptive flow has been deprecated, used to filter active strategies."
    - name: "limit_adjustment_strategy"
      expr: limit_adjustment_strategy
      comment: "Strategy used for adaptive limit adjustment, used to benchmark different optimization approaches."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the adaptive flow became effective, used for adoption trend analysis."
  measures:
    - name: "total_adaptive_flows"
      expr: COUNT(1)
      comment: "Total number of adaptive test flows defined. Measures the breadth of adaptive test strategy adoption."
    - name: "avg_test_time_reduction_target_percent"
      expr: AVG(CAST(test_time_reduction_target_percent AS DOUBLE))
      comment: "Average targeted test time reduction percentage across adaptive flows. Directly quantifies the cost-of-test savings potential of the adaptive test program."
    - name: "avg_quality_escape_risk_threshold"
      expr: AVG(CAST(quality_escape_risk_threshold AS DOUBLE))
      comment: "Average quality escape risk threshold set for adaptive flows. Monitors the risk tolerance of adaptive test strategies — critical for balancing cost reduction against outgoing quality."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across adaptive test flows. Used by test engineering leadership to prioritize risk mitigation for high-risk adaptive strategies."
    - name: "active_adaptive_flow_count"
      expr: COUNT(CASE WHEN is_deprecated = FALSE THEN 1 END)
      comment: "Count of currently active (non-deprecated) adaptive test flows. Measures the active footprint of adaptive test optimization in production."
    - name: "distinct_products_with_adaptive_flows"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct IC products with adaptive test flows deployed. Measures the product coverage of the adaptive test program."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_probe_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Probe card asset management and utilization KPIs. Used by test operations and equipment engineering to monitor probe card health, maintenance cycles, and cost efficiency of the probe card fleet."
  source: "`vibe_semiconductors_v1`.`test`.`probe_card`"
  dimensions:
    - name: "probe_card_status"
      expr: probe_card_status
      comment: "Current operational status of the probe card (active, in-maintenance, retired) for fleet availability tracking."
    - name: "probe_card_type"
      expr: probe_card_type
      comment: "Type of probe card (cantilever, vertical, MEMS) for technology segmentation and cost benchmarking."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the probe card (qualified, pending, failed) for release readiness tracking."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Probe card manufacturer for supplier performance benchmarking and sourcing decisions."
  measures:
    - name: "total_probe_cards"
      expr: COUNT(1)
      comment: "Total number of probe cards in the fleet. Baseline KPI for asset inventory management."
    - name: "avg_usage_hours"
      expr: AVG(CAST(usage_hours AS DOUBLE))
      comment: "Average usage hours per probe card. Used to assess fleet utilization and predict maintenance needs before contact degradation impacts yield."
    - name: "avg_contact_resistance_ohm"
      expr: AVG(CAST(contact_resistance_ohm AS DOUBLE))
      comment: "Average probe contact resistance in ohms. Rising contact resistance indicates needle wear and predicts yield loss — triggers preventive maintenance scheduling."
    - name: "avg_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average probe card cost in USD. Used for cost-of-test modeling and capital expenditure planning for probe card fleet renewal."
    - name: "total_fleet_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost of the probe card fleet in USD. Key capital asset KPI for test operations budget management."
    - name: "avg_pitch_um"
      expr: AVG(CAST(pitch_um AS DOUBLE))
      comment: "Average probe pitch in micrometers. Used to assess technology node compatibility and plan probe card upgrades for advanced node programs."
    - name: "cards_due_for_maintenance"
      expr: COUNT(CASE WHEN next_maintenance_due <= CURRENT_DATE() THEN 1 END)
      comment: "Count of probe cards with maintenance due today or overdue. Operational KPI that directly impacts test floor availability and yield risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_insertion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test insertion KPIs for cost-of-test and coverage optimization. Used by test engineering and operations to monitor insertion cost, coverage efficiency, and yield gate effectiveness across the manufacturing flow."
  source: "`vibe_semiconductors_v1`.`test`.`insertion`"
  dimensions:
    - name: "insertion_status"
      expr: insertion_status
      comment: "Status of the test insertion (active, inactive, deprecated) for operational filtering."
    - name: "insertion_type"
      expr: insertion_type
      comment: "Type of test insertion (wafer probe, final test, burn-in, SLT) for cost and coverage segmentation."
    - name: "ate_platform_type"
      expr: ate_platform_type
      comment: "ATE platform type used for this insertion, used for platform utilization and cost benchmarking."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Flag indicating whether the insertion is mandatory. Used to distinguish required vs. optional test steps for cost optimization analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the insertion became effective, used for trend analysis of test flow evolution."
  measures:
    - name: "total_insertions"
      expr: COUNT(1)
      comment: "Total number of test insertions defined in the manufacturing flow. Baseline KPI for test flow complexity."
    - name: "avg_cost_per_unit_usd"
      expr: AVG(CAST(cost_per_unit_usd AS DOUBLE))
      comment: "Average cost per unit for each test insertion in USD. The primary cost-of-test KPI — directly impacts product gross margin and drives test optimization investment decisions."
    - name: "total_cost_per_unit_usd"
      expr: SUM(CAST(cost_per_unit_usd AS DOUBLE))
      comment: "Total cost per unit across all insertions in USD. Represents the full cost-of-test stack — used for product cost modeling and margin analysis."
    - name: "avg_test_coverage_percent"
      expr: AVG(CAST(test_coverage_percent AS DOUBLE))
      comment: "Average test coverage percentage per insertion. Used to assess the coverage contribution of each insertion and identify low-value insertions for elimination."
    - name: "avg_yield_gate_criteria_percent"
      expr: AVG(CAST(yield_gate_criteria_percent AS DOUBLE))
      comment: "Average yield gate threshold percentage across insertions. Monitors the stringency of yield gates — gates set too low allow defective product to advance, increasing downstream cost."
    - name: "avg_max_temperature_c"
      expr: AVG(CAST(max_temperature_c AS DOUBLE))
      comment: "Average maximum test temperature in Celsius across insertions. Used to validate thermal stress conditions and ensure test environment compliance."
    - name: "mandatory_insertion_count"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END)
      comment: "Count of mandatory test insertions. Used to distinguish the non-negotiable test cost floor from optional insertions that can be optimized."
$$;