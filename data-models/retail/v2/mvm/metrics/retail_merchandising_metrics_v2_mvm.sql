-- Metric views for domain: merchandising | Business: Retail | Version: 2 | Generated on: 2026-07-12 15:23:39

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_assortment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic assortment planning KPIs tracking plan performance, OTB budget utilization, and target achievement across clusters and categories"
  source: "`vibe_retail_v1`.`merchandising`.`assortment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the assortment plan (draft, approved, active, closed)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of assortment plan (seasonal, promotional, core, test)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the assortment plan"
    - name: "cluster_strategy"
      expr: cluster_strategy_description
      comment: "Description of the clustering strategy applied to this plan"
    - name: "planogram_required"
      expr: planogram_required_flag
      comment: "Whether planogram compliance is required for this plan"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year when the assortment plan becomes effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_start_date))
      comment: "Quarter when the assortment plan becomes effective"
  measures:
    - name: "total_assortment_plans"
      expr: COUNT(DISTINCT assortment_plan_id)
      comment: "Total number of unique assortment plans"
    - name: "total_otb_budget"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total open-to-buy budget allocated across all plans"
    - name: "avg_otb_budget_per_plan"
      expr: AVG(CAST(otb_budget_amount AS DOUBLE))
      comment: "Average OTB budget per assortment plan"
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average target gross margin return on investment across plans"
    - name: "avg_target_inventory_turn"
      expr: AVG(CAST(target_inventory_turn_rate AS DOUBLE))
      comment: "Average target inventory turn rate across plans"
    - name: "avg_target_sell_through_pct"
      expr: AVG(CAST(target_sell_through_rate_percent AS DOUBLE))
      comment: "Average target sell-through rate percentage across plans"
    - name: "avg_private_label_mix_pct"
      expr: AVG(CAST(private_label_mix_percent AS DOUBLE))
      comment: "Average private label mix percentage target across plans"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_assortment_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level assortment performance KPIs tracking lifecycle stage, planned financial targets, and compliance status"
  source: "`vibe_retail_v1`.`merchandising`.`assortment_item`"
  dimensions:
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the assortment item (new, active, markdown, clearance, discontinued)"
    - name: "inclusion_status"
      expr: inclusion_status
      comment: "Whether the item is included in the assortment (included, excluded, pending)"
    - name: "assortment_role"
      expr: assortment_role
      comment: "Strategic role of the item in the assortment (hero, core, seasonal, filler)"
    - name: "assortment_depth_tier"
      expr: assortment_depth_tier
      comment: "Depth tier classification (deep, medium, shallow)"
    - name: "clearance_strategy"
      expr: clearance_strategy
      comment: "Strategy for clearing out the item (aggressive, standard, hold)"
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Whether the item is a private label product"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding status of the item (pending, in_progress, complete, failed)"
    - name: "cpsc_certification_status"
      expr: cpsc_certification_status
      comment: "Consumer Product Safety Commission certification status"
    - name: "fda_certification_status"
      expr: fda_certification_status
      comment: "Food and Drug Administration certification status"
    - name: "go_live_year_month"
      expr: DATE_TRUNC('MONTH', go_live_date)
      comment: "Month when the item went live in the assortment"
  measures:
    - name: "total_assortment_items"
      expr: COUNT(DISTINCT assortment_item_id)
      comment: "Total number of unique items in the assortment"
    - name: "total_planned_aur"
      expr: SUM(CAST(planned_aur AS DOUBLE))
      comment: "Total planned average unit retail across all assortment items"
    - name: "avg_planned_aur"
      expr: AVG(CAST(planned_aur AS DOUBLE))
      comment: "Average planned average unit retail per item"
    - name: "avg_planned_gmroi"
      expr: AVG(CAST(planned_gmroi AS DOUBLE))
      comment: "Average planned gross margin return on investment per item"
    - name: "avg_planned_sell_through_rate"
      expr: AVG(CAST(planned_sell_through_rate AS DOUBLE))
      comment: "Average planned sell-through rate per item"
    - name: "avg_planned_weeks_of_supply"
      expr: AVG(CAST(planned_weeks_of_supply AS DOUBLE))
      comment: "Average planned weeks of supply per item"
    - name: "private_label_item_count"
      expr: COUNT(DISTINCT CASE WHEN private_label_flag = TRUE THEN assortment_item_id END)
      comment: "Count of private label items in the assortment"
    - name: "planogram_required_item_count"
      expr: COUNT(DISTINCT CASE WHEN planogram_position_required = TRUE THEN assortment_item_id END)
      comment: "Count of items requiring planogram positioning"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_buying_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order KPIs tracking order value, landed costs, freight efficiency, and order fulfillment performance"
  source: "`vibe_retail_v1`.`merchandising`.`buying_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the buying order (draft, submitted, approved, shipped, received, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of buying order (regular, drop_ship, direct_import, consignment)"
    - name: "destination_type"
      expr: destination_type
      comment: "Type of destination (DC, store, cross_dock)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the order"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated with vendor"
    - name: "fob_terms"
      expr: fob_terms
      comment: "Free on board terms for shipping responsibility"
    - name: "order_year_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month when the order was placed"
    - name: "order_quarter"
      expr: CONCAT('Q', QUARTER(order_date))
      comment: "Quarter when the order was placed"
    - name: "cancellation_reason"
      expr: cancellation_reason_code
      comment: "Reason code for order cancellation"
  measures:
    - name: "total_buying_orders"
      expr: COUNT(DISTINCT buying_order_id)
      comment: "Total number of unique buying orders"
    - name: "total_order_cost"
      expr: SUM(CAST(total_order_cost AS DOUBLE))
      comment: "Total cost of all buying orders"
    - name: "total_order_quantity"
      expr: SUM(CAST(total_order_quantity AS DOUBLE))
      comment: "Total quantity ordered across all buying orders"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all orders"
    - name: "total_duty_cost"
      expr: SUM(CAST(duty_cost AS DOUBLE))
      comment: "Total duty cost across all orders"
    - name: "total_landed_cost"
      expr: SUM(CAST(landed_cost AS DOUBLE))
      comment: "Total landed cost including freight and duties"
    - name: "avg_order_cost"
      expr: AVG(CAST(total_order_cost AS DOUBLE))
      comment: "Average cost per buying order"
    - name: "avg_freight_cost_per_order"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per order"
    - name: "avg_landed_cost_per_order"
      expr: AVG(CAST(landed_cost AS DOUBLE))
      comment: "Average landed cost per order"
    - name: "cancelled_order_count"
      expr: COUNT(DISTINCT CASE WHEN order_status = 'cancelled' THEN buying_order_id END)
      comment: "Count of cancelled buying orders"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_buying_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order line-level KPIs tracking unit economics, margin performance, fulfillment efficiency, and private label penetration"
  source: "`vibe_retail_v1`.`merchandising`.`buying_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (open, received, cancelled, short)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the order line"
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Whether the order line is for a private label item"
    - name: "drop_ship_flag"
      expr: drop_ship_flag
      comment: "Whether the order line is drop-shipped directly to customer"
    - name: "store_cluster"
      expr: store_cluster_code
      comment: "Store cluster code for allocation"
    - name: "delivery_year_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month when the order line is scheduled for delivery"
  measures:
    - name: "total_order_lines"
      expr: COUNT(DISTINCT buying_order_line_id)
      comment: "Total number of unique order lines"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all lines"
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total quantity cancelled across all lines"
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost across all order lines"
    - name: "total_planned_margin_amount"
      expr: SUM(CAST(planned_margin_amount AS DOUBLE))
      comment: "Total planned margin dollars across all order lines"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per order line"
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price AS DOUBLE))
      comment: "Average retail price per order line"
    - name: "avg_planned_margin_pct"
      expr: AVG(CAST(planned_margin_percent AS DOUBLE))
      comment: "Average planned margin percentage per order line"
    - name: "private_label_line_count"
      expr: COUNT(DISTINCT CASE WHEN private_label_flag = TRUE THEN buying_order_line_id END)
      comment: "Count of private label order lines"
    - name: "drop_ship_line_count"
      expr: COUNT(DISTINCT CASE WHEN drop_ship_flag = TRUE THEN buying_order_line_id END)
      comment: "Count of drop-ship order lines"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category performance KPIs tracking financial targets, actual performance, GMROI, sell-through rates, and strategic objectives"
  source: "`vibe_retail_v1`.`merchandising`.`category`"
  dimensions:
    - name: "category_status"
      expr: category_status
      comment: "Current status of the category (active, inactive, under_review)"
    - name: "category_role"
      expr: category_role
      comment: "Strategic role of the category (destination, routine, seasonal, convenience)"
    - name: "merchandise_type"
      expr: merchandise_type
      comment: "Type of merchandise in the category (hardlines, softlines, consumables)"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the category hierarchy (division, department, class, subclass)"
    - name: "is_leaf_node"
      expr: is_leaf_node
      comment: "Whether this is a leaf node in the category hierarchy"
    - name: "seasonality_flag"
      expr: seasonality_flag
      comment: "Whether the category has seasonal demand patterns"
    - name: "peak_season"
      expr: peak_season
      comment: "Peak selling season for the category"
    - name: "division"
      expr: division
      comment: "Division to which the category belongs"
    - name: "strategic_objective"
      expr: strategic_objective
      comment: "Strategic objective for the category (grow, maintain, harvest, exit)"
  measures:
    - name: "total_categories"
      expr: COUNT(DISTINCT category_id)
      comment: "Total number of unique categories"
    - name: "total_otb_budget"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total open-to-buy budget allocated across categories"
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average target gross margin return on investment across categories"
    - name: "avg_actual_gmroi"
      expr: AVG(CAST(actual_gmroi AS DOUBLE))
      comment: "Average actual gross margin return on investment across categories"
    - name: "avg_target_inventory_turns"
      expr: AVG(CAST(target_inventory_turns AS DOUBLE))
      comment: "Average target inventory turns across categories"
    - name: "avg_target_margin_pct"
      expr: AVG(CAST(target_margin_percent AS DOUBLE))
      comment: "Average target margin percentage across categories"
    - name: "avg_target_sell_through_rate"
      expr: AVG(CAST(target_sell_through_rate AS DOUBLE))
      comment: "Average target sell-through rate across categories"
    - name: "avg_actual_sell_through_rate"
      expr: AVG(CAST(actual_sell_through_rate AS DOUBLE))
      comment: "Average actual sell-through rate across categories"
    - name: "avg_private_label_penetration_target"
      expr: AVG(CAST(private_label_penetration_target AS DOUBLE))
      comment: "Average private label penetration target percentage across categories"
    - name: "seasonal_category_count"
      expr: COUNT(DISTINCT CASE WHEN seasonality_flag = TRUE THEN category_id END)
      comment: "Count of categories with seasonal demand patterns"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_merch_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Merchandise financial planning KPIs tracking planned vs prior year sales, margin, markdown, inventory, and turn targets"
  source: "`vibe_retail_v1`.`merchandising`.`merch_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the merchandise plan (draft, approved, active, closed)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of merchandise plan (annual, seasonal, promotional, ad_hoc)"
    - name: "is_active"
      expr: is_active
      comment: "Whether the merchandise plan is currently active"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the plan financials"
    - name: "plan_year"
      expr: YEAR(plan_start_date)
      comment: "Year when the merchandise plan starts"
    - name: "plan_quarter"
      expr: CONCAT('Q', QUARTER(plan_start_date))
      comment: "Quarter when the merchandise plan starts"
  measures:
    - name: "total_merch_plans"
      expr: COUNT(DISTINCT merch_plan_id)
      comment: "Total number of unique merchandise plans"
    - name: "total_planned_sales"
      expr: SUM(CAST(planned_sales_amount AS DOUBLE))
      comment: "Total planned sales amount across all plans"
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost_amount AS DOUBLE))
      comment: "Total planned cost amount across all plans"
    - name: "total_planned_margin"
      expr: SUM(CAST(planned_margin_amount AS DOUBLE))
      comment: "Total planned margin dollars across all plans"
    - name: "total_planned_markdown"
      expr: SUM(CAST(planned_markdown_amount AS DOUBLE))
      comment: "Total planned markdown dollars across all plans"
    - name: "total_planned_receipts"
      expr: SUM(CAST(planned_receipt_amount AS DOUBLE))
      comment: "Total planned receipt amount across all plans"
    - name: "total_planned_units"
      expr: SUM(CAST(planned_units AS DOUBLE))
      comment: "Total planned units across all plans"
    - name: "total_otb_budget"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total open-to-buy budget across all plans"
    - name: "avg_planned_margin_pct"
      expr: AVG(CAST(planned_margin_percent AS DOUBLE))
      comment: "Average planned margin percentage across plans"
    - name: "avg_planned_markdown_pct"
      expr: AVG(CAST(planned_markdown_percent AS DOUBLE))
      comment: "Average planned markdown percentage across plans"
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target across plans"
    - name: "avg_inventory_turn_target"
      expr: AVG(CAST(inventory_turn_target AS DOUBLE))
      comment: "Average inventory turn target across plans"
    - name: "avg_sell_through_target_pct"
      expr: AVG(CAST(sell_through_target_percent AS DOUBLE))
      comment: "Average sell-through target percentage across plans"
    - name: "total_prior_year_sales"
      expr: SUM(CAST(prior_year_sales_amount AS DOUBLE))
      comment: "Total prior year sales amount for comparison"
    - name: "total_prior_year_units"
      expr: SUM(CAST(prior_year_units AS DOUBLE))
      comment: "Total prior year units for comparison"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_otb_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open-to-buy budget management KPIs tracking budget utilization, commitments, available balance, and financial performance targets"
  source: "`vibe_retail_v1`.`merchandising`.`otb_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the OTB budget (draft, approved, active, closed, exhausted)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget (pending, approved, rejected)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the OTB budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for the OTB budget"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the budget"
    - name: "budget_year"
      expr: YEAR(budget_start_date)
      comment: "Year when the budget period starts"
    - name: "budget_quarter"
      expr: CONCAT('Q', QUARTER(budget_start_date))
      comment: "Quarter when the budget period starts"
  measures:
    - name: "total_otb_budgets"
      expr: COUNT(DISTINCT otb_budget_id)
      comment: "Total number of unique OTB budgets"
    - name: "total_planned_receipts"
      expr: SUM(CAST(planned_receipts_at_cost AS DOUBLE))
      comment: "Total planned receipts at cost across all budgets"
    - name: "total_actual_receipts"
      expr: SUM(CAST(actual_receipts_at_cost AS DOUBLE))
      comment: "Total actual receipts at cost across all budgets"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed amount across all budgets"
    - name: "total_available_otb_balance"
      expr: SUM(CAST(available_otb_balance AS DOUBLE))
      comment: "Total available open-to-buy balance across all budgets"
    - name: "total_budget_adjustments"
      expr: SUM(CAST(budget_adjustment_amount AS DOUBLE))
      comment: "Total budget adjustment amount (net of increases and decreases)"
    - name: "total_budget_increases"
      expr: SUM(CAST(budget_increase_amount AS DOUBLE))
      comment: "Total budget increase amount"
    - name: "total_budget_decreases"
      expr: SUM(CAST(budget_decrease_amount AS DOUBLE))
      comment: "Total budget decrease amount"
    - name: "total_budget_transfer_in"
      expr: SUM(CAST(budget_transfer_in_amount AS DOUBLE))
      comment: "Total budget transferred in from other budgets"
    - name: "total_budget_transfer_out"
      expr: SUM(CAST(budget_transfer_out_amount AS DOUBLE))
      comment: "Total budget transferred out to other budgets"
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target across budgets"
    - name: "avg_inventory_turn_target"
      expr: AVG(CAST(inventory_turn_target AS DOUBLE))
      comment: "Average inventory turn target across budgets"
    - name: "avg_sell_through_target_pct"
      expr: AVG(CAST(sell_through_target_pct AS DOUBLE))
      comment: "Average sell-through target percentage across budgets"
    - name: "avg_markdown_budget_pct"
      expr: AVG(CAST(markdown_budget_pct AS DOUBLE))
      comment: "Average markdown budget percentage across budgets"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_buyer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buyer performance and capacity KPIs tracking authority limits, performance targets, vendor relationships, and buying experience"
  source: "`vibe_retail_v1`.`merchandising`.`buyer`"
  dimensions:
    - name: "buyer_status"
      expr: buyer_status
      comment: "Current employment status of the buyer (active, on_leave, terminated)"
    - name: "buyer_type"
      expr: buyer_type
      comment: "Type of buyer (senior, associate, assistant, specialist)"
    - name: "division_code"
      expr: division_code
      comment: "Division code the buyer is assigned to"
    - name: "office_location"
      expr: office_location_code
      comment: "Office location code where the buyer is based"
    - name: "international_sourcing_flag"
      expr: international_sourcing_flag
      comment: "Whether the buyer is authorized for international sourcing"
    - name: "private_label_focus_flag"
      expr: private_label_focus_flag
      comment: "Whether the buyer focuses on private label development"
    - name: "vendor_negotiation_rating"
      expr: vendor_negotiation_rating
      comment: "Rating of the buyer's vendor negotiation skills"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year when the buyer was hired"
  measures:
    - name: "total_buyers"
      expr: COUNT(DISTINCT buyer_id)
      comment: "Total number of unique buyers"
    - name: "total_buying_authority"
      expr: SUM(CAST(buying_authority_limit AS DOUBLE))
      comment: "Total buying authority limit across all buyers"
    - name: "total_otb_budget_limit"
      expr: SUM(CAST(otb_budget_limit AS DOUBLE))
      comment: "Total OTB budget limit across all buyers"
    - name: "avg_buying_authority"
      expr: AVG(CAST(buying_authority_limit AS DOUBLE))
      comment: "Average buying authority limit per buyer"
    - name: "avg_otb_budget_limit"
      expr: AVG(CAST(otb_budget_limit AS DOUBLE))
      comment: "Average OTB budget limit per buyer"
    - name: "avg_markdown_pct_limit"
      expr: AVG(CAST(markdown_percentage_limit AS DOUBLE))
      comment: "Average markdown percentage limit per buyer"
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target per buyer"
    - name: "avg_inventory_turn_target"
      expr: AVG(CAST(inventory_turn_target AS DOUBLE))
      comment: "Average inventory turn target per buyer"
    - name: "avg_sell_through_rate_target"
      expr: AVG(CAST(sell_through_rate_target AS DOUBLE))
      comment: "Average sell-through rate target per buyer"
    - name: "international_sourcing_buyer_count"
      expr: COUNT(DISTINCT CASE WHEN international_sourcing_flag = TRUE THEN buyer_id END)
      comment: "Count of buyers authorized for international sourcing"
    - name: "private_label_focus_buyer_count"
      expr: COUNT(DISTINCT CASE WHEN private_label_focus_flag = TRUE THEN buyer_id END)
      comment: "Count of buyers focused on private label development"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`merchandising_season`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seasonal planning KPIs tracking season lifecycle, OTB budget allocation, and performance targets by season type"
  source: "`vibe_retail_v1`.`merchandising`.`season`"
  dimensions:
    - name: "season_status"
      expr: season_status
      comment: "Current status of the season (planning, active, markdown, closed)"
    - name: "season_type"
      expr: season_type
      comment: "Type of season (spring, summer, fall, winter, holiday, back_to_school)"
    - name: "is_active"
      expr: is_active
      comment: "Whether the season is currently active"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the season"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the season budget"
    - name: "season_start_year"
      expr: YEAR(start_date)
      comment: "Year when the season starts"
    - name: "season_start_quarter"
      expr: CONCAT('Q', QUARTER(start_date))
      comment: "Quarter when the season starts"
  measures:
    - name: "total_seasons"
      expr: COUNT(DISTINCT season_id)
      comment: "Total number of unique seasons"
    - name: "total_otb_budget"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total open-to-buy budget allocated across all seasons"
    - name: "avg_otb_budget_per_season"
      expr: AVG(CAST(otb_budget_amount AS DOUBLE))
      comment: "Average OTB budget per season"
    - name: "avg_target_gmroi"
      expr: AVG(CAST(target_gmroi AS DOUBLE))
      comment: "Average target GMROI across seasons"
    - name: "avg_target_inventory_turns"
      expr: AVG(CAST(target_inventory_turns AS DOUBLE))
      comment: "Average target inventory turns across seasons"
    - name: "avg_target_sell_through_rate"
      expr: AVG(CAST(target_sell_through_rate AS DOUBLE))
      comment: "Average target sell-through rate across seasons"
    - name: "active_season_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN season_id END)
      comment: "Count of currently active seasons"
$$;