-- Metric views for domain: test | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 14:15:10

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_ate_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ate Configuration business metrics"
  source: "`vibe_semiconductors_v1`.`test`.`ate_configuration`"
  dimensions:
    - name: "Bin Mapping Version"
      expr: bin_mapping_version
    - name: "Calibration Due Date"
      expr: calibration_due_date
    - name: "Calibration Status"
      expr: calibration_status
    - name: "Change Reason"
      expr: change_reason
    - name: "Compliance Ear Status"
      expr: compliance_ear_status
    - name: "Compliance Itar Status"
      expr: compliance_itar_status
    - name: "Configuration Code"
      expr: configuration_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Hardware Revision"
      expr: hardware_revision
    - name: "Instrument Resource Allocation"
      expr: instrument_resource_allocation
    - name: "Last Calibration Timestamp"
      expr: last_calibration_timestamp
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Load Board Qualification Status"
      expr: load_board_qualification_status
    - name: "Load Board Revision"
      expr: load_board_revision
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ate Configuration"
      expr: COUNT(DISTINCT ate_configuration_id)
    - name: "Total Test Coverage Percentage"
      expr: SUM(test_coverage_percentage)
    - name: "Average Test Coverage Percentage"
      expr: AVG(test_coverage_percentage)
    - name: "Total Test Yield Target Percentage"
      expr: SUM(test_yield_target_percentage)
    - name: "Average Test Yield Target Percentage"
      expr: AVG(test_yield_target_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_bin_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bin Definition business metrics"
  source: "`vibe_semiconductors_v1`.`test`.`bin_definition`"
  dimensions:
    - name: "Bin Category"
      expr: bin_category
    - name: "Bin Code"
      expr: bin_code
    - name: "Bin Definition Status"
      expr: bin_definition_status
    - name: "Bin Name"
      expr: bin_name
    - name: "Bin Sort Order"
      expr: bin_sort_order
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Family"
      expr: device_family
    - name: "Disposition Rule"
      expr: disposition_rule
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Failure Mode"
      expr: failure_mode
    - name: "Is Default"
      expr: is_default
    - name: "Parameter Set"
      expr: parameter_set
    - name: "Test Level"
      expr: test_level
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bin Definition"
      expr: COUNT(DISTINCT bin_definition_id)
    - name: "Total Bin Number"
      expr: SUM(bin_number)
    - name: "Average Bin Number"
      expr: AVG(bin_number)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_final_test_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Final Test Run business metrics"
  source: "`vibe_semiconductors_v1`.`test`.`final_test_run`"
  dimensions:
    - name: "Ate Name"
      expr: ate_name
    - name: "Bin Distribution"
      expr: bin_distribution
    - name: "Boot Success Count"
      expr: boot_success_count
    - name: "Comments"
      expr: comments
    - name: "Defect Code"
      expr: defect_code
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Fail Count"
      expr: fail_count
    - name: "Final Test Run Status"
      expr: final_test_run_status
    - name: "Handler Name"
      expr: handler_name
    - name: "Parametric Test Fail"
      expr: parametric_test_fail
    - name: "Parametric Test Pass"
      expr: parametric_test_pass
    - name: "Pass Count"
      expr: pass_count
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Slt Board Code"
      expr: slt_board_code
    - name: "Socket Code"
      expr: socket_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Final Test Run"
      expr: COUNT(DISTINCT final_test_run_id)
    - name: "Total Power Consumption Mw"
      expr: SUM(power_consumption_mw)
    - name: "Average Power Consumption Mw"
      expr: AVG(power_consumption_mw)
    - name: "Total Test Temperature C"
      expr: SUM(test_temperature_c)
    - name: "Average Test Temperature C"
      expr: AVG(test_temperature_c)
    - name: "Total Test Time Seconds"
      expr: SUM(test_time_seconds)
    - name: "Average Test Time Seconds"
      expr: AVG(test_time_seconds)
    - name: "Total Yield Percent"
      expr: SUM(yield_percent)
    - name: "Average Yield Percent"
      expr: AVG(yield_percent)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Limit business metrics"
  source: "`vibe_semiconductors_v1`.`test`.`limit`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Audit Trail"
      expr: audit_trail
    - name: "Change Reason"
      expr: change_reason
    - name: "Compliance Standard"
      expr: compliance_standard
    - name: "Created By Department"
      expr: created_by_department
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Device Type"
      expr: device_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Measurement Type"
      expr: measurement_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Limit"
      expr: COUNT(DISTINCT limit_id)
    - name: "Total Lower Spec Limit"
      expr: SUM(lower_spec_limit)
    - name: "Average Lower Spec Limit"
      expr: AVG(lower_spec_limit)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Tolerance Percent"
      expr: SUM(tolerance_percent)
    - name: "Average Tolerance Percent"
      expr: AVG(tolerance_percent)
    - name: "Total Upper Spec Limit"
      expr: SUM(upper_spec_limit)
    - name: "Average Upper Spec Limit"
      expr: AVG(upper_spec_limit)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_parametric_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parametric Measurement business metrics"
  source: "`vibe_semiconductors_v1`.`test`.`parametric_measurement`"
  dimensions:
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Measurement Comment"
      expr: measurement_comment
    - name: "Measurement Flagged"
      expr: measurement_flagged
    - name: "Measurement Location"
      expr: measurement_location
    - name: "Measurement Mode"
      expr: measurement_mode
    - name: "Measurement Quality Flag"
      expr: measurement_quality_flag
    - name: "Measurement Repeat Count"
      expr: measurement_repeat_count
    - name: "Measurement Review Status"
      expr: measurement_review_status
    - name: "Measurement Review Timestamp"
      expr: measurement_review_timestamp
    - name: "Measurement Sequence"
      expr: measurement_sequence
    - name: "Measurement Source"
      expr: measurement_source
    - name: "Measurement Status"
      expr: measurement_status
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "Measurement Tool Version"
      expr: measurement_tool_version
    - name: "Measurement Type"
      expr: measurement_type
    - name: "Pass Fail Status"
      expr: pass_fail_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Parametric Measurement"
      expr: COUNT(DISTINCT parametric_measurement_id)
    - name: "Total Lower Spec Limit"
      expr: SUM(lower_spec_limit)
    - name: "Average Lower Spec Limit"
      expr: AVG(lower_spec_limit)
    - name: "Total Measured Value"
      expr: SUM(measured_value)
    - name: "Average Measured Value"
      expr: AVG(measured_value)
    - name: "Total Measurement Average Value"
      expr: SUM(measurement_average_value)
    - name: "Average Measurement Average Value"
      expr: AVG(measurement_average_value)
    - name: "Total Measurement Condition Frequency Mhz"
      expr: SUM(measurement_condition_frequency_mhz)
    - name: "Average Measurement Condition Frequency Mhz"
      expr: AVG(measurement_condition_frequency_mhz)
    - name: "Total Measurement Condition Temperature C"
      expr: SUM(measurement_condition_temperature_c)
    - name: "Average Measurement Condition Temperature C"
      expr: AVG(measurement_condition_temperature_c)
    - name: "Total Measurement Condition Voltage Mv"
      expr: SUM(measurement_condition_voltage_mv)
    - name: "Average Measurement Condition Voltage Mv"
      expr: AVG(measurement_condition_voltage_mv)
    - name: "Total Measurement Std Dev"
      expr: SUM(measurement_std_dev)
    - name: "Average Measurement Std Dev"
      expr: AVG(measurement_std_dev)
    - name: "Total Measurement Uncertainty"
      expr: SUM(measurement_uncertainty)
    - name: "Average Measurement Uncertainty"
      expr: AVG(measurement_uncertainty)
    - name: "Total Upper Spec Limit"
      expr: SUM(upper_spec_limit)
    - name: "Average Upper Spec Limit"
      expr: AVG(upper_spec_limit)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_probe_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Probe Card business metrics"
  source: "`vibe_semiconductors_v1`.`test`.`probe_card`"
  dimensions:
    - name: "Card Name"
      expr: card_name
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Die Site Layout"
      expr: die_site_layout
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Last Used Timestamp"
      expr: last_used_timestamp
    - name: "Maintenance Cycle Months"
      expr: maintenance_cycle_months
    - name: "Manufacturer"
      expr: manufacturer
    - name: "Needle Count"
      expr: needle_count
    - name: "Needle Replacements"
      expr: needle_replacements
    - name: "Next Maintenance Due"
      expr: next_maintenance_due
    - name: "Notes"
      expr: notes
    - name: "Probe Card Status"
      expr: probe_card_status
    - name: "Probe Card Type"
      expr: probe_card_type
    - name: "Qualification Date"
      expr: qualification_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Probe Card"
      expr: COUNT(DISTINCT probe_card_id)
    - name: "Total Contact Resistance Ohm"
      expr: SUM(contact_resistance_ohm)
    - name: "Average Contact Resistance Ohm"
      expr: AVG(contact_resistance_ohm)
    - name: "Total Cost Usd"
      expr: SUM(cost_usd)
    - name: "Average Cost Usd"
      expr: AVG(cost_usd)
    - name: "Total Pitch Um"
      expr: SUM(pitch_um)
    - name: "Average Pitch Um"
      expr: AVG(pitch_um)
    - name: "Total Usage Hours"
      expr: SUM(usage_hours)
    - name: "Average Usage Hours"
      expr: AVG(usage_hours)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program business metrics"
  source: "`vibe_semiconductors_v1`.`test`.`program`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Ate Platform"
      expr: ate_platform
    - name: "Atpg Tool"
      expr: atpg_tool
    - name: "Bin Mapping Reference"
      expr: bin_mapping_reference
    - name: "Change Description"
      expr: change_description
    - name: "Correlation Study Reference"
      expr: correlation_study_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deprecation Date"
      expr: deprecation_date
    - name: "Impact Assessment"
      expr: impact_assessment
    - name: "Is Deprecated"
      expr: is_deprecated
    - name: "Owner"
      expr: owner
    - name: "Parametric Test Data Reference"
      expr: parametric_test_data_reference
    - name: "Release Date"
      expr: release_date
    - name: "Target Device"
      expr: target_device
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program"
      expr: COUNT(DISTINCT program_id)
    - name: "Total Actual Coverage Percent"
      expr: SUM(actual_coverage_percent)
    - name: "Average Actual Coverage Percent"
      expr: AVG(actual_coverage_percent)
    - name: "Total Coverage Target Percent"
      expr: SUM(coverage_target_percent)
    - name: "Average Coverage Target Percent"
      expr: AVG(coverage_target_percent)
    - name: "Total Test Limit Value"
      expr: SUM(test_limit_value)
    - name: "Average Test Limit Value"
      expr: AVG(test_limit_value)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_unit_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unit Test Result business metrics"
  source: "`vibe_semiconductors_v1`.`test`.`unit_test_result`"
  dimensions:
    - name: "Assembly Position"
      expr: assembly_position
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Serial Number"
      expr: device_serial_number
    - name: "Hard Bin Code"
      expr: hard_bin_code
    - name: "Kgd Status"
      expr: kgd_status
    - name: "Measurement Summary"
      expr: measurement_summary
    - name: "Measurement Units"
      expr: measurement_units
    - name: "Parametric Flags"
      expr: parametric_flags
    - name: "Pass Fail"
      expr: pass_fail
    - name: "Retest Count"
      expr: retest_count
    - name: "Retest Indicator"
      expr: retest_indicator
    - name: "Soft Bin Code"
      expr: soft_bin_code
    - name: "Test Condition"
      expr: test_condition
    - name: "Test Result Comment"
      expr: test_result_comment
    - name: "Test Result Version"
      expr: test_result_version
    - name: "Test Stage"
      expr: test_stage
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Unit Test Result"
      expr: COUNT(DISTINCT unit_test_result_id)
    - name: "Total Test Temperature C"
      expr: SUM(test_temperature_c)
    - name: "Average Test Temperature C"
      expr: AVG(test_temperature_c)
    - name: "Total Test Time Seconds"
      expr: SUM(test_time_seconds)
    - name: "Average Test Time Seconds"
      expr: AVG(test_time_seconds)
    - name: "Total Test Voltage V"
      expr: SUM(test_voltage_v)
    - name: "Average Test Voltage V"
      expr: AVG(test_voltage_v)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`test_wafer_probe_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer Probe Run business metrics"
  source: "`vibe_semiconductors_v1`.`test`.`wafer_probe_run`"
  dimensions:
    - name: "Ate Configuration"
      expr: ate_configuration
    - name: "Bin Map Version"
      expr: bin_map_version
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Fail Die Count"
      expr: fail_die_count
    - name: "Gross Die Count"
      expr: gross_die_count
    - name: "Parametric Test Data Available"
      expr: parametric_test_data_available
    - name: "Pass Die Count"
      expr: pass_die_count
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Remarks"
      expr: remarks
    - name: "Run Number"
      expr: run_number
    - name: "Start Timestamp"
      expr: start_timestamp
    - name: "Total Die Count"
      expr: total_die_count
    - name: "Wafer Probe Run Status"
      expr: wafer_probe_run_status
    - name: "Wafer Sequence Number"
      expr: wafer_sequence_number
    - name: "End Timestamp Month"
      expr: DATE_TRUNC('MONTH', end_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Wafer Probe Run"
      expr: COUNT(DISTINCT wafer_probe_run_id)
    - name: "Total Contact Yield Percent"
      expr: SUM(contact_yield_percent)
    - name: "Average Contact Yield Percent"
      expr: AVG(contact_yield_percent)
    - name: "Total Test Coverage Percent"
      expr: SUM(test_coverage_percent)
    - name: "Average Test Coverage Percent"
      expr: AVG(test_coverage_percent)
$$;