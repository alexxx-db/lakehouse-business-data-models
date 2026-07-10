-- Metric views for domain: inventory | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 19:59:49

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_on_hand_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory on-hand balance metrics tracking stock levels, valuation, and inventory health across locations and SKUs"
  source: "`vibe_restaurants_v1`.`inventory`.`on_hand_balance`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of inventory (available, reserved, quarantined, etc.)"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for inventory prioritization (A=high value, B=medium, C=low)"
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone requirement for storage (frozen, refrigerated, ambient)"
    - name: "is_perishable"
      expr: is_perishable
      comment: "Flag indicating whether the item is perishable"
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (FIFO, LIFO, weighted average)"
    - name: "cycle_count_frequency"
      expr: cycle_count_frequency
      comment: "Frequency of cycle counting for this inventory item"
    - name: "sku_code"
      expr: sku_code
      comment: "Stock keeping unit code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for inventory valuation"
    - name: "snapshot_date"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Date of inventory snapshot"
    - name: "snapshot_month"
      expr: DATE_TRUNC('month', snapshot_timestamp)
      comment: "Month of inventory snapshot"
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month when inventory expires"
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(extended_value AS DOUBLE))
      comment: "Total extended value of inventory on hand across all SKUs and locations"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of inventory on hand"
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for use (on hand minus reserved)"
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved for orders or production"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of inventory items"
    - name: "inventory_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_available AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available (not reserved)"
    - name: "total_variance_from_par"
      expr: SUM(CAST(variance_from_par AS DOUBLE))
      comment: "Total variance from par levels across all inventory items"
    - name: "stockout_risk_count"
      expr: SUM(CASE WHEN CAST(quantity_on_hand AS DOUBLE) <= CAST(reorder_point AS DOUBLE) THEN 1 ELSE 0 END)
      comment: "Count of inventory items at or below reorder point indicating stockout risk"
    - name: "excess_inventory_count"
      expr: SUM(CASE WHEN CAST(quantity_on_hand AS DOUBLE) > CAST(par_level AS DOUBLE) * 1.5 THEN 1 ELSE 0 END)
      comment: "Count of inventory items with on-hand quantity exceeding 150% of par level"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_code)
      comment: "Number of distinct SKUs in inventory"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_physical_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory count metrics tracking count accuracy, variance, and cycle count performance"
  source: "`vibe_restaurants_v1`.`inventory`.`physical_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the physical count (scheduled, in progress, completed, approved, cancelled)"
    - name: "count_type"
      expr: count_type
      comment: "Type of physical count (full, cycle, spot, blind)"
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (manual, barcode scan, RFID)"
    - name: "count_period"
      expr: count_period
      comment: "Period of the count (daily, weekly, monthly, quarterly, annual)"
    - name: "is_period_end_count"
      expr: is_period_end_count
      comment: "Flag indicating whether this is a period-end count for financial reporting"
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Flag indicating whether a recount is required due to significant variance"
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Reason code for inventory variance"
    - name: "count_date"
      expr: count_date
      comment: "Date of the physical count"
    - name: "count_month"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month of the physical count"
  measures:
    - name: "total_physical_inventory_value"
      expr: SUM(CAST(physical_inventory_value AS DOUBLE))
      comment: "Total physical inventory value from counts"
    - name: "total_system_inventory_value"
      expr: SUM(CAST(system_inventory_value AS DOUBLE))
      comment: "Total system inventory value at time of count"
    - name: "total_variance_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Total dollar variance between physical and system inventory"
    - name: "inventory_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(physical_inventory_value AS DOUBLE)) / NULLIF(SUM(CAST(system_inventory_value AS DOUBLE)), 0), 2)
      comment: "Percentage accuracy of physical inventory compared to system records"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(total_variance_percentage AS DOUBLE))
      comment: "Average variance percentage across all physical counts"
    - name: "count_completion_count"
      expr: SUM(CASE WHEN count_status = 'completed' OR count_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Number of physical counts completed or approved"
    - name: "recount_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recount_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring recount due to variance"
    - name: "avg_count_duration_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(actual_end_timestamp) - UNIX_TIMESTAMP(actual_start_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average duration of physical counts in hours"
    - name: "total_count_events"
      expr: COUNT(1)
      comment: "Total number of physical count events"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_receiving_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving order metrics tracking delivery performance, quality inspection, and receiving accuracy"
  source: "`vibe_restaurants_v1`.`inventory`.`receiving_order`"
  dimensions:
    - name: "receiving_status"
      expr: receiving_status
      comment: "Status of the receiving order (scheduled, in progress, completed, posted, rejected)"
    - name: "quality_inspection_result"
      expr: quality_inspection_result
      comment: "Result of quality inspection (passed, failed, conditional)"
    - name: "temperature_check_result"
      expr: temperature_check_result
      comment: "Result of temperature check for temperature-sensitive items"
    - name: "delivery_timeliness"
      expr: delivery_timeliness
      comment: "Timeliness of delivery (early, on-time, late)"
    - name: "variance_flag"
      expr: variance_flag
      comment: "Flag indicating whether there was a variance between ordered and received quantities"
    - name: "posted_to_inventory_flag"
      expr: posted_to_inventory_flag
      comment: "Flag indicating whether the receipt has been posted to inventory"
    - name: "variance_reason"
      expr: variance_reason
      comment: "Reason for variance between ordered and received"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for rejecting the delivery"
    - name: "supplier_name"
      expr: supplier_name
      comment: "Name of the supplier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for receiving value"
    - name: "delivery_date"
      expr: delivery_date
      comment: "Date of delivery"
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of delivery"
  measures:
    - name: "total_received_value"
      expr: SUM(CAST(total_received_value AS DOUBLE))
      comment: "Total value of goods received"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN delivery_timeliness = 'on-time' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries received on time"
    - name: "quality_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_inspection_result = 'passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries passing quality inspection"
    - name: "temperature_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_check_result = 'passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of temperature-sensitive deliveries meeting temperature requirements"
    - name: "receiving_variance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN variance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receiving orders with quantity or quality variance"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN receiving_status = 'rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries rejected"
    - name: "avg_temperature_recorded"
      expr: AVG(CAST(temperature_recorded AS DOUBLE))
      comment: "Average temperature recorded at receiving for temperature-sensitive items"
    - name: "total_receiving_orders"
      expr: COUNT(1)
      comment: "Total number of receiving orders"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_name)
      comment: "Number of distinct suppliers delivering goods"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock transfer metrics tracking inter-location transfer efficiency, accuracy, and value movement"
  source: "`vibe_restaurants_v1`.`inventory`.`stock_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Status of the stock transfer (requested, approved, in transit, received, cancelled)"
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (inter-unit, inter-location, emergency, planned)"
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Reason code for the transfer (rebalancing, stockout, excess, spoilage)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer (urgent, high, normal, low)"
    - name: "variance_flag"
      expr: variance_flag
      comment: "Flag indicating variance between shipped and received quantities"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Status of quality inspection at destination"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flag indicating whether transfer requires temperature control"
    - name: "shipping_method"
      expr: shipping_method
      comment: "Method of shipping (internal fleet, third-party carrier, courier)"
    - name: "temperature_zone_required"
      expr: temperature_zone_required
      comment: "Temperature zone required for transfer"
    - name: "transfer_request_month"
      expr: DATE_TRUNC('month', transfer_request_date)
      comment: "Month when transfer was requested"
    - name: "transfer_received_month"
      expr: DATE_TRUNC('month', transfer_received_date)
      comment: "Month when transfer was received"
  measures:
    - name: "total_transfer_value"
      expr: SUM(CAST(total_transfer_value_usd AS DOUBLE))
      comment: "Total value of inventory transferred in USD"
    - name: "total_quantity_transferred"
      expr: SUM(CAST(total_quantity_transferred AS DOUBLE))
      comment: "Total quantity of items transferred"
    - name: "transfer_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN transfer_status = 'received' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers successfully completed and received"
    - name: "transfer_variance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN variance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers with quantity variance between shipped and received"
    - name: "avg_transfer_cycle_time_days"
      expr: AVG(CAST(DATEDIFF(transfer_received_date, transfer_request_date) AS DOUBLE))
      comment: "Average number of days from transfer request to receipt"
    - name: "emergency_transfer_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN priority_level = 'urgent' OR priority_level = 'high' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers marked as urgent or high priority"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN transfer_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers cancelled before completion"
    - name: "total_transfer_count"
      expr: COUNT(1)
      comment: "Total number of stock transfer transactions"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_waste_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste log metrics tracking food waste, cost of waste, and waste prevention opportunities"
  source: "`vibe_restaurants_v1`.`inventory`.`waste_log`"
  dimensions:
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (spoilage, preparation, overproduction, customer return, damaged)"
    - name: "waste_reason"
      expr: waste_reason
      comment: "Specific reason for waste"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of disposal (trash, compost, donation, recycling)"
    - name: "daypart"
      expr: daypart
      comment: "Daypart when waste occurred (breakfast, lunch, dinner, late night)"
    - name: "haccp_violation"
      expr: haccp_violation
      comment: "Flag indicating whether waste was due to HACCP violation"
    - name: "manager_approved"
      expr: manager_approved
      comment: "Flag indicating whether waste was approved by manager"
    - name: "waste_prevention_opportunity"
      expr: waste_prevention_opportunity
      comment: "Identified opportunity to prevent similar waste in future"
    - name: "waste_date"
      expr: waste_date
      comment: "Date when waste occurred"
    - name: "waste_month"
      expr: DATE_TRUNC('month', waste_date)
      comment: "Month when waste occurred"
  measures:
    - name: "total_waste_cost"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total cost of wasted inventory"
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total quantity of inventory wasted"
    - name: "avg_waste_cost_per_event"
      expr: AVG(CAST(waste_cost AS DOUBLE))
      comment: "Average cost per waste event"
    - name: "haccp_violation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN haccp_violation = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waste events due to HACCP violations"
    - name: "preventable_waste_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN waste_prevention_opportunity IS NOT NULL AND waste_prevention_opportunity != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waste events with identified prevention opportunities"
    - name: "spoilage_waste_cost"
      expr: SUM(CASE WHEN waste_category = 'spoilage' THEN CAST(waste_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of waste due to spoilage"
    - name: "overproduction_waste_cost"
      expr: SUM(CASE WHEN waste_category = 'overproduction' THEN CAST(waste_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of waste due to overproduction"
    - name: "avg_temperature_at_waste"
      expr: AVG(CAST(temperature_at_waste AS DOUBLE))
      comment: "Average temperature recorded at time of waste for temperature-sensitive items"
    - name: "total_waste_events"
      expr: COUNT(1)
      comment: "Total number of waste events logged"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_stock_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock location metrics tracking storage capacity utilization, location performance, and compliance"
  source: "`vibe_restaurants_v1`.`inventory`.`stock_location`"
  dimensions:
    - name: "stock_location_status"
      expr: stock_location_status
      comment: "Status of the stock location (active, inactive, maintenance, decommissioned)"
    - name: "location_type"
      expr: location_type
      comment: "Type of stock location (warehouse, walk-in cooler, freezer, dry storage, prep area)"
    - name: "storage_area_type"
      expr: storage_area_type
      comment: "Area type for storage classification"
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the location (frozen, refrigerated, ambient)"
    - name: "requires_haccp_monitoring"
      expr: requires_haccp_monitoring
      comment: "Flag indicating whether location requires HACCP monitoring"
    - name: "access_control_required"
      expr: access_control_required
      comment: "Flag indicating whether access control is required"
    - name: "par_level_enabled"
      expr: par_level_enabled
      comment: "Flag indicating whether par level management is enabled for this location"
    - name: "allows_receiving"
      expr: allows_receiving
      comment: "Flag indicating whether location allows receiving operations"
    - name: "allows_transfers"
      expr: allows_transfers
      comment: "Flag indicating whether location allows transfer operations"
    - name: "primary_commodity_category"
      expr: primary_commodity_category
      comment: "Primary commodity category stored in this location"
  measures:
    - name: "total_storage_capacity_cubic_feet"
      expr: SUM(CAST(capacity_cubic_feet AS DOUBLE))
      comment: "Total storage capacity across all locations in cubic feet"
    - name: "avg_target_temperature_min"
      expr: AVG(CAST(target_temperature_min_f AS DOUBLE))
      comment: "Average minimum target temperature across temperature-controlled locations"
    - name: "avg_target_temperature_max"
      expr: AVG(CAST(target_temperature_max_f AS DOUBLE))
      comment: "Average maximum target temperature across temperature-controlled locations"
    - name: "haccp_monitored_location_count"
      expr: SUM(CASE WHEN requires_haccp_monitoring = TRUE THEN 1 ELSE 0 END)
      comment: "Number of locations requiring HACCP monitoring"
    - name: "active_location_count"
      expr: SUM(CASE WHEN stock_location_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of active stock locations"
    - name: "total_location_count"
      expr: COUNT(1)
      comment: "Total number of stock locations"
$$;