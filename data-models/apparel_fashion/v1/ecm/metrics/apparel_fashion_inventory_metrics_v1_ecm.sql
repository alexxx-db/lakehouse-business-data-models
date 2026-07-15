-- Metric views for domain: inventory | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory position metrics tracking on-hand, available-to-sell, and reserved quantities across locations and SKUs for inventory health and availability analysis"
  source: "`apparel_fashion_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the inventory snapshot for trend analysis"
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock (e.g., available, held, damaged)"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Age classification of inventory for obsolescence tracking"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification (e.g., owned, consignment, VMI)"
    - name: "allocation_group"
      expr: allocation_group
      comment: "Grouping for allocation strategy segmentation"
    - name: "nos_flag"
      expr: nos_flag
      comment: "Never-out-of-stock indicator for critical SKUs"
    - name: "vmi_flag"
      expr: vmi_flag
      comment: "Vendor-managed inventory program indicator"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the inventory originated"
  measures:
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total physical inventory on hand across all locations"
    - name: "total_ats_quantity"
      expr: SUM(CAST(ats_quantity AS DOUBLE))
      comment: "Total available-to-sell quantity after reservations and holds"
    - name: "total_atp_quantity"
      expr: SUM(CAST(atp_quantity AS DOUBLE))
      comment: "Total available-to-promise quantity for future orders"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for pending orders"
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit between locations"
    - name: "total_damaged_quantity"
      expr: SUM(CAST(damaged_quantity AS DOUBLE))
      comment: "Total quantity identified as damaged or defective"
    - name: "total_held_quantity"
      expr: SUM(CAST(held_quantity AS DOUBLE))
      comment: "Total quantity on hold for quality or compliance reasons"
    - name: "total_inventory_value"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE) * CAST(unit_cost AS DOUBLE))
      comment: "Total value of on-hand inventory at unit cost"
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(wos AS DOUBLE))
      comment: "Average weeks of supply based on current demand rates"
    - name: "inventory_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(ats_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available to sell"
    - name: "inventory_utilization_rate"
      expr: ROUND(100.0 * (SUM(CAST(on_hand_quantity AS DOUBLE)) - SUM(CAST(ats_quantity AS DOUBLE))) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of inventory committed or unavailable for sale"
    - name: "damaged_inventory_rate"
      expr: ROUND(100.0 * SUM(CAST(damaged_quantity AS DOUBLE)) / NULLIF(SUM(CAST(on_hand_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of inventory that is damaged"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs in inventory"
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT warehouse_location_id)
      comment: "Number of unique warehouse locations holding inventory"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement and transaction metrics tracking inbound, outbound, and internal transfers for supply chain velocity and accuracy analysis"
  source: "`apparel_fashion_ecm`.`inventory`.`stock_movement`"
  dimensions:
    - name: "movement_timestamp"
      expr: movement_timestamp
      comment: "Timestamp when the stock movement occurred"
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "Type of movement (e.g., receipt, shipment, transfer, adjustment)"
    - name: "movement_category"
      expr: movement_category
      comment: "High-level category of movement for grouping"
    - name: "movement_status"
      expr: movement_status
      comment: "Current status of the movement transaction"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the movement (e.g., sale, return, damage)"
    - name: "source_location_type"
      expr: source_location_type
      comment: "Type of source location (e.g., warehouse, store, vendor)"
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination location"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock being moved (e.g., finished goods, raw materials)"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating if this is a reversal transaction"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the movement"
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(movement_quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions"
    - name: "total_movement_value"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total value of inventory movements"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across movements"
    - name: "movement_transaction_count"
      expr: COUNT(1)
      comment: "Total number of stock movement transactions"
    - name: "reversal_transaction_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal transactions indicating errors or returns"
    - name: "reversal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of movements that were reversed"
    - name: "distinct_sku_moved_count"
      expr: COUNT(DISTINCT sku)
      comment: "Number of unique SKUs involved in movements"
    - name: "distinct_source_location_count"
      expr: COUNT(DISTINCT source_location_code)
      comment: "Number of unique source locations"
    - name: "distinct_destination_location_count"
      expr: COUNT(DISTINCT destination_location_code)
      comment: "Number of unique destination locations"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving metrics tracking receipt accuracy, quality, and discrepancies for supplier performance and receiving operations analysis"
  source: "`apparel_fashion_ecm`.`inventory`.`goods_receipt`"
  dimensions:
    - name: "receipt_timestamp"
      expr: receipt_timestamp
      comment: "Timestamp when goods were received"
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of receipt (e.g., purchase order, return, transfer)"
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the receipt transaction"
    - name: "discrepancy_reason_code"
      expr: discrepancy_reason_code
      comment: "Reason code for quantity or quality discrepancies"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the received goods originated"
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Flag indicating hazardous materials"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating if this receipt was reversed"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier that delivered the goods"
  measures:
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity originally ordered"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received"
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted into inventory"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected due to quality or other issues"
    - name: "total_receipt_value"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total value of goods received"
    - name: "receipt_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that was received"
    - name: "acceptance_rate"
      expr: ROUND(100.0 * SUM(CAST(accepted_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity that was accepted"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity that was rejected"
    - name: "receipt_transaction_count"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions"
    - name: "discrepancy_transaction_count"
      expr: SUM(CASE WHEN discrepancy_reason_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of receipts with discrepancies"
    - name: "discrepancy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN discrepancy_reason_code IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts with discrepancies"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of received goods"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors from whom goods were received"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment performance metrics tracking order fulfillment, lead times, and service levels for inventory planning and supplier performance analysis"
  source: "`apparel_fashion_ecm`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the replenishment order was created"
    - name: "replenishment_order_status"
      expr: replenishment_order_status
      comment: "Current status of the replenishment order"
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Type of replenishment (e.g., automatic, manual, emergency)"
    - name: "replenishment_trigger"
      expr: replenishment_trigger
      comment: "Event or condition that triggered the replenishment"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the replenishment order"
    - name: "service_level"
      expr: service_level
      comment: "Target service level for this replenishment"
    - name: "shipment_method"
      expr: shipment_method
      comment: "Method of shipment (e.g., ground, air, ocean)"
    - name: "cancelled_reason"
      expr: cancelled_reason
      comment: "Reason for cancellation if applicable"
  measures:
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested for replenishment"
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total quantity approved for replenishment"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity actually shipped"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received at destination"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost for replenishment orders"
    - name: "replenishment_order_count"
      expr: COUNT(1)
      comment: "Total number of replenishment orders"
    - name: "fill_rate"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity that was shipped"
    - name: "receipt_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(shipped_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of shipped quantity that was received"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days from order to receipt"
    - name: "avg_freight_cost_per_unit"
      expr: AVG(CAST(freight_cost AS DOUBLE) / NULLIF(CAST(shipped_quantity AS DOUBLE), 0))
      comment: "Average freight cost per unit shipped"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs replenished"
    - name: "distinct_destination_count"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique destination locations"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy metrics tracking inventory variances and count performance for inventory accuracy and shrinkage analysis"
  source: "`apparel_fashion_ecm`.`inventory`.`inventory_cycle_count`"
  dimensions:
    - name: "count_start_timestamp"
      expr: count_start_timestamp
      comment: "Timestamp when the cycle count started"
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (e.g., scheduled, ad-hoc, blind)"
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (e.g., manual, RFID, barcode)"
    - name: "count_status"
      expr: count_status
      comment: "Current status of the cycle count"
    - name: "count_reason"
      expr: count_reason
      comment: "Reason for initiating the cycle count"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the counted items"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Status of the inventory being counted"
    - name: "recount_flag"
      expr: recount_flag
      comment: "Flag indicating if this is a recount"
    - name: "adjustment_posted_flag"
      expr: adjustment_posted_flag
      comment: "Flag indicating if adjustments have been posted"
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
      comment: "Total variance between expected and counted quantities"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total financial adjustment amount due to variances"
    - name: "cycle_count_transaction_count"
      expr: COUNT(1)
      comment: "Total number of cycle count transactions"
    - name: "count_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(counted_quantity AS DOUBLE)) / NULLIF(SUM(CAST(expected_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage accuracy of counted vs expected quantities"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across all counts"
    - name: "recount_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recount_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring a recount"
    - name: "variance_transaction_count"
      expr: SUM(CASE WHEN variance_quantity != 0 THEN 1 ELSE 0 END)
      comment: "Number of counts with variances"
    - name: "variance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN variance_quantity != 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts with variances"
    - name: "distinct_sku_counted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs counted"
    - name: "distinct_location_counted"
      expr: COUNT(DISTINCT warehouse_location_id)
      comment: "Number of unique locations counted"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_transfer_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-location transfer performance metrics tracking transfer efficiency, OTIF performance, and freight costs for network optimization analysis"
  source: "`apparel_fashion_ecm`.`inventory`.`transfer_order`"
  dimensions:
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the transfer order was created"
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the transfer order"
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (e.g., store-to-store, DC-to-store)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer"
    - name: "shipment_method"
      expr: shipment_method
      comment: "Method of shipment for the transfer"
    - name: "otif_status"
      expr: otif_status
      comment: "On-time in-full delivery status"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason for the transfer"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for cancellation if applicable"
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Flag indicating hazardous materials"
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Flag indicating temperature-controlled shipment"
  measures:
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested for transfer"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for transfer"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received at destination"
    - name: "total_estimated_freight_cost"
      expr: SUM(CAST(estimated_freight_cost AS DOUBLE))
      comment: "Total estimated freight cost"
    - name: "total_actual_freight_cost"
      expr: SUM(CAST(actual_freight_cost AS DOUBLE))
      comment: "Total actual freight cost incurred"
    - name: "transfer_order_count"
      expr: COUNT(1)
      comment: "Total number of transfer orders"
    - name: "transfer_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity that was shipped"
    - name: "transfer_receipt_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(shipped_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of shipped quantity that was received"
    - name: "freight_cost_variance"
      expr: SUM(CAST(actual_freight_cost AS DOUBLE) - CAST(estimated_freight_cost AS DOUBLE))
      comment: "Total variance between actual and estimated freight costs"
    - name: "avg_freight_cost_per_unit"
      expr: AVG(CAST(actual_freight_cost AS DOUBLE) / NULLIF(CAST(shipped_quantity AS DOUBLE), 0))
      comment: "Average freight cost per unit transferred"
    - name: "distinct_sku_transferred"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs transferred"
    - name: "distinct_source_location_count"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique source locations"
    - name: "distinct_destination_location_count"
      expr: COUNT(DISTINCT warehouse_location_id)
      comment: "Number of unique destination locations"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory valuation and financial metrics tracking stock value, write-downs, and turnover for financial reporting and inventory health analysis"
  source: "`apparel_fashion_ecm`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of the inventory valuation"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the valuation"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the valuation"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation method (e.g., FIFO, LIFO, weighted average)"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Classification of valuation for accounting purposes"
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Product lifecycle stage (e.g., new, mature, obsolete)"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for financial allocation"
    - name: "profit_center_code"
      expr: profit_center_code
      comment: "Profit center code for financial reporting"
  measures:
    - name: "total_stock_quantity"
      expr: SUM(CAST(total_stock_quantity AS DOUBLE))
      comment: "Total quantity of stock valued"
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total value of inventory at valuation date"
    - name: "total_inventory_write_down"
      expr: SUM(CAST(inventory_write_down_amount AS DOUBLE))
      comment: "Total inventory write-down amount for obsolescence or damage"
    - name: "total_markdown_reserve"
      expr: SUM(CAST(markdown_reserve_amount AS DOUBLE))
      comment: "Total markdown reserve amount for anticipated price reductions"
    - name: "total_aged_inventory_provision"
      expr: SUM(CAST(aged_inventory_provision AS DOUBLE))
      comment: "Total provision for aged inventory"
    - name: "total_cogs_allocation"
      expr: SUM(CAST(cogs_allocation_amount AS DOUBLE))
      comment: "Total cost of goods sold allocation"
    - name: "avg_current_unit_cost"
      expr: AVG(CAST(current_unit_cost AS DOUBLE))
      comment: "Average current unit cost of inventory"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost of inventory"
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price across inventory"
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply based on current demand"
    - name: "avg_inventory_turnover_days"
      expr: AVG(CAST(inventory_turnover_days AS DOUBLE))
      comment: "Average days to turn inventory"
    - name: "write_down_rate"
      expr: ROUND(100.0 * SUM(CAST(inventory_write_down_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_stock_value AS DOUBLE)), 0), 2)
      comment: "Percentage of inventory value written down"
    - name: "markdown_reserve_rate"
      expr: ROUND(100.0 * SUM(CAST(markdown_reserve_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_stock_value AS DOUBLE)), 0), 2)
      comment: "Percentage of inventory value reserved for markdowns"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs valued"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`inventory_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory reservation metrics tracking reservation fulfillment, expiry, and channel performance for omnichannel inventory allocation analysis"
  source: "`apparel_fashion_ecm`.`inventory`.`reservation`"
  dimensions:
    - name: "reservation_timestamp"
      expr: reservation_timestamp
      comment: "Timestamp when the reservation was created"
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current status of the reservation"
    - name: "reservation_type"
      expr: reservation_type
      comment: "Type of reservation (e.g., hard, soft, temporary)"
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel through which the reservation will be fulfilled"
    - name: "priority"
      expr: priority
      comment: "Priority level of the reservation"
    - name: "hard_reservation_flag"
      expr: hard_reservation_flag
      comment: "Flag indicating if this is a hard (committed) reservation"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for cancellation if applicable"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the reservation"
  measures:
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved across all reservations"
    - name: "reservation_count"
      expr: COUNT(1)
      comment: "Total number of reservation transactions"
    - name: "fulfilled_reservation_count"
      expr: SUM(CASE WHEN fulfilled_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of reservations that were fulfilled"
    - name: "cancelled_reservation_count"
      expr: SUM(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of reservations that were cancelled"
    - name: "expired_reservation_count"
      expr: SUM(CASE WHEN expiry_timestamp < CURRENT_TIMESTAMP AND fulfilled_timestamp IS NULL THEN 1 ELSE 0 END)
      comment: "Number of reservations that expired without fulfillment"
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fulfilled_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reservations that were fulfilled"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cancelled_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reservations that were cancelled"
    - name: "expiry_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN expiry_timestamp < CURRENT_TIMESTAMP AND fulfilled_timestamp IS NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reservations that expired"
    - name: "avg_extended_count"
      expr: AVG(CAST(extended_count AS DOUBLE))
      comment: "Average number of times reservations were extended"
    - name: "distinct_sku_reserved"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs reserved"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers with reservations"
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT warehouse_location_id)
      comment: "Number of unique locations holding reservations"
$$;
