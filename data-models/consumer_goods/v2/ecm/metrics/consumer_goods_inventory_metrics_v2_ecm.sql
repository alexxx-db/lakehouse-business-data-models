-- Metric views for domain: inventory | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory position metrics tracking on-hand, available, reserved, and blocked quantities with valuation and risk indicators for inventory optimization and working capital management."
  source: "`vibe_consumer_goods_v1`.`inventory`.`stock_position`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock position (e.g., active, obsolete, quarantine)"
    - name: "stock_type"
      expr: stock_type
      comment: "Type classification of stock (e.g., finished goods, raw materials, WIP)"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation method applied to this stock position (e.g., standard cost, moving average)"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicator for special stock categories (e.g., consignment, project stock)"
    - name: "stock_rotation_rule"
      expr: stock_rotation_rule
      comment: "Rotation rule applied (e.g., FIFO, FEFO, LIFO) for inventory movement"
    - name: "obsolete_flag"
      expr: obsolete_flag
      comment: "Flag indicating whether stock is marked as obsolete"
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Flag indicating whether stock is under quarantine hold"
    - name: "recall_hold_flag"
      expr: recall_hold_flag
      comment: "Flag indicating whether stock is held due to recall"
    - name: "oos_risk_flag"
      expr: oos_risk_flag
      comment: "Flag indicating high risk of out-of-stock condition"
    - name: "slow_moving_flag"
      expr: slow_moving_flag
      comment: "Flag indicating slow-moving inventory requiring attention"
    - name: "vmi_replenishment_flag"
      expr: vmi_replenishment_flag
      comment: "Flag indicating stock managed under vendor-managed inventory agreement"
    - name: "goods_receipt_month"
      expr: DATE_TRUNC('MONTH', goods_receipt_date)
      comment: "Month when goods were received into inventory"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month when stock is set to expire"
    - name: "manufacturing_month"
      expr: DATE_TRUNC('MONTH', manufacturing_date)
      comment: "Month when the product was manufactured"
    - name: "last_movement_month"
      expr: DATE_TRUNC('MONTH', last_goods_movement_date)
      comment: "Month of last goods movement activity"
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity physically on hand across all stock positions"
    - name: "total_unrestricted_quantity"
      expr: SUM(CAST(unrestricted_quantity AS DOUBLE))
      comment: "Total unrestricted quantity available for use without holds or restrictions"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for specific orders or production"
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked from use due to quality or compliance issues"
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit between locations"
    - name: "total_quality_inspection_quantity"
      expr: SUM(CAST(quality_inspection_quantity AS DOUBLE))
      comment: "Total quantity currently under quality inspection"
    - name: "total_available_to_promise"
      expr: SUM(CAST(available_to_promise_quantity AS DOUBLE))
      comment: "Total quantity available to promise to customers for future orders"
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity maintained as buffer against demand variability"
    - name: "total_stock_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of all stock positions at current valuation"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across stock positions"
    - name: "avg_days_inventory_outstanding"
      expr: AVG(CAST(days_inventory_outstanding AS DOUBLE))
      comment: "Average days inventory outstanding indicating how long stock has been held"
    - name: "inventory_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(unrestricted_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is unrestricted and available for use"
    - name: "inventory_utilization_rate"
      expr: ROUND(100.0 * (SUM(CAST(reserved_quantity AS DOUBLE)) + SUM(CAST(blocked_quantity AS DOUBLE))) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is reserved or blocked"
    - name: "stock_position_count"
      expr: COUNT(1)
      comment: "Total number of distinct stock positions tracked"
    - name: "unique_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs with active stock positions"
    - name: "obsolete_stock_value"
      expr: SUM(CASE WHEN obsolete_flag = TRUE THEN CAST(total_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of stock marked as obsolete requiring disposition"
    - name: "slow_moving_stock_value"
      expr: SUM(CASE WHEN slow_moving_flag = TRUE THEN CAST(total_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of slow-moving inventory requiring action"
    - name: "quarantine_stock_value"
      expr: SUM(CASE WHEN quarantine_flag = TRUE THEN CAST(total_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of stock under quarantine hold"
    - name: "recall_hold_stock_value"
      expr: SUM(CASE WHEN recall_hold_flag = TRUE THEN CAST(total_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of stock held due to product recall"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement transaction metrics tracking goods receipts, issues, transfers, and adjustments for supply chain velocity and material flow analysis."
  source: "`vibe_consumer_goods_v1`.`inventory`.`stock_movement`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "Standard movement type code (e.g., 101=GR, 261=GI, 311=transfer)"
    - name: "movement_category"
      expr: movement_category
      comment: "High-level category of movement (e.g., receipt, issue, transfer, adjustment)"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock involved in the movement"
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of originating document (e.g., purchase order, sales order, production order)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the movement transaction"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicator for special stock handling"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether this is a reversal transaction"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating whether quality inspection is required for this movement"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when the movement was posted to inventory"
    - name: "document_month"
      expr: DATE_TRUNC('MONTH', document_date)
      comment: "Month of the originating document"
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', movement_timestamp)
      comment: "Month when the physical movement occurred"
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions"
    - name: "total_movement_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of all inventory movements"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across movement transactions"
    - name: "movement_transaction_count"
      expr: COUNT(1)
      comment: "Total number of inventory movement transactions"
    - name: "unique_sku_moved_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs involved in movements"
    - name: "reversal_transaction_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal transactions indicating corrections or cancellations"
    - name: "reversal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of movements that are reversals, indicating transaction quality"
    - name: "quality_inspection_required_count"
      expr: SUM(CASE WHEN quality_inspection_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of movements requiring quality inspection"
    - name: "inspection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_inspection_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of movements requiring quality inspection"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_oos_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-stock event metrics tracking stockout incidents, duration, lost sales impact, and root causes for on-shelf availability optimization and service level management."
  source: "`vibe_consumer_goods_v1`.`inventory`.`oos_event`"
  dimensions:
    - name: "oos_type"
      expr: oos_type
      comment: "Type of out-of-stock event (e.g., phantom, physical, distribution)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level category of root cause (e.g., forecasting, supply, execution)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the OOS event (e.g., open, resolved, escalated)"
    - name: "detection_source"
      expr: detection_source
      comment: "Source that detected the OOS event (e.g., POS, audit, customer complaint)"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel where OOS occurred (e.g., retail, e-commerce, wholesale)"
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity level of business impact (e.g., critical, high, medium, low)"
    - name: "customer_impact_flag"
      expr: customer_impact_flag
      comment: "Flag indicating whether customers were directly impacted"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Flag indicating whether this is a recurring OOS issue"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flag indicating whether the OOS event breached service level agreement"
    - name: "product_category"
      expr: product_category
      comment: "Product category of the SKU experiencing OOS"
    - name: "brand_name"
      expr: brand_name
      comment: "Brand name of the product experiencing OOS"
    - name: "oos_start_month"
      expr: DATE_TRUNC('MONTH', oos_start_timestamp)
      comment: "Month when the OOS event started"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_timestamp)
      comment: "Month when the OOS event was resolved"
  measures:
    - name: "oos_event_count"
      expr: COUNT(1)
      comment: "Total number of out-of-stock events"
    - name: "unique_sku_oos_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs that experienced out-of-stock"
    - name: "total_estimated_lost_sales_value"
      expr: SUM(CAST(estimated_lost_sales_value AS DOUBLE))
      comment: "Total estimated revenue lost due to out-of-stock events"
    - name: "total_estimated_lost_units"
      expr: SUM(CAST(estimated_lost_units AS DOUBLE))
      comment: "Total estimated units of lost sales due to stockouts"
    - name: "avg_oos_duration_hours"
      expr: AVG(CAST(oos_duration_hours AS DOUBLE))
      comment: "Average duration of out-of-stock events in hours"
    - name: "avg_lost_sales_per_event"
      expr: AVG(CAST(estimated_lost_sales_value AS DOUBLE))
      comment: "Average revenue lost per out-of-stock event"
    - name: "avg_osa_actual_percent"
      expr: AVG(CAST(osa_actual_percent AS DOUBLE))
      comment: "Average actual on-shelf availability percentage during events"
    - name: "avg_osa_target_percent"
      expr: AVG(CAST(osa_target_percent AS DOUBLE))
      comment: "Average target on-shelf availability percentage"
    - name: "osa_gap_percentage_points"
      expr: AVG(CAST(osa_target_percent AS DOUBLE)) - AVG(CAST(osa_actual_percent AS DOUBLE))
      comment: "Average gap between target and actual on-shelf availability in percentage points"
    - name: "avg_forecast_accuracy_percent"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy percentage for SKUs experiencing OOS"
    - name: "customer_impact_event_count"
      expr: SUM(CASE WHEN customer_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of OOS events that directly impacted customers"
    - name: "customer_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OOS events that resulted in customer impact"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of OOS events that breached service level agreements"
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OOS events that breached SLA thresholds"
    - name: "recurrence_event_count"
      expr: SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of recurring OOS events indicating systemic issues"
    - name: "recurrence_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OOS events that are recurring"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory valuation metrics tracking stock value, cost variances, write-downs, and inventory turnover for financial reporting and working capital optimization."
  source: "`vibe_consumer_goods_v1`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "valuation_method"
      expr: valuation_method
      comment: "Valuation method applied (e.g., standard cost, moving average, FIFO)"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation (e.g., unrestricted, blocked, quality inspection)"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class for grouping similar materials"
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record (e.g., active, closed, adjusted)"
    - name: "obsolete_flag"
      expr: obsolete_flag
      comment: "Flag indicating obsolete inventory requiring write-down"
    - name: "slow_moving_flag"
      expr: slow_moving_flag
      comment: "Flag indicating slow-moving inventory"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the valuation"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the valuation"
    - name: "valuation_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Month of the valuation snapshot"
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total monetary value of inventory at valuation date"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity on hand at valuation date"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per unit across valuations"
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price per unit"
    - name: "avg_actual_unit_cost"
      expr: AVG(CAST(actual_unit_cost AS DOUBLE))
      comment: "Average actual unit cost across valuations"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between standard and actual costs"
    - name: "total_revaluation_amount"
      expr: SUM(CAST(revaluation_amount AS DOUBLE))
      comment: "Total revaluation adjustments made to inventory value"
    - name: "total_write_down_amount"
      expr: SUM(CAST(write_down_amount AS DOUBLE))
      comment: "Total write-down amount for obsolete or impaired inventory"
    - name: "total_cogs_allocation"
      expr: SUM(CAST(cogs_allocation_amount AS DOUBLE))
      comment: "Total cost of goods sold allocation from inventory"
    - name: "total_safety_stock_value"
      expr: SUM(CAST(safety_stock_value AS DOUBLE))
      comment: "Total value of safety stock maintained"
    - name: "avg_inventory_turnover_ratio"
      expr: AVG(CAST(inventory_turnover_ratio AS DOUBLE))
      comment: "Average inventory turnover ratio indicating how quickly inventory is sold"
    - name: "avg_days_inventory_outstanding"
      expr: AVG(CAST(days_inventory_outstanding AS DOUBLE))
      comment: "Average days inventory outstanding indicating holding period"
    - name: "avg_net_realizable_value"
      expr: AVG(CAST(net_realizable_value AS DOUBLE))
      comment: "Average net realizable value of inventory"
    - name: "obsolete_stock_value"
      expr: SUM(CASE WHEN obsolete_flag = TRUE THEN CAST(total_stock_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of obsolete inventory requiring disposition"
    - name: "slow_moving_stock_value"
      expr: SUM(CASE WHEN slow_moving_flag = TRUE THEN CAST(total_stock_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of slow-moving inventory"
    - name: "valuation_record_count"
      expr: COUNT(1)
      comment: "Total number of valuation records"
    - name: "unique_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs valued"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy metrics tracking physical inventory counts, variances, and adjustment rates for inventory record accuracy and shrinkage management."
  source: "`vibe_consumer_goods_v1`.`inventory`.`inventory_cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count (e.g., planned, in-progress, completed, approved)"
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (e.g., manual, RF scan, automated)"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the counted item (A=high value, B=medium, C=low)"
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Reason code for inventory variance (e.g., shrinkage, damage, system error)"
    - name: "count_zone"
      expr: count_zone
      comment: "Physical zone or area where count was performed"
    - name: "recount_flag"
      expr: recount_flag
      comment: "Flag indicating whether a recount was required"
    - name: "adjustment_posted_flag"
      expr: adjustment_posted_flag
      comment: "Flag indicating whether inventory adjustment was posted"
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Flag indicating whether counted stock is under quarantine"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flag indicating temperature-controlled storage requirement"
    - name: "count_month"
      expr: DATE_TRUNC('MONTH', count_date)
      comment: "Month when the cycle count was performed"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_timestamp)
      comment: "Month when the count was approved"
  measures:
    - name: "cycle_count_event_count"
      expr: COUNT(1)
      comment: "Total number of cycle count events performed"
    - name: "unique_sku_counted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs cycle counted"
    - name: "total_system_quantity"
      expr: SUM(CAST(system_quantity AS DOUBLE))
      comment: "Total system quantity before physical count"
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physically counted quantity"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance quantity between system and physical count"
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value AS DOUBLE))
      comment: "Total monetary value of inventory variances"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across cycle counts"
    - name: "total_inventory_value_at_count"
      expr: SUM(CAST(inventory_value_at_count AS DOUBLE))
      comment: "Total inventory value at time of count"
    - name: "count_accuracy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(variance_quantity AS DOUBLE) = 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts with zero variance indicating high accuracy"
    - name: "recount_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recount_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring recount due to discrepancies"
    - name: "adjustment_posting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN adjustment_posted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts resulting in posted inventory adjustments"
    - name: "variance_to_book_ratio"
      expr: ROUND(100.0 * SUM(CAST(variance_value AS DOUBLE)) / NULLIF(SUM(CAST(inventory_value_at_count AS DOUBLE)), 0), 2)
      comment: "Total variance value as percentage of total inventory value indicating shrinkage rate"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_recall_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recall event metrics tracking recall scope, recovery effectiveness, financial impact, and regulatory compliance for risk management and quality assurance."
  source: "`vibe_consumer_goods_v1`.`inventory`.`recall_event`"
  dimensions:
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g., voluntary, mandatory, market withdrawal)"
    - name: "recall_classification"
      expr: recall_classification
      comment: "FDA/regulatory classification (e.g., Class I, II, III) indicating severity"
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall (e.g., initiated, ongoing, completed, closed)"
    - name: "health_hazard_evaluation"
      expr: health_hazard_evaluation
      comment: "Health hazard evaluation level (e.g., serious, moderate, low)"
    - name: "depth_of_recall"
      expr: depth_of_recall
      comment: "Distribution depth of recall (e.g., consumer, retail, wholesale)"
    - name: "recall_scope_channel"
      expr: recall_scope_channel
      comment: "Sales channels affected by the recall"
    - name: "recall_scope_geographic"
      expr: recall_scope_geographic
      comment: "Geographic scope of the recall (e.g., national, regional, international)"
    - name: "recall_scope_customer_segment"
      expr: recall_scope_customer_segment
      comment: "Customer segments affected by the recall"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority overseeing the recall (e.g., FDA, USDA, CPSC)"
    - name: "initiation_month"
      expr: DATE_TRUNC('MONTH', initiation_date)
      comment: "Month when the recall was initiated"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month when the recall was completed"
    - name: "closure_month"
      expr: DATE_TRUNC('MONTH', closure_date)
      comment: "Month when the recall was officially closed"
  measures:
    - name: "recall_event_count"
      expr: COUNT(1)
      comment: "Total number of product recall events"
    - name: "total_quantity_distributed"
      expr: SUM(CAST(quantity_distributed AS DOUBLE))
      comment: "Total quantity of affected product distributed to market"
    - name: "total_quantity_recalled"
      expr: SUM(CAST(quantity_recalled AS DOUBLE))
      comment: "Total quantity of product subject to recall"
    - name: "total_quantity_recovered"
      expr: SUM(CAST(quantity_recovered AS DOUBLE))
      comment: "Total quantity of product successfully recovered from market"
    - name: "avg_recall_effectiveness_percentage"
      expr: AVG(CAST(recall_effectiveness_percentage AS DOUBLE))
      comment: "Average recall effectiveness rate indicating recovery success"
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of all recall events"
    - name: "avg_financial_impact_per_recall"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average financial impact per recall event"
    - name: "recall_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_recovered AS DOUBLE)) / NULLIF(SUM(CAST(quantity_recalled AS DOUBLE)), 0), 2)
      comment: "Percentage of recalled product successfully recovered from market"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy metrics tracking buffer inventory levels, service level targets, and replenishment parameters for inventory optimization and stockout prevention."
  source: "`vibe_consumer_goods_v1`.`inventory`.`safety_stock_policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Type of safety stock policy (e.g., fixed, dynamic, seasonal)"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate safety stock (e.g., statistical, judgmental, hybrid)"
    - name: "replenishment_strategy"
      expr: replenishment_strategy
      comment: "Replenishment strategy (e.g., reorder point, periodic review, min-max)"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU (A=high value, B=medium, C=low)"
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ classification based on demand variability (X=stable, Y=variable, Z=erratic)"
    - name: "criticality_level"
      expr: criticality_level
      comment: "Business criticality level of the SKU (e.g., critical, important, standard)"
    - name: "rotation_rule"
      expr: rotation_rule
      comment: "Inventory rotation rule (e.g., FIFO, FEFO, LIFO)"
    - name: "safety_stock_policy_status"
      expr: safety_stock_policy_status
      comment: "Status of the policy (e.g., active, inactive, under review)"
    - name: "system_generated_flag"
      expr: system_generated_flag
      comment: "Flag indicating whether policy was system-generated or manually set"
    - name: "planning_group"
      expr: planning_group
      comment: "Planning group responsible for the policy"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month when the policy became effective"
  measures:
    - name: "policy_count"
      expr: COUNT(1)
      comment: "Total number of safety stock policies defined"
    - name: "unique_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs with safety stock policies"
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all policies"
    - name: "total_reorder_point"
      expr: SUM(CAST(reorder_point AS DOUBLE))
      comment: "Total reorder point quantity across all policies"
    - name: "total_maximum_stock_level"
      expr: SUM(CAST(maximum_stock_level AS DOUBLE))
      comment: "Total maximum stock level across all policies"
    - name: "avg_service_level_target"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target percentage across policies"
    - name: "avg_replenishment_lead_time_days"
      expr: AVG(CAST(replenishment_lead_time_days AS DOUBLE))
      comment: "Average replenishment lead time in days"
    - name: "avg_average_daily_demand"
      expr: AVG(CAST(average_daily_demand AS DOUBLE))
      comment: "Average daily demand across SKUs"
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient indicating forecast uncertainty"
    - name: "avg_carrying_cost_rate"
      expr: AVG(CAST(carrying_cost_rate_percent AS DOUBLE))
      comment: "Average carrying cost rate as percentage of inventory value"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across policies"
    - name: "avg_stockout_cost_per_unit"
      expr: AVG(CAST(stockout_cost_per_unit AS DOUBLE))
      comment: "Average stockout cost per unit indicating business impact of OOS"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_intransit_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-transit inventory metrics tracking shipment status, on-time delivery performance, freight costs, and exception rates for supply chain visibility and logistics optimization."
  source: "`vibe_consumer_goods_v1`.`inventory`.`intransit_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the in-transit shipment (e.g., in-transit, delivered, delayed, exception)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation (e.g., truck, rail, air, ocean, intermodal)"
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level (e.g., standard, expedited, next-day)"
    - name: "origin_node_type"
      expr: origin_node_type
      comment: "Type of origin node (e.g., plant, DC, supplier, port)"
    - name: "destination_node_type"
      expr: destination_node_type
      comment: "Type of destination node (e.g., DC, store, customer, port)"
    - name: "exception_flag"
      expr: exception_flag
      comment: "Flag indicating whether shipment has an exception"
    - name: "exception_type"
      expr: exception_type
      comment: "Type of shipment exception (e.g., delay, damage, shortage, routing error)"
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Flag indicating whether shipment arrived on time"
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Flag indicating whether shipment was delivered in full quantity"
    - name: "otif_flag"
      expr: otif_flag
      comment: "Flag indicating whether shipment met on-time-in-full criteria"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Flag indicating hazardous materials shipment"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flag indicating temperature-controlled shipment requirement"
    - name: "departure_month"
      expr: DATE_TRUNC('MONTH', departure_timestamp)
      comment: "Month when shipment departed origin"
    - name: "expected_arrival_month"
      expr: DATE_TRUNC('MONTH', expected_arrival_date)
      comment: "Month when shipment is expected to arrive"
    - name: "actual_arrival_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_timestamp)
      comment: "Month when shipment actually arrived"
  measures:
    - name: "intransit_shipment_count"
      expr: COUNT(1)
      comment: "Total number of in-transit shipment records"
    - name: "unique_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs in transit"
    - name: "total_intransit_quantity"
      expr: SUM(CAST(intransit_quantity AS DOUBLE))
      comment: "Total quantity of inventory in transit"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost for all in-transit shipments"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment"
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(shipment_weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms"
    - name: "total_shipment_volume_m3"
      expr: SUM(CAST(shipment_volume_m3 AS DOUBLE))
      comment: "Total shipment volume in cubic meters"
    - name: "avg_transit_days"
      expr: AVG(CAST(transit_days AS DOUBLE))
      comment: "Average transit time in days"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments delivered on time"
    - name: "in_full_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments delivered in full quantity"
    - name: "otif_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "On-time-in-full delivery rate, key supply chain performance metric"
    - name: "exception_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN exception_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with exceptions requiring intervention"
    - name: "hazmat_shipment_count"
      expr: SUM(CASE WHEN hazmat_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of hazardous materials shipments requiring special handling"
    - name: "temperature_controlled_shipment_count"
      expr: SUM(CASE WHEN temperature_controlled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of temperature-controlled shipments"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_vmi_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor‑managed inventory agreement performance metrics."
  source: "`vibe_consumer_goods_v1`.`inventory`.`inventory_vmi_agreement`"
  dimensions:
    - name: "retail_store_id"
      expr: retail_store_id
      comment: "Retail store identifier"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of VMI agreement"
    - name: "inventory_ownership"
      expr: inventory_ownership
      comment: "Ownership model of inventory"
    - name: "agreement_status"
      expr: inventory_vmi_agreement_status
      comment: "Current status of the agreement"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Effective start month of the agreement"
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of VMI agreements"
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average OTIF target percentage"
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target percentage"
    - name: "avg_max_stock_level"
      expr: AVG(CAST(max_stock_level AS DOUBLE))
      comment: "Average maximum stock level"
    - name: "avg_min_stock_level"
      expr: AVG(CAST(min_stock_level AS DOUBLE))
      comment: "Average minimum stock level"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`inventory_stock_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock adjustments impact on quantity and value."
  source: "`vibe_consumer_goods_v1`.`inventory`.`stock_adjustment`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Status of the adjustment"
    - name: "adjustment_date_month"
      expr: DATE_TRUNC('month', adjustment_date)
      comment: "Month of adjustment"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the adjustment"
  measures:
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Number of stock adjustments"
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Sum of adjusted quantities"
    - name: "total_adjusted_value"
      expr: SUM(CAST(adjusted_value AS DOUBLE))
      comment: "Sum of adjusted monetary value"
    - name: "avg_adjustment_quantity"
      expr: AVG(CAST(adjusted_quantity AS DOUBLE))
      comment: "Average adjusted quantity per adjustment"
$$;