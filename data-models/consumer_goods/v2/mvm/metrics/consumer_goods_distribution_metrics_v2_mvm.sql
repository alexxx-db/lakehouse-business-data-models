-- Metric views for domain: distribution | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-27 07:41:37

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_outbound_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for outbound order fulfillment performance, covering order volume, value, fill rates, OTIF compliance, and on-time delivery. Used by Supply Chain VPs and Distribution Directors to steer fulfillment operations."
  source: "`vibe_consumer_goods_v1`.`distribution`.`outbound_order`"
  dimensions:
    - name: "order_status"
      expr: outbound_order_status
      comment: "Current lifecycle status of the outbound order (e.g. Open, Shipped, Cancelled) for segmenting fulfillment performance."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the outbound order type (e.g. Standard, Rush, DSD) to differentiate fulfillment patterns."
    - name: "order_date"
      expr: DATE_TRUNC('day', order_date)
      comment: "Day-level bucketing of the order placement date for trend analysis."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month-level bucketing of the order placement date for period-over-period reporting."
    - name: "requested_ship_date_month"
      expr: DATE_TRUNC('month', requested_ship_date)
      comment: "Month-level bucketing of the customer-requested ship date for on-time shipping analysis."
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Month-level bucketing of actual delivery date for delivery performance trending."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used (e.g. Ground, Air, LTL) to analyze cost and speed trade-offs."
    - name: "service_level"
      expr: service_level
      comment: "Contracted service level (e.g. Next Day, 2-Day, Standard) for SLA compliance segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order value for multi-currency financial reporting."
    - name: "priority"
      expr: priority
      comment: "Order priority classification (e.g. High, Medium, Low) to assess prioritization effectiveness."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates whether the order is in backorder status, enabling backorder rate analysis."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the order requires temperature-controlled handling, relevant for cold-chain compliance."
    - name: "incoterm"
      expr: incoterm
      comment: "Trade term governing delivery responsibility (e.g. DDP, EXW) for logistics cost allocation."
  measures:
    - name: "total_outbound_orders"
      expr: COUNT(1)
      comment: "Total number of outbound orders. Baseline volume KPI used to track fulfillment throughput."
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Sum of total order value across all outbound orders. Core revenue-linked distribution KPI for financial steering."
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average value per outbound order. Tracks order size trends and customer buying behavior shifts."
    - name: "total_order_quantity"
      expr: SUM(CAST(total_order_quantity AS DOUBLE))
      comment: "Total units ordered across all outbound orders. Measures distribution volume throughput."
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_order_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms. Used for freight cost benchmarking and carrier capacity planning."
    - name: "total_order_volume_m3"
      expr: SUM(CAST(total_order_volume_m3 AS DOUBLE))
      comment: "Total cubic volume of outbound orders in cubic meters. Drives truck utilization and warehouse space planning."
    - name: "avg_fill_rate_percentage"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average fill rate percentage across outbound orders. A critical service level KPI — low fill rate signals supply shortfalls or picking failures."
    - name: "otif_committed_orders"
      expr: COUNT(CASE WHEN otif_commitment_flag = TRUE THEN 1 END)
      comment: "Count of orders with an OTIF (On-Time In-Full) commitment. Numerator component for OTIF commitment rate."
    - name: "backorder_orders"
      expr: COUNT(CASE WHEN backorder_flag = TRUE THEN 1 END)
      comment: "Count of orders currently in backorder status. High backorder volume signals supply chain disruption or demand spikes."
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN outbound_order_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled outbound orders. Elevated cancellation rates indicate fulfillment failures or customer dissatisfaction."
    - name: "on_time_delivered_orders"
      expr: COUNT(CASE WHEN actual_delivery_date <= promised_delivery_date THEN 1 END)
      comment: "Count of orders delivered on or before the promised delivery date. Numerator for on-time delivery rate — a key customer service KPI."
    - name: "late_delivered_orders"
      expr: COUNT(CASE WHEN actual_delivery_date > promised_delivery_date THEN 1 END)
      comment: "Count of orders delivered after the promised delivery date. Directly impacts customer satisfaction and SLA penalties."
    - name: "avg_order_weight_kg"
      expr: AVG(CAST(total_order_weight_kg AS DOUBLE))
      comment: "Average weight per outbound order in kilograms. Used to benchmark carrier rate negotiations and route optimization."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_outbound_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level fulfillment KPIs for outbound orders, covering pick accuracy, short-ship rates, shipped vs ordered quantities, and line-level volume/weight. Used by warehouse operations managers and supply chain analysts."
  source: "`vibe_consumer_goods_v1`.`distribution`.`outbound_order_line`"
  dimensions:
    - name: "line_status"
      expr: outbound_order_line_status
      comment: "Current status of the outbound order line (e.g. Picked, Shipped, Short-Shipped) for fulfillment pipeline visibility."
    - name: "otif_status"
      expr: otif_status
      comment: "OTIF compliance status at the line level — critical for measuring on-time in-full performance per SKU."
    - name: "short_ship_flag"
      expr: short_ship_flag
      comment: "Indicates whether the line was short-shipped, enabling short-ship rate analysis by SKU or order."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates Direct Store Delivery lines, enabling DSD vs warehouse fulfillment performance comparison."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates temperature-controlled lines for cold-chain compliance monitoring."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates hazardous material lines requiring special handling compliance."
    - name: "requested_ship_date_month"
      expr: DATE_TRUNC('month', requested_ship_date)
      comment: "Month-level bucketing of the requested ship date for trend analysis."
    - name: "actual_ship_date_month"
      expr: DATE_TRUNC('month', actual_ship_date)
      comment: "Month-level bucketing of actual ship date for on-time shipping performance trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line amount for multi-currency financial reporting."
    - name: "short_ship_reason_code"
      expr: short_ship_reason_code
      comment: "Reason code for short-ship events, enabling root-cause analysis of fulfillment failures."
    - name: "pick_zone"
      expr: pick_zone
      comment: "Warehouse pick zone for the line, enabling zone-level productivity and accuracy analysis."
  measures:
    - name: "total_order_lines"
      expr: COUNT(1)
      comment: "Total number of outbound order lines. Baseline throughput measure for warehouse operations."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all lines. Measures demand volume flowing through the distribution network."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units actually shipped. Compared against ordered quantity to compute fill rate and identify shortfalls."
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total units picked from warehouse locations. Measures warehouse picking throughput."
    - name: "total_packed_quantity"
      expr: SUM(CAST(packed_quantity AS DOUBLE))
      comment: "Total units packed for shipment. Tracks packing station throughput and identifies pack-to-ship gaps."
    - name: "total_line_value"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of all outbound order lines. Revenue-linked KPI for distribution financial performance."
    - name: "total_line_weight_kg"
      expr: SUM(CAST(line_weight_kg AS DOUBLE))
      comment: "Total weight of all outbound order lines in kilograms. Used for freight cost allocation and carrier capacity planning."
    - name: "total_line_volume_m3"
      expr: SUM(CAST(line_volume_m3 AS DOUBLE))
      comment: "Total cubic volume of all outbound order lines. Drives truck load planning and warehouse space utilization."
    - name: "short_shipped_lines"
      expr: COUNT(CASE WHEN short_ship_flag = TRUE THEN 1 END)
      comment: "Count of lines that were short-shipped. High short-ship counts signal inventory availability or picking failures."
    - name: "quantity_variance"
      expr: SUM((CAST(shipped_quantity AS DOUBLE)) - (CAST(ordered_quantity AS DOUBLE)))
      comment: "Net difference between shipped and ordered quantities. Negative values indicate unfulfilled demand; used to quantify fill rate gaps."
    - name: "avg_unit_volume_m3"
      expr: AVG(CAST(unit_volume_m3 AS DOUBLE))
      comment: "Average cubic volume per unit across order lines. Used for packaging optimization and load planning benchmarks."
    - name: "avg_unit_weight_kg"
      expr: AVG(CAST(unit_weight_kg AS DOUBLE))
      comment: "Average weight per unit across order lines. Supports freight rate benchmarking and carrier selection decisions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment-level KPIs covering freight cost, delivery performance, shipment volume, and weight. Used by logistics managers and supply chain executives to optimize carrier performance and freight spend."
  source: "`vibe_consumer_goods_v1`.`distribution`.`distribution_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: distribution_shipment_status
      comment: "Current status of the shipment (e.g. In Transit, Delivered, Delayed) for pipeline visibility."
    - name: "ship_date_month"
      expr: DATE_TRUNC('month', ship_date)
      comment: "Month-level bucketing of ship date for freight volume and cost trending."
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Month-level bucketing of actual delivery date for on-time delivery performance analysis."
    - name: "expected_delivery_month"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Month-level bucketing of expected delivery date for SLA compliance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of freight cost for multi-currency financial reporting."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments dispatched. Baseline throughput KPI for distribution network capacity utilization."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all shipments. A primary cost KPI for logistics budget management and carrier negotiation."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment. Benchmarks carrier efficiency and identifies cost outliers."
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight shipped in kilograms across all shipments. Used for freight rate benchmarking and carrier capacity planning."
    - name: "avg_shipment_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average shipment weight in kilograms. Supports load optimization and carrier rate tier analysis."
    - name: "total_shipment_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units shipped across all shipments. Measures distribution throughput volume."
    - name: "on_time_deliveries"
      expr: COUNT(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 END)
      comment: "Count of shipments delivered on or before the expected delivery date. Numerator for on-time delivery rate — a key carrier SLA KPI."
    - name: "late_deliveries"
      expr: COUNT(CASE WHEN actual_delivery_date > expected_delivery_date THEN 1 END)
      comment: "Count of shipments delivered after the expected delivery date. Directly impacts customer satisfaction and OTIF compliance."
    - name: "avg_freight_cost_per_kg"
      expr: SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_weight_kg AS DOUBLE)), 0)
      comment: "Freight cost per kilogram shipped. A normalized efficiency KPI for comparing carrier rates and route economics."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_inbound_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving KPIs covering receipt accuracy, OTIF compliance, discrepancy rates, quality inspection outcomes, and receiving throughput. Used by warehouse managers and procurement teams to govern supplier delivery performance."
  source: "`vibe_consumer_goods_v1`.`distribution`.`inbound_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: inbound_receipt_status
      comment: "Current status of the inbound receipt (e.g. Pending, Completed, Discrepancy) for receiving pipeline visibility."
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of inbound receipt (e.g. Purchase Order, Transfer, Return) for categorizing inbound flows."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month-level bucketing of receipt date for inbound volume and quality trending."
    - name: "scheduled_receipt_date_month"
      expr: DATE_TRUNC('month', scheduled_receipt_date)
      comment: "Month-level bucketing of scheduled receipt date for on-time receiving analysis."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates whether a discrepancy was recorded on receipt, enabling discrepancy rate analysis."
    - name: "otif_compliant_flag"
      expr: otif_compliant_flag
      comment: "Indicates whether the receipt was OTIF compliant — a key supplier performance KPI."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for the receipt (e.g. Passed, Failed, Pending) for quality governance."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Indicates whether the inbound shipment met temperature compliance requirements — critical for cold-chain integrity."
    - name: "seal_intact_flag"
      expr: seal_intact_flag
      comment: "Indicates whether the trailer seal was intact on arrival, a security and compliance dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receipt amount for multi-currency financial reporting."
    - name: "discrepancy_reason"
      expr: discrepancy_reason
      comment: "Root cause category for receipt discrepancies, enabling targeted supplier corrective actions."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of inbound receipts processed. Baseline receiving throughput KPI."
    - name: "total_expected_quantity"
      expr: SUM(CAST(expected_quantity AS DOUBLE))
      comment: "Total quantity expected across all inbound receipts. Baseline for measuring receipt accuracy and supplier compliance."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received. Compared against expected quantity to compute receipt accuracy rate."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted after inspection. Measures usable inbound supply after quality screening."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected on receipt. High rejection volumes signal supplier quality failures and drive corrective action."
    - name: "receipts_with_discrepancy"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of receipts with recorded discrepancies. Numerator for discrepancy rate — a key supplier performance KPI."
    - name: "otif_compliant_receipts"
      expr: COUNT(CASE WHEN otif_compliant_flag = TRUE THEN 1 END)
      comment: "Count of receipts that were OTIF compliant. Numerator for supplier OTIF rate — a primary procurement governance KPI."
    - name: "temperature_non_compliant_receipts"
      expr: COUNT(CASE WHEN temperature_compliant_flag = FALSE THEN 1 END)
      comment: "Count of receipts that failed temperature compliance. Critical for cold-chain risk management and regulatory compliance."
    - name: "total_receipt_value"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of inbound receipts. Used for inventory valuation and procurement spend analysis."
    - name: "avg_temperature_reading_celsius"
      expr: AVG(CAST(temperature_reading_celsius AS DOUBLE))
      comment: "Average temperature reading at receipt in Celsius. Monitors cold-chain integrity across inbound shipments."
    - name: "quantity_variance"
      expr: SUM((CAST(received_quantity AS DOUBLE)) - (CAST(expected_quantity AS DOUBLE)))
      comment: "Net difference between received and expected quantities. Negative values indicate supplier under-delivery; positive values indicate over-delivery."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_inbound_receipt_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level inbound receipt KPIs covering quantity accuracy, damage rates, quality holds, and cost variance. Used by warehouse operations and quality teams to govern SKU-level receiving performance."
  source: "`vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line`"
  dimensions:
    - name: "line_status"
      expr: inbound_receipt_line_status
      comment: "Current status of the receipt line (e.g. Received, Rejected, On Hold) for line-level receiving pipeline visibility."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome at the line level for SKU-level quality governance."
    - name: "putaway_status"
      expr: putaway_status
      comment: "Putaway status of the receipt line (e.g. Pending, Completed) for warehouse slotting and space utilization analysis."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Indicates whether the line is on quality hold, enabling quality hold rate analysis by SKU or supplier."
    - name: "condition_code"
      expr: condition_code
      comment: "Physical condition of received goods (e.g. Good, Damaged, Expired) for quality and claims analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month-level bucketing of expiration date for near-expiry inventory risk monitoring."
    - name: "manufacture_date_month"
      expr: DATE_TRUNC('month', manufacture_date)
      comment: "Month-level bucketing of manufacture date for shelf-life and freshness analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line amount for multi-currency financial reporting."
  measures:
    - name: "total_receipt_lines"
      expr: COUNT(1)
      comment: "Total number of inbound receipt lines processed. Baseline receiving throughput measure."
    - name: "total_expected_quantity"
      expr: SUM(CAST(expected_quantity AS DOUBLE))
      comment: "Total expected quantity across all receipt lines. Baseline for measuring line-level receipt accuracy."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received at the line level. Core measure for receipt accuracy and supplier compliance."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at the line level. Drives supplier quality scorecards and corrective action programs."
    - name: "total_damaged_quantity"
      expr: SUM(CAST(damaged_quantity AS DOUBLE))
      comment: "Total quantity received in damaged condition. High damage rates trigger carrier or supplier claims and corrective actions."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost of received lines. Used for inventory valuation and procurement cost analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across received lines. Benchmarks procurement pricing and identifies cost anomalies."
    - name: "lines_on_quality_hold"
      expr: COUNT(CASE WHEN quality_hold_flag = TRUE THEN 1 END)
      comment: "Count of receipt lines placed on quality hold. Elevated counts signal systemic quality issues requiring supplier intervention."
    - name: "quantity_variance_cases"
      expr: SUM(CAST(variance_quantity_cases AS DOUBLE))
      comment: "Net case-level quantity variance between expected and received. Measures supplier delivery accuracy at the case level."
    - name: "quantity_variance_eaches"
      expr: SUM(CAST(variance_quantity_eaches AS DOUBLE))
      comment: "Net each-level quantity variance between expected and received. Measures supplier delivery accuracy at the unit level."
    - name: "total_received_quantity_cases"
      expr: SUM(CAST(received_quantity_cases AS DOUBLE))
      comment: "Total cases received across all receipt lines. Used for pallet and storage capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_inventory_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and availability KPIs covering on-hand stock, allocation rates, inventory value, expiry risk, and stock status. Used by supply chain planners and distribution executives to manage inventory investment and service levels."
  source: "`vibe_consumer_goods_v1`.`distribution`.`inventory_position`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (e.g. Available, Allocated, On Hold) for stock availability segmentation."
    - name: "stock_status"
      expr: stock_status
      comment: "Stock quality or usability status (e.g. Unrestricted, Blocked, Quality Inspection) for inventory health monitoring."
    - name: "inventory_condition"
      expr: inventory_condition
      comment: "Physical condition of inventory (e.g. Good, Damaged, Near Expiry) for quality-driven inventory decisions."
    - name: "storage_zone"
      expr: storage_zone
      comment: "Warehouse storage zone where inventory is located, enabling zone-level capacity and utilization analysis."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the storage location (e.g. Ambient, Chilled, Frozen) for cold-chain inventory management."
    - name: "snapshot_month"
      expr: DATE_TRUNC('month', snapshot_timestamp)
      comment: "Month-level bucketing of the inventory snapshot timestamp for period-over-period inventory trend analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month-level bucketing of expiration date for near-expiry inventory risk monitoring and write-off prevention."
    - name: "last_movement_type"
      expr: last_movement_type
      comment: "Type of last inventory movement (e.g. Receipt, Pick, Transfer) for inventory activity analysis."
    - name: "owner_type"
      expr: owner_type
      comment: "Ownership type of inventory (e.g. Own, Consignment, 3PL) for inventory liability and cost allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of inventory value for multi-currency financial reporting."
    - name: "replenishment_flag"
      expr: replenishment_flag
      comment: "Indicates whether the inventory position has triggered a replenishment signal, enabling replenishment rate analysis."
  measures:
    - name: "total_inventory_positions"
      expr: COUNT(1)
      comment: "Total number of active inventory positions. Baseline measure for inventory breadth across the distribution network."
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand inventory quantity. Primary stock availability KPI used for service level and replenishment decisions."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for order fulfillment (on-hand minus allocated/held). Directly drives order fill rate capability."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to open orders. High allocation rates relative to on-hand signal tight supply conditions."
    - name: "total_on_hold_quantity"
      expr: SUM(CAST(on_hold_quantity AS DOUBLE))
      comment: "Total quantity on quality or operational hold. Elevated hold quantities reduce effective availability and service levels."
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit between facilities. Used for supply pipeline visibility and replenishment planning."
    - name: "total_inventory_value"
      expr: SUM(CAST(total_inventory_value AS DOUBLE))
      comment: "Total monetary value of inventory on hand. A primary balance sheet KPI for working capital management."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per inventory unit. Used for inventory valuation benchmarking and margin analysis."
    - name: "total_damaged_quantity"
      expr: SUM(CAST(quantity_damaged AS DOUBLE))
      comment: "Total quantity in damaged condition. Drives write-off decisions and supplier/carrier claims."
    - name: "total_quarantine_quantity"
      expr: SUM(CAST(quantity_quarantine AS DOUBLE))
      comment: "Total quantity in quarantine status. Elevated quarantine levels signal quality issues requiring urgent resolution."
    - name: "allocation_rate"
      expr: SUM(CAST(allocated_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0)
      comment: "Ratio of allocated to on-hand quantity. Values approaching 1.0 indicate tight supply and elevated stockout risk."
    - name: "availability_rate"
      expr: SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0)
      comment: "Ratio of available to on-hand quantity. Measures the proportion of stock that is unencumbered and ready for fulfillment."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_pick_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse picking productivity and accuracy KPIs covering pick task throughput, accuracy rates, OTIF eligibility, and weight/dimension metrics. Used by warehouse operations managers to optimize labor productivity and fulfillment accuracy."
  source: "`vibe_consumer_goods_v1`.`distribution`.`pick_task`"
  dimensions:
    - name: "pick_task_status"
      expr: pick_task_status
      comment: "Current status of the pick task (e.g. Assigned, In Progress, Completed, Exception) for picking pipeline visibility."
    - name: "task_type"
      expr: task_type
      comment: "Type of pick task (e.g. Single Order, Batch, Zone) for productivity analysis by picking strategy."
    - name: "pick_method"
      expr: pick_method
      comment: "Picking method used (e.g. RF, Voice, Paper) for technology-driven productivity benchmarking."
    - name: "picking_strategy"
      expr: picking_strategy
      comment: "Picking strategy applied (e.g. FIFO, FEFO, Directed) for inventory rotation compliance analysis."
    - name: "pick_accuracy_flag"
      expr: pick_accuracy_flag
      comment: "Indicates whether the pick task was completed accurately. Enables pick accuracy rate calculation — a key warehouse quality KPI."
    - name: "otif_eligible_flag"
      expr: otif_eligible_flag
      comment: "Indicates whether the pick task is eligible for OTIF measurement, enabling OTIF-eligible pick accuracy analysis."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates Direct Store Delivery pick tasks for DSD vs warehouse fulfillment productivity comparison."
    - name: "priority"
      expr: priority
      comment: "Priority level of the pick task (e.g. High, Normal, Low) for prioritization effectiveness analysis."
    - name: "completed_date"
      expr: DATE_TRUNC('day', completed_timestamp)
      comment: "Day-level bucketing of task completion timestamp for daily picking productivity trending."
    - name: "completed_month"
      expr: DATE_TRUNC('month', completed_timestamp)
      comment: "Month-level bucketing of task completion timestamp for period-over-period productivity analysis."
  measures:
    - name: "total_pick_tasks"
      expr: COUNT(1)
      comment: "Total number of pick tasks executed. Baseline warehouse throughput KPI for labor planning and capacity management."
    - name: "total_pick_quantity"
      expr: SUM(CAST(pick_quantity AS DOUBLE))
      comment: "Total units assigned for picking across all tasks. Measures picking demand volume."
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS DOUBLE))
      comment: "Total units actually picked. Compared against pick quantity to measure picking completion rate."
    - name: "accurate_pick_tasks"
      expr: COUNT(CASE WHEN pick_accuracy_flag = TRUE THEN 1 END)
      comment: "Count of pick tasks completed with full accuracy. Numerator for pick accuracy rate — a primary warehouse quality KPI."
    - name: "otif_eligible_tasks"
      expr: COUNT(CASE WHEN otif_eligible_flag = TRUE THEN 1 END)
      comment: "Count of pick tasks eligible for OTIF measurement. Used to scope OTIF performance calculations."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of all pick tasks in kilograms. Used for labor ergonomics planning and equipment utilization."
    - name: "total_net_weight_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net weight of all pick tasks in kilograms. Used for freight cost estimation and load planning."
    - name: "pick_completion_rate"
      expr: SUM(CAST(picked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(pick_quantity AS DOUBLE)), 0)
      comment: "Ratio of picked to assigned pick quantity. Values below 1.0 indicate incomplete picks, signaling inventory shortfalls or task failures."
    - name: "avg_pick_quantity_per_task"
      expr: AVG(CAST(pick_quantity AS DOUBLE))
      comment: "Average units per pick task. Used to benchmark task sizing and optimize batch picking strategies."
    - name: "exception_tasks"
      expr: COUNT(CASE WHEN exception_code IS NOT NULL THEN 1 END)
      comment: "Count of pick tasks with recorded exceptions. High exception rates signal systemic warehouse process failures requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution facility capacity, capability, and operational status KPIs. Used by network design and operations executives to evaluate facility utilization, capability coverage, and network footprint decisions."
  source: "`vibe_consumer_goods_v1`.`distribution`.`distribution_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of distribution facility (e.g. DC, Cross-Dock, Hub) for network segmentation and capability analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility (e.g. Active, Closed, Under Construction) for network footprint management."
    - name: "distribution_facility_status"
      expr: distribution_facility_status
      comment: "Lifecycle status of the distribution facility for governance and planning purposes."
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located for geographic network analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the facility for regional distribution network analysis."
    - name: "city"
      expr: city
      comment: "City of the facility for granular geographic network planning."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the facility has temperature-controlled storage capability — critical for cold-chain network design."
    - name: "cross_dock_enabled_flag"
      expr: cross_dock_enabled_flag
      comment: "Indicates whether the facility supports cross-docking operations for flow-through distribution analysis."
    - name: "dsd_hub_flag"
      expr: dsd_hub_flag
      comment: "Indicates whether the facility serves as a Direct Store Delivery hub for DSD network coverage analysis."
    - name: "gmp_certified_flag"
      expr: gmp_certified_flag
      comment: "Indicates GMP certification status — required for regulated product distribution compliance."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Indicates hazardous materials handling certification for regulatory compliance and network capability mapping."
    - name: "inventory_rotation_method"
      expr: inventory_rotation_method
      comment: "Default inventory rotation method at the facility (e.g. FIFO, FEFO) for freshness and compliance analysis."
    - name: "opened_date_year"
      expr: DATE_TRUNC('year', opened_date)
      comment: "Year-level bucketing of facility opening date for network age and investment cycle analysis."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of distribution facilities in the network. Baseline KPI for network footprint and coverage decisions."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage across all distribution facilities. Measures total network storage capacity for investment planning."
    - name: "total_capacity_sqft"
      expr: SUM(CAST(total_capacity_sqft AS DOUBLE))
      comment: "Total rated capacity in square feet across all facilities. Used for network utilization rate calculations."
    - name: "avg_otif_target_percentage"
      expr: AVG(CAST(otif_target_percentage AS DOUBLE))
      comment: "Average OTIF target percentage across facilities. Benchmarks the ambition level of service commitments across the network."
    - name: "active_facilities"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Count of currently active distribution facilities. Used for network capacity planning and footprint optimization."
    - name: "temperature_controlled_facilities"
      expr: COUNT(CASE WHEN temperature_controlled_flag = TRUE THEN 1 END)
      comment: "Count of facilities with temperature-controlled capability. Measures cold-chain network coverage for regulated and perishable products."
    - name: "cross_dock_enabled_facilities"
      expr: COUNT(CASE WHEN cross_dock_enabled_flag = TRUE THEN 1 END)
      comment: "Count of facilities with cross-docking capability. Measures flow-through distribution capacity for velocity-sensitive products."
    - name: "gmp_certified_facilities"
      expr: COUNT(CASE WHEN gmp_certified_flag = TRUE THEN 1 END)
      comment: "Count of GMP-certified facilities. Measures regulated distribution network coverage for compliance-sensitive product lines."
    - name: "avg_square_footage_per_facility"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per distribution facility. Benchmarks facility size for network standardization and investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`distribution_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage location capacity, utilization, and compliance KPIs. Used by warehouse managers to optimize slotting, manage blocked locations, and ensure storage compliance across the distribution network."
  source: "`vibe_consumer_goods_v1`.`distribution`.`storage_location`"
  dimensions:
    - name: "location_status"
      expr: distribution_storage_location_status
      comment: "Current status of the storage location (e.g. Active, Blocked, Inactive) for location availability analysis."
    - name: "location_type"
      expr: location_type
      comment: "Type of storage location (e.g. Bulk, Pick Face, Reserve) for slotting strategy and capacity planning."
    - name: "storage_class"
      expr: storage_class
      comment: "Storage class of the location (e.g. Ambient, Chilled, Hazmat) for compliance and capability mapping."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the storage location for cold-chain capacity analysis."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC velocity classification of the storage location for slotting optimization and pick path efficiency."
    - name: "zone_code"
      expr: zone_code
      comment: "Warehouse zone code for zone-level capacity and utilization analysis."
    - name: "is_blocked"
      expr: is_blocked
      comment: "Indicates whether the storage location is currently blocked, enabling blocked location rate analysis."
    - name: "is_pickable"
      expr: is_pickable
      comment: "Indicates whether the location is available for picking, measuring effective pick face availability."
    - name: "fefo_eligible_flag"
      expr: fefo_eligible_flag
      comment: "Indicates FEFO (First Expired First Out) eligibility for expiry-sensitive product slotting compliance."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Indicates hazardous materials certification for regulatory compliance and capability mapping."
    - name: "cycle_count_frequency"
      expr: cycle_count_frequency
      comment: "Frequency of cycle counting for this location (e.g. Daily, Weekly, Monthly) for inventory accuracy governance."
  measures:
    - name: "total_storage_locations"
      expr: COUNT(1)
      comment: "Total number of storage locations in the warehouse network. Baseline capacity KPI for slotting and space management."
    - name: "total_max_weight_capacity_kg"
      expr: SUM(CAST(max_weight_kg AS DOUBLE))
      comment: "Total maximum weight capacity across all storage locations in kilograms. Measures structural load capacity of the warehouse network."
    - name: "total_max_volume_capacity_m3"
      expr: SUM(CAST(max_volume_cubic_m AS DOUBLE))
      comment: "Total maximum cubic volume capacity across all storage locations. Measures volumetric storage capacity for network planning."
    - name: "blocked_locations"
      expr: COUNT(CASE WHEN is_blocked = TRUE THEN 1 END)
      comment: "Count of currently blocked storage locations. High blocked location counts reduce effective warehouse capacity and picking efficiency."
    - name: "pickable_locations"
      expr: COUNT(CASE WHEN is_pickable = TRUE THEN 1 END)
      comment: "Count of locations available for picking. Measures effective pick face capacity for order fulfillment."
    - name: "hazmat_certified_locations"
      expr: COUNT(CASE WHEN hazmat_certified_flag = TRUE THEN 1 END)
      comment: "Count of hazmat-certified storage locations. Measures regulated storage capacity for compliance-sensitive product lines."
    - name: "fefo_eligible_locations"
      expr: COUNT(CASE WHEN fefo_eligible_flag = TRUE THEN 1 END)
      comment: "Count of FEFO-eligible storage locations. Measures the network's capability to manage expiry-sensitive inventory rotation."
    - name: "avg_max_weight_capacity_kg"
      expr: AVG(CAST(max_weight_kg AS DOUBLE))
      comment: "Average maximum weight capacity per storage location. Used for load balancing and equipment selection decisions."
    - name: "avg_height_cm"
      expr: AVG(CAST(height_cm AS DOUBLE))
      comment: "Average height of storage locations in centimeters. Used for racking design, equipment selection, and vertical space utilization analysis."
$$;