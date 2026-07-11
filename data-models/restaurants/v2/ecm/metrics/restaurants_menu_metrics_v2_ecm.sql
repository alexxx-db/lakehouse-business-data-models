-- Metric views for domain: menu | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core menu item performance metrics covering pricing, cost, nutritional profile, and availability across channels and dayparts. Used by menu engineering, culinary, and finance teams to evaluate item portfolio health."
  source: "`vibe_restaurants_v1`.`menu`.`menu_item`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Current lifecycle status of the menu item (active, discontinued, pending, etc.)."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the item is available in (breakfast, lunch, dinner, all-day, etc.)."
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering quadrant classification (star, plow horse, puzzle, dog) used to guide pricing and promotion decisions."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format the item is available in (drive-thru, dine-in, fast casual, etc.)."
    - name: "subcategory"
      expr: subcategory
      comment: "Menu subcategory the item belongs to (e.g., burgers, sides, beverages)."
    - name: "is_lto"
      expr: is_lto
      comment: "Whether the item is a limited-time offer."
    - name: "is_combo_eligible"
      expr: is_combo_eligible
      comment: "Whether the item can be included in combo meals."
    - name: "is_3pd_available"
      expr: is_3pd_available
      comment: "Whether the item is available on third-party delivery platforms."
    - name: "is_olo_available"
      expr: is_olo_available
      comment: "Whether the item is available for online ordering."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Whether the item is classified as vegan."
    - name: "is_vegetarian"
      expr: is_vegetarian
      comment: "Whether the item is classified as vegetarian."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Whether the item is classified as gluten-free."
    - name: "launch_date"
      expr: launch_date
      comment: "Date the item was launched on the menu."
    - name: "discontinue_date"
      expr: discontinue_date
      comment: "Date the item was or is scheduled to be discontinued."
  measures:
    - name: "total_menu_items"
      expr: COUNT(1)
      comment: "Total number of menu item records. Used to track portfolio size and complexity."
    - name: "active_menu_items"
      expr: COUNT(CASE WHEN item_status = 'active' THEN 1 END)
      comment: "Count of currently active menu items. Tracks live portfolio breadth."
    - name: "lto_item_count"
      expr: COUNT(CASE WHEN is_lto = TRUE THEN 1 END)
      comment: "Number of limited-time offer items currently in the portfolio. Tracks LTO pipeline depth."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base selling price across menu items. Tracks pricing tier positioning."
    - name: "avg_item_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost to produce a menu item. Used to monitor COGS exposure across the portfolio."
    - name: "avg_gross_margin_per_item"
      expr: AVG(CAST(base_price AS DOUBLE) - CAST(cost AS DOUBLE))
      comment: "Average gross margin (price minus cost) per menu item. Key profitability indicator for menu engineering decisions."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams across menu items. Used for nutritional compliance and health-conscious menu planning."
    - name: "avg_portion_size_grams"
      expr: AVG(CAST(portion_size_grams AS DOUBLE))
      comment: "Average portion size in grams. Used to benchmark serving sizes and manage food cost per portion."
    - name: "items_available_on_3pd"
      expr: COUNT(CASE WHEN is_3pd_available = TRUE THEN 1 END)
      comment: "Number of items available on third-party delivery platforms. Tracks digital channel coverage."
    - name: "items_available_online"
      expr: COUNT(CASE WHEN is_olo_available = TRUE THEN 1 END)
      comment: "Number of items available for online ordering. Tracks OLO channel coverage."
    - name: "pct_items_lto"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_lto = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of menu items that are limited-time offers. High LTO concentration can signal menu instability."
    - name: "pct_items_combo_eligible"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_combo_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of menu items eligible for combo bundling. Informs upsell and bundle strategy."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_pmix_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product mix (PMIX) performance metrics tracking sales volume, revenue, margin, and menu mix by item, daypart, channel, and period. The primary operational dashboard for menu performance and engineering decisions."
  source: "`vibe_restaurants_v1`.`menu`.`pmix_record`"
  dimensions:
    - name: "reporting_date"
      expr: reporting_date
      comment: "Date of the PMIX reporting record."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (daily, weekly, period, etc.)."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the sales occurred in (breakfast, lunch, dinner, late night)."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (dine-in, drive-thru, delivery, OLO, etc.)."
    - name: "menu_category"
      expr: menu_category
      comment: "Menu category of the item sold (entrees, sides, beverages, desserts)."
    - name: "menu_engineering_classification"
      expr: menu_engineering_classification
      comment: "Menu engineering quadrant (star, plow horse, puzzle, dog) for the item in this period."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format where sales occurred."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the restaurant (company-owned vs. franchised)."
    - name: "is_lto"
      expr: is_lto
      comment: "Whether the item is a limited-time offer."
    - name: "is_available"
      expr: is_available
      comment: "Whether the item was available during the reporting period."
    - name: "sku_code"
      expr: sku_code
      comment: "SKU code of the menu item for cross-system reconciliation."
  measures:
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales revenue across all menu items in the period. Primary top-line revenue KPI."
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales after discounts, comps, and refunds. Core revenue metric for P&L reporting."
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold across all items. Used to compute gross margin and monitor food cost."
    - name: "total_contribution_margin"
      expr: SUM(CAST(contribution_margin_amount AS DOUBLE))
      comment: "Total contribution margin (net sales minus COGS). Key profitability metric for menu engineering."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied. Tracks promotional spend and discount exposure."
    - name: "total_comp_amount"
      expr: SUM(CAST(comp_amount AS DOUBLE))
      comment: "Total complimentary (comped) item value. Monitors guest recovery and employee meal costs."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund dollars issued. Elevated refunds signal quality or service issues."
    - name: "total_void_amount"
      expr: SUM(CAST(void_amount AS DOUBLE))
      comment: "Total voided transaction value. High void rates may indicate POS errors or fraud."
    - name: "avg_selling_price"
      expr: AVG(CAST(avg_selling_price AS DOUBLE))
      comment: "Average actual selling price per item record. Compared against list price to measure discount depth."
    - name: "avg_cogs_pct"
      expr: AVG(CAST(cogs_pct AS DOUBLE))
      comment: "Average COGS as a percentage of sales. Core food cost efficiency metric; target typically 28-32% in QSR."
    - name: "avg_menu_mix_pct"
      expr: AVG(CAST(menu_mix_pct AS DOUBLE))
      comment: "Average menu mix percentage per item. Used to identify high-velocity items and rebalance the portfolio."
    - name: "avg_sales_mix_pct"
      expr: AVG(CAST(sales_mix_pct AS DOUBLE))
      comment: "Average sales mix percentage (revenue share) per item. Identifies revenue-driving items vs. volume drivers."
    - name: "total_unavailability_hours"
      expr: SUM(CAST(unavailability_hours AS DOUBLE))
      comment: "Total hours items were unavailable (86'd or out of stock). Directly impacts revenue and guest satisfaction."
    - name: "distinct_items_sold"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Number of distinct menu items with sales in the period. Measures active portfolio utilization."
    - name: "gross_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(contribution_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of gross sales. Executive-level profitability KPI for the menu portfolio."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Discount dollars as a percentage of gross sales. Tracks promotional intensity and margin erosion from discounting."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Refund dollars as a percentage of gross sales. Quality and satisfaction signal; elevated rates trigger operational review."
    - name: "menu_list_price_total"
      expr: SUM(CAST(menu_list_price AS DOUBLE))
      comment: "Sum of menu list prices across records. Used with avg_selling_price to compute realized price vs. list price gap."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item pricing metrics covering base price, promotional pricing, franchise price deviation, and channel surcharges. Used by pricing strategy, revenue management, and franchise operations teams."
  source: "`vibe_restaurants_v1`.`menu`.`item_price`"
  dimensions:
    - name: "daypart"
      expr: daypart
      comment: "Daypart the price applies to."
    - name: "ordering_channel"
      expr: ordering_channel
      comment: "Ordering channel the price applies to (dine-in, drive-thru, delivery, OLO)."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format the price applies to."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (company-owned vs. franchised) for price segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the price record (approved, pending, rejected)."
    - name: "is_active"
      expr: is_active
      comment: "Whether the price record is currently active."
    - name: "is_lto"
      expr: is_lto
      comment: "Whether the price is for a limited-time offer."
    - name: "price_elasticity_band"
      expr: price_elasticity_band
      comment: "Price elasticity band classification for the item. Used in pricing strategy to model demand sensitivity."
    - name: "menu_engineering_category"
      expr: menu_engineering_category
      comment: "Menu engineering category associated with this price record."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date from which the price is effective."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Date on which the price expires."
    - name: "country_code"
      expr: country_code
      comment: "Country the price applies to for international menu pricing analysis."
  measures:
    - name: "total_price_records"
      expr: COUNT(1)
      comment: "Total number of price records. Used to audit pricing coverage across items, channels, and formats."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base menu price across all price records. Tracks overall pricing tier positioning."
    - name: "avg_promotional_price"
      expr: AVG(CAST(promotional_price AS DOUBLE))
      comment: "Average promotional price. Compared against base price to measure promotional discount depth."
    - name: "avg_suggested_retail_price"
      expr: AVG(CAST(suggested_retail_price AS DOUBLE))
      comment: "Average suggested retail price. Used to benchmark actual pricing against recommended pricing."
    - name: "avg_channel_surcharge"
      expr: AVG(CAST(channel_surcharge AS DOUBLE))
      comment: "Average channel surcharge applied (e.g., delivery upcharge). Tracks digital channel pricing premiums."
    - name: "avg_cogs_pct"
      expr: AVG(CAST(cogs_pct AS DOUBLE))
      comment: "Average COGS percentage at the price record level. Used to validate that pricing maintains target food cost margins."
    - name: "avg_franchise_price_deviation_pct"
      expr: AVG(CAST(franchise_price_deviation_pct AS DOUBLE))
      comment: "Average percentage deviation of franchise prices from corporate recommended prices. Monitors franchise pricing compliance."
    - name: "avg_price_override_limit"
      expr: AVG(CAST(price_override_limit AS DOUBLE))
      comment: "Average maximum price override allowed. Used to govern discretionary pricing authority at the unit level."
    - name: "avg_cost_of_goods"
      expr: AVG(CAST(cost_of_goods AS DOUBLE))
      comment: "Average absolute cost of goods per price record. Supports margin analysis alongside base price."
    - name: "items_with_active_price"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of price records that are currently active. Ensures pricing coverage for the live menu."
    - name: "promotional_discount_depth_pct"
      expr: ROUND(100.0 * (SUM(CAST(base_price AS DOUBLE)) - SUM(CAST(promotional_price AS DOUBLE))) / NULLIF(SUM(CAST(base_price AS DOUBLE)), 0), 2)
      comment: "Average promotional discount as a percentage of base price across all price records. Measures promotional intensity and margin impact."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item cost analytics covering theoretical vs. actual COGS, food cost percentages, waste, and yield. Used by culinary finance, supply chain, and menu engineering teams to manage food cost and identify variance drivers."
  source: "`vibe_restaurants_v1`.`menu`.`item_cost`"
  dimensions:
    - name: "cost_status"
      expr: cost_status
      comment: "Status of the cost record (approved, draft, superseded)."
    - name: "channel"
      expr: channel
      comment: "Sales channel the cost record applies to."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the cost record applies to."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format the cost applies to."
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering classification for the item at time of cost calculation."
    - name: "is_lto"
      expr: is_lto
      comment: "Whether the cost record is for a limited-time offer item."
    - name: "cost_calculation_date"
      expr: cost_calculation_date
      comment: "Date the cost was calculated. Used for trend analysis of food cost over time."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period the cost record belongs to."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost record."
  measures:
    - name: "avg_actual_cogs_pct"
      expr: AVG(CAST(actual_cogs_pct AS DOUBLE))
      comment: "Average actual COGS percentage. Core food cost KPI; compared against target to identify over/under-cost items."
    - name: "avg_target_cogs_pct"
      expr: AVG(CAST(target_cogs_pct AS DOUBLE))
      comment: "Average target COGS percentage. Benchmark for evaluating actual food cost performance."
    - name: "avg_theoretical_cogs_pct"
      expr: AVG(CAST(theoretical_cogs_pct AS DOUBLE))
      comment: "Average theoretical COGS percentage based on recipe costing. Gap vs. actual indicates waste, theft, or portioning issues."
    - name: "avg_cogs_pct_variance"
      expr: AVG(CAST(cogs_pct_variance AS DOUBLE))
      comment: "Average variance between actual and target COGS percentage. Negative variance means better-than-target food cost."
    - name: "total_theoretical_cost"
      expr: SUM(CAST(theoretical_cost_amount AS DOUBLE))
      comment: "Total theoretical food cost based on recipe costing. Used as the baseline for variance analysis."
    - name: "total_theoretical_cost_variance"
      expr: SUM(CAST(theoretical_cost_variance_amount AS DOUBLE))
      comment: "Total variance between theoretical and actual food cost. Large positive variance signals waste, theft, or portioning problems."
    - name: "avg_base_selling_price"
      expr: AVG(CAST(base_selling_price AS DOUBLE))
      comment: "Average base selling price at time of cost calculation. Used to compute implied margin alongside COGS."
    - name: "avg_packaging_cost"
      expr: AVG(CAST(packaging_cost AS DOUBLE))
      comment: "Average packaging cost per item. Tracks packaging spend as a component of total item cost."
    - name: "avg_primary_protein_cost"
      expr: AVG(CAST(primary_protein_cost AS DOUBLE))
      comment: "Average primary protein cost per item. Protein is typically the largest cost driver; tracks commodity exposure."
    - name: "avg_waste_pct"
      expr: AVG(CAST(waste_pct AS DOUBLE))
      comment: "Average waste percentage per item. High waste rates inflate food cost and signal operational inefficiency."
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_pct AS DOUBLE))
      comment: "Average yield percentage per item. Low yield increases effective cost per serving."
    - name: "avg_cost_per_gram"
      expr: AVG(CAST(cost_per_gram AS DOUBLE))
      comment: "Average cost per gram across items. Enables normalized cost comparison across different portion sizes."
    - name: "cogs_variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(theoretical_cost_variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(theoretical_cost_amount AS DOUBLE)), 0), 2)
      comment: "Theoretical cost variance as a percentage of theoretical cost. Measures overall food cost control effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe portfolio metrics covering food cost, nutritional content, yield, waste, and preparation parameters. Used by culinary R&D, food safety, and menu engineering teams to manage recipe quality and cost."
  source: "`vibe_restaurants_v1`.`menu`.`recipe`"
  dimensions:
    - name: "recipe_status"
      expr: recipe_status
      comment: "Current status of the recipe (active, draft, retired, under review)."
    - name: "recipe_type"
      expr: recipe_type
      comment: "Type of recipe (base, sub-recipe, LTO, seasonal, etc.)."
    - name: "recipe_category"
      expr: recipe_category
      comment: "Category the recipe belongs to (entree, side, sauce, beverage, etc.)."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the recipe is intended for."
    - name: "channel"
      expr: channel
      comment: "Sales channel the recipe is designed for."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format the recipe applies to."
    - name: "cook_method"
      expr: cook_method
      comment: "Cooking method used (grill, fry, bake, steam, etc.). Used for equipment planning and energy cost analysis."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Whether the recipe is gluten-free."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Whether the recipe is vegan."
    - name: "is_vegetarian"
      expr: is_vegetarian
      comment: "Whether the recipe is vegetarian."
    - name: "haccp_ccp_flag"
      expr: haccp_ccp_flag
      comment: "Whether the recipe has a HACCP critical control point. Used for food safety compliance tracking."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the recipe version became effective."
  measures:
    - name: "total_recipes"
      expr: COUNT(1)
      comment: "Total number of recipe records. Tracks recipe portfolio size and version proliferation."
    - name: "active_recipes"
      expr: COUNT(CASE WHEN recipe_status = 'active' THEN 1 END)
      comment: "Number of currently active recipes. Measures live culinary portfolio depth."
    - name: "avg_food_cost"
      expr: AVG(CAST(food_cost AS DOUBLE))
      comment: "Average food cost per recipe. Core cost management metric for culinary and finance teams."
    - name: "avg_food_cost_pct"
      expr: AVG(CAST(food_cost_pct AS DOUBLE))
      comment: "Average food cost as a percentage of menu price. Target benchmark varies by format (typically 28-35% in QSR)."
    - name: "avg_menu_price"
      expr: AVG(CAST(menu_price AS DOUBLE))
      comment: "Average menu price across recipes. Used to track pricing tier and compare against food cost."
    - name: "avg_calories"
      expr: AVG(CAST(calories AS DOUBLE))
      comment: "Average calorie count per recipe. Used for nutritional compliance and menu health positioning."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams per recipe. Monitored for regulatory compliance and health positioning."
    - name: "avg_waste_pct"
      expr: AVG(CAST(waste_pct AS DOUBLE))
      comment: "Average waste percentage per recipe. High waste inflates food cost and signals prep inefficiency."
    - name: "avg_yield_quantity"
      expr: AVG(CAST(yield_quantity AS DOUBLE))
      comment: "Average yield quantity per recipe. Used to normalize cost-per-serving calculations."
    - name: "avg_cook_temperature_f"
      expr: AVG(CAST(cook_temperature_f AS DOUBLE))
      comment: "Average cooking temperature in Fahrenheit. Used for food safety compliance and equipment calibration."
    - name: "avg_holding_temperature_f"
      expr: AVG(CAST(holding_temperature_f AS DOUBLE))
      comment: "Average holding temperature in Fahrenheit. Critical for food safety; must stay within HACCP-defined safe zones."
    - name: "avg_serving_size_g"
      expr: AVG(CAST(serving_size_g AS DOUBLE))
      comment: "Average serving size in grams. Used for portion control and cost-per-gram benchmarking."
    - name: "recipes_with_haccp_ccp"
      expr: COUNT(CASE WHEN haccp_ccp_flag = TRUE THEN 1 END)
      comment: "Number of recipes with HACCP critical control points. Used for food safety audit planning and compliance reporting."
    - name: "implied_gross_margin_per_recipe"
      expr: AVG(CAST(menu_price AS DOUBLE) - CAST(food_cost AS DOUBLE))
      comment: "Average implied gross margin (menu price minus food cost) per recipe. Guides recipe prioritization in menu engineering."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_combo_meal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Combo meal portfolio metrics covering bundle pricing, discount depth, food cost, and availability across channels and dayparts. Used by menu engineering, marketing, and pricing teams to optimize bundle strategy."
  source: "`vibe_restaurants_v1`.`menu`.`combo_meal`"
  dimensions:
    - name: "combo_status"
      expr: combo_status
      comment: "Current status of the combo meal (active, discontinued, pending launch)."
    - name: "combo_type"
      expr: combo_type
      comment: "Type of combo (value meal, family bundle, kids meal, etc.)."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the combo is available in."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format the combo is available in."
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering classification for the combo."
    - name: "is_national_launch"
      expr: is_national_launch
      comment: "Whether the combo is a national launch vs. regional/test market."
    - name: "is_3pd_available"
      expr: is_3pd_available
      comment: "Whether the combo is available on third-party delivery platforms."
    - name: "is_olo_available"
      expr: is_olo_available
      comment: "Whether the combo is available for online ordering."
    - name: "country_code"
      expr: country_code
      comment: "Country the combo is available in."
    - name: "launch_date"
      expr: launch_date
      comment: "Date the combo was launched."
    - name: "ownership_model"
      expr: ownership_model
      comment: "Ownership model (company-owned vs. franchised) for the combo."
  measures:
    - name: "total_combos"
      expr: COUNT(1)
      comment: "Total number of combo meal records. Tracks bundle portfolio size."
    - name: "active_combos"
      expr: COUNT(CASE WHEN combo_status = 'active' THEN 1 END)
      comment: "Number of currently active combo meals. Measures live bundle portfolio depth."
    - name: "avg_bundle_price"
      expr: AVG(CAST(bundle_price AS DOUBLE))
      comment: "Average bundle selling price. Tracks pricing tier for combo offerings."
    - name: "avg_individual_items_price_sum"
      expr: AVG(CAST(individual_items_price_sum AS DOUBLE))
      comment: "Average sum of individual item prices if purchased separately. Used to compute bundle savings."
    - name: "avg_bundle_discount_amount"
      expr: AVG(CAST(bundle_discount_amount AS DOUBLE))
      comment: "Average discount provided by the bundle vs. individual item prices. Measures bundle value proposition."
    - name: "avg_food_cost_pct"
      expr: AVG(CAST(food_cost_pct AS DOUBLE))
      comment: "Average food cost percentage for combo meals. Ensures bundles maintain acceptable margin thresholds."
    - name: "avg_item_cost"
      expr: AVG(CAST(item_cost AS DOUBLE))
      comment: "Average total item cost for combo meals. Used alongside bundle price to compute combo gross margin."
    - name: "avg_pmix_target_pct"
      expr: AVG(CAST(pmix_target_pct AS DOUBLE))
      comment: "Average product mix target percentage for combos. Used to set sales velocity expectations for bundle items."
    - name: "bundle_savings_pct"
      expr: ROUND(100.0 * SUM(CAST(bundle_discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(individual_items_price_sum AS DOUBLE)), 0), 2)
      comment: "Bundle discount as a percentage of individual item price sum. Quantifies the consumer value proposition of combo bundling."
    - name: "combos_on_3pd"
      expr: COUNT(CASE WHEN is_3pd_available = TRUE THEN 1 END)
      comment: "Number of combos available on third-party delivery. Tracks digital channel bundle coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_engineering_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu engineering review metrics tracking review outcomes, item disposition decisions, complexity scores, and contribution margin benchmarks. Used by menu strategy and culinary leadership to govern the menu engineering cycle."
  source: "`vibe_restaurants_v1`.`menu`.`engineering_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the engineering review (in-progress, complete, pending approval)."
    - name: "review_cycle"
      expr: review_cycle
      comment: "Review cycle cadence (quarterly, semi-annual, annual)."
    - name: "review_scope_type"
      expr: review_scope_type
      comment: "Scope of the review (full menu, category, daypart, channel)."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format the review applies to."
    - name: "engineering_framework"
      expr: engineering_framework
      comment: "Menu engineering framework used (BCG matrix, contribution margin matrix, etc.)."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Status of implementing the review recommendations."
    - name: "is_franchise_applicable"
      expr: is_franchise_applicable
      comment: "Whether the review applies to franchise locations."
    - name: "review_date"
      expr: review_date
      comment: "Date the engineering review was conducted."
    - name: "channel_scope"
      expr: channel_scope
      comment: "Channel scope of the review (all channels, delivery only, dine-in only, etc.)."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of engineering reviews conducted. Tracks cadence and coverage of menu engineering governance."
    - name: "avg_contribution_margin"
      expr: AVG(CAST(avg_contribution_margin AS DOUBLE))
      comment: "Average contribution margin across items evaluated in engineering reviews. Core profitability benchmark for menu decisions."
    - name: "avg_menu_item_popularity_index"
      expr: AVG(CAST(avg_menu_item_popularity_index AS DOUBLE))
      comment: "Average menu item popularity index across reviews. Combined with margin, drives star/plow horse/puzzle/dog classification."
    - name: "avg_complexity_score_before"
      expr: AVG(CAST(menu_complexity_score_before AS DOUBLE))
      comment: "Average menu complexity score before engineering review actions. Baseline for measuring simplification impact."
    - name: "avg_complexity_score_after"
      expr: AVG(CAST(menu_complexity_score_after AS DOUBLE))
      comment: "Average menu complexity score after engineering review actions. Measures effectiveness of menu simplification efforts."
    - name: "avg_complexity_reduction"
      expr: AVG(CAST(menu_complexity_score_before AS DOUBLE) - CAST(menu_complexity_score_after AS DOUBLE))
      comment: "Average reduction in menu complexity score per review. Positive values indicate successful simplification."
    - name: "avg_cogs_pct_threshold"
      expr: AVG(CAST(cogs_pct_threshold AS DOUBLE))
      comment: "Average COGS percentage threshold used in engineering reviews. Tracks how aggressively food cost targets are set."
    - name: "reviews_with_allergen_required"
      expr: COUNT(CASE WHEN allergen_review_required = TRUE THEN 1 END)
      comment: "Number of reviews requiring allergen review. Tracks food safety compliance workload in the engineering cycle."
    - name: "reviews_with_nutritional_required"
      expr: COUNT(CASE WHEN nutritional_review_required = TRUE THEN 1 END)
      comment: "Number of reviews requiring nutritional review. Tracks regulatory compliance workload."
    - name: "reviews_with_food_safety_required"
      expr: COUNT(CASE WHEN food_safety_review_required = TRUE THEN 1 END)
      comment: "Number of reviews requiring food safety review. Ensures food safety is integrated into menu engineering decisions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_86_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item 86 (out-of-stock) event metrics tracking frequency, duration, and operational impact of menu item unavailability. Used by operations, supply chain, and menu teams to reduce stockouts and their revenue impact."
  source: "`vibe_restaurants_v1`.`menu`.`item_86_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the 86 event (active, resolved, escalated)."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause code for the 86 event (supply shortage, equipment failure, prep issue, etc.)."
    - name: "daypart_affected"
      expr: daypart_affected
      comment: "Daypart during which the item was unavailable."
    - name: "channel_affected"
      expr: channel_affected
      comment: "Sales channel affected by the 86 event."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format where the 86 event occurred."
    - name: "is_food_safety_related"
      expr: is_food_safety_related
      comment: "Whether the 86 event was triggered by a food safety concern."
    - name: "is_recall_related"
      expr: is_recall_related
      comment: "Whether the 86 event was triggered by a product recall."
    - name: "is_lto_item"
      expr: is_lto_item
      comment: "Whether the 86'd item is a limited-time offer. LTO stockouts have outsized marketing and guest satisfaction impact."
    - name: "ownership_model"
      expr: ownership_model
      comment: "Ownership model of the affected restaurant."
    - name: "olo_suppressed"
      expr: olo_suppressed
      comment: "Whether the item was suppressed from online ordering during the event."
    - name: "pos_suppressed"
      expr: pos_suppressed
      comment: "Whether the item was suppressed from the POS during the event."
  measures:
    - name: "total_86_events"
      expr: COUNT(1)
      comment: "Total number of item 86 events. High frequency signals supply chain or operational reliability issues."
    - name: "food_safety_86_events"
      expr: COUNT(CASE WHEN is_food_safety_related = TRUE THEN 1 END)
      comment: "Number of 86 events triggered by food safety concerns. Critical compliance and risk metric."
    - name: "recall_related_86_events"
      expr: COUNT(CASE WHEN is_recall_related = TRUE THEN 1 END)
      comment: "Number of 86 events triggered by product recalls. Tracks supply chain risk exposure."
    - name: "lto_86_events"
      expr: COUNT(CASE WHEN is_lto_item = TRUE THEN 1 END)
      comment: "Number of 86 events affecting LTO items. LTO stockouts damage marketing ROI and guest experience."
    - name: "avg_inventory_on_hand"
      expr: AVG(CAST(inventory_quantity_on_hand AS DOUBLE))
      comment: "Average inventory quantity on hand at time of 86 event. Near-zero values confirm genuine stockout vs. system error."
    - name: "avg_par_level_quantity"
      expr: AVG(CAST(par_level_quantity AS DOUBLE))
      comment: "Average par level quantity for 86'd items. Compared against on-hand quantity to assess par level adequacy."
    - name: "pct_events_food_safety_related"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_food_safety_related = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of 86 events that are food safety related. Elevated rates trigger food safety protocol reviews."
    - name: "pct_events_olo_suppressed"
      expr: ROUND(100.0 * COUNT(CASE WHEN olo_suppressed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of 86 events where the item was suppressed from online ordering. Measures digital channel availability impact."
    - name: "distinct_items_86d"
      expr: COUNT(DISTINCT primary_menu_item_id)
      comment: "Number of distinct menu items that experienced an 86 event. Breadth of stockout exposure across the menu."
    - name: "distinct_units_with_86_events"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of distinct restaurant units that experienced 86 events. Identifies systemic supply chain issues vs. isolated incidents."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_lto`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Limited-time offer (LTO) lifecycle metrics covering launch performance, food cost targets, approval status, and rollout scope. Used by marketing, culinary, and operations teams to manage the LTO pipeline and evaluate launch readiness."
  source: "`vibe_restaurants_v1`.`menu`.`menu_lto`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the LTO (concept, approved, in-market, retired)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the LTO (approved, pending, rejected)."
    - name: "lto_type"
      expr: lto_type
      comment: "Type of LTO (seasonal, promotional, test market, national launch)."
    - name: "rollout_scope"
      expr: rollout_scope
      comment: "Geographic or operational scope of the LTO rollout (national, regional, test market)."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format the LTO is available in."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the LTO is targeted at."
    - name: "is_national_launch"
      expr: is_national_launch
      comment: "Whether the LTO is a national launch."
    - name: "is_returning_item"
      expr: is_returning_item
      comment: "Whether the LTO is a returning fan-favorite item."
    - name: "is_test_market"
      expr: is_test_market
      comment: "Whether the LTO is in test market phase."
    - name: "season_or_occasion"
      expr: season_or_occasion
      comment: "Season or occasion the LTO is tied to (summer, holiday, Super Bowl, etc.)."
    - name: "planned_launch_date"
      expr: planned_launch_date
      comment: "Planned launch date for the LTO."
    - name: "actual_launch_date"
      expr: actual_launch_date
      comment: "Actual launch date for the LTO. Compared against planned to measure launch execution accuracy."
  measures:
    - name: "total_ltos"
      expr: COUNT(1)
      comment: "Total number of LTO records. Tracks LTO pipeline volume."
    - name: "active_ltos"
      expr: COUNT(CASE WHEN lifecycle_status = 'in-market' THEN 1 END)
      comment: "Number of LTOs currently in market. Tracks live promotional menu complexity."
    - name: "food_safety_approved_ltos"
      expr: COUNT(CASE WHEN food_safety_approved = TRUE THEN 1 END)
      comment: "Number of LTOs with food safety approval. Ensures compliance before launch."
    - name: "nutritional_approved_ltos"
      expr: COUNT(CASE WHEN nutritional_approved = TRUE THEN 1 END)
      comment: "Number of LTOs with nutritional approval. Tracks regulatory compliance readiness."
    - name: "avg_target_food_cost_pct"
      expr: AVG(CAST(target_food_cost_pct AS DOUBLE))
      comment: "Average target food cost percentage for LTOs. Ensures LTOs are priced to maintain margin targets."
    - name: "avg_suggested_retail_price"
      expr: AVG(CAST(suggested_retail_price AS DOUBLE))
      comment: "Average suggested retail price for LTOs. Tracks LTO pricing tier positioning."
    - name: "avg_pmix_target_pct"
      expr: AVG(CAST(pmix_target_pct AS DOUBLE))
      comment: "Average product mix target percentage for LTOs. Sets velocity expectations for LTO performance evaluation."
    - name: "pct_ltos_food_safety_approved"
      expr: ROUND(100.0 * COUNT(CASE WHEN food_safety_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of LTOs with food safety approval. Low rates signal compliance bottlenecks in the launch pipeline."
    - name: "pct_ltos_national_launch"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_national_launch = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of LTOs that are national launches vs. regional/test. Tracks national vs. local innovation balance."
    - name: "returning_item_lto_count"
      expr: COUNT(CASE WHEN is_returning_item = TRUE THEN 1 END)
      comment: "Number of LTOs that are returning fan-favorite items. Returning items typically have lower launch risk and higher initial velocity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_nutrition_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nutritional profile metrics across the menu portfolio covering macronutrients, sodium, calories, and regulatory compliance status. Used by culinary R&D, regulatory affairs, and marketing teams for nutritional transparency and compliance."
  source: "`vibe_restaurants_v1`.`menu`.`nutrition_profile`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the nutritional profile (approved, pending, expired)."
    - name: "profile_type"
      expr: profile_type
      comment: "Type of nutritional profile (standard, combo, modified, lab-tested)."
    - name: "data_source"
      expr: data_source
      comment: "Source of nutritional data (lab analysis, database, calculated)."
    - name: "is_current_version"
      expr: is_current_version
      comment: "Whether this is the current active version of the nutritional profile."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the nutritional profile became effective."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Date the nutritional profile expires and requires re-certification."
  measures:
    - name: "total_nutrition_profiles"
      expr: COUNT(1)
      comment: "Total number of nutritional profiles. Tracks nutritional documentation coverage across the menu."
    - name: "current_approved_profiles"
      expr: COUNT(CASE WHEN is_current_version = TRUE AND approval_status = 'approved' THEN 1 END)
      comment: "Number of currently approved and active nutritional profiles. Measures regulatory compliance coverage."
    - name: "avg_total_fat_g"
      expr: AVG(CAST(total_fat_g AS DOUBLE))
      comment: "Average total fat content in grams across menu items. Used for nutritional positioning and health-conscious menu planning."
    - name: "avg_saturated_fat_g"
      expr: AVG(CAST(saturated_fat_g AS DOUBLE))
      comment: "Average saturated fat content in grams. Monitored for heart health positioning and regulatory thresholds."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams. High sodium is a key regulatory and consumer health concern in QSR."
    - name: "avg_total_carbohydrate_g"
      expr: AVG(CAST(total_carbohydrate_g AS DOUBLE))
      comment: "Average total carbohydrate content in grams. Used for low-carb menu positioning and diabetic-friendly options."
    - name: "avg_protein_g"
      expr: AVG(CAST(protein_g AS DOUBLE))
      comment: "Average protein content in grams. Used for high-protein menu positioning and athletic/fitness consumer targeting."
    - name: "avg_dietary_fiber_g"
      expr: AVG(CAST(dietary_fiber_g AS DOUBLE))
      comment: "Average dietary fiber content in grams. Used for digestive health positioning."
    - name: "avg_total_sugars_g"
      expr: AVG(CAST(total_sugars_g AS DOUBLE))
      comment: "Average total sugar content in grams. Monitored for regulatory compliance and health-conscious menu planning."
    - name: "avg_trans_fat_g"
      expr: AVG(CAST(trans_fat_g AS DOUBLE))
      comment: "Average trans fat content in grams. Regulatory compliance metric; many jurisdictions require near-zero trans fat."
    - name: "avg_serving_size_g"
      expr: AVG(CAST(serving_size_g AS DOUBLE))
      comment: "Average serving size in grams. Used for portion standardization and per-serving nutritional benchmarking."
    - name: "pct_profiles_current_approved"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_current_version = TRUE AND approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nutritional profiles that are current and approved. Low rates indicate compliance gaps requiring remediation."
$$;