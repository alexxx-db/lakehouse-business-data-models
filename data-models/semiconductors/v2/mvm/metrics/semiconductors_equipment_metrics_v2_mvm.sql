-- Metric views for domain: equipment | Business: Semiconductors | Version: 2 | Generated on: 2026-06-27 11:25:39

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Calibration Record business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`calibration_record`"
  dimensions:
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Calibration Interval Days"
      expr: calibration_interval_days
    - name: "Calibration Method"
      expr: calibration_method
    - name: "Calibration Number"
      expr: calibration_number
    - name: "Calibration Record Status"
      expr: calibration_record_status
    - name: "Calibration Report Url"
      expr: calibration_report_url
    - name: "Calibration Result"
      expr: calibration_result
    - name: "Calibration Result Code"
      expr: calibration_result_code
    - name: "Calibration Source System"
      expr: calibration_source_system
    - name: "Calibration Standard"
      expr: calibration_standard
    - name: "Calibration Status"
      expr: calibration_status
    - name: "Calibration Timestamp"
      expr: calibration_timestamp
    - name: "Calibration Type"
      expr: calibration_type
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Comments"
      expr: comments
    - name: "Compliance Reference"
      expr: compliance_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Calibration Record"
      expr: COUNT(DISTINCT calibration_record_id)
    - name: "Total As Found Value"
      expr: SUM(as_found_value)
    - name: "Average As Found Value"
      expr: AVG(as_found_value)
    - name: "Total As Left Value"
      expr: SUM(as_left_value)
    - name: "Average As Left Value"
      expr: AVG(as_left_value)
    - name: "Total Measured Value"
      expr: SUM(measured_value)
    - name: "Average Measured Value"
      expr: AVG(measured_value)
    - name: "Total Measurement Uncertainty"
      expr: SUM(measurement_uncertainty)
    - name: "Average Measurement Uncertainty"
      expr: AVG(measurement_uncertainty)
    - name: "Total Nominal Value"
      expr: SUM(nominal_value)
    - name: "Average Nominal Value"
      expr: AVG(nominal_value)
    - name: "Total Tolerance"
      expr: SUM(tolerance)
    - name: "Average Tolerance"
      expr: AVG(tolerance)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_equipment_process_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment Process Recipe business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Audit Status"
      expr: audit_status
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Documentation Url"
      expr: documentation_url
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Active"
      expr: is_active
    - name: "Is Deprecated"
      expr: is_deprecated
    - name: "Last Audit Timestamp"
      expr: last_audit_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Used Timestamp"
      expr: last_used_timestamp
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Parameter Count"
      expr: parameter_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Equipment Process Recipe"
      expr: COUNT(DISTINCT equipment_process_recipe_id)
    - name: "Total Exposure Dose Mj Cm2"
      expr: SUM(exposure_dose_mj_cm2)
    - name: "Average Exposure Dose Mj Cm2"
      expr: AVG(exposure_dose_mj_cm2)
    - name: "Total Focus Offset Nm"
      expr: SUM(focus_offset_nm)
    - name: "Average Focus Offset Nm"
      expr: AVG(focus_offset_nm)
    - name: "Total Gas Flow Rate Sccm"
      expr: SUM(gas_flow_rate_sccm)
    - name: "Average Gas Flow Rate Sccm"
      expr: AVG(gas_flow_rate_sccm)
    - name: "Total Oee Actual Percent"
      expr: SUM(oee_actual_percent)
    - name: "Average Oee Actual Percent"
      expr: AVG(oee_actual_percent)
    - name: "Total Oee Target Percent"
      expr: SUM(oee_target_percent)
    - name: "Average Oee Target Percent"
      expr: AVG(oee_target_percent)
    - name: "Total Pressure Setpoint Pa"
      expr: SUM(pressure_setpoint_pa)
    - name: "Average Pressure Setpoint Pa"
      expr: AVG(pressure_setpoint_pa)
    - name: "Total Rf Power Watts"
      expr: SUM(rf_power_watts)
    - name: "Average Rf Power Watts"
      expr: AVG(rf_power_watts)
    - name: "Total Ssot Owner Reference"
      expr: SUM(ssot_owner_reference)
    - name: "Average Ssot Owner Reference"
      expr: AVG(ssot_owner_reference)
    - name: "Total Temperature Setpoint C"
      expr: SUM(temperature_setpoint_c)
    - name: "Average Temperature Setpoint C"
      expr: AVG(temperature_setpoint_c)
    - name: "Total Yield Actual Percent"
      expr: SUM(yield_actual_percent)
    - name: "Average Yield Actual Percent"
      expr: AVG(yield_actual_percent)
    - name: "Total Yield Target Percent"
      expr: SUM(yield_target_percent)
    - name: "Average Yield Target Percent"
      expr: AVG(yield_target_percent)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_fab_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fab Tool business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`fab_tool`"
  dimensions:
    - name: "Asset Status"
      expr: asset_status
    - name: "Asset Tag"
      expr: asset_tag
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Calibration Due Date"
      expr: calibration_due_date
    - name: "Cleanroom Class"
      expr: cleanroom_class
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Depreciation End Date"
      expr: depreciation_end_date
    - name: "Depreciation Start Date"
      expr: depreciation_start_date
    - name: "Fab Site Code"
      expr: fab_site_code
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Maintenance Interval Days"
      expr: maintenance_interval_days
    - name: "Manufacturer"
      expr: manufacturer
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fab Tool"
      expr: COUNT(DISTINCT fab_tool_id)
    - name: "Total Capacity Wafer Per Hour"
      expr: SUM(capacity_wafer_per_hour)
    - name: "Average Capacity Wafer Per Hour"
      expr: AVG(capacity_wafer_per_hour)
    - name: "Total Capital Expenditure Amount"
      expr: SUM(capital_expenditure_amount)
    - name: "Average Capital Expenditure Amount"
      expr: AVG(capital_expenditure_amount)
    - name: "Total Energy Consumption Kwh Per Year"
      expr: SUM(energy_consumption_kwh_per_year)
    - name: "Average Energy Consumption Kwh Per Year"
      expr: AVG(energy_consumption_kwh_per_year)
    - name: "Total Mtbf Hours"
      expr: SUM(mtbf_hours)
    - name: "Average Mtbf Hours"
      expr: AVG(mtbf_hours)
    - name: "Total Mttr Hours"
      expr: SUM(mttr_hours)
    - name: "Average Mttr Hours"
      expr: AVG(mttr_hours)
    - name: "Total Oee Percent"
      expr: SUM(oee_percent)
    - name: "Average Oee Percent"
      expr: AVG(oee_percent)
    - name: "Total Power Rating Kw"
      expr: SUM(power_rating_kw)
    - name: "Average Power Rating Kw"
      expr: AVG(power_rating_kw)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_maintenance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance Event business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`maintenance_event`"
  dimensions:
    - name: "Actual Duration Minutes"
      expr: actual_duration_minutes
    - name: "Baseline Change Flag"
      expr: baseline_change_flag
    - name: "Comments"
      expr: comments
    - name: "Compliance Regulation"
      expr: compliance_regulation
    - name: "Cost Currency"
      expr: cost_currency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Downtime Duration Minutes"
      expr: downtime_duration_minutes
    - name: "Downtime Minutes"
      expr: downtime_minutes
    - name: "Eco Reference"
      expr: eco_reference
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Event Description"
      expr: event_description
    - name: "Event Number"
      expr: event_number
    - name: "Event Status"
      expr: event_status
    - name: "Event Type"
      expr: event_type
    - name: "Failure Mode"
      expr: failure_mode
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Maintenance Event"
      expr: COUNT(DISTINCT maintenance_event_id)
    - name: "Total Downtime Hours"
      expr: SUM(downtime_hours)
    - name: "Average Downtime Hours"
      expr: AVG(downtime_hours)
    - name: "Total Labor Cost"
      expr: SUM(labor_cost)
    - name: "Average Labor Cost"
      expr: AVG(labor_cost)
    - name: "Total Labor Cost Total"
      expr: SUM(labor_cost_total)
    - name: "Average Labor Cost Total"
      expr: AVG(labor_cost_total)
    - name: "Total Labor Cost Usd"
      expr: SUM(labor_cost_usd)
    - name: "Average Labor Cost Usd"
      expr: AVG(labor_cost_usd)
    - name: "Total Labor Hours"
      expr: SUM(labor_hours)
    - name: "Average Labor Hours"
      expr: AVG(labor_hours)
    - name: "Total Oee Impact Percentage"
      expr: SUM(oee_impact_percentage)
    - name: "Average Oee Impact Percentage"
      expr: AVG(oee_impact_percentage)
    - name: "Total Parts Cost"
      expr: SUM(parts_cost)
    - name: "Average Parts Cost"
      expr: AVG(parts_cost)
    - name: "Total Parts Cost Total"
      expr: SUM(parts_cost_total)
    - name: "Average Parts Cost Total"
      expr: AVG(parts_cost_total)
    - name: "Total Parts Cost Usd"
      expr: SUM(parts_cost_usd)
    - name: "Average Parts Cost Usd"
      expr: AVG(parts_cost_usd)
    - name: "Total Total Cost"
      expr: SUM(total_cost)
    - name: "Average Total Cost"
      expr: AVG(total_cost)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_maintenance_parts_consumed`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance Parts Consumed business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`maintenance_parts_consumed`"
  dimensions:
    - name: "Consumption Timestamp"
      expr: consumption_timestamp
    - name: "Cost Currency"
      expr: cost_currency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Part Condition After"
      expr: part_condition_after
    - name: "Part Condition Before"
      expr: part_condition_before
    - name: "Planned Vs Unplanned"
      expr: planned_vs_unplanned
    - name: "Replacement Reason"
      expr: replacement_reason
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Warranty Claim Eligible"
      expr: warranty_claim_eligible
    - name: "Work Order Line Number"
      expr: work_order_line_number
    - name: "Consumption Timestamp Month"
      expr: DATE_TRUNC('MONTH', consumption_timestamp)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Maintenance Parts Consumed"
      expr: COUNT(DISTINCT maintenance_parts_consumed_id)
    - name: "Total Quantity Used"
      expr: SUM(quantity_used)
    - name: "Average Quantity Used"
      expr: AVG(quantity_used)
    - name: "Total Technician Code"
      expr: SUM(technician_code)
    - name: "Average Technician Code"
      expr: AVG(technician_code)
    - name: "Total Unit Cost At Time Of Use"
      expr: SUM(unit_cost_at_time_of_use)
    - name: "Average Unit Cost At Time Of Use"
      expr: AVG(unit_cost_at_time_of_use)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Oee Record business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`oee_record`"
  dimensions:
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Downtime Minutes"
      expr: downtime_minutes
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Good Units"
      expr: good_units
    - name: "Measurement Period"
      expr: measurement_period
    - name: "Model Lineage Source"
      expr: model_lineage_source
    - name: "Oee Calculation Method"
      expr: oee_calculation_method
    - name: "Period End Date"
      expr: period_end_date
    - name: "Period Start Date"
      expr: period_start_date
    - name: "Planned Production Minutes"
      expr: planned_production_minutes
    - name: "Record Date"
      expr: record_date
    - name: "Record Status"
      expr: record_status
    - name: "Responsible Party"
      expr: responsible_party
    - name: "Shift Date"
      expr: shift_date
    - name: "Shift Name"
      expr: shift_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Oee Record"
      expr: COUNT(DISTINCT oee_record_id)
    - name: "Total Availability Percent"
      expr: SUM(availability_percent)
    - name: "Average Availability Percent"
      expr: AVG(availability_percent)
    - name: "Total Availability Rate"
      expr: SUM(availability_rate)
    - name: "Average Availability Rate"
      expr: AVG(availability_rate)
    - name: "Total Available Hours"
      expr: SUM(available_hours)
    - name: "Average Available Hours"
      expr: AVG(available_hours)
    - name: "Total Downtime Hours"
      expr: SUM(downtime_hours)
    - name: "Average Downtime Hours"
      expr: AVG(downtime_hours)
    - name: "Total Engineering Hours"
      expr: SUM(engineering_hours)
    - name: "Average Engineering Hours"
      expr: AVG(engineering_hours)
    - name: "Total Idle Hours"
      expr: SUM(idle_hours)
    - name: "Average Idle Hours"
      expr: AVG(idle_hours)
    - name: "Total Oee Percent"
      expr: SUM(oee_percent)
    - name: "Average Oee Percent"
      expr: AVG(oee_percent)
    - name: "Total Oee Percentage"
      expr: SUM(oee_percentage)
    - name: "Average Oee Percentage"
      expr: AVG(oee_percentage)
    - name: "Total Performance Percent"
      expr: SUM(performance_percent)
    - name: "Average Performance Percent"
      expr: AVG(performance_percent)
    - name: "Total Performance Rate"
      expr: SUM(performance_rate)
    - name: "Average Performance Rate"
      expr: AVG(performance_rate)
    - name: "Total Productive Hours"
      expr: SUM(productive_hours)
    - name: "Average Productive Hours"
      expr: AVG(productive_hours)
    - name: "Total Quality Percent"
      expr: SUM(quality_percent)
    - name: "Average Quality Percent"
      expr: AVG(quality_percent)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pm Schedule business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`pm_schedule`"
  dimensions:
    - name: "Compliance Requirement"
      expr: compliance_requirement
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Estimated Downtime Minutes"
      expr: estimated_downtime_minutes
    - name: "Frequency Days"
      expr: frequency_days
    - name: "Frequency Interval"
      expr: frequency_interval
    - name: "Interval Unit"
      expr: interval_unit
    - name: "Interval Value"
      expr: interval_value
    - name: "Is Critical"
      expr: is_critical
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Performed Date"
      expr: last_performed_date
    - name: "Last Pm Date"
      expr: last_pm_date
    - name: "Maintenance Window End"
      expr: maintenance_window_end
    - name: "Maintenance Window Start"
      expr: maintenance_window_start
    - name: "Model Lineage Source"
      expr: model_lineage_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pm Schedule"
      expr: COUNT(DISTINCT pm_schedule_id)
    - name: "Total Estimated Duration Hours"
      expr: SUM(estimated_duration_hours)
    - name: "Average Estimated Duration Hours"
      expr: AVG(estimated_duration_hours)
    - name: "Total Oee Impact Estimate"
      expr: SUM(oee_impact_estimate)
    - name: "Average Oee Impact Estimate"
      expr: AVG(oee_impact_estimate)
    - name: "Total Work Order Template Code"
      expr: SUM(work_order_template_code)
    - name: "Average Work Order Template Code"
      expr: AVG(work_order_template_code)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_spare_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare Part business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`spare_part`"
  dimensions:
    - name: "Calibration Interval Days"
      expr: calibration_interval_days
    - name: "Calibration Required Flag"
      expr: calibration_required_flag
    - name: "Compliance Certifications"
      expr: compliance_certifications
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criticality"
      expr: criticality
    - name: "Criticality Rating"
      expr: criticality_rating
    - name: "Currency Code"
      expr: currency_code
    - name: "Current Stock Qty"
      expr: current_stock_qty
    - name: "Disposal Method"
      expr: disposal_method
    - name: "Hazardous Material Flag"
      expr: hazardous_material_flag
    - name: "Inspection Status"
      expr: inspection_status
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Received Date"
      expr: last_received_date
    - name: "Last Used Date"
      expr: last_used_date
    - name: "Lead Time Days"
      expr: lead_time_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Spare Part"
      expr: COUNT(DISTINCT spare_part_id)
    - name: "Total Part Volume Cm3"
      expr: SUM(part_volume_cm3)
    - name: "Average Part Volume Cm3"
      expr: AVG(part_volume_cm3)
    - name: "Total Part Weight Kg"
      expr: SUM(part_weight_kg)
    - name: "Average Part Weight Kg"
      expr: AVG(part_weight_kg)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
    - name: "Total Unit Cost Usd"
      expr: SUM(unit_cost_usd)
    - name: "Average Unit Cost Usd"
      expr: AVG(unit_cost_usd)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_chamber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool Chamber business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_chamber`"
  dimensions:
    - name: "Audit Last Date"
      expr: audit_last_date
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Calibration Status"
      expr: calibration_status
    - name: "Chamber Code"
      expr: chamber_code
    - name: "Chamber Name"
      expr: chamber_name
    - name: "Chamber Status"
      expr: chamber_status
    - name: "Chamber Status Reason"
      expr: chamber_status_reason
    - name: "Chamber Type"
      expr: chamber_type
    - name: "Clean Interval Wafers"
      expr: clean_interval_wafers
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Calibration Result"
      expr: last_calibration_result
    - name: "Last Clean Date"
      expr: last_clean_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tool Chamber"
      expr: COUNT(DISTINCT tool_chamber_id)
    - name: "Total Chamber Lifetime Hours"
      expr: SUM(chamber_lifetime_hours)
    - name: "Average Chamber Lifetime Hours"
      expr: AVG(chamber_lifetime_hours)
    - name: "Total Gas Flow Rate Sccm"
      expr: SUM(gas_flow_rate_sccm)
    - name: "Average Gas Flow Rate Sccm"
      expr: AVG(gas_flow_rate_sccm)
    - name: "Total Max Pressure Torr"
      expr: SUM(max_pressure_torr)
    - name: "Average Max Pressure Torr"
      expr: AVG(max_pressure_torr)
    - name: "Total Max Temperature C"
      expr: SUM(max_temperature_c)
    - name: "Average Max Temperature C"
      expr: AVG(max_temperature_c)
    - name: "Total Mtbf Hours"
      expr: SUM(mtbf_hours)
    - name: "Average Mtbf Hours"
      expr: AVG(mtbf_hours)
    - name: "Total Mttr Hours"
      expr: SUM(mttr_hours)
    - name: "Average Mttr Hours"
      expr: AVG(mttr_hours)
    - name: "Total Oee Percentage"
      expr: SUM(oee_percentage)
    - name: "Average Oee Percentage"
      expr: AVG(oee_percentage)
    - name: "Total Pressure Setpoint Pa"
      expr: SUM(pressure_setpoint_pa)
    - name: "Average Pressure Setpoint Pa"
      expr: AVG(pressure_setpoint_pa)
    - name: "Total Temperature Setpoint C"
      expr: SUM(temperature_setpoint_c)
    - name: "Average Temperature Setpoint C"
      expr: AVG(temperature_setpoint_c)
    - name: "Total Throughput Pph"
      expr: SUM(throughput_pph)
    - name: "Average Throughput Pph"
      expr: AVG(throughput_pph)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool Downtime business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_downtime`"
  dimensions:
    - name: "Comments"
      expr: comments
    - name: "Corrective Action Taken"
      expr: corrective_action_taken
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Downtime Category"
      expr: downtime_category
    - name: "Downtime Code"
      expr: downtime_code
    - name: "Downtime Duration Minutes"
      expr: downtime_duration_minutes
    - name: "Downtime End Timestamp"
      expr: downtime_end_timestamp
    - name: "Downtime Minutes"
      expr: downtime_minutes
    - name: "Downtime Reason"
      expr: downtime_reason
    - name: "Downtime Reason Code"
      expr: downtime_reason_code
    - name: "Downtime Reason Description"
      expr: downtime_reason_description
    - name: "Downtime Start Timestamp"
      expr: downtime_start_timestamp
    - name: "Downtime State"
      expr: downtime_state
    - name: "Downtime Type"
      expr: downtime_type
    - name: "End Timestamp"
      expr: end_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tool Downtime"
      expr: COUNT(DISTINCT tool_downtime_id)
    - name: "Total Duration Hours"
      expr: SUM(duration_hours)
    - name: "Average Duration Hours"
      expr: AVG(duration_hours)
    - name: "Total Duration Minutes"
      expr: SUM(duration_minutes)
    - name: "Average Duration Minutes"
      expr: AVG(duration_minutes)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool Qualification business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_qualification`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Calibration Date"
      expr: calibration_date
    - name: "Calibration Status"
      expr: calibration_status
    - name: "Change Control Number"
      expr: change_control_number
    - name: "Compliance Approval Status"
      expr: compliance_approval_status
    - name: "Compliance Document Reference"
      expr: compliance_document_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Documentation Url"
      expr: documentation_url
    - name: "Equipment Serial Number"
      expr: equipment_serial_number
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Critical"
      expr: is_critical
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Maintenance Status"
      expr: maintenance_status
    - name: "Measurement Method"
      expr: measurement_method
    - name: "Model Lineage Source"
      expr: model_lineage_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tool Qualification"
      expr: COUNT(DISTINCT tool_qualification_id)
    - name: "Total Baseline Value"
      expr: SUM(baseline_value)
    - name: "Average Baseline Value"
      expr: AVG(baseline_value)
    - name: "Total Cpk Value"
      expr: SUM(cpk_value)
    - name: "Average Cpk Value"
      expr: AVG(cpk_value)
    - name: "Total Oee Impact"
      expr: SUM(oee_impact)
    - name: "Average Oee Impact"
      expr: AVG(oee_impact)
    - name: "Total Result Metric Value"
      expr: SUM(result_metric_value)
    - name: "Average Result Metric Value"
      expr: AVG(result_metric_value)
    - name: "Total Tolerance"
      expr: SUM(tolerance)
    - name: "Average Tolerance"
      expr: AVG(tolerance)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_spare_part_compatibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tool Spare Part Compatibility business metrics"
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_spare_part_compatibility`"
  dimensions:
    - name: "Compatibility Type"
      expr: compatibility_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criticality For Tool"
      expr: criticality_for_tool
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Equipment Compatible"
      expr: equipment_compatible
    - name: "Installation Procedure Reference"
      expr: installation_procedure_reference
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lead Time For Tool"
      expr: lead_time_for_tool
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tool Spare Part Compatibility"
      expr: COUNT(DISTINCT tool_spare_part_compatibility_id)
    - name: "Total Quantity Required Per Pm"
      expr: SUM(quantity_required_per_pm)
    - name: "Average Quantity Required Per Pm"
      expr: AVG(quantity_required_per_pm)
$$;