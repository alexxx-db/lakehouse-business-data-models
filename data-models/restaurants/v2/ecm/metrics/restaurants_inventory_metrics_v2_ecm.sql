-- Metric views for domain: inventory | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_food_cost_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks food cost performance per period including actual vs theoretical cost, variance, and waste metrics. Used by operations and finance leadership to monitor COGS efficiency and identify cost control opportunities."
  source: "`vibe_restaurants_v1`.`inventory`.`food_cost_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of accounting period (weekly, monthly, period) for time-based grouping of food cost analysis."
    - name: "period_status"
      expr: period_status
      comment: "Status of the food cost period (open, closed, approved) to filter for finalized vs in-progress periods."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which food cost values are denominated, enabling multi-currency reporting."
    - name: "count_method"
      expr: count_method
      comment: "Inventory count method used (physical, cycle, estimated) affecting reliability of cost calculations."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month bucket of period start date for trend analysis of food cost over time."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier for location-level food cost benchmarking."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Franchisee identifier for franchise-level food cost performance comparison."
  measures:
    - name: "total_actual_food_cost"
      expr: SUM(CAST(actual_food_cost AS DOUBLE))
      comment: "Total actual food cost incurred in the period. Core COGS driver used by finance and operations to track spending against budget."
    - name: "total_theoretical_food_cost"
      expr: SUM(CAST(theoretical_food_cost AS DOUBLE))
      comment: "Total theoretical food cost based on recipe standards and sales mix. Baseline for variance analysis — gap vs actual reveals operational inefficiency."
    - name: "total_food_cost_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between actual and theoretical food cost. Negative variance indicates over-spend; used to trigger investigation and corrective action."
    - name: "avg_cogs_percent_actual"
      expr: AVG(CAST(cogs_percent_actual AS DOUBLE))
      comment: "Average actual COGS as a percentage of sales across periods. Key P&L metric monitored by CFO and VP Operations against target thresholds."
    - name: "avg_cogs_percent_theoretical"
      expr: AVG(CAST(cogs_percent_theoretical AS DOUBLE))
      comment: "Average theoretical COGS percentage based on standard recipes. Benchmark against actual COGS percent to quantify operational gap."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average food cost variance as a percentage. Persistent positive variance signals systemic waste, theft, or portioning issues requiring leadership intervention."
    - name: "total_waste_value"
      expr: SUM(CAST(waste_value AS DOUBLE))
      comment: "Total monetary value of food waste in the period. Directly impacts profitability; tracked by operations to drive waste reduction programs."
    - name: "avg_waste_percent"
      expr: AVG(CAST(waste_percent AS DOUBLE))
      comment: "Average waste as a percentage of food cost. Benchmarked against industry standards to identify units with abnormal waste levels."
    - name: "total_food_sales_revenue"
      expr: SUM(CAST(food_sales_revenue AS DOUBLE))
      comment: "Total food sales revenue in the period. Denominator for COGS% calculations and top-line revenue tracking for food category."
    - name: "total_beverage_sales_revenue"
      expr: SUM(CAST(beverage_sales_revenue AS DOUBLE))
      comment: "Total beverage sales revenue in the period. Tracked separately from food to monitor category mix and margin contribution."
    - name: "total_purchases_value"
      expr: SUM(CAST(purchases_value AS DOUBLE))
      comment: "Total value of inventory purchases in the period. Key input to food cost calculation and procurement spend analysis."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total inventory adjustment value applied in the period. Large adjustments may indicate counting errors or shrinkage requiring investigation."
    - name: "period_count"
      expr: COUNT(1)
      comment: "Number of food cost periods recorded. Used to validate completeness of period-end close process across all units."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors inventory adjustment activity including shrinkage, waste, and variance events. Used by operations and loss prevention to identify abnormal adjustment patterns and control inventory integrity."
  source: "`vibe_restaurants_v1`.`inventory`.`inventory_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Category of adjustment (waste, theft, spoilage, count correction) for root-cause analysis of inventory losses."
    - name: "reason_code"
      expr: reason_code
      comment: "Specific reason code for the adjustment, enabling drill-down into the most common causes of inventory variance."
    - name: "waste_category"
      expr: waste_category
      comment: "Classification of waste type (prep waste, spoilage, over-production) for targeted waste reduction initiatives."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adjustment (pending, approved, rejected) to monitor compliance with authorization controls."
    - name: "is_shrinkage"
      expr: is_shrinkage
      comment: "Flag indicating whether the adjustment represents shrinkage (theft, unexplained loss) for loss prevention reporting."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Flag indicating whether the adjustment was subsequently reversed, useful for identifying data quality issues."
    - name: "impacts_cogs"
      expr: impacts_cogs
      comment: "Flag indicating whether the adjustment impacts cost of goods sold, for financial impact filtering."
    - name: "adjustment_date"
      expr: DATE_TRUNC('month', adjustment_date)
      comment: "Month bucket of adjustment date for trend analysis of adjustment frequency and value over time."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit where the adjustment occurred, for location-level loss analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the adjusted quantity, enabling consistent cross-item comparison."
  measures:
    - name: "total_adjustment_value"
      expr: SUM(CAST(adjustment_value AS DOUBLE))
      comment: "Total monetary value of all inventory adjustments. High values signal significant inventory loss or data quality issues requiring leadership attention."
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Total quantity adjusted across all inventory adjustment events. Volume metric for operational loss tracking."
    - name: "shrinkage_adjustment_value"
      expr: SUM(CASE WHEN is_shrinkage = TRUE THEN CAST(adjustment_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of adjustments classified as shrinkage (theft, unexplained loss). Critical loss prevention KPI monitored by operations and security leadership."
    - name: "avg_unit_cost_at_adjustment"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of items being adjusted. Helps prioritize high-value items for tighter inventory controls."
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of inventory adjustment transactions. High frequency may indicate systemic counting or operational issues."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Number of adjustments awaiting approval. Backlog in approvals creates financial reporting risk and should trigger management escalation."
    - name: "shrinkage_event_count"
      expr: COUNT(CASE WHEN is_shrinkage = TRUE THEN 1 END)
      comment: "Number of shrinkage events recorded. Frequency trend used by loss prevention to assess theft or unexplained loss risk."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_physical_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks physical inventory count accuracy, variance, and completion. Used by operations and finance to validate inventory integrity, support period-end close, and identify locations with persistent count discrepancies."
  source: "`vibe_restaurants_v1`.`inventory`.`physical_count`"
  dimensions:
    - name: "count_type"
      expr: count_type
      comment: "Type of physical count (full, cycle, spot) for segmenting count accuracy by methodology."
    - name: "count_method"
      expr: count_method
      comment: "Method used to conduct the count (manual, scanner, system-assisted) affecting count accuracy benchmarking."
    - name: "count_status"
      expr: count_status
      comment: "Current status of the count (scheduled, in-progress, submitted, approved) for pipeline monitoring."
    - name: "is_period_end_count"
      expr: is_period_end_count
      comment: "Flag indicating whether this is a period-end count, which feeds directly into financial reporting."
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Flag indicating a recount was required due to variance, signaling count quality issues at a location."
    - name: "count_date"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month bucket of count date for trend analysis of count frequency and variance over time."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit where the physical count was conducted, for location-level accuracy benchmarking."
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Reason code explaining the variance between physical and system inventory values."
  measures:
    - name: "total_physical_inventory_value"
      expr: SUM(CAST(physical_inventory_value AS DOUBLE))
      comment: "Total physical inventory value counted. Core balance sheet input used by finance for period-end inventory valuation."
    - name: "total_system_inventory_value"
      expr: SUM(CAST(system_inventory_value AS DOUBLE))
      comment: "Total system-recorded inventory value at time of count. Compared against physical value to compute variance."
    - name: "total_variance_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Total monetary variance between physical count and system inventory. Large variances trigger financial restatement risk and operational investigation."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(total_variance_percentage AS DOUBLE))
      comment: "Average variance percentage across counts. Persistent high variance indicates systemic inventory control failures requiring executive intervention."
    - name: "count_events"
      expr: COUNT(1)
      comment: "Total number of physical count events. Used to verify count cadence compliance across all restaurant units."
    - name: "recount_required_count"
      expr: COUNT(CASE WHEN recount_required_flag = TRUE THEN 1 END)
      comment: "Number of counts that required a recount due to variance. High recount rate signals counting process quality issues."
    - name: "period_end_count_events"
      expr: COUNT(CASE WHEN is_period_end_count = TRUE THEN 1 END)
      comment: "Number of period-end counts completed. Validates that all units completed mandatory period-end inventory counts for financial close."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_waste_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks food waste events by category, reason, and location. Used by operations leadership to drive waste reduction programs, monitor HACCP compliance, and quantify the financial impact of waste on profitability."
  source: "`vibe_restaurants_v1`.`inventory`.`waste_log`"
  dimensions:
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (prep waste, spoilage, over-production, expired) for targeted waste reduction program design."
    - name: "waste_reason"
      expr: waste_reason
      comment: "Specific reason for the waste event, enabling root-cause analysis and corrective action prioritization."
    - name: "disposal_method"
      expr: disposal_method
      comment: "How the waste was disposed of (trash, compost, donation) for sustainability reporting."
    - name: "haccp_violation"
      expr: haccp_violation
      comment: "Flag indicating whether the waste event was associated with a HACCP violation, a food safety compliance risk."
    - name: "daypart"
      expr: daypart
      comment: "Daypart (breakfast, lunch, dinner) during which waste occurred, for operational scheduling and prep optimization."
    - name: "waste_date"
      expr: DATE_TRUNC('month', waste_date)
      comment: "Month bucket of waste date for trend analysis of waste volume and cost over time."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit where waste was recorded, for location-level waste benchmarking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for waste quantity, enabling consistent cross-item waste comparison."
  measures:
    - name: "total_waste_cost"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total monetary cost of food waste. Direct P&L impact metric used by CFO and VP Operations to quantify waste reduction opportunity."
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total quantity of food wasted. Volume metric for operational waste tracking and sustainability reporting."
    - name: "haccp_violation_waste_cost"
      expr: SUM(CASE WHEN haccp_violation = TRUE THEN CAST(waste_cost AS DOUBLE) ELSE 0 END)
      comment: "Total waste cost associated with HACCP violations. Food safety compliance risk metric — high values indicate systemic food safety failures."
    - name: "avg_waste_cost_per_event"
      expr: AVG(CAST(waste_cost AS DOUBLE))
      comment: "Average cost per waste event. Benchmarked across units and dayparts to identify high-cost waste patterns."
    - name: "waste_event_count"
      expr: COUNT(1)
      comment: "Total number of waste events recorded. Frequency metric for waste culture assessment and operational discipline monitoring."
    - name: "haccp_violation_event_count"
      expr: COUNT(CASE WHEN haccp_violation = TRUE THEN 1 END)
      comment: "Number of waste events with HACCP violations. Food safety KPI monitored by quality assurance and operations leadership."
    - name: "manager_approved_waste_count"
      expr: COUNT(CASE WHEN manager_approved = TRUE THEN 1 END)
      comment: "Number of waste events approved by a manager. Approval rate indicates compliance with waste authorization controls."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_on_hand_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a real-time view of inventory on-hand levels, valuation, and stock health. Used by supply chain and operations leadership to monitor stock availability, identify at-risk inventory, and optimize reorder decisions."
  source: "`vibe_restaurants_v1`.`inventory`.`on_hand_balance`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory (available, reserved, expired, quarantine) for stock health segmentation."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the stock item (A=high value, B=medium, C=low) for prioritized inventory management."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Storage temperature zone (ambient, refrigerated, frozen) for cold chain compliance monitoring."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Flag indicating whether the item is perishable, for prioritizing expiration risk management."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (FIFO, LIFO, weighted average) for financial reporting consistency."
    - name: "snapshot_timestamp"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Day bucket of inventory snapshot for daily on-hand balance trend analysis."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit for location-level inventory balance monitoring."
    - name: "cycle_count_frequency"
      expr: cycle_count_frequency
      comment: "Frequency at which this item is cycle-counted, for count schedule compliance monitoring."
  measures:
    - name: "total_extended_value"
      expr: SUM(CAST(extended_value AS DOUBLE))
      comment: "Total extended inventory value (quantity × unit cost). Balance sheet inventory asset value used by finance for period-end reporting."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of inventory on hand. Operational availability metric used to prevent stockouts and over-ordering."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for use (on-hand minus reserved). Actual usable stock for production planning."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved for pending orders or production. High reservation levels may indicate supply constraints."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of inventory on hand. Used for cost trend analysis and vendor price benchmarking."
    - name: "total_variance_from_par"
      expr: SUM(CAST(variance_from_par AS DOUBLE))
      comment: "Total variance from par level across all stock items. Negative values indicate under-stocking risk; positive values indicate over-stocking and capital tie-up."
    - name: "below_reorder_point_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN 1 END)
      comment: "Number of stock items below their reorder point. Critical supply chain alert metric — high count signals imminent stockout risk requiring procurement action."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT stock_item_id)
      comment: "Number of distinct SKUs with on-hand inventory. Breadth of active inventory portfolio for assortment management."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_receiving_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks supplier delivery performance, receiving quality, and variance at the point of goods receipt. Used by supply chain and procurement leadership to evaluate supplier reliability and receiving process compliance."
  source: "`vibe_restaurants_v1`.`inventory`.`receiving_order`"
  dimensions:
    - name: "receiving_status"
      expr: receiving_status
      comment: "Status of the receiving order (pending, received, rejected, partial) for pipeline and exception monitoring."
    - name: "delivery_timeliness"
      expr: delivery_timeliness
      comment: "Classification of delivery timeliness (on-time, early, late) for supplier on-time delivery performance tracking."
    - name: "quality_inspection_result"
      expr: quality_inspection_result
      comment: "Result of quality inspection at receiving (pass, fail, conditional) for supplier quality performance monitoring."
    - name: "temperature_check_result"
      expr: temperature_check_result
      comment: "Result of temperature check at receiving for cold chain compliance and food safety monitoring."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Flag indicating a quantity or quality variance was detected at receiving, for exception-based management."
    - name: "delivery_date"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month bucket of delivery date for trend analysis of receiving volume and supplier performance over time."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit receiving the delivery, for location-level receiving performance analysis."
    - name: "receiving_shift"
      expr: receiving_shift
      comment: "Shift during which receiving occurred, for staffing and scheduling optimization of receiving operations."
  measures:
    - name: "total_received_value"
      expr: SUM(CAST(total_received_value AS DOUBLE))
      comment: "Total value of goods received. Procurement spend metric used to track supplier volume and validate against purchase orders."
    - name: "receiving_order_count"
      expr: COUNT(1)
      comment: "Total number of receiving orders processed. Volume metric for receiving workload planning and supplier delivery frequency analysis."
    - name: "variance_receiving_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of receiving orders with a variance. High variance count signals supplier quality or quantity issues requiring procurement escalation."
    - name: "avg_temperature_recorded"
      expr: AVG(CAST(temperature_recorded AS DOUBLE))
      comment: "Average temperature recorded at receiving. Cold chain compliance metric — deviations from safe temperature ranges indicate food safety risk."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN delivery_timeliness = 'on-time' THEN 1 END)
      comment: "Number of deliveries received on time. Numerator for supplier on-time delivery rate calculation."
    - name: "quality_pass_count"
      expr: COUNT(CASE WHEN quality_inspection_result = 'pass' THEN 1 END)
      comment: "Number of receiving orders that passed quality inspection. Numerator for supplier quality pass rate — low rates trigger supplier review."
    - name: "avg_days_variance"
      expr: AVG(CAST(days_variance AS DOUBLE))
      comment: "Average number of days variance between expected and actual delivery date. Supplier reliability metric used in vendor scorecards."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks actual vs standard yield performance for prep operations. Used by culinary and operations leadership to identify yield gaps, control food cost, and optimize prep procedures."
  source: "`vibe_restaurants_v1`.`inventory`.`yield_record`"
  dimensions:
    - name: "prep_type"
      expr: prep_type
      comment: "Type of prep operation (butchery, cooking, portioning) for yield analysis by preparation method."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade of the yielded product, for correlating yield performance with quality outcomes."
    - name: "haccp_compliant"
      expr: haccp_compliant
      comment: "Flag indicating HACCP compliance during prep, for food safety yield analysis."
    - name: "yield_record_status"
      expr: yield_record_status
      comment: "Status of the yield record (draft, submitted, approved) for data completeness monitoring."
    - name: "prep_date"
      expr: DATE_TRUNC('month', prep_date)
      comment: "Month bucket of prep date for trend analysis of yield performance over time."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit where prep was performed, for location-level yield benchmarking."
    - name: "prep_station_code"
      expr: prep_station_code
      comment: "Prep station identifier for station-level yield performance analysis and equipment optimization."
    - name: "waste_reason_code"
      expr: waste_reason_code
      comment: "Reason code for yield waste, enabling targeted reduction of the most impactful waste causes."
  measures:
    - name: "avg_actual_yield_percentage"
      expr: AVG(CAST(actual_yield_percentage AS DOUBLE))
      comment: "Average actual yield percentage achieved in prep. Core culinary efficiency KPI — gap vs standard yield directly drives food cost variance."
    - name: "avg_standard_yield_percentage"
      expr: AVG(CAST(standard_yield_percentage AS DOUBLE))
      comment: "Average standard (expected) yield percentage. Benchmark for actual yield performance evaluation."
    - name: "avg_yield_variance_percentage"
      expr: AVG(CAST(yield_variance_percentage AS DOUBLE))
      comment: "Average variance between actual and standard yield percentage. Persistent negative variance signals prep skill gaps or ingredient quality issues."
    - name: "total_raw_cost"
      expr: SUM(CAST(total_raw_cost AS DOUBLE))
      comment: "Total cost of raw ingredients used in prep. Input cost metric for yield-adjusted food cost analysis."
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total quantity of waste generated during prep. Volume metric for waste reduction program targeting."
    - name: "avg_cost_per_yield_unit"
      expr: AVG(CAST(cost_per_yield_unit AS DOUBLE))
      comment: "Average cost per usable yield unit. Effective cost metric that accounts for yield loss — used to price menu items accurately."
    - name: "yield_record_count"
      expr: COUNT(1)
      comment: "Total number of yield records. Used to validate prep documentation compliance across units and stations."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_prep_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks actual vs theoretical prep usage and cost variance. Used by culinary operations and finance to identify over-usage, control prep costs, and validate recipe adherence."
  source: "`vibe_restaurants_v1`.`inventory`.`prep_usage`"
  dimensions:
    - name: "prep_type"
      expr: prep_type
      comment: "Type of prep task for segmenting usage variance by preparation category."
    - name: "prep_usage_status"
      expr: prep_usage_status
      comment: "Status of the prep usage record (draft, submitted, approved) for data completeness monitoring."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade of the prepped item, for correlating usage efficiency with quality outcomes."
    - name: "haccp_compliant"
      expr: haccp_compliant
      comment: "Flag indicating HACCP compliance during prep, for food safety compliance monitoring."
    - name: "prep_date"
      expr: DATE_TRUNC('month', prep_date)
      comment: "Month bucket of prep date for trend analysis of prep usage and cost variance over time."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit for location-level prep usage benchmarking."
    - name: "prep_station_code"
      expr: prep_station_code
      comment: "Prep station for station-level usage efficiency analysis."
    - name: "waste_reason_code"
      expr: waste_reason_code
      comment: "Reason code for prep waste, enabling targeted reduction of the most impactful waste causes."
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of prep usage. Core food cost input — compared against theoretical cost to identify over-spend."
    - name: "total_theoretical_cost"
      expr: SUM(CAST(theoretical_cost AS DOUBLE))
      comment: "Total theoretical cost of prep based on standard recipes. Benchmark for actual cost performance."
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total cost variance between actual and theoretical prep usage. Persistent positive variance signals recipe non-compliance or ingredient waste."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average prep cost variance as a percentage. Benchmarked across units and stations to identify outliers requiring corrective action."
    - name: "total_actual_quantity_used"
      expr: SUM(CAST(actual_quantity_used AS DOUBLE))
      comment: "Total actual quantity of ingredients used in prep. Volume metric for usage efficiency and recipe adherence analysis."
    - name: "total_theoretical_quantity"
      expr: SUM(CAST(theoretical_quantity AS DOUBLE))
      comment: "Total theoretical quantity expected based on standard recipes. Baseline for actual quantity variance calculation."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between actual and theoretical prep usage. Identifies over-portioning or waste patterns."
    - name: "prep_usage_record_count"
      expr: COUNT(1)
      comment: "Total number of prep usage records. Used to validate prep documentation compliance across units."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_stock_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a catalog-level view of stock item attributes including cost, allergen profile, and dietary certifications. Used by procurement, culinary, and compliance teams to manage the active item portfolio and support menu development."
  source: "`vibe_restaurants_v1`.`inventory`.`stock_item`"
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of the stock item for portfolio analysis and category-level cost management."
    - name: "item_subcategory"
      expr: item_subcategory
      comment: "Subcategory of the stock item for granular assortment management."
    - name: "storage_class"
      expr: storage_class
      comment: "Storage class (ambient, refrigerated, frozen) for cold chain capacity planning."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the stock item is currently active in the catalog."
    - name: "is_organic"
      expr: is_organic
      comment: "Flag indicating organic certification, for sustainability and menu labeling compliance."
    - name: "is_halal"
      expr: is_halal
      comment: "Flag indicating halal certification, for dietary compliance and menu labeling."
    - name: "is_kosher"
      expr: is_kosher
      comment: "Flag indicating kosher certification, for dietary compliance and menu labeling."
    - name: "allergen_wheat"
      expr: allergen_wheat
      comment: "Flag indicating wheat allergen presence, for allergen management and menu labeling compliance."
    - name: "allergen_milk"
      expr: allergen_milk
      comment: "Flag indicating milk allergen presence, for allergen management and menu labeling compliance."
  measures:
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost across stock items. Benchmark for procurement price negotiation and cost trend monitoring."
    - name: "avg_par_level"
      expr: AVG(CAST(par_level AS DOUBLE))
      comment: "Average par level across stock items. Used to calibrate replenishment policies and assess inventory investment levels."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across stock items. Used to calculate effective cost per usable unit for menu costing."
    - name: "active_sku_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active SKUs in the inventory catalog. Portfolio breadth metric for assortment management and supplier consolidation decisions."
    - name: "allergen_item_count"
      expr: COUNT(CASE WHEN allergen_wheat = TRUE OR allergen_milk = TRUE OR allergen_peanuts = TRUE OR allergen_eggs = TRUE OR allergen_fish = TRUE OR allergen_shellfish = TRUE OR allergen_soybeans = TRUE OR allergen_tree_nuts = TRUE THEN 1 END)
      comment: "Number of stock items containing at least one major allergen. Food safety compliance metric for allergen management program."
    - name: "total_sku_count"
      expr: COUNT(1)
      comment: "Total number of stock items in the catalog. Used to monitor catalog growth and complexity for procurement and operations management."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks replenishment order activity, fulfillment performance, and cost. Used by supply chain and operations leadership to monitor order cycle efficiency, supplier responsiveness, and replenishment cost management."
  source: "`vibe_restaurants_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (draft, submitted, confirmed, received, cancelled) for pipeline monitoring."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (emergency, scheduled, auto-generated) for order pattern analysis."
    - name: "order_source"
      expr: order_source
      comment: "Source of the order (manual, system-generated, EDI) for automation adoption tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the order (standard, urgent, critical) for supply chain risk monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the replenishment order for authorization compliance monitoring."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Flag indicating a variance between ordered and received quantities, for supplier fulfillment accuracy tracking."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month bucket of order date for trend analysis of replenishment volume and spend over time."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit placing the replenishment order, for location-level ordering pattern analysis."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used for the replenishment order, for logistics cost optimization."
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of replenishment orders placed. Procurement spend metric used to track supply chain investment and budget adherence."
    - name: "total_amount_due"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount due to suppliers for replenishment orders. Accounts payable liability metric for cash flow management."
    - name: "total_shipping_fee"
      expr: SUM(CAST(shipping_fee AS DOUBLE))
      comment: "Total shipping fees incurred on replenishment orders. Logistics cost metric for freight spend optimization."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on replenishment orders. Tax liability metric for financial reporting and compliance."
    - name: "replenishment_order_count"
      expr: COUNT(1)
      comment: "Total number of replenishment orders. Volume metric for supply chain activity and ordering frequency analysis."
    - name: "variance_order_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of replenishment orders with fulfillment variances. High count signals supplier reliability issues requiring procurement intervention."
    - name: "emergency_order_count"
      expr: COUNT(CASE WHEN priority_level = 'critical' OR order_type = 'emergency' THEN 1 END)
      comment: "Number of emergency or critical priority replenishment orders. High frequency indicates poor demand forecasting or supply chain fragility."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_lot_tracking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks lot-level inventory receipt, quality, and recall status. Used by food safety and supply chain leadership to manage traceability, respond to recalls, and monitor cold chain compliance at the lot level."
  source: "`vibe_restaurants_v1`.`inventory`.`lot_tracking`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the lot (active, quarantine, recalled, consumed, expired) for lot disposition management."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone required for the lot, for cold chain compliance monitoring."
    - name: "quarantine_flag"
      expr: quarantine_flag
      comment: "Flag indicating the lot is under quarantine, for food safety risk management."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Flag indicating the lot is subject to a recall, for rapid response and traceability reporting."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade assigned at receiving, for supplier quality performance tracking."
    - name: "condition_at_receiving"
      expr: condition_at_receiving
      comment: "Condition of the lot when received (acceptable, damaged, rejected) for receiving quality monitoring."
    - name: "received_date"
      expr: DATE_TRUNC('month', received_date)
      comment: "Month bucket of lot receipt date for trend analysis of receiving volume and quality over time."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit that received the lot, for location-level traceability and recall response."
  measures:
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received across all lots. Supply chain volume metric for receiving activity and supplier delivery analysis."
    - name: "total_quantity_remaining"
      expr: SUM(CAST(quantity_remaining AS DOUBLE))
      comment: "Total quantity remaining across active lots. On-hand inventory metric at the lot level for FIFO/FEFO management."
    - name: "quarantine_quantity"
      expr: SUM(CASE WHEN quarantine_flag = TRUE THEN CAST(quantity_remaining AS DOUBLE) ELSE 0 END)
      comment: "Total quantity currently under quarantine. Food safety risk metric — high quarantine volumes signal supplier quality issues."
    - name: "recall_quantity_remaining"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN CAST(quantity_remaining AS DOUBLE) ELSE 0 END)
      comment: "Total quantity remaining from recalled lots. Critical food safety metric for recall response — any non-zero value requires immediate action."
    - name: "avg_temperature_at_receiving"
      expr: AVG(CAST(temperature_at_receiving_f AS DOUBLE))
      comment: "Average temperature recorded at lot receiving. Cold chain compliance metric — deviations from safe ranges indicate food safety risk."
    - name: "lot_count"
      expr: COUNT(1)
      comment: "Total number of lots tracked. Traceability coverage metric for food safety compliance."
    - name: "recalled_lot_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of lots subject to a recall. Food safety KPI — any non-zero value triggers immediate supply chain and operations response."
    - name: "quarantine_lot_count"
      expr: COUNT(CASE WHEN quarantine_flag = TRUE THEN 1 END)
      comment: "Number of lots currently under quarantine. Food safety risk indicator monitored by quality assurance leadership."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks inter-unit stock transfer activity, value, and compliance. Used by supply chain and operations leadership to monitor inventory redistribution efficiency, reduce waste through transfers, and ensure HACCP compliance during transit."
  source: "`vibe_restaurants_v1`.`inventory`.`stock_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the stock transfer (requested, approved, in-transit, received, cancelled) for pipeline monitoring."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (inter-unit, inter-facility, emergency) for transfer pattern analysis."
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Reason for the transfer (surplus redistribution, emergency supply, waste prevention) for root-cause analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer for supply chain urgency monitoring."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flag indicating whether temperature control was required during transit, for cold chain compliance monitoring."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Flag indicating a variance between transferred and received quantities, for transfer accuracy tracking."
    - name: "transfer_request_date"
      expr: DATE_TRUNC('month', transfer_request_date)
      comment: "Month bucket of transfer request date for trend analysis of transfer activity over time."
    - name: "origin_restaurant_unit_id"
      expr: origin_restaurant_unit_id
      comment: "Origin restaurant unit for transfer flow analysis and surplus identification."
    - name: "unit_id"
      expr: unit_id
      comment: "Destination restaurant unit for transfer flow analysis and demand pattern identification."
  measures:
    - name: "total_transfer_value"
      expr: SUM(CAST(total_transfer_value_usd AS DOUBLE))
      comment: "Total value of inventory transferred between units. Measures the scale of inventory redistribution activity and its impact on unit-level inventory valuations."
    - name: "total_quantity_transferred"
      expr: SUM(CAST(total_quantity_transferred AS DOUBLE))
      comment: "Total quantity of inventory transferred. Volume metric for supply chain redistribution efficiency analysis."
    - name: "transfer_count"
      expr: COUNT(1)
      comment: "Total number of stock transfer transactions. Activity metric for supply chain redistribution program monitoring."
    - name: "variance_transfer_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of transfers with quantity or quality variances. High count signals transfer process integrity issues."
    - name: "temperature_controlled_transfer_count"
      expr: COUNT(CASE WHEN temperature_controlled_flag = TRUE THEN 1 END)
      comment: "Number of transfers requiring temperature control. Cold chain compliance volume metric for food safety monitoring."
$$;


CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_vendor_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks vendor item pricing, quality, and delivery performance at the item-supplier level. Used by procurement leadership to manage vendor scorecards, negotiate contracts, and optimize supplier selection."
  source: "`vibe_restaurants_v1`.`inventory`.`vendor_item`"
  dimensions:
    - name: "vendor_item_status"
      expr: vendor_item_status
      comment: "Status of the vendor item (active, discontinued, pending) for catalog management."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Flag indicating whether this is the preferred vendor for the item, for preferred supplier compliance monitoring."
    - name: "contract_price_flag"
      expr: contract_price_flag
      comment: "Flag indicating whether the item is priced under a contract, for contract compliance monitoring."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the vendor item, for supply chain diversification and trade compliance analysis."
    - name: "vendor_product_category"
      expr: vendor_product_category
      comment: "Vendor-assigned product category for cross-vendor category analysis."
    - name: "activation_date"
      expr: DATE_TRUNC('year', activation_date)
      comment: "Year bucket of vendor item activation date for portfolio age analysis."
    - name: "procurement_supplier_id"
      expr: procurement_supplier_id
      comment: "Primary vendor supplier identifier for vendor-level performance aggregation."
  measures:
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across vendor items. Procurement price benchmark used to evaluate vendor competitiveness and negotiate contracts."
    - name: "avg_on_time_delivery_percent"
      expr: AVG(CAST(on_time_delivery_percent AS DOUBLE))
      comment: "Average on-time delivery percentage across vendor items. Supplier reliability KPI used in vendor scorecards and contract renewal decisions."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across vendor items. Supplier quality KPI used to identify underperforming vendors and drive quality improvement programs."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across vendor items. Procurement flexibility metric — high MOQs constrain ordering agility and increase inventory carrying costs."
    - name: "active_vendor_item_count"
      expr: COUNT(CASE WHEN vendor_item_status = 'active' THEN 1 END)
      comment: "Number of active vendor items. Portfolio breadth metric for supplier assortment management."
    - name: "preferred_vendor_item_count"
      expr: COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN 1 END)
      comment: "Number of items sourced from preferred vendors. Preferred supplier compliance metric — low count indicates maverick buying."
    - name: "contract_priced_item_count"
      expr: COUNT(CASE WHEN contract_price_flag = TRUE THEN 1 END)
      comment: "Number of items with contract pricing. Contract coverage metric — higher coverage reduces price volatility risk."
$$;
