-- Metric views for domain: inventory | Business: Automotive | Version: 2 | Generated on: 2026-07-14 04:29:43

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_finished_vehicle_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finished Vehicle Stock business metrics"
  source: "`vibe_automotive_v1`.`inventory`.`finished_vehicle_stock`"
  dimensions:
    - name: "Aging Days"
      expr: aging_days
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Batch Number"
      expr: batch_number
    - name: "Body Style"
      expr: body_style
    - name: "Color"
      expr: color
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Emission Standard"
      expr: emission_standard
    - name: "Expected Delivery Date"
      expr: expected_delivery_date
    - name: "Hold Code"
      expr: hold_code
    - name: "Hold Reason"
      expr: hold_reason
    - name: "Location Type"
      expr: location_type
    - name: "Lot Number"
      expr: lot_number
    - name: "Production Date"
      expr: production_date
    - name: "Production Line"
      expr: production_line
    - name: "Recall Flag"
      expr: recall_flag
    - name: "Record Audit Created"
      expr: record_audit_created
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Finished Vehicle Stock"
      expr: COUNT(DISTINCT finished_vehicle_stock_id)
    - name: "Total Msrp"
      expr: SUM(msrp)
    - name: "Average Msrp"
      expr: AVG(msrp)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods Movement business metrics"
  source: "`vibe_automotive_v1`.`inventory`.`goods_movement`"
  dimensions:
    - name: "Base Uom"
      expr: base_uom
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency"
      expr: currency
    - name: "Delivery Note Number"
      expr: delivery_note_number
    - name: "Destination Plant"
      expr: destination_plant
    - name: "Destination Storage Location"
      expr: destination_storage_location
    - name: "Goods Movement Status"
      expr: goods_movement_status
    - name: "Inspection Document Number"
      expr: inspection_document_number
    - name: "Is Automated"
      expr: is_automated
    - name: "Is Lot Tracked"
      expr: is_lot_tracked
    - name: "Is Serial Tracked"
      expr: is_serial_tracked
    - name: "Line Sequence"
      expr: line_sequence
    - name: "Location Zone"
      expr: location_zone
    - name: "Lot Number"
      expr: lot_number
    - name: "Movement Reason"
      expr: movement_reason
    - name: "Posting Date"
      expr: posting_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Goods Movement"
      expr: COUNT(DISTINCT goods_movement_id)
    - name: "Total Amount Local"
      expr: SUM(amount_local)
    - name: "Average Amount Local"
      expr: AVG(amount_local)
    - name: "Total Amount Usd"
      expr: SUM(amount_usd)
    - name: "Average Amount Usd"
      expr: AVG(amount_usd)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_mrp_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mrp Requirement business metrics"
  source: "`vibe_automotive_v1`.`inventory`.`mrp_requirement`"
  dimensions:
    - name: "Batch Flag"
      expr: batch_flag
    - name: "Demand Source"
      expr: demand_source
    - name: "Exception Message"
      expr: exception_message
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Mrp Requirement Status"
      expr: mrp_requirement_status
    - name: "Planning Horizon Days"
      expr: planning_horizon_days
    - name: "Planning Scenario"
      expr: planning_scenario
    - name: "Priority Code"
      expr: priority_code
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Requirement Date"
      expr: requirement_date
    - name: "Requirement Number"
      expr: requirement_number
    - name: "Requirement Type"
      expr: requirement_type
    - name: "Unit Of Measure"
      expr: unit_of_measure
    - name: "Record Audit Created Month"
      expr: DATE_TRUNC('MONTH', record_audit_created)
    - name: "Record Audit Updated Month"
      expr: DATE_TRUNC('MONTH', record_audit_updated)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mrp Requirement"
      expr: COUNT(DISTINCT mrp_requirement_id)
    - name: "Total Lot Size"
      expr: SUM(lot_size)
    - name: "Average Lot Size"
      expr: AVG(lot_size)
    - name: "Total Quantity Required"
      expr: SUM(quantity_required)
    - name: "Average Quantity Required"
      expr: AVG(quantity_required)
    - name: "Total Reorder Point"
      expr: SUM(reorder_point)
    - name: "Average Reorder Point"
      expr: AVG(reorder_point)
    - name: "Total Safety Stock"
      expr: SUM(safety_stock)
    - name: "Average Safety Stock"
      expr: AVG(safety_stock)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment Order business metrics"
  source: "`vibe_automotive_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "Actual Delivery Timestamp"
      expr: actual_delivery_timestamp
    - name: "Batch Number"
      expr: batch_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Fulfillment Status"
      expr: fulfillment_status
    - name: "Is Critical"
      expr: is_critical
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Lot Number"
      expr: lot_number
    - name: "Max Stock Level"
      expr: max_stock_level
    - name: "Min Stock Level"
      expr: min_stock_level
    - name: "Notes"
      expr: notes
    - name: "Order Number"
      expr: order_number
    - name: "Order Status"
      expr: order_status
    - name: "Order Type"
      expr: order_type
    - name: "Priority Level"
      expr: priority_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Replenishment Order"
      expr: COUNT(DISTINCT replenishment_order_id)
    - name: "Total Cost Per Unit"
      expr: SUM(cost_per_unit)
    - name: "Average Cost Per Unit"
      expr: AVG(cost_per_unit)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_service_parts_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Parts Stock business metrics"
  source: "`vibe_automotive_v1`.`inventory`.`service_parts_stock`"
  dimensions:
    - name: "Aisle"
      expr: aisle
    - name: "Batch Number"
      expr: batch_number
    - name: "Bin Number"
      expr: bin_number
    - name: "Currency Code"
      expr: currency_code
    - name: "Cycle Count Status"
      expr: cycle_count_status
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Inventory Status"
      expr: inventory_status
    - name: "Last Cost Update Timestamp"
      expr: last_cost_update_timestamp
    - name: "Last Count Date"
      expr: last_count_date
    - name: "Last Issue Date"
      expr: last_issue_date
    - name: "Last Receipt Date"
      expr: last_receipt_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Lot Number"
      expr: lot_number
    - name: "Max Stock Level"
      expr: max_stock_level
    - name: "Min Stock Level"
      expr: min_stock_level
    - name: "Obsolescence Date"
      expr: obsolescence_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Parts Stock"
      expr: COUNT(DISTINCT service_parts_stock_id)
    - name: "Total Cost Per Unit"
      expr: SUM(cost_per_unit)
    - name: "Average Cost Per Unit"
      expr: AVG(cost_per_unit)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_sku_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sku Master business metrics"
  source: "`vibe_automotive_v1`.`inventory`.`sku_master`"
  dimensions:
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customs Tariff Code"
      expr: customs_tariff_code
    - name: "Description"
      expr: sku_master_description
    - name: "Ean13"
      expr: ean13
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Hazardous Class"
      expr: hazardous_class
    - name: "Hazardous Flag"
      expr: hazardous_flag
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Lot Controlled Flag"
      expr: lot_controlled_flag
    - name: "Material Group"
      expr: material_group
    - name: "Material Type"
      expr: material_type
    - name: "Mrp Controller"
      expr: mrp_controller
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sku Master"
      expr: COUNT(DISTINCT sku_master_id)
    - name: "Total Height Cm"
      expr: SUM(height_cm)
    - name: "Average Height Cm"
      expr: AVG(height_cm)
    - name: "Total Last Price"
      expr: SUM(last_price)
    - name: "Average Last Price"
      expr: AVG(last_price)
    - name: "Total Length Cm"
      expr: SUM(length_cm)
    - name: "Average Length Cm"
      expr: AVG(length_cm)
    - name: "Total Max Order Qty"
      expr: SUM(max_order_qty)
    - name: "Average Max Order Qty"
      expr: AVG(max_order_qty)
    - name: "Total Min Order Qty"
      expr: SUM(min_order_qty)
    - name: "Average Min Order Qty"
      expr: AVG(min_order_qty)
    - name: "Total Reorder Point Qty"
      expr: SUM(reorder_point_qty)
    - name: "Average Reorder Point Qty"
      expr: AVG(reorder_point_qty)
    - name: "Total Safety Stock Qty"
      expr: SUM(safety_stock_qty)
    - name: "Average Safety Stock Qty"
      expr: AVG(safety_stock_qty)
    - name: "Total Standard Price"
      expr: SUM(standard_price)
    - name: "Average Standard Price"
      expr: AVG(standard_price)
    - name: "Total Volume M3"
      expr: SUM(volume_m3)
    - name: "Average Volume M3"
      expr: AVG(volume_m3)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
    - name: "Total Width Cm"
      expr: SUM(width_cm)
    - name: "Average Width Cm"
      expr: AVG(width_cm)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock Balance business metrics"
  source: "`vibe_automotive_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Goods Movement Type"
      expr: goods_movement_type
    - name: "Is Serialized"
      expr: is_serialized
    - name: "Last Movement Timestamp"
      expr: last_movement_timestamp
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Lot Number"
      expr: lot_number
    - name: "Manufacturing Date"
      expr: manufacturing_date
    - name: "Physical Location Hierarchy"
      expr: physical_location_hierarchy
    - name: "Plant Code"
      expr: plant_code
    - name: "Purchase Order Number"
      expr: purchase_order_number
    - name: "Quality Status"
      expr: quality_status
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Serial Number"
      expr: serial_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stock Balance"
      expr: COUNT(DISTINCT stock_balance_id)
    - name: "Total Blocked Stock Qty"
      expr: SUM(blocked_stock_qty)
    - name: "Average Blocked Stock Qty"
      expr: AVG(blocked_stock_qty)
    - name: "Total Consignment Stock Qty"
      expr: SUM(consignment_stock_qty)
    - name: "Average Consignment Stock Qty"
      expr: AVG(consignment_stock_qty)
    - name: "Total In Transit Stock Qty"
      expr: SUM(in_transit_stock_qty)
    - name: "Average In Transit Stock Qty"
      expr: AVG(in_transit_stock_qty)
    - name: "Total Quality Inspection Stock Qty"
      expr: SUM(quality_inspection_stock_qty)
    - name: "Average Quality Inspection Stock Qty"
      expr: AVG(quality_inspection_stock_qty)
    - name: "Total Quantity On Hand"
      expr: SUM(quantity_on_hand)
    - name: "Average Quantity On Hand"
      expr: AVG(quantity_on_hand)
    - name: "Total Safety Stock Qty"
      expr: SUM(safety_stock_qty)
    - name: "Average Safety Stock Qty"
      expr: AVG(safety_stock_qty)
    - name: "Total Unrestricted Stock Qty"
      expr: SUM(unrestricted_stock_qty)
    - name: "Average Unrestricted Stock Qty"
      expr: AVG(unrestricted_stock_qty)
    - name: "Total Valuation Price"
      expr: SUM(valuation_price)
    - name: "Average Valuation Price"
      expr: AVG(valuation_price)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_stock_transfer_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock Transfer Order business metrics"
  source: "`vibe_automotive_v1`.`inventory`.`stock_transfer_order`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Confirmation Status"
      expr: confirmation_status
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Cost Currency"
      expr: cost_currency
    - name: "Execution End Timestamp"
      expr: execution_end_timestamp
    - name: "Execution Start Timestamp"
      expr: execution_start_timestamp
    - name: "Handling Instructions"
      expr: handling_instructions
    - name: "Hazardous Material Flag"
      expr: hazardous_material_flag
    - name: "Is Jis"
      expr: is_jis
    - name: "Is Jit"
      expr: is_jit
    - name: "Lot Number"
      expr: lot_number
    - name: "Movement Reason Code"
      expr: movement_reason_code
    - name: "Priority"
      expr: priority
    - name: "Project Number"
      expr: project_number
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stock Transfer Order"
      expr: COUNT(DISTINCT stock_transfer_order_id)
    - name: "Total Agv Code"
      expr: SUM(agv_code)
    - name: "Average Agv Code"
      expr: AVG(agv_code)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage Location business metrics"
  source: "`vibe_automotive_v1`.`inventory`.`storage_location`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Agv Routing Priority"
      expr: agv_routing_priority
    - name: "Aisle"
      expr: aisle
    - name: "Bin"
      expr: bin
    - name: "Capacity Uom"
      expr: capacity_uom
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: storage_location_description
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "External System Source"
      expr: external_system_source
    - name: "Fire Safety Rating"
      expr: fire_safety_rating
    - name: "Hazardous Material Allowed"
      expr: hazardous_material_allowed
    - name: "Is Default Location"
      expr: is_default_location
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Storage Location"
      expr: COUNT(DISTINCT storage_location_id)
    - name: "Total Capacity Quantity"
      expr: SUM(capacity_quantity)
    - name: "Average Capacity Quantity"
      expr: AVG(capacity_quantity)
    - name: "Total Inventory Accuracy Percent"
      expr: SUM(inventory_accuracy_percent)
    - name: "Average Inventory Accuracy Percent"
      expr: AVG(inventory_accuracy_percent)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Used Capacity Percentage"
      expr: SUM(used_capacity_percentage)
    - name: "Average Used Capacity Percentage"
      expr: AVG(used_capacity_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse business metrics"
  source: "`vibe_automotive_v1`.`inventory`.`warehouse`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "City"
      expr: city
    - name: "Close Date"
      expr: close_date
    - name: "Code"
      expr: warehouse_code
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: description
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Manager Email"
      expr: manager_email
    - name: "Manager Name"
      expr: manager_name
    - name: "Manager Phone"
      expr: manager_phone
    - name: "Name"
      expr: name
    - name: "Open Date"
      expr: open_date
    - name: "Operating Hours"
      expr: operating_hours
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Warehouse"
      expr: COUNT(DISTINCT warehouse_id)
    - name: "Total Capacity Cubic M"
      expr: SUM(capacity_cubic_m)
    - name: "Average Capacity Cubic M"
      expr: AVG(capacity_cubic_m)
    - name: "Total Capacity Sqft"
      expr: SUM(capacity_sqft)
    - name: "Average Capacity Sqft"
      expr: AVG(capacity_sqft)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;
