-- Metric views for domain: production | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 14:41:45

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_bom_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bom Consumption business metrics"
  source: "`vibe_manufacturing_v1`.`production`.`bom_consumption`"
  dimensions:
    - name: "Backflush Indicator"
      expr: backflush_indicator
    - name: "Consumption Notes"
      expr: consumption_notes
    - name: "Consumption Status"
      expr: consumption_status
    - name: "Consumption Type"
      expr: consumption_type
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Goods Issue Number"
      expr: goods_issue_number
    - name: "Goods Issue Timestamp"
      expr: goods_issue_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Movement Type"
      expr: movement_type
    - name: "Operation Number"
      expr: operation_number
    - name: "Original Goods Issue Number"
      expr: original_goods_issue_number
    - name: "Posting Date"
      expr: posting_date
    - name: "Quality Inspection Required"
      expr: quality_inspection_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bom Consumption"
      expr: COUNT(DISTINCT bom_consumption_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Actual Quantity"
      expr: SUM(actual_quantity)
    - name: "Average Actual Quantity"
      expr: AVG(actual_quantity)
    - name: "Total Planned Quantity"
      expr: SUM(planned_quantity)
    - name: "Average Planned Quantity"
      expr: AVG(planned_quantity)
    - name: "Total Scrap Quantity"
      expr: SUM(scrap_quantity)
    - name: "Average Scrap Quantity"
      expr: AVG(scrap_quantity)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Total Cost"
      expr: SUM(total_cost)
    - name: "Average Total Cost"
      expr: AVG(total_cost)
    - name: "Total Variance Quantity"
      expr: SUM(variance_quantity)
    - name: "Average Variance Quantity"
      expr: AVG(variance_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_order_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order Confirmation business metrics"
  source: "`vibe_manufacturing_v1`.`production`.`order_confirmation`"
  dimensions:
    - name: "Activity Type"
      expr: activity_type
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Confirmation Status"
      expr: confirmation_status
    - name: "Confirmation Timestamp"
      expr: confirmation_timestamp
    - name: "Confirmation Type"
      expr: confirmation_type
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Final Confirmation Flag"
      expr: final_confirmation_flag
    - name: "Goods Movement Type"
      expr: goods_movement_type
    - name: "Last Modified By User"
      expr: last_modified_by_user
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Material Document Number"
      expr: material_document_number
    - name: "Mes Transaction Code"
      expr: mes_transaction_code
    - name: "Operation Number"
      expr: operation_number
    - name: "Plant Code"
      expr: plant_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Order Confirmation"
      expr: COUNT(DISTINCT order_confirmation_id)
    - name: "Total Actual Cost Amount"
      expr: SUM(actual_cost_amount)
    - name: "Average Actual Cost Amount"
      expr: AVG(actual_cost_amount)
    - name: "Total Actual Labor Hours"
      expr: SUM(actual_labor_hours)
    - name: "Average Actual Labor Hours"
      expr: AVG(actual_labor_hours)
    - name: "Total Actual Machine Hours"
      expr: SUM(actual_machine_hours)
    - name: "Average Actual Machine Hours"
      expr: AVG(actual_machine_hours)
    - name: "Total Rework Quantity"
      expr: SUM(rework_quantity)
    - name: "Average Rework Quantity"
      expr: AVG(rework_quantity)
    - name: "Total Scrap Quantity"
      expr: SUM(scrap_quantity)
    - name: "Average Scrap Quantity"
      expr: AVG(scrap_quantity)
    - name: "Total Setup Time Hours"
      expr: SUM(setup_time_hours)
    - name: "Average Setup Time Hours"
      expr: AVG(setup_time_hours)
    - name: "Total Standard Cost Amount"
      expr: SUM(standard_cost_amount)
    - name: "Average Standard Cost Amount"
      expr: AVG(standard_cost_amount)
    - name: "Total Teardown Time Hours"
      expr: SUM(teardown_time_hours)
    - name: "Average Teardown Time Hours"
      expr: AVG(teardown_time_hours)
    - name: "Total Yield Quantity"
      expr: SUM(yield_quantity)
    - name: "Average Yield Quantity"
      expr: AVG(yield_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_production_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Line business metrics"
  source: "`vibe_manufacturing_v1`.`production`.`production_line`"
  dimensions:
    - name: "Automation Level"
      expr: automation_level
    - name: "Capacity Constraint Flag"
      expr: capacity_constraint_flag
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Environmental Compliance Flag"
      expr: environmental_compliance_flag
    - name: "Erp Work Center Code"
      expr: erp_work_center_code
    - name: "Last Major Upgrade Date"
      expr: last_major_upgrade_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Layout Diagram Url"
      expr: layout_diagram_url
    - name: "Line Code"
      expr: line_code
    - name: "Line Name"
      expr: line_name
    - name: "Line Type"
      expr: line_type
    - name: "Mes Line Identifier"
      expr: mes_line_identifier
    - name: "Notes"
      expr: notes
    - name: "Number Of Stations"
      expr: number_of_stations
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Line"
      expr: COUNT(DISTINCT production_line_id)
    - name: "Total Actual Oee Percentage"
      expr: SUM(actual_oee_percentage)
    - name: "Average Actual Oee Percentage"
      expr: AVG(actual_oee_percentage)
    - name: "Total Changeover Time Minutes"
      expr: SUM(changeover_time_minutes)
    - name: "Average Changeover Time Minutes"
      expr: AVG(changeover_time_minutes)
    - name: "Total Cycle Time Seconds"
      expr: SUM(cycle_time_seconds)
    - name: "Average Cycle Time Seconds"
      expr: AVG(cycle_time_seconds)
    - name: "Total Design Throughput Rate"
      expr: SUM(design_throughput_rate)
    - name: "Average Design Throughput Rate"
      expr: AVG(design_throughput_rate)
    - name: "Total Energy Consumption Kwh Per Unit"
      expr: SUM(energy_consumption_kwh_per_unit)
    - name: "Average Energy Consumption Kwh Per Unit"
      expr: AVG(energy_consumption_kwh_per_unit)
    - name: "Total Mtbf Hours"
      expr: SUM(mtbf_hours)
    - name: "Average Mtbf Hours"
      expr: AVG(mtbf_hours)
    - name: "Total Mttr Hours"
      expr: SUM(mttr_hours)
    - name: "Average Mttr Hours"
      expr: AVG(mttr_hours)
    - name: "Total Planned Availability Hours Per Day"
      expr: SUM(planned_availability_hours_per_day)
    - name: "Average Planned Availability Hours Per Day"
      expr: AVG(planned_availability_hours_per_day)
    - name: "Total Setup Time Minutes"
      expr: SUM(setup_time_minutes)
    - name: "Average Setup Time Minutes"
      expr: AVG(setup_time_minutes)
    - name: "Total Takt Time Seconds"
      expr: SUM(takt_time_seconds)
    - name: "Average Takt Time Seconds"
      expr: AVG(takt_time_seconds)
    - name: "Total Target Oee Percentage"
      expr: SUM(target_oee_percentage)
    - name: "Average Target Oee Percentage"
      expr: AVG(target_oee_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_production_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Plant business metrics"
  source: "`vibe_manufacturing_v1`.`production`.`production_plant`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "City"
      expr: city
    - name: "Closure Date"
      expr: closure_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: production_plant_description
    - name: "Is Active"
      expr: is_active
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Maintenance Cycle Days"
      expr: maintenance_cycle_days
    - name: "Manager Email"
      expr: manager_email
    - name: "Manager Name"
      expr: manager_name
    - name: "Manager Phone"
      expr: manager_phone
    - name: "Name"
      expr: production_plant_name
    - name: "Next Maintenance Date"
      expr: next_maintenance_date
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Plant"
      expr: COUNT(DISTINCT production_plant_id)
    - name: "Total Capacity Mw"
      expr: SUM(capacity_mw)
    - name: "Average Capacity Mw"
      expr: AVG(capacity_mw)
    - name: "Total Carbon Emission Kg"
      expr: SUM(carbon_emission_kg)
    - name: "Average Carbon Emission Kg"
      expr: AVG(carbon_emission_kg)
    - name: "Total Energy Consumption Mwh"
      expr: SUM(energy_consumption_mwh)
    - name: "Average Energy Consumption Mwh"
      expr: AVG(energy_consumption_mwh)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Oee Actual"
      expr: SUM(oee_actual)
    - name: "Average Oee Actual"
      expr: AVG(oee_actual)
    - name: "Total Oee Target"
      expr: SUM(oee_target)
    - name: "Average Oee Target"
      expr: AVG(oee_target)
    - name: "Total Waste Generated Tons"
      expr: SUM(waste_generated_tons)
    - name: "Average Waste Generated Tons"
      expr: AVG(waste_generated_tons)
    - name: "Total Water Consumption M3"
      expr: SUM(water_consumption_m3)
    - name: "Average Water Consumption M3"
      expr: AVG(water_consumption_m3)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_production_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Work Order business metrics"
  source: "`vibe_manufacturing_v1`.`production`.`production_work_order`"
  dimensions:
    - name: "Actual Finish Timestamp"
      expr: actual_finish_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Batch Number"
      expr: batch_number
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Planned Finish Date"
      expr: planned_finish_date
    - name: "Planned Start Date"
      expr: planned_start_date
    - name: "Priority Code"
      expr: priority_code
    - name: "Production Notes"
      expr: production_notes
    - name: "Release Date"
      expr: release_date
    - name: "Unit Of Measure"
      expr: unit_of_measure
    - name: "Work Order Number"
      expr: work_order_number
    - name: "Work Order Status"
      expr: work_order_status
    - name: "Work Order Type"
      expr: work_order_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Work Order"
      expr: COUNT(DISTINCT production_work_order_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Actual Quantity"
      expr: SUM(actual_quantity)
    - name: "Average Actual Quantity"
      expr: AVG(actual_quantity)
    - name: "Total Completion Percentage"
      expr: SUM(completion_percentage)
    - name: "Average Completion Percentage"
      expr: AVG(completion_percentage)
    - name: "Total Cycle Time Minutes"
      expr: SUM(cycle_time_minutes)
    - name: "Average Cycle Time Minutes"
      expr: AVG(cycle_time_minutes)
    - name: "Total Downtime Minutes"
      expr: SUM(downtime_minutes)
    - name: "Average Downtime Minutes"
      expr: AVG(downtime_minutes)
    - name: "Total Oee Percentage"
      expr: SUM(oee_percentage)
    - name: "Average Oee Percentage"
      expr: AVG(oee_percentage)
    - name: "Total Planned Quantity"
      expr: SUM(planned_quantity)
    - name: "Average Planned Quantity"
      expr: AVG(planned_quantity)
    - name: "Total Scrap Quantity"
      expr: SUM(scrap_quantity)
    - name: "Average Scrap Quantity"
      expr: AVG(scrap_quantity)
    - name: "Total Scrap Rate Percentage"
      expr: SUM(scrap_rate_percentage)
    - name: "Average Scrap Rate Percentage"
      expr: AVG(scrap_rate_percentage)
    - name: "Total Setup Time Minutes"
      expr: SUM(setup_time_minutes)
    - name: "Average Setup Time Minutes"
      expr: AVG(setup_time_minutes)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Takt Time Minutes"
      expr: SUM(takt_time_minutes)
    - name: "Average Takt Time Minutes"
      expr: AVG(takt_time_minutes)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_routing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Routing business metrics"
  source: "`vibe_manufacturing_v1`.`production`.`routing`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Base Unit Of Measure"
      expr: base_unit_of_measure
    - name: "Change Number"
      expr: change_number
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Counter"
      expr: counter
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: routing_description
    - name: "Is Default Routing"
      expr: is_default_routing
    - name: "Is Phantom Routing"
      expr: is_phantom_routing
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Used Date"
      expr: last_used_date
    - name: "Planner Group"
      expr: planner_group
    - name: "Routing Group"
      expr: routing_group
    - name: "Routing Number"
      expr: routing_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Routing"
      expr: COUNT(DISTINCT routing_id)
    - name: "Total Base Quantity"
      expr: SUM(base_quantity)
    - name: "Average Base Quantity"
      expr: AVG(base_quantity)
    - name: "Total Lot Size From"
      expr: SUM(lot_size_from)
    - name: "Average Lot Size From"
      expr: AVG(lot_size_from)
    - name: "Total Lot Size To"
      expr: SUM(lot_size_to)
    - name: "Average Lot Size To"
      expr: AVG(lot_size_to)
    - name: "Total Standard Cost Amount"
      expr: SUM(standard_cost_amount)
    - name: "Average Standard Cost Amount"
      expr: AVG(standard_cost_amount)
    - name: "Total Total Labor Time Minutes"
      expr: SUM(total_labor_time_minutes)
    - name: "Average Total Labor Time Minutes"
      expr: AVG(total_labor_time_minutes)
    - name: "Total Total Lead Time Hours"
      expr: SUM(total_lead_time_hours)
    - name: "Average Total Lead Time Hours"
      expr: AVG(total_lead_time_hours)
    - name: "Total Total Machine Time Minutes"
      expr: SUM(total_machine_time_minutes)
    - name: "Average Total Machine Time Minutes"
      expr: AVG(total_machine_time_minutes)
    - name: "Total Total Setup Time Minutes"
      expr: SUM(total_setup_time_minutes)
    - name: "Average Total Setup Time Minutes"
      expr: AVG(total_setup_time_minutes)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Run business metrics"
  source: "`vibe_manufacturing_v1`.`production`.`run`"
  dimensions:
    - name: "Actual Finish Timestamp"
      expr: actual_finish_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Campaign Code"
      expr: campaign_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Planned Finish Timestamp"
      expr: planned_finish_timestamp
    - name: "Planned Start Timestamp"
      expr: planned_start_timestamp
    - name: "Priority Code"
      expr: priority_code
    - name: "Run Number"
      expr: run_number
    - name: "Run Status"
      expr: run_status
    - name: "Run Type"
      expr: run_type
    - name: "Unit Of Measure"
      expr: unit_of_measure
    - name: "Work Order Count"
      expr: work_order_count
    - name: "Actual Finish Timestamp Month"
      expr: DATE_TRUNC('MONTH', actual_finish_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Run"
      expr: COUNT(DISTINCT run_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Actual Quantity"
      expr: SUM(actual_quantity)
    - name: "Average Actual Quantity"
      expr: AVG(actual_quantity)
    - name: "Total Availability Percentage"
      expr: SUM(availability_percentage)
    - name: "Average Availability Percentage"
      expr: AVG(availability_percentage)
    - name: "Total Oee Percentage"
      expr: SUM(oee_percentage)
    - name: "Average Oee Percentage"
      expr: AVG(oee_percentage)
    - name: "Total Performance Percentage"
      expr: SUM(performance_percentage)
    - name: "Average Performance Percentage"
      expr: AVG(performance_percentage)
    - name: "Total Planned Quantity"
      expr: SUM(planned_quantity)
    - name: "Average Planned Quantity"
      expr: AVG(planned_quantity)
    - name: "Total Quality Percentage"
      expr: SUM(quality_percentage)
    - name: "Average Quality Percentage"
      expr: AVG(quality_percentage)
    - name: "Total Rework Quantity"
      expr: SUM(rework_quantity)
    - name: "Average Rework Quantity"
      expr: AVG(rework_quantity)
    - name: "Total Scrap Quantity"
      expr: SUM(scrap_quantity)
    - name: "Average Scrap Quantity"
      expr: AVG(scrap_quantity)
    - name: "Total Scrap Rate Percentage"
      expr: SUM(scrap_rate_percentage)
    - name: "Average Scrap Rate Percentage"
      expr: AVG(scrap_rate_percentage)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Takt Time Minutes"
      expr: SUM(takt_time_minutes)
    - name: "Average Takt Time Minutes"
      expr: AVG(takt_time_minutes)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule business metrics"
  source: "`vibe_manufacturing_v1`.`production`.`schedule`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Cancelled Timestamp"
      expr: cancelled_timestamp
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Firmed Flag"
      expr: firmed_flag
    - name: "Freeze Horizon Date"
      expr: freeze_horizon_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Lot Sizing Rule"
      expr: lot_sizing_rule
    - name: "Mrp Controller"
      expr: mrp_controller
    - name: "Notes"
      expr: notes
    - name: "Pegging Reference"
      expr: pegging_reference
    - name: "Planning Bucket"
      expr: planning_bucket
    - name: "Planning Horizon Weeks"
      expr: planning_horizon_weeks
    - name: "Planning Strategy"
      expr: planning_strategy
    - name: "Priority Rank"
      expr: priority_rank
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Schedule"
      expr: COUNT(DISTINCT schedule_id)
    - name: "Total Capacity Requirement Hours"
      expr: SUM(capacity_requirement_hours)
    - name: "Average Capacity Requirement Hours"
      expr: AVG(capacity_requirement_hours)
    - name: "Total Lot Size Quantity"
      expr: SUM(lot_size_quantity)
    - name: "Average Lot Size Quantity"
      expr: AVG(lot_size_quantity)
    - name: "Total Planned Quantity"
      expr: SUM(planned_quantity)
    - name: "Average Planned Quantity"
      expr: AVG(planned_quantity)
    - name: "Total Run Time Hours"
      expr: SUM(run_time_hours)
    - name: "Average Run Time Hours"
      expr: AVG(run_time_hours)
    - name: "Total Safety Stock Quantity"
      expr: SUM(safety_stock_quantity)
    - name: "Average Safety Stock Quantity"
      expr: AVG(safety_stock_quantity)
    - name: "Total Setup Time Hours"
      expr: SUM(setup_time_hours)
    - name: "Average Setup Time Hours"
      expr: AVG(setup_time_hours)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_wip_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wip Lot business metrics"
  source: "`vibe_manufacturing_v1`.`production`.`wip_lot`"
  dimensions:
    - name: "Actual Completion Timestamp"
      expr: actual_completion_timestamp
    - name: "Batch Number"
      expr: batch_number
    - name: "Current Operation Sequence"
      expr: current_operation_sequence
    - name: "Current Operation Start Timestamp"
      expr: current_operation_start_timestamp
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Inspection Lot Number"
      expr: inspection_lot_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lot Creation Timestamp"
      expr: lot_creation_timestamp
    - name: "Lot Number"
      expr: lot_number
    - name: "Lot Status"
      expr: lot_status
    - name: "Notes"
      expr: notes
    - name: "Original Lot Number"
      expr: original_lot_number
    - name: "Priority Code"
      expr: priority_code
    - name: "Production Start Timestamp"
      expr: production_start_timestamp
    - name: "Project Number"
      expr: project_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Wip Lot"
      expr: COUNT(DISTINCT wip_lot_id)
    - name: "Total Quantity Completed"
      expr: SUM(quantity_completed)
    - name: "Average Quantity Completed"
      expr: AVG(quantity_completed)
    - name: "Total Quantity In Process"
      expr: SUM(quantity_in_process)
    - name: "Average Quantity In Process"
      expr: AVG(quantity_in_process)
    - name: "Total Quantity On Hold"
      expr: SUM(quantity_on_hold)
    - name: "Average Quantity On Hold"
      expr: AVG(quantity_on_hold)
    - name: "Total Quantity Ordered"
      expr: SUM(quantity_ordered)
    - name: "Average Quantity Ordered"
      expr: AVG(quantity_ordered)
    - name: "Total Quantity Scrapped"
      expr: SUM(quantity_scrapped)
    - name: "Average Quantity Scrapped"
      expr: AVG(quantity_scrapped)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work Center business metrics"
  source: "`vibe_manufacturing_v1`.`production`.`work_center`"
  dimensions:
    - name: "Capacity Category"
      expr: capacity_category
    - name: "Capacity Planning Group"
      expr: capacity_planning_group
    - name: "Category"
      expr: work_center_category
    - name: "Code"
      expr: work_center_code
    - name: "Control Key"
      expr: control_key
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Formula Key"
      expr: formula_key
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Location Description"
      expr: location_description
    - name: "Mes Integration Enabled"
      expr: mes_integration_enabled
    - name: "Name"
      expr: work_center_name
    - name: "Number Of Machines"
      expr: number_of_machines
    - name: "Number Of Operators"
      expr: number_of_operators
    - name: "Plc Address"
      expr: plc_address
    - name: "Quality Inspection Required"
      expr: quality_inspection_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Work Center"
      expr: COUNT(DISTINCT work_center_id)
    - name: "Total Available Capacity Per Shift"
      expr: SUM(available_capacity_per_shift)
    - name: "Average Available Capacity Per Shift"
      expr: AVG(available_capacity_per_shift)
    - name: "Total Efficiency Rate Percent"
      expr: SUM(efficiency_rate_percent)
    - name: "Average Efficiency Rate Percent"
      expr: AVG(efficiency_rate_percent)
    - name: "Total Oee Baseline Target Percent"
      expr: SUM(oee_baseline_target_percent)
    - name: "Average Oee Baseline Target Percent"
      expr: AVG(oee_baseline_target_percent)
    - name: "Total Standard Processing Time Minutes"
      expr: SUM(standard_processing_time_minutes)
    - name: "Average Standard Processing Time Minutes"
      expr: AVG(standard_processing_time_minutes)
    - name: "Total Standard Queue Time Hours"
      expr: SUM(standard_queue_time_hours)
    - name: "Average Standard Queue Time Hours"
      expr: AVG(standard_queue_time_hours)
    - name: "Total Standard Setup Time Minutes"
      expr: SUM(standard_setup_time_minutes)
    - name: "Average Standard Setup Time Minutes"
      expr: AVG(standard_setup_time_minutes)
    - name: "Total Standard Teardown Time Minutes"
      expr: SUM(standard_teardown_time_minutes)
    - name: "Average Standard Teardown Time Minutes"
      expr: AVG(standard_teardown_time_minutes)
    - name: "Total Utilization Rate Percent"
      expr: SUM(utilization_rate_percent)
    - name: "Average Utilization Rate Percent"
      expr: AVG(utilization_rate_percent)
$$;