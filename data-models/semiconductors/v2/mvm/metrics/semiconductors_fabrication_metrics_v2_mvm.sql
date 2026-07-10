-- Metric views for domain: fabrication | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 14:15:10

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_equipment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment Run business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`equipment_run`"
  dimensions:
    - name: "Abort Reason"
      expr: abort_reason
    - name: "Alarm Count"
      expr: alarm_count
    - name: "Cmp Slurry Type"
      expr: cmp_slurry_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deposition Film Material"
      expr: deposition_film_material
    - name: "Implant Species"
      expr: implant_species
    - name: "Mes Transaction Code"
      expr: mes_transaction_code
    - name: "Process Type"
      expr: process_type
    - name: "Run End Timestamp"
      expr: run_end_timestamp
    - name: "Run Number"
      expr: run_number
    - name: "Run Start Timestamp"
      expr: run_start_timestamp
    - name: "Run Status"
      expr: run_status
    - name: "Wafer Count"
      expr: wafer_count
    - name: "Wafer Slot Map"
      expr: wafer_slot_map
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Run End Timestamp Month"
      expr: DATE_TRUNC('MONTH', run_end_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Equipment Run"
      expr: COUNT(DISTINCT equipment_run_id)
    - name: "Total Actual Pressure Torr"
      expr: SUM(actual_pressure_torr)
    - name: "Average Actual Pressure Torr"
      expr: AVG(actual_pressure_torr)
    - name: "Total Actual Temperature Celsius"
      expr: SUM(actual_temperature_celsius)
    - name: "Average Actual Temperature Celsius"
      expr: AVG(actual_temperature_celsius)
    - name: "Total Cmp Removal Rate Angstrom Per Min"
      expr: SUM(cmp_removal_rate_angstrom_per_min)
    - name: "Average Cmp Removal Rate Angstrom Per Min"
      expr: AVG(cmp_removal_rate_angstrom_per_min)
    - name: "Total Cmp Wiwnu Percent"
      expr: SUM(cmp_wiwnu_percent)
    - name: "Average Cmp Wiwnu Percent"
      expr: AVG(cmp_wiwnu_percent)
    - name: "Total Deposition Rate Angstrom Per Min"
      expr: SUM(deposition_rate_angstrom_per_min)
    - name: "Average Deposition Rate Angstrom Per Min"
      expr: AVG(deposition_rate_angstrom_per_min)
    - name: "Total Deposition Thickness Angstrom"
      expr: SUM(deposition_thickness_angstrom)
    - name: "Average Deposition Thickness Angstrom"
      expr: AVG(deposition_thickness_angstrom)
    - name: "Total Deposition Uniformity Percent"
      expr: SUM(deposition_uniformity_percent)
    - name: "Average Deposition Uniformity Percent"
      expr: AVG(deposition_uniformity_percent)
    - name: "Total Implant Dose Atoms Per Cm2"
      expr: SUM(implant_dose_atoms_per_cm2)
    - name: "Average Implant Dose Atoms Per Cm2"
      expr: AVG(implant_dose_atoms_per_cm2)
    - name: "Total Implant Energy Kev"
      expr: SUM(implant_energy_kev)
    - name: "Average Implant Energy Kev"
      expr: AVG(implant_energy_kev)
    - name: "Total Implant Tilt Angle Degrees"
      expr: SUM(implant_tilt_angle_degrees)
    - name: "Average Implant Tilt Angle Degrees"
      expr: AVG(implant_tilt_angle_degrees)
    - name: "Total Implant Twist Angle Degrees"
      expr: SUM(implant_twist_angle_degrees)
    - name: "Average Implant Twist Angle Degrees"
      expr: AVG(implant_twist_angle_degrees)
    - name: "Total Lithography Cd Measurement Nm"
      expr: SUM(lithography_cd_measurement_nm)
    - name: "Average Lithography Cd Measurement Nm"
      expr: AVG(lithography_cd_measurement_nm)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fab_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fab Facility business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`fab_facility`"
  dimensions:
    - name: "City"
      expr: city
    - name: "Cleanroom Class"
      expr: cleanroom_class
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Country Code"
      expr: country_code
    - name: "End Date"
      expr: end_date
    - name: "Environmental Certifications"
      expr: environmental_certifications
    - name: "Equipment Summary"
      expr: equipment_summary
    - name: "Facility Code"
      expr: facility_code
    - name: "Facility Name"
      expr: facility_name
    - name: "Facility Type"
      expr: facility_type
    - name: "Last Audit Date"
      expr: last_audit_date
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Lithography Type"
      expr: lithography_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fab Facility"
      expr: COUNT(DISTINCT fab_facility_id)
    - name: "Total Capacity Wafer Per Month"
      expr: SUM(capacity_wafer_per_month)
    - name: "Average Capacity Wafer Per Month"
      expr: AVG(capacity_wafer_per_month)
    - name: "Total Carbon Footprint Kgco2e"
      expr: SUM(carbon_footprint_kgco2e)
    - name: "Average Carbon Footprint Kgco2e"
      expr: AVG(carbon_footprint_kgco2e)
    - name: "Total Energy Consumption Mwh"
      expr: SUM(energy_consumption_mwh)
    - name: "Average Energy Consumption Mwh"
      expr: AVG(energy_consumption_mwh)
    - name: "Total Fab Area Sqft"
      expr: SUM(fab_area_sqft)
    - name: "Average Fab Area Sqft"
      expr: AVG(fab_area_sqft)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Waste Generated Tons"
      expr: SUM(waste_generated_tons)
    - name: "Average Waste Generated Tons"
      expr: AVG(waste_generated_tons)
    - name: "Total Water Usage M3"
      expr: SUM(water_usage_m3)
    - name: "Average Water Usage M3"
      expr: AVG(water_usage_m3)
$$;

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
    - name: "Total Control Limit Lower"
      expr: SUM(control_limit_lower)
    - name: "Average Control Limit Lower"
      expr: AVG(control_limit_lower)
    - name: "Total Control Limit Upper"
      expr: SUM(control_limit_upper)
    - name: "Average Control Limit Upper"
      expr: AVG(control_limit_upper)
    - name: "Total Specification Limit Lower"
      expr: SUM(specification_limit_lower)
    - name: "Average Specification Limit Lower"
      expr: AVG(specification_limit_lower)
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
    - name: "Lot Updated Timestamp"
      expr: lot_updated_timestamp
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
    - name: "Fabrication Process Flow Description"
      expr: fabrication_process_flow_description
    - name: "Feol Step Count"
      expr: feol_step_count
    - name: "Flow Revision"
      expr: flow_revision
    - name: "Flow Status"
      expr: flow_status
    - name: "Flow Type"
      expr: flow_type
    - name: "Is Customer Specific"
      expr: is_customer_specific
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
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
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_process_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process Recipe business metrics"
  source: "`vibe_semiconductors_v1`.`fabrication`.`process_recipe`"
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
    - name: "Distinct Process Recipe"
      expr: COUNT(DISTINCT process_recipe_id)
    - name: "Total Defect Density Target Per Cm2"
      expr: SUM(defect_density_target_per_cm2)
    - name: "Average Defect Density Target Per Cm2"
      expr: AVG(defect_density_target_per_cm2)
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
    - name: "Total Uniformity Target Percent"
      expr: SUM(uniformity_target_percent)
    - name: "Average Uniformity Target Percent"
      expr: AVG(uniformity_target_percent)
    - name: "Total Yield Target Percent"
      expr: SUM(yield_target_percent)
    - name: "Average Yield Target Percent"
      expr: AVG(yield_target_percent)
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
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Itar Controlled Flag"
      expr: itar_controlled_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lot Number"
      expr: lot_number
    - name: "Parent Lot Number"
      expr: parent_lot_number
    - name: "Planned Completion Date"
      expr: planned_completion_date
    - name: "Priority Class"
      expr: priority_class
    - name: "Production Line"
      expr: production_line
    - name: "Release Timestamp"
      expr: release_timestamp
    - name: "Requested Delivery Date"
      expr: requested_delivery_date
    - name: "Special Instructions"
      expr: special_instructions
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