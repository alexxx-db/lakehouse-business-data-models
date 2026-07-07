-- Metric views for domain: inventory | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_food_cost_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic food cost performance metrics by period, unit, and franchisee. Tracks actual vs theoretical food cost, variance, and waste to drive margin management decisions."
  source: "`vibe_restaurants_v1`.`inventory`.`food_cost_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of cost period (weekly, monthly, period) for time-based grouping of food cost analysis."
    - name: "period_status"
      expr: period_status
      comment: "Status of the food cost period (open, closed, approved) to filter actionable vs finalized periods."
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the food cost period for time-series trending."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the food cost period for time-series trending."
    - name: "count_method"
      expr: count_method
      comment: "Inventory count method used (physical, theoretical, hybrid) affecting cost accuracy."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which food cost values are denominated."
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Reason for any cost period adjustment, used to identify systemic issues."
  measures:
    - name: "total_actual_food_cost"
      expr: SUM(CAST(actual_food_cost AS DOUBLE))
      comment: "Total actual food cost across all periods. Core P&L input for restaurant margin management."
    - name: "total_theoretical_food_cost"
      expr: SUM(CAST(theoretical_food_cost AS DOUBLE))
      comment: "Total theoretical food cost based on recipe standards. Baseline for variance analysis."
    - name: "total_food_cost_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total dollar variance between actual and theoretical food cost. Drives investigation and corrective action."
    - name: "avg_cogs_percent_actual"
      expr: AVG(CAST(cogs_percent_actual AS DOUBLE))
      comment: "Average actual COGS as a percentage of sales. Key profitability KPI tracked at every QBR."
    - name: "avg_cogs_percent_theoretical"
      expr: AVG(CAST(cogs_percent_theoretical AS DOUBLE))
      comment: "Average theoretical COGS percentage based on recipe standards. Benchmark for actual performance."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average food cost variance percentage. Signals systemic waste, theft, or portioning issues."
    - name: "total_waste_value"
      expr: SUM(CAST(waste_value AS DOUBLE))
      comment: "Total dollar value of food waste across periods. Directly impacts food cost and sustainability targets."
    - name: "avg_waste_percent"
      expr: AVG(CAST(waste_percent AS DOUBLE))
      comment: "Average waste as a percentage of food cost. Operational efficiency KPI for waste reduction programs."
    - name: "total_food_sales_revenue"
      expr: SUM(CAST(food_sales_revenue AS DOUBLE))
      comment: "Total food sales revenue used as the denominator for food cost percentage calculations."
    - name: "total_beverage_sales_revenue"
      expr: SUM(CAST(beverage_sales_revenue AS DOUBLE))
      comment: "Total beverage sales revenue for category-level margin analysis."
    - name: "total_purchases_value"
      expr: SUM(CAST(purchases_value AS DOUBLE))
      comment: "Total value of inventory purchases in the period. Key input for food cost and cash flow management."
    - name: "total_opening_inventory_value"
      expr: SUM(CAST(opening_inventory_value AS DOUBLE))
      comment: "Total opening inventory value across periods. Used in food cost formula and balance sheet reporting."
    - name: "total_closing_inventory_value"
      expr: SUM(CAST(closing_inventory_value AS DOUBLE))
      comment: "Total closing inventory value across periods. Used in food cost formula and balance sheet reporting."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total value of manual adjustments applied to food cost periods. High values signal data quality or control issues."
    - name: "period_count"
      expr: COUNT(1)
      comment: "Number of food cost periods. Used to normalize averages and track reporting cadence."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustment analytics tracking the volume, value, and nature of stock corrections. Drives shrinkage control, HACCP compliance, and financial accuracy programs."
  source: "`vibe_restaurants_v1`.`inventory`.`inventory_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (waste, theft, spoilage, count correction) for root-cause categorization."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the adjustment. Enables trend analysis by cause."
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste associated with the adjustment for waste reduction program targeting."
    - name: "adjustment_date"
      expr: adjustment_date
      comment: "Date the adjustment was recorded for time-series trending."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the adjustment (pending, approved, rejected) for control monitoring."
    - name: "is_shrinkage"
      expr: is_shrinkage
      comment: "Flag indicating whether the adjustment represents shrinkage (theft, spoilage) for loss prevention reporting."
    - name: "impacts_cogs"
      expr: impacts_cogs
      comment: "Flag indicating whether the adjustment impacts cost of goods sold for financial reporting."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Flag indicating whether the adjustment has been reversed, for net impact calculations."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the adjusted quantity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which adjustment values are denominated."
  measures:
    - name: "total_adjustment_value"
      expr: SUM(CAST(adjustment_value AS DOUBLE))
      comment: "Total dollar value of all inventory adjustments. Key financial control metric for shrinkage and loss management."
    - name: "total_adjusted_quantity"
      expr: SUM(CAST(adjusted_quantity AS DOUBLE))
      comment: "Total quantity adjusted across all inventory adjustment records. Operational volume metric."
    - name: "total_shrinkage_value"
      expr: SUM(CASE WHEN is_shrinkage = TRUE THEN adjustment_value ELSE 0 END)
      comment: "Total dollar value of shrinkage adjustments (theft, spoilage). Core loss prevention KPI."
    - name: "avg_unit_cost_at_adjustment"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost at time of adjustment. Used to assess whether high-value items are disproportionately affected."
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of inventory adjustments. High frequency signals control weaknesses or data quality issues."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Number of adjustments awaiting approval. Operational backlog metric for inventory control teams."
    - name: "distinct_stock_items_adjusted"
      expr: COUNT(DISTINCT stock_item_id)
      comment: "Number of distinct stock items with adjustments. Breadth indicator for inventory control issues."
    - name: "avg_on_hand_quantity_before"
      expr: AVG(CAST(on_hand_quantity_before AS DOUBLE))
      comment: "Average on-hand quantity before adjustment. Context for assessing adjustment materiality."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_ingredient_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient usage efficiency metrics comparing actual vs theoretical consumption. Drives food cost variance analysis, waste reduction, and recipe compliance programs."
  source: "`vibe_restaurants_v1`.`inventory`.`inventory_ingredient_usage`"
  dimensions:
    - name: "usage_date"
      expr: usage_date
      comment: "Date of ingredient usage for daily and weekly trend analysis."
    - name: "usage_period"
      expr: usage_period
      comment: "Named usage period (e.g., week 1, period 3) for period-over-period comparison."
    - name: "usage_type"
      expr: usage_type
      comment: "Type of usage (production, waste, transfer) for categorized consumption analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for usage quantities."
    - name: "usage_period_start"
      expr: usage_period_start
      comment: "Start date of the usage period for time-range filtering."
    - name: "usage_period_end"
      expr: usage_period_end
      comment: "End date of the usage period for time-range filtering."
  measures:
    - name: "total_actual_usage"
      expr: SUM(CAST(actual_usage AS DOUBLE))
      comment: "Total actual ingredient usage quantity. Primary consumption metric for supply planning and cost management."
    - name: "total_theoretical_usage"
      expr: SUM(CAST(theoretical_usage AS DOUBLE))
      comment: "Total theoretical ingredient usage based on recipe standards. Benchmark for actual consumption."
    - name: "total_usage_variance"
      expr: SUM(CAST(variance AS DOUBLE))
      comment: "Total variance between actual and theoretical usage. Drives recipe compliance and waste reduction initiatives."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between actual and theoretical usage. Operational metric for portioning control."
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total waste quantity recorded during usage periods. Key input for waste reduction programs."
    - name: "total_usage_cost"
      expr: SUM(CAST(total_usage_cost AS DOUBLE))
      comment: "Total cost of ingredient usage across all records. Core food cost input for P&L management."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit of ingredient used. Tracks price inflation and supplier performance impact on food cost."
    - name: "avg_monthly_usage"
      expr: AVG(CAST(average_monthly_usage AS DOUBLE))
      comment: "Average monthly ingredient usage for demand forecasting and par level setting."
    - name: "distinct_ingredients_tracked"
      expr: COUNT(DISTINCT ingredient_id)
      comment: "Number of distinct ingredients with usage records. Coverage metric for ingredient tracking completeness."
    - name: "usage_record_count"
      expr: COUNT(1)
      comment: "Total number of ingredient usage records. Volume metric for tracking cadence and completeness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_on_hand_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time inventory position metrics tracking stock levels, valuation, and reorder status. Drives replenishment decisions, working capital management, and stockout prevention."
  source: "`vibe_restaurants_v1`.`inventory`.`on_hand_balance`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (available, reserved, expired, quarantine) for actionable stock management."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the stock item (A=high value, B=medium, C=low) for prioritized inventory management."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Storage temperature zone (ambient, refrigerated, frozen) for cold chain compliance monitoring."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Flag indicating perishable items requiring priority management to minimize spoilage."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (FIFO, LIFO, weighted average) for financial reporting context."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for on-hand quantities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for inventory valuation."
    - name: "cycle_count_frequency"
      expr: cycle_count_frequency
      comment: "Frequency of cycle counts for this item, used to assess count coverage and compliance."
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(extended_value AS DOUBLE))
      comment: "Total extended value of on-hand inventory. Core balance sheet metric and working capital indicator."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity on hand across all locations. Primary stock availability metric."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available (on-hand minus reserved). Actual usable stock for operations."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved for pending orders or transfers. Commitment visibility metric."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across all stock positions. Tracks cost inflation and valuation trends."
    - name: "avg_days_until_expiration"
      expr: AVG(CAST(days_until_expiration AS DOUBLE))
      comment: "Average days until expiration across perishable inventory. Critical metric for spoilage risk management."
    - name: "total_variance_from_par"
      expr: SUM(CAST(variance_from_par AS DOUBLE))
      comment: "Total variance from par levels across all stock positions. Negative values signal stockout risk; positive signals overstock."
    - name: "items_below_reorder_point"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN 1 END)
      comment: "Number of stock items below reorder point. Urgent replenishment trigger metric for operations."
    - name: "items_below_safety_stock"
      expr: COUNT(CASE WHEN quantity_on_hand < safety_stock THEN 1 END)
      comment: "Number of items below safety stock threshold. Critical stockout risk indicator requiring immediate action."
    - name: "distinct_stock_items_on_hand"
      expr: COUNT(DISTINCT on_stock_item_id)
      comment: "Number of distinct stock items with on-hand balances. Inventory breadth metric."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_physical_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory count accuracy and compliance metrics. Tracks count completion, variance discovery, and financial impact to ensure inventory integrity and audit readiness."
  source: "`vibe_restaurants_v1`.`inventory`.`physical_count`"
  dimensions:
    - name: "count_type"
      expr: count_type
      comment: "Type of physical count (full, cycle, spot) for categorized accuracy analysis."
    - name: "count_status"
      expr: count_status
      comment: "Current status of the count (scheduled, in-progress, completed, approved) for workflow monitoring."
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (manual, scanner, blind) affecting accuracy benchmarking."
    - name: "count_date"
      expr: count_date
      comment: "Date the physical count was conducted for time-series compliance tracking."
    - name: "is_period_end_count"
      expr: is_period_end_count
      comment: "Flag indicating whether this is a period-end count required for financial close."
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Flag indicating a recount was required due to variance, signaling count quality issues."
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Reason code for count variance to identify systemic accuracy issues."
  measures:
    - name: "total_physical_inventory_value"
      expr: SUM(CAST(physical_inventory_value AS DOUBLE))
      comment: "Total physical inventory value as counted. Core balance sheet input for period-end financial close."
    - name: "total_system_inventory_value"
      expr: SUM(CAST(system_inventory_value AS DOUBLE))
      comment: "Total system inventory value before count adjustment. Baseline for variance calculation."
    - name: "total_count_variance_amount"
      expr: SUM(CAST(total_variance_amount AS DOUBLE))
      comment: "Total dollar variance between physical and system inventory. Financial materiality metric for audit and control."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(total_variance_percentage AS DOUBLE))
      comment: "Average inventory variance percentage across counts. Key accuracy KPI for inventory integrity programs."
    - name: "total_sku_counted"
      expr: SUM(CAST(total_sku_counted AS DOUBLE))
      comment: "Total number of SKUs counted across all physical counts. Coverage completeness metric."
    - name: "total_sku_with_variance"
      expr: SUM(CAST(total_sku_with_variance AS DOUBLE))
      comment: "Total number of SKUs with count variances. Breadth of discrepancy metric for root-cause investigation."
    - name: "count_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(total_sku_counted AS DOUBLE) - CAST(total_sku_with_variance AS DOUBLE)) / NULLIF(SUM(CAST(total_sku_counted AS DOUBLE)), 0), 2)
      comment: "Percentage of SKUs counted without variance. Primary inventory accuracy KPI for operational excellence."
    - name: "physical_count_events"
      expr: COUNT(1)
      comment: "Total number of physical count events. Compliance metric for count frequency requirements."
    - name: "recount_required_count"
      expr: COUNT(CASE WHEN recount_required_flag = TRUE THEN 1 END)
      comment: "Number of counts requiring a recount. Quality indicator for count process effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_waste_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food waste analytics tracking waste volume, cost, and root causes by category, station, and time. Drives waste reduction programs, sustainability reporting, and food cost improvement."
  source: "`vibe_restaurants_v1`.`inventory`.`waste_log`"
  dimensions:
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (overproduction, spoilage, trim, expired) for targeted reduction programs."
    - name: "waste_reason"
      expr: waste_reason
      comment: "Specific reason for waste to identify root causes and drive corrective action."
    - name: "waste_date"
      expr: waste_date
      comment: "Date waste was recorded for daily and weekly trend analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart (breakfast, lunch, dinner) when waste occurred for operational timing analysis."
    - name: "responsible_station"
      expr: responsible_station
      comment: "Kitchen station responsible for the waste for station-level accountability."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of disposal (compost, trash, donation) for sustainability reporting."
    - name: "haccp_violation"
      expr: haccp_violation
      comment: "Flag indicating waste was due to a HACCP violation, requiring food safety escalation."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for waste quantities."
  measures:
    - name: "total_waste_cost"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total dollar cost of food waste. Primary financial metric for waste reduction ROI calculations."
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total quantity of food wasted. Volume metric for sustainability and operational efficiency programs."
    - name: "avg_waste_cost_per_event"
      expr: AVG(CAST(waste_cost AS DOUBLE))
      comment: "Average cost per waste event. Identifies high-impact waste incidents requiring investigation."
    - name: "haccp_violation_waste_cost"
      expr: SUM(CASE WHEN haccp_violation = TRUE THEN waste_cost ELSE 0 END)
      comment: "Total waste cost attributable to HACCP violations. Food safety compliance and risk metric."
    - name: "waste_event_count"
      expr: COUNT(1)
      comment: "Total number of waste events recorded. Frequency metric for waste culture and tracking compliance."
    - name: "distinct_items_wasted"
      expr: COUNT(DISTINCT stock_item_id)
      comment: "Number of distinct stock items with waste records. Breadth indicator for waste program targeting."
    - name: "avg_on_hand_before_waste"
      expr: AVG(CAST(on_hand_quantity_before_waste AS DOUBLE))
      comment: "Average on-hand quantity before waste event. Context for assessing whether waste is driven by overstock."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_receiving_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier delivery performance and receiving quality metrics. Tracks on-time delivery, temperature compliance, and variance rates to drive supplier accountability and food safety."
  source: "`vibe_restaurants_v1`.`inventory`.`receiving_order`"
  dimensions:
    - name: "receiving_status"
      expr: receiving_status
      comment: "Status of the receiving order (pending, received, rejected, partial) for workflow monitoring."
    - name: "delivery_timeliness"
      expr: delivery_timeliness
      comment: "Timeliness classification (on-time, early, late) for supplier delivery performance scoring."
    - name: "quality_inspection_result"
      expr: quality_inspection_result
      comment: "Result of quality inspection at receiving (pass, fail, conditional) for supplier quality tracking."
    - name: "temperature_check_result"
      expr: temperature_check_result
      comment: "Temperature check result at receiving for cold chain compliance monitoring."
    - name: "delivery_date"
      expr: delivery_date
      comment: "Actual delivery date for time-series supplier performance analysis."
    - name: "receiving_shift"
      expr: receiving_shift
      comment: "Shift during which receiving occurred for operational staffing analysis."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Flag indicating a quantity or quality variance was found at receiving."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for received value amounts."
  measures:
    - name: "total_received_value"
      expr: SUM(CAST(total_received_value AS DOUBLE))
      comment: "Total value of goods received. Key procurement spend and inventory investment metric."
    - name: "total_items_received"
      expr: SUM(CAST(total_items_received AS DOUBLE))
      comment: "Total number of items received across all orders. Volume metric for receiving operations."
    - name: "total_items_ordered"
      expr: SUM(CAST(total_items_ordered AS DOUBLE))
      comment: "Total number of items ordered. Used with items received to calculate fill rate."
    - name: "fill_rate_percent"
      expr: ROUND(100.0 * SUM(CAST(total_items_received AS DOUBLE)) / NULLIF(SUM(CAST(total_items_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered items actually received. Supplier reliability KPI for procurement negotiations."
    - name: "avg_temperature_recorded"
      expr: AVG(CAST(temperature_recorded AS DOUBLE))
      comment: "Average temperature recorded at receiving. Cold chain compliance metric for food safety programs."
    - name: "receiving_order_count"
      expr: COUNT(1)
      comment: "Total number of receiving orders. Volume metric for receiving operations capacity planning."
    - name: "variance_order_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of receiving orders with variances. Supplier accuracy metric driving corrective action."
    - name: "variance_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN variance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receiving orders with variances. Supplier quality KPI for vendor scorecards."
    - name: "distinct_suppliers_received_from"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers with receiving activity. Supply base diversity and dependency metric."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prep yield efficiency metrics comparing actual vs standard yield percentages. Drives recipe compliance, food cost accuracy, and prep training effectiveness."
  source: "`vibe_restaurants_v1`.`inventory`.`yield_record`"
  dimensions:
    - name: "prep_type"
      expr: prep_type
      comment: "Type of prep activity (butchering, portioning, cooking) for yield analysis by prep category."
    - name: "prep_date"
      expr: prep_date
      comment: "Date of prep activity for time-series yield trend analysis."
    - name: "prep_station_name"
      expr: prep_station_name
      comment: "Name of the prep station for station-level yield performance benchmarking."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade of the yield output for quality-adjusted yield analysis."
    - name: "haccp_compliant"
      expr: haccp_compliant
      comment: "Flag indicating HACCP compliance during prep for food safety yield analysis."
    - name: "raw_unit_of_measure"
      expr: raw_unit_of_measure
      comment: "Unit of measure for raw input quantities."
    - name: "waste_reason_code"
      expr: waste_reason_code
      comment: "Reason code for yield waste to identify systemic prep inefficiencies."
  measures:
    - name: "avg_actual_yield_percentage"
      expr: AVG(CAST(actual_yield_percentage AS DOUBLE))
      comment: "Average actual yield percentage across all prep records. Core prep efficiency KPI for recipe compliance."
    - name: "avg_standard_yield_percentage"
      expr: AVG(CAST(standard_yield_percentage AS DOUBLE))
      comment: "Average standard yield percentage from recipe specifications. Benchmark for actual yield performance."
    - name: "avg_yield_variance_percentage"
      expr: AVG(CAST(yield_variance_percentage AS DOUBLE))
      comment: "Average variance between actual and standard yield. Drives prep training and recipe calibration decisions."
    - name: "total_raw_quantity_in"
      expr: SUM(CAST(raw_quantity_in AS DOUBLE))
      comment: "Total raw ingredient quantity processed. Volume metric for prep capacity and ingredient demand planning."
    - name: "total_usable_yield_quantity"
      expr: SUM(CAST(usable_yield_quantity_out AS DOUBLE))
      comment: "Total usable yield quantity produced. Output metric for production planning and menu availability."
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total waste quantity from prep activities. Drives waste reduction and cost improvement programs."
    - name: "total_raw_cost"
      expr: SUM(CAST(total_raw_cost AS DOUBLE))
      comment: "Total cost of raw ingredients processed. Input for food cost and yield-adjusted cost calculations."
    - name: "avg_cost_per_yield_unit"
      expr: AVG(CAST(cost_per_yield_unit AS DOUBLE))
      comment: "Average cost per unit of usable yield. Yield-adjusted cost metric for accurate menu costing."
    - name: "yield_record_count"
      expr: COUNT(1)
      comment: "Total number of yield records. Tracking completeness metric for prep documentation compliance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_prep_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prep usage efficiency metrics tracking actual vs theoretical ingredient consumption during food preparation. Drives recipe adherence, food cost control, and kitchen training programs."
  source: "`vibe_restaurants_v1`.`inventory`.`prep_usage`"
  dimensions:
    - name: "prep_type"
      expr: prep_type
      comment: "Type of prep activity for categorized usage analysis."
    - name: "prep_date"
      expr: prep_date
      comment: "Date of prep activity for time-series usage trend analysis."
    - name: "prep_station_name"
      expr: prep_station_name
      comment: "Prep station name for station-level efficiency benchmarking."
    - name: "prep_usage_status"
      expr: prep_usage_status
      comment: "Status of the prep usage record (completed, voided, adjusted) for data quality filtering."
    - name: "haccp_compliant"
      expr: haccp_compliant
      comment: "HACCP compliance flag for food safety-filtered usage analysis."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade of prep output for quality-adjusted cost analysis."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for shift-level prep efficiency analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for prep quantities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for prep cost values."
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of prep activities. Core food cost input for P&L and recipe costing."
    - name: "total_theoretical_cost"
      expr: SUM(CAST(theoretical_cost AS DOUBLE))
      comment: "Total theoretical prep cost based on recipe standards. Benchmark for actual cost performance."
    - name: "total_cost_variance"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total cost variance between actual and theoretical prep. Drives recipe compliance and training investment decisions."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average prep cost variance percentage. KPI for recipe adherence and kitchen efficiency programs."
    - name: "total_actual_quantity_used"
      expr: SUM(CAST(actual_quantity_used AS DOUBLE))
      comment: "Total actual quantity of ingredients used in prep. Volume metric for ingredient demand planning."
    - name: "total_theoretical_quantity"
      expr: SUM(CAST(theoretical_quantity AS DOUBLE))
      comment: "Total theoretical quantity per recipe standards. Baseline for quantity variance analysis."
    - name: "total_quantity_variance"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between actual and theoretical prep usage. Portioning control metric."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of ingredients used in prep. Tracks ingredient cost inflation impact on prep economics."
    - name: "prep_usage_record_count"
      expr: COUNT(1)
      comment: "Total number of prep usage records. Documentation completeness metric."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-unit stock transfer analytics tracking volume, value, and efficiency of inventory movements between locations. Drives network inventory optimization and transfer cost management."
  source: "`vibe_restaurants_v1`.`inventory`.`stock_transfer`"
  dimensions:
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (inter-unit, DC-to-unit, emergency) for categorized movement analysis."
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the transfer (requested, approved, in-transit, received) for workflow monitoring."
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Reason code for the transfer (overstock, shortage, expiry) for root-cause analysis."
    - name: "transfer_request_date"
      expr: transfer_request_date
      comment: "Date transfer was requested for lead time and cycle time analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer (urgent, standard, low) for operational triage."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used for the transfer for cost and speed benchmarking."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flag indicating temperature-controlled transfer for cold chain compliance tracking."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Flag indicating a quantity variance was found upon receipt of the transfer."
  measures:
    - name: "total_transfer_value"
      expr: SUM(CAST(total_transfer_value_usd AS DOUBLE))
      comment: "Total dollar value of inventory transferred. Working capital movement metric for network optimization."
    - name: "total_quantity_transferred"
      expr: SUM(CAST(total_quantity_transferred AS DOUBLE))
      comment: "Total quantity of items transferred across the network. Volume metric for transfer operations."
    - name: "total_item_count_transferred"
      expr: SUM(CAST(total_item_count AS DOUBLE))
      comment: "Total number of line items transferred. Operational complexity metric for transfer processing."
    - name: "transfer_count"
      expr: COUNT(1)
      comment: "Total number of stock transfer events. Frequency metric for network inventory movement analysis."
    - name: "variance_transfer_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of transfers with quantity variances upon receipt. Transfer accuracy metric."
    - name: "transfer_variance_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN variance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers with variances. Transfer process quality KPI for network operations."
    - name: "avg_transfer_value"
      expr: AVG(CAST(total_transfer_value_usd AS DOUBLE))
      comment: "Average value per transfer event. Benchmark for transfer economics and cost-benefit analysis."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order efficiency and spend metrics. Tracks order fulfillment, delivery performance, and procurement spend to optimize inventory replenishment cycles."
  source: "`vibe_restaurants_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (draft, submitted, approved, received) for pipeline monitoring."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (automatic, manual, emergency) for process efficiency analysis."
    - name: "order_source"
      expr: order_source
      comment: "Source system or trigger for the order (par-based, forecast, manual) for automation effectiveness tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the order for procurement control monitoring."
    - name: "order_date"
      expr: order_date
      comment: "Date the order was placed for time-series procurement analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the replenishment order for operational triage and SLA tracking."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method for the replenishment order for cost and speed benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for order value amounts."
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of replenishment orders placed. Core procurement spend metric for budget management."
    - name: "total_amount_due"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount due for replenishment orders. Accounts payable and cash flow planning metric."
    - name: "total_shipping_fee"
      expr: SUM(CAST(shipping_fee AS DOUBLE))
      comment: "Total shipping fees for replenishment orders. Logistics cost metric for supplier negotiation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on replenishment orders. Tax compliance and cost management metric."
    - name: "replenishment_order_count"
      expr: COUNT(1)
      comment: "Total number of replenishment orders. Volume metric for procurement operations capacity planning."
    - name: "variance_order_count"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Number of replenishment orders with delivery variances. Supplier reliability metric."
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average replenishment order value. Benchmark for order sizing efficiency and minimum order optimization."
    - name: "distinct_suppliers_ordered_from"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers used for replenishment. Supply base concentration risk metric."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_food_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food cost performance metrics per period"
  source: "`vibe_restaurants_v1`.`inventory`.`food_cost_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of cost period (e.g., monthly, weekly)"
    - name: "period_status"
      expr: period_status
      comment: "Current status of the period"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the cost period"
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Identifier of the franchisee"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of monetary values"
  measures:
    - name: "period_count"
      expr: COUNT(1)
      comment: "Number of food cost periods"
    - name: "total_actual_food_cost"
      expr: SUM(CAST(actual_food_cost AS DOUBLE))
      comment: "Total actual food cost across periods"
    - name: "total_food_sales_revenue"
      expr: SUM(CAST(food_sales_revenue AS DOUBLE))
      comment: "Total food sales revenue across periods"
    - name: "avg_cogs_percent_actual"
      expr: AVG(CAST(cogs_percent_actual AS DOUBLE))
      comment: "Average actual COGS percent"
    - name: "avg_cogs_percent_theoretical"
      expr: AVG(CAST(cogs_percent_theoretical AS DOUBLE))
      comment: "Average theoretical COGS percent"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance amount between actual and theoretical costs"
    - name: "avg_waste_percent"
      expr: AVG(CAST(waste_percent AS DOUBLE))
      comment: "Average waste percent"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_waste`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste tracking metrics for operational efficiency"
  source: "`vibe_restaurants_v1`.`inventory`.`waste_log`"
  dimensions:
    - name: "waste_date"
      expr: waste_date
      comment: "Date the waste was recorded"
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (e.g., spoilage, preparation)"
    - name: "waste_reason"
      expr: waste_reason
      comment: "Reason provided for waste"
  measures:
    - name: "waste_event_count"
      expr: COUNT(1)
      comment: "Number of waste log events"
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total quantity of waste recorded"
    - name: "total_waste_cost"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total monetary cost of waste"
    - name: "avg_waste_cost_per_event"
      expr: AVG(CAST(waste_cost AS DOUBLE))
      comment: "Average cost per waste event"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`inventory_yield`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield and waste efficiency metrics for recipe preparation"
  source: "`vibe_restaurants_v1`.`inventory`.`yield_record`"
  dimensions:
    - name: "prep_date"
      expr: prep_date
      comment: "Date of the preparation"
    - name: "recipe_id"
      expr: recipe_id
      comment: "Identifier of the recipe"
    - name: "waste_reason_code"
      expr: waste_reason_code
      comment: "Code indicating reason for waste"
  measures:
    - name: "yield_record_count"
      expr: COUNT(1)
      comment: "Number of yield records captured"
    - name: "avg_actual_yield_percentage"
      expr: AVG(CAST(actual_yield_percentage AS DOUBLE))
      comment: "Average actual yield percentage across recipes"
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage across preparations"
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total waste quantity recorded in yield processes"
$$;