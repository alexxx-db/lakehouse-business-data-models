-- Metric views for domain: process | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_capability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capability business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`capability`"
  dimensions:
    - name: "Analysis Timestamp"
      expr: analysis_timestamp
    - name: "Assessment Method"
      expr: assessment_method
    - name: "Capability Status"
      expr: capability_status
    - name: "Comments"
      expr: comments
    - name: "Control Chart Type"
      expr: control_chart_type
    - name: "Corrective Action Required"
      expr: corrective_action_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Evaluation Period End Date"
      expr: evaluation_period_end_date
    - name: "Evaluation Period Start Date"
      expr: evaluation_period_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Measurement Method"
      expr: measurement_method
    - name: "Normality Test Result"
      expr: normality_test_result
    - name: "Out Of Control Points"
      expr: out_of_control_points
    - name: "Parameter Code"
      expr: parameter_code
    - name: "Parameter Name"
      expr: parameter_name
    - name: "Process Area"
      expr: process_area
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Capability"
      expr: COUNT(DISTINCT capability_id)
    - name: "Total Cp Index"
      expr: SUM(cp_index)
    - name: "Average Cp Index"
      expr: AVG(cp_index)
    - name: "Total Cpk Index"
      expr: SUM(cpk_index)
    - name: "Average Cpk Index"
      expr: AVG(cpk_index)
    - name: "Total Lower Specification Limit"
      expr: SUM(lower_specification_limit)
    - name: "Average Lower Specification Limit"
      expr: AVG(lower_specification_limit)
    - name: "Total Mean Value"
      expr: SUM(mean_value)
    - name: "Average Mean Value"
      expr: AVG(mean_value)
    - name: "Total Pp Index"
      expr: SUM(pp_index)
    - name: "Average Pp Index"
      expr: AVG(pp_index)
    - name: "Total Ppk Index"
      expr: SUM(ppk_index)
    - name: "Average Ppk Index"
      expr: AVG(ppk_index)
    - name: "Total Standard Deviation"
      expr: SUM(standard_deviation)
    - name: "Average Standard Deviation"
      expr: AVG(standard_deviation)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Upper Specification Limit"
      expr: SUM(upper_specification_limit)
    - name: "Average Upper Specification Limit"
      expr: AVG(upper_specification_limit)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_capability_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key capability quality metrics for process engineering leadership"
  source: "`vibe_semiconductors_v1`.`process`.`capability`"
  dimensions:
    - name: "process_area"
      expr: process_area
      comment: "High‑level process area (e.g., Front‑End, Back‑End)"
    - name: "process_layer"
      expr: process_layer
      comment: "Specific process layer within the area"
    - name: "product_family"
      expr: product_family
      comment: "Product family associated with the capability"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status of the capability"
    - name: "capability_status"
      expr: capability_status
      comment: "Operational status of the capability"
    - name: "control_chart_type"
      expr: control_chart_type
      comment: "Type of control chart used for monitoring"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the capability parameters"
    - name: "analysis_date"
      expr: DATE_TRUNC('day', analysis_timestamp)
      comment: "Date of the capability analysis"
  measures:
    - name: "total_capabilities"
      expr: COUNT(1)
      comment: "Total number of capability records captured"
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average Process Capability (Cp) index across capabilities"
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average Process Capability (Cpk) index across capabilities"
    - name: "avg_pp_index"
      expr: AVG(CAST(pp_index AS DOUBLE))
      comment: "Average Process Performance (Pp) index"
    - name: "avg_ppk_index"
      expr: AVG(CAST(ppk_index AS DOUBLE))
      comment: "Average Process Performance (Ppk) index"
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * AVG(CASE WHEN corrective_action_required THEN 1 ELSE 0 END), 2)
      comment: "Percentage of capabilities requiring corrective action"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_change_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change Notification business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`change_notification`"
  dimensions:
    - name: "Actual Implementation Date"
      expr: actual_implementation_date
    - name: "Affected Customer List"
      expr: affected_customer_list
    - name: "Affected Equipment List"
      expr: affected_equipment_list
    - name: "Affected Material List"
      expr: affected_material_list
    - name: "Affected Product List"
      expr: affected_product_list
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Attachments"
      expr: attachments
    - name: "Change Classification"
      expr: change_classification
    - name: "Change Description"
      expr: change_description
    - name: "Change Reason"
      expr: change_reason
    - name: "Change Status"
      expr: change_status
    - name: "Change Title"
      expr: change_title
    - name: "Change Type"
      expr: change_type
    - name: "Cooling Process Impact"
      expr: cooling_process_impact
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Change Notification"
      expr: COUNT(DISTINCT change_notification_id)
    - name: "Total Cycle Time Impact Hours"
      expr: SUM(cycle_time_impact_hours)
    - name: "Average Cycle Time Impact Hours"
      expr: AVG(cycle_time_impact_hours)
    - name: "Total Yield Impact Percent"
      expr: SUM(yield_impact_percent)
    - name: "Average Yield Impact Percent"
      expr: AVG(yield_impact_percent)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_cmp_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cmp Condition business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`cmp_condition`"
  dimensions:
    - name: "Cmp Step Type"
      expr: cmp_step_type
    - name: "Condition Code"
      expr: condition_code
    - name: "Condition Name"
      expr: condition_name
    - name: "Conditioner Type"
      expr: conditioner_type
    - name: "Conditioning Frequency"
      expr: conditioning_frequency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cmp Condition Description"
      expr: cmp_condition_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Endpoint Detection Method"
      expr: endpoint_detection_method
    - name: "Equipment Class"
      expr: equipment_class
    - name: "Fab Site Code"
      expr: fab_site_code
    - name: "Is Baseline Condition"
      expr: is_baseline_condition
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Owner Organization"
      expr: owner_organization
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cmp Condition"
      expr: COUNT(DISTINCT cmp_condition_id)
    - name: "Total Carrier Speed Rpm"
      expr: SUM(carrier_speed_rpm)
    - name: "Average Carrier Speed Rpm"
      expr: AVG(carrier_speed_rpm)
    - name: "Total Defect Density Spec Per Wafer"
      expr: SUM(defect_density_spec_per_wafer)
    - name: "Average Defect Density Spec Per Wafer"
      expr: AVG(defect_density_spec_per_wafer)
    - name: "Total Dishing Spec Angstrom"
      expr: SUM(dishing_spec_angstrom)
    - name: "Average Dishing Spec Angstrom"
      expr: AVG(dishing_spec_angstrom)
    - name: "Total Erosion Spec Angstrom"
      expr: SUM(erosion_spec_angstrom)
    - name: "Average Erosion Spec Angstrom"
      expr: AVG(erosion_spec_angstrom)
    - name: "Total Platen Pressure Psi"
      expr: SUM(platen_pressure_psi)
    - name: "Average Platen Pressure Psi"
      expr: AVG(platen_pressure_psi)
    - name: "Total Polish Time Seconds"
      expr: SUM(polish_time_seconds)
    - name: "Average Polish Time Seconds"
      expr: AVG(polish_time_seconds)
    - name: "Total Removal Rate Angstrom Per Min"
      expr: SUM(removal_rate_angstrom_per_min)
    - name: "Average Removal Rate Angstrom Per Min"
      expr: AVG(removal_rate_angstrom_per_min)
    - name: "Total Selectivity Ratio"
      expr: SUM(selectivity_ratio)
    - name: "Average Selectivity Ratio"
      expr: AVG(selectivity_ratio)
    - name: "Total Slurry Flow Rate Ml Per Min"
      expr: SUM(slurry_flow_rate_ml_per_min)
    - name: "Average Slurry Flow Rate Ml Per Min"
      expr: AVG(slurry_flow_rate_ml_per_min)
    - name: "Total Table Speed Rpm"
      expr: SUM(table_speed_rpm)
    - name: "Average Table Speed Rpm"
      expr: AVG(table_speed_rpm)
    - name: "Total Target Removal Amount Angstrom"
      expr: SUM(target_removal_amount_angstrom)
    - name: "Average Target Removal Amount Angstrom"
      expr: AVG(target_removal_amount_angstrom)
    - name: "Total Wafer To Wafer Uniformity Spec Percent"
      expr: SUM(wafer_to_wafer_uniformity_spec_percent)
    - name: "Average Wafer To Wafer Uniformity Spec Percent"
      expr: AVG(wafer_to_wafer_uniformity_spec_percent)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_cooling_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cooling Condition business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`cooling_condition`"
  dimensions:
    - name: "Condition Code"
      expr: condition_code
    - name: "Condition Name"
      expr: condition_name
    - name: "Cool Optimization Enabled"
      expr: cool_optimization_enabled
    - name: "Cool Optimization Mode"
      expr: cool_optimization_mode
    - name: "Cool Optimization Strategy"
      expr: cool_optimization_strategy
    - name: "Coolant Recirculation Flag"
      expr: coolant_recirculation_flag
    - name: "Coolant Type"
      expr: coolant_type
    - name: "Cooling Method"
      expr: cooling_method
    - name: "Created Date"
      expr: created_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cooling Condition Description"
      expr: cooling_condition_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Baseline Condition"
      expr: is_baseline_condition
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Model Lineage Source"
      expr: model_lineage_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cooling Condition"
      expr: COUNT(DISTINCT cooling_condition_id)
    - name: "Total Ambient Humidity Pct"
      expr: SUM(ambient_humidity_pct)
    - name: "Average Ambient Humidity Pct"
      expr: AVG(ambient_humidity_pct)
    - name: "Total Backside Helium Pressure Torr"
      expr: SUM(backside_helium_pressure_torr)
    - name: "Average Backside Helium Pressure Torr"
      expr: AVG(backside_helium_pressure_torr)
    - name: "Total Chamber Pressure Torr"
      expr: SUM(chamber_pressure_torr)
    - name: "Average Chamber Pressure Torr"
      expr: AVG(chamber_pressure_torr)
    - name: "Total Chiller Setpoint Celsius"
      expr: SUM(chiller_setpoint_celsius)
    - name: "Average Chiller Setpoint Celsius"
      expr: AVG(chiller_setpoint_celsius)
    - name: "Total Cool Optimization Target Percent"
      expr: SUM(cool_optimization_target_percent)
    - name: "Average Cool Optimization Target Percent"
      expr: AVG(cool_optimization_target_percent)
    - name: "Total Coolant Flow Rate"
      expr: SUM(coolant_flow_rate)
    - name: "Average Coolant Flow Rate"
      expr: AVG(coolant_flow_rate)
    - name: "Total Coolant Flow Rate Lpm"
      expr: SUM(coolant_flow_rate_lpm)
    - name: "Average Coolant Flow Rate Lpm"
      expr: AVG(coolant_flow_rate_lpm)
    - name: "Total Coolant Inlet Temperature Celsius"
      expr: SUM(coolant_inlet_temperature_celsius)
    - name: "Average Coolant Inlet Temperature Celsius"
      expr: AVG(coolant_inlet_temperature_celsius)
    - name: "Total Coolant Outlet Temperature Celsius"
      expr: SUM(coolant_outlet_temperature_celsius)
    - name: "Average Coolant Outlet Temperature Celsius"
      expr: AVG(coolant_outlet_temperature_celsius)
    - name: "Total Coolant Recovery Percent"
      expr: SUM(coolant_recovery_percent)
    - name: "Average Coolant Recovery Percent"
      expr: AVG(coolant_recovery_percent)
    - name: "Total Coolant Recycle Percent"
      expr: SUM(coolant_recycle_percent)
    - name: "Average Coolant Recycle Percent"
      expr: AVG(coolant_recycle_percent)
    - name: "Total Cooling Rate Celsius Per Minute"
      expr: SUM(cooling_rate_celsius_per_minute)
    - name: "Average Cooling Rate Celsius Per Minute"
      expr: AVG(cooling_rate_celsius_per_minute)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_cooling_process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cooling Process Flow business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`cooling_process_flow`"
  dimensions:
    - name: "Closed Loop Recirculation Flag"
      expr: closed_loop_recirculation_flag
    - name: "Cool Optimization Enabled"
      expr: cool_optimization_enabled
    - name: "Cool Optimization Mode"
      expr: cool_optimization_mode
    - name: "Cool Optimization Objective"
      expr: cool_optimization_objective
    - name: "Coolant Type"
      expr: coolant_type
    - name: "Cooling Stage Count"
      expr: cooling_stage_count
    - name: "Cooling Step Count"
      expr: cooling_step_count
    - name: "Cooling Strategy"
      expr: cooling_strategy
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Energy Efficiency Rating"
      expr: energy_efficiency_rating
    - name: "Flow Code"
      expr: flow_code
    - name: "Flow Description"
      expr: flow_description
    - name: "Flow Name"
      expr: flow_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cooling Process Flow"
      expr: COUNT(DISTINCT cooling_process_flow_id)
    - name: "Total Baseline Energy Consumption Kwh"
      expr: SUM(baseline_energy_consumption_kwh)
    - name: "Average Baseline Energy Consumption Kwh"
      expr: AVG(baseline_energy_consumption_kwh)
    - name: "Total Co2 Reduction Kg"
      expr: SUM(co2_reduction_kg)
    - name: "Average Co2 Reduction Kg"
      expr: AVG(co2_reduction_kg)
    - name: "Total Coolant Recovery Target Percent"
      expr: SUM(coolant_recovery_target_percent)
    - name: "Average Coolant Recovery Target Percent"
      expr: AVG(coolant_recovery_target_percent)
    - name: "Total Cycle Time Sec"
      expr: SUM(cycle_time_sec)
    - name: "Average Cycle Time Sec"
      expr: AVG(cycle_time_sec)
    - name: "Total Energy Efficiency Target Percent"
      expr: SUM(energy_efficiency_target_percent)
    - name: "Average Energy Efficiency Target Percent"
      expr: AVG(energy_efficiency_target_percent)
    - name: "Total Energy Savings Target Percent"
      expr: SUM(energy_savings_target_percent)
    - name: "Average Energy Savings Target Percent"
      expr: AVG(energy_savings_target_percent)
    - name: "Total Estimated Energy Savings Kwh"
      expr: SUM(estimated_energy_savings_kwh)
    - name: "Average Estimated Energy Savings Kwh"
      expr: AVG(estimated_energy_savings_kwh)
    - name: "Total Optimized Energy Consumption Kwh"
      expr: SUM(optimized_energy_consumption_kwh)
    - name: "Average Optimized Energy Consumption Kwh"
      expr: AVG(optimized_energy_consumption_kwh)
    - name: "Total Target Energy Savings Kwh"
      expr: SUM(target_energy_savings_kwh)
    - name: "Average Target Energy Savings Kwh"
      expr: AVG(target_energy_savings_kwh)
    - name: "Total Target Exit Temperature Celsius"
      expr: SUM(target_exit_temperature_celsius)
    - name: "Average Target Exit Temperature Celsius"
      expr: AVG(target_exit_temperature_celsius)
    - name: "Total Thermal Budget C Sec"
      expr: SUM(thermal_budget_c_sec)
    - name: "Average Thermal Budget C Sec"
      expr: AVG(thermal_budget_c_sec)
    - name: "Total Total Coolant Consumption Lpm"
      expr: SUM(total_coolant_consumption_lpm)
    - name: "Average Total Coolant Consumption Lpm"
      expr: AVG(total_coolant_consumption_lpm)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_defect_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and yield impact metrics from defect inspections"
  source: "`vibe_semiconductors_v1`.`process`.`defect_inspection_result`"
  dimensions:
    - name: "fab_tool_id"
      expr: fab_tool_id
      comment: "Identifier of the fab tool used for inspection"
    - name: "wafer_id"
      expr: wafer_id
      comment: "Wafer identifier inspected"
    - name: "inspection_date"
      expr: DATE_TRUNC('day', inspection_timestamp)
      comment: "Date of the inspection"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection (e.g., Completed, Pending)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed"
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer where inspection occurred"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of defect inspection records"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per cm² across inspections"
    - name: "avg_inspected_area"
      expr: AVG(CAST(inspected_area_cm2 AS DOUBLE))
      comment: "Average inspected area in cm²"
    - name: "excursion_rate_pct"
      expr: ROUND(100.0 * AVG(CASE WHEN excursion_detected THEN 1 ELSE 0 END), 2)
      comment: "Percentage of inspections where an excursion was detected"
$$;

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
    - name: "Total Spc Control Limit Lower"
      expr: SUM(spc_control_limit_lower)
    - name: "Average Spc Control Limit Lower"
      expr: AVG(spc_control_limit_lower)
    - name: "Total Spc Control Limit Upper"
      expr: SUM(spc_control_limit_upper)
    - name: "Average Spc Control Limit Upper"
      expr: AVG(spc_control_limit_upper)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_deposition_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deposition Condition business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`deposition_condition`"
  dimensions:
    - name: "Carrier Gas"
      expr: carrier_gas
    - name: "Chamber Configuration"
      expr: chamber_configuration
    - name: "Condition Code"
      expr: condition_code
    - name: "Condition Name"
      expr: condition_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deposition Method"
      expr: deposition_method
    - name: "Deposition Condition Description"
      expr: deposition_condition_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fab Site Code"
      expr: fab_site_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Owner Engineer Name"
      expr: owner_engineer_name
    - name: "Owner Organization"
      expr: owner_organization
    - name: "Precursor Gas 1"
      expr: precursor_gas_1
    - name: "Precursor Gas 2"
      expr: precursor_gas_2
    - name: "Process Category"
      expr: process_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Deposition Condition"
      expr: COUNT(DISTINCT deposition_condition_id)
    - name: "Total Carrier Gas Flow Rate Sccm"
      expr: SUM(carrier_gas_flow_rate_sccm)
    - name: "Average Carrier Gas Flow Rate Sccm"
      expr: AVG(carrier_gas_flow_rate_sccm)
    - name: "Total Deposition Pressure Torr"
      expr: SUM(deposition_pressure_torr)
    - name: "Average Deposition Pressure Torr"
      expr: AVG(deposition_pressure_torr)
    - name: "Total Deposition Rate Angstrom Per Minute"
      expr: SUM(deposition_rate_angstrom_per_minute)
    - name: "Average Deposition Rate Angstrom Per Minute"
      expr: AVG(deposition_rate_angstrom_per_minute)
    - name: "Total Deposition Temperature Celsius"
      expr: SUM(deposition_temperature_celsius)
    - name: "Average Deposition Temperature Celsius"
      expr: AVG(deposition_temperature_celsius)
    - name: "Total Deposition Time Seconds"
      expr: SUM(deposition_time_seconds)
    - name: "Average Deposition Time Seconds"
      expr: AVG(deposition_time_seconds)
    - name: "Total Film Stress Mpa"
      expr: SUM(film_stress_mpa)
    - name: "Average Film Stress Mpa"
      expr: AVG(film_stress_mpa)
    - name: "Total Precursor Gas 1 Flow Rate Sccm"
      expr: SUM(precursor_gas_1_flow_rate_sccm)
    - name: "Average Precursor Gas 1 Flow Rate Sccm"
      expr: AVG(precursor_gas_1_flow_rate_sccm)
    - name: "Total Precursor Gas 2 Flow Rate Sccm"
      expr: SUM(precursor_gas_2_flow_rate_sccm)
    - name: "Average Precursor Gas 2 Flow Rate Sccm"
      expr: AVG(precursor_gas_2_flow_rate_sccm)
    - name: "Total Process Capability Cpk"
      expr: SUM(process_capability_cpk)
    - name: "Average Process Capability Cpk"
      expr: AVG(process_capability_cpk)
    - name: "Total Refractive Index"
      expr: SUM(refractive_index)
    - name: "Average Refractive Index"
      expr: AVG(refractive_index)
    - name: "Total Rf Frequency Mhz"
      expr: SUM(rf_frequency_mhz)
    - name: "Average Rf Frequency Mhz"
      expr: AVG(rf_frequency_mhz)
    - name: "Total Rf Power Watts"
      expr: SUM(rf_power_watts)
    - name: "Average Rf Power Watts"
      expr: AVG(rf_power_watts)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_doe_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Doe Experiment business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`doe_experiment`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Actual Start Date"
      expr: actual_start_date
    - name: "Analysis Software"
      expr: analysis_software
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Blocking Factor"
      expr: blocking_factor
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Doe Type"
      expr: doe_type
    - name: "Experiment Number"
      expr: experiment_number
    - name: "Experiment Objective"
      expr: experiment_objective
    - name: "Experiment Status"
      expr: experiment_status
    - name: "Experiment Title"
      expr: experiment_title
    - name: "Fab Site Code"
      expr: fab_site_code
    - name: "Factor Count"
      expr: factor_count
    - name: "Factor Levels"
      expr: factor_levels
    - name: "Factor List"
      expr: factor_list
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Doe Experiment"
      expr: COUNT(DISTINCT doe_experiment_id)
    - name: "Total Baseline Cpk"
      expr: SUM(baseline_cpk)
    - name: "Average Baseline Cpk"
      expr: AVG(baseline_cpk)
    - name: "Total Post Doe Cpk"
      expr: SUM(post_doe_cpk)
    - name: "Average Post Doe Cpk"
      expr: AVG(post_doe_cpk)
    - name: "Total Yield Impact Percent"
      expr: SUM(yield_impact_percent)
    - name: "Average Yield Impact Percent"
      expr: AVG(yield_impact_percent)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_etch_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Etch Condition business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`etch_condition`"
  dimensions:
    - name: "Application Scope"
      expr: application_scope
    - name: "Condition Code"
      expr: condition_code
    - name: "Condition Name"
      expr: condition_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Endpoint Detection Method"
      expr: endpoint_detection_method
    - name: "Etch Method"
      expr: etch_method
    - name: "Etch Type"
      expr: etch_type
    - name: "Etchant Chemistry"
      expr: etchant_chemistry
    - name: "Fab Site Code"
      expr: fab_site_code
    - name: "Is Baseline Condition"
      expr: is_baseline_condition
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Owner Organization"
      expr: owner_organization
    - name: "Process Category"
      expr: process_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Etch Condition"
      expr: COUNT(DISTINCT etch_condition_id)
    - name: "Total Chamber Pressure Torr"
      expr: SUM(chamber_pressure_torr)
    - name: "Average Chamber Pressure Torr"
      expr: AVG(chamber_pressure_torr)
    - name: "Total Critical Dimension Bias Nm"
      expr: SUM(critical_dimension_bias_nm)
    - name: "Average Critical Dimension Bias Nm"
      expr: AVG(critical_dimension_bias_nm)
    - name: "Total Etch Rate Angstrom Per Minute"
      expr: SUM(etch_rate_angstrom_per_minute)
    - name: "Average Etch Rate Angstrom Per Minute"
      expr: AVG(etch_rate_angstrom_per_minute)
    - name: "Total Etch Time Seconds"
      expr: SUM(etch_time_seconds)
    - name: "Average Etch Time Seconds"
      expr: AVG(etch_time_seconds)
    - name: "Total Over Etch Percent"
      expr: SUM(over_etch_percent)
    - name: "Average Over Etch Percent"
      expr: AVG(over_etch_percent)
    - name: "Total Primary Gas Flow Sccm"
      expr: SUM(primary_gas_flow_sccm)
    - name: "Average Primary Gas Flow Sccm"
      expr: AVG(primary_gas_flow_sccm)
    - name: "Total Profile Angle Degrees"
      expr: SUM(profile_angle_degrees)
    - name: "Average Profile Angle Degrees"
      expr: AVG(profile_angle_degrees)
    - name: "Total Rf Bias Power Watts"
      expr: SUM(rf_bias_power_watts)
    - name: "Average Rf Bias Power Watts"
      expr: AVG(rf_bias_power_watts)
    - name: "Total Rf Source Power Watts"
      expr: SUM(rf_source_power_watts)
    - name: "Average Rf Source Power Watts"
      expr: AVG(rf_source_power_watts)
    - name: "Total Secondary Gas Flow Sccm"
      expr: SUM(secondary_gas_flow_sccm)
    - name: "Average Secondary Gas Flow Sccm"
      expr: AVG(secondary_gas_flow_sccm)
    - name: "Total Selectivity Ratio"
      expr: SUM(selectivity_ratio)
    - name: "Average Selectivity Ratio"
      expr: AVG(selectivity_ratio)
    - name: "Total Substrate Temperature Celsius"
      expr: SUM(substrate_temperature_celsius)
    - name: "Average Substrate Temperature Celsius"
      expr: AVG(substrate_temperature_celsius)
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

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_flow_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flow Qualification business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`flow_qualification`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Signoff"
      expr: approval_signoff
    - name: "Approved By"
      expr: approved_by
    - name: "Completion Date"
      expr: completion_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Approval Date"
      expr: customer_approval_date
    - name: "Customer Approval Required Flag"
      expr: customer_approval_required_flag
    - name: "Defect Density Actual"
      expr: defect_density_actual
    - name: "Defect Density Target"
      expr: defect_density_target
    - name: "Disposition"
      expr: disposition
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Environmental Condition"
      expr: environmental_condition
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Failure Mode Summary"
      expr: failure_mode_summary
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Flow Qualification"
      expr: COUNT(DISTINCT flow_qualification_id)
    - name: "Total Achieved Yield Percent"
      expr: SUM(achieved_yield_percent)
    - name: "Average Achieved Yield Percent"
      expr: AVG(achieved_yield_percent)
    - name: "Total Actual Cpk"
      expr: SUM(actual_cpk)
    - name: "Average Actual Cpk"
      expr: AVG(actual_cpk)
    - name: "Total Actual Yield Pct"
      expr: SUM(actual_yield_pct)
    - name: "Average Actual Yield Pct"
      expr: AVG(actual_yield_pct)
    - name: "Total Actual Yield Percent"
      expr: SUM(actual_yield_percent)
    - name: "Average Actual Yield Percent"
      expr: AVG(actual_yield_percent)
    - name: "Total Baseline Yield Percent"
      expr: SUM(baseline_yield_percent)
    - name: "Average Baseline Yield Percent"
      expr: AVG(baseline_yield_percent)
    - name: "Total Defect Density Actual Per Cm2"
      expr: SUM(defect_density_actual_per_cm2)
    - name: "Average Defect Density Actual Per Cm2"
      expr: AVG(defect_density_actual_per_cm2)
    - name: "Total Defect Density Target Per Cm2"
      expr: SUM(defect_density_target_per_cm2)
    - name: "Average Defect Density Target Per Cm2"
      expr: AVG(defect_density_target_per_cm2)
    - name: "Total Statistical Confidence Level"
      expr: SUM(statistical_confidence_level)
    - name: "Average Statistical Confidence Level"
      expr: AVG(statistical_confidence_level)
    - name: "Total Target Cpk"
      expr: SUM(target_cpk)
    - name: "Average Target Cpk"
      expr: AVG(target_cpk)
    - name: "Total Target Yield Percent"
      expr: SUM(target_yield_percent)
    - name: "Average Target Yield Percent"
      expr: AVG(target_yield_percent)
    - name: "Total Yield Achieved Percent"
      expr: SUM(yield_achieved_percent)
    - name: "Average Yield Achieved Percent"
      expr: AVG(yield_achieved_percent)
    - name: "Total Yield Actual"
      expr: SUM(yield_actual)
    - name: "Average Yield Actual"
      expr: AVG(yield_actual)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_implant_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Implant Condition business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`implant_condition`"
  dimensions:
    - name: "Anneal Type"
      expr: anneal_type
    - name: "Condition Code"
      expr: condition_code
    - name: "Condition Name"
      expr: condition_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Implant Condition Description"
      expr: implant_condition_description
    - name: "Device Type"
      expr: device_type
    - name: "Dopant Species"
      expr: dopant_species
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Implant Layer Name"
      expr: implant_layer_name
    - name: "Implant Purpose"
      expr: implant_purpose
    - name: "Implant Tool Class"
      expr: implant_tool_class
    - name: "Implant Tool Model"
      expr: implant_tool_model
    - name: "Is Baseline Condition"
      expr: is_baseline_condition
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Implant Condition"
      expr: COUNT(DISTINCT implant_condition_id)
    - name: "Total Anneal Temperature Celsius"
      expr: SUM(anneal_temperature_celsius)
    - name: "Average Anneal Temperature Celsius"
      expr: AVG(anneal_temperature_celsius)
    - name: "Total Anneal Time Seconds"
      expr: SUM(anneal_time_seconds)
    - name: "Average Anneal Time Seconds"
      expr: AVG(anneal_time_seconds)
    - name: "Total Baseline Cpk"
      expr: SUM(baseline_cpk)
    - name: "Average Baseline Cpk"
      expr: AVG(baseline_cpk)
    - name: "Total Beam Current Ma"
      expr: SUM(beam_current_ma)
    - name: "Average Beam Current Ma"
      expr: AVG(beam_current_ma)
    - name: "Total Implant Dose Ions Per Cm2"
      expr: SUM(implant_dose_ions_per_cm2)
    - name: "Average Implant Dose Ions Per Cm2"
      expr: AVG(implant_dose_ions_per_cm2)
    - name: "Total Implant Energy Kev"
      expr: SUM(implant_energy_kev)
    - name: "Average Implant Energy Kev"
      expr: AVG(implant_energy_kev)
    - name: "Total Process Window Dose Tolerance Percent"
      expr: SUM(process_window_dose_tolerance_percent)
    - name: "Average Process Window Dose Tolerance Percent"
      expr: AVG(process_window_dose_tolerance_percent)
    - name: "Total Process Window Energy Tolerance Percent"
      expr: SUM(process_window_energy_tolerance_percent)
    - name: "Average Process Window Energy Tolerance Percent"
      expr: AVG(process_window_energy_tolerance_percent)
    - name: "Total Target Junction Depth Nm"
      expr: SUM(target_junction_depth_nm)
    - name: "Average Target Junction Depth Nm"
      expr: AVG(target_junction_depth_nm)
    - name: "Total Target Sheet Resistance Ohms Per Sq"
      expr: SUM(target_sheet_resistance_ohms_per_sq)
    - name: "Average Target Sheet Resistance Ohms Per Sq"
      expr: AVG(target_sheet_resistance_ohms_per_sq)
    - name: "Total Target Threshold Voltage Mv"
      expr: SUM(target_threshold_voltage_mv)
    - name: "Average Target Threshold Voltage Mv"
      expr: AVG(target_threshold_voltage_mv)
    - name: "Total Tilt Angle Degrees"
      expr: SUM(tilt_angle_degrees)
    - name: "Average Tilt Angle Degrees"
      expr: AVG(tilt_angle_degrees)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_inspection_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection Point business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`inspection_point`"
  dimensions:
    - name: "Classification"
      expr: classification
    - name: "Inspection Point Code"
      expr: inspection_point_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Equipment Name"
      expr: equipment_name
    - name: "Inspection Frequency"
      expr: inspection_frequency
    - name: "Inspection Method"
      expr: inspection_method
    - name: "Inspection Point Status"
      expr: inspection_point_status
    - name: "Inspection Type"
      expr: inspection_type
    - name: "Is Active"
      expr: is_active
    - name: "Is Critical"
      expr: is_critical
    - name: "Last Calibrated Date"
      expr: last_calibrated_date
    - name: "Location"
      expr: location
    - name: "Measurement Type"
      expr: measurement_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inspection Point"
      expr: COUNT(DISTINCT inspection_point_id)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Tolerance Lower"
      expr: SUM(tolerance_lower)
    - name: "Average Tolerance Lower"
      expr: AVG(tolerance_lower)
    - name: "Total Tolerance Upper"
      expr: SUM(tolerance_upper)
    - name: "Average Tolerance Upper"
      expr: AVG(tolerance_upper)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_litho_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Litho Condition business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`litho_condition`"
  dimensions:
    - name: "Condition Code"
      expr: condition_code
    - name: "Condition Name"
      expr: condition_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Develop Process Type"
      expr: develop_process_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fab Site Code"
      expr: fab_site_code
    - name: "Illumination Mode"
      expr: illumination_mode
    - name: "Is Baseline Condition"
      expr: is_baseline_condition
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Layer Name"
      expr: layer_name
    - name: "Lithography Type"
      expr: lithography_type
    - name: "Multi Patterning Type"
      expr: multi_patterning_type
    - name: "Notes"
      expr: notes
    - name: "Owner Engineer Name"
      expr: owner_engineer_name
    - name: "Owner Organization"
      expr: owner_organization
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Litho Condition"
      expr: COUNT(DISTINCT litho_condition_id)
    - name: "Total Cd Tolerance Nm"
      expr: SUM(cd_tolerance_nm)
    - name: "Average Cd Tolerance Nm"
      expr: AVG(cd_tolerance_nm)
    - name: "Total Depth Of Focus Nm"
      expr: SUM(depth_of_focus_nm)
    - name: "Average Depth Of Focus Nm"
      expr: AVG(depth_of_focus_nm)
    - name: "Total Develop Time Seconds"
      expr: SUM(develop_time_seconds)
    - name: "Average Develop Time Seconds"
      expr: AVG(develop_time_seconds)
    - name: "Total Exposure Dose Mj Cm2"
      expr: SUM(exposure_dose_mj_cm2)
    - name: "Average Exposure Dose Mj Cm2"
      expr: AVG(exposure_dose_mj_cm2)
    - name: "Total Exposure Latitude Percent"
      expr: SUM(exposure_latitude_percent)
    - name: "Average Exposure Latitude Percent"
      expr: AVG(exposure_latitude_percent)
    - name: "Total Focus Offset Nm"
      expr: SUM(focus_offset_nm)
    - name: "Average Focus Offset Nm"
      expr: AVG(focus_offset_nm)
    - name: "Total Hard Bake Temperature C"
      expr: SUM(hard_bake_temperature_c)
    - name: "Average Hard Bake Temperature C"
      expr: AVG(hard_bake_temperature_c)
    - name: "Total Hard Bake Time Seconds"
      expr: SUM(hard_bake_time_seconds)
    - name: "Average Hard Bake Time Seconds"
      expr: AVG(hard_bake_time_seconds)
    - name: "Total Numerical Aperture"
      expr: SUM(numerical_aperture)
    - name: "Average Numerical Aperture"
      expr: AVG(numerical_aperture)
    - name: "Total Overlay Tolerance Nm"
      expr: SUM(overlay_tolerance_nm)
    - name: "Average Overlay Tolerance Nm"
      expr: AVG(overlay_tolerance_nm)
    - name: "Total Post Exposure Bake Temperature C"
      expr: SUM(post_exposure_bake_temperature_c)
    - name: "Average Post Exposure Bake Temperature C"
      expr: AVG(post_exposure_bake_temperature_c)
    - name: "Total Post Exposure Bake Time Seconds"
      expr: SUM(post_exposure_bake_time_seconds)
    - name: "Average Post Exposure Bake Time Seconds"
      expr: AVG(post_exposure_bake_time_seconds)
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
    - name: "Total Waste Heat Recovered Kwh"
      expr: SUM(waste_heat_recovered_kwh)
    - name: "Average Waste Heat Recovered Kwh"
      expr: AVG(waste_heat_recovered_kwh)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_meef_parameter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meef Parameter business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`meef_parameter`"
  dimensions:
    - name: "Application Scope"
      expr: application_scope
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Feature Type"
      expr: feature_type
    - name: "Illumination Mode"
      expr: illumination_mode
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Layer Name"
      expr: layer_name
    - name: "Lithography Type"
      expr: lithography_type
    - name: "Measurement Date"
      expr: measurement_date
    - name: "Measurement Method"
      expr: measurement_method
    - name: "Measurement Tool"
      expr: measurement_tool
    - name: "Notes"
      expr: notes
    - name: "Process Condition"
      expr: process_condition
    - name: "Qualification Date"
      expr: qualification_date
    - name: "Qualification Status"
      expr: qualification_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Meef Parameter"
      expr: COUNT(DISTINCT meef_parameter_id)
    - name: "Total Cd Target Nm"
      expr: SUM(cd_target_nm)
    - name: "Average Cd Target Nm"
      expr: AVG(cd_target_nm)
    - name: "Total Depth Of Focus Nm"
      expr: SUM(depth_of_focus_nm)
    - name: "Average Depth Of Focus Nm"
      expr: AVG(depth_of_focus_nm)
    - name: "Total Exposure Latitude Percent"
      expr: SUM(exposure_latitude_percent)
    - name: "Average Exposure Latitude Percent"
      expr: AVG(exposure_latitude_percent)
    - name: "Total Mask Cd Target Nm"
      expr: SUM(mask_cd_target_nm)
    - name: "Average Mask Cd Target Nm"
      expr: AVG(mask_cd_target_nm)
    - name: "Total Mask Cd Tolerance Nm"
      expr: SUM(mask_cd_tolerance_nm)
    - name: "Average Mask Cd Tolerance Nm"
      expr: AVG(mask_cd_tolerance_nm)
    - name: "Total Meef Value"
      expr: SUM(meef_value)
    - name: "Average Meef Value"
      expr: AVG(meef_value)
    - name: "Total Numerical Aperture"
      expr: SUM(numerical_aperture)
    - name: "Average Numerical Aperture"
      expr: AVG(numerical_aperture)
    - name: "Total Pitch Nm"
      expr: SUM(pitch_nm)
    - name: "Average Pitch Nm"
      expr: AVG(pitch_nm)
    - name: "Total Process Window Score"
      expr: SUM(process_window_score)
    - name: "Average Process Window Score"
      expr: AVG(process_window_score)
    - name: "Total Sigma Inner"
      expr: SUM(sigma_inner)
    - name: "Average Sigma Inner"
      expr: AVG(sigma_inner)
    - name: "Total Sigma Outer"
      expr: SUM(sigma_outer)
    - name: "Average Sigma Outer"
      expr: AVG(sigma_outer)
    - name: "Total Wavelength Nm"
      expr: SUM(wavelength_nm)
    - name: "Average Wavelength Nm"
      expr: AVG(wavelength_nm)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_metrology_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrology Plan business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`metrology_plan`"
  dimensions:
    - name: "Metrology Plan Code"
      expr: metrology_plan_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Metrology Plan Description"
      expr: metrology_plan_description
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Frequency Per Day"
      expr: frequency_per_day
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Measurement Category"
      expr: measurement_category
    - name: "Measurement Parameter"
      expr: measurement_parameter
    - name: "Measurement Tool"
      expr: measurement_tool
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Metrology Type"
      expr: metrology_type
    - name: "Metrology Plan Name"
      expr: metrology_plan_name
    - name: "Plan Code"
      expr: plan_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Metrology Plan"
      expr: COUNT(DISTINCT metrology_plan_id)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_ocap_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ocap Action business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`ocap_action`"
  dimensions:
    - name: "Action Completed Timestamp"
      expr: action_completed_timestamp
    - name: "Action Initiated Timestamp"
      expr: action_initiated_timestamp
    - name: "Action Status"
      expr: action_status
    - name: "Action Type"
      expr: action_type
    - name: "Affected Wafer Count"
      expr: affected_wafer_count
    - name: "Assigned Organization"
      expr: assigned_organization
    - name: "Closure Notes"
      expr: closure_notes
    - name: "Containment Action Flag"
      expr: containment_action_flag
    - name: "Corrective Action Description"
      expr: corrective_action_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Date"
      expr: customer_notification_date
    - name: "Customer Notification Required Flag"
      expr: customer_notification_required_flag
    - name: "Detection Timestamp"
      expr: detection_timestamp
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Escalation Required Flag"
      expr: escalation_required_flag
    - name: "Excursion Severity"
      expr: excursion_severity
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ocap Action"
      expr: COUNT(DISTINCT ocap_action_id)
    - name: "Total Ocap Responds To Excursion"
      expr: SUM(ocap_responds_to_excursion)
    - name: "Average Ocap Responds To Excursion"
      expr: AVG(ocap_responds_to_excursion)
    - name: "Total Resolution Time Minutes"
      expr: SUM(resolution_time_minutes)
    - name: "Average Resolution Time Minutes"
      expr: AVG(resolution_time_minutes)
    - name: "Total Response Time Minutes"
      expr: SUM(response_time_minutes)
    - name: "Average Response Time Minutes"
      expr: AVG(response_time_minutes)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_opc_rule_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Opc Rule Set business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`opc_rule_set`"
  dimensions:
    - name: "Assist Feature Rules"
      expr: assist_feature_rules
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eda Tool Name"
      expr: eda_tool_name
    - name: "Eda Tool Vendor"
      expr: eda_tool_vendor
    - name: "Eda Tool Version"
      expr: eda_tool_version
    - name: "Illumination Mode"
      expr: illumination_mode
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lithography Type"
      expr: lithography_type
    - name: "Meef Feature Type"
      expr: meef_feature_type
    - name: "Meef Measurement Methodology"
      expr: meef_measurement_methodology
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Notes"
      expr: notes
    - name: "Opc Model Type"
      expr: opc_model_type
    - name: "Owner Engineer Name"
      expr: owner_engineer_name
    - name: "Owner Organization"
      expr: owner_organization
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Opc Rule Set"
      expr: COUNT(DISTINCT opc_rule_set_id)
    - name: "Total Lithography Wavelength Nm"
      expr: SUM(lithography_wavelength_nm)
    - name: "Average Lithography Wavelength Nm"
      expr: AVG(lithography_wavelength_nm)
    - name: "Total Meef Pitch Nm"
      expr: SUM(meef_pitch_nm)
    - name: "Average Meef Pitch Nm"
      expr: AVG(meef_pitch_nm)
    - name: "Total Meef Target Cd Nm"
      expr: SUM(meef_target_cd_nm)
    - name: "Average Meef Target Cd Nm"
      expr: AVG(meef_target_cd_nm)
    - name: "Total Meef Value"
      expr: SUM(meef_value)
    - name: "Average Meef Value"
      expr: AVG(meef_value)
    - name: "Total Opc For Node"
      expr: SUM(opc_for_node)
    - name: "Average Opc For Node"
      expr: AVG(opc_for_node)
    - name: "Total Process Window Dof Nm"
      expr: SUM(process_window_dof_nm)
    - name: "Average Process Window Dof Nm"
      expr: AVG(process_window_dof_nm)
    - name: "Total Process Window El Percent"
      expr: SUM(process_window_el_percent)
    - name: "Average Process Window El Percent"
      expr: AVG(process_window_el_percent)
    - name: "Total Scanner Numerical Aperture"
      expr: SUM(scanner_numerical_aperture)
    - name: "Average Scanner Numerical Aperture"
      expr: AVG(scanner_numerical_aperture)
    - name: "Total Sigma Inner"
      expr: SUM(sigma_inner)
    - name: "Average Sigma Inner"
      expr: AVG(sigma_inner)
    - name: "Total Sigma Outer"
      expr: SUM(sigma_outer)
    - name: "Average Sigma Outer"
      expr: AVG(sigma_outer)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process Flow business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`process_flow`"
  dimensions:
    - name: "Beol Step Count"
      expr: beol_step_count
    - name: "Cool Optimization Enabled"
      expr: cool_optimization_enabled
    - name: "Cooling Step Count"
      expr: cooling_step_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Layer Count"
      expr: critical_layer_count
    - name: "Process Flow Description"
      expr: process_flow_description
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
    - name: "Flow Code"
      expr: flow_code
    - name: "Flow Name"
      expr: flow_name
    - name: "Flow Revision"
      expr: flow_revision
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Process Flow"
      expr: COUNT(DISTINCT process_flow_id)
    - name: "Total Baseline Cpk"
      expr: SUM(baseline_cpk)
    - name: "Average Baseline Cpk"
      expr: AVG(baseline_cpk)
    - name: "Total Cycle Time Days"
      expr: SUM(cycle_time_days)
    - name: "Average Cycle Time Days"
      expr: AVG(cycle_time_days)
    - name: "Total Flow For Node"
      expr: SUM(flow_for_node)
    - name: "Average Flow For Node"
      expr: AVG(flow_for_node)
    - name: "Total Target Yield Percent"
      expr: SUM(target_yield_percent)
    - name: "Average Target Yield Percent"
      expr: AVG(target_yield_percent)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_metrology`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrology quality and capability metrics for process control"
  source: "`vibe_semiconductors_v1`.`process`.`process_metrology_measurement`"
  dimensions:
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer measured"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of metrology measurement"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the metrology data"
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Date of the metrology measurement"
  measures:
    - name: "measurement_count"
      expr: COUNT(1)
      comment: "Number of metrology measurements captured"
    - name: "avg_cp_value"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average Cp value across measurements"
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk value across measurements"
    - name: "avg_mean_value"
      expr: AVG(CAST(mean_value AS DOUBLE))
      comment: "Average mean value of the measured parameter"
    - name: "avg_std_deviation"
      expr: AVG(CAST(std_deviation AS DOUBLE))
      comment: "Average standard deviation of the measured parameter"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_metrology_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process metrology measurement KPIs tracking measurement accuracy, uniformity, and specification compliance across wafers and process layers. Drives process control tightening and equipment qualification decisions."
  source: "`vibe_semiconductors_v1`.`process`.`process_metrology_measurement`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of metrology measurement (e.g. CD-SEM, ellipsometry, XRF) for method-level analysis."
    - name: "measurement_parameter"
      expr: measurement_parameter
      comment: "Specific parameter being measured (e.g. film thickness, CD, overlay)."
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer measured, enabling layer-level process control analysis."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (e.g. Valid, Suspect, Out of Spec)."
    - name: "disposition"
      expr: disposition
      comment: "Disposition of the wafer based on metrology result (e.g. Pass, Hold, Rework)."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the metrology parameter."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the measurement (e.g. Good, Suspect, Invalid)."
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of measurement for trend analysis."
  measures:
    - name: "avg_mean_value"
      expr: AVG(CAST(mean_value AS DOUBLE))
      comment: "Average mean measurement value across all metrology records. Tracks process centering relative to target specifications."
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk from metrology measurements. Primary process capability KPI for metrology-confirmed process control."
    - name: "avg_cp_value"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average Cp from metrology measurements. Indicates process potential and specification headroom."
    - name: "avg_uniformity_pct"
      expr: AVG(CAST(uniformity_percent AS DOUBLE))
      comment: "Average within-wafer uniformity percentage. Critical for advanced node yield; poor uniformity drives systematic die failures."
    - name: "avg_std_deviation"
      expr: AVG(CAST(std_deviation AS DOUBLE))
      comment: "Average standard deviation of metrology measurements. Tracks process variability reduction over time."
    - name: "avg_three_sigma"
      expr: AVG(CAST(three_sigma AS DOUBLE))
      comment: "Average 3-sigma spread of measurements. Used to assess process window margin against specification limits."
    - name: "spec_exceedance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mean_value > upper_spec_limit OR mean_value < lower_spec_limit THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements where mean value exceeds specification limits. Direct yield risk indicator used in process qualification reviews."
    - name: "total_metrology_measurements"
      expr: COUNT(1)
      comment: "Total metrology measurement count. Indicates process monitoring coverage and sampling plan adherence."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_process_metrology_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process Metrology Measurement business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`process_metrology_measurement`"
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
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Notes"
      expr: notes
    - name: "Site Count"
      expr: site_count
    - name: "Spc Rule Violation"
      expr: spc_rule_violation
    - name: "Unit Of Measure"
      expr: unit_of_measure
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Process Metrology Measurement"
      expr: COUNT(DISTINCT process_metrology_measurement_id)
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
    - name: "Total Metrology At Step"
      expr: SUM(metrology_at_step)
    - name: "Average Metrology At Step"
      expr: AVG(metrology_at_step)
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
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_process_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process Qualification business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`process_qualification`"
  dimensions:
    - name: "Acceptance Criteria Summary"
      expr: acceptance_criteria_summary
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Cooling Optimization Evaluated"
      expr: cooling_optimization_evaluated
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
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Notes"
      expr: notes
    - name: "Owner Engineer Name"
      expr: owner_engineer_name
    - name: "Owner Organization"
      expr: owner_organization
    - name: "Plan Reference"
      expr: plan_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Process Qualification"
      expr: COUNT(DISTINCT process_qualification_id)
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

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process qualification KPIs tracking qualification pass rates, yield achievement, and cycle time. Used by technology development and manufacturing VPs to gate process releases and manage qualification pipeline."
  source: "`vibe_semiconductors_v1`.`process`.`process_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (e.g. Qualified, In Progress, Failed, Conditional)."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g. New Process, Change Qualification, Customer Qualification)."
    - name: "customer_approval_status"
      expr: customer_approval_status
      comment: "Customer approval status for qualifications requiring customer sign-off."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the qualification (e.g. Approved, Rejected, Conditional Approval)."
    - name: "fab_site_code"
      expr: fab_site_code
      comment: "Fab site where qualification was performed, enabling site-level comparison."
    - name: "requires_customer_approval"
      expr: requires_customer_approval
      comment: "Flag indicating customer approval is required, tracking compliance obligations."
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month qualification started for pipeline and cycle time analysis."
  measures:
    - name: "avg_actual_yield_pct"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield achieved during qualification. Primary KPI for assessing whether process meets yield targets for release."
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield for qualifications. Compared against actual yield to assess qualification success margin."
    - name: "avg_yield_gap_pct"
      expr: AVG(actual_yield_percent - target_yield_percent)
      comment: "Average gap between actual and target yield. Negative values indicate qualification shortfall requiring process improvement before release."
    - name: "avg_actual_cpk"
      expr: AVG(CAST(actual_cpk AS DOUBLE))
      comment: "Average actual Cpk achieved during qualification. Cpk < 1.33 typically blocks process release."
    - name: "avg_target_cpk"
      expr: AVG(CAST(target_cpk AS DOUBLE))
      comment: "Average target Cpk for qualifications. Benchmarks process capability requirements across technology nodes."
    - name: "qualification_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qualification_status = 'Qualified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications achieving qualified status. Key technology readiness KPI for executive program reviews."
    - name: "customer_approval_pending_count"
      expr: SUM(CASE WHEN requires_customer_approval = TRUE AND customer_approval_status NOT IN ('Approved', 'Accepted') THEN 1 ELSE 0 END)
      comment: "Count of qualifications pending customer approval. Tracks customer-gated process releases affecting revenue timing."
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of process qualifications. Baseline metric for technology development pipeline volume."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_process_site_map`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process Site Map business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`process_site_map`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Capacity Unit"
      expr: capacity_unit
    - name: "City"
      expr: city
    - name: "Closing Date"
      expr: closing_date
    - name: "Compliance Classification"
      expr: compliance_classification
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Classification"
      expr: data_classification
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Is Primary Site"
      expr: is_primary_site
    - name: "Manager Email"
      expr: manager_email
    - name: "Manager Name"
      expr: manager_name
    - name: "Manager Phone"
      expr: manager_phone
    - name: "Measurement Site Count"
      expr: measurement_site_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Process Site Map"
      expr: COUNT(DISTINCT process_site_map_id)
    - name: "Total Capacity"
      expr: SUM(capacity)
    - name: "Average Capacity"
      expr: AVG(capacity)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_process_spc_control_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process Spc Control Plan business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`process_spc_control_plan`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Approved By"
      expr: approved_by
    - name: "Control Chart Type"
      expr: control_chart_type
    - name: "Control Plan Code"
      expr: control_plan_code
    - name: "Control Plan Name"
      expr: control_plan_name
    - name: "Control Plan Status"
      expr: control_plan_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Deprecation Date"
      expr: deprecation_date
    - name: "Deprecation Reason"
      expr: deprecation_reason
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Equipment Identifier"
      expr: equipment_identifier
    - name: "Is Critical"
      expr: is_critical
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Lot Size"
      expr: lot_size
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Process Spc Control Plan"
      expr: COUNT(DISTINCT process_spc_control_plan_id)
    - name: "Total Capability Index Cp K"
      expr: SUM(capability_index_cp_k)
    - name: "Average Capability Index Cp K"
      expr: AVG(capability_index_cp_k)
    - name: "Total Confidence Level Percent"
      expr: SUM(confidence_level_percent)
    - name: "Average Confidence Level Percent"
      expr: AVG(confidence_level_percent)
    - name: "Total Control Limit Lower"
      expr: SUM(control_limit_lower)
    - name: "Average Control Limit Lower"
      expr: AVG(control_limit_lower)
    - name: "Total Control Limit Upper"
      expr: SUM(control_limit_upper)
    - name: "Average Control Limit Upper"
      expr: AVG(control_limit_upper)
    - name: "Total Sampling Rate Per Hour"
      expr: SUM(sampling_rate_per_hour)
    - name: "Average Sampling Rate Per Hour"
      expr: AVG(sampling_rate_per_hour)
    - name: "Total Ssot Owner Reference"
      expr: SUM(ssot_owner_reference)
    - name: "Average Ssot Owner Reference"
      expr: AVG(ssot_owner_reference)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Tolerance Lower"
      expr: SUM(tolerance_lower)
    - name: "Average Tolerance Lower"
      expr: AVG(tolerance_lower)
    - name: "Total Tolerance Upper"
      expr: SUM(tolerance_upper)
    - name: "Average Tolerance Upper"
      expr: AVG(tolerance_upper)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_process_step`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process Step business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`process_step`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Cooling Step"
      expr: is_cooling_step
    - name: "Is Critical Step"
      expr: is_critical_step
    - name: "Is Rework Allowed"
      expr: is_rework_allowed
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Model Lineage Source"
      expr: model_lineage_source
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
    - name: "Step Description"
      expr: step_description
    - name: "Step Name"
      expr: step_name
    - name: "Step Number"
      expr: step_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Process Step"
      expr: COUNT(DISTINCT process_step_id)
    - name: "Total Cooling Target Temperature Celsius"
      expr: SUM(cooling_target_temperature_celsius)
    - name: "Average Cooling Target Temperature Celsius"
      expr: AVG(cooling_target_temperature_celsius)
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

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_process_supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process Supply Agreement business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`process_supply_agreement`"
  dimensions:
    - name: "Agreement End Date"
      expr: agreement_end_date
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Start Date"
      expr: agreement_start_date
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Capacity Commitment"
      expr: capacity_commitment
    - name: "Committed Volume Units"
      expr: committed_volume_units
    - name: "Committed Volume Wafers"
      expr: committed_volume_wafers
    - name: "Committed Wafer Volume"
      expr: committed_wafer_volume
    - name: "Contract Number"
      expr: contract_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency"
      expr: currency
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Terms"
      expr: delivery_terms
    - name: "Effective Date"
      expr: effective_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Process Supply Agreement"
      expr: COUNT(DISTINCT process_supply_agreement_id)
    - name: "Total Capacity Allocation Pct"
      expr: SUM(capacity_allocation_pct)
    - name: "Average Capacity Allocation Pct"
      expr: AVG(capacity_allocation_pct)
    - name: "Total Capacity Reservation"
      expr: SUM(capacity_reservation)
    - name: "Average Capacity Reservation"
      expr: AVG(capacity_reservation)
    - name: "Total Capacity Reservation Pct"
      expr: SUM(capacity_reservation_pct)
    - name: "Average Capacity Reservation Pct"
      expr: AVG(capacity_reservation_pct)
    - name: "Total Committed Capacity Pct"
      expr: SUM(committed_capacity_pct)
    - name: "Average Committed Capacity Pct"
      expr: AVG(committed_capacity_pct)
    - name: "Total Committed Capacity Percent"
      expr: SUM(committed_capacity_percent)
    - name: "Average Committed Capacity Percent"
      expr: AVG(committed_capacity_percent)
    - name: "Total Committed Volume"
      expr: SUM(committed_volume)
    - name: "Average Committed Volume"
      expr: AVG(committed_volume)
    - name: "Total Price Per Wafer"
      expr: SUM(price_per_wafer)
    - name: "Average Price Per Wafer"
      expr: AVG(price_per_wafer)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
    - name: "Total Volume Commitment Qty"
      expr: SUM(volume_commitment_qty)
    - name: "Average Volume Commitment Qty"
      expr: AVG(volume_commitment_qty)
    - name: "Total Volume Commitment Units"
      expr: SUM(volume_commitment_units)
    - name: "Average Volume Commitment Units"
      expr: AVG(volume_commitment_units)
    - name: "Total Wafer Price Usd"
      expr: SUM(wafer_price_usd)
    - name: "Average Wafer Price Usd"
      expr: AVG(wafer_price_usd)
    - name: "Total Yield Commitment Percent"
      expr: SUM(yield_commitment_percent)
    - name: "Average Yield Commitment Percent"
      expr: AVG(yield_commitment_percent)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process supply agreement KPIs tracking capacity commitments, pricing, and yield obligations. Used by supply chain and finance leadership to manage foundry/supplier relationships and capacity risk."
  source: "`vibe_semiconductors_v1`.`process`.`process_supply_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of supply agreement (e.g. Foundry, Material, Equipment) for portfolio analysis."
    - name: "process_supply_agreement_status"
      expr: process_supply_agreement_status
      comment: "Current status of the supply agreement (e.g. Active, Expired, Negotiating)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement for multi-currency portfolio analysis."
    - name: "take_or_pay_flag"
      expr: take_or_pay_flag
      comment: "Flag indicating take-or-pay obligation, representing committed financial exposure."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms of the agreement for cash flow planning."
    - name: "agreement_start_month"
      expr: DATE_TRUNC('month', agreement_start_date)
      comment: "Month agreement started for portfolio timeline analysis."
  measures:
    - name: "avg_price_per_wafer_usd"
      expr: AVG(CAST(price_per_wafer AS DOUBLE))
      comment: "Average price per wafer across supply agreements. Key cost benchmark for wafer cost modeling and supplier negotiation."
    - name: "avg_wafer_price_usd"
      expr: AVG(CAST(wafer_price_usd AS DOUBLE))
      comment: "Average wafer price in USD across agreements. Tracks wafer cost trends for financial planning and margin analysis."
    - name: "avg_committed_volume"
      expr: AVG(CAST(committed_volume AS DOUBLE))
      comment: "Average committed volume per agreement. Tracks supply commitment levels for capacity planning."
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume AS DOUBLE))
      comment: "Total committed volume across all active supply agreements. Critical for supply chain capacity planning and financial commitment tracking."
    - name: "avg_yield_commitment_pct"
      expr: AVG(CAST(yield_commitment_percent AS DOUBLE))
      comment: "Average yield commitment percentage in supply agreements. Tracks supplier yield obligations and risk of shortfall penalties."
    - name: "take_or_pay_agreement_count"
      expr: SUM(CASE WHEN take_or_pay_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of take-or-pay agreements. Quantifies committed financial exposure regardless of actual consumption."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN process_supply_agreement_status = 'Active' THEN 1 END)
      comment: "Number of active supply agreements. Tracks supplier relationship portfolio breadth and dependency concentration."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_process_technology_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process Technology Node business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`process_technology_node`"
  dimensions:
    - name: "Application Scope"
      expr: application_scope
    - name: "Beol Layer Count"
      expr: beol_layer_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Process Technology Node Description"
      expr: process_technology_node_description
    - name: "Design Rule Complexity"
      expr: design_rule_complexity
    - name: "Device Architecture"
      expr: device_architecture
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Euv Layer Count"
      expr: euv_layer_count
    - name: "Fab Site Code"
      expr: fab_site_code
    - name: "Feol Layer Count"
      expr: feol_layer_count
    - name: "Introduction Year"
      expr: introduction_year
    - name: "Is Baseline Node"
      expr: is_baseline_node
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lithography Type"
      expr: lithography_type
    - name: "Metal Layer Count"
      expr: metal_layer_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Process Technology Node"
      expr: COUNT(DISTINCT process_technology_node_id)
    - name: "Total Baseline Cpk"
      expr: SUM(baseline_cpk)
    - name: "Average Baseline Cpk"
      expr: AVG(baseline_cpk)
    - name: "Total Baseline Yield Target Percent"
      expr: SUM(baseline_yield_target_percent)
    - name: "Average Baseline Yield Target Percent"
      expr: AVG(baseline_yield_target_percent)
    - name: "Total Dram Half Pitch Nm"
      expr: SUM(dram_half_pitch_nm)
    - name: "Average Dram Half Pitch Nm"
      expr: AVG(dram_half_pitch_nm)
    - name: "Total Gate Pitch Nm"
      expr: SUM(gate_pitch_nm)
    - name: "Average Gate Pitch Nm"
      expr: AVG(gate_pitch_nm)
    - name: "Total Minimum Metal Pitch Nm"
      expr: SUM(minimum_metal_pitch_nm)
    - name: "Average Minimum Metal Pitch Nm"
      expr: AVG(minimum_metal_pitch_nm)
    - name: "Total Ssot Owner Reference"
      expr: SUM(ssot_owner_reference)
    - name: "Average Ssot Owner Reference"
      expr: AVG(ssot_owner_reference)
    - name: "Total Target Performance Improvement Percent"
      expr: SUM(target_performance_improvement_percent)
    - name: "Average Target Performance Improvement Percent"
      expr: AVG(target_performance_improvement_percent)
    - name: "Total Target Power Efficiency Improvement Percent"
      expr: SUM(target_power_efficiency_improvement_percent)
    - name: "Average Target Power Efficiency Improvement Percent"
      expr: AVG(target_power_efficiency_improvement_percent)
    - name: "Total Target Transistor Density Per Mm2"
      expr: SUM(target_transistor_density_per_mm2)
    - name: "Average Target Transistor Density Per Mm2"
      expr: AVG(target_transistor_density_per_mm2)
    - name: "Total Wavelength Nm"
      expr: SUM(wavelength_nm)
    - name: "Average Wavelength Nm"
      expr: AVG(wavelength_nm)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_technology_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process technology node KPIs tracking capability targets, yield goals, and production readiness across technology generations. Used by technology strategy and R&D leadership for roadmap planning and node qualification tracking."
  source: "`vibe_semiconductors_v1`.`process`.`process_technology_node`"
  dimensions:
    - name: "node_name"
      expr: node_name
      comment: "Technology node name (e.g. 5nm, 3nm, 2nm) for node-level performance comparison."
    - name: "node_generation"
      expr: node_generation
      comment: "Generation of the technology node for roadmap progression analysis."
    - name: "production_readiness_status"
      expr: production_readiness_status
      comment: "Production readiness status (e.g. R&D, Qualification, Production, EOL)."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the technology node."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography type used (e.g. EUV, DUV, Multi-Patterning) for technology capability analysis."
    - name: "device_architecture"
      expr: device_architecture
      comment: "Device architecture (e.g. FinFET, GAA, Planar) for technology differentiation analysis."
    - name: "supports_multi_patterning"
      expr: supports_multi_patterning
      comment: "Flag indicating multi-patterning support, relevant for advanced node cost and complexity analysis."
    - name: "is_baseline_node"
      expr: is_baseline_node
      comment: "Flag indicating this is the baseline reference node for performance benchmarking."
  measures:
    - name: "avg_baseline_cpk"
      expr: AVG(CAST(baseline_cpk AS DOUBLE))
      comment: "Average baseline Cpk across technology nodes. Tracks process capability maturity as nodes progress through qualification."
    - name: "avg_baseline_yield_target_pct"
      expr: AVG(CAST(baseline_yield_target_percent AS DOUBLE))
      comment: "Average baseline yield target across nodes. Benchmarks yield expectations for technology node planning."
    - name: "avg_target_transistor_density"
      expr: AVG(CAST(target_transistor_density_per_mm2 AS DOUBLE))
      comment: "Average target transistor density per mm². Key technology scaling KPI for roadmap competitiveness assessment."
    - name: "avg_gate_pitch_nm"
      expr: AVG(CAST(gate_pitch_nm AS DOUBLE))
      comment: "Average gate pitch in nanometers. Fundamental scaling metric for technology node advancement tracking."
    - name: "avg_minimum_metal_pitch_nm"
      expr: AVG(CAST(minimum_metal_pitch_nm AS DOUBLE))
      comment: "Average minimum metal pitch in nanometers. Tracks interconnect scaling progress across technology generations."
    - name: "avg_target_power_efficiency_improvement_pct"
      expr: AVG(CAST(target_power_efficiency_improvement_percent AS DOUBLE))
      comment: "Average target power efficiency improvement percentage. Tracks energy efficiency roadmap commitments for competitive positioning."
    - name: "production_ready_node_count"
      expr: COUNT(CASE WHEN production_readiness_status = 'Production' THEN 1 END)
      comment: "Number of nodes in production-ready status. Tracks technology portfolio breadth available for customer design wins."
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
    - name: "Coolant Type"
      expr: coolant_type
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
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Modified Timestamp"
      expr: modified_timestamp
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
    - name: "Total Cooling Rate Celsius Per Minute"
      expr: SUM(cooling_rate_celsius_per_minute)
    - name: "Average Cooling Rate Celsius Per Minute"
      expr: AVG(cooling_rate_celsius_per_minute)
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
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_sampling_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sampling Plan business metrics"
  source: "`vibe_semiconductors_v1`.`process`.`sampling_plan`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Sampling Plan Code"
      expr: sampling_plan_code
    - name: "Compliance Regulation"
      expr: compliance_regulation
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Sampling Plan Description"
      expr: sampling_plan_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Active"
      expr: is_active
    - name: "Is Critical"
      expr: is_critical
    - name: "Last Executed By"
      expr: last_executed_by
    - name: "Last Executed Date"
      expr: last_executed_date
    - name: "Lot Size"
      expr: lot_size
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Sampling Plan Name"
      expr: sampling_plan_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sampling Plan"
      expr: COUNT(DISTINCT sampling_plan_id)
    - name: "Total Control Limit Lower"
      expr: SUM(control_limit_lower)
    - name: "Average Control Limit Lower"
      expr: AVG(control_limit_lower)
    - name: "Total Control Limit Upper"
      expr: SUM(control_limit_upper)
    - name: "Average Control Limit Upper"
      expr: AVG(control_limit_upper)
    - name: "Total Sample Rate Percent"
      expr: SUM(sample_rate_percent)
    - name: "Average Sample Rate Percent"
      expr: AVG(sample_rate_percent)
    - name: "Total Sampling Rate Percent"
      expr: SUM(sampling_rate_percent)
    - name: "Average Sampling Rate Percent"
      expr: AVG(sampling_rate_percent)
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
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Monitored Parameter Name"
      expr: monitored_parameter_name
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
    - name: "Model Lineage Source"
      expr: model_lineage_source
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

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`process_yield_loss`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic yield loss and risk metrics for executive oversight"
  source: "`vibe_semiconductors_v1`.`process`.`yield_loss_event`"
  dimensions:
    - name: "fab_tool_id"
      expr: fab_tool_id
      comment: "Fab tool where the yield loss event occurred"
    - name: "recipe_id"
      expr: recipe_id
      comment: "Recipe in use during the event"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the event"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for the event"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the yield loss event"
  measures:
    - name: "event_count"
      expr: COUNT(1)
      comment: "Total number of yield loss events recorded"
    - name: "avg_yield_impact_pct"
      expr: AVG(CAST(estimated_yield_impact_percent AS DOUBLE))
      comment: "Average estimated yield impact percentage"
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk value associated with yield loss events"
    - name: "high_severity_rate_pct"
      expr: ROUND(100.0 * AVG(CASE WHEN severity_level = 'High' THEN 1 ELSE 0 END), 2)
      comment: "Percentage of events classified as high severity"
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
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Notes"
      expr: notes
    - name: "Reported By"
      expr: reported_by
    - name: "Resolution Status"
      expr: resolution_status
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
