-- Metric views for domain: supply | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 14:42:54

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity Plan business metrics"
  source: "`vibe_manufacturing_v1`.`supply`.`capacity_plan`"
  dimensions:
    - name: "Capacity Category"
      expr: capacity_category
    - name: "Capacity Load Profile"
      expr: capacity_load_profile
    - name: "Capacity Source System"
      expr: capacity_source_system
    - name: "Capacity Unit"
      expr: capacity_unit
    - name: "Is Bottleneck"
      expr: is_bottleneck
    - name: "Last Mrp Run Date"
      expr: last_mrp_run_date
    - name: "Leveling Strategy"
      expr: leveling_strategy
    - name: "Mrp Controller"
      expr: mrp_controller
    - name: "Notes"
      expr: notes
    - name: "Plan Created Timestamp"
      expr: plan_created_timestamp
    - name: "Plan Status"
      expr: plan_status
    - name: "Plan Type"
      expr: plan_type
    - name: "Plan Updated Timestamp"
      expr: plan_updated_timestamp
    - name: "Planning Horizon"
      expr: planning_horizon
    - name: "Planning Period End Date"
      expr: planning_period_end_date
    - name: "Planning Period Start Date"
      expr: planning_period_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Capacity Plan"
      expr: COUNT(DISTINCT capacity_plan_id)
    - name: "Total Available Capacity Hours"
      expr: SUM(available_capacity_hours)
    - name: "Average Available Capacity Hours"
      expr: AVG(available_capacity_hours)
    - name: "Total Capacity Buffer Hours"
      expr: SUM(capacity_buffer_hours)
    - name: "Average Capacity Buffer Hours"
      expr: AVG(capacity_buffer_hours)
    - name: "Total Capacity Utilization Rate"
      expr: SUM(capacity_utilization_rate)
    - name: "Average Capacity Utilization Rate"
      expr: AVG(capacity_utilization_rate)
    - name: "Total Critical Ratio"
      expr: SUM(critical_ratio)
    - name: "Average Critical Ratio"
      expr: AVG(critical_ratio)
    - name: "Total Efficiency Rate"
      expr: SUM(efficiency_rate)
    - name: "Average Efficiency Rate"
      expr: AVG(efficiency_rate)
    - name: "Total Leveling Adjustment Hours"
      expr: SUM(leveling_adjustment_hours)
    - name: "Average Leveling Adjustment Hours"
      expr: AVG(leveling_adjustment_hours)
    - name: "Total Overload Hours"
      expr: SUM(overload_hours)
    - name: "Average Overload Hours"
      expr: AVG(overload_hours)
    - name: "Total Planned Downtime Hours"
      expr: SUM(planned_downtime_hours)
    - name: "Average Planned Downtime Hours"
      expr: AVG(planned_downtime_hours)
    - name: "Total Queue Time Hours"
      expr: SUM(queue_time_hours)
    - name: "Average Queue Time Hours"
      expr: AVG(queue_time_hours)
    - name: "Total Required Capacity Hours"
      expr: SUM(required_capacity_hours)
    - name: "Average Required Capacity Hours"
      expr: AVG(required_capacity_hours)
    - name: "Total Run Time Hours"
      expr: SUM(run_time_hours)
    - name: "Average Run Time Hours"
      expr: AVG(run_time_hours)
    - name: "Total Setup Time Hours"
      expr: SUM(setup_time_hours)
    - name: "Average Setup Time Hours"
      expr: AVG(setup_time_hours)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand Forecast business metrics"
  source: "`vibe_manufacturing_v1`.`supply`.`demand_forecast`"
  dimensions:
    - name: "Approval Comments"
      expr: approval_comments
    - name: "Consensus Approval Date"
      expr: consensus_approval_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment Code"
      expr: customer_segment_code
    - name: "Demand Class"
      expr: demand_class
    - name: "Demand Pattern"
      expr: demand_pattern
    - name: "Forecast Consumption Flag"
      expr: forecast_consumption_flag
    - name: "Forecast Generation Timestamp"
      expr: forecast_generation_timestamp
    - name: "Forecast Horizon Days"
      expr: forecast_horizon_days
    - name: "Forecast Model Code"
      expr: forecast_model_code
    - name: "Forecast Model Name"
      expr: forecast_model_name
    - name: "Forecast Number"
      expr: forecast_number
    - name: "Forecast Status"
      expr: forecast_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Mrp Area Code"
      expr: mrp_area_code
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Demand Forecast"
      expr: COUNT(DISTINCT demand_forecast_id)
    - name: "Total Bias Percent"
      expr: SUM(bias_percent)
    - name: "Average Bias Percent"
      expr: AVG(bias_percent)
    - name: "Total Confidence Interval Lower"
      expr: SUM(confidence_interval_lower)
    - name: "Average Confidence Interval Lower"
      expr: AVG(confidence_interval_lower)
    - name: "Total Confidence Interval Upper"
      expr: SUM(confidence_interval_upper)
    - name: "Average Confidence Interval Upper"
      expr: AVG(confidence_interval_upper)
    - name: "Total Confidence Level Percent"
      expr: SUM(confidence_level_percent)
    - name: "Average Confidence Level Percent"
      expr: AVG(confidence_level_percent)
    - name: "Total Forecast Accuracy Percent"
      expr: SUM(forecast_accuracy_percent)
    - name: "Average Forecast Accuracy Percent"
      expr: AVG(forecast_accuracy_percent)
    - name: "Total Forecast Quantity"
      expr: SUM(forecast_quantity)
    - name: "Average Forecast Quantity"
      expr: AVG(forecast_quantity)
    - name: "Total Mean Absolute Percentage Error"
      expr: SUM(mean_absolute_percentage_error)
    - name: "Average Mean Absolute Percentage Error"
      expr: AVG(mean_absolute_percentage_error)
    - name: "Total Promotional Uplift Percent"
      expr: SUM(promotional_uplift_percent)
    - name: "Average Promotional Uplift Percent"
      expr: AVG(promotional_uplift_percent)
    - name: "Total Sales Adjustment Quantity"
      expr: SUM(sales_adjustment_quantity)
    - name: "Average Sales Adjustment Quantity"
      expr: AVG(sales_adjustment_quantity)
    - name: "Total Seasonality Index"
      expr: SUM(seasonality_index)
    - name: "Average Seasonality Index"
      expr: AVG(seasonality_index)
    - name: "Total Trend Coefficient"
      expr: SUM(trend_coefficient)
    - name: "Average Trend Coefficient"
      expr: AVG(trend_coefficient)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_material_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Requirement business metrics"
  source: "`vibe_manufacturing_v1`.`supply`.`material_requirement`"
  dimensions:
    - name: "Abc Indicator"
      expr: abc_indicator
    - name: "Bom Explosion Date"
      expr: bom_explosion_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Exception Message Code"
      expr: exception_message_code
    - name: "Exception Message Text"
      expr: exception_message_text
    - name: "Firming Date"
      expr: firming_date
    - name: "Goods Receipt Processing Time Days"
      expr: goods_receipt_processing_time_days
    - name: "In House Production Time Days"
      expr: in_house_production_time_days
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lot Size Key"
      expr: lot_size_key
    - name: "Mrp Controller"
      expr: mrp_controller
    - name: "Mrp Element Type"
      expr: mrp_element_type
    - name: "Mrp Run Timestamp"
      expr: mrp_run_timestamp
    - name: "Planned Delivery Time Days"
      expr: planned_delivery_time_days
    - name: "Planning Time Fence Days"
      expr: planning_time_fence_days
    - name: "Procurement Type"
      expr: procurement_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material Requirement"
      expr: COUNT(DISTINCT material_requirement_id)
    - name: "Total Gross Requirement Quantity"
      expr: SUM(gross_requirement_quantity)
    - name: "Average Gross Requirement Quantity"
      expr: AVG(gross_requirement_quantity)
    - name: "Total Maximum Order Quantity"
      expr: SUM(maximum_order_quantity)
    - name: "Average Maximum Order Quantity"
      expr: AVG(maximum_order_quantity)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Net Requirement Quantity"
      expr: SUM(net_requirement_quantity)
    - name: "Average Net Requirement Quantity"
      expr: AVG(net_requirement_quantity)
    - name: "Total Pegging Requirement Reference"
      expr: SUM(pegging_requirement_reference)
    - name: "Average Pegging Requirement Reference"
      expr: AVG(pegging_requirement_reference)
    - name: "Total Planned Order Quantity"
      expr: SUM(planned_order_quantity)
    - name: "Average Planned Order Quantity"
      expr: AVG(planned_order_quantity)
    - name: "Total Projected Available Balance"
      expr: SUM(projected_available_balance)
    - name: "Average Projected Available Balance"
      expr: AVG(projected_available_balance)
    - name: "Total Reorder Point Quantity"
      expr: SUM(reorder_point_quantity)
    - name: "Average Reorder Point Quantity"
      expr: AVG(reorder_point_quantity)
    - name: "Total Rounding Value"
      expr: SUM(rounding_value)
    - name: "Average Rounding Value"
      expr: AVG(rounding_value)
    - name: "Total Safety Stock Quantity"
      expr: SUM(safety_stock_quantity)
    - name: "Average Safety Stock Quantity"
      expr: AVG(safety_stock_quantity)
    - name: "Total Scheduled Receipt Quantity"
      expr: SUM(scheduled_receipt_quantity)
    - name: "Average Scheduled Receipt Quantity"
      expr: AVG(scheduled_receipt_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_mrp_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mrp Run business metrics"
  source: "`vibe_manufacturing_v1`.`supply`.`mrp_run`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Bom Explosion Level"
      expr: bom_explosion_level
    - name: "Completion Notes"
      expr: completion_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Demand Time Fence Days"
      expr: demand_time_fence_days
    - name: "Error Messages Count"
      expr: error_messages_count
    - name: "Exception Messages Count"
      expr: exception_messages_count
    - name: "Include Forecast Flag"
      expr: include_forecast_flag
    - name: "Include Safety Stock Flag"
      expr: include_safety_stock_flag
    - name: "Include Wip Flag"
      expr: include_wip_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Offset Days"
      expr: lead_time_offset_days
    - name: "Lot Sizing Rule"
      expr: lot_sizing_rule
    - name: "Materials Processed Count"
      expr: materials_processed_count
    - name: "Planned Orders Cancelled Count"
      expr: planned_orders_cancelled_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mrp Run"
      expr: COUNT(DISTINCT mrp_run_id)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_order_pegging`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order Pegging business metrics"
  source: "`vibe_manufacturing_v1`.`supply`.`order_pegging`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Pegging Date"
      expr: pegging_date
    - name: "Pegging Level"
      expr: pegging_level
    - name: "Pegging Status"
      expr: pegging_status
    - name: "Pegging Type"
      expr: pegging_type
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Last Modified Timestamp Month"
      expr: DATE_TRUNC('MONTH', last_modified_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Order Pegging"
      expr: COUNT(DISTINCT order_pegging_id)
    - name: "Total Pegged Quantity"
      expr: SUM(pegged_quantity)
    - name: "Average Pegged Quantity"
      expr: AVG(pegged_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan business metrics"
  source: "`vibe_manufacturing_v1`.`supply`.`plan`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Lot Sizing Procedure"
      expr: lot_sizing_procedure
    - name: "Material Group Code"
      expr: material_group_code
    - name: "Mrp Controller Code"
      expr: mrp_controller_code
    - name: "Notes"
      expr: notes
    - name: "Plan Number"
      expr: plan_number
    - name: "Plan Status"
      expr: plan_status
    - name: "Planning Horizon Days"
      expr: planning_horizon_days
    - name: "Planning Method"
      expr: planning_method
    - name: "Planning Period End Date"
      expr: planning_period_end_date
    - name: "Planning Period Start Date"
      expr: planning_period_start_date
    - name: "Planning Run Timestamp"
      expr: planning_run_timestamp
    - name: "Planning Strategy"
      expr: planning_strategy
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Plan"
      expr: COUNT(DISTINCT plan_id)
    - name: "Total Capacity Utilization Percentage"
      expr: SUM(capacity_utilization_percentage)
    - name: "Average Capacity Utilization Percentage"
      expr: AVG(capacity_utilization_percentage)
    - name: "Total Demand Forecast Quantity"
      expr: SUM(demand_forecast_quantity)
    - name: "Average Demand Forecast Quantity"
      expr: AVG(demand_forecast_quantity)
    - name: "Total Maximum Lot Size"
      expr: SUM(maximum_lot_size)
    - name: "Average Maximum Lot Size"
      expr: AVG(maximum_lot_size)
    - name: "Total Minimum Lot Size"
      expr: SUM(minimum_lot_size)
    - name: "Average Minimum Lot Size"
      expr: AVG(minimum_lot_size)
    - name: "Total Planned Supply Quantity"
      expr: SUM(planned_supply_quantity)
    - name: "Average Planned Supply Quantity"
      expr: AVG(planned_supply_quantity)
    - name: "Total Reorder Point Quantity"
      expr: SUM(reorder_point_quantity)
    - name: "Average Reorder Point Quantity"
      expr: AVG(reorder_point_quantity)
    - name: "Total Rounding Value"
      expr: SUM(rounding_value)
    - name: "Average Rounding Value"
      expr: AVG(rounding_value)
    - name: "Total Safety Stock Quantity"
      expr: SUM(safety_stock_quantity)
    - name: "Average Safety Stock Quantity"
      expr: AVG(safety_stock_quantity)
    - name: "Total Variance Percentage"
      expr: SUM(variance_percentage)
    - name: "Average Variance Percentage"
      expr: AVG(variance_percentage)
    - name: "Total Variance Quantity"
      expr: SUM(variance_quantity)
    - name: "Average Variance Quantity"
      expr: AVG(variance_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_planned_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned Order business metrics"
  source: "`vibe_manufacturing_v1`.`supply`.`planned_order`"
  dimensions:
    - name: "Converted Order Number"
      expr: converted_order_number
    - name: "Converted Timestamp"
      expr: converted_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deletion Flag"
      expr: deletion_flag
    - name: "Exception Code"
      expr: exception_code
    - name: "Exception Message"
      expr: exception_message
    - name: "Firmed Timestamp"
      expr: firmed_timestamp
    - name: "Firming Indicator"
      expr: firming_indicator
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lot Size Rule"
      expr: lot_size_rule
    - name: "Mrp Controller"
      expr: mrp_controller
    - name: "Multi Tier Supplier Flag"
      expr: multi_tier_supplier_flag
    - name: "Order Type"
      expr: order_type
    - name: "Planner Notes"
      expr: planner_notes
    - name: "Planner Override Date"
      expr: planner_override_date
    - name: "Planning Run Timestamp"
      expr: planning_run_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Planned Order"
      expr: COUNT(DISTINCT planned_order_id)
    - name: "Total Available Capacity Hours"
      expr: SUM(available_capacity_hours)
    - name: "Average Available Capacity Hours"
      expr: AVG(available_capacity_hours)
    - name: "Total Moq Quantity"
      expr: SUM(moq_quantity)
    - name: "Average Moq Quantity"
      expr: AVG(moq_quantity)
    - name: "Total Planned Quantity"
      expr: SUM(planned_quantity)
    - name: "Average Planned Quantity"
      expr: AVG(planned_quantity)
    - name: "Total Planner Override Quantity"
      expr: SUM(planner_override_quantity)
    - name: "Average Planner Override Quantity"
      expr: AVG(planner_override_quantity)
    - name: "Total Required Capacity Hours"
      expr: SUM(required_capacity_hours)
    - name: "Average Required Capacity Hours"
      expr: AVG(required_capacity_hours)
    - name: "Total Safety Stock Quantity"
      expr: SUM(safety_stock_quantity)
    - name: "Average Safety Stock Quantity"
      expr: AVG(safety_stock_quantity)
    - name: "Total Supply Risk Score"
      expr: SUM(supply_risk_score)
    - name: "Average Supply Risk Score"
      expr: AVG(supply_risk_score)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_sourcing_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing Rule business metrics"
  source: "`vibe_manufacturing_v1`.`supply`.`sourcing_rule`"
  dimensions:
    - name: "Automatic Po Flag"
      expr: automatic_po_flag
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Exception Reason"
      expr: exception_reason
    - name: "Gr Processing Time Days"
      expr: gr_processing_time_days
    - name: "Incoterms"
      expr: incoterms
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Last Modified By User"
      expr: last_modified_by_user
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Moq Negotiation Date"
      expr: last_moq_negotiation_date
    - name: "Lot Sizing Procedure"
      expr: lot_sizing_procedure
    - name: "Make Or Buy Indicator"
      expr: make_or_buy_indicator
    - name: "Notes"
      expr: notes
    - name: "Order Unit"
      expr: order_unit
    - name: "Payment Terms"
      expr: payment_terms
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sourcing Rule"
      expr: COUNT(DISTINCT sourcing_rule_id)
    - name: "Total Allocation Percentage"
      expr: SUM(allocation_percentage)
    - name: "Average Allocation Percentage"
      expr: AVG(allocation_percentage)
    - name: "Total Fixed Lot Size"
      expr: SUM(fixed_lot_size)
    - name: "Average Fixed Lot Size"
      expr: AVG(fixed_lot_size)
    - name: "Total Lot Size Rounding Value"
      expr: SUM(lot_size_rounding_value)
    - name: "Average Lot Size Rounding Value"
      expr: AVG(lot_size_rounding_value)
    - name: "Total Maximum Order Quantity"
      expr: SUM(maximum_order_quantity)
    - name: "Average Maximum Order Quantity"
      expr: AVG(maximum_order_quantity)
    - name: "Total Moq"
      expr: SUM(moq)
    - name: "Average Moq"
      expr: AVG(moq)
    - name: "Total Standard Price"
      expr: SUM(standard_price)
    - name: "Average Standard Price"
      expr: AVG(standard_price)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supply_supply_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply Plant business metrics"
  source: "`vibe_manufacturing_v1`.`supply`.`supply_plant`"
  dimensions:
    - name: "Capacity Unit"
      expr: capacity_unit
    - name: "City"
      expr: city
    - name: "Closing Date"
      expr: closing_date
    - name: "Compliance Certifications"
      expr: compliance_certifications
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Energy Source"
      expr: energy_source
    - name: "Is Primary Plant"
      expr: is_primary_plant
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Location Address"
      expr: location_address
    - name: "Maintenance Window"
      expr: maintenance_window
    - name: "Manager Email"
      expr: manager_email
    - name: "Manager Name"
      expr: manager_name
    - name: "Manager Phone"
      expr: manager_phone
    - name: "Name"
      expr: supply_plant_name
    - name: "Next Maintenance Date"
      expr: next_maintenance_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supply Plant"
      expr: COUNT(DISTINCT delivery_id)
    - name: "Total Capacity"
      expr: SUM(capacity)
    - name: "Average Capacity"
      expr: AVG(capacity)
    - name: "Total Carbon Emission Factor"
      expr: SUM(carbon_emission_factor)
    - name: "Average Carbon Emission Factor"
      expr: AVG(carbon_emission_factor)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Power Capacity Mw"
      expr: SUM(power_capacity_mw)
    - name: "Average Power Capacity Mw"
      expr: AVG(power_capacity_mw)
    - name: "Total Shift Hours"
      expr: SUM(shift_hours)
    - name: "Average Shift Hours"
      expr: AVG(shift_hours)
    - name: "Total Site Area Sqm"
      expr: SUM(site_area_sqm)
    - name: "Average Site Area Sqm"
      expr: AVG(site_area_sqm)
    - name: "Total Water Usage Cubic M"
      expr: SUM(water_usage_cubic_m)
    - name: "Average Water Usage Cubic M"
      expr: AVG(water_usage_cubic_m)
$$;