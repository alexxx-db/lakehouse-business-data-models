-- Metric views for domain: fabrication | Business: Semiconductors | Version: 2 | Generated on: 2026-06-27 11:25:39

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fab_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fab Yield Record business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`fab_yield_record`"
  dimensions:
    - name: "Bin 1 Die Count"
      expr: bin_1_die_count
    - name: "Bin 2 Die Count"
      expr: bin_2_die_count
    - name: "Bin 3 Die Count"
      expr: bin_3_die_count
    - name: "Checkpoint Code"
      expr: checkpoint_code
    - name: "Comments"
      expr: comments
    - name: "Design Loss Die Count"
      expr: design_loss_die_count
    - name: "Disposition Status"
      expr: disposition_status
    - name: "Excursion Severity Level"
      expr: excursion_severity_level
    - name: "Good Die Count"
      expr: good_die_count
    - name: "Gross Die Count"
      expr: gross_die_count
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "Process Loss Die Count"
      expr: process_loss_die_count
    - name: "Random Defect Die Count"
      expr: random_defect_die_count
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fab Yield Record"
      expr: COUNT(DISTINCT fab_yield_record_id)
    - name: "Total Yield For Lot"
      expr: SUM(yield_for_lot)
    - name: "Average Yield For Lot"
      expr: AVG(yield_for_lot)
    - name: "Total Yield Percentage"
      expr: SUM(yield_percentage)
    - name: "Average Yield Percentage"
      expr: AVG(yield_percentage)
    - name: "Total Yield Record For Lot"
      expr: SUM(yield_record_for_lot)
    - name: "Average Yield Record For Lot"
      expr: AVG(yield_record_for_lot)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fabrication_process_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fabrication Process Recipe business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_process_recipe`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Chamber Configuration"
      expr: chamber_configuration
    - name: "Change Control Reference"
      expr: change_control_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Environmental Compliance Flag"
      expr: environmental_compliance_flag
    - name: "Equipment Type"
      expr: equipment_type
    - name: "Fmea Reference"
      expr: fmea_reference
    - name: "Gas Flow Parameters"
      expr: gas_flow_parameters
    - name: "Itar Controlled Flag"
      expr: itar_controlled_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Process Duration Seconds"
      expr: process_duration_seconds
    - name: "Process Layer Type"
      expr: process_layer_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fabrication Process Recipe"
      expr: COUNT(DISTINCT fabrication_process_recipe_id)
    - name: "Total Power Settings Watts"
      expr: SUM(power_settings_watts)
    - name: "Average Power Settings Watts"
      expr: AVG(power_settings_watts)
    - name: "Total Process Pressure Torr"
      expr: SUM(process_pressure_torr)
    - name: "Average Process Pressure Torr"
      expr: AVG(process_pressure_torr)
    - name: "Total Process Temperature Celsius"
      expr: SUM(process_temperature_celsius)
    - name: "Average Process Temperature Celsius"
      expr: AVG(process_temperature_celsius)
    - name: "Total Target Thickness Nm"
      expr: SUM(target_thickness_nm)
    - name: "Average Target Thickness Nm"
      expr: AVG(target_thickness_nm)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fabrication_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fabrication Wafer Lot business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`"
  dimensions:
    - name: "Actual Completion Timestamp"
      expr: actual_completion_timestamp
    - name: "Current Operation Name"
      expr: current_operation_name
    - name: "Current Operation Number"
      expr: current_operation_number
    - name: "Current Process Area"
      expr: current_process_area
    - name: "Due Date"
      expr: due_date
    - name: "Fab Facility Code"
      expr: fab_facility_code
    - name: "Hold Flag"
      expr: hold_flag
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Hold Timestamp"
      expr: hold_timestamp
    - name: "Initial Wafer Count"
      expr: initial_wafer_count
    - name: "Is Hot Lot"
      expr: is_hot_lot
    - name: "Lot Created Timestamp"
      expr: lot_created_timestamp
    - name: "Lot Disposition"
      expr: lot_disposition
    - name: "Lot Notes"
      expr: lot_notes
    - name: "Lot Number"
      expr: lot_number
    - name: "Lot Type"
      expr: lot_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fabrication Wafer Lot"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
    - name: "Total Cycle Time Days"
      expr: SUM(cycle_time_days)
    - name: "Average Cycle Time Days"
      expr: AVG(cycle_time_days)
    - name: "Total Lot On Node"
      expr: SUM(lot_on_node)
    - name: "Average Lot On Node"
      expr: AVG(lot_on_node)
    - name: "Total Process Time Hours"
      expr: SUM(process_time_hours)
    - name: "Average Process Time Hours"
      expr: AVG(process_time_hours)
    - name: "Total Queue Time Hours"
      expr: SUM(queue_time_hours)
    - name: "Average Queue Time Hours"
      expr: AVG(queue_time_hours)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot Hold business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`lot_hold`"
  dimensions:
    - name: "Approval Required"
      expr: approval_required
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Required"
      expr: customer_notification_required
    - name: "Customer Notification Timestamp"
      expr: customer_notification_timestamp
    - name: "Defect Density Threshold Exceeded"
      expr: defect_density_threshold_exceeded
    - name: "Disposition Action"
      expr: disposition_action
    - name: "Disposition Notes"
      expr: disposition_notes
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Hold Expiration Timestamp"
      expr: hold_expiration_timestamp
    - name: "Hold Placement Timestamp"
      expr: hold_placement_timestamp
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Hold Reason Description"
      expr: hold_reason_description
    - name: "Hold Release Timestamp"
      expr: hold_release_timestamp
    - name: "Hold Status"
      expr: hold_status
    - name: "Hold Type"
      expr: hold_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lot Hold"
      expr: COUNT(DISTINCT lot_hold_id)
    - name: "Total Hold Cycle Time Hours"
      expr: SUM(hold_cycle_time_hours)
    - name: "Average Hold Cycle Time Hours"
      expr: AVG(hold_cycle_time_hours)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_move`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot Move business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`lot_move`"
  dimensions:
    - name: "Comments"
      expr: comments
    - name: "Control Job Code"
      expr: control_job_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Defect Count"
      expr: defect_count
    - name: "Disposition"
      expr: disposition
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Move In Timestamp"
      expr: move_in_timestamp
    - name: "Move Out Timestamp"
      expr: move_out_timestamp
    - name: "Move Status"
      expr: move_status
    - name: "Priority Code"
      expr: priority_code
    - name: "Process Layer"
      expr: process_layer
    - name: "Process Module"
      expr: process_module
    - name: "Process Time Seconds"
      expr: process_time_seconds
    - name: "Quantity In"
      expr: quantity_in
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lot Move"
      expr: COUNT(DISTINCT lot_move_id)
    - name: "Total Actual Flow Rate Sccm"
      expr: SUM(actual_flow_rate_sccm)
    - name: "Average Actual Flow Rate Sccm"
      expr: AVG(actual_flow_rate_sccm)
    - name: "Total Actual Power Watts"
      expr: SUM(actual_power_watts)
    - name: "Average Actual Power Watts"
      expr: AVG(actual_power_watts)
    - name: "Total Actual Pressure Torr"
      expr: SUM(actual_pressure_torr)
    - name: "Average Actual Pressure Torr"
      expr: AVG(actual_pressure_torr)
    - name: "Total Actual Temperature C"
      expr: SUM(actual_temperature_c)
    - name: "Average Actual Temperature C"
      expr: AVG(actual_temperature_c)
    - name: "Total At Step"
      expr: SUM(at_step)
    - name: "Average At Step"
      expr: AVG(at_step)
    - name: "Total Measurement Value"
      expr: SUM(measurement_value)
    - name: "Average Measurement Value"
      expr: AVG(measurement_value)
    - name: "Total Tracks Lot"
      expr: SUM(tracks_lot)
    - name: "Average Tracks Lot"
      expr: AVG(tracks_lot)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_photomask`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Photomask business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`photomask`"
  dimensions:
    - name: "Cleaning Cycle Count"
      expr: cleaning_cycle_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Defect Count"
      expr: critical_defect_count
    - name: "Cumulative Usage Count"
      expr: cumulative_usage_count
    - name: "Defect Count Last Inspection"
      expr: defect_count_last_inspection
    - name: "Defect Retirement Threshold"
      expr: defect_retirement_threshold
    - name: "Gds File Checksum"
      expr: gds_file_checksum
    - name: "Last Cleaning Date"
      expr: last_cleaning_date
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Layer Name"
      expr: layer_name
    - name: "Lithography Wavelength"
      expr: lithography_wavelength
    - name: "Mask Generation"
      expr: mask_generation
    - name: "Mask Serial Number"
      expr: mask_serial_number
    - name: "Mask Status"
      expr: mask_status
    - name: "Mask Type"
      expr: mask_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Photomask"
      expr: COUNT(DISTINCT photomask_id)
    - name: "Total Acquisition Cost"
      expr: SUM(acquisition_cost)
    - name: "Average Acquisition Cost"
      expr: AVG(acquisition_cost)
    - name: "Total Cd Uniformity Specification"
      expr: SUM(cd_uniformity_specification)
    - name: "Average Cd Uniformity Specification"
      expr: AVG(cd_uniformity_specification)
    - name: "Total Critical Dimension Target Nm"
      expr: SUM(critical_dimension_target_nm)
    - name: "Average Critical Dimension Target Nm"
      expr: AVG(critical_dimension_target_nm)
    - name: "Total Cumulative Exposure Hours"
      expr: SUM(cumulative_exposure_hours)
    - name: "Average Cumulative Exposure Hours"
      expr: AVG(cumulative_exposure_hours)
    - name: "Total Meef Value"
      expr: SUM(meef_value)
    - name: "Average Meef Value"
      expr: AVG(meef_value)
    - name: "Total Registration Error Specification Nm"
      expr: SUM(registration_error_specification_nm)
    - name: "Average Registration Error Specification Nm"
      expr: AVG(registration_error_specification_nm)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process Flow business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`process_flow`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Beol Step Count"
      expr: beol_step_count
    - name: "Cool Optimization Mode"
      expr: cool_optimization_mode
    - name: "Coolant Type"
      expr: coolant_type
    - name: "Cooling Method"
      expr: cooling_method
    - name: "Cooling Optimization Mode"
      expr: cooling_optimization_mode
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Environmental Classification"
      expr: environmental_classification
    - name: "Export Control Classification"
      expr: export_control_classification
    - name: "Fab Facility Code"
      expr: fab_facility_code
    - name: "Feol Step Count"
      expr: feol_step_count
    - name: "Flow Code"
      expr: flow_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Process Flow"
      expr: COUNT(DISTINCT process_flow_id)
    - name: "Total Estimated Cycle Time Days"
      expr: SUM(estimated_cycle_time_days)
    - name: "Average Estimated Cycle Time Days"
      expr: AVG(estimated_cycle_time_days)
    - name: "Total Target Yield Percent"
      expr: SUM(target_yield_percent)
    - name: "Average Target Yield Percent"
      expr: AVG(target_yield_percent)
    - name: "Total Waste Elimination Target Pct"
      expr: SUM(waste_elimination_target_pct)
    - name: "Average Waste Elimination Target Pct"
      expr: AVG(waste_elimination_target_pct)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_process_flow_step_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process Flow Step Recipe business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`process_flow_step_recipe`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Mandatory Step"
      expr: is_mandatory_step
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Modified By"
      expr: modified_by
    - name: "Step Description"
      expr: step_description
    - name: "Step Sequence Number"
      expr: step_sequence_number
    - name: "Step Type"
      expr: step_type
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Process Flow Step Recipe"
      expr: COUNT(DISTINCT process_flow_step_recipe_id)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_technology_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technology Node business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`technology_node`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Rule Complexity"
      expr: design_rule_complexity
    - name: "Dfm Enabled Flag"
      expr: dfm_enabled_flag
    - name: "Dft Enabled Flag"
      expr: dft_enabled_flag
    - name: "Ear Classification"
      expr: ear_classification
    - name: "Eol Announcement Date"
      expr: eol_announcement_date
    - name: "Iatf16949 Certified Flag"
      expr: iatf16949_certified_flag
    - name: "Iso9001 Certified Flag"
      expr: iso9001_certified_flag
    - name: "Itar Controlled Flag"
      expr: itar_controlled_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lithography Technology"
      expr: lithography_technology
    - name: "Metal Layer Count"
      expr: metal_layer_count
    - name: "Modified By User"
      expr: modified_by_user
    - name: "Node Code"
      expr: node_code
    - name: "Node Generation"
      expr: node_generation
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Technology Node"
      expr: COUNT(DISTINCT technology_node_id)
    - name: "Total Mask Set Cost Usd"
      expr: SUM(mask_set_cost_usd)
    - name: "Average Mask Set Cost Usd"
      expr: AVG(mask_set_cost_usd)
    - name: "Total Minimum Feature Size Nm"
      expr: SUM(minimum_feature_size_nm)
    - name: "Average Minimum Feature Size Nm"
      expr: AVG(minimum_feature_size_nm)
    - name: "Total Nre Cost Estimate Usd"
      expr: SUM(nre_cost_estimate_usd)
    - name: "Average Nre Cost Estimate Usd"
      expr: AVG(nre_cost_estimate_usd)
    - name: "Total Target Yield Percent"
      expr: SUM(target_yield_percent)
    - name: "Average Target Yield Percent"
      expr: AVG(target_yield_percent)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_wafer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`wafer`"
  dimensions:
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Critical Defect Count"
      expr: critical_defect_count
    - name: "Crystal Orientation"
      expr: crystal_orientation
    - name: "Current Operation Number"
      expr: current_operation_number
    - name: "Current Process Step"
      expr: current_process_step
    - name: "Defect Count"
      expr: defect_count
    - name: "Diameter Mm"
      expr: diameter_mm
    - name: "Disposition Status"
      expr: disposition_status
    - name: "Doping Type"
      expr: doping_type
    - name: "Epitaxial Layer Flag"
      expr: epitaxial_layer_flag
    - name: "Expected Die Count"
      expr: expected_die_count
    - name: "Genealogy Path"
      expr: genealogy_path
    - name: "Good Die Count"
      expr: good_die_count
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Inspection Timestamp"
      expr: inspection_timestamp
    - name: "Last Process Timestamp"
      expr: last_process_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Wafer"
      expr: COUNT(DISTINCT wafer_id)
    - name: "Total Belongs To Lot"
      expr: SUM(belongs_to_lot)
    - name: "Average Belongs To Lot"
      expr: AVG(belongs_to_lot)
    - name: "Total Epitaxial Resistivity Ohm Cm"
      expr: SUM(epitaxial_resistivity_ohm_cm)
    - name: "Average Epitaxial Resistivity Ohm Cm"
      expr: AVG(epitaxial_resistivity_ohm_cm)
    - name: "Total Epitaxial Thickness Um"
      expr: SUM(epitaxial_thickness_um)
    - name: "Average Epitaxial Thickness Um"
      expr: AVG(epitaxial_thickness_um)
    - name: "Total Resistivity Ohm Cm"
      expr: SUM(resistivity_ohm_cm)
    - name: "Average Resistivity Ohm Cm"
      expr: AVG(resistivity_ohm_cm)
    - name: "Total Thickness Um"
      expr: SUM(thickness_um)
    - name: "Average Thickness Um"
      expr: AVG(thickness_um)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_wafer_start`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer Start business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`wafer_start`"
  dimensions:
    - name: "Authorization Timestamp"
      expr: authorization_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crystal Orientation"
      expr: crystal_orientation
    - name: "Doping Type"
      expr: doping_type
    - name: "Ear Classification"
      expr: ear_classification
    - name: "Fab Facility Code"
      expr: fab_facility_code
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Itar Controlled Flag"
      expr: itar_controlled_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lot Number"
      expr: lot_number
    - name: "Nre Project Code"
      expr: nre_project_code
    - name: "Number"
      expr: number
    - name: "Parent Lot Number"
      expr: parent_lot_number
    - name: "Planned Completion Date"
      expr: planned_completion_date
    - name: "Priority Class"
      expr: priority_class
    - name: "Production Line"
      expr: production_line
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Wafer Start"
      expr: COUNT(DISTINCT wafer_start_id)
    - name: "Total Estimated Cycle Time Days"
      expr: SUM(estimated_cycle_time_days)
    - name: "Average Estimated Cycle Time Days"
      expr: AVG(estimated_cycle_time_days)
    - name: "Total Resistivity Ohm Cm"
      expr: SUM(resistivity_ohm_cm)
    - name: "Average Resistivity Ohm Cm"
      expr: AVG(resistivity_ohm_cm)
$$;