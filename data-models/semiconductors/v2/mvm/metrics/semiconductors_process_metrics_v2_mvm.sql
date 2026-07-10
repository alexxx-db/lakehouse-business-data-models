-- Metric views for domain: process | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 14:15:10

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_defect_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect Inspection Result business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`defect_inspection_result`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crystal Defect Count"
      expr: crystal_defect_count
    - name: "Defect Map File Format"
      expr: defect_map_file_format
    - name: "Defect Map File Path"
      expr: defect_map_file_path
    - name: "Defect Size Bin Large Count"
      expr: defect_size_bin_large_count
    - name: "Defect Size Bin Medium Count"
      expr: defect_size_bin_medium_count
    - name: "Defect Size Bin Small Count"
      expr: defect_size_bin_small_count
    - name: "Disposition"
      expr: disposition
    - name: "Excursion Detected"
      expr: excursion_detected
    - name: "Inspection Mode"
      expr: inspection_mode
    - name: "Inspection Status"
      expr: inspection_status
    - name: "Inspection Timestamp"
      expr: inspection_timestamp
    - name: "Inspection Type"
      expr: inspection_type
    - name: "Killer Defect Count"
      expr: killer_defect_count
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Layer Name"
      expr: layer_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Defect Inspection Result"
      expr: COUNT(DISTINCT defect_inspection_result_id)
    - name: "Total Defect Density Per Cm2"
      expr: SUM(defect_density_per_cm2)
    - name: "Average Defect Density Per Cm2"
      expr: AVG(defect_density_per_cm2)
    - name: "Total Inspected Area Cm2"
      expr: SUM(inspected_area_cm2)
    - name: "Average Inspected Area Cm2"
      expr: AVG(inspected_area_cm2)
    - name: "Total Inspection At Step"
      expr: SUM(inspection_at_step)
    - name: "Average Inspection At Step"
      expr: AVG(inspection_at_step)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_excursion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Excursion business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`excursion`"
  dimensions:
    - name: "Affected Die Count"
      expr: affected_die_count
    - name: "Affected Lot Count"
      expr: affected_lot_count
    - name: "Affected Wafer Count"
      expr: affected_wafer_count
    - name: "Containment Action Taken"
      expr: containment_action_taken
    - name: "Containment Timestamp"
      expr: containment_timestamp
    - name: "Corrective Action Reference"
      expr: corrective_action_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Required"
      expr: customer_notification_required
    - name: "Customer Notification Timestamp"
      expr: customer_notification_timestamp
    - name: "Detection Source"
      expr: detection_source
    - name: "Detection Timestamp"
      expr: detection_timestamp
    - name: "Disposition"
      expr: disposition
    - name: "Disposition Timestamp"
      expr: disposition_timestamp
    - name: "Excursion Number"
      expr: excursion_number
    - name: "Excursion Type"
      expr: excursion_type
    - name: "Investigation Status"
      expr: investigation_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Excursion"
      expr: COUNT(DISTINCT excursion_id)
    - name: "Total Defect Density Per Cm2"
      expr: SUM(defect_density_per_cm2)
    - name: "Average Defect Density Per Cm2"
      expr: AVG(defect_density_per_cm2)
    - name: "Total Estimated Financial Impact Usd"
      expr: SUM(estimated_financial_impact_usd)
    - name: "Average Estimated Financial Impact Usd"
      expr: AVG(estimated_financial_impact_usd)
    - name: "Total Estimated Yield Impact Percent"
      expr: SUM(estimated_yield_impact_percent)
    - name: "Average Estimated Yield Impact Percent"
      expr: AVG(estimated_yield_impact_percent)
    - name: "Total Lower Control Limit"
      expr: SUM(lower_control_limit)
    - name: "Average Lower Control Limit"
      expr: AVG(lower_control_limit)
    - name: "Total Measured Value"
      expr: SUM(measured_value)
    - name: "Average Measured Value"
      expr: AVG(measured_value)
    - name: "Total Specification Lower Limit"
      expr: SUM(specification_lower_limit)
    - name: "Average Specification Lower Limit"
      expr: AVG(specification_lower_limit)
    - name: "Total Specification Upper Limit"
      expr: SUM(specification_upper_limit)
    - name: "Average Specification Upper Limit"
      expr: AVG(specification_upper_limit)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Upper Control Limit"
      expr: SUM(upper_control_limit)
    - name: "Average Upper Control Limit"
      expr: AVG(upper_control_limit)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flow business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`flow`"
  dimensions:
    - name: "Beol Step Count"
      expr: beol_step_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Layer Count"
      expr: critical_layer_count
    - name: "Device Family"
      expr: device_family
    - name: "Dfm Rule Set Version"
      expr: dfm_rule_set_version
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Euv Layer Count"
      expr: euv_layer_count
    - name: "Fab Site Code"
      expr: fab_site_code
    - name: "Feol Step Count"
      expr: feol_step_count
    - name: "Flow Type"
      expr: flow_type
    - name: "Is Baseline Flow"
      expr: is_baseline_flow
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lithography Layer Count"
      expr: lithography_layer_count
    - name: "Metal Layer Count"
      expr: metal_layer_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Flow"
      expr: COUNT(DISTINCT flow_id)
    - name: "Total Baseline Cpk"
      expr: SUM(baseline_cpk)
    - name: "Average Baseline Cpk"
      expr: AVG(baseline_cpk)
    - name: "Total Cycle Time Days"
      expr: SUM(cycle_time_days)
    - name: "Average Cycle Time Days"
      expr: AVG(cycle_time_days)
    - name: "Total For Node"
      expr: SUM(for_node)
    - name: "Average For Node"
      expr: AVG(for_node)
    - name: "Total Target Yield Percent"
      expr: SUM(target_yield_percent)
    - name: "Average Target Yield Percent"
      expr: AVG(target_yield_percent)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_lot_process_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot Process Run business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`lot_process_run`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Control Chart Rule Violated"
      expr: control_chart_rule_violated
    - name: "Control Chart Violation Flag"
      expr: control_chart_violation_flag
    - name: "Defect Count"
      expr: defect_count
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Lot Disposition"
      expr: lot_disposition
    - name: "Measurement Site Count"
      expr: measurement_site_count
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Process Duration Seconds"
      expr: process_duration_seconds
    - name: "Process Notes"
      expr: process_notes
    - name: "Process Qualification Status"
      expr: process_qualification_status
    - name: "Recipe Version"
      expr: recipe_version
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Rework Count"
      expr: rework_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lot Process Run"
      expr: COUNT(DISTINCT lot_process_run_id)
    - name: "Total Defect Density Per Cm2"
      expr: SUM(defect_density_per_cm2)
    - name: "Average Defect Density Per Cm2"
      expr: AVG(defect_density_per_cm2)
    - name: "Total Measurement Result Value"
      expr: SUM(measurement_result_value)
    - name: "Average Measurement Result Value"
      expr: AVG(measurement_result_value)
    - name: "Total Process Gas Flow Sccm"
      expr: SUM(process_gas_flow_sccm)
    - name: "Average Process Gas Flow Sccm"
      expr: AVG(process_gas_flow_sccm)
    - name: "Total Process Power Watts"
      expr: SUM(process_power_watts)
    - name: "Average Process Power Watts"
      expr: AVG(process_power_watts)
    - name: "Total Process Pressure Torr"
      expr: SUM(process_pressure_torr)
    - name: "Average Process Pressure Torr"
      expr: AVG(process_pressure_torr)
    - name: "Total Process Temperature C"
      expr: SUM(process_temperature_c)
    - name: "Average Process Temperature C"
      expr: AVG(process_temperature_c)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_metrology_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrology Measurement business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`metrology_measurement`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Disposition"
      expr: disposition
    - name: "Fab Site Code"
      expr: fab_site_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Layer Name"
      expr: layer_name
    - name: "Measurement Mode"
      expr: measurement_mode
    - name: "Measurement Parameter"
      expr: measurement_parameter
    - name: "Measurement Status"
      expr: measurement_status
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "Measurement Type"
      expr: measurement_type
    - name: "Notes"
      expr: notes
    - name: "Site Count"
      expr: site_count
    - name: "Spc Rule Violation"
      expr: spc_rule_violation
    - name: "Unit Of Measure"
      expr: unit_of_measure
    - name: "Wafer Slot Number"
      expr: wafer_slot_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Metrology Measurement"
      expr: COUNT(DISTINCT metrology_measurement_id)
    - name: "Total Cp Value"
      expr: SUM(cp_value)
    - name: "Average Cp Value"
      expr: AVG(cp_value)
    - name: "Total Cpk Value"
      expr: SUM(cpk_value)
    - name: "Average Cpk Value"
      expr: AVG(cpk_value)
    - name: "Total Lower Control Limit"
      expr: SUM(lower_control_limit)
    - name: "Average Lower Control Limit"
      expr: AVG(lower_control_limit)
    - name: "Total Lower Spec Limit"
      expr: SUM(lower_spec_limit)
    - name: "Average Lower Spec Limit"
      expr: AVG(lower_spec_limit)
    - name: "Total Max Value"
      expr: SUM(max_value)
    - name: "Average Max Value"
      expr: AVG(max_value)
    - name: "Total Mean Value"
      expr: SUM(mean_value)
    - name: "Average Mean Value"
      expr: AVG(mean_value)
    - name: "Total Median Value"
      expr: SUM(median_value)
    - name: "Average Median Value"
      expr: AVG(median_value)
    - name: "Total Min Value"
      expr: SUM(min_value)
    - name: "Average Min Value"
      expr: AVG(min_value)
    - name: "Total Range Value"
      expr: SUM(range_value)
    - name: "Average Range Value"
      expr: AVG(range_value)
    - name: "Total Std Deviation"
      expr: SUM(std_deviation)
    - name: "Average Std Deviation"
      expr: AVG(std_deviation)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Three Sigma"
      expr: SUM(three_sigma)
    - name: "Average Three Sigma"
      expr: AVG(three_sigma)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qualification business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`qualification`"
  dimensions:
    - name: "Acceptance Criteria Summary"
      expr: acceptance_criteria_summary
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Corrective Action Plan"
      expr: corrective_action_plan
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Approval Status"
      expr: customer_approval_status
    - name: "Disposition"
      expr: disposition
    - name: "Fab Site Code"
      expr: fab_site_code
    - name: "Failure Mode Summary"
      expr: failure_mode_summary
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lot Count"
      expr: lot_count
    - name: "Notes"
      expr: notes
    - name: "Owner Engineer Name"
      expr: owner_engineer_name
    - name: "Owner Organization"
      expr: owner_organization
    - name: "Plan Reference"
      expr: plan_reference
    - name: "Plm System Source"
      expr: plm_system_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Qualification"
      expr: COUNT(DISTINCT qualification_id)
    - name: "Total Actual Cpk"
      expr: SUM(actual_cpk)
    - name: "Average Actual Cpk"
      expr: AVG(actual_cpk)
    - name: "Total Actual Yield Percent"
      expr: SUM(actual_yield_percent)
    - name: "Average Actual Yield Percent"
      expr: AVG(actual_yield_percent)
    - name: "Total Target Cpk"
      expr: SUM(target_cpk)
    - name: "Average Target Cpk"
      expr: AVG(target_cpk)
    - name: "Total Target Yield Percent"
      expr: SUM(target_yield_percent)
    - name: "Average Target Yield Percent"
      expr: AVG(target_yield_percent)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`recipe`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Chamber Configuration"
      expr: chamber_configuration
    - name: "Cmp Pad Type"
      expr: cmp_pad_type
    - name: "Cmp Slurry Type"
      expr: cmp_slurry_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deposition Method"
      expr: deposition_method
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Etch Chemistry"
      expr: etch_chemistry
    - name: "Etch Type"
      expr: etch_type
    - name: "Implant Species"
      expr: implant_species
    - name: "Litho Illumination Mode"
      expr: litho_illumination_mode
    - name: "Litho Scanner Model"
      expr: litho_scanner_model
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Process Type"
      expr: process_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Recipe"
      expr: COUNT(DISTINCT recipe_id)
    - name: "Total Cmp Platen Pressure Psi"
      expr: SUM(cmp_platen_pressure_psi)
    - name: "Average Cmp Platen Pressure Psi"
      expr: AVG(cmp_platen_pressure_psi)
    - name: "Total Cmp Removal Target Nm"
      expr: SUM(cmp_removal_target_nm)
    - name: "Average Cmp Removal Target Nm"
      expr: AVG(cmp_removal_target_nm)
    - name: "Total Cmp Table Speed Rpm"
      expr: SUM(cmp_table_speed_rpm)
    - name: "Average Cmp Table Speed Rpm"
      expr: AVG(cmp_table_speed_rpm)
    - name: "Total Deposition Pressure Torr"
      expr: SUM(deposition_pressure_torr)
    - name: "Average Deposition Pressure Torr"
      expr: AVG(deposition_pressure_torr)
    - name: "Total Deposition Rf Power W"
      expr: SUM(deposition_rf_power_w)
    - name: "Average Deposition Rf Power W"
      expr: AVG(deposition_rf_power_w)
    - name: "Total Deposition Target Thickness Nm"
      expr: SUM(deposition_target_thickness_nm)
    - name: "Average Deposition Target Thickness Nm"
      expr: AVG(deposition_target_thickness_nm)
    - name: "Total Deposition Temperature C"
      expr: SUM(deposition_temperature_c)
    - name: "Average Deposition Temperature C"
      expr: AVG(deposition_temperature_c)
    - name: "Total Etch Pressure Mtorr"
      expr: SUM(etch_pressure_mtorr)
    - name: "Average Etch Pressure Mtorr"
      expr: AVG(etch_pressure_mtorr)
    - name: "Total Etch Rf Bias Power W"
      expr: SUM(etch_rf_bias_power_w)
    - name: "Average Etch Rf Bias Power W"
      expr: AVG(etch_rf_bias_power_w)
    - name: "Total Etch Rf Source Power W"
      expr: SUM(etch_rf_source_power_w)
    - name: "Average Etch Rf Source Power W"
      expr: AVG(etch_rf_source_power_w)
    - name: "Total Etch Selectivity Ratio"
      expr: SUM(etch_selectivity_ratio)
    - name: "Average Etch Selectivity Ratio"
      expr: AVG(etch_selectivity_ratio)
    - name: "Total Implant Dose Cm2"
      expr: SUM(implant_dose_cm2)
    - name: "Average Implant Dose Cm2"
      expr: AVG(implant_dose_cm2)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_spc_control_chart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spc Control Chart business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`spc_control_chart`"
  dimensions:
    - name: "Baseline Data Points"
      expr: baseline_data_points
    - name: "Chart Activation Date"
      expr: chart_activation_date
    - name: "Chart Name"
      expr: chart_name
    - name: "Chart Owner"
      expr: chart_owner
    - name: "Chart Retirement Date"
      expr: chart_retirement_date
    - name: "Chart Status"
      expr: chart_status
    - name: "Chart Type"
      expr: chart_type
    - name: "Control Limit Calculation Method"
      expr: control_limit_calculation_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Last Limit Revision Date"
      expr: last_limit_revision_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Measurement Sequence Number"
      expr: measurement_sequence_number
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "Monitored Parameter Name"
      expr: monitored_parameter_name
    - name: "Ocap Reference Number"
      expr: ocap_reference_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Spc Control Chart"
      expr: COUNT(DISTINCT spc_control_chart_id)
    - name: "Total Lower Control Limit"
      expr: SUM(lower_control_limit)
    - name: "Average Lower Control Limit"
      expr: AVG(lower_control_limit)
    - name: "Total Lower Warning Limit"
      expr: SUM(lower_warning_limit)
    - name: "Average Lower Warning Limit"
      expr: AVG(lower_warning_limit)
    - name: "Total Measured Value"
      expr: SUM(measured_value)
    - name: "Average Measured Value"
      expr: AVG(measured_value)
    - name: "Total Process Capability Index Cp"
      expr: SUM(process_capability_index_cp)
    - name: "Average Process Capability Index Cp"
      expr: AVG(process_capability_index_cp)
    - name: "Total Process Capability Index Cpk"
      expr: SUM(process_capability_index_cpk)
    - name: "Average Process Capability Index Cpk"
      expr: AVG(process_capability_index_cpk)
    - name: "Total Site X Coordinate"
      expr: SUM(site_x_coordinate)
    - name: "Average Site X Coordinate"
      expr: AVG(site_x_coordinate)
    - name: "Total Site Y Coordinate"
      expr: SUM(site_y_coordinate)
    - name: "Average Site Y Coordinate"
      expr: AVG(site_y_coordinate)
    - name: "Total Specification Lower Limit"
      expr: SUM(specification_lower_limit)
    - name: "Average Specification Lower Limit"
      expr: AVG(specification_lower_limit)
    - name: "Total Specification Upper Limit"
      expr: SUM(specification_upper_limit)
    - name: "Average Specification Upper Limit"
      expr: AVG(specification_upper_limit)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Upper Control Limit"
      expr: SUM(upper_control_limit)
    - name: "Average Upper Control Limit"
      expr: AVG(upper_control_limit)
    - name: "Total Upper Warning Limit"
      expr: SUM(upper_warning_limit)
    - name: "Average Upper Warning Limit"
      expr: AVG(upper_warning_limit)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_spc_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spc Measurement business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`spc_measurement`"
  dimensions:
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Measurement Status"
      expr: measurement_status
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "Measurement Type"
      expr: measurement_type
    - name: "Out Of Control Flag"
      expr: out_of_control_flag
    - name: "Out Of Spec Flag"
      expr: out_of_spec_flag
    - name: "Parameter Code"
      expr: parameter_code
    - name: "Parameter Name"
      expr: parameter_name
    - name: "Process Action Taken"
      expr: process_action_taken
    - name: "Rule Violation Flags"
      expr: rule_violation_flags
    - name: "Site Number"
      expr: site_number
    - name: "Unit Of Measure"
      expr: unit_of_measure
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Measurement Timestamp Month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Spc Measurement"
      expr: COUNT(DISTINCT spc_measurement_id)
    - name: "Total Control Limit Lower"
      expr: SUM(control_limit_lower)
    - name: "Average Control Limit Lower"
      expr: AVG(control_limit_lower)
    - name: "Total Control Limit Upper"
      expr: SUM(control_limit_upper)
    - name: "Average Control Limit Upper"
      expr: AVG(control_limit_upper)
    - name: "Total Deviation From Target"
      expr: SUM(deviation_from_target)
    - name: "Average Deviation From Target"
      expr: AVG(deviation_from_target)
    - name: "Total Measured Value"
      expr: SUM(measured_value)
    - name: "Average Measured Value"
      expr: AVG(measured_value)
    - name: "Total Measurement On Chart"
      expr: SUM(measurement_on_chart)
    - name: "Average Measurement On Chart"
      expr: AVG(measurement_on_chart)
    - name: "Total Sigma Level"
      expr: SUM(sigma_level)
    - name: "Average Sigma Level"
      expr: AVG(sigma_level)
    - name: "Total Site X Coordinate"
      expr: SUM(site_x_coordinate)
    - name: "Average Site X Coordinate"
      expr: AVG(site_x_coordinate)
    - name: "Total Site Y Coordinate"
      expr: SUM(site_y_coordinate)
    - name: "Average Site Y Coordinate"
      expr: AVG(site_y_coordinate)
    - name: "Total Specification Limit Lower"
      expr: SUM(specification_limit_lower)
    - name: "Average Specification Limit Lower"
      expr: AVG(specification_limit_lower)
    - name: "Total Specification Limit Upper"
      expr: SUM(specification_limit_upper)
    - name: "Average Specification Limit Upper"
      expr: AVG(specification_limit_upper)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_step`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Step business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`step`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Critical Step"
      expr: is_critical_step
    - name: "Is Rework Allowed"
      expr: is_rework_allowed
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Operation Type"
      expr: operation_type
    - name: "Process Category"
      expr: process_category
    - name: "Qualification Date"
      expr: qualification_date
    - name: "Qualification Status"
      expr: qualification_status
    - name: "Sequence Order"
      expr: sequence_order
    - name: "Step Number"
      expr: step_number
    - name: "Step Status"
      expr: step_status
    - name: "Target Layer"
      expr: target_layer
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Step"
      expr: COUNT(DISTINCT step_id)
    - name: "Total Cycle Time Target Minutes"
      expr: SUM(cycle_time_target_minutes)
    - name: "Average Cycle Time Target Minutes"
      expr: AVG(cycle_time_target_minutes)
    - name: "Total Dose Target"
      expr: SUM(dose_target)
    - name: "Average Dose Target"
      expr: AVG(dose_target)
    - name: "Total Energy Target Kev"
      expr: SUM(energy_target_kev)
    - name: "Average Energy Target Kev"
      expr: AVG(energy_target_kev)
    - name: "Total Gas Flow Rate Sccm"
      expr: SUM(gas_flow_rate_sccm)
    - name: "Average Gas Flow Rate Sccm"
      expr: AVG(gas_flow_rate_sccm)
    - name: "Total Meef Value"
      expr: SUM(meef_value)
    - name: "Average Meef Value"
      expr: AVG(meef_value)
    - name: "Total Power Setpoint Watts"
      expr: SUM(power_setpoint_watts)
    - name: "Average Power Setpoint Watts"
      expr: AVG(power_setpoint_watts)
    - name: "Total Pressure Setpoint Torr"
      expr: SUM(pressure_setpoint_torr)
    - name: "Average Pressure Setpoint Torr"
      expr: AVG(pressure_setpoint_torr)
    - name: "Total Process Time Seconds"
      expr: SUM(process_time_seconds)
    - name: "Average Process Time Seconds"
      expr: AVG(process_time_seconds)
    - name: "Total Target Cd Nm"
      expr: SUM(target_cd_nm)
    - name: "Average Target Cd Nm"
      expr: AVG(target_cd_nm)
    - name: "Total Target Thickness Angstrom"
      expr: SUM(target_thickness_angstrom)
    - name: "Average Target Thickness Angstrom"
      expr: AVG(target_thickness_angstrom)
    - name: "Total Temperature Setpoint Celsius"
      expr: SUM(temperature_setpoint_celsius)
    - name: "Average Temperature Setpoint Celsius"
      expr: AVG(temperature_setpoint_celsius)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_yield_loss_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield Loss Event business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`yield_loss_event`"
  dimensions:
    - name: "Affected Die Count"
      expr: affected_die_count
    - name: "Assigned To"
      expr: assigned_to
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Defect Type"
      expr: defect_type
    - name: "Detection Method"
      expr: detection_method
    - name: "Disposition Action"
      expr: disposition_action
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Fab Site Code"
      expr: fab_site_code
    - name: "Investigation Start Timestamp"
      expr: investigation_start_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Layer Name"
      expr: layer_name
    - name: "Lot Hold Applied"
      expr: lot_hold_applied
    - name: "Notes"
      expr: notes
    - name: "Reported By"
      expr: reported_by
    - name: "Resolution Status"
      expr: resolution_status
    - name: "Resolution Timestamp"
      expr: resolution_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Yield Loss Event"
      expr: COUNT(DISTINCT yield_loss_event_id)
    - name: "Total Cpk Value"
      expr: SUM(cpk_value)
    - name: "Average Cpk Value"
      expr: AVG(cpk_value)
    - name: "Total Defect Density Per Cm2"
      expr: SUM(defect_density_per_cm2)
    - name: "Average Defect Density Per Cm2"
      expr: AVG(defect_density_per_cm2)
    - name: "Total Defect Size Nm"
      expr: SUM(defect_size_nm)
    - name: "Average Defect Size Nm"
      expr: AVG(defect_size_nm)
    - name: "Total Estimated Yield Impact Percent"
      expr: SUM(estimated_yield_impact_percent)
    - name: "Average Estimated Yield Impact Percent"
      expr: AVG(estimated_yield_impact_percent)
    - name: "Total Wafer Position X Mm"
      expr: SUM(wafer_position_x_mm)
    - name: "Average Wafer Position X Mm"
      expr: AVG(wafer_position_x_mm)
    - name: "Total Wafer Position Y Mm"
      expr: SUM(wafer_position_y_mm)
    - name: "Average Wafer Position Y Mm"
      expr: AVG(wafer_position_y_mm)
$$;