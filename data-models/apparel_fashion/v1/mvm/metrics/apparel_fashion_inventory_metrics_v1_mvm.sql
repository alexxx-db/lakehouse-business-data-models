-- Metric views for domain: inventory | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 18:03:30

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory position metrics tracking on-hand, available-to-sell, and reserved quantities with turnover and aging analysis"
  source: "`apparel_fashion_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock position (e.g., available, held, damaged)"
    - name: "allocation_group"
      expr: allocation_group
      comment: "Allocation group classification for inventory planning"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Age classification bucket for inventory aging analysis"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Type of inventory ownership (e.g., owned, consignment, VMI)"
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Method used for replenishing this stock position"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the inventory originated"
    - name: "vmi_flag"
      expr: vmi_flag
      comment: "Indicates if this is vendor-managed inventory"
    - name: "nos_flag"
      expr: nos_flag
      comment: "Never-out-of-stock flag indicating critical inventory items"
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the inventory snapshot"
    - name: "snapshot_year"
      expr: YEAR(snapshot_date)
      comment: "Year of the inventory snapshot"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the inventory snapshot"
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total physical inventory on hand across all stock positions"
    - name: "total_ats_quantity"
      expr: SUM(CAST(ats_quantity AS DOUBLE))
      comment: "Total available-to-sell quantity (on-hand minus reserved and held)"
    - name: "total_atp_quantity"
      expr: SUM(CAST(atp_quantity AS DOUBLE))
      comment: "Total available-to-promise quantity for future orders"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for orders or allocations"
    - name: "total_held_quantity"
      expr: SUM(CAST(held_quantity AS DOUBLE))
      comment: "Total quantity held (e.g., quality hold, investigation)"
    - name: "total_damaged_quantity"
      expr: SUM(CAST(damaged_quantity AS DOUBLE))
      comment: "Total quantity marked as damaged or defective"
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit to locations"
    - name: "total_stock_value"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE) * CAST(unit_cost AS DOUBLE))
      comment: "Total inventory value at cost (on-hand quantity times unit cost)"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across stock positions"
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(wos AS DOUBLE))
      comment: "Average weeks of supply based on current inventory and demand"
    - name: "inventory_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(ats_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available to sell (not reserved or held)"
    - name: "inventory_utilization_rate"
      expr: ROUND(100.0 * (SUM(CAST(on_hand_quantity AS DOUBLE)) - SUM(CAST(ats_quantity AS DOUBLE))) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is committed (reserved or held)"
    - name: "damaged_inventory_rate"
      expr: ROUND(100.0 * SUM(CAST(damaged_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is damaged"
    - name: "stock_position_count"
      expr: COUNT(DISTINCT stock_position_id)
      comment: "Number of unique stock positions"
    - name: "sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs in stock positions"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement and transaction metrics tracking inbound, outbound, and internal transfers with cost analysis"
  source: "`apparel_fashion_ecm`.`inventory`.`stock_movement`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "Code identifying the type of stock movement (e.g., receipt, sale, transfer, adjustment)"
    - name: "movement_category"
      expr: movement_category
      comment: "High-level category of the movement (e.g., inbound, outbound, internal)"
    - name: "movement_status"
      expr: movement_status
      comment: "Current status of the movement transaction"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock involved in the movement"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the movement (e.g., sale, return, damage, adjustment)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the movement transaction"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates if this movement is a reversal of a previous transaction"
    - name: "source_location_type"
      expr: source_location_type
      comment: "Type of source location for the movement"
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination location for the movement"
    - name: "movement_date"
      expr: movement_timestamp
      comment: "Timestamp when the movement occurred"
    - name: "movement_year"
      expr: YEAR(movement_timestamp)
      comment: "Year of the movement"
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', movement_timestamp)
      comment: "Month of the movement"
    - name: "posting_date"
      expr: posting_date
      comment: "Date when the movement was posted to the system"
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(movement_quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions"
    - name: "total_movement_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all inventory movements"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across movements"
    - name: "total_inbound_quantity"
      expr: SUM(CASE WHEN movement_category = 'inbound' THEN CAST(movement_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity of inbound movements (receipts, returns to stock)"
    - name: "total_outbound_quantity"
      expr: SUM(CASE WHEN movement_category = 'outbound' THEN CAST(movement_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity of outbound movements (sales, shipments, disposals)"
    - name: "total_internal_transfer_quantity"
      expr: SUM(CASE WHEN movement_category = 'internal' THEN CAST(movement_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity of internal transfers between locations"
    - name: "movement_transaction_count"
      expr: COUNT(stock_movement_id)
      comment: "Total number of stock movement transactions"
    - name: "reversal_transaction_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal transactions"
    - name: "reversal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(stock_movement_id), 0), 2)
      comment: "Percentage of movements that are reversals, indicating transaction quality"
    - name: "avg_movement_value"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average value per movement transaction"
    - name: "unique_sku_moved_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs involved in movements"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving metrics tracking receipt accuracy, discrepancies, and supplier performance"
  source: "`apparel_fashion_ecm`.`inventory`.`goods_receipt`"
  dimensions:
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of goods receipt (e.g., purchase order, return, transfer)"
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the receipt transaction"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received"
    - name: "discrepancy_reason_code"
      expr: discrepancy_reason_code
      comment: "Reason code for any discrepancies between ordered and received quantities"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the received goods"
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Indicates if the received goods are hazardous materials"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates if this receipt is a reversal"
    - name: "rfid_enabled_flag"
      expr: rfid_enabled_flag
      comment: "Indicates if RFID tracking was used for this receipt"
    - name: "receipt_date"
      expr: receipt_timestamp
      comment: "Timestamp when goods were received"
    - name: "receipt_year"
      expr: YEAR(receipt_timestamp)
      comment: "Year of the receipt"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_timestamp)
      comment: "Month of the receipt"
    - name: "posting_date"
      expr: posting_date
      comment: "Date when the receipt was posted to inventory"
  measures:
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all receipts"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received"
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted into inventory after quality checks"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected due to quality or other issues"
    - name: "total_receipt_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all goods received"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of received goods"
    - name: "receipt_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that was actually received, measuring supplier fulfillment accuracy"
    - name: "acceptance_rate"
      expr: ROUND(100.0 * SUM(CAST(accepted_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received goods that passed quality checks and were accepted"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received goods that were rejected, indicating quality issues"
    - name: "receipt_transaction_count"
      expr: COUNT(goods_receipt_id)
      comment: "Total number of goods receipt transactions"
    - name: "receipts_with_discrepancies"
      expr: SUM(CASE WHEN discrepancy_reason_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of receipts that had discrepancies"
    - name: "discrepancy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN discrepancy_reason_code IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(goods_receipt_id), 0), 2)
      comment: "Percentage of receipts with discrepancies, measuring receiving process quality"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors from whom goods were received"
    - name: "unique_sku_received_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs received"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy metrics tracking inventory variance, count efficiency, and adjustment impact"
  source: "`apparel_fashion_ecm`.`inventory`.`cycle_count`"
  dimensions:
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (e.g., scheduled, ad-hoc, ABC-based)"
    - name: "count_status"
      expr: count_status
      comment: "Current status of the cycle count"
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (e.g., manual, RFID, barcode)"
    - name: "count_reason"
      expr: count_reason
      comment: "Reason for initiating the cycle count"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the counted item (A=high value, B=medium, C=low)"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Status of the inventory being counted"
    - name: "recount_flag"
      expr: recount_flag
      comment: "Indicates if this was a recount due to variance"
    - name: "adjustment_posted_flag"
      expr: adjustment_posted_flag
      comment: "Indicates if the adjustment has been posted to inventory"
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Date when the cycle count was scheduled"
    - name: "count_start_date"
      expr: count_start_timestamp
      comment: "Timestamp when counting started"
    - name: "count_year"
      expr: YEAR(count_start_timestamp)
      comment: "Year of the cycle count"
    - name: "count_month"
      expr: DATE_TRUNC('MONTH', count_start_timestamp)
      comment: "Month of the cycle count"
  measures:
    - name: "total_expected_quantity"
      expr: SUM(CAST(expected_quantity AS DOUBLE))
      comment: "Total expected quantity based on system records"
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total quantity physically counted"
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total quantity approved after count verification"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance between expected and counted quantities (can be positive or negative)"
    - name: "total_absolute_variance_quantity"
      expr: SUM(ABS(CAST(variance_quantity AS DOUBLE)))
      comment: "Total absolute variance regardless of direction, measuring total discrepancy"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total financial adjustment amount due to variances"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across all counts"
    - name: "cycle_count_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(counted_quantity AS DOUBLE)) / NULLIF(SUM(CAST(expected_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage accuracy of cycle counts (counted vs expected), measuring inventory record accuracy"
    - name: "variance_rate"
      expr: ROUND(100.0 * SUM(ABS(CAST(variance_quantity AS DOUBLE))) / NULLIF(SUM(CAST(expected_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of expected quantity that represents variance, measuring inventory accuracy"
    - name: "cycle_count_transaction_count"
      expr: COUNT(cycle_count_id)
      comment: "Total number of cycle count transactions"
    - name: "counts_with_variance"
      expr: SUM(CASE WHEN CAST(variance_quantity AS DOUBLE) != 0 THEN 1 ELSE 0 END)
      comment: "Number of counts that had variances"
    - name: "recount_count"
      expr: SUM(CASE WHEN recount_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of recounts performed"
    - name: "recount_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recount_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(cycle_count_id), 0), 2)
      comment: "Percentage of counts requiring recounts, indicating count quality issues"
    - name: "unique_sku_counted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs counted"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_transfer_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-location transfer metrics tracking fulfillment accuracy, transit time, and transfer efficiency"
  source: "`apparel_fashion_ecm`.`inventory`.`transfer_order`"
  dimensions:
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (e.g., store-to-store, DC-to-store, store-to-DC)"
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the transfer order"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason for the transfer"
    - name: "shipment_method"
      expr: shipment_method
      comment: "Method used for shipping the transfer"
    - name: "otif_status"
      expr: otif_status
      comment: "On-time in-full delivery status"
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Indicates if the transfer contains hazardous materials"
    - name: "rfid_tracked"
      expr: rfid_tracked
      comment: "Indicates if the transfer is tracked via RFID"
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Indicates if the transfer requires temperature control"
    - name: "requested_ship_date"
      expr: requested_ship_date
      comment: "Date when shipment was requested"
    - name: "actual_ship_date"
      expr: actual_ship_date
      comment: "Date when shipment actually occurred"
    - name: "requested_delivery_date"
      expr: requested_delivery_date
      comment: "Date when delivery was requested"
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Date when delivery actually occurred"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year when the transfer order was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when the transfer order was created"
  measures:
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested for transfer"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for transfer"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity actually shipped"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received at destination"
    - name: "total_estimated_freight_cost"
      expr: SUM(CAST(estimated_freight_cost AS DOUBLE))
      comment: "Total estimated freight cost for transfers"
    - name: "total_actual_freight_cost"
      expr: SUM(CAST(actual_freight_cost AS DOUBLE))
      comment: "Total actual freight cost incurred"
    - name: "transfer_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity that was shipped, measuring transfer fulfillment"
    - name: "transfer_receipt_accuracy"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(shipped_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of shipped quantity that was received, measuring transfer accuracy"
    - name: "freight_cost_variance"
      expr: SUM(CAST(actual_freight_cost AS DOUBLE) - CAST(estimated_freight_cost AS DOUBLE))
      comment: "Total variance between actual and estimated freight costs"
    - name: "freight_cost_variance_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_freight_cost AS DOUBLE) - CAST(estimated_freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(estimated_freight_cost AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and estimated freight costs, measuring cost predictability"
    - name: "transfer_order_count"
      expr: COUNT(transfer_order_id)
      comment: "Total number of transfer orders"
    - name: "otif_transfer_count"
      expr: SUM(CASE WHEN otif_status = 'OTIF' THEN 1 ELSE 0 END)
      comment: "Number of transfers delivered on-time and in-full"
    - name: "otif_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_status = 'OTIF' THEN 1 ELSE 0 END) / NULLIF(COUNT(transfer_order_id), 0), 2)
      comment: "Percentage of transfers delivered on-time in-full, key supply chain performance metric"
    - name: "cancelled_transfer_count"
      expr: SUM(CASE WHEN cancellation_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of cancelled transfers"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cancellation_reason IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(transfer_order_id), 0), 2)
      comment: "Percentage of transfers that were cancelled, indicating planning or execution issues"
    - name: "unique_sku_transferred"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs transferred"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment effectiveness metrics tracking order fulfillment, lead time performance, and stock optimization"
  source: "`apparel_fashion_ecm`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Type of replenishment (e.g., automatic, manual, emergency)"
    - name: "replenishment_order_status"
      expr: replenishment_order_status
      comment: "Current status of the replenishment order"
    - name: "replenishment_trigger"
      expr: replenishment_trigger
      comment: "What triggered the replenishment (e.g., reorder point, forecast, event)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the replenishment order"
    - name: "service_level"
      expr: service_level
      comment: "Target service level for this replenishment"
    - name: "shipment_method"
      expr: shipment_method
      comment: "Method used for shipping the replenishment"
    - name: "cancelled_reason"
      expr: cancelled_reason
      comment: "Reason for cancellation if applicable"
    - name: "expected_ship_date"
      expr: expected_ship_date
      comment: "Expected date of shipment"
    - name: "actual_ship_date"
      expr: actual_ship_date
      comment: "Actual date of shipment"
    - name: "requested_delivery_date"
      expr: requested_delivery_date
      comment: "Requested delivery date"
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Actual delivery date"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year when the replenishment order was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when the replenishment order was created"
  measures:
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested for replenishment"
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total quantity approved for replenishment"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received at destination"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost for replenishment orders"
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point across replenishment orders"
    - name: "avg_safety_stock_level"
      expr: AVG(CAST(safety_stock_level AS DOUBLE))
      comment: "Average safety stock level maintained"
    - name: "avg_max_stock_level"
      expr: AVG(CAST(max_stock_level AS DOUBLE))
      comment: "Average maximum stock level target"
    - name: "avg_ats_at_request"
      expr: AVG(CAST(ats_quantity_at_request AS DOUBLE))
      comment: "Average available-to-sell quantity at time of replenishment request"
    - name: "replenishment_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity that was shipped, measuring replenishment effectiveness"
    - name: "replenishment_receipt_accuracy"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(shipped_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of shipped quantity that was received, measuring delivery accuracy"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CAST(approved_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity that was approved, measuring request quality"
    - name: "replenishment_order_count"
      expr: COUNT(replenishment_order_id)
      comment: "Total number of replenishment orders"
    - name: "cancelled_order_count"
      expr: SUM(CASE WHEN cancelled_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of cancelled replenishment orders"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cancelled_reason IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(replenishment_order_id), 0), 2)
      comment: "Percentage of replenishment orders cancelled, indicating planning accuracy issues"
    - name: "unique_destination_store_count"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique destination stores receiving replenishment"
    - name: "unique_sku_replenished"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs replenished"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory valuation and financial metrics tracking stock value, markdown reserves, write-downs, and inventory health"
  source: "`apparel_fashion_ecm`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation method (e.g., FIFO, LIFO, weighted average)"
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Classification of the valuation"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Product lifecycle stage (e.g., new, regular, clearance, obsolete)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the valuation"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the valuation"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for the inventory"
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Profit center code for the inventory"
    - name: "gl_account_number"
      expr: gl_account_number
      comment: "General ledger account number"
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of the valuation"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of the valuation"
    - name: "valuation_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Month of the valuation"
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total value of inventory at cost"
    - name: "total_net_realizable_value"
      expr: SUM(CAST(net_realizable_value AS DOUBLE))
      comment: "Total net realizable value of inventory (estimated selling price minus costs)"
    - name: "total_markdown_reserve"
      expr: SUM(CAST(markdown_reserve_amount AS DOUBLE))
      comment: "Total markdown reserve amount set aside for future price reductions"
    - name: "total_aged_inventory_provision"
      expr: SUM(CAST(aged_inventory_provision AS DOUBLE))
      comment: "Total provision for aged or slow-moving inventory"
    - name: "total_inventory_write_down"
      expr: SUM(CAST(inventory_write_down_amount AS DOUBLE))
      comment: "Total inventory write-down amount due to obsolescence or damage"
    - name: "total_cogs_allocation"
      expr: SUM(CAST(cogs_allocation_amount AS DOUBLE))
      comment: "Total cost of goods sold allocation amount"
    - name: "total_price_variance"
      expr: SUM(CAST(price_variance_amount AS DOUBLE))
      comment: "Total price variance between standard and actual costs"
    - name: "avg_current_unit_cost"
      expr: AVG(CAST(current_unit_cost AS DOUBLE))
      comment: "Average current unit cost of inventory"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost of inventory"
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price across inventory"
    - name: "avg_markdown_reserve_percentage"
      expr: AVG(CAST(markdown_reserve_percentage AS DOUBLE))
      comment: "Average markdown reserve as percentage of inventory value"
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply based on current inventory and demand"
    - name: "inventory_shrinkage_rate"
      expr: ROUND(100.0 * SUM(CAST(inventory_write_down_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_stock_value AS DOUBLE)), 0), 2)
      comment: "Percentage of inventory value written down, measuring shrinkage and obsolescence"
    - name: "markdown_reserve_rate"
      expr: ROUND(100.0 * SUM(CAST(markdown_reserve_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_stock_value AS DOUBLE)), 0), 2)
      comment: "Markdown reserve as percentage of total stock value, indicating pricing risk"
    - name: "inventory_health_ratio"
      expr: ROUND(100.0 * SUM(CAST(net_realizable_value AS DOUBLE)) / NULLIF(SUM(CAST(total_stock_value AS DOUBLE)), 0), 2)
      comment: "Net realizable value as percentage of cost, measuring inventory quality and salability"
    - name: "valuation_record_count"
      expr: COUNT(stock_valuation_id)
      comment: "Total number of stock valuation records"
    - name: "unique_sku_valued"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs with valuation records"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_asn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advanced shipping notice metrics tracking inbound shipment accuracy, timeliness, and receiving efficiency"
  source: "`apparel_fashion_ecm`.`inventory`.`asn`"
  dimensions:
    - name: "asn_type"
      expr: asn_type
      comment: "Type of ASN (e.g., purchase order, transfer, return)"
    - name: "asn_status"
      expr: asn_status
      comment: "Current status of the ASN"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the shipment"
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Service level provided by the carrier"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms defining shipping responsibilities"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the goods originated"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Indicates if the shipment contains hazardous materials"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates if the shipment requires temperature control"
    - name: "rfid_enabled_flag"
      expr: rfid_enabled_flag
      comment: "Indicates if RFID tracking is enabled for this ASN"
    - name: "expected_arrival_date"
      expr: expected_arrival_date
      comment: "Expected date of arrival"
    - name: "actual_arrival_date"
      expr: actual_arrival_date
      comment: "Actual date of arrival"
    - name: "shipment_date"
      expr: shipment_date
      comment: "Date when the shipment was sent"
    - name: "transmitted_year"
      expr: YEAR(transmitted_timestamp)
      comment: "Year when the ASN was transmitted"
    - name: "transmitted_month"
      expr: DATE_TRUNC('MONTH', transmitted_timestamp)
      comment: "Month when the ASN was transmitted"
  measures:
    - name: "total_unit_quantity"
      expr: SUM(CAST(total_unit_quantity AS DOUBLE))
      comment: "Total unit quantity across all ASNs"
    - name: "total_carton_count"
      expr: SUM(CAST(total_carton_count AS DOUBLE))
      comment: "Total number of cartons shipped"
    - name: "total_pallet_count"
      expr: SUM(CAST(total_pallet_count AS DOUBLE))
      comment: "Total number of pallets shipped"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight in kilograms"
    - name: "total_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total volume in cubic meters"
    - name: "total_customs_value"
      expr: SUM(CAST(customs_value_amount AS DOUBLE))
      comment: "Total customs value of shipments"
    - name: "avg_weight_per_unit"
      expr: AVG(CAST(total_weight_kg AS DOUBLE) / NULLIF(CAST(total_unit_quantity AS DOUBLE), 0))
      comment: "Average weight per unit across shipments"
    - name: "avg_volume_per_unit"
      expr: AVG(CAST(total_volume_cbm AS DOUBLE) / NULLIF(CAST(total_unit_quantity AS DOUBLE), 0))
      comment: "Average volume per unit across shipments"
    - name: "asn_count"
      expr: COUNT(asn_id)
      comment: "Total number of ASNs"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors sending ASNs"
    - name: "unique_carrier_count"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers used"
    - name: "hazmat_shipment_count"
      expr: SUM(CASE WHEN is_hazmat = TRUE THEN 1 ELSE 0 END)
      comment: "Number of hazardous material shipments"
    - name: "hazmat_shipment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_hazmat = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(asn_id), 0), 2)
      comment: "Percentage of shipments containing hazardous materials"
    - name: "rfid_enabled_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rfid_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(asn_id), 0), 2)
      comment: "Percentage of ASNs with RFID tracking enabled"
$$;
