-- Metric views for domain: supplychain | Business: Retail | Version: 2 | Generated on: 2026-07-12 15:25:24

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_dc_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dc Facility business metrics"
  source: "`vibe_retail_v1`.`supplychain`.`dc_facility`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Automation Level"
      expr: automation_level
    - name: "Bonded Warehouse Flag"
      expr: bonded_warehouse_flag
    - name: "City"
      expr: city
    - name: "Closed Date"
      expr: closed_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dock Door Count"
      expr: dock_door_count
    - name: "Facility Code"
      expr: facility_code
    - name: "Facility Email Address"
      expr: facility_email_address
    - name: "Facility Manager Name"
      expr: facility_manager_name
    - name: "Facility Name"
      expr: facility_name
    - name: "Facility Phone Number"
      expr: facility_phone_number
    - name: "Facility Status"
      expr: facility_status
    - name: "Facility Type"
      expr: facility_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dc Facility"
      expr: COUNT(DISTINCT dc_facility_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Storage Capacity Cubic Feet"
      expr: SUM(storage_capacity_cubic_feet)
    - name: "Average Storage Capacity Cubic Feet"
      expr: AVG(storage_capacity_cubic_feet)
    - name: "Total Total Square Footage"
      expr: SUM(total_square_footage)
    - name: "Average Total Square Footage"
      expr: AVG(total_square_footage)
    - name: "Total Warehouse Square Footage"
      expr: SUM(warehouse_square_footage)
    - name: "Average Warehouse Square Footage"
      expr: AVG(warehouse_square_footage)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand Forecast business metrics"
  source: "`vibe_retail_v1`.`supplychain`.`demand_forecast`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Source System"
      expr: data_source_system
    - name: "Demand Category"
      expr: demand_category
    - name: "Forecast Generation Timestamp"
      expr: forecast_generation_timestamp
    - name: "Forecast Horizon Weeks"
      expr: forecast_horizon_weeks
    - name: "Forecast Period End Date"
      expr: forecast_period_end_date
    - name: "Forecast Period Start Date"
      expr: forecast_period_start_date
    - name: "Forecast Status"
      expr: forecast_status
    - name: "Forecast Type"
      expr: forecast_type
    - name: "Forecast Version"
      expr: forecast_version
    - name: "Is Latest Version"
      expr: is_latest_version
    - name: "Is New Item"
      expr: is_new_item
    - name: "Is Override Applied"
      expr: is_override_applied
    - name: "Is Promotional Period"
      expr: is_promotional_period
    - name: "Model Version"
      expr: model_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Demand Forecast"
      expr: COUNT(DISTINCT demand_forecast_id)
    - name: "Total Baseline Forecast Units"
      expr: SUM(baseline_forecast_units)
    - name: "Average Baseline Forecast Units"
      expr: AVG(baseline_forecast_units)
    - name: "Total Confidence Level Pct"
      expr: SUM(confidence_level_pct)
    - name: "Average Confidence Level Pct"
      expr: AVG(confidence_level_pct)
    - name: "Total Forecast Bias"
      expr: SUM(forecast_bias)
    - name: "Average Forecast Bias"
      expr: AVG(forecast_bias)
    - name: "Total Forecast Lower Bound Units"
      expr: SUM(forecast_lower_bound_units)
    - name: "Average Forecast Lower Bound Units"
      expr: AVG(forecast_lower_bound_units)
    - name: "Total Forecast Run Number"
      expr: SUM(forecast_run_number)
    - name: "Average Forecast Run Number"
      expr: AVG(forecast_run_number)
    - name: "Total Forecast Upper Bound Units"
      expr: SUM(forecast_upper_bound_units)
    - name: "Average Forecast Upper Bound Units"
      expr: AVG(forecast_upper_bound_units)
    - name: "Total Forecasted Revenue"
      expr: SUM(forecasted_revenue)
    - name: "Average Forecasted Revenue"
      expr: AVG(forecasted_revenue)
    - name: "Total Forecasted Units"
      expr: SUM(forecasted_units)
    - name: "Average Forecasted Units"
      expr: AVG(forecasted_units)
    - name: "Total Mape"
      expr: SUM(mape)
    - name: "Average Mape"
      expr: AVG(mape)
    - name: "Total Override Units"
      expr: SUM(override_units)
    - name: "Average Override Units"
      expr: AVG(override_units)
    - name: "Total Promotional Lift Units"
      expr: SUM(promotional_lift_units)
    - name: "Average Promotional Lift Units"
      expr: AVG(promotional_lift_units)
    - name: "Total Replenishment Recommendation Units"
      expr: SUM(replenishment_recommendation_units)
    - name: "Average Replenishment Recommendation Units"
      expr: AVG(replenishment_recommendation_units)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound Shipment business metrics"
  source: "`vibe_retail_v1`.`supplychain`.`inbound_shipment`"
  dimensions:
    - name: "Actual Arrival Date"
      expr: actual_arrival_date
    - name: "Actual Arrival Timestamp"
      expr: actual_arrival_timestamp
    - name: "Actual Carton Count"
      expr: actual_carton_count
    - name: "Actual Pallet Count"
      expr: actual_pallet_count
    - name: "Asn Number"
      expr: asn_number
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Carrier Scac Code"
      expr: carrier_scac_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Dock Flag"
      expr: cross_dock_flag
    - name: "Dock Door Number"
      expr: dock_door_number
    - name: "Expected Arrival Date"
      expr: expected_arrival_date
    - name: "Expected Arrival Timestamp"
      expr: expected_arrival_timestamp
    - name: "Expected Carton Count"
      expr: expected_carton_count
    - name: "Expected Pallet Count"
      expr: expected_pallet_count
    - name: "Freight Currency Code"
      expr: freight_currency_code
    - name: "Hazmat Flag"
      expr: hazmat_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inbound Shipment"
      expr: COUNT(DISTINCT inbound_shipment_id)
    - name: "Total Actual Weight Kg"
      expr: SUM(actual_weight_kg)
    - name: "Average Actual Weight Kg"
      expr: AVG(actual_weight_kg)
    - name: "Total Expected Cube M3"
      expr: SUM(expected_cube_m3)
    - name: "Average Expected Cube M3"
      expr: AVG(expected_cube_m3)
    - name: "Total Expected Weight Kg"
      expr: SUM(expected_weight_kg)
    - name: "Average Expected Weight Kg"
      expr: AVG(expected_weight_kg)
    - name: "Total Freight Cost Amount"
      expr: SUM(freight_cost_amount)
    - name: "Average Freight Cost Amount"
      expr: AVG(freight_cost_amount)
    - name: "Total Temperature Max Celsius"
      expr: SUM(temperature_max_celsius)
    - name: "Average Temperature Max Celsius"
      expr: AVG(temperature_max_celsius)
    - name: "Total Temperature Min Celsius"
      expr: SUM(temperature_min_celsius)
    - name: "Average Temperature Min Celsius"
      expr: AVG(temperature_min_celsius)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_outbound_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound Order business metrics"
  source: "`vibe_retail_v1`.`supplychain`.`outbound_order`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Actual Ship Date"
      expr: actual_ship_date
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Carrier Service Level"
      expr: carrier_service_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Address Line1"
      expr: destination_address_line1
    - name: "Destination City"
      expr: destination_city
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Destination Postal Code"
      expr: destination_postal_code
    - name: "Destination State Province"
      expr: destination_state_province
    - name: "Destination Type"
      expr: destination_type
    - name: "Dock Door Number"
      expr: dock_door_number
    - name: "Is Cross Dock"
      expr: is_cross_dock
    - name: "Is Drop Ship"
      expr: is_drop_ship
    - name: "Is Hazmat"
      expr: is_hazmat
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Outbound Order"
      expr: COUNT(DISTINCT outbound_order_id)
    - name: "Total Fill Rate Pct"
      expr: SUM(fill_rate_pct)
    - name: "Average Fill Rate Pct"
      expr: AVG(fill_rate_pct)
    - name: "Total Total Cube M3"
      expr: SUM(total_cube_m3)
    - name: "Average Total Cube M3"
      expr: AVG(total_cube_m3)
    - name: "Total Total Weight Kg"
      expr: SUM(total_weight_kg)
    - name: "Average Total Weight Kg"
      expr: AVG(total_weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_outbound_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound Order Line business metrics"
  source: "`vibe_retail_v1`.`supplychain`.`outbound_order_line`"
  dimensions:
    - name: "Carton Number"
      expr: carton_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Handling Instructions"
      expr: handling_instructions
    - name: "Is Hazmat"
      expr: is_hazmat
    - name: "Is Temperature Controlled"
      expr: is_temperature_controlled
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Original Sku"
      expr: original_sku
    - name: "Serial Number"
      expr: serial_number
    - name: "Short Ship Reason Code"
      expr: short_ship_reason_code
    - name: "Sku"
      expr: sku
    - name: "Substitution Flag"
      expr: substitution_flag
    - name: "Temperature Requirement"
      expr: temperature_requirement
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Outbound Order Line"
      expr: COUNT(DISTINCT outbound_order_line_id)
    - name: "Total Allocated Qty"
      expr: SUM(allocated_qty)
    - name: "Average Allocated Qty"
      expr: AVG(allocated_qty)
    - name: "Total Extended Cost"
      expr: SUM(extended_cost)
    - name: "Average Extended Cost"
      expr: AVG(extended_cost)
    - name: "Total Ordered Qty"
      expr: SUM(ordered_qty)
    - name: "Average Ordered Qty"
      expr: AVG(ordered_qty)
    - name: "Total Packed Qty"
      expr: SUM(packed_qty)
    - name: "Average Packed Qty"
      expr: AVG(packed_qty)
    - name: "Total Picked Qty"
      expr: SUM(picked_qty)
    - name: "Average Picked Qty"
      expr: AVG(picked_qty)
    - name: "Total Shipped Qty"
      expr: SUM(shipped_qty)
    - name: "Average Shipped Qty"
      expr: AVG(shipped_qty)
    - name: "Total Short Ship Qty"
      expr: SUM(short_ship_qty)
    - name: "Average Short Ship Qty"
      expr: AVG(short_ship_qty)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
    - name: "Total Volume Cubic Meters"
      expr: SUM(volume_cubic_meters)
    - name: "Average Volume Cubic Meters"
      expr: AVG(volume_cubic_meters)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Po Line business metrics"
  source: "`vibe_retail_v1`.`supplychain`.`po_line`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Cancel Date"
      expr: cancel_date
    - name: "Confirmed Delivery Date"
      expr: confirmed_delivery_date
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Type"
      expr: destination_type
    - name: "Incoterms"
      expr: incoterms
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Moq Compliant"
      expr: moq_compliant
    - name: "Rejection Reason"
      expr: rejection_reason
    - name: "Requested Delivery Date"
      expr: requested_delivery_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Po Line"
      expr: COUNT(DISTINCT po_line_id)
    - name: "Total Allowance Amount"
      expr: SUM(allowance_amount)
    - name: "Average Allowance Amount"
      expr: AVG(allowance_amount)
    - name: "Total Confirmed Qty"
      expr: SUM(confirmed_qty)
    - name: "Average Confirmed Qty"
      expr: AVG(confirmed_qty)
    - name: "Total Extended Cost"
      expr: SUM(extended_cost)
    - name: "Average Extended Cost"
      expr: AVG(extended_cost)
    - name: "Total Moq"
      expr: SUM(moq)
    - name: "Average Moq"
      expr: AVG(moq)
    - name: "Total Net Cost"
      expr: SUM(net_cost)
    - name: "Average Net Cost"
      expr: AVG(net_cost)
    - name: "Total Order Uom Qty"
      expr: SUM(order_uom_qty)
    - name: "Average Order Uom Qty"
      expr: AVG(order_uom_qty)
    - name: "Total Ordered Qty"
      expr: SUM(ordered_qty)
    - name: "Average Ordered Qty"
      expr: AVG(ordered_qty)
    - name: "Total Otb Consumed"
      expr: SUM(otb_consumed)
    - name: "Average Otb Consumed"
      expr: AVG(otb_consumed)
    - name: "Total Received Qty"
      expr: SUM(received_qty)
    - name: "Average Received Qty"
      expr: AVG(received_qty)
    - name: "Total Retail Price"
      expr: SUM(retail_price)
    - name: "Average Retail Price"
      expr: AVG(retail_price)
    - name: "Total Shipped Qty"
      expr: SUM(shipped_qty)
    - name: "Average Shipped Qty"
      expr: AVG(shipped_qty)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase Order business metrics"
  source: "`vibe_retail_v1`.`supplychain`.`purchase_order`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Company Code"
      expr: company_code
    - name: "Confirmed Delivery Date"
      expr: confirmed_delivery_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Edi Transmission Status"
      expr: edi_transmission_status
    - name: "Edi Transmitted Timestamp"
      expr: edi_transmitted_timestamp
    - name: "Expected Delivery Date"
      expr: expected_delivery_date
    - name: "Incoterms Code"
      expr: incoterms_code
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Is Cross Dock"
      expr: is_cross_dock
    - name: "Is Drop Ship"
      expr: is_drop_ship
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchase Order"
      expr: COUNT(DISTINCT purchase_order_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Fill Rate Pct"
      expr: SUM(fill_rate_pct)
    - name: "Average Fill Rate Pct"
      expr: AVG(fill_rate_pct)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Net Payable Amount"
      expr: SUM(net_payable_amount)
    - name: "Average Net Payable Amount"
      expr: AVG(net_payable_amount)
    - name: "Total Total Order Amount"
      expr: SUM(total_order_amount)
    - name: "Average Total Order Amount"
      expr: AVG(total_order_amount)
    - name: "Total Total Ordered Units"
      expr: SUM(total_ordered_units)
    - name: "Average Total Ordered Units"
      expr: AVG(total_ordered_units)
    - name: "Total Total Received Units"
      expr: SUM(total_received_units)
    - name: "Average Total Received Units"
      expr: AVG(total_received_units)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_receiving_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving Event business metrics"
  source: "`vibe_retail_v1`.`supplychain`.`receiving_event`"
  dimensions:
    - name: "Actual Carton Count"
      expr: actual_carton_count
    - name: "Actual Pallet Count"
      expr: actual_pallet_count
    - name: "Actual Unit Quantity"
      expr: actual_unit_quantity
    - name: "Advance Ship Notice Number"
      expr: advance_ship_notice_number
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Carton Variance Count"
      expr: carton_variance_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Damage Flag"
      expr: damage_flag
    - name: "Damaged Unit Quantity"
      expr: damaged_unit_quantity
    - name: "Discrepancy Reason Code"
      expr: discrepancy_reason_code
    - name: "Dock Door Number"
      expr: dock_door_number
    - name: "Expected Carton Count"
      expr: expected_carton_count
    - name: "Expected Pallet Count"
      expr: expected_pallet_count
    - name: "Expected Unit Quantity"
      expr: expected_unit_quantity
    - name: "Hazmat Flag"
      expr: hazmat_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Receiving Event"
      expr: COUNT(DISTINCT receiving_event_id)
    - name: "Total Temperature Reading"
      expr: SUM(temperature_reading)
    - name: "Average Temperature Reading"
      expr: AVG(temperature_reading)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_replenishment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment Plan business metrics"
  source: "`vibe_retail_v1`.`supplychain`.`replenishment_plan`"
  dimensions:
    - name: "Buyer Override Flag"
      expr: buyer_override_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Moq Compliance Flag"
      expr: moq_compliance_flag
    - name: "Node Type"
      expr: node_type
    - name: "Order Release Date"
      expr: order_release_date
    - name: "Override Reason Code"
      expr: override_reason_code
    - name: "Plan Generation Timestamp"
      expr: plan_generation_timestamp
    - name: "Plan Horizon End Date"
      expr: plan_horizon_end_date
    - name: "Plan Horizon Start Date"
      expr: plan_horizon_start_date
    - name: "Plan Number"
      expr: plan_number
    - name: "Plan Status"
      expr: plan_status
    - name: "Plan Type"
      expr: plan_type
    - name: "Planned Receipt Date"
      expr: planned_receipt_date
    - name: "Promotion Flag"
      expr: promotion_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Replenishment Plan"
      expr: COUNT(DISTINCT replenishment_plan_id)
    - name: "Total Approved Order Qty"
      expr: SUM(approved_order_qty)
    - name: "Average Approved Order Qty"
      expr: AVG(approved_order_qty)
    - name: "Total Current On Hand Qty"
      expr: SUM(current_on_hand_qty)
    - name: "Average Current On Hand Qty"
      expr: AVG(current_on_hand_qty)
    - name: "Total Demand Variability Factor"
      expr: SUM(demand_variability_factor)
    - name: "Average Demand Variability Factor"
      expr: AVG(demand_variability_factor)
    - name: "Total Fill Rate Target Pct"
      expr: SUM(fill_rate_target_pct)
    - name: "Average Fill Rate Target Pct"
      expr: AVG(fill_rate_target_pct)
    - name: "Total Forecasted Demand Qty"
      expr: SUM(forecasted_demand_qty)
    - name: "Average Forecasted Demand Qty"
      expr: AVG(forecasted_demand_qty)
    - name: "Total Min Order Value"
      expr: SUM(min_order_value)
    - name: "Average Min Order Value"
      expr: AVG(min_order_value)
    - name: "Total Moq"
      expr: SUM(moq)
    - name: "Average Moq"
      expr: AVG(moq)
    - name: "Total On Order Qty"
      expr: SUM(on_order_qty)
    - name: "Average On Order Qty"
      expr: AVG(on_order_qty)
    - name: "Total Order Multiple"
      expr: SUM(order_multiple)
    - name: "Average Order Multiple"
      expr: AVG(order_multiple)
    - name: "Total Planned Order Qty"
      expr: SUM(planned_order_qty)
    - name: "Average Planned Order Qty"
      expr: AVG(planned_order_qty)
    - name: "Total Planned Order Value"
      expr: SUM(planned_order_value)
    - name: "Average Planned Order Value"
      expr: AVG(planned_order_value)
    - name: "Total Reorder Point"
      expr: SUM(reorder_point)
    - name: "Average Reorder Point"
      expr: AVG(reorder_point)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_warehouse_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse Zone business metrics"
  source: "`vibe_retail_v1`.`supplychain`.`warehouse_zone`"
  dimensions:
    - name: "Aisle Range End"
      expr: aisle_range_end
    - name: "Aisle Range Start"
      expr: aisle_range_start
    - name: "Automation Type"
      expr: automation_type
    - name: "Barcode Scanning Required Flag"
      expr: barcode_scanning_required_flag
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cycle Count Frequency"
      expr: cycle_count_frequency
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Hazmat Certified Flag"
      expr: hazmat_certified_flag
    - name: "Last Cycle Count Date"
      expr: last_cycle_count_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Location Count"
      expr: location_count
    - name: "Next Scheduled Cycle Count Date"
      expr: next_scheduled_cycle_count_date
    - name: "Notes"
      expr: notes
    - name: "Pick Method"
      expr: pick_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Warehouse Zone"
      expr: COUNT(DISTINCT warehouse_zone_id)
    - name: "Total Current Occupancy Pct"
      expr: SUM(current_occupancy_pct)
    - name: "Average Current Occupancy Pct"
      expr: AVG(current_occupancy_pct)
    - name: "Total Temperature Max Celsius"
      expr: SUM(temperature_max_celsius)
    - name: "Average Temperature Max Celsius"
      expr: AVG(temperature_max_celsius)
    - name: "Total Temperature Min Celsius"
      expr: SUM(temperature_min_celsius)
    - name: "Average Temperature Min Celsius"
      expr: AVG(temperature_min_celsius)
    - name: "Total Total Capacity Cubic Meters"
      expr: SUM(total_capacity_cubic_meters)
    - name: "Average Total Capacity Cubic Meters"
      expr: AVG(total_capacity_cubic_meters)
    - name: "Total Weight Capacity Kg"
      expr: SUM(weight_capacity_kg)
    - name: "Average Weight Capacity Kg"
      expr: AVG(weight_capacity_kg)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wave business metrics"
  source: "`vibe_retail_v1`.`supplychain`.`wave`"
  dimensions:
    - name: "Actual Pick End Timestamp"
      expr: actual_pick_end_timestamp
    - name: "Actual Pick Start Timestamp"
      expr: actual_pick_start_timestamp
    - name: "Assigned Pick Zones"
      expr: assigned_pick_zones
    - name: "Carrier Service Level"
      expr: carrier_service_level
    - name: "Channel"
      expr: channel
    - name: "Consolidation Location"
      expr: consolidation_location
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Equipment Type"
      expr: equipment_type
    - name: "Generation Method"
      expr: generation_method
    - name: "Is Hazmat"
      expr: is_hazmat
    - name: "Is Promotional"
      expr: is_promotional
    - name: "Is Temperature Controlled"
      expr: is_temperature_controlled
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Notes"
      expr: notes
    - name: "Picked Units"
      expr: picked_units
    - name: "Planned Pick End Timestamp"
      expr: planned_pick_end_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Wave"
      expr: COUNT(DISTINCT wave_id)
    - name: "Total Fill Rate Pct"
      expr: SUM(fill_rate_pct)
    - name: "Average Fill Rate Pct"
      expr: AVG(fill_rate_pct)
    - name: "Total Labor Hours Actual"
      expr: SUM(labor_hours_actual)
    - name: "Average Labor Hours Actual"
      expr: AVG(labor_hours_actual)
    - name: "Total Labor Hours Planned"
      expr: SUM(labor_hours_planned)
    - name: "Average Labor Hours Planned"
      expr: AVG(labor_hours_planned)
    - name: "Total Template Code"
      expr: SUM(template_code)
    - name: "Average Template Code"
      expr: AVG(template_code)
    - name: "Total Units Per Hour"
      expr: SUM(units_per_hour)
    - name: "Average Units Per Hour"
      expr: AVG(units_per_hour)
$$;