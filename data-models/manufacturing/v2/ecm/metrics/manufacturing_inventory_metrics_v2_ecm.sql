-- Metric views for domain: inventory | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory health metrics derived from stock balance snapshots. Tracks on-hand quantities, stock values, safety stock coverage, and variance from cycle counts to support inventory optimization and financial reporting decisions."
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "asset_plant_id"
      expr: asset_plant_id
      comment: "Plant identifier for cross-plant inventory comparison and regional analysis."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (unrestricted, blocked, quality inspection, etc.) for stock segmentation analysis."
    - name: "stock_category"
      expr: stock_category
      comment: "Category of stock for classification-based inventory reporting."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification (A/B/C) of the material for Pareto-based inventory prioritization."
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class for financial grouping of inventory by accounting category."
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock record (active, obsolete, slow-moving) for inventory health segmentation."
    - name: "slow_moving_indicator"
      expr: slow_moving_indicator
      comment: "Flag indicating slow-moving inventory items requiring management attention."
    - name: "obsolete_indicator"
      expr: obsolete_indicator
      comment: "Flag indicating obsolete inventory items for write-down and disposal decisions."
    - name: "period_end_snapshot_date"
      expr: DATE_TRUNC('month', period_end_snapshot_date)
      comment: "Month-level snapshot date for period-over-period inventory trend analysis."
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total financial value of inventory on hand. Core balance sheet metric used by CFO and supply chain leadership to assess working capital tied up in inventory."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical quantity of inventory on hand across all locations. Drives replenishment decisions and production planning."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for use or sale (on-hand minus reserved). Key metric for order fulfillment capability assessment."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for open orders. Indicates demand commitment against current stock."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held as buffer. Compared against on-hand to assess risk exposure to stockouts."
    - name: "avg_valuation_price"
      expr: AVG(CAST(valuation_price AS DOUBLE))
      comment: "Average valuation price per unit across stock records. Used for standard cost benchmarking and price variance analysis."
    - name: "total_last_count_variance_quantity"
      expr: SUM(CAST(last_count_variance_quantity AS DOUBLE))
      comment: "Total quantity variance identified during the last physical or cycle count. Measures inventory accuracy and shrinkage risk."
    - name: "stock_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand stock that is available (not reserved or blocked). Measures effective inventory utilization and fulfillment readiness."
    - name: "safety_stock_coverage_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_on_hand AS DOUBLE)) / NULLIF(SUM(CAST(safety_stock_quantity AS DOUBLE)), 0), 2)
      comment: "Ratio of on-hand quantity to safety stock target. Values below 100% indicate stockout risk; values far above 100% indicate excess inventory."
    - name: "slow_moving_stock_value"
      expr: SUM(CASE WHEN slow_moving_indicator = TRUE THEN total_stock_value ELSE 0 END)
      comment: "Total value of slow-moving inventory. Directly informs write-down provisions and inventory reduction initiatives."
    - name: "obsolete_stock_value"
      expr: SUM(CASE WHEN obsolete_indicator = TRUE THEN total_stock_value ELSE 0 END)
      comment: "Total value of obsolete inventory. Critical for financial provisioning and disposal cost planning."
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with active stock balances. Measures portfolio breadth and complexity of inventory management."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory flow and transaction metrics derived from stock movement events. Tracks goods receipts, goods issues, transfer quantities, and movement values to support throughput analysis, shrinkage detection, and supply chain performance management."
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_movement`"
  dimensions:
    - name: "inventory_plant_id"
      expr: inventory_plant_id
      comment: "Plant where the stock movement occurred for location-based throughput analysis."
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "ERP movement type code (e.g., 101=GR, 261=GI to production) for transaction-type segmentation."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type affected by the movement for quality and availability impact analysis."
    - name: "goods_receipt_indicator"
      expr: goods_receipt_indicator
      comment: "Flag indicating inbound goods receipt movements for inflow vs. outflow analysis."
    - name: "goods_issue_indicator"
      expr: goods_issue_indicator
      comment: "Flag indicating outbound goods issue movements for consumption and fulfillment analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating reversed/cancelled movements for error rate and correction volume tracking."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for period-over-period movement trend analysis."
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Reason code for the movement to identify root causes of adjustments and transfers."
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all movement types. Measures overall inventory throughput and activity volume."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CASE WHEN goods_receipt_indicator = TRUE THEN quantity ELSE 0 END)
      comment: "Total inbound goods receipt quantity. Tracks supply inflow and receiving performance."
    - name: "total_goods_issue_quantity"
      expr: SUM(CASE WHEN goods_issue_indicator = TRUE THEN quantity ELSE 0 END)
      comment: "Total outbound goods issue quantity. Measures consumption, fulfillment, and production supply throughput."
    - name: "total_reversal_quantity"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity in reversed movements. High reversal volumes indicate process errors or data quality issues requiring investigation."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of movements that are reversals. Key process quality indicator — high rates signal systemic posting errors."
    - name: "total_movement_transactions"
      expr: COUNT(1)
      comment: "Total number of stock movement transactions. Baseline activity volume metric for workload and throughput benchmarking."
    - name: "distinct_materials_moved"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with movement activity. Measures breadth of active inventory churn."
    - name: "distinct_plants_active"
      expr: COUNT(DISTINCT inventory_plant_id)
      comment: "Number of distinct plants with movement activity in the period. Indicates operational footprint activity."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial valuation metrics for inventory. Tracks standard vs. moving average prices, price variances, write-downs, and obsolescence provisions to support cost accounting, financial close, and inventory optimization decisions."
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "asset_plant_id"
      expr: asset_plant_id
      comment: "Plant for which valuation is recorded, enabling cross-plant cost comparison."
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class grouping materials by accounting category for financial reporting."
    - name: "price_control_method"
      expr: price_control_method
      comment: "Price control method (standard price vs. moving average) for cost accounting segmentation."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type for split valuation scenarios (e.g., by origin or quality grade)."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record for filtering active vs. historical valuations."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual inventory valuation trend analysis and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly financial close inventory valuation reporting."
    - name: "inventory_accounting_method"
      expr: inventory_accounting_method
      comment: "Accounting method (FIFO, LIFO, WAC) applied to this valuation for compliance and audit segmentation."
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total inventory value at current valuation prices. Primary balance sheet inventory figure used in financial close and audit."
    - name: "total_stock_quantity"
      expr: SUM(CAST(total_stock_quantity AS DOUBLE))
      comment: "Total quantity of stock covered by valuation records. Validates completeness of valuation coverage."
    - name: "total_price_variance_amount"
      expr: SUM(CAST(price_variance_amount AS DOUBLE))
      comment: "Total price variance between standard and actual costs. Key cost accounting KPI — large variances trigger cost review and standard price updates."
    - name: "total_inventory_write_down_amount"
      expr: SUM(CAST(inventory_write_down_amount AS DOUBLE))
      comment: "Total inventory write-down amount. Directly impacts P&L and signals excess or obsolete inventory requiring disposal action."
    - name: "total_provision_for_obsolescence"
      expr: SUM(CAST(provision_for_obsolescence AS DOUBLE))
      comment: "Total financial provision set aside for obsolete inventory. Critical for accurate balance sheet representation and risk management."
    - name: "total_cost_of_goods_sold"
      expr: SUM(CAST(cost_of_goods_sold_amount AS DOUBLE))
      comment: "Total cost of goods sold posted through inventory valuation. Core P&L metric linking inventory consumption to financial performance."
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price across valuation records. Tracks cost trend and identifies materials with significant price drift."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price across valuation records. Baseline for price variance analysis and cost benchmarking."
    - name: "price_variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(price_variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_stock_value AS DOUBLE)), 0), 2)
      comment: "Price variance as a percentage of total stock value. Measures cost control effectiveness — high rates indicate standard cost misalignment."
    - name: "write_down_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(inventory_write_down_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_stock_value AS DOUBLE)), 0), 2)
      comment: "Inventory write-down as a percentage of total stock value. Measures inventory quality risk and financial exposure from excess/obsolete stock."
    - name: "net_realizable_value_total"
      expr: SUM(CAST(net_realizable_value AS DOUBLE))
      comment: "Total net realizable value of inventory. Compared against book value to assess impairment risk under accounting standards."
    - name: "material_overhead_total"
      expr: SUM(CAST(material_overhead_amount AS DOUBLE))
      comment: "Total material overhead absorbed into inventory value. Tracks overhead absorption performance against budget."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy and cycle count performance metrics. Tracks count completion, variance rates, and tolerance compliance to support inventory accuracy programs and audit readiness."
  source: "`vibe_manufacturing_v1`.`inventory`.`cycle_count`"
  dimensions:
    - name: "inventory_plant_id"
      expr: inventory_plant_id
      comment: "Plant where the cycle count was performed for location-based accuracy benchmarking."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (full, cycle, spot) for segmenting accuracy results by count methodology."
    - name: "count_status"
      expr: count_status
      comment: "Current status of the cycle count (planned, in-progress, completed, posted) for pipeline monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the count for governance and audit trail tracking."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status indicating whether count variances have been posted to the ledger."
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Flag indicating counts that required a recount due to variance exceeding tolerance."
    - name: "count_date_month"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month of count date for trend analysis of inventory accuracy over time."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual inventory accuracy reporting and audit compliance."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification of counted materials for prioritized accuracy analysis."
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count events. Baseline metric for count program activity and compliance with count frequency targets."
    - name: "avg_accuracy_percentage"
      expr: AVG(CAST(accuracy_percentage AS DOUBLE))
      comment: "Average inventory accuracy percentage across cycle counts. Primary KPI for inventory accuracy programs — target typically 98%+ for A-class items."
    - name: "total_variance_quantity"
      expr: SUM(CAST(total_variance_quantity AS DOUBLE))
      comment: "Total quantity variance identified across all cycle counts. Measures absolute inventory discrepancy volume."
    - name: "total_variance_value"
      expr: SUM(CAST(total_variance_value AS DOUBLE))
      comment: "Total financial value of inventory variances. Directly impacts P&L through inventory adjustments and signals shrinkage or process failures."
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average tolerance percentage applied across cycle counts. Benchmarks stringency of accuracy standards across plants."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recount_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts requiring a recount. High recount rates indicate systemic accuracy problems or inadequate counting procedures."
    - name: "counts_below_target_accuracy"
      expr: SUM(CASE WHEN accuracy_percentage < 98.0 THEN 1 ELSE 0 END)
      comment: "Number of cycle counts with accuracy below 98% threshold. Identifies locations and periods requiring corrective action in inventory accuracy programs."
    - name: "avg_variance_value_per_count"
      expr: AVG(CAST(total_variance_value AS DOUBLE))
      comment: "Average financial variance per cycle count event. Normalizes variance impact for cross-plant and cross-period comparison."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_cycle_count_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level inventory accuracy metrics from cycle count results. Enables material-level accuracy analysis, variance root cause identification, and tolerance compliance tracking to drive targeted inventory improvement actions."
  source: "`vibe_manufacturing_v1`.`inventory`.`cycle_count_line`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the individual count line for pipeline and completion tracking."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type of the counted item for segmenting accuracy by stock category."
    - name: "recount_indicator"
      expr: recount_indicator
      comment: "Flag indicating lines that required a recount for accuracy problem identification."
    - name: "posting_indicator"
      expr: posting_indicator
      comment: "Flag indicating whether the variance has been posted to the ledger."
    - name: "count_date_month"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month of count date for trend analysis of line-level accuracy."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type of the counted material for financial impact segmentation."
  measures:
    - name: "total_count_lines"
      expr: COUNT(1)
      comment: "Total number of cycle count lines processed. Measures count program scope and throughput."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physical quantity counted across all lines. Validates count completeness against book inventory."
    - name: "total_book_quantity"
      expr: SUM(CAST(book_quantity AS DOUBLE))
      comment: "Total book (system) quantity at time of count. Baseline for variance calculation and accuracy assessment."
    - name: "total_difference_quantity"
      expr: SUM(CAST(difference_quantity AS DOUBLE))
      comment: "Total quantity difference (counted minus book) across all count lines. Measures absolute inventory discrepancy."
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average tolerance percentage applied at line level. Benchmarks accuracy standards applied to individual material counts."
    - name: "lines_with_variance"
      expr: SUM(CASE WHEN difference_quantity <> 0 THEN 1 ELSE 0 END)
      comment: "Number of count lines with a non-zero variance. Measures breadth of inventory discrepancy across the material portfolio."
    - name: "variance_line_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN difference_quantity <> 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of count lines with a variance. Key inventory accuracy KPI — high rates indicate systemic counting or system integrity issues."
    - name: "recount_line_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recount_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of count lines requiring a recount. Measures first-pass accuracy of counting procedures."
    - name: "distinct_materials_counted"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials counted. Measures coverage breadth of the cycle count program."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy effectiveness and coverage metrics. Tracks policy parameters, service level targets, and holding cost exposure to support inventory optimization and working capital reduction initiatives."
  source: "`vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Type of safety stock policy (fixed, dynamic, seasonal) for methodology segmentation."
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the policy (active, pending review, expired) for governance monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the policy for compliance and change management tracking."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the material for prioritized policy management."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ demand variability classification for combined ABC-XYZ policy segmentation."
    - name: "planning_strategy"
      expr: planning_strategy
      comment: "MRP/planning strategy applied for segmenting policy effectiveness by planning approach."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate safety stock (statistical, fixed, coverage-based) for methodology benchmarking."
    - name: "jit_enabled_flag"
      expr: jit_enabled_flag
      comment: "Flag indicating JIT-enabled materials for lean inventory policy segmentation."
    - name: "seasonal_adjustment_flag"
      expr: seasonal_adjustment_flag
      comment: "Flag indicating policies with seasonal adjustments for demand-driven policy analysis."
  measures:
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity mandated by active policies. Measures total buffer inventory investment required."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target across policies. Benchmarks the organization's overall inventory service commitment."
    - name: "total_holding_cost_per_year"
      expr: SUM(CAST(holding_cost_per_unit_per_year AS DOUBLE))
      comment: "Total annual holding cost across all safety stock policies. Quantifies the financial cost of maintaining safety buffers for working capital optimization."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point quantity across policies. Benchmarks replenishment trigger levels for supply chain responsiveness analysis."
    - name: "avg_demand_variability_factor"
      expr: AVG(CAST(demand_variability_factor AS DOUBLE))
      comment: "Average demand variability factor across policies. Higher values indicate greater demand uncertainty and safety stock investment requirements."
    - name: "total_stockout_cost_exposure"
      expr: SUM(CAST(stockout_cost_per_unit AS DOUBLE))
      comment: "Total stockout cost per unit across all policies. Quantifies the financial risk of stockout events to prioritize safety stock investments."
    - name: "policies_pending_review"
      expr: SUM(CASE WHEN next_review_date <= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of policies past their scheduled review date. Measures policy governance compliance and identifies stale safety stock parameters."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across policies. Informs lot sizing optimization and supplier negotiation strategies."
    - name: "distinct_materials_with_policy"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials covered by safety stock policies. Measures policy coverage breadth across the material portfolio."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order performance and cost metrics. Tracks order fulfillment rates, lead time adherence, and cost efficiency to support procurement and supply chain optimization decisions."
  source: "`vibe_manufacturing_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (open, in-transit, received, closed) for pipeline monitoring."
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Type of replenishment (purchase order, production order, transfer) for sourcing strategy analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the replenishment order for urgency-based performance analysis."
    - name: "source_type"
      expr: source_type
      comment: "Source type of the replenishment for make vs. buy and internal vs. external analysis."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Flag indicating orders requiring quality inspection upon receipt for quality-linked lead time analysis."
    - name: "requested_delivery_date_month"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month of requested delivery date for demand timing and seasonal replenishment analysis."
    - name: "asset_plant_id"
      expr: asset_plant_id
      comment: "Destination plant for the replenishment order for location-based supply performance analysis."
  measures:
    - name: "total_replenishment_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders. Baseline activity metric for supply chain workload and demand signal volume."
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total quantity requested across all replenishment orders. Measures aggregate demand signal for supply planning."
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity actually fulfilled. Compared against required quantity to measure supply fulfillment performance."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of replenishment orders. Tracks procurement spend commitment for budget management."
    - name: "order_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(required_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of required quantity that was fulfilled. Core supply chain KPI measuring replenishment effectiveness and supplier/production reliability."
    - name: "avg_lot_size_quantity"
      expr: AVG(CAST(lot_size_quantity AS DOUBLE))
      comment: "Average lot size per replenishment order. Benchmarks ordering efficiency and identifies opportunities for lot size optimization."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity referenced in replenishment orders. Measures buffer inventory demand driving replenishment activity."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved against open replenishment orders. Measures committed supply pipeline."
    - name: "distinct_suppliers_used"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers fulfilling replenishment orders. Measures supplier base breadth and single-source risk exposure."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_lot_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot and batch traceability and quality metrics. Tracks batch status, expiry risk, quantity availability, and quality decisions to support traceability compliance, shelf-life management, and quality-driven inventory decisions."
  source: "`vibe_manufacturing_v1`.`inventory`.`lot_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (unrestricted, blocked, quality inspection) for availability segmentation."
    - name: "quality_decision"
      expr: quality_decision
      comment: "Quality disposition decision (accept, reject, rework) for quality performance analysis."
    - name: "batch_classification"
      expr: batch_classification
      comment: "Classification of the batch for regulatory and quality segmentation."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating hazardous material batches for compliance and handling risk analysis."
    - name: "inventory_plant_id"
      expr: inventory_plant_id
      comment: "Plant where the batch is stored for location-based batch management analysis."
    - name: "goods_receipt_date_month"
      expr: DATE_TRUNC('month', goods_receipt_date)
      comment: "Month of goods receipt for inbound batch volume trend analysis."
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock indicator (consignment, project stock, etc.) for ownership and valuation segmentation."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of lot/batch records. Baseline metric for batch portfolio size and traceability scope."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available quantity across all batches. Measures usable inventory from a batch-managed perspective."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total blocked quantity across batches. Measures inventory held back due to quality or compliance issues."
    - name: "total_restricted_quantity"
      expr: SUM(CAST(restricted_quantity AS DOUBLE))
      comment: "Total restricted quantity across batches. Measures inventory under regulatory or quality hold."
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total quantity produced across all batches. Tracks production output volume for yield and throughput analysis."
    - name: "total_batch_cost"
      expr: SUM(CAST(batch_cost_amount AS DOUBLE))
      comment: "Total cost of all batches. Measures financial value of batch-managed inventory for working capital analysis."
    - name: "blocked_quantity_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(blocked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(available_quantity AS DOUBLE)) + SUM(CAST(blocked_quantity AS DOUBLE)) + SUM(CAST(restricted_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of total batch quantity that is blocked. High rates indicate quality or compliance issues reducing effective inventory availability."
    - name: "batches_near_expiry"
      expr: SUM(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND expiry_date >= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of batches expiring within 30 days. Critical for shelf-life management — drives urgent consumption or disposal decisions to prevent write-offs."
    - name: "expired_batch_count"
      expr: SUM(CASE WHEN expiry_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of batches past their expiry date. Measures inventory write-off risk and shelf-life management effectiveness."
    - name: "avg_batch_cost"
      expr: AVG(CAST(batch_cost_amount AS DOUBLE))
      comment: "Average cost per batch. Benchmarks batch production cost for standard cost validation and cost trend analysis."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_quarantine_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quarantine stock management and financial impact metrics. Tracks quarantine volumes, disposition decisions, and financial exposure to support quality management, regulatory compliance, and working capital risk assessment."
  source: "`vibe_manufacturing_v1`.`inventory`.`quarantine_stock`"
  dimensions:
    - name: "quarantine_status"
      expr: quarantine_status
      comment: "Current status of the quarantine record (open, released, disposed) for pipeline monitoring."
    - name: "quarantine_reason_code"
      expr: quarantine_reason_code
      comment: "Reason code for quarantine (quality failure, regulatory hold, supplier issue) for root cause analysis."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition decision (use-as-is, rework, scrap, return to supplier) for outcome analysis."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Flag indicating regulatory-mandated holds for compliance risk segmentation."
    - name: "inventory_plant_id"
      expr: inventory_plant_id
      comment: "Plant where quarantine stock is held for location-based quality risk analysis."
    - name: "quarantine_start_date_month"
      expr: DATE_TRUNC('month', quarantine_start_date)
      comment: "Month quarantine was initiated for trend analysis of quality incident frequency."
    - name: "initiating_document_type"
      expr: initiating_document_type
      comment: "Type of document that triggered the quarantine (NCR, customer complaint, inspection lot) for source analysis."
  measures:
    - name: "total_quarantine_records"
      expr: COUNT(1)
      comment: "Total number of quarantine stock records. Baseline metric for quality incident volume and quarantine program activity."
    - name: "total_quarantine_quantity"
      expr: SUM(CAST(quarantine_quantity AS DOUBLE))
      comment: "Total quantity of inventory in quarantine. Measures the volume of inventory unavailable due to quality or compliance issues."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of quarantined inventory. Quantifies the P&L and working capital risk from quality holds — critical for executive risk reporting."
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average financial impact per quarantine record. Benchmarks the cost severity of individual quality incidents."
    - name: "regulatory_hold_quantity"
      expr: SUM(CASE WHEN regulatory_hold_flag = TRUE THEN quarantine_quantity ELSE 0 END)
      comment: "Total quantity under regulatory hold. Measures compliance-driven inventory risk requiring immediate management attention."
    - name: "open_quarantine_records"
      expr: SUM(CASE WHEN quarantine_status = 'OPEN' THEN 1 ELSE 0 END)
      comment: "Number of open (unresolved) quarantine records. Measures backlog of quality decisions pending resolution."
    - name: "avg_quarantine_resolution_days"
      expr: AVG(DATEDIFF(actual_release_date, quarantine_start_date))
      comment: "Average number of days to resolve quarantine records. Measures quality disposition process efficiency — long cycle times increase working capital risk."
    - name: "distinct_suppliers_with_quarantine"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with quarantine events. Identifies suppliers with systemic quality issues requiring corrective action."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_wip_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work-in-process inventory cost and throughput metrics. Tracks WIP quantities, cost components, yield, and rework rates to support production efficiency analysis, cost control, and manufacturing performance management."
  source: "`vibe_manufacturing_v1`.`inventory`.`wip_stock`"
  dimensions:
    - name: "wip_status"
      expr: wip_status
      comment: "Current status of the WIP record (in-process, completed, scrapped, on-hold) for production pipeline monitoring."
    - name: "inventory_plant_id"
      expr: inventory_plant_id
      comment: "Plant where WIP is located for cross-plant production cost comparison."
    - name: "rework_required"
      expr: rework_required
      comment: "Flag indicating WIP requiring rework for quality-driven cost impact analysis."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating WIP pending quality inspection for throughput bottleneck analysis."
    - name: "production_start_date_month"
      expr: DATE_TRUNC('month', production_start_date)
      comment: "Month production started for WIP aging and throughput trend analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code of the WIP order for urgency-based production scheduling analysis."
  measures:
    - name: "total_wip_valuation_amount"
      expr: SUM(CAST(wip_valuation_amount AS DOUBLE))
      comment: "Total financial value of work-in-process inventory. Core balance sheet WIP figure used in financial close and production cost reporting."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost component of WIP. Measures raw material consumption value in production for cost of goods manufactured analysis."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component of WIP. Tracks direct labor absorption into production for workforce cost efficiency analysis."
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost AS DOUBLE))
      comment: "Total overhead cost component of WIP. Measures overhead absorption rate and identifies under/over-absorption issues."
    - name: "total_quantity_in_process"
      expr: SUM(CAST(quantity_in_process AS DOUBLE))
      comment: "Total quantity currently in production process. Measures active production volume and WIP pipeline size."
    - name: "total_quantity_completed"
      expr: SUM(CAST(quantity_completed AS DOUBLE))
      comment: "Total quantity completed from WIP. Measures production output and throughput performance."
    - name: "total_quantity_scrapped"
      expr: SUM(CAST(quantity_scrapped AS DOUBLE))
      comment: "Total quantity scrapped during production. Directly measures production waste and quality failure cost."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average production yield percentage across WIP records. Core manufacturing quality KPI — low yield drives scrap cost and capacity inefficiency."
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_scrapped AS DOUBLE)) / NULLIF(SUM(CAST(quantity_completed AS DOUBLE)) + SUM(CAST(quantity_scrapped AS DOUBLE)), 0), 2)
      comment: "Percentage of production output that was scrapped. Measures manufacturing quality and waste — high rates trigger process improvement investigations."
    - name: "rework_wip_value"
      expr: SUM(CASE WHEN rework_required = TRUE THEN wip_valuation_amount ELSE 0 END)
      comment: "Total WIP value requiring rework. Quantifies the financial cost of quality failures in production for corrective action prioritization."
    - name: "avg_wip_cost_per_unit"
      expr: AVG(CAST(wip_valuation_amount AS DOUBLE))
      comment: "Average WIP valuation amount per record. Benchmarks production cost per work order for standard cost validation."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity utilization and operational metrics. Tracks storage capacity, utilization rates, and facility characteristics to support network optimization, capacity planning, and logistics cost management decisions."
  source: "`vibe_manufacturing_v1`.`inventory`.`warehouse`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the warehouse (active, inactive, under maintenance) for network availability analysis."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of warehouse facility (distribution center, manufacturing warehouse, 3PL) for network segmentation."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (owned, leased, 3PL) for cost structure and make-vs-buy analysis."
    - name: "climate_controlled_flag"
      expr: climate_controlled_flag
      comment: "Flag indicating climate-controlled facilities for specialized storage capacity analysis."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Flag indicating hazmat-certified warehouses for compliance and specialized storage network analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the warehouse for geographic network analysis and regulatory compliance segmentation."
    - name: "automated_storage_flag"
      expr: automated_storage_flag
      comment: "Flag indicating automated storage and retrieval systems for technology investment and efficiency analysis."
  measures:
    - name: "total_warehouses"
      expr: COUNT(1)
      comment: "Total number of warehouse facilities. Baseline metric for network footprint size and coverage."
    - name: "total_capacity_cubic_meters"
      expr: SUM(CAST(total_capacity_cubic_meters AS DOUBLE))
      comment: "Total storage capacity across all warehouses in cubic meters. Measures aggregate network capacity for supply chain planning."
    - name: "total_usable_capacity_cubic_meters"
      expr: SUM(CAST(usable_capacity_cubic_meters AS DOUBLE))
      comment: "Total usable storage capacity after accounting for aisles and infrastructure. Measures effective capacity available for inventory storage."
    - name: "total_floor_area_sq_meters"
      expr: SUM(CAST(total_floor_area_square_meters AS DOUBLE))
      comment: "Total floor area across all warehouses. Measures physical footprint for real estate cost and capacity planning."
    - name: "total_storage_area_sq_meters"
      expr: SUM(CAST(storage_area_square_meters AS DOUBLE))
      comment: "Total dedicated storage area across warehouses. Measures net storage space for capacity utilization benchmarking."
    - name: "usable_capacity_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(usable_capacity_cubic_meters AS DOUBLE)) / NULLIF(SUM(CAST(total_capacity_cubic_meters AS DOUBLE)), 0), 2)
      comment: "Percentage of total capacity that is usable. Measures warehouse design efficiency and identifies facilities with poor space utilization."
    - name: "avg_temperature_range_max"
      expr: AVG(CAST(temperature_range_max_celsius AS DOUBLE))
      comment: "Average maximum temperature range across climate-controlled warehouses. Supports cold chain compliance monitoring."
    - name: "hazmat_certified_warehouse_count"
      expr: SUM(CASE WHEN hazmat_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of hazmat-certified warehouse facilities. Measures specialized storage network capacity for hazardous materials compliance."
$$;


CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_kanban_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kanban replenishment signal and lean inventory metrics. Tracks kanban card status, container quantities, lead times, and safety stock levels to support lean manufacturing and pull-system performance management."
  source: "`vibe_manufacturing_v1`.`inventory`.`kanban_card`"
  dimensions:
    - name: "kanban_card_status"
      expr: kanban_card_status
      comment: "Current status of the kanban card (empty, full, in-transit, blocked) for pull-system flow monitoring."
    - name: "replenishment_strategy"
      expr: replenishment_strategy
      comment: "Replenishment strategy (supplier, production, warehouse) for kanban sourcing analysis."
    - name: "signal_type"
      expr: signal_type
      comment: "Type of kanban signal (card, electronic, bin) for system maturity and digitization analysis."
    - name: "active_flag"
      expr: active_flag
      comment: "Flag indicating active kanban cards for filtering operational vs. inactive cards."
    - name: "priority"
      expr: priority
      comment: "Priority level of the kanban card for urgency-based replenishment analysis."
    - name: "asset_plant_id"
      expr: asset_plant_id
      comment: "Plant where the kanban card operates for location-based lean performance analysis."
  measures:
    - name: "total_kanban_cards"
      expr: COUNT(1)
      comment: "Total number of kanban cards. Baseline metric for lean system scope and pull-signal volume."
    - name: "active_kanban_cards"
      expr: SUM(CASE WHEN active_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of active kanban cards. Measures operational lean system coverage."
    - name: "total_container_quantity"
      expr: SUM(CAST(container_quantity AS DOUBLE))
      comment: "Total container quantity across all kanban cards. Measures total pull-system inventory buffer size."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held within kanban loops. Measures buffer inventory investment in lean replenishment systems."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days across kanban cards. Measures replenishment responsiveness — shorter lead times enable smaller kanban buffers and lower WIP."
    - name: "avg_minimum_lot_size"
      expr: AVG(CAST(minimum_lot_size AS DOUBLE))
      comment: "Average minimum lot size across kanban cards. Benchmarks ordering granularity for lean lot size optimization."
    - name: "avg_maximum_lot_size"
      expr: AVG(CAST(maximum_lot_size AS DOUBLE))
      comment: "Average maximum lot size across kanban cards. Measures upper bound of pull-system batch sizes for flow efficiency analysis."
    - name: "distinct_materials_in_kanban"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials managed via kanban. Measures lean system coverage across the material portfolio."
$$;
