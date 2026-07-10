-- Metric views for domain: inventory | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory position metrics tracking on-hand stock levels, availability, valuation, and safety stock coverage across materials, plants, and locations. Used by supply chain and finance leadership to manage working capital and prevent stockouts."
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (unrestricted, blocked, quality inspection, etc.) for segmenting inventory position."
    - name: "stock_category"
      expr: stock_category
      comment: "Category classification of stock for inventory segmentation and reporting."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the material (A=high value, B=medium, C=low) for prioritized inventory management."
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock record (active, obsolete, slow-moving) for inventory health analysis."
    - name: "valuation_currency"
      expr: valuation_currency
      comment: "Currency in which stock is valued, enabling multi-currency inventory reporting."
    - name: "special_stock_type"
      expr: special_stock_type
      comment: "Special stock category (consignment, project stock, etc.) for specialized inventory tracking."
    - name: "period_end_snapshot_date"
      expr: DATE_TRUNC('month', period_end_snapshot_date)
      comment: "Month of the period-end snapshot for trend analysis of inventory levels over time."
    - name: "obsolete_indicator"
      expr: obsolete_indicator
      comment: "Flag indicating whether the stock is marked as obsolete, used for write-down risk analysis."
    - name: "slow_moving_indicator"
      expr: slow_moving_indicator
      comment: "Flag indicating slow-moving stock, used to identify working capital tied up in stagnant inventory."
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total monetary value of inventory on hand. Core working capital KPI used by CFO and supply chain VP to assess inventory investment."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of stock on hand across all locations. Fundamental inventory position metric for supply planning."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for use or sale (on-hand minus reserved). Drives order fulfillment and production scheduling decisions."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for open orders or production. Indicates committed inventory that cannot be reallocated."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held as buffer. Used to assess risk coverage against demand variability."
    - name: "avg_valuation_price"
      expr: AVG(CAST(valuation_price AS DOUBLE))
      comment: "Average valuation price per unit across stock records. Used to monitor price drift and inventory cost trends."
    - name: "stock_below_safety_stock_count"
      expr: COUNT(CASE WHEN quantity_on_hand < safety_stock_quantity THEN 1 END)
      comment: "Number of stock records where on-hand quantity is below safety stock level. Critical risk indicator for potential stockouts requiring immediate replenishment action."
    - name: "obsolete_stock_value"
      expr: SUM(CASE WHEN obsolete_indicator = TRUE THEN total_stock_value ELSE 0 END)
      comment: "Total value of stock flagged as obsolete. Drives write-down decisions and working capital reduction initiatives."
    - name: "slow_moving_stock_value"
      expr: SUM(CASE WHEN slow_moving_indicator = TRUE THEN total_stock_value ELSE 0 END)
      comment: "Total value of slow-moving stock. Used by supply chain leadership to identify excess inventory and reduce carrying costs."
    - name: "last_count_variance_total"
      expr: SUM(CAST(last_count_variance_quantity AS DOUBLE))
      comment: "Sum of quantity variances from the last physical count. Measures inventory accuracy and identifies locations with systemic discrepancies."
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with active stock balances. Used to assess inventory breadth and complexity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory flow and transaction metrics tracking goods receipts, goods issues, transfers, and reversals. Used by operations and supply chain leadership to monitor inventory velocity, throughput, and accuracy."
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_movement`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "SAP-style movement type code (e.g., 101=GR, 261=GI to production) for classifying inventory transactions."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type affected by the movement (unrestricted, blocked, quality) for transaction segmentation."
    - name: "movement_status"
      expr: movement_status
      comment: "Status of the movement transaction (posted, reversed, pending) for transaction integrity monitoring."
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Reason code for the movement, enabling root cause analysis of inventory adjustments."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for trend analysis of inventory flow volumes over time."
    - name: "goods_receipt_indicator"
      expr: goods_receipt_indicator
      comment: "Flag indicating whether the movement is a goods receipt, used to segment inbound vs. outbound flows."
    - name: "goods_issue_indicator"
      expr: goods_issue_indicator
      comment: "Flag indicating whether the movement is a goods issue, used to segment outbound inventory flows."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating a reversal transaction. High reversal rates signal process or data quality issues."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the movement quantity, enabling consistent cross-material analysis."
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions. Measures inventory throughput and operational activity volume."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CASE WHEN goods_receipt_indicator = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity received into inventory. Key inbound supply chain throughput metric."
    - name: "total_goods_issue_quantity"
      expr: SUM(CASE WHEN goods_issue_indicator = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity issued from inventory (to production, customers, etc.). Measures consumption and fulfillment throughput."
    - name: "total_reversal_transactions"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed inventory transactions. High reversal counts indicate process errors, data quality issues, or fraud risk."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory transactions that are reversals. Operational quality KPI — high rates trigger process improvement investigations."
    - name: "total_movement_transactions"
      expr: COUNT(1)
      comment: "Total number of inventory movement transactions. Baseline activity volume metric for operational capacity planning."
    - name: "distinct_materials_moved"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with inventory movements in the period. Measures inventory activity breadth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy and cycle count program metrics. Used by warehouse operations and quality leadership to assess counting program effectiveness, variance rates, and inventory record accuracy."
  source: "`vibe_manufacturing_v1`.`inventory`.`cycle_count`"
  dimensions:
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (full, partial, ABC-based) for segmenting counting program performance."
    - name: "count_status"
      expr: count_status
      comment: "Current status of the cycle count (planned, in-progress, completed, approved) for pipeline monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the count results, used to track governance compliance of the counting program."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification of materials counted, enabling accuracy analysis by inventory criticality tier."
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (manual, scanner, RFID) to assess technology impact on accuracy."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of variance posting to the inventory ledger, tracking financial close completeness."
    - name: "count_date"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month of the count date for trend analysis of counting program activity and accuracy over time."
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Flag indicating a recount was required, used to measure first-pass accuracy of the counting program."
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count events executed. Measures counting program activity and coverage."
    - name: "avg_inventory_accuracy_pct"
      expr: AVG(CAST(accuracy_percentage AS DOUBLE))
      comment: "Average inventory record accuracy percentage across cycle counts. Primary KPI for inventory data quality — target typically 98%+."
    - name: "total_variance_quantity"
      expr: SUM(CAST(total_variance_quantity AS DOUBLE))
      comment: "Total quantity variance identified across all cycle counts. Measures the magnitude of inventory discrepancies."
    - name: "total_variance_value"
      expr: SUM(CAST(total_variance_value AS DOUBLE))
      comment: "Total financial value of inventory variances. Critical P&L impact metric reviewed by finance and operations leadership."
    - name: "total_items_counted"
      expr: SUM(CAST(total_items_counted AS DOUBLE))
      comment: "Total number of line items counted across all cycle count events. Measures counting program throughput."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts requiring a recount. High recount rates indicate counting process quality issues or systemic inventory discrepancies."
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average tolerance percentage applied across cycle counts. Used to assess whether counting standards are appropriately stringent."
    - name: "counts_with_variance"
      expr: COUNT(CASE WHEN total_variance_quantity > 0 THEN 1 END)
      comment: "Number of cycle counts that identified a non-zero variance. Measures the prevalence of inventory discrepancies."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_cycle_count_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level inventory accuracy metrics from cycle count results. Enables granular analysis of variance patterns by material, location, and stock type to drive targeted inventory accuracy improvement."
  source: "`vibe_manufacturing_v1`.`inventory`.`cycle_count_line`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the individual count line (counted, recounted, posted) for pipeline completeness tracking."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type of the counted item for segmenting accuracy by inventory category."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the counted material, enabling consistent cross-material variance analysis."
    - name: "recount_indicator"
      expr: recount_indicator
      comment: "Flag indicating this line required a recount, used to identify materials with persistent accuracy issues."
    - name: "posting_indicator"
      expr: posting_indicator
      comment: "Flag indicating whether the variance has been posted to the inventory ledger."
    - name: "count_date"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month of the count date for trend analysis of line-level accuracy over time."
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Reason code assigned to the variance, enabling root cause analysis of inventory discrepancies."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type of the counted stock for financial impact segmentation."
  measures:
    - name: "total_book_quantity"
      expr: SUM(CAST(book_quantity AS DOUBLE))
      comment: "Total book (system) quantity across all count lines. Baseline for measuring inventory record accuracy."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physically counted quantity. Compared against book quantity to determine inventory accuracy."
    - name: "total_difference_quantity"
      expr: SUM(CAST(difference_quantity AS DOUBLE))
      comment: "Total quantity difference (counted minus book) across all count lines. Measures aggregate inventory discrepancy."
    - name: "abs_difference_quantity"
      expr: SUM(ABS(difference_quantity))
      comment: "Sum of absolute quantity differences, eliminating positive/negative netting. True measure of inventory inaccuracy magnitude."
    - name: "line_accuracy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN difference_quantity = 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of count lines with zero variance (perfect accuracy). Primary inventory accuracy KPI at line level — target typically 98%+."
    - name: "recount_line_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of count lines requiring a recount. Identifies materials and locations with persistent accuracy problems."
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average tolerance percentage applied at line level. Used to assess counting standard stringency."
    - name: "distinct_materials_with_variance"
      expr: COUNT(DISTINCT CASE WHEN difference_quantity <> 0 THEN material_master_id END)
      comment: "Number of distinct materials with non-zero variance. Identifies breadth of inventory accuracy issues across the material portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory valuation and financial metrics tracking stock value, price variances, write-downs, and cost of goods sold. Used by finance and supply chain leadership to manage inventory-related P&L impacts and working capital."
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type (standard price, moving average) for segmenting inventory cost methodology."
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class grouping materials by accounting treatment for financial reporting segmentation."
    - name: "valuation_category"
      expr: valuation_category
      comment: "Category of valuation for multi-level inventory cost analysis."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record (active, closed, adjusted) for financial period management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the valuation record for year-over-year inventory cost trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly inventory valuation trend analysis."
    - name: "inventory_accounting_method"
      expr: inventory_accounting_method
      comment: "Accounting method (FIFO, LIFO, WAC) applied to the inventory valuation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the valuation for multi-currency financial reporting."
    - name: "is_consignment_stock"
      expr: is_consignment_stock
      comment: "Flag indicating consignment stock, which has different ownership and financial treatment."
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total inventory value on the books. Primary working capital metric reviewed by CFO and supply chain VP."
    - name: "total_stock_quantity"
      expr: SUM(CAST(total_stock_quantity AS DOUBLE))
      comment: "Total stock quantity across all valuation records. Used to reconcile physical and financial inventory positions."
    - name: "total_cogs_amount"
      expr: SUM(CAST(cost_of_goods_sold_amount AS DOUBLE))
      comment: "Total cost of goods sold from inventory. Core P&L metric linking inventory consumption to financial performance."
    - name: "total_price_variance_amount"
      expr: SUM(CAST(price_variance_amount AS DOUBLE))
      comment: "Total price variance between standard and actual cost. Measures procurement and production cost efficiency vs. plan."
    - name: "total_inventory_write_down"
      expr: SUM(CAST(inventory_write_down_amount AS DOUBLE))
      comment: "Total inventory write-down amount. Measures financial impact of obsolete or damaged stock — directly impacts P&L."
    - name: "total_provision_for_obsolescence"
      expr: SUM(CAST(provision_for_obsolescence AS DOUBLE))
      comment: "Total provision held for obsolete inventory. Forward-looking risk metric for inventory-related financial exposure."
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price across materials. Tracks cost trend and identifies materials with significant price drift."
    - name: "avg_price_change_percentage"
      expr: AVG(CAST(price_change_percentage AS DOUBLE))
      comment: "Average percentage price change across valuation records. Measures cost inflation/deflation trends in inventory."
    - name: "total_net_realizable_value"
      expr: SUM(CAST(net_realizable_value AS DOUBLE))
      comment: "Total net realizable value of inventory. Used to assess whether inventory is carried above market value, triggering write-down requirements."
    - name: "total_material_overhead_amount"
      expr: SUM(CAST(material_overhead_amount AS DOUBLE))
      comment: "Total material overhead absorbed into inventory value. Used to assess overhead absorption rates and manufacturing cost accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order performance metrics tracking order fulfillment, lead times, and supply reliability. Used by supply chain and procurement leadership to optimize replenishment processes and reduce stockout risk."
  source: "`vibe_manufacturing_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (open, confirmed, delivered, closed) for pipeline management."
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Type of replenishment (purchase order, production order, transfer) for segmenting supply source performance."
    - name: "priority"
      expr: priority
      comment: "Priority level of the replenishment order for analyzing urgency distribution and expediting patterns."
    - name: "source_type"
      expr: source_type
      comment: "Source type of the replenishment (internal, external, intercompany) for supply network analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for replenishment quantities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the replenishment order cost for financial analysis."
    - name: "requested_delivery_date"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month of requested delivery date for demand timing analysis."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Flag indicating whether incoming replenishment requires quality inspection, affecting lead time planning."
  measures:
    - name: "total_replenishment_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders. Baseline activity metric for supply chain workload assessment."
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total quantity required across all replenishment orders. Measures aggregate demand on the supply network."
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled from replenishment orders. Measures supply delivery performance."
    - name: "replenishment_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(required_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of required replenishment quantity that has been fulfilled. Key supply reliability KPI — low fill rates signal supply chain risk."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of replenishment orders. Used for procurement budget management and working capital planning."
    - name: "avg_lot_size_quantity"
      expr: AVG(CAST(lot_size_quantity AS DOUBLE))
      comment: "Average lot size of replenishment orders. Used to optimize order quantities and reduce ordering costs."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity covered by replenishment orders. Measures buffer stock replenishment activity."
    - name: "open_replenishment_orders"
      expr: COUNT(CASE WHEN order_status NOT IN ('closed', 'cancelled') THEN 1 END)
      comment: "Number of open replenishment orders. Measures current supply pipeline depth and workload."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_lot_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot and batch traceability metrics tracking batch status, quality decisions, shelf life, and financial value. Used by quality, supply chain, and compliance leadership to manage batch risk and traceability."
  source: "`vibe_manufacturing_v1`.`inventory`.`lot_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (unrestricted, blocked, restricted, expired) for inventory availability analysis."
    - name: "quality_decision"
      expr: quality_decision
      comment: "Quality disposition decision (accepted, rejected, conditional release) for batch quality performance tracking."
    - name: "batch_classification"
      expr: batch_classification
      comment: "Classification of the batch for segmented quality and traceability reporting."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating hazardous material batches requiring special handling and compliance tracking."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for trade compliance and supply chain risk analysis."
    - name: "goods_receipt_date"
      expr: DATE_TRUNC('month', goods_receipt_date)
      comment: "Month of goods receipt for batch intake trend analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for batch quantities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of batch cost valuation."
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock indicator for batches held under special conditions (consignment, project, etc.)."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of lot/batch records. Baseline traceability coverage metric."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available quantity across all batches. Measures usable inventory from a batch perspective."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked across batches. Measures inventory at risk due to quality holds or other restrictions."
    - name: "total_restricted_quantity"
      expr: SUM(CAST(restricted_quantity AS DOUBLE))
      comment: "Total quantity under restricted use across batches. Indicates inventory with conditional availability."
    - name: "total_batch_cost_value"
      expr: SUM(CAST(batch_cost_amount AS DOUBLE))
      comment: "Total financial value of all batches. Used for inventory valuation and working capital management."
    - name: "batch_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_decision = 'rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches rejected by quality. Key supplier and production quality KPI — high rates trigger supplier development or process improvement actions."
    - name: "expiring_batches_30d"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND expiry_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of batches expiring within 30 days. Urgent inventory risk metric requiring immediate action to consume or dispose."
    - name: "expired_batch_value"
      expr: SUM(CASE WHEN expiry_date < CURRENT_DATE() THEN batch_cost_amount ELSE 0 END)
      comment: "Total financial value of expired batches. Measures write-off exposure from expired inventory — direct P&L impact."
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total quantity produced across all batches. Measures production output tracked at batch level."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy effectiveness metrics tracking coverage levels, service targets, and policy compliance. Used by supply chain planning leadership to optimize buffer stock investment and service level performance."
  source: "`vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Type of safety stock policy (fixed quantity, dynamic, time-based) for segmenting policy approach effectiveness."
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the policy (active, expired, under review) for policy governance tracking."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of materials covered by the policy for prioritized safety stock management."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ demand variability classification for safety stock policy segmentation."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate safety stock (statistical, fixed, coverage-based) for methodology effectiveness analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the policy for governance compliance tracking."
    - name: "jit_enabled_flag"
      expr: jit_enabled_flag
      comment: "Flag indicating JIT-enabled policies, used to segment lean vs. buffer-based supply strategies."
    - name: "seasonal_adjustment_flag"
      expr: seasonal_adjustment_flag
      comment: "Flag indicating policies with seasonal adjustments, used to assess demand-responsive planning coverage."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the policy became effective for policy lifecycle trend analysis."
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of safety stock policies. Measures planning coverage breadth across the material portfolio."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity per policy. Used to benchmark buffer levels across material categories."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity mandated by policies. Measures aggregate buffer inventory investment."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target across policies. Measures the ambition of the safety stock program — typically 95-99% for critical materials."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point quantity across policies. Used to assess replenishment trigger levels relative to demand."
    - name: "total_holding_cost_per_year"
      expr: SUM(CAST(holding_cost_per_unit_per_year AS DOUBLE))
      comment: "Total annual holding cost across all safety stock policies. Measures the financial cost of the buffer inventory program."
    - name: "avg_demand_variability_factor"
      expr: AVG(CAST(demand_variability_factor AS DOUBLE))
      comment: "Average demand variability factor across policies. Higher values indicate more volatile demand requiring larger safety buffers."
    - name: "total_stockout_cost_exposure"
      expr: SUM(CAST(stockout_cost_per_unit AS DOUBLE))
      comment: "Total stockout cost per unit across policies. Measures the financial risk of inadequate safety stock coverage."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across policies. Used to assess ordering constraint impact on inventory levels."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_quarantine_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quarantine stock management metrics tracking blocked inventory value, disposition decisions, and resolution cycle times. Used by quality and supply chain leadership to minimize financial exposure from non-conforming inventory."
  source: "`vibe_manufacturing_v1`.`inventory`.`quarantine_stock`"
  dimensions:
    - name: "quarantine_status"
      expr: quarantine_status
      comment: "Current status of the quarantine record (active, released, disposed, scrapped) for pipeline management."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision (use-as-is, rework, scrap, return to supplier) for quality outcome analysis."
    - name: "quarantine_reason_code"
      expr: quarantine_reason_code
      comment: "Reason code for quarantine (incoming inspection failure, production defect, customer return) for root cause analysis."
    - name: "initiating_document_type"
      expr: initiating_document_type
      comment: "Type of document that triggered the quarantine (NCR, customer complaint, inspection lot) for source analysis."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Flag indicating regulatory-mandated holds, which have compliance implications beyond standard quality holds."
    - name: "quarantine_start_date"
      expr: DATE_TRUNC('month', quarantine_start_date)
      comment: "Month quarantine was initiated for trend analysis of quarantine activity over time."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quarantine quantities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the financial impact estimate for quarantine records."
  measures:
    - name: "total_quarantine_records"
      expr: COUNT(1)
      comment: "Total number of active quarantine records. Measures the volume of non-conforming inventory requiring disposition."
    - name: "total_quarantine_quantity"
      expr: SUM(CAST(quarantine_quantity AS DOUBLE))
      comment: "Total quantity of stock in quarantine. Measures the volume of inventory blocked from use."
    - name: "total_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of quarantined stock. Critical risk metric for finance and quality leadership — drives disposition urgency."
    - name: "regulatory_hold_count"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Number of quarantine records with regulatory holds. Compliance risk metric requiring immediate escalation and resolution."
    - name: "scrap_disposition_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disposition_decision = 'scrap' THEN 1 END) / NULLIF(COUNT(CASE WHEN disposition_decision IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of disposed quarantine records resulting in scrap. High scrap rates indicate systemic quality or supplier issues with direct cost impact."
    - name: "open_quarantine_financial_exposure"
      expr: SUM(CASE WHEN quarantine_status = 'active' THEN estimated_financial_impact ELSE 0 END)
      comment: "Total financial exposure from currently open quarantine records. Measures unresolved inventory risk on the balance sheet."
    - name: "distinct_materials_in_quarantine"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials currently in quarantine. Measures breadth of quality issues across the material portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_kanban_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kanban replenishment system performance metrics tracking card status, cycle times, and lot sizing. Used by production and supply chain leadership to optimize lean replenishment flows and identify kanban system inefficiencies."
  source: "`vibe_manufacturing_v1`.`inventory`.`kanban_card`"
  dimensions:
    - name: "kanban_card_status"
      expr: kanban_card_status
      comment: "Current status of the kanban card (empty, full, in-transit, blocked) for replenishment pipeline monitoring."
    - name: "signal_type"
      expr: signal_type
      comment: "Type of kanban signal (card, electronic, RFID) for system technology segmentation."
    - name: "replenishment_strategy"
      expr: replenishment_strategy
      comment: "Replenishment strategy associated with the kanban card for supply method analysis."
    - name: "container_type"
      expr: container_type
      comment: "Type of container used in the kanban loop for material handling analysis."
    - name: "active_flag"
      expr: active_flag
      comment: "Flag indicating whether the kanban card is currently active in the replenishment system."
    - name: "priority"
      expr: priority
      comment: "Priority level of the kanban card for urgency-based replenishment analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for kanban quantities."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the kanban card became effective for system evolution tracking."
  measures:
    - name: "total_kanban_cards"
      expr: COUNT(1)
      comment: "Total number of kanban cards in the system. Measures lean replenishment system scale."
    - name: "active_kanban_cards"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Number of currently active kanban cards. Measures the active lean replenishment footprint."
    - name: "total_container_quantity"
      expr: SUM(CAST(container_quantity AS DOUBLE))
      comment: "Total container quantity across all kanban cards. Measures aggregate kanban inventory buffer size."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days across kanban cards. Key lean metric — shorter lead times enable smaller kanban quantities and less WIP."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held within kanban loops. Measures buffer inventory in the lean replenishment system."
    - name: "avg_minimum_lot_size"
      expr: AVG(CAST(minimum_lot_size AS DOUBLE))
      comment: "Average minimum lot size across kanban cards. Used to assess ordering constraint impact on kanban loop efficiency."
    - name: "avg_maximum_lot_size"
      expr: AVG(CAST(maximum_lot_size AS DOUBLE))
      comment: "Average maximum lot size across kanban cards. Used to assess upper bound on kanban replenishment quantities."
    - name: "blocked_kanban_cards"
      expr: COUNT(CASE WHEN kanban_card_status = 'blocked' THEN 1 END)
      comment: "Number of blocked kanban cards. Blocked cards indicate supply disruptions in the lean replenishment system requiring immediate resolution."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_wip_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work-in-process inventory metrics tracking WIP value, yield, rework rates, and production progress. Used by production and finance leadership to manage WIP investment, identify bottlenecks, and improve manufacturing efficiency."
  source: "`vibe_manufacturing_v1`.`inventory`.`wip_stock`"
  dimensions:
    - name: "wip_status"
      expr: wip_status
      comment: "Current status of the WIP record (in-process, on-hold, completed, scrapped) for production pipeline monitoring."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code of the WIP order for urgency-based production management."
    - name: "shift_code"
      expr: shift_code
      comment: "Production shift associated with the WIP for shift-level performance analysis."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for WIP holds, enabling root cause analysis of production stoppages."
    - name: "rework_required"
      expr: rework_required
      comment: "Flag indicating WIP requiring rework, used to measure rework prevalence and associated cost."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating WIP requiring quality inspection before completion."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for WIP quantities."
    - name: "production_start_date"
      expr: DATE_TRUNC('month', production_start_date)
      comment: "Month production started for WIP aging and throughput trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of WIP cost valuation."
  measures:
    - name: "total_wip_valuation_amount"
      expr: SUM(CAST(wip_valuation_amount AS DOUBLE))
      comment: "Total financial value of work-in-process inventory. Core working capital metric — high WIP values indicate production bottlenecks or long cycle times."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost absorbed into WIP. Used to track material consumption efficiency in production."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost absorbed into WIP. Used to assess labor efficiency and production cost structure."
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost AS DOUBLE))
      comment: "Total overhead cost absorbed into WIP. Used to assess overhead absorption rates and manufacturing cost accuracy."
    - name: "total_quantity_in_process"
      expr: SUM(CAST(quantity_in_process AS DOUBLE))
      comment: "Total quantity currently in production process. Measures production pipeline volume and throughput capacity utilization."
    - name: "total_quantity_completed"
      expr: SUM(CAST(quantity_completed AS DOUBLE))
      comment: "Total quantity completed from WIP. Measures production output and throughput performance."
    - name: "total_quantity_scrapped"
      expr: SUM(CAST(quantity_scrapped AS DOUBLE))
      comment: "Total quantity scrapped during production. Measures waste and quality losses with direct cost impact."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average production yield percentage across WIP records. Key manufacturing efficiency KPI — low yields indicate quality or process problems."
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of WIP records requiring rework. Measures production quality and process capability — high rework rates drive cost and cycle time increases."
    - name: "wip_on_hold_value"
      expr: SUM(CASE WHEN hold_reason_code IS NOT NULL THEN wip_valuation_amount ELSE 0 END)
      comment: "Total value of WIP currently on hold. Measures financial exposure from production stoppages requiring management intervention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_material_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material master data quality and portfolio metrics. Used by supply chain and data governance leadership to assess material portfolio composition, data completeness, and inventory policy coverage."
  source: "`vibe_manufacturing_v1`.`inventory`.`material_master`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Type of material (raw material, semi-finished, finished goods, trading goods) for portfolio segmentation."
    - name: "material_group"
      expr: material_group
      comment: "Material group classification for category-level portfolio analysis."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification of the material for prioritized inventory management analysis."
    - name: "material_status"
      expr: material_status
      comment: "Current status of the material master (active, blocked, discontinued) for portfolio health monitoring."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP type (consumption-based, MRP, manual) for planning strategy segmentation."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (in-house, external, both) for make-vs-buy analysis."
    - name: "hazardous_material_indicator"
      expr: hazardous_material_indicator
      comment: "Flag indicating hazardous materials requiring special handling and compliance management."
    - name: "batch_management_indicator"
      expr: batch_management_indicator
      comment: "Flag indicating batch-managed materials for traceability coverage analysis."
    - name: "created_date"
      expr: DATE_TRUNC('year', created_date)
      comment: "Year the material master was created for portfolio age and lifecycle analysis."
  measures:
    - name: "total_materials"
      expr: COUNT(1)
      comment: "Total number of material master records. Measures portfolio size and complexity."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price across materials. Used to benchmark material cost levels and identify pricing outliers."
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price across materials. Tracks actual cost trends vs. standard price."
    - name: "avg_safety_stock"
      expr: AVG(CAST(safety_stock AS DOUBLE))
      comment: "Average safety stock quantity across materials. Used to assess aggregate buffer inventory policy."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point across materials. Used to assess replenishment trigger levels relative to demand patterns."
    - name: "avg_gross_weight"
      expr: AVG(CAST(gross_weight AS DOUBLE))
      comment: "Average gross weight of materials. Used for logistics capacity planning and freight cost estimation."
    - name: "hazardous_material_count"
      expr: COUNT(CASE WHEN hazardous_material_indicator = TRUE THEN 1 END)
      comment: "Number of hazardous materials in the portfolio. Compliance risk metric for EHS management and regulatory reporting."
    - name: "batch_managed_material_count"
      expr: COUNT(CASE WHEN batch_management_indicator = TRUE THEN 1 END)
      comment: "Number of batch-managed materials. Measures traceability program scope and associated data management complexity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity and capability metrics tracking storage utilization, certifications, and operational characteristics. Used by logistics and operations leadership to optimize warehouse network capacity and compliance."
  source: "`vibe_manufacturing_v1`.`inventory`.`warehouse`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of warehouse facility (distribution center, manufacturing warehouse, cold storage) for network segmentation."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (owned, leased, 3PL) for make-vs-buy analysis of warehouse network."
    - name: "country_code"
      expr: country_code
      comment: "Country of the warehouse for geographic network analysis."
    - name: "climate_controlled_flag"
      expr: climate_controlled_flag
      comment: "Flag indicating climate-controlled warehouses for specialized storage capability analysis."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Flag indicating hazmat-certified warehouses for compliance capability tracking."
    - name: "customs_bonded_flag"
      expr: customs_bonded_flag
      comment: "Flag indicating customs-bonded warehouses for trade compliance network analysis."
    - name: "automated_storage_flag"
      expr: automated_storage_flag
      comment: "Flag indicating automated storage systems for technology investment and efficiency analysis."
    - name: "active_from_date"
      expr: DATE_TRUNC('year', active_from_date)
      comment: "Year the warehouse became active for network age and investment planning."
  measures:
    - name: "total_warehouses"
      expr: COUNT(1)
      comment: "Total number of warehouses in the network. Baseline network scale metric."
    - name: "total_storage_area_sqm"
      expr: SUM(CAST(storage_area_square_meters AS DOUBLE))
      comment: "Total storage area in square meters across the warehouse network. Measures physical capacity of the distribution network."
    - name: "total_capacity_cubic_meters"
      expr: SUM(CAST(total_capacity_cubic_meters AS DOUBLE))
      comment: "Total volumetric capacity across all warehouses. Used for network capacity planning and utilization analysis."
    - name: "total_usable_capacity_cubic_meters"
      expr: SUM(CAST(usable_capacity_cubic_meters AS DOUBLE))
      comment: "Total usable volumetric capacity across warehouses. Measures effective storage capacity available for inventory."
    - name: "avg_temperature_range_max"
      expr: AVG(CAST(temperature_range_max_celsius AS DOUBLE))
      comment: "Average maximum temperature range across warehouses. Used for cold chain capability assessment."
    - name: "hazmat_certified_warehouse_count"
      expr: COUNT(CASE WHEN hazmat_certified_flag = TRUE THEN 1 END)
      comment: "Number of hazmat-certified warehouses. Measures compliance capability for hazardous material storage across the network."
    - name: "automated_warehouse_count"
      expr: COUNT(CASE WHEN automated_storage_flag = TRUE THEN 1 END)
      comment: "Number of warehouses with automated storage systems. Measures technology investment and automation coverage in the network."
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(total_floor_area_square_meters AS DOUBLE))
      comment: "Total floor area across all warehouses. Used for facility cost allocation and capacity planning."
$$;