-- Metric views for domain: manufacturing | Business: Automotive | Version: 2 | Generated on: 2026-07-14 04:29:52

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_build_sequence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Build Sequence business metrics"
  source: "`vibe_automotive_v1`.`manufacturing`.`build_sequence`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Assembly Stage"
      expr: assembly_stage
    - name: "Body Style Code"
      expr: body_style_code
    - name: "Build Type"
      expr: build_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Market Code"
      expr: destination_market_code
    - name: "Drive Configuration"
      expr: drive_configuration
    - name: "Exterior Color Code"
      expr: exterior_color_code
    - name: "Freeze Timestamp"
      expr: freeze_timestamp
    - name: "Interior Color Code"
      expr: interior_color_code
    - name: "Is Frozen"
      expr: is_frozen
    - name: "Is Priority Build"
      expr: is_priority_build
    - name: "Jis Call Off Timestamp"
      expr: jis_call_off_timestamp
    - name: "Mes Sequence Reference"
      expr: mes_sequence_reference
    - name: "Model Year"
      expr: model_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Build Sequence"
      expr: COUNT(DISTINCT build_sequence_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity Plan business metrics"
  source: "`vibe_automotive_v1`.`manufacturing`.`capacity_plan`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Approved By"
      expr: approved_by
    - name: "Bottleneck Constraint Description"
      expr: bottleneck_constraint_description
    - name: "Capacity Gap Units"
      expr: capacity_gap_units
    - name: "Capacity Plan Type"
      expr: capacity_plan_type
    - name: "Capex Required"
      expr: capex_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Daily Production Target"
      expr: daily_production_target
    - name: "Demonstrated Capacity Units"
      expr: demonstrated_capacity_units
    - name: "Eop Date"
      expr: eop_date
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Headcount Required"
      expr: headcount_required
    - name: "Is Bottleneck Constrained"
      expr: is_bottleneck_constrained
    - name: "Model Year"
      expr: model_year
    - name: "Number Of Shifts"
      expr: number_of_shifts
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Capacity Plan"
      expr: COUNT(DISTINCT capacity_plan_id)
    - name: "Total Available Hours"
      expr: SUM(available_hours)
    - name: "Average Available Hours"
      expr: AVG(available_hours)
    - name: "Total Capacity Utilization Percent"
      expr: SUM(capacity_utilization_percent)
    - name: "Average Capacity Utilization Percent"
      expr: AVG(capacity_utilization_percent)
    - name: "Total Capex Amount"
      expr: SUM(capex_amount)
    - name: "Average Capex Amount"
      expr: AVG(capex_amount)
    - name: "Total Changeover Hours"
      expr: SUM(changeover_hours)
    - name: "Average Changeover Hours"
      expr: AVG(changeover_hours)
    - name: "Total Planned Downtime Hours"
      expr: SUM(planned_downtime_hours)
    - name: "Average Planned Downtime Hours"
      expr: AVG(planned_downtime_hours)
    - name: "Total Planned Maintenance Hours"
      expr: SUM(planned_maintenance_hours)
    - name: "Average Planned Maintenance Hours"
      expr: AVG(planned_maintenance_hours)
    - name: "Total Planned Overtime Hours"
      expr: SUM(planned_overtime_hours)
    - name: "Average Planned Overtime Hours"
      expr: AVG(planned_overtime_hours)
    - name: "Total Rated Capacity Jph"
      expr: SUM(rated_capacity_jph)
    - name: "Average Rated Capacity Jph"
      expr: AVG(rated_capacity_jph)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_material_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Consumption business metrics"
  source: "`vibe_automotive_v1`.`manufacturing`.`material_consumption`"
  dimensions:
    - name: "Assembly Station Code"
      expr: assembly_station_code
    - name: "Batch Number"
      expr: batch_number
    - name: "Bom Item Number"
      expr: bom_item_number
    - name: "Consumption Status"
      expr: consumption_status
    - name: "Consumption Timestamp"
      expr: consumption_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Goods Movement Number"
      expr: goods_movement_number
    - name: "Goods Movement Type"
      expr: goods_movement_type
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Mes Transaction Code"
      expr: mes_transaction_code
    - name: "Model Year"
      expr: model_year
    - name: "Operation Number"
      expr: operation_number
    - name: "Original Goods Movement Number"
      expr: original_goods_movement_number
    - name: "Posting Date"
      expr: posting_date
    - name: "Powertrain Type"
      expr: powertrain_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material Consumption"
      expr: COUNT(DISTINCT material_consumption_id)
    - name: "Total Cost Variance Amount"
      expr: SUM(cost_variance_amount)
    - name: "Average Cost Variance Amount"
      expr: AVG(cost_variance_amount)
    - name: "Total Material Cost Amount"
      expr: SUM(material_cost_amount)
    - name: "Average Material Cost Amount"
      expr: AVG(material_cost_amount)
    - name: "Total Planned Quantity"
      expr: SUM(planned_quantity)
    - name: "Average Planned Quantity"
      expr: AVG(planned_quantity)
    - name: "Total Quantity Consumed"
      expr: SUM(quantity_consumed)
    - name: "Average Quantity Consumed"
      expr: AVG(quantity_consumed)
    - name: "Total Quantity Variance"
      expr: SUM(quantity_variance)
    - name: "Average Quantity Variance"
      expr: AVG(quantity_variance)
    - name: "Total Variance Percentage"
      expr: SUM(variance_percentage)
    - name: "Average Variance Percentage"
      expr: AVG(variance_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant business metrics"
  source: "`vibe_automotive_v1`.`manufacturing`.`plant`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Agv Enabled"
      expr: agv_enabled
    - name: "Annual Capacity Units"
      expr: annual_capacity_units
    - name: "City"
      expr: city
    - name: "Code"
      expr: plant_code
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Company Code"
      expr: company_code
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Daily Capacity Units"
      expr: daily_capacity_units
    - name: "Eop Date"
      expr: eop_date
    - name: "Epa Facility Code"
      expr: epa_facility_code
    - name: "Iatf 16949 Certified"
      expr: iatf_16949_certified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Plant"
      expr: COUNT(DISTINCT plant_id)
    - name: "Total Floor Area Sqm"
      expr: SUM(floor_area_sqm)
    - name: "Average Floor Area Sqm"
      expr: AVG(floor_area_sqm)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_production_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Bom business metrics"
  source: "`vibe_automotive_v1`.`manufacturing`.`production_bom`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Apqp Phase"
      expr: apqp_phase
    - name: "Assembly Type"
      expr: assembly_type
    - name: "Base Unit Of Measure"
      expr: base_unit_of_measure
    - name: "Bom Alternative"
      expr: bom_alternative
    - name: "Bom Description"
      expr: bom_description
    - name: "Bom Level"
      expr: bom_level
    - name: "Bom Status"
      expr: bom_status
    - name: "Bom Type"
      expr: bom_type
    - name: "Bom Usage"
      expr: bom_usage
    - name: "Bom Version"
      expr: bom_version
    - name: "Change Reason"
      expr: change_reason
    - name: "Component Count"
      expr: component_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eco Number"
      expr: eco_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Bom"
      expr: COUNT(DISTINCT production_bom_id)
    - name: "Total Base Quantity"
      expr: SUM(base_quantity)
    - name: "Average Base Quantity"
      expr: AVG(base_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_production_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Line business metrics"
  source: "`vibe_automotive_v1`.`manufacturing`.`production_line`"
  dimensions:
    - name: "Agv Integration Enabled"
      expr: agv_integration_enabled
    - name: "Automation Level"
      expr: automation_level
    - name: "Ckd Skd Capable"
      expr: ckd_skd_capable
    - name: "Conveyor Type"
      expr: conveyor_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eop Date"
      expr: eop_date
    - name: "Iatf Audit Status"
      expr: iatf_audit_status
    - name: "Jis Enabled"
      expr: jis_enabled
    - name: "Last Iatf Audit Date"
      expr: last_iatf_audit_date
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Line Code"
      expr: line_code
    - name: "Line Name"
      expr: line_name
    - name: "Line Status"
      expr: line_status
    - name: "Line Type"
      expr: line_type
    - name: "Mes Line Code"
      expr: mes_line_code
    - name: "Mixed Model Capable"
      expr: mixed_model_capable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Line"
      expr: COUNT(DISTINCT production_line_id)
    - name: "Total Current Jph"
      expr: SUM(current_jph)
    - name: "Average Current Jph"
      expr: AVG(current_jph)
    - name: "Total Designed Jph"
      expr: SUM(designed_jph)
    - name: "Average Designed Jph"
      expr: AVG(designed_jph)
    - name: "Total Energy Consumption Kwh Per Unit"
      expr: SUM(energy_consumption_kwh_per_unit)
    - name: "Average Energy Consumption Kwh Per Unit"
      expr: AVG(energy_consumption_kwh_per_unit)
    - name: "Total Floor Space Sqm"
      expr: SUM(floor_space_sqm)
    - name: "Average Floor Space Sqm"
      expr: AVG(floor_space_sqm)
    - name: "Total Line Length Meters"
      expr: SUM(line_length_meters)
    - name: "Average Line Length Meters"
      expr: AVG(line_length_meters)
    - name: "Total Max Vehicle Weight Kg"
      expr: SUM(max_vehicle_weight_kg)
    - name: "Average Max Vehicle Weight Kg"
      expr: AVG(max_vehicle_weight_kg)
    - name: "Total Takt Time Seconds"
      expr: SUM(takt_time_seconds)
    - name: "Average Takt Time Seconds"
      expr: AVG(takt_time_seconds)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Order business metrics"
  source: "`vibe_automotive_v1`.`manufacturing`.`production_order`"
  dimensions:
    - name: "Actual Finish Timestamp"
      expr: actual_finish_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Assembly Sequence Number"
      expr: assembly_sequence_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Hazardous Material Flag"
      expr: hazardous_material_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Mes Order Reference"
      expr: mes_order_reference
    - name: "Model Year"
      expr: model_year
    - name: "Order Date"
      expr: order_date
    - name: "Order Description"
      expr: order_description
    - name: "Order Number"
      expr: order_number
    - name: "Order Status"
      expr: order_status
    - name: "Order Type"
      expr: order_type
    - name: "Planned Finish Date"
      expr: planned_finish_date
    - name: "Planned Start Date"
      expr: planned_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Order"
      expr: COUNT(DISTINCT production_order_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Actual Labor Hours"
      expr: SUM(actual_labor_hours)
    - name: "Average Actual Labor Hours"
      expr: AVG(actual_labor_hours)
    - name: "Total Actual Machine Hours"
      expr: SUM(actual_machine_hours)
    - name: "Average Actual Machine Hours"
      expr: AVG(actual_machine_hours)
    - name: "Total Confirmed Quantity"
      expr: SUM(confirmed_quantity)
    - name: "Average Confirmed Quantity"
      expr: AVG(confirmed_quantity)
    - name: "Total Planned Labor Hours"
      expr: SUM(planned_labor_hours)
    - name: "Average Planned Labor Hours"
      expr: AVG(planned_labor_hours)
    - name: "Total Planned Machine Hours"
      expr: SUM(planned_machine_hours)
    - name: "Average Planned Machine Hours"
      expr: AVG(planned_machine_hours)
    - name: "Total Rework Quantity"
      expr: SUM(rework_quantity)
    - name: "Average Rework Quantity"
      expr: AVG(rework_quantity)
    - name: "Total Scrap Quantity"
      expr: SUM(scrap_quantity)
    - name: "Average Scrap Quantity"
      expr: AVG(scrap_quantity)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Target Quantity"
      expr: SUM(target_quantity)
    - name: "Average Target Quantity"
      expr: AVG(target_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Schedule business metrics"
  source: "`vibe_automotive_v1`.`manufacturing`.`production_schedule`"
  dimensions:
    - name: "Actual Quantity"
      expr: actual_quantity
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Assembly Process Stage"
      expr: assembly_process_stage
    - name: "Body Style"
      expr: body_style
    - name: "Build Sequence End"
      expr: build_sequence_end
    - name: "Build Sequence Start"
      expr: build_sequence_start
    - name: "Build Type"
      expr: build_type
    - name: "Calloff Transmission Time"
      expr: calloff_transmission_time
    - name: "Confirmed Quantity"
      expr: confirmed_quantity
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eop Date"
      expr: eop_date
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Freeze Horizon Date"
      expr: freeze_horizon_date
    - name: "Is Frozen"
      expr: is_frozen
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Schedule"
      expr: COUNT(DISTINCT production_schedule_id)
    - name: "Total Available Capacity Hours"
      expr: SUM(available_capacity_hours)
    - name: "Average Available Capacity Hours"
      expr: AVG(available_capacity_hours)
    - name: "Total Capacity Utilization Pct"
      expr: SUM(capacity_utilization_pct)
    - name: "Average Capacity Utilization Pct"
      expr: AVG(capacity_utilization_pct)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_routing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Routing business metrics"
  source: "`vibe_automotive_v1`.`manufacturing`.`routing`"
  dimensions:
    - name: "Change Approved By"
      expr: change_approved_by
    - name: "Change Approved Date"
      expr: change_approved_date
    - name: "Change Reason"
      expr: change_reason
    - name: "Code"
      expr: routing_code
    - name: "Compliance Standard"
      expr: compliance_standard
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Default"
      expr: is_default
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Material Type"
      expr: material_type
    - name: "Notes"
      expr: notes
    - name: "Operation Count"
      expr: operation_count
    - name: "Product Family"
      expr: product_family
    - name: "Quality Check Required"
      expr: quality_check_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Routing"
      expr: COUNT(DISTINCT routing_id)
    - name: "Total Total Cycle Time Minutes"
      expr: SUM(total_cycle_time_minutes)
    - name: "Average Total Cycle Time Minutes"
      expr: AVG(total_cycle_time_minutes)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_vehicle_build`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle Build business metrics"
  source: "`vibe_automotive_v1`.`manufacturing`.`vehicle_build`"
  dimensions:
    - name: "Assembly Line Code"
      expr: assembly_line_code
    - name: "Battery Serial Number"
      expr: battery_serial_number
    - name: "Body Shop End Timestamp"
      expr: body_shop_end_timestamp
    - name: "Body Shop Start Timestamp"
      expr: body_shop_start_timestamp
    - name: "Body Style"
      expr: body_style
    - name: "Bom Version"
      expr: bom_version
    - name: "Build End Timestamp"
      expr: build_end_timestamp
    - name: "Build Start Timestamp"
      expr: build_start_timestamp
    - name: "Build Status"
      expr: build_status
    - name: "Build Type"
      expr: build_type
    - name: "Chassis End Timestamp"
      expr: chassis_end_timestamp
    - name: "Chassis Start Timestamp"
      expr: chassis_start_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Of Line Test Result"
      expr: end_of_line_test_result
    - name: "Engine Serial Number"
      expr: engine_serial_number
    - name: "Final Assembly End Timestamp"
      expr: final_assembly_end_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vehicle Build"
      expr: COUNT(DISTINCT vehicle_build_id)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`manufacturing_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work Center business metrics"
  source: "`vibe_automotive_v1`.`manufacturing`.`work_center`"
  dimensions:
    - name: "Agv Integration Enabled"
      expr: agv_integration_enabled
    - name: "Automation Level"
      expr: automation_level
    - name: "Capacity Category"
      expr: capacity_category
    - name: "Category"
      expr: work_center_category
    - name: "Code"
      expr: code
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Decommissioning Date"
      expr: decommissioning_date
    - name: "Description"
      expr: description
    - name: "Is Bottleneck"
      expr: is_bottleneck
    - name: "Is Jis Enabled"
      expr: is_jis_enabled
    - name: "Is Quality Gate"
      expr: is_quality_gate
    - name: "Last Calibration Date"
      expr: last_calibration_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Location Description"
      expr: location_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Work Center"
      expr: COUNT(DISTINCT work_center_id)
    - name: "Total Available Capacity Hours Per Day"
      expr: SUM(available_capacity_hours_per_day)
    - name: "Average Available Capacity Hours Per Day"
      expr: AVG(available_capacity_hours_per_day)
    - name: "Total Cycle Time Seconds"
      expr: SUM(cycle_time_seconds)
    - name: "Average Cycle Time Seconds"
      expr: AVG(cycle_time_seconds)
    - name: "Total Energy Consumption Kw"
      expr: SUM(energy_consumption_kw)
    - name: "Average Energy Consumption Kw"
      expr: AVG(energy_consumption_kw)
    - name: "Total Floor Area Sqm"
      expr: SUM(floor_area_sqm)
    - name: "Average Floor Area Sqm"
      expr: AVG(floor_area_sqm)
    - name: "Total Labor Rate Per Hour"
      expr: SUM(labor_rate_per_hour)
    - name: "Average Labor Rate Per Hour"
      expr: AVG(labor_rate_per_hour)
    - name: "Total Machine Rate Per Hour"
      expr: SUM(machine_rate_per_hour)
    - name: "Average Machine Rate Per Hour"
      expr: AVG(machine_rate_per_hour)
    - name: "Total Mean Time Between Failures Hours"
      expr: SUM(mean_time_between_failures_hours)
    - name: "Average Mean Time Between Failures Hours"
      expr: AVG(mean_time_between_failures_hours)
    - name: "Total Mean Time To Repair Hours"
      expr: SUM(mean_time_to_repair_hours)
    - name: "Average Mean Time To Repair Hours"
      expr: AVG(mean_time_to_repair_hours)
    - name: "Total Overhead Rate Percent"
      expr: SUM(overhead_rate_percent)
    - name: "Average Overhead Rate Percent"
      expr: AVG(overhead_rate_percent)
    - name: "Total Setup Time Minutes"
      expr: SUM(setup_time_minutes)
    - name: "Average Setup Time Minutes"
      expr: AVG(setup_time_minutes)
    - name: "Total Takt Time Seconds"
      expr: SUM(takt_time_seconds)
    - name: "Average Takt Time Seconds"
      expr: AVG(takt_time_seconds)
    - name: "Total Teardown Time Minutes"
      expr: SUM(teardown_time_minutes)
    - name: "Average Teardown Time Minutes"
      expr: AVG(teardown_time_minutes)
$$;
