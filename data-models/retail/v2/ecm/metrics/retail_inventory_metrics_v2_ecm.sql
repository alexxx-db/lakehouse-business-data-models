-- Metric views for domain: inventory | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_stock_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational inventory movement metrics derived from the stock ledger. Tracks cost impact, shrinkage, and movement patterns to support P&L, loss-prevention, and audit decisions."
  source: "`vibe_retail_v1`.`inventory`.`stock_ledger`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store or DC location where the inventory movement occurred."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU involved in the inventory movement for item-level analysis."
    - name: "category_id"
      expr: category_id
      comment: "Merchandise category for category-level movement roll-ups."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of inventory movement (e.g. sale, receipt, adjustment, transfer) for movement classification."
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Reason code for the inventory movement, used to analyze root causes of adjustments and shrinkage."
    - name: "channel"
      expr: channel
      comment: "Sales or fulfillment channel associated with the movement (e.g. in-store, online, ship-from-store)."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the ledger transaction (e.g. posted, pending, reversed)."
    - name: "shrinkage_flag"
      expr: shrinkage_flag
      comment: "Indicates whether the movement is classified as shrinkage for loss-prevention reporting."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether this ledger entry is a reversal of a prior transaction."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method applied to this movement for financial reporting segmentation."
    - name: "posting_date"
      expr: DATE_TRUNC('day', posting_date)
      comment: "Date the movement was posted to the ledger for daily trend analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month the movement was posted for monthly financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the movement for period-over-period financial comparison."
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(movement_quantity AS DOUBLE))
      comment: "Net total units moved across all ledger entries. Measures overall inventory flow volume."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total cost value of all inventory movements. Core financial metric for cost-of-goods-sold and inventory valuation."
    - name: "total_extended_retail_value"
      expr: SUM(CAST(extended_retail_value AS DOUBLE))
      comment: "Total retail value of inventory movements. Used to compute gross margin and shrinkage at retail."
    - name: "total_shrinkage_cost"
      expr: SUM(CASE WHEN shrinkage_flag = TRUE THEN extended_cost ELSE 0 END)
      comment: "Total cost of shrinkage movements. Key loss-prevention KPI directly impacting gross margin."
    - name: "total_shrinkage_units"
      expr: SUM(CASE WHEN shrinkage_flag = TRUE THEN movement_quantity ELSE 0 END)
      comment: "Total units lost to shrinkage. Drives loss-prevention investment and operational intervention decisions."
    - name: "shrinkage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN shrinkage_flag = TRUE THEN extended_retail_value ELSE 0 END) / NULLIF(SUM(CAST(extended_retail_value AS DOUBLE)), 0), 4)
      comment: "Shrinkage as a percentage of total retail value. Industry-standard loss-prevention KPI; benchmarked against sector norms to trigger investigation."
    - name: "total_reversal_cost"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN extended_cost ELSE 0 END)
      comment: "Total cost value of reversed transactions. High reversal volumes indicate data quality or process issues requiring audit."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across ledger movements. Used to monitor cost inflation and supplier pricing trends."
    - name: "distinct_skus_moved"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with ledger movements in the period. Measures assortment activity breadth."
    - name: "distinct_locations_with_movements"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of distinct locations with inventory movements. Used to assess operational coverage and identify inactive nodes."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustment metrics tracking the volume, cost impact, and approval patterns of stock adjustments. Used by loss-prevention, finance, and operations to monitor shrinkage, write-offs, and process compliance."
  source: "`vibe_retail_v1`.`inventory`.`adjustment`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Location where the adjustment was made for geographic analysis of adjustment patterns."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU adjusted for item-level shrinkage and variance analysis."
    - name: "category_id"
      expr: category_id
      comment: "Merchandise category for category-level adjustment roll-ups."
    - name: "reason_category"
      expr: reason_category
      comment: "High-level reason category for the adjustment (e.g. shrinkage, damage, receiving error) for root-cause analysis."
    - name: "reason_sub_category"
      expr: reason_sub_category
      comment: "Detailed reason sub-category for granular root-cause drill-down."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g. pending, approved, posted) for workflow monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adjustment for compliance and audit tracking."
    - name: "is_shrinkage"
      expr: is_shrinkage
      comment: "Flag indicating whether the adjustment is classified as shrinkage for loss-prevention reporting."
    - name: "is_system_generated"
      expr: is_system_generated
      comment: "Distinguishes system-generated adjustments from manual entries for process quality analysis."
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the discrepancy was detected (e.g. cycle count, RFID, POS exception) for process effectiveness analysis."
    - name: "location_type"
      expr: location_type
      comment: "Type of location (e.g. store, DC, warehouse) for node-type segmentation."
    - name: "posting_date"
      expr: DATE_TRUNC('day', posting_date)
      comment: "Date the adjustment was posted for daily trend analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month the adjustment was posted for monthly loss reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the adjustment for period-over-period comparison."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of inventory adjustments. High volumes may indicate process or data quality issues requiring investigation."
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Net total units adjusted across all adjustment records. Measures overall inventory correction volume."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total financial cost impact of all adjustments. Directly affects inventory valuation and P&L; key metric for finance and loss-prevention leadership."
    - name: "total_shrinkage_cost_impact"
      expr: SUM(CASE WHEN is_shrinkage = TRUE THEN cost_impact ELSE 0 END)
      comment: "Total cost impact of shrinkage-classified adjustments. Core loss-prevention KPI used to benchmark against industry shrinkage rates."
    - name: "shrinkage_adjustment_count"
      expr: COUNT(CASE WHEN is_shrinkage = TRUE THEN 1 END)
      comment: "Number of adjustments classified as shrinkage. Tracks frequency of loss events for operational intervention."
    - name: "avg_cost_impact_per_adjustment"
      expr: AVG(CAST(cost_impact AS DOUBLE))
      comment: "Average cost impact per adjustment. Identifies whether adjustments are increasing in severity over time."
    - name: "pending_approval_adjustments"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Number of adjustments awaiting approval. High backlogs indicate process bottlenecks and compliance risk."
    - name: "distinct_skus_adjusted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with adjustments in the period. Broad SKU coverage may indicate systemic issues."
    - name: "distinct_locations_with_adjustments"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of distinct locations with adjustments. Used to identify high-adjustment locations for targeted loss-prevention programs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy and variance metrics used by operations and finance to assess inventory record accuracy, identify shrinkage patterns, and drive corrective action at the SKU and location level."
  source: "`vibe_retail_v1`.`inventory`.`cycle_count`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Location where the cycle count was performed for geographic accuracy analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU counted for item-level accuracy analysis."
    - name: "category_id"
      expr: category_id
      comment: "Merchandise category for category-level count accuracy roll-ups."
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count (e.g. scheduled, in-progress, completed, approved) for workflow monitoring."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (e.g. full, partial, spot-check, RFID) for methodology segmentation."
    - name: "count_frequency"
      expr: count_frequency
      comment: "Frequency classification of the count (e.g. daily, weekly, monthly) for compliance monitoring."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification of the counted SKU for prioritization analysis."
    - name: "shrinkage_category"
      expr: shrinkage_category
      comment: "Shrinkage category identified during the count for loss-prevention root-cause analysis."
    - name: "adjustment_generated"
      expr: adjustment_generated
      comment: "Indicates whether the count resulted in an inventory adjustment, used to measure count-to-adjustment conversion rate."
    - name: "recount_required"
      expr: recount_required
      comment: "Indicates whether a recount was required, signaling count quality issues."
    - name: "scheduled_date"
      expr: DATE_TRUNC('day', scheduled_date)
      comment: "Scheduled date of the cycle count for compliance and scheduling analysis."
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month of the scheduled cycle count for monthly compliance reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the cycle count for period-over-period accuracy comparison."
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle counts performed. Measures count program activity and compliance with scheduled frequency."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Net total unit variance between counted and system quantities. Measures overall inventory record accuracy gap."
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total cost value of inventory variances. Directly impacts financial inventory valuation and P&L."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across cycle counts. Key inventory accuracy KPI; high values trigger process improvement initiatives."
    - name: "counts_within_tolerance"
      expr: COUNT(CASE WHEN ABS(variance_percentage) <= variance_tolerance_pct THEN 1 END)
      comment: "Number of cycle counts where variance fell within the defined tolerance. Measures inventory accuracy compliance rate."
    - name: "counts_exceeding_tolerance"
      expr: COUNT(CASE WHEN ABS(variance_percentage) > variance_tolerance_pct THEN 1 END)
      comment: "Number of cycle counts exceeding variance tolerance. Triggers mandatory adjustment and root-cause investigation."
    - name: "accuracy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ABS(variance_percentage) <= variance_tolerance_pct THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts within tolerance. Primary inventory accuracy KPI used in operational scorecards and audit reporting."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring a recount. High recount rates indicate count process quality issues."
    - name: "adjustment_generation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adjustment_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts that generated an inventory adjustment. Measures how often counts reveal actionable discrepancies."
    - name: "avg_unit_cost_at_count"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of items counted. Used to weight variance cost analysis and prioritize high-value count programs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving performance metrics tracking receipt accuracy, discrepancy rates, and quality inspection outcomes. Used by supply chain, procurement, and finance to manage supplier performance and inbound cost control."
  source: "`vibe_retail_v1`.`inventory`.`goods_receipt`"
  dimensions:
    - name: "inventory_node_id"
      expr: inventory_node_id
      comment: "Receiving node (store or DC) for location-level inbound performance analysis."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Supplier for vendor-level receipt accuracy and discrepancy analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU received for item-level inbound quality analysis."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (e.g. complete, partial, rejected) for workflow monitoring."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome (e.g. passed, failed, conditional) for supplier quality management."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of receiving discrepancy (e.g. shortage, overage, damage) for root-cause analysis."
    - name: "receipt_method"
      expr: receipt_method
      comment: "Method used to receive goods (e.g. manual, RFID, scan) for process efficiency analysis."
    - name: "receiving_node_type"
      expr: receiving_node_type
      comment: "Type of receiving node (e.g. store, DC) for node-type segmentation."
    - name: "chargeback_eligible"
      expr: chargeback_eligible
      comment: "Indicates whether the receipt qualifies for a supplier chargeback, used to track chargeback recovery opportunities."
    - name: "receipt_date"
      expr: DATE_TRUNC('day', receipt_date)
      comment: "Date goods were received for daily inbound volume trending."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month goods were received for monthly inbound performance reporting."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipts processed. Measures inbound receiving volume."
    - name: "total_received_qty"
      expr: SUM(CAST(received_qty AS DOUBLE))
      comment: "Total units received across all receipts. Core inbound volume metric for supply chain planning."
    - name: "total_accepted_qty"
      expr: SUM(CAST(accepted_qty AS DOUBLE))
      comment: "Total units accepted after inspection. Measures effective inbound supply after quality filtering."
    - name: "total_rejected_qty"
      expr: SUM(CAST(rejected_qty AS DOUBLE))
      comment: "Total units rejected at receiving. High rejection volumes indicate supplier quality issues requiring escalation."
    - name: "total_shortage_qty"
      expr: SUM(CAST(shortage_qty AS DOUBLE))
      comment: "Total units short-shipped versus purchase order. Drives chargeback and supplier performance management."
    - name: "total_overage_qty"
      expr: SUM(CAST(overage_qty AS DOUBLE))
      comment: "Total units received in excess of purchase order. Overages create inventory and financial reconciliation issues."
    - name: "total_receipt_cost"
      expr: SUM(CAST(total_receipt_cost AS DOUBLE))
      comment: "Total cost value of goods received. Core AP and inventory valuation input for finance."
    - name: "receipt_accuracy_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accepted_qty AS DOUBLE)) / NULLIF(SUM(CAST(ordered_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered units accepted at receipt. Primary supplier fill-rate and accuracy KPI used in vendor scorecards."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_qty AS DOUBLE)) / NULLIF(SUM(CAST(received_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of received units rejected at quality inspection. High rates trigger supplier quality reviews and corrective action."
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_type IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts with a recorded discrepancy. Measures inbound process reliability and supplier compliance."
    - name: "chargeback_eligible_receipts"
      expr: COUNT(CASE WHEN chargeback_eligible = TRUE THEN 1 END)
      comment: "Number of receipts eligible for supplier chargeback. Quantifies chargeback recovery opportunity for finance."
    - name: "avg_unit_cost_received"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of received goods. Used to monitor cost inflation and validate against purchase order pricing."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order performance metrics tracking order fulfillment rates, lead times, and cost efficiency. Used by supply chain and merchandising leadership to optimize replenishment programs and supplier performance."
  source: "`vibe_retail_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Supplier fulfilling the replenishment order for vendor performance analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being replenished for item-level replenishment analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (e.g. open, in-transit, received, cancelled) for pipeline monitoring."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (e.g. auto, manual, emergency, VMI) for program segmentation."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel through which the order is fulfilled (e.g. DC, direct-to-store, cross-dock) for supply chain routing analysis."
    - name: "trigger_type"
      expr: trigger_type
      comment: "What triggered the replenishment (e.g. reorder point, forecast, manual) for demand-driven vs. reactive analysis."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flags emergency replenishment orders, which carry higher cost and indicate planning failures."
    - name: "is_vmi"
      expr: is_vmi
      comment: "Indicates vendor-managed inventory orders for VMI program performance analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the order for fulfillment sequencing analysis."
    - name: "order_date"
      expr: DATE_TRUNC('day', order_date)
      comment: "Date the replenishment order was placed for daily order volume trending."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the order was placed for monthly replenishment reporting."
  measures:
    - name: "total_replenishment_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders placed. Measures replenishment program activity volume."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered for replenishment. Core supply pipeline volume metric."
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total units approved for replenishment after review. Measures effective supply commitment."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units actually received against replenishment orders. Measures supplier delivery fulfillment."
    - name: "total_order_cost"
      expr: SUM(CAST(total_order_cost AS DOUBLE))
      comment: "Total cost of replenishment orders. Core procurement spend metric for budget management."
    - name: "fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered units actually received. Primary supplier fill-rate KPI used in vendor scorecards and supply chain reviews."
    - name: "emergency_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replenishment orders classified as emergency. High rates indicate planning failures and carry premium cost implications."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replenishment orders cancelled. High cancellation rates signal demand volatility or supplier reliability issues."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across replenishment orders. Used to monitor procurement cost trends and negotiate supplier pricing."
    - name: "moq_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN moq_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders meeting minimum order quantity requirements. Non-compliance drives excess freight and handling costs."
    - name: "distinct_vendors_ordered_from"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with active replenishment orders. Measures supply base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_expiry_tracking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Perishable and date-sensitive inventory expiry risk metrics. Used by store operations, food safety, and finance to minimize waste, prevent compliance violations, and optimize markdown timing for near-expiry stock."
  source: "`vibe_retail_v1`.`inventory`.`expiry_tracking`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Store or DC location for geographic expiry risk analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU for item-level expiry risk analysis."
    - name: "category_id"
      expr: category_id
      comment: "Merchandise category for category-level expiry risk roll-ups."
    - name: "expiry_risk_status"
      expr: expiry_risk_status
      comment: "Risk classification of the expiry position (e.g. critical, near-expiry, safe) for prioritized action."
    - name: "action_status"
      expr: action_status
      comment: "Status of the remediation action taken (e.g. marked-down, donated, disposed) for waste management tracking."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of expired stock (e.g. markdown, donation, waste) for sustainability and cost analysis."
    - name: "recommended_action"
      expr: recommended_action
      comment: "System-recommended action for near-expiry stock for operational guidance analysis."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature storage zone (e.g. ambient, chilled, frozen) for cold-chain expiry risk segmentation."
    - name: "is_recall_active"
      expr: is_recall_active
      comment: "Indicates whether the item is subject to an active recall, requiring immediate action."
    - name: "location_type"
      expr: location_type
      comment: "Type of location (e.g. store, DC) for node-type expiry analysis."
    - name: "expiry_date"
      expr: DATE_TRUNC('day', expiry_date)
      comment: "Expiry date for time-based expiry risk analysis."
    - name: "expiry_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month of expiry for monthly waste forecasting."
  measures:
    - name: "total_quantity_at_risk"
      expr: SUM(CAST(quantity_at_risk AS DOUBLE))
      comment: "Total units at risk of expiry. Primary perishable waste risk KPI used to trigger markdown and donation decisions."
    - name: "total_quantity_disposed"
      expr: SUM(CAST(quantity_disposed AS DOUBLE))
      comment: "Total units disposed due to expiry. Measures actual waste volume for sustainability and cost reporting."
    - name: "total_cost_at_risk"
      expr: SUM(CAST(quantity_at_risk AS DOUBLE) * CAST(inventory_cost_per_unit AS DOUBLE))
      comment: "Total cost value of inventory at expiry risk. Quantifies financial exposure from perishable waste for P&L management."
    - name: "total_disposal_cost"
      expr: SUM(CAST(quantity_disposed AS DOUBLE) * CAST(inventory_cost_per_unit AS DOUBLE))
      comment: "Total cost of disposed expired inventory. Measures realized waste cost impact on gross margin."
    - name: "avg_remaining_shelf_life_pct"
      expr: AVG(CAST(remaining_shelf_life_pct AS DOUBLE))
      comment: "Average remaining shelf life percentage across tracked positions. Low averages indicate systemic FEFO or ordering issues."
    - name: "recall_active_quantity"
      expr: SUM(CASE WHEN is_recall_active = TRUE THEN quantity_on_hand ELSE 0 END)
      comment: "Total on-hand units subject to an active recall. Requires immediate operational response and regulatory reporting."
    - name: "waste_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_disposed AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory disposed due to expiry. Key sustainability and margin KPI benchmarked against category targets."
    - name: "distinct_skus_at_expiry_risk"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with expiry risk positions. Measures breadth of perishable risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-node stock transfer metrics tracking transfer volume, cost, and fulfillment performance. Used by supply chain and store operations to optimize inventory redistribution and ship-from-store programs."
  source: "`vibe_retail_v1`.`inventory`.`stock_transfer`"
  dimensions:
    - name: "primary_stock_inventory_node_id"
      expr: primary_stock_inventory_node_id
      comment: "Source inventory node for the transfer for origin-level analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being transferred for item-level transfer analysis."
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the transfer (e.g. initiated, in-transit, received, cancelled) for pipeline monitoring."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (e.g. store-to-store, DC-to-store, cross-dock) for routing analysis."
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Reason for the transfer (e.g. replenishment, balancing, return-to-DC) for root-cause analysis."
    - name: "is_ship_from_store"
      expr: is_ship_from_store
      comment: "Indicates ship-from-store transfers for omnichannel fulfillment program analysis."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Indicates cross-dock transfers for supply chain efficiency analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the transfer for fulfillment sequencing analysis."
    - name: "source_node_type"
      expr: source_node_type
      comment: "Type of source node (e.g. store, DC) for node-type segmentation."
    - name: "destination_node_type"
      expr: destination_node_type
      comment: "Type of destination node for destination segmentation."
    - name: "shipment_date"
      expr: DATE_TRUNC('day', shipment_date)
      comment: "Date the transfer was shipped for daily transfer volume trending."
    - name: "shipment_month"
      expr: DATE_TRUNC('month', shipment_date)
      comment: "Month the transfer was shipped for monthly transfer reporting."
  measures:
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total number of stock transfers initiated. Measures inventory redistribution activity volume."
    - name: "total_transfer_cost"
      expr: SUM(CAST(transfer_cost AS DOUBLE))
      comment: "Total cost of stock transfers including freight and handling. Key supply chain cost metric for network optimization decisions."
    - name: "avg_transfer_cost"
      expr: AVG(CAST(transfer_cost AS DOUBLE))
      comment: "Average cost per stock transfer. Used to benchmark transfer efficiency and identify high-cost routing patterns."
    - name: "total_inventory_cost_transferred"
      expr: SUM(CAST(inventory_cost_per_unit AS DOUBLE))
      comment: "Total inventory cost value transferred across nodes. Measures capital movement within the supply network."
    - name: "ship_from_store_transfer_count"
      expr: COUNT(CASE WHEN is_ship_from_store = TRUE THEN 1 END)
      comment: "Number of ship-from-store transfers. Measures omnichannel fulfillment program utilization."
    - name: "ship_from_store_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_ship_from_store = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers executed as ship-from-store. Tracks omnichannel fulfillment program adoption and capacity utilization."
    - name: "on_time_receipt_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_receipt_date <= expected_receipt_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_receipt_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of transfers received on or before the expected receipt date. Measures supply chain reliability and carrier performance."
    - name: "distinct_skus_transferred"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs transferred in the period. Measures breadth of inventory redistribution activity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_reorder_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reorder policy configuration and coverage metrics used by supply chain planners to assess replenishment policy health, safety stock adequacy, and auto-replenishment adoption across the SKU-location matrix."
  source: "`vibe_retail_v1`.`inventory`.`reorder_policy`"
  dimensions:
    - name: "location_id"
      expr: location_id
      comment: "Location covered by the reorder policy for geographic policy analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU covered by the reorder policy for item-level policy analysis."
    - name: "policy_status"
      expr: policy_status
      comment: "Status of the reorder policy (e.g. active, expired, suspended) for policy health monitoring."
    - name: "reorder_method"
      expr: reorder_method
      comment: "Replenishment method (e.g. min-max, reorder-point, days-of-supply) for methodology segmentation."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU for policy prioritization analysis."
    - name: "is_auto_replenishment"
      expr: is_auto_replenishment
      comment: "Indicates whether the policy uses automated replenishment for automation adoption tracking."
    - name: "is_vendor_managed"
      expr: is_vendor_managed
      comment: "Indicates vendor-managed inventory policies for VMI program analysis."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Indicates seasonal policies for seasonal planning analysis."
    - name: "location_type"
      expr: location_type
      comment: "Type of location (e.g. store, DC) for node-type policy segmentation."
    - name: "effective_date"
      expr: DATE_TRUNC('day', effective_date)
      comment: "Date the policy became effective for policy lifecycle analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the policy became effective for monthly policy coverage reporting."
  measures:
    - name: "total_active_policies"
      expr: COUNT(CASE WHEN policy_status = 'active' THEN 1 END)
      comment: "Number of active reorder policies. Measures replenishment program coverage across the SKU-location matrix."
    - name: "auto_replenishment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_auto_replenishment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of policies using automated replenishment. Higher automation rates reduce manual intervention costs and stockout risk."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity across policies. Used to assess buffer adequacy against demand variability."
    - name: "avg_target_days_of_supply"
      expr: AVG(CAST(target_days_of_supply AS DOUBLE))
      comment: "Average target days of supply across policies. Measures inventory coverage target and capital efficiency balance."
    - name: "avg_target_weeks_of_supply"
      expr: AVG(CAST(target_wos AS DOUBLE))
      comment: "Average target weeks of supply across policies. Used in executive inventory coverage reviews."
    - name: "avg_reorder_point_quantity"
      expr: AVG(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Average reorder point quantity across policies. Calibration metric for replenishment trigger sensitivity."
    - name: "total_min_stock_value"
      expr: SUM(CAST(min_stock_quantity AS DOUBLE))
      comment: "Total minimum stock quantity committed across all policies. Measures minimum inventory investment floor."
    - name: "total_max_stock_value"
      expr: SUM(CAST(max_stock_quantity AS DOUBLE))
      comment: "Total maximum stock quantity ceiling across all policies. Measures maximum inventory investment cap for working capital management."
    - name: "expired_policies"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE AND policy_status = 'active' THEN 1 END)
      comment: "Number of policies past their expiry date but still marked active. Indicates policy governance gaps requiring review."
    - name: "distinct_skus_with_policies"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with reorder policies. Measures replenishment program SKU coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_promo_stock_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional inventory allocation performance metrics tracking reservation accuracy, sell-through, and revenue generation from promotional stock programs. Used by merchandising and marketing to evaluate promotional inventory effectiveness."
  source: "`vibe_retail_v1`.`inventory`.`promo_stock_allocation`"
  dimensions:
    - name: "promo_offer_id"
      expr: promo_offer_id
      comment: "Promotional offer for offer-level allocation performance analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the promotional allocation (e.g. active, expired, sold-out) for program monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the promotional pricing for multi-currency analysis."
    - name: "offer_start_date"
      expr: DATE_TRUNC('day', offer_start_date)
      comment: "Start date of the promotional offer for time-based performance analysis."
    - name: "offer_month"
      expr: DATE_TRUNC('month', offer_start_date)
      comment: "Month the promotional offer started for monthly promotional performance reporting."
  measures:
    - name: "total_promotional_inventory_reserved"
      expr: SUM(CAST(promotional_inventory_reserve_qty AS DOUBLE))
      comment: "Total units reserved for promotional programs. Measures promotional inventory commitment volume."
    - name: "total_actual_units_sold"
      expr: SUM(CAST(actual_units_sold AS DOUBLE))
      comment: "Total units actually sold under promotional allocation. Measures promotional sell-through volume."
    - name: "total_promotional_revenue"
      expr: SUM(CAST(promotional_revenue AS DOUBLE))
      comment: "Total revenue generated from promotional stock allocations. Core promotional ROI metric for marketing and merchandising."
    - name: "promo_sell_through_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_units_sold AS DOUBLE)) / NULLIF(SUM(CAST(promotional_inventory_reserve_qty AS DOUBLE)), 0), 2)
      comment: "Percentage of reserved promotional inventory actually sold. Measures promotional inventory efficiency; low rates indicate over-allocation."
    - name: "avg_promotional_price"
      expr: AVG(CAST(promotional_price AS DOUBLE))
      comment: "Average promotional selling price across allocations. Used to assess promotional depth and margin impact."
    - name: "total_active_allocations"
      expr: COUNT(CASE WHEN allocation_status = 'active' THEN 1 END)
      comment: "Number of currently active promotional stock allocations. Measures live promotional program inventory exposure."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_asn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asn business metrics"
  source: "`vibe_retail_v1`.`inventory`.`asn`"
  dimensions:
    - name: "Actual Arrival Date"
      expr: actual_arrival_date
    - name: "Asn Number"
      expr: asn_number
    - name: "Asn Status"
      expr: asn_status
    - name: "Asn Type"
      expr: asn_type
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Node Type"
      expr: destination_node_type
    - name: "Discrepancy Flag"
      expr: discrepancy_flag
    - name: "Discrepancy Type"
      expr: discrepancy_type
    - name: "Dock Door Number"
      expr: dock_door_number
    - name: "Expected Arrival Date"
      expr: expected_arrival_date
    - name: "Freight Terms"
      expr: freight_terms
    - name: "Is Cross Dock"
      expr: is_cross_dock
    - name: "Is Rfid Enabled"
      expr: is_rfid_enabled
    - name: "Po Number"
      expr: po_number
    - name: "Pro Number"
      expr: pro_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asn"
      expr: COUNT(DISTINCT asn_id)
    - name: "Total Total Volume M3"
      expr: SUM(total_volume_m3)
    - name: "Average Total Volume M3"
      expr: AVG(total_volume_m3)
    - name: "Total Total Weight Kg"
      expr: SUM(total_weight_kg)
    - name: "Average Total Weight Kg"
      expr: AVG(total_weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_assortment_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment Deployment business metrics"
  source: "`vibe_retail_v1`.`inventory`.`assortment_deployment`"
  dimensions:
    - name: "Actual Sku Count"
      expr: actual_sku_count
    - name: "Deployment Completion Date"
      expr: deployment_completion_date
    - name: "Deployment Start Date"
      expr: deployment_start_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Implementation Status"
      expr: implementation_status
    - name: "Last Compliance Check Date"
      expr: last_compliance_check_date
    - name: "Notes"
      expr: notes
    - name: "Planned Sku Count"
      expr: planned_sku_count
    - name: "Deployment Completion Date Month"
      expr: DATE_TRUNC('MONTH', deployment_completion_date)
    - name: "Deployment Start Date Month"
      expr: DATE_TRUNC('MONTH', deployment_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assortment Deployment"
      expr: COUNT(DISTINCT assortment_deployment_id)
    - name: "Total Compliance Percentage"
      expr: SUM(compliance_percentage)
    - name: "Average Compliance Percentage"
      expr: AVG(compliance_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_inventory_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory Node business metrics"
  source: "`vibe_retail_v1`.`inventory`.`inventory_node`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "City"
      expr: city
    - name: "Close Date"
      expr: close_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cycle Count Frequency"
      expr: cycle_count_frequency
    - name: "District Code"
      expr: district_code
    - name: "Dock Door Count"
      expr: dock_door_count
    - name: "Format Code"
      expr: format_code
    - name: "Gln"
      expr: gln
    - name: "Is Bopis Enabled"
      expr: is_bopis_enabled
    - name: "Is Drop Ship Origin"
      expr: is_drop_ship_origin
    - name: "Is Rfid Enabled"
      expr: is_rfid_enabled
    - name: "Is Ropis Enabled"
      expr: is_ropis_enabled
    - name: "Is Ship From Store Enabled"
      expr: is_ship_from_store_enabled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inventory Node"
      expr: COUNT(DISTINCT inventory_node_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Selling Area Sqft"
      expr: SUM(selling_area_sqft)
    - name: "Average Selling Area Sqft"
      expr: AVG(selling_area_sqft)
    - name: "Total Total Storage Capacity Sqft"
      expr: SUM(total_storage_capacity_sqft)
    - name: "Average Total Storage Capacity Sqft"
      expr: AVG(total_storage_capacity_sqft)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_location_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Location Assignment business metrics"
  source: "`vibe_retail_v1`.`inventory`.`location_assignment`"
  dimensions:
    - name: "Access Level"
      expr: access_level
    - name: "Assignment End Date"
      expr: assignment_end_date
    - name: "Assignment Start Date"
      expr: assignment_start_date
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Primary Location Flag"
      expr: primary_location_flag
    - name: "Role At Location"
      expr: role_at_location
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Assignment End Date Month"
      expr: DATE_TRUNC('MONTH', assignment_end_date)
    - name: "Assignment Start Date Month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Location Assignment"
      expr: COUNT(DISTINCT location_assignment_id)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot business metrics"
  source: "`vibe_retail_v1`.`inventory`.`lot`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Best Before Date"
      expr: best_before_date
    - name: "Certification Code"
      expr: certification_code
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fefo Sequence"
      expr: fefo_sequence
    - name: "Gtin"
      expr: gtin
    - name: "Inspection Date"
      expr: inspection_date
    - name: "Inspection Result"
      expr: inspection_result
    - name: "Is Private Label"
      expr: is_private_label
    - name: "Is Recalled"
      expr: is_recalled
    - name: "Is Vendor Managed"
      expr: is_vendor_managed
    - name: "Lot Number"
      expr: lot_number
    - name: "Lot Status"
      expr: lot_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lot"
      expr: COUNT(DISTINCT lot_id)
    - name: "Total Available Quantity"
      expr: SUM(available_quantity)
    - name: "Average Available Quantity"
      expr: AVG(available_quantity)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_node_assortment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Node Assortment business metrics"
  source: "`vibe_retail_v1`.`inventory`.`node_assortment`"
  dimensions:
    - name: "Actual Sku Count"
      expr: actual_sku_count
    - name: "Assortment Status"
      expr: assortment_status
    - name: "Category Manager Override Name"
      expr: category_manager_override_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Local Assortment Override"
      expr: local_assortment_override
    - name: "Max Presentation Qty"
      expr: max_presentation_qty
    - name: "Min Presentation Qty"
      expr: min_presentation_qty
    - name: "Planogram Count"
      expr: planogram_count
    - name: "Replenishment Priority"
      expr: replenishment_priority
    - name: "Shelf Capacity Units"
      expr: shelf_capacity_units
    - name: "Target Sku Count"
      expr: target_sku_count
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Node Assortment"
      expr: COUNT(DISTINCT node_assortment_id)
    - name: "Total Space Allocation Sqft"
      expr: SUM(space_allocation_sqft)
    - name: "Average Space Allocation Sqft"
      expr: AVG(space_allocation_sqft)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reservation business metrics"
  source: "`vibe_retail_v1`.`inventory`.`reservation`"
  dimensions:
    - name: "Authorizing Department"
      expr: authorizing_department
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Encumbrance Type"
      expr: encumbrance_type
    - name: "Expiry Timestamp"
      expr: expiry_timestamp
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fulfillment Channel"
      expr: fulfillment_channel
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Hold Reason Description"
      expr: hold_reason_description
    - name: "Is Recalled"
      expr: is_recalled
    - name: "Is Vendor Managed"
      expr: is_vendor_managed
    - name: "Priority Level"
      expr: priority_level
    - name: "Release Notes"
      expr: release_notes
    - name: "Release Status"
      expr: release_status
    - name: "Release Timestamp"
      expr: release_timestamp
    - name: "Reservation Number"
      expr: reservation_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reservation"
      expr: COUNT(DISTINCT reservation_id)
    - name: "Total Case Reference Number"
      expr: SUM(case_reference_number)
    - name: "Average Case Reference Number"
      expr: AVG(case_reference_number)
    - name: "Total Inventory Cost Per Unit"
      expr: SUM(inventory_cost_per_unit)
    - name: "Average Inventory Cost Per Unit"
      expr: AVG(inventory_cost_per_unit)
    - name: "Total Reserved Quantity"
      expr: SUM(reserved_quantity)
    - name: "Average Reserved Quantity"
      expr: AVG(reserved_quantity)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_rfid_tag`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rfid Tag business metrics"
  source: "`vibe_retail_v1`.`inventory`.`rfid_tag`"
  dimensions:
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decommission Reason"
      expr: decommission_reason
    - name: "Decommission Timestamp"
      expr: decommission_timestamp
    - name: "Encoding Date"
      expr: encoding_date
    - name: "Encoding Standard"
      expr: encoding_standard
    - name: "Epc Code"
      expr: epc_code
    - name: "Epc Memory Bank Size"
      expr: epc_memory_bank_size
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Frequency Band"
      expr: frequency_band
    - name: "Gtin"
      expr: gtin
    - name: "Is Locked"
      expr: is_locked
    - name: "Is Password Protected"
      expr: is_password_protected
    - name: "Is Private Label"
      expr: is_private_label
    - name: "Is Recalled"
      expr: is_recalled
    - name: "Kill Password Set"
      expr: kill_password_set
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rfid Tag"
      expr: COUNT(DISTINCT rfid_tag_id)
    - name: "Total Signal Strength Dbm"
      expr: SUM(signal_strength_dbm)
    - name: "Average Signal Strength Dbm"
      expr: AVG(signal_strength_dbm)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`inventory_vmi_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vmi Agreement business metrics"
  source: "`vibe_retail_v1`.`inventory`.`vmi_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Auto Renewal"
      expr: auto_renewal
    - name: "Chargeback Enabled"
      expr: chargeback_enabled
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Edi Transaction Set"
      expr: edi_transaction_set
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Inventory Ownership"
      expr: inventory_ownership
    - name: "Inventory Visibility Method"
      expr: inventory_visibility_method
    - name: "Location Type"
      expr: location_type
    - name: "Max Inventory Units"
      expr: max_inventory_units
    - name: "Min Inventory Units"
      expr: min_inventory_units
    - name: "Moq"
      expr: moq
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vmi Agreement"
      expr: COUNT(DISTINCT vmi_agreement_id)
    - name: "Total Chargeback Rate Pct"
      expr: SUM(chargeback_rate_pct)
    - name: "Average Chargeback Rate Pct"
      expr: AVG(chargeback_rate_pct)
    - name: "Total Target Fill Rate Pct"
      expr: SUM(target_fill_rate_pct)
    - name: "Average Target Fill Rate Pct"
      expr: AVG(target_fill_rate_pct)
    - name: "Total Target Otd Rate Pct"
      expr: SUM(target_otd_rate_pct)
    - name: "Average Target Otd Rate Pct"
      expr: AVG(target_otd_rate_pct)
    - name: "Total Target Weeks Of Supply"
      expr: SUM(target_weeks_of_supply)
    - name: "Average Target Weeks Of Supply"
      expr: AVG(target_weeks_of_supply)
$$;