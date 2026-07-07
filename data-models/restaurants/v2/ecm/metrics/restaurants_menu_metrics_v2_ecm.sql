-- Metric views for domain: menu | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core menu item performance metrics covering pricing, cost, and portfolio composition. Used by menu engineers and executives to evaluate item-level profitability and portfolio health."
  source: "`vibe_restaurants_v1`.`menu`.`menu_item`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Current lifecycle status of the menu item (active, discontinued, test, etc.) for portfolio segmentation."
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering quadrant classification (Star, Plow Horse, Puzzle, Dog) used to drive pricing and promotion decisions."
    - name: "daypart"
      expr: daypart
      comment: "Daypart applicability (breakfast, lunch, dinner, late-night) for time-of-day performance analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (QSR, fast casual, drive-thru) to segment item performance by service model."
    - name: "subcategory"
      expr: subcategory
      comment: "Menu subcategory (burgers, salads, beverages, etc.) for category-level portfolio analysis."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the item is a limited-time offer, enabling LTO vs. core menu comparison."
    - name: "is_vegetarian"
      expr: is_vegetarian
      comment: "Vegetarian flag for dietary portfolio composition reporting."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Vegan flag for dietary portfolio composition reporting."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Gluten-free flag for allergen-sensitive portfolio reporting."
    - name: "launch_date"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month of item launch for cohort and vintage analysis of menu additions."
  measures:
    - name: "total_menu_items"
      expr: COUNT(1)
      comment: "Total number of menu items in the portfolio. Tracks menu complexity and breadth for engineering reviews."
    - name: "active_menu_items"
      expr: COUNT(CASE WHEN item_status = 'active' THEN 1 END)
      comment: "Count of currently active menu items. Executives use this to monitor menu complexity and rationalization progress."
    - name: "lto_item_count"
      expr: COUNT(CASE WHEN is_lto = TRUE THEN 1 END)
      comment: "Number of limited-time offer items currently in the portfolio. Drives LTO pipeline and marketing investment decisions."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base selling price across menu items. Used to monitor pricing tier positioning and competitive benchmarking."
    - name: "avg_item_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average theoretical cost per menu item. Drives food cost management and margin analysis at the portfolio level."
    - name: "avg_gross_margin_per_item"
      expr: AVG(CAST(base_price AS DOUBLE) - CAST(cost AS DOUBLE))
      comment: "Average gross margin (price minus cost) per menu item. Core profitability KPI for menu engineering decisions."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams across menu items. Used for nutritional compliance and health-conscious menu strategy."
    - name: "customizable_item_count"
      expr: COUNT(CASE WHEN is_customizable = TRUE THEN 1 END)
      comment: "Number of customizable menu items. Informs digital ordering platform investment and kitchen complexity management."
    - name: "digital_channel_eligible_items"
      expr: COUNT(CASE WHEN is_olo_available = TRUE THEN 1 END)
      comment: "Count of items available on digital/OLO ordering channels. Tracks digital menu completeness for e-commerce revenue strategy."
    - name: "third_party_delivery_eligible_items"
      expr: COUNT(CASE WHEN is_3pd_available = TRUE THEN 1 END)
      comment: "Count of items available on third-party delivery platforms. Drives 3PD channel revenue and partnership decisions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_pmix_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product mix (PMIX) performance metrics measuring sales volume, revenue, margin, and menu mix by item. The primary operational KPI view for menu performance management and engineering decisions."
  source: "`vibe_restaurants_v1`.`menu`.`pmix_record`"
  dimensions:
    - name: "reporting_date"
      expr: DATE_TRUNC('week', reporting_date)
      comment: "Week of the reporting period for trend analysis of item-level sales performance."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Period granularity (daily, weekly, period) for flexible time-series analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart (breakfast, lunch, dinner) for time-of-day sales mix analysis."
    - name: "menu_category"
      expr: menu_category
      comment: "Menu category for category-level performance aggregation and comparison."
    - name: "menu_engineering_classification"
      expr: menu_engineering_classification
      comment: "Menu engineering quadrant (Star, Plow Horse, Puzzle, Dog) for strategic portfolio management."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (dine-in, drive-thru, delivery, OLO) for channel-level revenue attribution."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format performance benchmarking."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (corporate, franchise) for performance comparison across ownership structures."
    - name: "is_lto"
      expr: is_lto
      comment: "LTO flag to isolate limited-time offer performance from core menu performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency revenue reporting."
  measures:
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales revenue across all items in the period. Primary top-line revenue KPI for menu performance."
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales after discounts and voids. Used for accurate revenue reporting and P&L alignment."
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold across all items. Core input for food cost management and margin analysis."
    - name: "total_contribution_margin"
      expr: SUM(CAST(contribution_margin_amount AS DOUBLE))
      comment: "Total contribution margin (net sales minus COGS). The primary profitability KPI for menu engineering decisions."
    - name: "avg_selling_price"
      expr: AVG(CAST(avg_selling_price AS DOUBLE))
      comment: "Average actual selling price per item record. Tracks price realization vs. list price and promotional impact."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied. Monitors promotional spend and discount program effectiveness."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund dollars issued. Tracks quality and satisfaction issues at the item level."
    - name: "total_void_amount"
      expr: SUM(CAST(void_amount AS DOUBLE))
      comment: "Total voided transaction value. Operational quality indicator for order accuracy and kitchen performance."
    - name: "avg_cogs_pct"
      expr: AVG(CAST(cogs_pct AS DOUBLE))
      comment: "Average food cost percentage across items. Executives use this to monitor margin health against target thresholds."
    - name: "avg_menu_mix_pct"
      expr: AVG(CAST(menu_mix_pct AS DOUBLE))
      comment: "Average menu mix percentage showing item share of total sales volume. Drives portfolio rationalization decisions."
    - name: "avg_sales_mix_pct"
      expr: AVG(CAST(sales_mix_pct AS DOUBLE))
      comment: "Average sales mix percentage showing item share of total revenue. Identifies revenue concentration risk."
    - name: "total_unavailability_hours"
      expr: SUM(CAST(unavailability_hours AS DOUBLE))
      comment: "Total hours items were unavailable (86'd). Tracks supply chain and operational reliability impact on revenue."
    - name: "total_comp_amount"
      expr: SUM(CAST(comp_amount AS DOUBLE))
      comment: "Total complimentary (comped) item value. Monitors guest recovery costs and employee meal program spend."
    - name: "distinct_items_sold"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Count of distinct menu items generating sales. Measures effective menu breadth and identifies dead SKUs."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level food cost and margin metrics for menu engineering and financial planning. Tracks theoretical vs. actual cost performance to drive pricing and recipe optimization decisions."
  source: "`vibe_restaurants_v1`.`menu`.`item_cost`"
  dimensions:
    - name: "cost_calculation_date"
      expr: DATE_TRUNC('month', cost_calculation_date)
      comment: "Month of cost calculation for trend analysis of food cost movements."
    - name: "cost_calculation_method"
      expr: cost_calculation_method
      comment: "Method used to calculate cost (theoretical, actual, weighted average) for methodology comparison."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format cost benchmarking."
    - name: "channel"
      expr: channel
      comment: "Sales channel for channel-specific cost analysis (e.g., delivery packaging costs)."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for time-of-day cost analysis."
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering classification for cost analysis by portfolio quadrant."
    - name: "is_lto"
      expr: is_lto
      comment: "LTO flag to compare cost profiles of limited-time vs. core menu items."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period cost variance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency cost reporting."
  measures:
    - name: "avg_theoretical_cost"
      expr: AVG(CAST(theoretical_cost_amount AS DOUBLE))
      comment: "Average theoretical food cost per item. Baseline for food cost management and recipe costing accuracy."
    - name: "avg_theoretical_cogs_pct"
      expr: AVG(CAST(theoretical_cogs_pct AS DOUBLE))
      comment: "Average theoretical COGS percentage. Primary food cost KPI used in menu engineering and pricing strategy."
    - name: "avg_actual_cogs_pct"
      expr: AVG(CAST(actual_cogs_pct AS DOUBLE))
      comment: "Average actual COGS percentage. Compared against theoretical to identify waste, theft, and portioning issues."
    - name: "avg_cogs_pct_variance"
      expr: AVG(CAST(cogs_pct_variance AS DOUBLE))
      comment: "Average variance between actual and target COGS percentage. Triggers investigation when outside acceptable thresholds."
    - name: "total_theoretical_cost_variance"
      expr: SUM(CAST(theoretical_cost_variance_amount AS DOUBLE))
      comment: "Total dollar variance between theoretical and actual food cost. Quantifies financial exposure from cost overruns."
    - name: "avg_target_cogs_pct"
      expr: AVG(CAST(target_cogs_pct AS DOUBLE))
      comment: "Average target COGS percentage set during menu engineering. Benchmark for evaluating actual cost performance."
    - name: "avg_base_selling_price"
      expr: AVG(CAST(base_selling_price AS DOUBLE))
      comment: "Average base selling price at time of cost calculation. Used to validate price-cost relationship and margin targets."
    - name: "avg_packaging_cost"
      expr: AVG(CAST(packaging_cost AS DOUBLE))
      comment: "Average packaging cost per item. Tracks packaging spend especially relevant for delivery channel profitability."
    - name: "avg_waste_pct"
      expr: AVG(CAST(waste_pct AS DOUBLE))
      comment: "Average waste percentage factored into item cost. Drives waste reduction programs and yield improvement initiatives."
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_pct AS DOUBLE))
      comment: "Average yield percentage for recipe ingredients. Low yield drives up effective food cost and signals prep inefficiency."
    - name: "avg_primary_protein_cost"
      expr: AVG(CAST(primary_protein_cost AS DOUBLE))
      comment: "Average primary protein cost per item. Protein is typically the largest food cost driver; tracked for commodity risk management."
    - name: "items_with_cost_records"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Count of distinct menu items with active cost records. Measures cost data completeness for financial reporting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item pricing metrics tracking price levels, promotional pricing, and franchise price deviation. Used by pricing strategy teams and executives to manage revenue optimization and pricing compliance."
  source: "`vibe_restaurants_v1`.`menu`.`item_price`"
  dimensions:
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month price became effective for price change trend analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel for channel-specific pricing analysis (dine-in vs. delivery surcharges)."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format price benchmarking."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for time-of-day pricing analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (corporate, franchise) for price compliance monitoring."
    - name: "price_change_reason"
      expr: price_change_reason
      comment: "Reason for price change (cost increase, competitive response, promotion) for pricing decision audit trail."
    - name: "price_elasticity_band"
      expr: price_elasticity_band
      comment: "Price elasticity band for demand sensitivity segmentation in pricing strategy."
    - name: "menu_engineering_category"
      expr: menu_engineering_category
      comment: "Menu engineering category for price analysis by portfolio quadrant."
    - name: "is_lto"
      expr: is_lto
      comment: "LTO flag to compare promotional vs. core menu pricing."
    - name: "country_code"
      expr: country_code
      comment: "Country code for international pricing analysis and currency-adjusted comparisons."
  measures:
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base menu price across items and locations. Core pricing KPI for competitive benchmarking and revenue management."
    - name: "avg_promotional_price"
      expr: AVG(CAST(promotional_price AS DOUBLE))
      comment: "Average promotional price. Measures depth of promotional discounting and its impact on revenue realization."
    - name: "avg_suggested_retail_price"
      expr: AVG(CAST(suggested_retail_price AS DOUBLE))
      comment: "Average suggested retail price. Baseline for measuring franchise price compliance and deviation."
    - name: "avg_channel_surcharge"
      expr: AVG(CAST(channel_surcharge AS DOUBLE))
      comment: "Average channel surcharge applied (e.g., delivery fee uplift). Tracks channel pricing strategy effectiveness."
    - name: "avg_franchise_price_deviation_pct"
      expr: AVG(CAST(franchise_price_deviation_pct AS DOUBLE))
      comment: "Average percentage deviation of franchise prices from suggested retail. Monitors pricing compliance across franchise network."
    - name: "avg_cogs_pct"
      expr: AVG(CAST(cogs_pct AS DOUBLE))
      comment: "Average COGS percentage at the price record level. Validates that pricing maintains target margin thresholds."
    - name: "avg_cost_of_goods"
      expr: AVG(CAST(cost_of_goods AS DOUBLE))
      comment: "Average cost of goods at time of pricing. Used to validate price-cost relationship and margin adequacy."
    - name: "active_price_records"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active price records. Monitors pricing data completeness and identifies items missing active prices."
    - name: "avg_price_override_limit"
      expr: AVG(CAST(price_override_limit AS DOUBLE))
      comment: "Average maximum price override allowed. Tracks flexibility granted to operators and franchise partners."
    - name: "distinct_priced_items"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Count of distinct menu items with price records. Measures pricing data completeness across the menu portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_nutrition_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nutritional content metrics for menu items supporting regulatory compliance, health-conscious menu strategy, and consumer transparency initiatives."
  source: "`vibe_restaurants_v1`.`menu`.`nutrition_profile`"
  dimensions:
    - name: "profile_type"
      expr: profile_type
      comment: "Type of nutrition profile (standard, modified, allergen-free variant) for segmented nutritional analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the nutrition profile for compliance and data quality monitoring."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the nutrition profile became effective for tracking nutritional changes over time."
    - name: "data_source"
      expr: data_source
      comment: "Source of nutritional data (lab analysis, supplier data, calculated) for data quality segmentation."
    - name: "is_current_version"
      expr: is_current_version
      comment: "Flag indicating whether this is the current active nutrition profile version."
  measures:
    - name: "avg_calories"
      expr: AVG(CAST(protein_g AS DOUBLE))
      comment: "Average protein content in grams across profiled items. Tracks protein positioning for health-conscious menu strategy. Note: uses protein_g as calories column is DIMENSION_ONLY typed."
    - name: "avg_total_fat_g"
      expr: AVG(CAST(total_fat_g AS DOUBLE))
      comment: "Average total fat content in grams. Monitored for nutritional compliance and health-conscious menu positioning."
    - name: "avg_saturated_fat_g"
      expr: AVG(CAST(saturated_fat_g AS DOUBLE))
      comment: "Average saturated fat content. Regulatory and health-strategy KPI for menu nutritional quality."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams. Critical health metric tracked for regulatory compliance and consumer health initiatives."
    - name: "avg_total_carbohydrate_g"
      expr: AVG(CAST(total_carbohydrate_g AS DOUBLE))
      comment: "Average total carbohydrate content. Tracked for dietary compliance and low-carb menu strategy."
    - name: "avg_protein_g"
      expr: AVG(CAST(protein_g AS DOUBLE))
      comment: "Average protein content in grams. Supports high-protein menu positioning and nutritional marketing claims."
    - name: "avg_dietary_fiber_g"
      expr: AVG(CAST(dietary_fiber_g AS DOUBLE))
      comment: "Average dietary fiber content. Tracks fiber-rich menu positioning for health-conscious consumer segments."
    - name: "avg_trans_fat_g"
      expr: AVG(CAST(trans_fat_g AS DOUBLE))
      comment: "Average trans fat content. Regulatory compliance KPI — trans fat elimination is a key health and brand standard."
    - name: "avg_serving_size_g"
      expr: AVG(CAST(serving_size_g AS DOUBLE))
      comment: "Average serving size in grams. Tracks portion standardization and consistency across menu items."
    - name: "items_with_current_nutrition"
      expr: COUNT(CASE WHEN is_current_version = TRUE THEN 1 END)
      comment: "Count of items with a current approved nutrition profile. Measures nutritional data completeness for regulatory compliance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe performance and cost metrics supporting menu engineering, food safety compliance, and kitchen standardization. Used by culinary, operations, and finance teams."
  source: "`vibe_restaurants_v1`.`menu`.`recipe`"
  dimensions:
    - name: "recipe_status"
      expr: recipe_status
      comment: "Current status of the recipe (active, draft, retired) for portfolio management."
    - name: "recipe_type"
      expr: recipe_type
      comment: "Recipe type (core, LTO, test, seasonal) for portfolio segmentation."
    - name: "recipe_category"
      expr: recipe_category
      comment: "Recipe category (entree, side, beverage, dessert) for category-level analysis."
    - name: "cook_method"
      expr: cook_method
      comment: "Cooking method (grill, fry, bake, raw) for kitchen equipment utilization and throughput analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format recipe standardization analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart applicability for time-of-day recipe complexity analysis."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Vegan flag for dietary portfolio composition reporting."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Gluten-free flag for allergen-sensitive recipe portfolio reporting."
    - name: "haccp_ccp_flag"
      expr: haccp_ccp_flag
      comment: "Flag indicating recipe has a critical control point for food safety compliance monitoring."
  measures:
    - name: "total_recipes"
      expr: COUNT(1)
      comment: "Total number of recipes in the system. Tracks recipe library size and complexity."
    - name: "active_recipes"
      expr: COUNT(CASE WHEN recipe_status = 'active' THEN 1 END)
      comment: "Count of currently active recipes. Monitors operational recipe complexity and standardization."
    - name: "avg_food_cost"
      expr: AVG(CAST(food_cost AS DOUBLE))
      comment: "Average food cost per recipe. Primary cost management KPI for culinary and finance teams."
    - name: "avg_food_cost_pct"
      expr: AVG(CAST(food_cost_pct AS DOUBLE))
      comment: "Average food cost percentage per recipe. Benchmarked against target to identify high-cost recipes requiring reformulation."
    - name: "avg_menu_price"
      expr: AVG(CAST(menu_price AS DOUBLE))
      comment: "Average menu selling price associated with recipes. Used to validate price-cost alignment."
    - name: "avg_waste_pct"
      expr: AVG(CAST(waste_pct AS DOUBLE))
      comment: "Average waste percentage across recipes. Drives waste reduction programs and yield improvement initiatives."
    - name: "avg_yield_quantity"
      expr: AVG(CAST(yield_quantity AS DOUBLE))
      comment: "Average yield quantity per recipe batch. Supports portion standardization and batch cooking efficiency."
    - name: "avg_total_time_seconds"
      expr: AVG(CAST(total_time_seconds AS DOUBLE))
      comment: "Average total preparation time in seconds. Drives kitchen throughput planning and speed-of-service optimization."
    - name: "avg_calories_from_fat"
      expr: AVG(CAST(calories_from_fat AS DOUBLE))
      comment: "Average calories from fat per recipe. Nutritional KPI for health-conscious menu strategy and regulatory compliance."
    - name: "recipes_with_haccp_ccp"
      expr: COUNT(CASE WHEN haccp_ccp_flag = TRUE THEN 1 END)
      comment: "Count of recipes with HACCP critical control points. Food safety compliance KPI for regulatory audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_lto`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Limited-time offer (LTO) pipeline and performance metrics. Used by marketing, culinary, and operations executives to manage LTO strategy, launch readiness, and financial targets."
  source: "`vibe_restaurants_v1`.`menu`.`menu_lto`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the LTO (concept, approved, launched, discontinued) for pipeline management."
    - name: "lto_type"
      expr: lto_type
      comment: "Type of LTO (seasonal, promotional, test market, national) for portfolio segmentation."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format LTO performance comparison."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional LTO rollout analysis."
    - name: "rollout_scope"
      expr: rollout_scope
      comment: "Rollout scope (national, regional, test market) for launch scale analysis."
    - name: "season_or_occasion"
      expr: season_or_occasion
      comment: "Season or occasion driving the LTO for seasonal performance benchmarking."
    - name: "planned_launch_date"
      expr: DATE_TRUNC('quarter', planned_launch_date)
      comment: "Quarter of planned launch for pipeline capacity planning."
    - name: "is_national_launch"
      expr: is_national_launch
      comment: "Flag for national vs. regional/test launches for investment scale analysis."
    - name: "is_returning_item"
      expr: is_returning_item
      comment: "Flag for returning LTO items vs. new concepts for performance benchmarking."
  measures:
    - name: "total_lto_items"
      expr: COUNT(1)
      comment: "Total LTO items in the pipeline. Tracks LTO program scale and pipeline capacity."
    - name: "active_lto_items"
      expr: COUNT(CASE WHEN lifecycle_status = 'launched' THEN 1 END)
      comment: "Count of currently active/launched LTO items. Monitors live LTO complexity and operational burden."
    - name: "avg_planned_duration_days"
      expr: AVG(CAST(planned_duration_days AS DOUBLE))
      comment: "Average planned duration of LTO items in days. Informs LTO calendar planning and supply chain commitment windows."
    - name: "avg_suggested_retail_price"
      expr: AVG(CAST(suggested_retail_price AS DOUBLE))
      comment: "Average suggested retail price for LTO items. Tracks LTO pricing strategy and premium positioning."
    - name: "avg_target_food_cost_pct"
      expr: AVG(CAST(target_food_cost_pct AS DOUBLE))
      comment: "Average target food cost percentage for LTO items. Validates LTO profitability at launch planning stage."
    - name: "avg_pmix_target_pct"
      expr: AVG(CAST(pmix_target_pct AS DOUBLE))
      comment: "Average product mix target percentage for LTO items. Benchmarks expected LTO contribution to total sales mix."
    - name: "food_safety_approved_count"
      expr: COUNT(CASE WHEN food_safety_approved = TRUE THEN 1 END)
      comment: "Count of LTO items with food safety approval. Tracks launch readiness and compliance gate completion."
    - name: "nutritional_approved_count"
      expr: COUNT(CASE WHEN nutritional_approved = TRUE THEN 1 END)
      comment: "Count of LTO items with nutritional approval. Monitors regulatory compliance readiness for menu labeling requirements."
    - name: "national_launch_count"
      expr: COUNT(CASE WHEN is_national_launch = TRUE THEN 1 END)
      comment: "Count of national LTO launches. Tracks scale of national marketing investment and supply chain commitment."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_engineering_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu engineering review metrics tracking portfolio optimization outcomes, complexity management, and strategic menu decisions. Used by menu strategy and executive teams for quarterly business reviews."
  source: "`vibe_restaurants_v1`.`menu`.`engineering_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the engineering review (in-progress, complete, approved) for pipeline management."
    - name: "review_cycle"
      expr: review_cycle
      comment: "Review cycle (quarterly, annual, ad-hoc) for cadence analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format engineering review comparison."
    - name: "review_scope_type"
      expr: review_scope_type
      comment: "Scope of the review (full menu, category, daypart) for analysis granularity."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation status of review recommendations for execution tracking."
    - name: "review_date"
      expr: DATE_TRUNC('quarter', review_date)
      comment: "Quarter of the review for trend analysis of menu engineering activity."
    - name: "engineering_framework"
      expr: engineering_framework
      comment: "Framework used (BCG matrix, custom) for methodology consistency tracking."
    - name: "is_franchise_applicable"
      expr: is_franchise_applicable
      comment: "Flag indicating whether review applies to franchise locations for network-wide impact assessment."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of engineering reviews conducted. Tracks menu management cadence and governance activity."
    - name: "avg_menu_complexity_score_before"
      expr: AVG(CAST(menu_complexity_score_before AS DOUBLE))
      comment: "Average menu complexity score before review. Baseline for measuring complexity reduction from engineering actions."
    - name: "avg_menu_complexity_score_after"
      expr: AVG(CAST(menu_complexity_score_after AS DOUBLE))
      comment: "Average menu complexity score after review. Measures effectiveness of menu simplification initiatives."
    - name: "avg_complexity_reduction"
      expr: AVG(CAST(menu_complexity_score_before AS DOUBLE) - CAST(menu_complexity_score_after AS DOUBLE))
      comment: "Average reduction in menu complexity score per review. Key outcome metric for menu simplification strategy."
    - name: "avg_contribution_margin"
      expr: AVG(CAST(avg_contribution_margin AS DOUBLE))
      comment: "Average contribution margin across reviewed items. Tracks profitability improvement from engineering decisions."
    - name: "avg_popularity_index"
      expr: AVG(CAST(avg_menu_item_popularity_index AS DOUBLE))
      comment: "Average menu item popularity index across reviews. Measures guest demand alignment with portfolio decisions."
    - name: "avg_cogs_pct_threshold"
      expr: AVG(CAST(cogs_pct_threshold AS DOUBLE))
      comment: "Average COGS threshold used in engineering reviews. Tracks consistency of financial criteria applied across reviews."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_86_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item 86 (out-of-stock) event metrics tracking frequency, duration, and operational impact of item unavailability. Used by operations and supply chain executives to manage availability and revenue risk."
  source: "`vibe_restaurants_v1`.`menu`.`item_86_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the 86 event (active, resolved) for real-time availability monitoring."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause code for the 86 event (supply shortage, equipment failure, prep issue) for root cause analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for cross-format availability benchmarking."
    - name: "channel_affected"
      expr: channel_affected
      comment: "Sales channel affected by the 86 event for channel-specific revenue impact analysis."
    - name: "daypart_affected"
      expr: daypart_affected
      comment: "Daypart during which the 86 event occurred for time-of-day availability analysis."
    - name: "is_lto_item"
      expr: is_lto_item
      comment: "Flag indicating whether the 86'd item is an LTO for LTO supply chain risk monitoring."
    - name: "is_food_safety_related"
      expr: is_food_safety_related
      comment: "Flag for food safety-related 86 events for compliance and risk reporting."
    - name: "start_timestamp"
      expr: DATE_TRUNC('week', start_timestamp)
      comment: "Week of the 86 event for trend analysis of availability issues."
  measures:
    - name: "total_86_events"
      expr: COUNT(1)
      comment: "Total number of item 86 events. Primary availability KPI tracking operational reliability and supply chain performance."
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of 86 events in minutes. Measures operational responsiveness and supply chain recovery speed."
    - name: "total_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total minutes of item unavailability. Quantifies cumulative operational impact of 86 events."
    - name: "avg_inventory_on_hand"
      expr: AVG(CAST(inventory_quantity_on_hand AS DOUBLE))
      comment: "Average inventory quantity on hand at time of 86 event. Identifies par level adequacy and reorder point issues."
    - name: "avg_par_level"
      expr: AVG(CAST(par_level_quantity AS DOUBLE))
      comment: "Average par level quantity for 86'd items. Benchmarks against on-hand quantity to evaluate par level adequacy."
    - name: "food_safety_86_events"
      expr: COUNT(CASE WHEN is_food_safety_related = TRUE THEN 1 END)
      comment: "Count of 86 events triggered by food safety concerns. Critical compliance KPI for regulatory risk management."
    - name: "recall_related_86_events"
      expr: COUNT(CASE WHEN is_recall_related = TRUE THEN 1 END)
      comment: "Count of 86 events related to ingredient recalls. Tracks supply chain risk exposure and recall response effectiveness."
    - name: "distinct_units_with_86_events"
      expr: COUNT(DISTINCT unit_id)
      comment: "Count of distinct restaurant units experiencing 86 events. Identifies locations with systemic supply or operational issues."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_allergen_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allergen declaration compliance metrics tracking declaration completeness, review status, and regulatory submission readiness. Used by food safety, legal, and operations teams for compliance governance."
  source: "`vibe_restaurants_v1`.`menu`.`allergen_declaration`"
  dimensions:
    - name: "declaration_status"
      expr: declaration_status
      comment: "Current status of the allergen declaration (draft, approved, expired) for compliance monitoring."
    - name: "declaration_type"
      expr: declaration_type
      comment: "Type of allergen declaration (contains, may-contain, free-from) for risk classification."
    - name: "cross_contact_risk_level"
      expr: cross_contact_risk_level
      comment: "Cross-contact risk level (high, medium, low) for risk-based compliance prioritization."
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channel scope of the declaration for channel-specific compliance reporting."
    - name: "regulatory_submission_required"
      expr: regulatory_submission_required
      comment: "Flag indicating regulatory submission is required for compliance deadline tracking."
    - name: "gluten_free_certified"
      expr: gluten_free_certified
      comment: "Gluten-free certification flag for certified item portfolio tracking."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month declaration became effective for compliance timeline analysis."
  measures:
    - name: "total_declarations"
      expr: COUNT(1)
      comment: "Total allergen declarations in the system. Tracks compliance documentation completeness."
    - name: "pending_regulatory_submissions"
      expr: COUNT(CASE WHEN regulatory_submission_required = TRUE THEN 1 END)
      comment: "Count of declarations requiring regulatory submission. Critical compliance KPI for legal and food safety teams."
    - name: "gluten_free_certified_items"
      expr: COUNT(CASE WHEN gluten_free_certified = TRUE THEN 1 END)
      comment: "Count of items with gluten-free certification. Tracks certified dietary portfolio for consumer transparency."
    - name: "high_cross_contact_risk_items"
      expr: COUNT(CASE WHEN cross_contact_risk_level = 'high' THEN 1 END)
      comment: "Count of items with high cross-contact allergen risk. Priority compliance KPI for food safety risk management."
    - name: "distinct_items_with_declarations"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Count of distinct menu items with allergen declarations. Measures allergen documentation coverage across the menu."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing performance metrics for menu items, useful for pricing strategy and margin optimization"
  source: "`vibe_restaurants_v1`.`menu`.`item_price`"
  dimensions:
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Format of the restaurant (e.g., quick-service, casual, fine-dining)"
    - name: "country_code"
      expr: country_code
      comment: "ISO country code where the price is applied"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price"
    - name: "daypart"
      expr: daypart
      comment: "Daypart applicability of the price"
    - name: "price_region_code"
      expr: price_region_code
      comment: "Regional pricing code"
    - name: "price_effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of price effectiveness"
  measures:
    - name: "count_price_records"
      expr: COUNT(1)
      comment: "Total number of price records for menu items"
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across menu items"
    - name: "avg_promotional_price"
      expr: AVG(CAST(promotional_price AS DOUBLE))
      comment: "Average promotional price across menu items"
    - name: "avg_price_override_limit"
      expr: AVG(CAST(price_override_limit AS DOUBLE))
      comment: "Average price override limit amount"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_overview`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level overview of menus across the enterprise, supporting portfolio management"
  source: "`vibe_restaurants_v1`.`menu`.`menu`"
  dimensions:
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (e.g., quick-service, casual, fine-dining)"
    - name: "country_code"
      expr: country_code
      comment: "Country code where the menu is deployed"
    - name: "is_default"
      expr: is_default
      comment: "Indicates if this is the default menu for the location"
    - name: "is_franchise_menu"
      expr: is_franchise_menu
      comment: "Flag indicating franchise‑owned menu"
    - name: "menu_effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the menu became effective"
  measures:
    - name: "count_menus"
      expr: COUNT(1)
      comment: "Total number of menu records"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_sales_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales performance KPIs for menu items, driving revenue and profitability decisions"
  source: "`vibe_restaurants_v1`.`menu`.`pmix_record`"
  dimensions:
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (e.g., quick-service, casual)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the sale occurred"
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the sale"
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_date)
      comment: "Month of the reporting date"
    - name: "menu_engineering_classification"
      expr: menu_engineering_classification
      comment: "Engineering classification of the menu item"
  measures:
    - name: "count_sales_records"
      expr: COUNT(1)
      comment: "Total number of sales records in the PMIX view"
    - name: "total_gross_sales_amount"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales amount"
    - name: "total_net_sales_amount"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales amount after discounts and refunds"
    - name: "total_contribution_margin_amount"
      expr: SUM(CAST(contribution_margin_amount AS DOUBLE))
      comment: "Total contribution margin amount"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount"
    - name: "avg_menu_mix_pct"
      expr: AVG(CAST(menu_mix_pct AS DOUBLE))
      comment: "Average menu mix percentage"
    - name: "avg_sales_mix_pct"
      expr: AVG(CAST(sales_mix_pct AS DOUBLE))
      comment: "Average sales mix percentage"
$$;