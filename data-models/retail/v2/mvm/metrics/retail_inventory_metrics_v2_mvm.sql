-- Metric views for domain: inventory | Business: Retail | Version: 2 | Generated on: 2026-07-12 15:23:39

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory health and availability metrics by SKU and node, tracking on-hand, reserved, available-to-promise, and replenishment status for operational steering and allocation decisions."
  source: "`vibe_retail_v1`.`inventory`.`stock_position`"
  dimensions:
    - name: "inventory_node_id"
      expr: stock_inventory_node_id
      comment: "Inventory node (store, DC, warehouse) where stock is held"
    - name: "sku_id"
      expr: stock_sku_id
      comment: "Stock keeping unit identifier"
    - name: "vendor_id"
      expr: position_vendor_id
      comment: "Vendor supplying the SKU"
    - name: "position_status"
      expr: position_status
      comment: "Current status of the stock position (active, inactive, discontinued)"
    - name: "replenishment_status"
      expr: replenishment_status
      comment: "Replenishment state (normal, urgent, blocked, excess)"
    - name: "velocity_band"
      expr: velocity_band
      comment: "Sales velocity classification (fast, medium, slow mover)"
    - name: "is_dead_stock"
      expr: is_dead_stock
      comment: "Flag indicating no sales activity for extended period"
    - name: "is_vmi"
      expr: is_vmi
      comment: "Vendor-managed inventory flag"
    - name: "is_rfid_tracked"
      expr: is_rfid_tracked
      comment: "RFID tracking enabled for this position"
    - name: "inventory_valuation_method"
      expr: inventory_valuation_method
      comment: "Valuation method (FIFO, LIFO, weighted average)"
    - name: "position_date"
      expr: DATE(position_timestamp)
      comment: "Date of stock position snapshot"
    - name: "position_month"
      expr: DATE_TRUNC('MONTH', position_timestamp)
      comment: "Month of stock position snapshot"
  measures:
    - name: "total_on_hand_qty"
      expr: SUM(CAST(on_hand_qty AS DOUBLE))
      comment: "Total physical inventory on hand across all locations"
    - name: "total_available_to_promise_qty"
      expr: SUM(CAST(available_to_promise_qty AS DOUBLE))
      comment: "Total quantity available for customer promise (on-hand minus reserved)"
    - name: "total_reserved_qty"
      expr: SUM(CAST(reserved_qty AS DOUBLE))
      comment: "Total quantity reserved for orders or holds"
    - name: "total_in_transit_qty"
      expr: SUM(CAST(in_transit_qty AS DOUBLE))
      comment: "Total quantity in transit to this location"
    - name: "total_on_order_qty"
      expr: SUM(CAST(on_order_qty AS DOUBLE))
      comment: "Total quantity on purchase orders not yet received"
    - name: "total_damaged_qty"
      expr: SUM(CAST(damaged_qty AS DOUBLE))
      comment: "Total quantity damaged and unsellable"
    - name: "total_quarantine_qty"
      expr: SUM(CAST(quarantine_qty AS DOUBLE))
      comment: "Total quantity in quarantine pending inspection or release"
    - name: "total_shrinkage_qty"
      expr: SUM(CAST(shrinkage_qty AS DOUBLE))
      comment: "Total quantity lost to shrinkage (theft, damage, error)"
    - name: "total_inventory_value"
      expr: SUM(CAST(on_hand_qty AS DOUBLE) * CAST(unit_cost AS DOUBLE))
      comment: "Total inventory value at cost (on-hand quantity times unit cost)"
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply based on current on-hand and sales velocity"
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate (sales divided by receipts)"
    - name: "stock_availability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(available_to_promise_qty AS DOUBLE) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SKU-node positions with available-to-promise inventory"
    - name: "dead_stock_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_dead_stock = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of positions flagged as dead stock"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT stock_sku_id)
      comment: "Number of unique SKUs in stock positions"
    - name: "distinct_node_count"
      expr: COUNT(DISTINCT stock_inventory_node_id)
      comment: "Number of unique inventory nodes holding stock"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_stock_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement and transaction metrics tracking receipts, sales, adjustments, and transfers for audit, reconciliation, and flow analysis."
  source: "`vibe_retail_v1`.`inventory`.`stock_ledger`"
  dimensions:
    - name: "sku_id"
      expr: stock_sku_id
      comment: "Stock keeping unit identifier"
    - name: "inventory_node_id"
      expr: ledger_inventory_node_id
      comment: "Inventory node where transaction occurred"
    - name: "location_id"
      expr: stock_location_id
      comment: "Store or facility location"
    - name: "vendor_id"
      expr: stock_vendor_id
      comment: "Vendor associated with the stock movement"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of inventory transaction (receipt, sale, adjustment, transfer, return)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (posted, pending, reversed)"
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Reason code for the inventory movement"
    - name: "channel"
      expr: channel
      comment: "Sales or fulfillment channel (store, online, wholesale)"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates if this transaction reverses a prior transaction"
    - name: "shrinkage_flag"
      expr: shrinkage_flag
      comment: "Indicates if this movement is due to shrinkage"
    - name: "dead_stock_flag"
      expr: dead_stock_flag
      comment: "Indicates if this movement involves dead stock"
    - name: "rfid_tracked"
      expr: rfid_tracked
      comment: "RFID tracking enabled for this transaction"
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Direct store delivery flag"
    - name: "vmf_flag"
      expr: vmf_flag
      comment: "Vendor-managed fulfillment flag"
    - name: "transaction_date"
      expr: DATE(transaction_timestamp)
      comment: "Date of inventory transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of inventory transaction"
    - name: "posting_date"
      expr: posting_date
      comment: "Fiscal posting date of the transaction"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for financial reporting"
  measures:
    - name: "total_movement_qty"
      expr: SUM(CAST(movement_quantity AS DOUBLE))
      comment: "Total quantity moved (positive for receipts, negative for sales/adjustments)"
    - name: "total_receipts_qty"
      expr: SUM(CASE WHEN CAST(movement_quantity AS DOUBLE) > 0 THEN CAST(movement_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity received into inventory"
    - name: "total_issues_qty"
      expr: SUM(CASE WHEN CAST(movement_quantity AS DOUBLE) < 0 THEN ABS(CAST(movement_quantity AS DOUBLE)) ELSE 0 END)
      comment: "Total quantity issued out of inventory (sales, transfers, adjustments)"
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost of inventory movements (quantity times unit cost)"
    - name: "total_extended_retail_value"
      expr: SUM(CAST(extended_retail_value AS DOUBLE))
      comment: "Total extended retail value of inventory movements"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across transactions"
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average unit retail price across transactions"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of inventory transactions"
    - name: "shrinkage_transaction_count"
      expr: SUM(CASE WHEN shrinkage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of transactions flagged as shrinkage"
    - name: "reversal_transaction_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal transactions"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT stock_sku_id)
      comment: "Number of unique SKUs involved in transactions"
    - name: "distinct_node_count"
      expr: COUNT(DISTINCT ledger_inventory_node_id)
      comment: "Number of unique inventory nodes with transactions"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy and variance metrics for inventory audit, shrinkage detection, and process improvement."
  source: "`vibe_retail_v1`.`inventory`.`cycle_count`"
  dimensions:
    - name: "sku_id"
      expr: cycle_sku_id
      comment: "Stock keeping unit being counted"
    - name: "inventory_node_id"
      expr: cycle_inventory_node_id
      comment: "Inventory node where count was performed"
    - name: "location_id"
      expr: cycle_location_id
      comment: "Store or facility location"
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (full, partial, ABC, spot)"
    - name: "count_status"
      expr: count_status
      comment: "Status of the count (scheduled, in-progress, completed, cancelled)"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU (A=high value, B=medium, C=low)"
    - name: "count_frequency"
      expr: count_frequency
      comment: "Frequency of cycle counts for this SKU (daily, weekly, monthly, quarterly)"
    - name: "trigger_reason"
      expr: trigger_reason
      comment: "Reason the count was triggered (scheduled, variance, audit, shrinkage)"
    - name: "recount_required"
      expr: recount_required
      comment: "Flag indicating if a recount is required due to variance"
    - name: "adjustment_generated"
      expr: adjustment_generated
      comment: "Flag indicating if an inventory adjustment was generated from this count"
    - name: "shrinkage_category"
      expr: shrinkage_category
      comment: "Category of shrinkage detected (theft, damage, administrative error)"
    - name: "count_date"
      expr: DATE(count_start_timestamp)
      comment: "Date the cycle count was started"
    - name: "count_month"
      expr: DATE_TRUNC('MONTH', count_start_timestamp)
      comment: "Month of the cycle count"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for financial reporting"
  measures:
    - name: "total_counted_qty"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total quantity counted during cycle counts"
    - name: "total_system_qty"
      expr: SUM(CAST(system_quantity AS DOUBLE))
      comment: "Total system quantity expected during cycle counts"
    - name: "total_variance_qty"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance quantity (counted minus system)"
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total cost impact of inventory variances"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across cycle counts"
    - name: "count_accuracy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ABS(CAST(variance_quantity AS DOUBLE)) <= CAST(system_quantity AS DOUBLE) * CAST(variance_tolerance_pct AS DOUBLE) / 100.0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts within tolerance (variance within acceptable threshold)"
    - name: "recount_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recount_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring recount due to variance"
    - name: "adjustment_generation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN adjustment_generated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts that generated inventory adjustments"
    - name: "cycle_count_total"
      expr: COUNT(1)
      comment: "Total number of cycle counts performed"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT cycle_sku_id)
      comment: "Number of unique SKUs cycle counted"
    - name: "distinct_node_count"
      expr: COUNT(DISTINCT cycle_inventory_node_id)
      comment: "Number of unique inventory nodes with cycle counts"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving performance and quality metrics tracking receipt accuracy, timeliness, and discrepancies for supplier performance and receiving operations."
  source: "`vibe_retail_v1`.`inventory`.`goods_receipt`"
  dimensions:
    - name: "sku_id"
      expr: goods_sku_id
      comment: "Stock keeping unit received"
    - name: "vendor_id"
      expr: goods_vendor_id
      comment: "Vendor supplying the goods"
    - name: "inventory_node_id"
      expr: goods_inventory_node_id
      comment: "Inventory node receiving the goods"
    - name: "location_id"
      expr: location_id
      comment: "Store or facility location"
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (pending, received, inspected, posted)"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection result (passed, failed, pending)"
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of discrepancy (shortage, overage, damage, quality)"
    - name: "discrepancy_resolution_status"
      expr: discrepancy_resolution_status
      comment: "Status of discrepancy resolution (open, resolved, escalated)"
    - name: "receipt_method"
      expr: receipt_method
      comment: "Method of receipt (manual, RFID, barcode scan)"
    - name: "receiving_node_type"
      expr: receiving_node_type
      comment: "Type of receiving node (DC, store, cross-dock)"
    - name: "rfid_verified"
      expr: rfid_verified
      comment: "RFID verification completed flag"
    - name: "rtv_initiated"
      expr: rtv_initiated
      comment: "Return-to-vendor initiated flag"
    - name: "chargeback_eligible"
      expr: chargeback_eligible
      comment: "Chargeback to vendor eligible flag"
    - name: "receipt_date"
      expr: receipt_date
      comment: "Date goods were received"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month goods were received"
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date of quality inspection"
  measures:
    - name: "total_ordered_qty"
      expr: SUM(CAST(ordered_qty AS DOUBLE))
      comment: "Total quantity ordered from vendors"
    - name: "total_expected_qty"
      expr: SUM(CAST(expected_qty AS DOUBLE))
      comment: "Total quantity expected to be received"
    - name: "total_received_qty"
      expr: SUM(CAST(received_qty AS DOUBLE))
      comment: "Total quantity actually received"
    - name: "total_accepted_qty"
      expr: SUM(CAST(accepted_qty AS DOUBLE))
      comment: "Total quantity accepted after inspection"
    - name: "total_rejected_qty"
      expr: SUM(CAST(rejected_qty AS DOUBLE))
      comment: "Total quantity rejected due to quality or damage"
    - name: "total_shortage_qty"
      expr: SUM(CAST(shortage_qty AS DOUBLE))
      comment: "Total quantity short (expected minus received)"
    - name: "total_overage_qty"
      expr: SUM(CAST(overage_qty AS DOUBLE))
      comment: "Total quantity over (received minus expected)"
    - name: "total_receipt_cost"
      expr: SUM(CAST(total_receipt_cost AS DOUBLE))
      comment: "Total cost of goods received"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of received goods"
    - name: "receipt_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(received_qty AS DOUBLE)) / NULLIF(SUM(CAST(expected_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of expected quantity actually received"
    - name: "acceptance_rate"
      expr: ROUND(100.0 * SUM(CAST(accepted_qty AS DOUBLE)) / NULLIF(SUM(CAST(received_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity accepted after inspection"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(rejected_qty AS DOUBLE)) / NULLIF(SUM(CAST(received_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity rejected"
    - name: "shortage_rate"
      expr: ROUND(100.0 * SUM(CAST(shortage_qty AS DOUBLE)) / NULLIF(SUM(CAST(expected_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of expected quantity that was short"
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipts"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT goods_vendor_id)
      comment: "Number of unique vendors with receipts"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT goods_sku_id)
      comment: "Number of unique SKUs received"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order performance and efficiency metrics tracking order fulfillment, lead times, and cost for supply chain optimization."
  source: "`vibe_retail_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "sku_id"
      expr: replenishment_sku_id
      comment: "Stock keeping unit being replenished"
    - name: "vendor_id"
      expr: replenishment_vendor_id
      comment: "Vendor supplying the replenishment"
    - name: "destination_node_id"
      expr: destination_node_inventory_node_id
      comment: "Destination inventory node for replenishment"
    - name: "location_id"
      expr: location_id
      comment: "Store or facility location"
    - name: "order_status"
      expr: order_status
      comment: "Status of the replenishment order (draft, approved, ordered, received, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (regular, emergency, promotional, seasonal)"
    - name: "trigger_type"
      expr: trigger_type
      comment: "What triggered the replenishment (reorder point, forecast, manual, promotional)"
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Fulfillment channel (DC-to-store, vendor-direct, cross-dock)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the order (normal, high, urgent)"
    - name: "is_emergency"
      expr: is_emergency
      comment: "Emergency replenishment flag"
    - name: "is_vmi"
      expr: is_vmi
      comment: "Vendor-managed inventory flag"
    - name: "moq_compliant"
      expr: moq_compliant
      comment: "Minimum order quantity compliance flag"
    - name: "order_date"
      expr: DATE(order_date)
      comment: "Date the replenishment order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the replenishment order was placed"
    - name: "expected_delivery_date"
      expr: expected_delivery_date
      comment: "Expected delivery date"
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Actual delivery date"
  measures:
    - name: "total_ordered_qty"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered for replenishment"
    - name: "total_approved_qty"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total quantity approved for replenishment"
    - name: "total_received_qty"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received from replenishment orders"
    - name: "total_order_cost"
      expr: SUM(CAST(total_order_cost AS DOUBLE))
      comment: "Total cost of replenishment orders"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of replenishment orders"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days from order to delivery"
    - name: "fill_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of orders delivered on or before expected date"
    - name: "emergency_order_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_emergency = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replenishment orders flagged as emergency"
    - name: "moq_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN moq_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders compliant with minimum order quantity"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of replenishment orders"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT replenishment_vendor_id)
      comment: "Number of unique vendors with replenishment orders"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT replenishment_sku_id)
      comment: "Number of unique SKUs replenished"
    - name: "distinct_destination_count"
      expr: COUNT(DISTINCT destination_node_inventory_node_id)
      comment: "Number of unique destination nodes receiving replenishment"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustment and shrinkage metrics tracking reasons, costs, and approval status for loss prevention and inventory accuracy."
  source: "`vibe_retail_v1`.`inventory`.`adjustment`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Stock keeping unit adjusted"
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Inventory node where adjustment occurred"
    - name: "location_id"
      expr: location_id
      comment: "Store or facility location"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor associated with the adjusted inventory"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Status of the adjustment (draft, pending, approved, posted, rejected)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status (pending, approved, rejected)"
    - name: "reason_category"
      expr: reason_category
      comment: "High-level reason category (shrinkage, damage, expiry, error, return)"
    - name: "reason_sub_category"
      expr: reason_sub_category
      comment: "Detailed reason sub-category"
    - name: "detection_method"
      expr: detection_method
      comment: "How the adjustment was detected (cycle count, audit, customer return, system)"
    - name: "is_shrinkage"
      expr: is_shrinkage
      comment: "Flag indicating if adjustment is due to shrinkage"
    - name: "is_system_generated"
      expr: is_system_generated
      comment: "Flag indicating if adjustment was system-generated"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Flag indicating if adjustment is due to product recall"
    - name: "location_type"
      expr: location_type
      comment: "Type of location (store, DC, warehouse)"
    - name: "source_document_type"
      expr: source_document_type
      comment: "Type of source document (cycle count, return, transfer, manual)"
    - name: "adjustment_date"
      expr: DATE(adjustment_timestamp)
      comment: "Date of the adjustment"
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', adjustment_timestamp)
      comment: "Month of the adjustment"
    - name: "posting_date"
      expr: posting_date
      comment: "Fiscal posting date"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for financial reporting"
  measures:
    - name: "total_adjusted_qty"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Total quantity adjusted (positive for increases, negative for decreases)"
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total cost impact of inventory adjustments"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of adjusted inventory"
    - name: "shrinkage_cost"
      expr: SUM(CASE WHEN is_shrinkage = TRUE THEN CAST(cost_impact AS DOUBLE) ELSE 0 END)
      comment: "Total cost impact of shrinkage adjustments"
    - name: "shrinkage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_shrinkage = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments due to shrinkage"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments approved"
    - name: "system_generated_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_system_generated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments that were system-generated"
    - name: "recall_adjustment_count"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of adjustments due to product recalls"
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of inventory adjustments"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs adjusted"
    - name: "distinct_node_count"
      expr: COUNT(DISTINCT inventory_node_id)
      comment: "Number of unique inventory nodes with adjustments"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-node stock transfer performance metrics tracking transfer efficiency, accuracy, and cost for network optimization."
  source: "`vibe_retail_v1`.`inventory`.`stock_transfer`"
  dimensions:
    - name: "sku_id"
      expr: stock_sku_id
      comment: "Stock keeping unit being transferred"
    - name: "source_node_id"
      expr: primary_stock_inventory_node_id
      comment: "Source inventory node"
    - name: "destination_node_id"
      expr: destination_node_inventory_node_id
      comment: "Destination inventory node"
    - name: "location_id"
      expr: location_id
      comment: "Store or facility location"
    - name: "vendor_id"
      expr: transfer_vendor_id
      comment: "Vendor associated with the transfer"
    - name: "transfer_status"
      expr: transfer_status
      comment: "Status of the transfer (initiated, in-transit, received, cancelled)"
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (replenishment, rebalancing, emergency, return)"
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Reason code for the transfer"
    - name: "source_node_type"
      expr: source_node_type
      comment: "Type of source node (DC, store, warehouse)"
    - name: "destination_node_type"
      expr: destination_node_type
      comment: "Type of destination node (DC, store, warehouse)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer (normal, high, urgent)"
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Cross-dock transfer flag"
    - name: "is_ship_from_store"
      expr: is_ship_from_store
      comment: "Ship-from-store transfer flag"
    - name: "is_vendor_managed"
      expr: is_vendor_managed
      comment: "Vendor-managed transfer flag"
    - name: "rfid_enabled"
      expr: rfid_enabled
      comment: "RFID tracking enabled for this transfer"
    - name: "shipment_date"
      expr: shipment_date
      comment: "Date the transfer was shipped"
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', shipment_date)
      comment: "Month the transfer was shipped"
    - name: "expected_receipt_date"
      expr: expected_receipt_date
      comment: "Expected receipt date at destination"
    - name: "actual_receipt_date"
      expr: actual_receipt_date
      comment: "Actual receipt date at destination"
  measures:
    - name: "total_transfer_cost"
      expr: SUM(CAST(transfer_cost AS DOUBLE))
      comment: "Total cost of stock transfers"
    - name: "avg_inventory_cost_per_unit"
      expr: AVG(CAST(inventory_cost_per_unit AS DOUBLE))
      comment: "Average inventory cost per unit transferred"
    - name: "on_time_transfer_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_receipt_date <= expected_receipt_date THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN actual_receipt_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of transfers received on or before expected date"
    - name: "cross_dock_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_cross_dock = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers using cross-dock"
    - name: "ship_from_store_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_ship_from_store = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers originating from stores"
    - name: "transfer_count"
      expr: COUNT(1)
      comment: "Total number of stock transfers"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT stock_sku_id)
      comment: "Number of unique SKUs transferred"
    - name: "distinct_source_node_count"
      expr: COUNT(DISTINCT primary_stock_inventory_node_id)
      comment: "Number of unique source nodes"
    - name: "distinct_destination_node_count"
      expr: COUNT(DISTINCT destination_node_inventory_node_id)
      comment: "Number of unique destination nodes"
$$;