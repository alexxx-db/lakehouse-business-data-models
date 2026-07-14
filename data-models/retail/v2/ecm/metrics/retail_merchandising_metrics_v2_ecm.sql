-- Metric views for domain: merchandising | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_merch_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational performance metrics for merchandise plans, enabling buyers and planners to track planned vs. prior-year performance, margin health, and inventory efficiency at category, department, and season level."
  source: "`vibe_retail_v1`.`merchandising`.`merch_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current lifecycle status of the merchandise plan (e.g., draft, approved, active, closed), used to filter active vs. historical plans."
    - name: "plan_type"
      expr: plan_type
      comment: "Classification of the merchandise plan (e.g., initial, revised, final), enabling comparison across plan iterations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which plan financials are denominated, supporting multi-currency reporting."
    - name: "plan_start_date"
      expr: DATE_TRUNC('month', plan_start_date)
      comment: "Month-truncated plan start date for time-series trending of merchandise plans."
    - name: "plan_end_date"
      expr: DATE_TRUNC('month', plan_end_date)
      comment: "Month-truncated plan end date for cohort analysis of plan durations."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the merchandise plan is currently active, enabling quick filtering to live plans."
  measures:
    - name: "total_planned_sales_amount"
      expr: SUM(CAST(planned_sales_amount AS DOUBLE))
      comment: "Total planned sales revenue across all merchandise plans. Core top-line planning KPI used in quarterly business reviews to set revenue targets."
    - name: "total_planned_margin_amount"
      expr: SUM(CAST(planned_margin_amount AS DOUBLE))
      comment: "Total planned gross margin dollars. Directly informs profitability targets and buyer accountability."
    - name: "avg_planned_margin_percent"
      expr: AVG(CAST(planned_margin_percent AS DOUBLE))
      comment: "Average planned gross margin percentage across plans. Signals whether the assortment is planned at healthy margin levels."
    - name: "total_planned_receipt_amount"
      expr: SUM(CAST(planned_receipt_amount AS DOUBLE))
      comment: "Total planned receipt value (cost of goods to be received). Drives open-to-buy and cash flow planning."
    - name: "total_planned_markdown_amount"
      expr: SUM(CAST(planned_markdown_amount AS DOUBLE))
      comment: "Total planned markdown dollars. Elevated markdown spend signals over-buying or weak sell-through and triggers assortment review."
    - name: "avg_planned_markdown_percent"
      expr: AVG(CAST(planned_markdown_percent AS DOUBLE))
      comment: "Average planned markdown rate. Benchmarks markdown aggressiveness across categories and seasons."
    - name: "total_planned_units"
      expr: SUM(CAST(planned_units AS DOUBLE))
      comment: "Total planned unit volume. Used alongside planned sales to validate average unit retail assumptions."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average Gross Margin Return on Inventory Investment target across plans. A primary retail efficiency KPI used by merchants to evaluate inventory productivity."
    - name: "avg_inventory_turn_target"
      expr: AVG(CAST(inventory_turn_target AS DOUBLE))
      comment: "Average planned inventory turn rate. Low turns indicate excess inventory risk; high turns may signal stockout risk."
    - name: "avg_sell_through_target_percent"
      expr: AVG(CAST(sell_through_target_percent AS DOUBLE))
      comment: "Average planned sell-through rate target. Sell-through is a primary in-season health indicator for merchants."
    - name: "total_prior_year_sales_amount"
      expr: SUM(CAST(prior_year_sales_amount AS DOUBLE))
      comment: "Total prior-year sales for year-over-year comparison. Essential for evaluating plan ambition and growth trajectory."
    - name: "avg_prior_year_margin_percent"
      expr: AVG(CAST(prior_year_margin_percent AS DOUBLE))
      comment: "Average prior-year gross margin percentage. Baseline for assessing whether current plans represent margin improvement or erosion."
    - name: "total_planned_cost_amount"
      expr: SUM(CAST(planned_cost_amount AS DOUBLE))
      comment: "Total planned cost of goods. Used in conjunction with planned sales to validate planned margin calculations."
    - name: "total_otb_budget_amount"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total open-to-buy budget allocated across merchandise plans. Controls purchasing spend and prevents over-commitment."
    - name: "plan_count"
      expr: COUNT(DISTINCT merch_plan_id)
      comment: "Number of distinct merchandise plans. Used to understand planning coverage and workload distribution across buyers."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_otb_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open-to-buy budget utilization and efficiency metrics, enabling finance and merchandising leadership to monitor purchasing commitment, budget availability, and inventory investment discipline by category, season, and department."
  source: "`vibe_retail_v1`.`merchandising`.`otb_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the OTB budget (e.g., draft, approved, closed), used to filter to active budgets."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the OTB budget, enabling tracking of budgets pending approval vs. approved."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year associated with the OTB budget for annual planning comparisons."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) for sub-annual OTB budget analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the OTB budget for multi-currency reporting."
    - name: "budget_start_date"
      expr: DATE_TRUNC('month', budget_start_date)
      comment: "Month-truncated budget start date for time-series trending of OTB budget periods."
  measures:
    - name: "total_planned_receipts_at_cost"
      expr: SUM(CAST(planned_receipts_at_cost AS DOUBLE))
      comment: "Total planned receipt value at cost across all OTB budgets. The primary OTB planning figure used to set purchasing limits."
    - name: "total_actual_receipts_at_cost"
      expr: SUM(CAST(actual_receipts_at_cost AS DOUBLE))
      comment: "Total actual receipts received at cost. Compared against planned receipts to measure OTB execution accuracy."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed purchasing spend (open purchase orders). Signals how much of the OTB budget is already obligated."
    - name: "total_available_otb_balance"
      expr: SUM(CAST(available_otb_balance AS DOUBLE))
      comment: "Total remaining open-to-buy balance available for new purchasing commitments. A critical liquidity metric for buyers."
    - name: "total_budget_adjustment_amount"
      expr: SUM(CAST(budget_adjustment_amount AS DOUBLE))
      comment: "Total net budget adjustments applied. Frequent large adjustments indicate planning instability."
    - name: "total_budget_increase_amount"
      expr: SUM(CAST(budget_increase_amount AS DOUBLE))
      comment: "Total upward budget revisions. Tracks how often and by how much budgets are increased, signaling demand upside or planning conservatism."
    - name: "total_budget_decrease_amount"
      expr: SUM(CAST(budget_decrease_amount AS DOUBLE))
      comment: "Total downward budget revisions. Tracks budget cuts driven by demand weakness or cash conservation."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target set within OTB budgets. Ensures inventory investment is planned to deliver adequate returns."
    - name: "avg_inventory_turn_target"
      expr: AVG(CAST(inventory_turn_target AS DOUBLE))
      comment: "Average inventory turn target within OTB budgets. Low targets signal risk of excess inventory build-up."
    - name: "avg_sell_through_target_pct"
      expr: AVG(CAST(sell_through_target_pct AS DOUBLE))
      comment: "Average sell-through target percentage within OTB budgets. Drives markdown and clearance planning assumptions."
    - name: "avg_markdown_budget_pct"
      expr: AVG(CAST(markdown_budget_pct AS DOUBLE))
      comment: "Average markdown budget as a percentage of total OTB. High markdown budget allocation signals anticipated clearance pressure."
    - name: "otb_budget_count"
      expr: COUNT(DISTINCT otb_budget_id)
      comment: "Number of distinct OTB budgets. Used to understand budget granularity and coverage across categories and seasons."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_buying_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchasing order volume, cost, and execution metrics for buying orders, enabling merchandising and supply chain leadership to monitor vendor commitments, landed cost efficiency, and order fulfillment performance."
  source: "`vibe_retail_v1`.`merchandising`.`buying_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the buying order (e.g., submitted, approved, shipped, received, cancelled), used to filter to active vs. closed orders."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the buying order (e.g., domestic, import, direct), enabling analysis by sourcing channel."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the buying order is denominated for multi-currency cost analysis."
    - name: "destination_type"
      expr: destination_type
      comment: "Type of destination for the order (e.g., distribution center, direct-to-store), used to analyze supply chain routing efficiency."
    - name: "fob_terms"
      expr: fob_terms
      comment: "Free-on-board terms for the order, indicating where title and risk transfer from vendor to retailer."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month-truncated order placement date for time-series analysis of purchasing activity."
    - name: "planned_receipt_date"
      expr: DATE_TRUNC('month', planned_receipt_date)
      comment: "Month-truncated planned receipt date for forward-looking inventory arrival planning."
  measures:
    - name: "total_order_cost"
      expr: SUM(CAST(total_order_cost AS DOUBLE))
      comment: "Total cost of all buying orders. Primary purchasing spend KPI used by finance and merchandising to track cost of goods commitments."
    - name: "total_landed_cost"
      expr: SUM(CAST(landed_cost AS DOUBLE))
      comment: "Total landed cost including freight, duty, and other import costs. Landed cost drives true margin calculations and sourcing decisions."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across buying orders. Elevated freight costs erode margin and trigger logistics optimization reviews."
    - name: "total_duty_cost"
      expr: SUM(CAST(duty_cost AS DOUBLE))
      comment: "Total import duty cost. Tracks tariff exposure and informs sourcing country diversification decisions."
    - name: "total_order_quantity"
      expr: SUM(CAST(total_order_quantity AS DOUBLE))
      comment: "Total units ordered across all buying orders. Used to validate volume commitments against assortment plans."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to buying orders. Monitors currency exposure on import purchasing."
    - name: "buying_order_count"
      expr: COUNT(DISTINCT buying_order_id)
      comment: "Number of distinct buying orders placed. Tracks purchasing activity volume and vendor engagement breadth."
    - name: "avg_order_cost"
      expr: AVG(CAST(total_order_cost AS DOUBLE))
      comment: "Average cost per buying order. Benchmarks order size and helps identify fragmented vs. consolidated purchasing patterns."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_buying_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level purchasing metrics for buying order lines, enabling detailed analysis of ordered vs. received quantities, unit costs, planned margins, and drop-ship activity at the SKU and category level."
  source: "`vibe_retail_v1`.`merchandising`.`buying_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the buying order line (e.g., open, received, cancelled), used to filter active vs. closed lines."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the order line for multi-currency cost analysis."
    - name: "drop_ship_flag"
      expr: drop_ship_flag
      comment: "Indicates whether the line is fulfilled via drop-ship directly from vendor to customer, enabling drop-ship vs. warehouse fulfillment analysis."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the ordered item is a private label product, enabling private label vs. national brand purchasing analysis."
    - name: "delivery_date"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month-truncated delivery date for time-series analysis of inbound inventory flow."
  measures:
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all buying order lines. Core volume metric for purchasing and inventory planning."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units actually received. Compared against ordered quantity to measure vendor fill rate and order completion."
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total units cancelled from buying order lines. High cancellation rates signal vendor reliability issues or demand forecast errors."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost (unit cost × quantity) across all order lines. Primary cost-of-goods metric at line level."
    - name: "total_planned_margin_amount"
      expr: SUM(CAST(planned_margin_amount AS DOUBLE))
      comment: "Total planned gross margin dollars at order line level. Validates that purchasing decisions support margin targets."
    - name: "avg_planned_margin_percent"
      expr: AVG(CAST(planned_margin_percent AS DOUBLE))
      comment: "Average planned margin percentage across order lines. Signals whether buying decisions are margin-accretive."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across buying order lines. Tracks cost trends and vendor negotiation effectiveness."
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price AS DOUBLE))
      comment: "Average planned retail price across order lines. Used alongside unit cost to validate initial markup assumptions."
    - name: "total_allocation_quantity"
      expr: SUM(CAST(allocation_quantity AS DOUBLE))
      comment: "Total quantity allocated to stores from buying order lines. Measures how effectively purchased inventory is distributed."
    - name: "buying_order_line_count"
      expr: COUNT(DISTINCT buying_order_line_id)
      comment: "Number of distinct buying order lines. Tracks purchasing granularity and SKU-level commitment breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_markdown_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Markdown event performance metrics tracking the financial impact, sell-through lift, and vendor contribution of markdown activity, enabling merchants and finance teams to evaluate markdown effectiveness and manage margin erosion."
  source: "`vibe_retail_v1`.`merchandising`.`markdown_event`"
  dimensions:
    - name: "markdown_status"
      expr: markdown_status
      comment: "Current status of the markdown event (e.g., planned, active, completed, cancelled), used to filter to active vs. historical markdowns."
    - name: "markdown_type"
      expr: markdown_type
      comment: "Type of markdown (e.g., permanent, promotional, clearance), enabling analysis of markdown strategy mix."
    - name: "markdown_reason"
      expr: markdown_reason
      comment: "Business reason for the markdown (e.g., slow sell-through, end-of-season, competitive response), used to diagnose root causes of margin pressure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of markdown financials for multi-currency reporting."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month-truncated markdown effective date for time-series analysis of markdown cadence and seasonality."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether the markdown required management approval, enabling governance and compliance analysis."
  measures:
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total markdown dollars taken across all markdown events. Primary metric for tracking margin erosion from price reductions."
    - name: "avg_markdown_percentage"
      expr: AVG(CAST(markdown_percentage AS DOUBLE))
      comment: "Average markdown depth as a percentage of original price. Measures aggressiveness of pricing actions."
    - name: "total_actual_revenue_impact"
      expr: SUM(CAST(actual_revenue_impact AS DOUBLE))
      comment: "Total actual revenue impact from markdown events. Quantifies the top-line effect of markdown activity."
    - name: "total_projected_revenue_impact"
      expr: SUM(CAST(projected_revenue_impact AS DOUBLE))
      comment: "Total projected revenue impact at time of markdown planning. Compared against actual to evaluate markdown forecasting accuracy."
    - name: "total_actual_margin_impact"
      expr: SUM(CAST(actual_margin_impact AS DOUBLE))
      comment: "Total actual gross margin impact from markdowns. Critical for P&L management and markdown ROI evaluation."
    - name: "total_projected_margin_impact"
      expr: SUM(CAST(projected_margin_impact AS DOUBLE))
      comment: "Total projected margin impact at planning time. Variance vs. actual signals markdown modeling accuracy."
    - name: "avg_actual_sell_through_lift_pct"
      expr: AVG(CAST(actual_sell_through_lift_percentage AS DOUBLE))
      comment: "Average actual sell-through lift percentage achieved by markdown events. Measures markdown effectiveness in accelerating inventory clearance."
    - name: "avg_projected_sell_through_lift_pct"
      expr: AVG(CAST(projected_sell_through_lift_percentage AS DOUBLE))
      comment: "Average projected sell-through lift at planning time. Compared against actual to assess markdown planning model quality."
    - name: "total_vendor_contribution_amount"
      expr: SUM(CAST(vendor_contribution_amount AS DOUBLE))
      comment: "Total vendor funding contribution to markdown events. Tracks how much markdown cost is offset by vendor allowances, protecting retailer margin."
    - name: "markdown_event_count"
      expr: COUNT(DISTINCT markdown_event_id)
      comment: "Number of distinct markdown events. Tracks markdown activity volume and frequency as a signal of inventory health."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_assortment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment planning metrics tracking SKU breadth, depth, private label mix, and financial targets, enabling category managers and buyers to evaluate assortment strategy effectiveness and open-to-buy discipline."
  source: "`vibe_retail_v1`.`merchandising`.`assortment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current lifecycle status of the assortment plan (e.g., draft, approved, active, closed)."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of assortment plan (e.g., seasonal, annual, event-driven), enabling analysis by planning horizon."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the assortment plan for annual performance comparisons."
    - name: "otb_currency_code"
      expr: otb_currency_code
      comment: "Currency in which the OTB budget is denominated for multi-currency financial analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated plan effective start date for time-series analysis of assortment plan coverage."
    - name: "planogram_required_flag"
      expr: planogram_required_flag
      comment: "Indicates whether the assortment plan requires a planogram, enabling compliance tracking for space planning."
  measures:
    - name: "total_otb_budget_amount"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total open-to-buy budget allocated across assortment plans. Controls purchasing investment and prevents over-commitment."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average GMROI target set in assortment plans. Ensures assortments are planned to deliver adequate inventory returns."
    - name: "avg_target_inventory_turn_rate"
      expr: AVG(CAST(target_inventory_turn_rate AS DOUBLE))
      comment: "Average planned inventory turn rate. Low targets signal risk of excess inventory; high targets may indicate stockout risk."
    - name: "avg_target_sell_through_rate_percent"
      expr: AVG(CAST(target_sell_through_rate_percent AS DOUBLE))
      comment: "Average planned sell-through rate target. Primary in-season health indicator for assortment performance."
    - name: "avg_private_label_mix_percent"
      expr: AVG(CAST(private_label_mix_percent AS DOUBLE))
      comment: "Average planned private label penetration percentage. Tracks progress toward private label strategy goals, which typically carry higher margins."
    - name: "assortment_plan_count"
      expr: COUNT(DISTINCT assortment_plan_id)
      comment: "Number of distinct assortment plans. Tracks planning coverage and workload across buyers and categories."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_assortment_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level assortment item metrics tracking planned financial performance, sell-through targets, and lifecycle status, enabling buyers to evaluate item-level assortment decisions and identify underperforming or at-risk items."
  source: "`vibe_retail_v1`.`merchandising`.`assortment_item`"
  dimensions:
    - name: "inclusion_status"
      expr: inclusion_status
      comment: "Whether the item is included, excluded, or pending in the assortment, used to filter to active assortment items."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the item (e.g., new, core, declining, exit), enabling lifecycle-based assortment management."
    - name: "assortment_role"
      expr: assortment_role
      comment: "Strategic role of the item in the assortment (e.g., traffic driver, margin builder, image), used for role-based performance analysis."
    - name: "assortment_depth_tier"
      expr: assortment_depth_tier
      comment: "Depth tier classification of the item (e.g., core, optional, test), enabling tiered assortment analysis."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the item is a private label product, enabling private label vs. national brand performance comparison."
    - name: "clearance_strategy"
      expr: clearance_strategy
      comment: "Planned clearance approach for the item (e.g., markdown, return-to-vendor, donate), used to manage end-of-life inventory."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated item effective start date for time-series analysis of assortment additions."
  measures:
    - name: "avg_planned_aur"
      expr: AVG(CAST(planned_aur AS DOUBLE))
      comment: "Average planned unit retail price across assortment items. Validates pricing strategy and average ticket assumptions."
    - name: "avg_planned_gmroi"
      expr: AVG(CAST(planned_gmroi AS DOUBLE))
      comment: "Average planned GMROI at item level. Identifies items that are planned to underdeliver on inventory return."
    - name: "avg_planned_sell_through_rate"
      expr: AVG(CAST(planned_sell_through_rate AS DOUBLE))
      comment: "Average planned sell-through rate across assortment items. Items with low planned sell-through are candidates for assortment reduction."
    - name: "avg_planned_weeks_of_supply"
      expr: AVG(CAST(planned_weeks_of_supply AS DOUBLE))
      comment: "Average planned weeks of supply at item level. Excessive weeks of supply signals over-buying risk."
    - name: "assortment_item_count"
      expr: COUNT(DISTINCT assortment_item_id)
      comment: "Total number of distinct assortment items (SKU-plan combinations). Measures assortment breadth and complexity."
    - name: "private_label_item_count"
      expr: SUM(CASE WHEN private_label_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of private label items in the assortment. Tracks private label penetration at item level against strategic targets."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category-level performance and planning metrics tracking actual vs. target GMROI, sell-through, margin, and inventory turns, enabling category managers to evaluate category health and prioritize strategic interventions."
  source: "`vibe_retail_v1`.`merchandising`.`category`"
  dimensions:
    - name: "category_status"
      expr: category_status
      comment: "Current status of the category (e.g., active, discontinued, under review), used to filter to active categories."
    - name: "category_role"
      expr: category_role
      comment: "Strategic role of the category (e.g., destination, routine, convenience, occasional), used for role-based performance benchmarking."
    - name: "merchandise_type"
      expr: merchandise_type
      comment: "Type of merchandise in the category (e.g., hardlines, softlines, grocery), enabling cross-merchandise-type analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level of the category in the merchandise hierarchy (e.g., department, class, subclass), used to filter analysis to the appropriate hierarchy level."
    - name: "division"
      expr: division
      comment: "Business division owning the category, enabling divisional performance rollups."
    - name: "seasonality_flag"
      expr: seasonality_flag
      comment: "Indicates whether the category has significant seasonal demand patterns, used to contextualize performance metrics."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year-truncated category effective start date for cohort analysis of category age and maturity."
  measures:
    - name: "avg_actual_gmroi"
      expr: AVG(CAST(actual_gmroi AS DOUBLE))
      comment: "Average actual Gross Margin Return on Inventory Investment across categories. Primary retail efficiency KPI for evaluating inventory productivity."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average GMROI target across categories. Used alongside actual GMROI to measure performance vs. plan."
    - name: "avg_actual_sell_through_rate"
      expr: AVG(CAST(actual_sell_through_rate AS DOUBLE))
      comment: "Average actual sell-through rate across categories. Low sell-through signals over-buying or weak demand and triggers markdown or assortment action."
    - name: "avg_target_sell_through_rate"
      expr: AVG(CAST(target_sell_through_rate AS DOUBLE))
      comment: "Average sell-through target across categories. Baseline for evaluating actual sell-through performance."
    - name: "avg_target_margin_percent"
      expr: AVG(CAST(target_margin_percent AS DOUBLE))
      comment: "Average planned gross margin percentage target across categories. Tracks whether category margin ambitions are realistic and achievable."
    - name: "avg_target_inventory_turns"
      expr: AVG(CAST(target_inventory_turns AS DOUBLE))
      comment: "Average planned inventory turn target across categories. Benchmarks inventory efficiency expectations."
    - name: "total_otb_budget_amount"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total open-to-buy budget allocated at category level. Tracks purchasing investment by category for budget governance."
    - name: "avg_private_label_penetration_target"
      expr: AVG(CAST(private_label_penetration_target AS DOUBLE))
      comment: "Average private label penetration target across categories. Monitors progress toward private label strategy, which drives margin improvement."
    - name: "category_count"
      expr: COUNT(DISTINCT category_id)
      comment: "Number of distinct active categories. Tracks assortment breadth and category management scope."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_vendor_negotiation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor negotiation outcome metrics tracking cost changes, allowances, co-op advertising funds, and fill rate commitments, enabling buyers and procurement leadership to evaluate negotiation effectiveness and vendor partnership value."
  source: "`vibe_retail_v1`.`merchandising`.`vendor_negotiation`"
  dimensions:
    - name: "negotiation_status"
      expr: negotiation_status
      comment: "Current status of the vendor negotiation (e.g., in-progress, completed, cancelled), used to filter to active vs. closed negotiations."
    - name: "negotiation_type"
      expr: negotiation_type
      comment: "Type of negotiation (e.g., annual cost review, promotional allowance, new item), enabling analysis by negotiation purpose."
    - name: "allowance_type"
      expr: allowance_type
      comment: "Type of vendor allowance negotiated (e.g., markdown support, co-op advertising, volume rebate), used to analyze allowance mix."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the negotiation, enabling tracking of pending vs. approved agreements."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of negotiation financials for multi-currency reporting."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month-truncated negotiation effective date for time-series analysis of negotiation activity."
  measures:
    - name: "avg_cost_change_percentage"
      expr: AVG(CAST(cost_change_percentage AS DOUBLE))
      comment: "Average cost change percentage negotiated with vendors. Negative values indicate cost reductions; positive values signal cost inflation requiring margin management."
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total vendor allowance dollars negotiated. Allowances directly offset cost of goods and improve effective margin."
    - name: "total_coop_advertising_fund"
      expr: SUM(CAST(coop_advertising_fund AS DOUBLE))
      comment: "Total co-op advertising funds secured from vendors. Reduces marketing spend burden on the retailer."
    - name: "total_markdown_support_amount"
      expr: SUM(CAST(markdown_support_amount AS DOUBLE))
      comment: "Total vendor markdown support dollars negotiated. Protects retailer margin during promotional and clearance events."
    - name: "avg_fill_rate_commitment_percentage"
      expr: AVG(CAST(fill_rate_commitment_percentage AS DOUBLE))
      comment: "Average vendor fill rate commitment percentage. Low fill rate commitments signal supply reliability risk and potential stockout exposure."
    - name: "avg_new_cost_price"
      expr: AVG(CAST(new_cost_price AS DOUBLE))
      comment: "Average negotiated new cost price across vendor negotiations. Tracks cost trend direction and negotiation outcomes."
    - name: "avg_old_cost_price"
      expr: AVG(CAST(old_cost_price AS DOUBLE))
      comment: "Average prior cost price before negotiation. Used alongside new cost price to calculate cost change magnitude."
    - name: "vendor_negotiation_count"
      expr: COUNT(DISTINCT vendor_negotiation_id)
      comment: "Number of distinct vendor negotiations. Tracks negotiation activity volume and vendor engagement breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_private_label_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Private label program performance metrics tracking investment, margin targets, sell-through, and sustainability certification, enabling merchandising leadership to evaluate private label strategy execution and ROI."
  source: "`vibe_retail_v1`.`merchandising`.`private_label_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the private label program (e.g., active, discontinued, in-development), used to filter to active programs."
    - name: "quality_tier"
      expr: quality_tier
      comment: "Quality positioning tier of the private label program (e.g., premium, standard, value), enabling tier-based performance analysis."
    - name: "competitive_positioning"
      expr: competitive_positioning
      comment: "Competitive positioning strategy of the program (e.g., price parity, premium, value), used to analyze positioning effectiveness."
    - name: "sustainability_certified_flag"
      expr: sustainability_certified_flag
      comment: "Indicates whether the program has sustainability certification, enabling ESG-aligned assortment analysis."
    - name: "exclusive_flag"
      expr: exclusive_flag
      comment: "Indicates whether the private label program is exclusive to the retailer, used to track exclusive assortment breadth."
    - name: "seasonal_flag"
      expr: seasonal_flag
      comment: "Indicates whether the program is seasonal, enabling seasonal vs. evergreen private label performance comparison."
    - name: "launch_date"
      expr: DATE_TRUNC('year', launch_date)
      comment: "Year-truncated program launch date for cohort analysis of private label program maturity and performance trajectory."
  measures:
    - name: "total_marketing_investment_usd"
      expr: SUM(CAST(marketing_investment_usd AS DOUBLE))
      comment: "Total marketing investment in private label programs. Tracks spend required to build brand awareness and drive adoption."
    - name: "total_otb_budget_amount"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total open-to-buy budget allocated to private label programs. Measures purchasing investment in own-brand development."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average GMROI target for private label programs. Private label typically targets higher GMROI than national brands."
    - name: "avg_target_margin_premium_pct"
      expr: AVG(CAST(target_margin_premium_pct AS DOUBLE))
      comment: "Average planned margin premium percentage over national brand equivalents. Quantifies the margin advantage private label is expected to deliver."
    - name: "avg_target_sell_through_rate_pct"
      expr: AVG(CAST(target_sell_through_rate_pct AS DOUBLE))
      comment: "Average planned sell-through rate for private label programs. Tracks whether private label inventory is planned to clear efficiently."
    - name: "avg_target_price_point_usd"
      expr: AVG(CAST(target_price_point_usd AS DOUBLE))
      comment: "Average planned retail price point for private label programs. Validates pricing strategy relative to competitive positioning."
    - name: "private_label_program_count"
      expr: COUNT(DISTINCT private_label_program_id)
      comment: "Number of distinct private label programs. Tracks the breadth of own-brand portfolio development."
    - name: "sustainability_certified_program_count"
      expr: SUM(CASE WHEN sustainability_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of private label programs with sustainability certification. Tracks ESG commitment in own-brand assortment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_planogram`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planogram space productivity and compliance metrics, enabling visual merchandising and category management teams to evaluate space allocation efficiency, GMROI per square foot, and planogram compliance across store clusters and departments."
  source: "`vibe_retail_v1`.`merchandising`.`merchandising_planogram`"
  dimensions:
    - name: "merchandising_planogram_status"
      expr: merchandising_planogram_status
      comment: "Current status of the planogram (e.g., draft, approved, active, retired), used to filter to live planograms."
    - name: "fixture_type"
      expr: fixture_type
      comment: "Type of fixture used in the planogram (e.g., gondola, end-cap, wall unit), enabling fixture-type performance analysis."
    - name: "seasonal_flag"
      expr: seasonal_flag
      comment: "Indicates whether the planogram is seasonal, enabling seasonal vs. evergreen space planning analysis."
    - name: "compliance_required_flag"
      expr: compliance_required_flag
      comment: "Indicates whether planogram compliance is mandatory, used to prioritize compliance monitoring efforts."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated planogram effective start date for time-series analysis of planogram resets."
  measures:
    - name: "total_space_allocation_sqft"
      expr: SUM(CAST(space_allocation_sqft AS DOUBLE))
      comment: "Total square footage allocated across planograms. Tracks space investment by category and department."
    - name: "avg_space_allocation_sqft"
      expr: AVG(CAST(space_allocation_sqft AS DOUBLE))
      comment: "Average space allocation per planogram. Benchmarks space productivity expectations across fixture types."
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average GMROI target set for planograms. Ensures space is allocated to categories with adequate inventory return expectations."
    - name: "avg_target_sales_per_sqft"
      expr: AVG(CAST(target_sales_per_sqft AS DOUBLE))
      comment: "Average planned sales per square foot across planograms. Primary space productivity KPI used to evaluate and optimize space allocation."
    - name: "avg_compliance_tolerance_pct"
      expr: AVG(CAST(compliance_tolerance_pct AS DOUBLE))
      comment: "Average compliance tolerance percentage across planograms. Tracks how much deviation from the planogram is permitted before triggering a compliance flag."
    - name: "planogram_count"
      expr: COUNT(DISTINCT merchandising_planogram_id)
      comment: "Number of distinct active planograms. Tracks space planning coverage across the store estate."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_buyer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buyer business metrics"
  source: "`vibe_retail_v1`.`merchandising`.`buyer`"
  dimensions:
    - name: "Assigned Category Codes"
      expr: assigned_category_codes
    - name: "Assigned Department Codes"
      expr: assigned_department_codes
    - name: "Assortment Planning System Access"
      expr: assortment_planning_system_access
    - name: "Buyer Code"
      expr: buyer_code
    - name: "Buyer Name"
      expr: buyer_name
    - name: "Buyer Status"
      expr: buyer_status
    - name: "Buyer Type"
      expr: buyer_type
    - name: "Certification Credentials"
      expr: certification_credentials
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Division Code"
      expr: division_code
    - name: "Email Address"
      expr: email_address
    - name: "Hire Date"
      expr: hire_date
    - name: "International Sourcing Flag"
      expr: international_sourcing_flag
    - name: "Language Proficiency"
      expr: language_proficiency
    - name: "Last Modified By User"
      expr: last_modified_by_user
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Buyer"
      expr: COUNT(DISTINCT buyer_id)
    - name: "Total Buying Authority Limit"
      expr: SUM(buying_authority_limit)
    - name: "Average Buying Authority Limit"
      expr: AVG(buying_authority_limit)
    - name: "Total Gmroi Target"
      expr: SUM(gmroi_target)
    - name: "Average Gmroi Target"
      expr: AVG(gmroi_target)
    - name: "Total Inventory Turn Target"
      expr: SUM(inventory_turn_target)
    - name: "Average Inventory Turn Target"
      expr: AVG(inventory_turn_target)
    - name: "Total Markdown Percentage Limit"
      expr: SUM(markdown_percentage_limit)
    - name: "Average Markdown Percentage Limit"
      expr: AVG(markdown_percentage_limit)
    - name: "Total Otb Budget Limit"
      expr: SUM(otb_budget_limit)
    - name: "Average Otb Budget Limit"
      expr: AVG(otb_budget_limit)
    - name: "Total Sell Through Rate Target"
      expr: SUM(sell_through_rate_target)
    - name: "Average Sell Through Rate Target"
      expr: AVG(sell_through_rate_target)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_buyer_profit_center_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buyer Profit Center Assignment business metrics"
  source: "`vibe_retail_v1`.`merchandising`.`buyer_profit_center_assignment`"
  dimensions:
    - name: "Assigned Category List"
      expr: assigned_category_list
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Primary Flag"
      expr: primary_flag
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
    - name: "Effective Start Date Month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Buyer Profit Center Assignment"
      expr: COUNT(DISTINCT buyer_profit_center_assignment_id)
    - name: "Total Otb Allocation Amount"
      expr: SUM(otb_allocation_amount)
    - name: "Average Otb Allocation Amount"
      expr: AVG(otb_allocation_amount)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_category_accrual_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category Accrual Rule business metrics"
  source: "`vibe_retail_v1`.`merchandising`.`category_accrual_rule`"
  dimensions:
    - name: "Category Accrual Rule Status"
      expr: category_accrual_rule_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Rule Priority"
      expr: rule_priority
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Category Accrual Rule"
      expr: COUNT(DISTINCT category_accrual_rule_id)
    - name: "Total Minimum Spend Threshold"
      expr: SUM(minimum_spend_threshold)
    - name: "Average Minimum Spend Threshold"
      expr: AVG(minimum_spend_threshold)
    - name: "Total Points Multiplier"
      expr: SUM(points_multiplier)
    - name: "Average Points Multiplier"
      expr: AVG(points_multiplier)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_category_campaign_placement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category Campaign Placement business metrics"
  source: "`vibe_retail_v1`.`merchandising`.`category_campaign_placement`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Featured"
      expr: is_featured
    - name: "Placement Status"
      expr: placement_status
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Category Campaign Placement"
      expr: COUNT(DISTINCT category_campaign_placement_id)
    - name: "Total Actual Sales Amount"
      expr: SUM(actual_sales_amount)
    - name: "Average Actual Sales Amount"
      expr: AVG(actual_sales_amount)
    - name: "Total Actual Spend Amount"
      expr: SUM(actual_spend_amount)
    - name: "Average Actual Spend Amount"
      expr: AVG(actual_spend_amount)
    - name: "Total Budget Allocation Amount"
      expr: SUM(budget_allocation_amount)
    - name: "Average Budget Allocation Amount"
      expr: AVG(budget_allocation_amount)
    - name: "Total Target Sales Amount"
      expr: SUM(target_sales_amount)
    - name: "Average Target Sales Amount"
      expr: AVG(target_sales_amount)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_merchandising_planogram`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Merchandising Planogram business metrics"
  source: "`vibe_retail_v1`.`merchandising`.`merchandising_planogram`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Compliance Required Flag"
      expr: compliance_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fixture Type"
      expr: fixture_type
    - name: "Implementation Instructions"
      expr: implementation_instructions
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Reset Date"
      expr: last_reset_date
    - name: "Merchandising Planogram Status"
      expr: merchandising_planogram_status
    - name: "Next Scheduled Reset Date"
      expr: next_scheduled_reset_date
    - name: "Planogram Code"
      expr: planogram_code
    - name: "Planogram Name"
      expr: planogram_name
    - name: "Seasonal Flag"
      expr: seasonal_flag
    - name: "Shelf Count"
      expr: shelf_count
    - name: "Space Planning System Code"
      expr: space_planning_system_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Merchandising Planogram"
      expr: COUNT(DISTINCT merchandising_planogram_id)
    - name: "Total Compliance Tolerance Pct"
      expr: SUM(compliance_tolerance_pct)
    - name: "Average Compliance Tolerance Pct"
      expr: AVG(compliance_tolerance_pct)
    - name: "Total Fixture Depth Cm"
      expr: SUM(fixture_depth_cm)
    - name: "Average Fixture Depth Cm"
      expr: AVG(fixture_depth_cm)
    - name: "Total Fixture Height Cm"
      expr: SUM(fixture_height_cm)
    - name: "Average Fixture Height Cm"
      expr: AVG(fixture_height_cm)
    - name: "Total Fixture Width Cm"
      expr: SUM(fixture_width_cm)
    - name: "Average Fixture Width Cm"
      expr: AVG(fixture_width_cm)
    - name: "Total Space Allocation Sqft"
      expr: SUM(space_allocation_sqft)
    - name: "Average Space Allocation Sqft"
      expr: AVG(space_allocation_sqft)
    - name: "Total Target Gmroi"
      expr: SUM(target_gmroi)
    - name: "Average Target Gmroi"
      expr: AVG(target_gmroi)
    - name: "Total Target Sales Per Sqft"
      expr: SUM(target_sales_per_sqft)
    - name: "Average Target Sales Per Sqft"
      expr: AVG(target_sales_per_sqft)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_planogram_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planogram Position business metrics"
  source: "`vibe_retail_v1`.`merchandising`.`planogram_position`"
  dimensions:
    - name: "Bay Number"
      expr: bay_number
    - name: "Capacity Units"
      expr: capacity_units
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Orientation"
      expr: display_orientation
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Facing Count"
      expr: facing_count
    - name: "Fixture Type"
      expr: fixture_type
    - name: "Is Hero Position"
      expr: is_hero_position
    - name: "Is New Item"
      expr: is_new_item
    - name: "Is Promotional"
      expr: is_promotional
    - name: "Last Audit Date"
      expr: last_audit_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Maximum Facings"
      expr: maximum_facings
    - name: "Merchandising Zone"
      expr: merchandising_zone
    - name: "Minimum Facings"
      expr: minimum_facings
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Planogram Position"
      expr: COUNT(DISTINCT planogram_position_id)
    - name: "Total Compliance Score"
      expr: SUM(compliance_score)
    - name: "Average Compliance Score"
      expr: AVG(compliance_score)
    - name: "Total Position Depth Cm"
      expr: SUM(position_depth_cm)
    - name: "Average Position Depth Cm"
      expr: AVG(position_depth_cm)
    - name: "Total Position Height Cm"
      expr: SUM(position_height_cm)
    - name: "Average Position Height Cm"
      expr: AVG(position_height_cm)
    - name: "Total Position Width Cm"
      expr: SUM(position_width_cm)
    - name: "Average Position Width Cm"
      expr: AVG(position_width_cm)
    - name: "Total Space Productivity Index"
      expr: SUM(space_productivity_index)
    - name: "Average Space Productivity Index"
      expr: AVG(space_productivity_index)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_season`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Season business metrics"
  source: "`vibe_retail_v1`.`merchandising`.`season`"
  dimensions:
    - name: "Assortment Breadth Target"
      expr: assortment_breadth_target
    - name: "Assortment Depth Target"
      expr: assortment_depth_target
    - name: "Buy Deadline Date"
      expr: buy_deadline_date
    - name: "Clearance Exit Date"
      expr: clearance_exit_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "End Date"
      expr: end_date
    - name: "First Receipt Date"
      expr: first_receipt_date
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Active"
      expr: is_active
    - name: "Line Review Date"
      expr: line_review_date
    - name: "Markdown Entry Date"
      expr: markdown_entry_date
    - name: "Notes"
      expr: notes
    - name: "Planning Start Date"
      expr: planning_start_date
    - name: "Season Code"
      expr: season_code
    - name: "Season Name"
      expr: season_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Season"
      expr: COUNT(DISTINCT season_id)
    - name: "Total Otb Budget Amount"
      expr: SUM(otb_budget_amount)
    - name: "Average Otb Budget Amount"
      expr: AVG(otb_budget_amount)
    - name: "Total Target Gmroi"
      expr: SUM(target_gmroi)
    - name: "Average Target Gmroi"
      expr: AVG(target_gmroi)
    - name: "Total Target Inventory Turns"
      expr: SUM(target_inventory_turns)
    - name: "Average Target Inventory Turns"
      expr: AVG(target_inventory_turns)
    - name: "Total Target Sell Through Rate"
      expr: SUM(target_sell_through_rate)
    - name: "Average Target Sell Through Rate"
      expr: AVG(target_sell_through_rate)
$$;