-- Metric views for domain: warehouse | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_inventory_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory position metrics tracking stock levels, availability, and inventory health across warehouse facilities for supply chain visibility and working capital optimization."
  source: "`transport_shipping_ecm`.`warehouse`.`inventory_position`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility identifier for location-based inventory analysis"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (available, hold, damaged, quarantine) for stock health segmentation"
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Whether inventory is hazardous material requiring special handling"
    - name: "temperature_controlled_indicator"
      expr: temperature_controlled_indicator
      comment: "Whether inventory requires temperature-controlled storage"
    - name: "putaway_zone"
      expr: putaway_zone
      comment: "Storage zone assignment for zone-level inventory analysis"
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of inventory receipt for aging and turnover analysis"
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand inventory quantity across all positions - primary stock level indicator"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available (sellable/fulfillable) inventory quantity"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total reserved inventory committed to orders but not yet picked"
    - name: "total_hold_quantity"
      expr: SUM(CAST(hold_quantity AS DOUBLE))
      comment: "Total inventory on hold (quality, regulatory, or other holds) - risk indicator"
    - name: "total_damaged_quantity"
      expr: SUM(CAST(damaged_quantity AS DOUBLE))
      comment: "Total damaged inventory quantity - shrinkage and quality indicator"
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total inventory in transit to the facility"
    - name: "total_quarantine_quantity"
      expr: SUM(CAST(quarantine_quantity AS DOUBLE))
      comment: "Total quarantined inventory pending inspection or disposition"
    - name: "total_inventory_value"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE) * CAST(cost_per_unit AS DOUBLE))
      comment: "Total inventory value at cost - working capital metric"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across inventory positions"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs in inventory - product breadth indicator"
    - name: "inventory_position_count"
      expr: COUNT(1)
      comment: "Total number of inventory position records"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_inbound_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving metrics tracking receipt performance, dock-to-stock efficiency, and receiving quality for warehouse throughput optimization."
  source: "`transport_shipping_ecm`.`warehouse`.`inbound_receipt`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility identifier for site-level receiving analysis"
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current receipt processing status"
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of receipt (standard, cross-dock, returns, etc.)"
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Whether receipt had quantity or quality discrepancies"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether receipt contains hazardous materials"
    - name: "cross_dock_flag"
      expr: cross_dock_flag
      comment: "Whether receipt is designated for cross-docking (bypass putaway)"
    - name: "receipt_month"
      expr: DATE_TRUNC('month', actual_arrival_timestamp)
      comment: "Month of actual arrival for trend analysis"
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of inbound receipts processed"
    - name: "total_weight_received_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight received in kilograms - throughput volume indicator"
    - name: "total_volume_received_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume received in cubic meters"
    - name: "receipts_with_discrepancies"
      expr: SUM(CASE WHEN discrepancy_flag = true THEN 1 ELSE 0 END)
      comment: "Count of receipts with discrepancies - supplier quality indicator"
    - name: "avg_temperature_recorded_c"
      expr: AVG(CAST(temperature_recorded_c AS DOUBLE))
      comment: "Average temperature recorded at receipt for cold chain compliance monitoring"
    - name: "distinct_carrier_count"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers delivering inbound shipments"
    - name: "cross_dock_receipt_count"
      expr: SUM(CASE WHEN cross_dock_flag = true THEN 1 ELSE 0 END)
      comment: "Count of cross-dock receipts for flow-through efficiency tracking"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_outbound_shipment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound shipment order metrics tracking fulfillment performance, on-time delivery, and order throughput for customer service and operational efficiency."
  source: "`transport_shipping_ecm`.`warehouse`.`outbound_shipment_order`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility fulfilling the order"
    - name: "order_status"
      expr: order_status
      comment: "Current order processing status for pipeline analysis"
    - name: "order_type"
      expr: order_type
      comment: "Type of outbound order (standard, expedited, wholesale, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Order priority level for workload segmentation"
    - name: "sla_service_level"
      expr: sla_service_level
      comment: "Contracted service level for SLA compliance tracking"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether order contains hazardous materials"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for geographic distribution analysis"
    - name: "order_received_month"
      expr: DATE_TRUNC('month', order_received_timestamp)
      comment: "Month order was received for demand trend analysis"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total outbound shipment orders - primary volume metric"
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of outbound orders in kilograms"
    - name: "total_order_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume of outbound orders in cubic meters"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight (max of actual vs dimensional) - revenue driver"
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN otd_flag = true THEN 1 ELSE 0 END)
      comment: "Count of orders delivered on time - OTD numerator for rate calculation"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers served - customer reach metric"
    - name: "distinct_carrier_count"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers used for outbound shipments"
    - name: "avg_dim_weight_kg"
      expr: AVG(CAST(dim_weight_kg AS DOUBLE))
      comment: "Average dimensional weight per order - packaging efficiency indicator"
    - name: "cod_total_amount"
      expr: SUM(CAST(cod_amount AS DOUBLE))
      comment: "Total cash-on-delivery amount across orders"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pick task metrics tracking picking productivity, accuracy, and efficiency for warehouse labor optimization and fulfillment speed."
  source: "`transport_shipping_ecm`.`warehouse`.`pick_task`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility where picking occurs"
    - name: "task_status"
      expr: task_status
      comment: "Current pick task status for pipeline and backlog analysis"
    - name: "pick_method"
      expr: pick_method
      comment: "Picking method used (discrete, batch, cluster, zone)"
    - name: "pick_type"
      expr: pick_type
      comment: "Type of pick (full case, each, pallet)"
    - name: "zone_code"
      expr: zone_code
      comment: "Warehouse zone where pick occurs for zone productivity analysis"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether pick involves hazardous materials"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date task was created for daily throughput trending"
  measures:
    - name: "total_pick_tasks"
      expr: COUNT(1)
      comment: "Total number of pick tasks - workload volume metric"
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total units picked across all tasks"
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total units requested for picking - demand indicator"
    - name: "total_short_pick_quantity"
      expr: SUM(CAST(short_pick_quantity AS DOUBLE))
      comment: "Total short-picked units - stock availability and accuracy issue indicator"
    - name: "total_travel_distance_meters"
      expr: SUM(CAST(travel_distance_meters AS DOUBLE))
      comment: "Total travel distance in meters - layout efficiency and labor cost driver"
    - name: "total_weight_picked_kg"
      expr: SUM(CAST(weight_picked_kg AS DOUBLE))
      comment: "Total weight picked in kilograms - ergonomic and throughput metric"
    - name: "total_volume_picked_cbm"
      expr: SUM(CAST(volume_picked_cbm AS DOUBLE))
      comment: "Total volume picked in cubic meters"
    - name: "avg_travel_distance_meters"
      expr: AVG(CAST(travel_distance_meters AS DOUBLE))
      comment: "Average travel distance per pick task - slotting optimization indicator"
    - name: "distinct_picker_count"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct pickers active - labor utilization metric"
    - name: "short_pick_task_count"
      expr: SUM(CASE WHEN short_pick_quantity > 0 THEN 1 ELSE 0 END)
      comment: "Count of tasks with short picks - inventory accuracy signal"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_labor_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse labor activity metrics tracking productivity, cost efficiency, and workforce utilization for labor planning and performance management."
  source: "`transport_shipping_ecm`.`warehouse`.`labor_activity`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility for site-level labor analysis"
    - name: "activity_type"
      expr: activity_type
      comment: "Type of warehouse activity (picking, packing, putaway, replenishment, etc.)"
    - name: "activity_status"
      expr: activity_status
      comment: "Current activity status for pipeline analysis"
    - name: "priority_level"
      expr: priority_level
      comment: "Activity priority level for workload segmentation"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment used during activity"
    - name: "training_mode"
      expr: training_mode
      comment: "Whether activity was performed in training mode (exclude from productivity benchmarks)"
    - name: "activity_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date activity started for daily labor trending"
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of labor activities recorded"
    - name: "total_actual_time_minutes"
      expr: SUM(CAST(actual_time_minutes AS DOUBLE))
      comment: "Total actual time spent on activities in minutes - labor cost driver"
    - name: "total_standard_time_minutes"
      expr: SUM(CAST(standard_time_minutes AS DOUBLE))
      comment: "Total engineered standard time in minutes - benchmark for productivity"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across all activities - direct cost metric"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive pay earned - performance reward tracking"
    - name: "total_travel_distance_meters"
      expr: SUM(CAST(travel_distance_meters AS DOUBLE))
      comment: "Total travel distance in meters - non-productive time indicator"
    - name: "avg_productivity_percentage"
      expr: AVG(CAST(productivity_percentage AS DOUBLE))
      comment: "Average productivity percentage (actual vs standard) - workforce efficiency KPI"
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average activity duration in minutes"
    - name: "distinct_employee_count"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees performing activities - headcount utilization"
    - name: "quality_check_pass_count"
      expr: SUM(CASE WHEN quality_check_passed = true THEN 1 ELSE 0 END)
      comment: "Count of activities passing quality checks - first-pass quality rate numerator"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_dock_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dock appointment metrics tracking dock utilization, carrier punctuality, and loading/unloading efficiency for yard management and throughput optimization."
  source: "`transport_shipping_ecm`.`warehouse`.`dock_appointment`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility for dock performance analysis"
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current appointment status (scheduled, checked-in, completed, no-show, cancelled)"
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of appointment (inbound, outbound, cross-dock)"
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Whether appointment involves hazardous materials"
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether appointment requires temperature-controlled handling"
    - name: "shipment_priority"
      expr: shipment_priority
      comment: "Priority level of the shipment for scheduling analysis"
    - name: "scheduled_date"
      expr: DATE_TRUNC('day', scheduled_arrival_start)
      comment: "Scheduled arrival date for daily dock planning"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total dock appointments - dock demand metric"
    - name: "total_expected_weight_kg"
      expr: SUM(CAST(expected_weight_kg AS DOUBLE))
      comment: "Total expected weight across appointments - capacity planning metric"
    - name: "total_expected_volume_cbm"
      expr: SUM(CAST(expected_volume_cbm AS DOUBLE))
      comment: "Total expected volume across appointments"
    - name: "distinct_carrier_count"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers with appointments"
    - name: "no_show_count"
      expr: SUM(CASE WHEN appointment_status = 'no_show' THEN 1 ELSE 0 END)
      comment: "Count of no-show appointments - carrier reliability indicator"
    - name: "cancelled_count"
      expr: SUM(CASE WHEN appointment_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled appointments - planning disruption metric"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count metrics tracking inventory accuracy, count program effectiveness, and variance management for inventory control and financial compliance."
  source: "`transport_shipping_ecm`.`warehouse`.`cycle_count`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility for site-level accuracy analysis"
    - name: "count_status"
      expr: count_status
      comment: "Current count status for program progress tracking"
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (ABC, random, directed, wall-to-wall)"
    - name: "count_method"
      expr: count_method
      comment: "Counting method used (blind, guided, RF-directed)"
    - name: "count_reason"
      expr: count_reason
      comment: "Reason for count initiation (scheduled, discrepancy, audit)"
    - name: "priority_level"
      expr: priority_level
      comment: "Count priority level"
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Scheduled month for count program trending"
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle counts performed"
    - name: "avg_accuracy_percentage"
      expr: AVG(CAST(accuracy_percentage AS DOUBLE))
      comment: "Average inventory accuracy percentage - primary inventory control KPI"
    - name: "total_variance_value_usd"
      expr: SUM(CAST(variance_value_usd AS DOUBLE))
      comment: "Total inventory variance value in USD - financial impact of inaccuracy"
    - name: "total_labor_hours_actual"
      expr: SUM(CAST(labor_hours_actual AS DOUBLE))
      comment: "Total actual labor hours spent on cycle counting - cost of inventory control"
    - name: "recount_required_count"
      expr: SUM(CASE WHEN recount_required = true THEN 1 ELSE 0 END)
      comment: "Count of cycles requiring recount - first-count accuracy indicator"
    - name: "adjustment_posted_count"
      expr: SUM(CASE WHEN adjustment_posted = true THEN 1 ELSE 0 END)
      comment: "Count of cycles with posted adjustments - inventory correction volume"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_outbound_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound order line metrics tracking fulfillment accuracy, OTIF performance, and line-level throughput for customer service excellence."
  source: "`transport_shipping_ecm`.`warehouse`.`outbound_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current line processing status for fulfillment pipeline visibility"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether line item is hazardous material"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity analysis"
    - name: "shipped_month"
      expr: DATE_TRUNC('month', shipped_timestamp)
      comment: "Month shipped for fulfillment trend analysis"
  measures:
    - name: "total_order_lines"
      expr: COUNT(1)
      comment: "Total outbound order lines - granular workload metric"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all lines"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped - fulfillment output metric"
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total units picked for outbound orders"
    - name: "total_short_ship_quantity"
      expr: SUM(CAST(short_ship_quantity AS DOUBLE))
      comment: "Total short-shipped units - service failure indicator"
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total line-level revenue amount"
    - name: "otif_line_count"
      expr: SUM(CASE WHEN otif_flag = true THEN 1 ELSE 0 END)
      comment: "Count of lines delivered on-time-in-full - OTIF numerator"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of outbound order lines in kilograms"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across order lines - value density indicator"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_putaway_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Putaway task metrics tracking dock-to-stock speed, putaway efficiency, and storage optimization for inbound throughput management."
  source: "`transport_shipping_ecm`.`warehouse`.`putaway_task`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility for site-level putaway analysis"
    - name: "task_status"
      expr: task_status
      comment: "Current putaway task status for backlog monitoring"
    - name: "task_type"
      expr: task_type
      comment: "Type of putaway task (directed, manual, cross-dock)"
    - name: "priority"
      expr: priority
      comment: "Task priority level for workload segmentation"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether putaway involves hazardous materials"
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone for cold chain putaway tracking"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date task was created for daily throughput trending"
  measures:
    - name: "total_putaway_tasks"
      expr: COUNT(1)
      comment: "Total putaway tasks - inbound workload volume"
    - name: "total_putaway_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units put away across all tasks"
    - name: "total_travel_distance_meters"
      expr: SUM(CAST(travel_distance_meters AS DOUBLE))
      comment: "Total travel distance for putaway - layout efficiency metric"
    - name: "total_putaway_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight put away in kilograms"
    - name: "total_putaway_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume put away in cubic meters"
    - name: "avg_travel_distance_meters"
      expr: AVG(CAST(travel_distance_meters AS DOUBLE))
      comment: "Average travel distance per putaway task - slotting effectiveness indicator"
    - name: "distinct_employee_count"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees performing putaway - labor allocation metric"
    - name: "exception_task_count"
      expr: SUM(CASE WHEN exception_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of putaway tasks with exceptions - process quality indicator"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_returns_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Returns receipt metrics tracking reverse logistics volume, return reasons, and disposition efficiency for customer experience and cost management."
  source: "`transport_shipping_ecm`.`warehouse`.`returns_receipt`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility processing returns"
    - name: "return_status"
      expr: return_status
      comment: "Current return processing status"
    - name: "return_type"
      expr: return_type
      comment: "Type of return (customer, damaged, recall, etc.)"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for return - root cause analysis dimension"
    - name: "disposition_action"
      expr: disposition_action
      comment: "Disposition decision (restock, refurbish, destroy, donate)"
    - name: "condition_assessment"
      expr: condition_assessment
      comment: "Condition assessment of returned goods"
    - name: "received_month"
      expr: DATE_TRUNC('month', received_timestamp)
      comment: "Month return was received for trend analysis"
  measures:
    - name: "total_returns"
      expr: COUNT(1)
      comment: "Total return receipts processed - reverse logistics volume"
    - name: "total_declared_value"
      expr: SUM(CAST(total_declared_value_amount AS DOUBLE))
      comment: "Total declared value of returned goods - financial exposure metric"
    - name: "refund_eligible_count"
      expr: SUM(CASE WHEN refund_eligible_flag = true THEN 1 ELSE 0 END)
      comment: "Count of returns eligible for refund - financial liability indicator"
    - name: "claim_initiated_count"
      expr: SUM(CASE WHEN claim_initiated_flag = true THEN 1 ELSE 0 END)
      comment: "Count of returns with claims initiated - carrier/supplier recovery tracking"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers returning goods - customer satisfaction signal"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_inventory_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement metrics tracking stock flow velocity, movement types, and warehouse throughput for operational efficiency and inventory accuracy."
  source: "`transport_shipping_ecm`.`warehouse`.`inventory_movement`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility where movement occurs"
    - name: "movement_type"
      expr: movement_type
      comment: "Type of inventory movement (receipt, issue, transfer, adjustment, etc.)"
    - name: "movement_status"
      expr: movement_status
      comment: "Current movement status"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory status after movement"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether movement involves hazardous materials"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for movement - root cause analysis for adjustments"
    - name: "movement_date"
      expr: DATE_TRUNC('day', movement_timestamp)
      comment: "Date of movement for daily throughput analysis"
  measures:
    - name: "total_movements"
      expr: COUNT(1)
      comment: "Total inventory movements - warehouse activity volume"
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity_moved AS DOUBLE))
      comment: "Total units moved across all movements"
    - name: "total_movement_value"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total value of inventory moved - financial flow metric"
    - name: "total_weight_moved_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight moved in kilograms - physical throughput metric"
    - name: "total_volume_moved_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume moved in cubic meters"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_flag = true THEN 1 ELSE 0 END)
      comment: "Count of reversed movements - error correction indicator"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs moved - product velocity breadth"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`warehouse_pick_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pick wave metrics tracking wave planning effectiveness, fulfillment throughput, and labor utilization for outbound operations management."
  source: "`transport_shipping_ecm`.`warehouse`.`pick_wave`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Warehouse facility for site-level wave analysis"
    - name: "wave_status"
      expr: wave_status
      comment: "Current wave status for pipeline monitoring"
    - name: "wave_type"
      expr: wave_type
      comment: "Type of wave (carrier cutoff, priority, zone-based)"
    - name: "priority_level"
      expr: priority_level
      comment: "Wave priority level for workload segmentation"
    - name: "carrier_service_type"
      expr: carrier_service_type
      comment: "Carrier service type driving wave cutoff"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether wave contains hazmat orders"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date wave was created for daily planning analysis"
  measures:
    - name: "total_waves"
      expr: COUNT(1)
      comment: "Total pick waves created - planning activity volume"
    - name: "total_wave_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight across all waves in kilograms"
    - name: "total_wave_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume across all waves in cubic meters"
    - name: "total_labor_hours_actual"
      expr: SUM(CAST(labor_hours_actual AS DOUBLE))
      comment: "Total actual labor hours consumed by waves"
    - name: "total_labor_hours_planned"
      expr: SUM(CAST(labor_hours_planned AS DOUBLE))
      comment: "Total planned labor hours for waves - planning accuracy benchmark"
    - name: "avg_pick_accuracy_percentage"
      expr: AVG(CAST(pick_accuracy_percentage AS DOUBLE))
      comment: "Average pick accuracy percentage across waves - quality KPI"
$$;
