-- Metric views for domain: inventory | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:59:48

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_waste_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks food and material waste events at the restaurant unit level. Drives waste reduction initiatives, HACCP compliance monitoring, and cost-of-goods optimization by surfacing waste cost, quantity, and category trends."
  source: "`vibe_restaurants_v1`.`inventory`.`waste_log`"
  dimensions:
    - name: "waste_date"
      expr: waste_date
      comment: "Calendar date the waste event was recorded, used for daily and period-over-period waste trend analysis."
    - name: "waste_category"
      expr: waste_category
      comment: "High-level category of waste (e.g., spoilage, over-production, trim) enabling category-level root-cause analysis."
    - name: "waste_reason"
      expr: waste_reason
      comment: "Specific reason code for the waste event, supporting targeted corrective action programs."
    - name: "disposal_method"
      expr: disposal_method
      comment: "How the wasted item was disposed of (e.g., compost, landfill, donation), relevant for sustainability reporting."
    - name: "daypart"
      expr: daypart
      comment: "Meal period (e.g., breakfast, lunch, dinner) during which waste occurred, enabling daypart-level operational analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for waste quantity (e.g., lbs, oz, each), required for accurate quantity aggregation context."
    - name: "haccp_violation"
      expr: haccp_violation
      comment: "Indicates whether the waste event was associated with a HACCP food-safety violation, critical for compliance tracking."
    - name: "manager_approved"
      expr: manager_approved
      comment: "Indicates whether a manager approved the waste record, supporting audit and governance workflows."
    - name: "waste_prevention_opportunity"
      expr: waste_prevention_opportunity
      comment: "Flags whether a prevention opportunity was identified, enabling proactive waste reduction program tracking."
  measures:
    - name: "total_waste_cost"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total dollar cost of all waste events. A primary financial KPI for food cost management — directly impacts COGS and profitability."
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total quantity of items wasted across all events. Drives volume-based waste reduction targets and par-level adjustments."
    - name: "avg_waste_cost_per_event"
      expr: AVG(CAST(waste_cost AS DOUBLE))
      comment: "Average cost per waste event. Identifies whether waste is driven by high-frequency low-cost events or low-frequency high-cost events."
    - name: "total_waste_events"
      expr: COUNT(1)
      comment: "Total number of waste log entries. Baseline volume metric for waste frequency analysis and staffing/training decisions."
    - name: "haccp_violation_events"
      expr: COUNT(CASE WHEN haccp_violation = TRUE THEN 1 END)
      comment: "Count of waste events flagged as HACCP violations. A critical food-safety compliance KPI monitored by operations and regulatory teams."
    - name: "total_on_hand_before_waste"
      expr: SUM(CAST(on_hand_quantity_before_waste AS DOUBLE))
      comment: "Sum of on-hand inventory quantities at the time of waste events. Contextualizes waste volume relative to available stock."
    - name: "avg_waste_quantity_per_event"
      expr: AVG(CAST(waste_quantity AS DOUBLE))
      comment: "Average quantity wasted per event. Helps identify systemic over-portioning or spoilage patterns by category or daypart."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_food_cost_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Captures period-level food cost accounting metrics including actual vs. theoretical cost, variance, and sales revenue. The primary domain for food cost percentage management, a core restaurant profitability KPI."
  source: "`vibe_restaurants_v1`.`inventory`.`food_cost_period`"
  dimensions:
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the food cost accounting period, used for period-over-period trend analysis."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the food cost accounting period, used for period boundary filtering and reporting."
    - name: "period_type"
      expr: period_type
      comment: "Type of accounting period (e.g., weekly, monthly, quarterly), enabling multi-cadence reporting."
    - name: "period_status"
      expr: period_status
      comment: "Current status of the period (e.g., open, closed, approved), used to filter for finalized vs. in-progress periods."
    - name: "period_number"
      expr: period_number
      comment: "Business period identifier (e.g., P01, P02) for fiscal calendar alignment and sequential period comparison."
    - name: "count_method"
      expr: count_method
      comment: "Inventory count methodology used for the period (e.g., full count, cycle count), affecting data quality context."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial values are denominated, required for multi-currency restaurant group reporting."
  measures:
    - name: "total_actual_food_cost"
      expr: SUM(CAST(actual_food_cost AS DOUBLE))
      comment: "Total actual food cost across all periods. The primary cost-of-goods metric for restaurant profitability management."
    - name: "total_theoretical_food_cost"
      expr: SUM(CAST(theoretical_food_cost AS DOUBLE))
      comment: "Total theoretical (ideal) food cost based on recipes and sales mix. Baseline for variance analysis against actual cost."
    - name: "total_food_sales_revenue"
      expr: SUM(CAST(food_sales_revenue AS DOUBLE))
      comment: "Total food sales revenue for the period. Denominator for food cost percentage calculations and top-line performance tracking."
    - name: "total_beverage_sales_revenue"
      expr: SUM(CAST(beverage_sales_revenue AS DOUBLE))
      comment: "Total beverage sales revenue for the period. Enables separate food vs. beverage cost analysis."
    - name: "total_sales_revenue"
      expr: SUM(CAST(total_sales_revenue AS DOUBLE))
      comment: "Total combined sales revenue (food + beverage) for the period. Primary revenue denominator for all cost percentage KPIs."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total dollar variance between actual and theoretical food cost. Directly measures operational efficiency and recipe adherence."
    - name: "avg_cogs_percent_actual"
      expr: AVG(CAST(cogs_percent_actual AS DOUBLE))
      comment: "Average actual COGS percentage across periods. The headline food cost KPI used in executive dashboards and QBRs."
    - name: "avg_cogs_percent_theoretical"
      expr: AVG(CAST(cogs_percent_theoretical AS DOUBLE))
      comment: "Average theoretical COGS percentage across periods. Benchmark for evaluating actual performance against ideal recipe-based targets."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average food cost variance percentage (actual vs. theoretical). A key operational efficiency metric driving menu engineering and waste reduction decisions."
    - name: "total_waste_value"
      expr: SUM(CAST(waste_value AS DOUBLE))
      comment: "Total value of waste recorded within food cost periods. Quantifies the financial impact of waste on period-level food cost."
    - name: "total_purchases_value"
      expr: SUM(CAST(purchases_value AS DOUBLE))
      comment: "Total value of inventory purchases within the period. Key input to food cost calculation and procurement spend analysis."
    - name: "total_opening_inventory_value"
      expr: SUM(CAST(opening_inventory_value AS DOUBLE))
      comment: "Total opening inventory value across periods. Required for period-level food cost formula: Opening + Purchases - Closing = Cost of Food Used."
    - name: "total_closing_inventory_value"
      expr: SUM(CAST(closing_inventory_value AS DOUBLE))
      comment: "Total closing inventory value across periods. Paired with opening value and purchases to compute cost of food used."
    - name: "avg_waste_percent"
      expr: AVG(CAST(waste_percent AS DOUBLE))
      comment: "Average waste as a percentage of food cost. Tracks waste reduction program effectiveness over time."
    - name: "total_transfers_in_value"
      expr: SUM(CAST(transfers_in_value AS DOUBLE))
      comment: "Total value of inventory transferred into the unit during the period. Adjusts food cost for inter-unit transfer activity."
    - name: "total_transfers_out_value"
      expr: SUM(CAST(transfers_out_value AS DOUBLE))
      comment: "Total value of inventory transferred out of the unit during the period. Adjusts food cost for inter-unit transfer activity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_on_hand_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Snapshot-level inventory position metrics tracking on-hand quantities, valuation, par compliance, and expiration risk. Drives replenishment decisions, shrinkage control, and working capital optimization."
  source: "`vibe_restaurants_v1`.`inventory`.`on_hand_balance`"
  dimensions:
    - name: "snapshot_timestamp"
      expr: snapshot_timestamp
      comment: "Timestamp of the inventory snapshot, used to track inventory position over time and identify trends."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory record (e.g., available, reserved, quarantine), enabling status-based filtering."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification (A=high value, B=medium, C=low) for prioritized cycle count and management focus."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Storage temperature zone (e.g., frozen, refrigerated, dry) for HACCP compliance and storage cost analysis."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (e.g., FIFO, LIFO, weighted average) affecting financial reporting accuracy."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Indicates whether the item is perishable, enabling targeted expiration risk and waste prevention analysis."
    - name: "sku_code"
      expr: sku_code
      comment: "SKU identifier for item-level inventory analysis and replenishment planning."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity fields, required for accurate aggregation context."
    - name: "cycle_count_frequency"
      expr: cycle_count_frequency
      comment: "Frequency at which this item is cycle-counted, used to assess count coverage and compliance."
    - name: "last_physical_count_date"
      expr: last_physical_count_date
      comment: "Date of the last physical count for this balance record, used to identify stale count records."
    - name: "last_received_date"
      expr: last_received_date
      comment: "Date the item was last received, used for slow-moving inventory and supplier delivery analysis."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total on-hand inventory quantity across all balance records. Primary stock position metric for replenishment and ordering decisions."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total available (unreserved) inventory quantity. Drives real-time availability decisions for production and service."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved for pending orders or production. Indicates committed inventory not available for new demand."
    - name: "total_extended_value"
      expr: SUM(CAST(extended_value AS DOUBLE))
      comment: "Total extended inventory value (quantity × unit cost). Primary working capital metric for inventory investment management."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across inventory balance records. Tracks cost inflation and supplier pricing trends."
    - name: "total_variance_from_par"
      expr: SUM(CAST(variance_from_par AS DOUBLE))
      comment: "Total variance between on-hand quantity and par level. Negative values indicate below-par risk; positive values indicate overstock."
    - name: "avg_days_until_expiration"
      expr: AVG(CAST(days_until_expiration AS DOUBLE))
      comment: "Average days until expiration across perishable inventory. A leading indicator of spoilage risk and waste cost exposure."
    - name: "items_below_reorder_point"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN 1 END)
      comment: "Count of SKU-location combinations where on-hand quantity is below the reorder point. Drives urgent replenishment actions."
    - name: "items_below_safety_stock"
      expr: COUNT(CASE WHEN quantity_on_hand < safety_stock THEN 1 END)
      comment: "Count of SKU-location combinations below safety stock threshold. Indicates stockout risk requiring immediate intervention."
    - name: "total_balance_records"
      expr: COUNT(1)
      comment: "Total number of on-hand balance records. Baseline count for inventory breadth and coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_receiving_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks inbound goods receiving performance including delivery timeliness, quality inspection outcomes, quantity accuracy, and total received value. Drives supplier performance management and receiving process efficiency."
  source: "`vibe_restaurants_v1`.`inventory`.`receiving_order`"
  dimensions:
    - name: "delivery_date"
      expr: delivery_date
      comment: "Actual date goods were delivered, used for delivery timeliness and volume trend analysis."
    - name: "expected_delivery_date"
      expr: expected_delivery_date
      comment: "Scheduled delivery date, paired with actual delivery date to compute on-time delivery performance."
    - name: "receiving_status"
      expr: receiving_status
      comment: "Current status of the receiving order (e.g., pending, received, rejected), used for pipeline and exception reporting."
    - name: "quality_inspection_result"
      expr: quality_inspection_result
      comment: "Outcome of the quality inspection (e.g., pass, fail, conditional), critical for supplier quality scorecards."
    - name: "temperature_check_result"
      expr: temperature_check_result
      comment: "Result of the temperature check at receiving (e.g., pass, fail), a key HACCP compliance data point."
    - name: "delivery_timeliness"
      expr: delivery_timeliness
      comment: "Timeliness classification of the delivery (e.g., on-time, early, late), used for supplier SLA tracking."
    - name: "supplier_name"
      expr: supplier_name
      comment: "Name of the supplier for this receiving order, enabling supplier-level performance benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the received order value, required for multi-currency procurement reporting."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Indicates whether a quantity or value variance was detected at receiving, used to filter exception reports."
    - name: "posted_to_inventory_flag"
      expr: posted_to_inventory_flag
      comment: "Indicates whether the receiving order has been posted to inventory, used to identify unposted receipts."
  measures:
    - name: "total_received_value"
      expr: SUM(CAST(total_received_value AS DOUBLE))
      comment: "Total value of goods received. Primary procurement spend metric and key input to food cost period calculations."
    - name: "total_items_received"
      expr: SUM(CAST(total_items_received AS DOUBLE))
      comment: "Total number of line items received across all orders. Measures receiving throughput and supplier fulfillment volume."
    - name: "total_items_ordered"
      expr: SUM(CAST(total_items_ordered AS DOUBLE))
      comment: "Total number of line items ordered. Paired with items received to compute fill rate and order fulfillment accuracy."
    - name: "total_receiving_orders"
      expr: COUNT(1)
      comment: "Total number of receiving orders processed. Baseline volume metric for receiving workload and supplier activity."
    - name: "orders_with_quality_failure"
      expr: COUNT(CASE WHEN quality_inspection_result = 'fail' THEN 1 END)
      comment: "Count of receiving orders that failed quality inspection. Drives supplier quality improvement programs and rejection rate KPIs."
    - name: "orders_with_temperature_failure"
      expr: COUNT(CASE WHEN temperature_check_result = 'fail' THEN 1 END)
      comment: "Count of receiving orders that failed temperature checks. A critical HACCP food-safety compliance metric."
    - name: "orders_with_variance"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Count of receiving orders with quantity or value variances. Indicates supplier fulfillment accuracy issues requiring follow-up."
    - name: "avg_temperature_recorded"
      expr: AVG(CAST(temperature_recorded AS DOUBLE))
      comment: "Average temperature recorded at receiving. Monitors cold-chain integrity across deliveries for HACCP compliance."
    - name: "orders_late_delivery"
      expr: COUNT(CASE WHEN delivery_timeliness = 'late' THEN 1 END)
      comment: "Count of receiving orders with late deliveries. Key supplier SLA metric affecting kitchen production scheduling."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_physical_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures physical inventory count accuracy, variance detection, and process compliance. Drives inventory accuracy programs, shrinkage investigation, and period-end close quality."
  source: "`vibe_restaurants_v1`.`inventory`.`physical_count`"
  dimensions:
    - name: "count_date"
      expr: count_date
      comment: "Date the physical count was conducted, used for count frequency and trend analysis."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (e.g., full, cycle, spot), enabling analysis by count methodology and coverage."
    - name: "count_status"
      expr: count_status
      comment: "Current status of the count (e.g., in-progress, submitted, approved, cancelled), used for pipeline and completion tracking."
    - name: "count_method"
      expr: count_method
      comment: "Counting method used (e.g., manual, scanner-assisted), relevant for accuracy benchmarking by method."
    - name: "is_period_end_count"
      expr: is_period_end_count
      comment: "Indicates whether this count was a period-end closing count, used to filter for financially significant counts."
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Indicates whether a recount was required due to variance, a quality signal for count accuracy programs."
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Reason code for inventory variance identified during the count, enabling root-cause categorization."
    - name: "count_period"
      expr: count_period
      comment: "Business period the count belongs to, enabling period-level count coverage and accuracy reporting."
  measures:
    - name: "total_variance_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Total dollar variance between physical count and system inventory value. The primary inventory accuracy financial KPI."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(total_variance_percentage AS DOUBLE))
      comment: "Average variance percentage across counts. Tracks inventory accuracy improvement over time and against industry benchmarks."
    - name: "total_physical_inventory_value"
      expr: SUM(CAST(physical_inventory_value AS DOUBLE))
      comment: "Total physical inventory value as counted. Used for balance sheet inventory valuation and period-end financial close."
    - name: "total_system_inventory_value"
      expr: SUM(CAST(system_inventory_value AS DOUBLE))
      comment: "Total system (book) inventory value at time of count. Paired with physical value to compute shrinkage and variance."
    - name: "total_sku_counted"
      expr: SUM(CAST(total_sku_counted AS DOUBLE))
      comment: "Total number of SKUs counted across all physical counts. Measures count coverage and completeness."
    - name: "total_sku_with_variance"
      expr: SUM(CAST(total_sku_with_variance AS DOUBLE))
      comment: "Total number of SKUs with identified variances. Drives targeted investigation and shrinkage reduction programs."
    - name: "total_counts_conducted"
      expr: COUNT(1)
      comment: "Total number of physical counts conducted. Baseline metric for count frequency compliance and operational discipline."
    - name: "counts_requiring_recount"
      expr: COUNT(CASE WHEN recount_required_flag = TRUE THEN 1 END)
      comment: "Number of counts that required a recount due to variance. Indicates count quality issues and process improvement opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks inventory adjustment events including waste, shrinkage, corrections, and reversals. Provides visibility into inventory accuracy, shrinkage cost, and adjustment approval compliance."
  source: "`vibe_restaurants_v1`.`inventory`.`adjustment`"
  dimensions:
    - name: "adjustment_date"
      expr: adjustment_date
      comment: "Date the inventory adjustment was made, used for daily and period-level adjustment trend analysis."
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (e.g., waste, shrinkage, correction, receiving variance), enabling category-level root-cause analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the adjustment, supporting structured root-cause categorization and corrective action tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adjustment (e.g., pending, approved, rejected), used for governance and compliance monitoring."
    - name: "waste_category"
      expr: waste_category
      comment: "Waste category for waste-type adjustments, enabling waste cost analysis by category."
    - name: "is_shrinkage"
      expr: is_shrinkage
      comment: "Indicates whether the adjustment represents shrinkage (theft, unexplained loss), a key loss prevention KPI."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Indicates whether the adjustment has been reversed, used to identify corrected entries and net adjustment calculations."
    - name: "impacts_cogs"
      expr: impacts_cogs
      comment: "Indicates whether the adjustment impacts cost of goods sold, used to filter for financially material adjustments."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the adjusted quantity, required for accurate quantity aggregation context."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment value, required for multi-currency reporting."
  measures:
    - name: "total_adjustment_value"
      expr: SUM(CAST(value AS DOUBLE))
      comment: "Total financial value of all inventory adjustments. Measures the aggregate financial impact of inventory corrections on COGS."
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Total quantity adjusted across all adjustment events. Measures the volume of inventory corrections and shrinkage."
    - name: "total_shrinkage_value"
      expr: SUM(CASE WHEN is_shrinkage = TRUE THEN CAST(value AS DOUBLE) ELSE 0 END)
      comment: "Total value of shrinkage adjustments (theft, unexplained loss). A critical loss prevention and profitability KPI."
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of inventory adjustment events. Baseline frequency metric for adjustment volume and process compliance monitoring."
    - name: "adjustments_pending_approval"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Count of adjustments awaiting approval. Identifies governance bottlenecks and unapproved inventory changes."
    - name: "avg_unit_cost_at_adjustment"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of items at the time of adjustment. Tracks whether high-cost items are disproportionately affected by shrinkage."
    - name: "total_cogs_impacting_value"
      expr: SUM(CASE WHEN impacts_cogs = TRUE THEN CAST(value AS DOUBLE) ELSE 0 END)
      comment: "Total value of adjustments that directly impact COGS. Isolates the financially material subset of adjustments for P&L reporting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks inter-unit and inter-location inventory transfer activity including transfer value, quantity, timeliness, and quality compliance. Supports supply chain balancing, inter-unit cost allocation, and HACCP cold-chain monitoring."
  source: "`vibe_restaurants_v1`.`inventory`.`stock_transfer`"
  dimensions:
    - name: "transfer_request_date"
      expr: transfer_request_date
      comment: "Date the transfer was requested, used for lead time analysis and demand planning."
    - name: "transfer_ship_date"
      expr: transfer_ship_date
      comment: "Date the transfer was shipped, used for fulfillment cycle time analysis."
    - name: "transfer_received_date"
      expr: transfer_received_date
      comment: "Date the transfer was received at the destination, used for end-to-end transfer cycle time measurement."
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the transfer (e.g., requested, in-transit, received, cancelled), used for pipeline and exception reporting."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (e.g., inter-unit, inter-location, emergency), enabling analysis by transfer purpose."
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Reason code for the transfer (e.g., par balancing, emergency, waste prevention), supporting root-cause analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer (e.g., urgent, standard, low), used for SLA compliance and resource allocation analysis."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Method used to ship the transfer, relevant for logistics cost and cold-chain compliance analysis."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the transfer required temperature-controlled transport, critical for HACCP compliance tracking."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Status of quality inspection for the transfer, used for supplier and logistics quality scorecards."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Indicates whether a quantity or value variance was detected on the transfer, used for exception reporting."
  measures:
    - name: "total_transfer_value"
      expr: SUM(CAST(total_transfer_value_usd AS DOUBLE))
      comment: "Total value of inventory transferred across all transfers. Key metric for inter-unit cost allocation and working capital movement."
    - name: "total_quantity_transferred"
      expr: SUM(CAST(total_quantity_transferred AS DOUBLE))
      comment: "Total quantity of inventory transferred. Measures the volume of inter-unit supply chain activity."
    - name: "total_item_count_transferred"
      expr: SUM(CAST(total_item_count AS DOUBLE))
      comment: "Total number of line items transferred. Measures transfer complexity and fulfillment breadth."
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total number of stock transfer events. Baseline volume metric for inter-unit supply chain activity."
    - name: "transfers_with_variance"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Count of transfers with quantity or value variances. Identifies fulfillment accuracy issues and potential shrinkage in transit."
    - name: "avg_transfer_value"
      expr: AVG(CAST(total_transfer_value_usd AS DOUBLE))
      comment: "Average value per stock transfer. Tracks transfer size trends and identifies unusually large or small transfers."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_vendor_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks vendor item catalog performance including pricing, quality ratings, delivery performance, and contract compliance. Drives supplier rationalization, preferred vendor programs, and procurement cost optimization."
  source: "`vibe_restaurants_v1`.`inventory`.`vendor_item`"
  dimensions:
    - name: "vendor_item_status"
      expr: vendor_item_status
      comment: "Current status of the vendor item (e.g., active, inactive, discontinued), used to filter for active procurement options."
    - name: "vendor_product_category"
      expr: vendor_product_category
      comment: "Product category as classified by the vendor, enabling category-level supplier analysis."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates whether this is a preferred vendor item, used to track preferred vendor utilization and compliance."
    - name: "contract_price_flag"
      expr: contract_price_flag
      comment: "Indicates whether the item is on a contracted price, used to monitor contract compliance and off-contract spend."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the vendor item, relevant for supply chain risk, tariff analysis, and sourcing diversification."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Name of the manufacturer, enabling manufacturer-level quality and cost analysis."
    - name: "activation_date"
      expr: activation_date
      comment: "Date the vendor item was activated in the catalog, used for new item onboarding analysis."
    - name: "last_cost_update_date"
      expr: last_cost_update_date
      comment: "Date of the last cost update, used to identify stale pricing and trigger cost review workflows."
    - name: "order_uom"
      expr: order_uom
      comment: "Unit of measure for ordering, relevant for pack size optimization and order quantity analysis."
  measures:
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across vendor items. Tracks pricing trends and enables cost benchmarking across suppliers."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average vendor quality rating. A key supplier scorecard metric driving preferred vendor selection and contract renewals."
    - name: "avg_on_time_delivery_percent"
      expr: AVG(CAST(on_time_delivery_percent AS DOUBLE))
      comment: "Average on-time delivery percentage across vendor items. Primary supplier reliability KPI for procurement SLA management."
    - name: "total_active_vendor_items"
      expr: COUNT(CASE WHEN vendor_item_status = 'active' THEN 1 END)
      comment: "Count of active vendor items in the catalog. Measures supplier catalog breadth and sourcing optionality."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across vendor items. Informs order consolidation strategies and working capital optimization."
    - name: "total_vendor_items"
      expr: COUNT(1)
      comment: "Total number of vendor item records. Baseline catalog size metric for supplier rationalization programs."
$$;