-- Metric views for domain: menu | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:59:48

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for menu item portfolio management — pricing, cost structure, dietary positioning, and LTO lifecycle performance. Used by menu engineering, culinary, and finance teams to steer item-level profitability and portfolio health."
  source: "`vibe_restaurants_v1`.`menu`.`menu_item`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Current lifecycle status of the menu item (e.g. Active, Discontinued, Pending). Primary filter for active portfolio analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the item belongs to (e.g. Breakfast, Lunch, Dinner, All-Day). Enables daypart-level menu engineering analysis."
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering classification (e.g. Star, Plow Horse, Puzzle, Dog). Core dimension for portfolio profitability steering."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format the item is available in (e.g. Drive-Thru, Dine-In, Fast Casual). Enables format-level portfolio comparison."
    - name: "subcategory"
      expr: subcategory
      comment: "Menu subcategory (e.g. Burgers, Sides, Beverages). Enables category-level portfolio analysis."
    - name: "is_lto"
      expr: is_lto
      comment: "Indicates whether the item is a Limited Time Offer. Separates core menu from promotional items for lifecycle analysis."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Indicates whether the item is vegan. Supports dietary portfolio mix reporting."
    - name: "is_vegetarian"
      expr: is_vegetarian
      comment: "Indicates whether the item is vegetarian. Supports dietary portfolio mix reporting."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Indicates whether the item is gluten-free. Supports allergen and dietary portfolio mix reporting."
    - name: "launch_date"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month of item launch. Enables cohort analysis of items launched in the same period."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which item pricing is denominated. Required for multi-currency portfolio analysis."
  measures:
    - name: "total_active_items"
      expr: COUNT(CASE WHEN item_status = 'Active' THEN menu_item_id END)
      comment: "Count of currently active menu items. Tracks portfolio breadth and complexity — a key input to menu simplification decisions."
    - name: "total_lto_items"
      expr: COUNT(CASE WHEN is_lto = TRUE THEN menu_item_id END)
      comment: "Count of Limited Time Offer items currently in the portfolio. Tracks promotional pipeline depth and LTO cadence."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base selling price across menu items. Tracks price positioning and supports price-tier benchmarking."
    - name: "avg_item_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average unit cost across menu items. Tracks cost structure of the portfolio for margin management."
    - name: "avg_gross_margin_amount"
      expr: AVG(CAST(base_price AS DOUBLE) - CAST(cost AS DOUBLE))
      comment: "Average gross margin (price minus cost) per menu item. Direct indicator of item-level profitability for menu engineering decisions."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams across menu items. Tracks nutritional profile of the portfolio for regulatory compliance and health positioning."
    - name: "avg_portion_size_grams"
      expr: AVG(CAST(portion_size_grams AS DOUBLE))
      comment: "Average portion size in grams across menu items. Supports value perception and cost-per-gram benchmarking."
    - name: "pct_lto_items"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_lto = TRUE THEN menu_item_id END) / NULLIF(COUNT(menu_item_id), 0), 2)
      comment: "Percentage of menu items that are Limited Time Offers. Tracks LTO intensity — high LTO share may signal over-reliance on promotions vs. core menu strength."
    - name: "pct_vegan_items"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_vegan = TRUE THEN menu_item_id END) / NULLIF(COUNT(menu_item_id), 0), 2)
      comment: "Percentage of menu items that are vegan. Tracks dietary inclusivity of the portfolio — a growing strategic priority for brand positioning."
    - name: "pct_gluten_free_items"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_gluten_free = TRUE THEN menu_item_id END) / NULLIF(COUNT(menu_item_id), 0), 2)
      comment: "Percentage of menu items that are gluten-free. Tracks allergen-safe portfolio coverage for regulatory and guest experience purposes."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing strategy and price integrity KPIs — covering base price levels, promotional discounting depth, channel surcharges, and COGS margin at the price record level. Used by revenue management, finance, and franchise operations teams."
  source: "`vibe_restaurants_v1`.`menu`.`item_price`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Sales channel for this price record (e.g. Dine-In, Drive-Thru, Delivery). Enables channel-level pricing strategy analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for this price record (e.g. Breakfast, Lunch, Dinner). Enables daypart-level pricing analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for this price record. Enables format-level pricing comparison."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g. Corporate, Franchise). Critical for franchise vs. corporate pricing compliance analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the price record (e.g. Approved, Pending, Rejected). Tracks pricing governance compliance."
    - name: "is_active"
      expr: is_active
      comment: "Whether the price record is currently active. Primary filter for live pricing analysis."
    - name: "is_lto"
      expr: is_lto
      comment: "Whether this price record is for a Limited Time Offer. Separates promotional pricing from core menu pricing."
    - name: "price_elasticity_band"
      expr: price_elasticity_band
      comment: "Price elasticity band assigned to the item. Enables demand-sensitivity segmentation for pricing decisions."
    - name: "menu_engineering_category"
      expr: menu_engineering_category
      comment: "Menu engineering category for this price record. Enables profitability-class-level pricing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for this price record. Required for multi-currency pricing analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the price became effective. Enables price change trend analysis over time."
  measures:
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base menu price across price records. Core pricing KPI for benchmarking and price positioning strategy."
    - name: "avg_suggested_retail_price"
      expr: AVG(CAST(suggested_retail_price AS DOUBLE))
      comment: "Average suggested retail price. Tracks alignment between actual pricing and recommended price points."
    - name: "avg_promotional_price"
      expr: AVG(CAST(promotional_price AS DOUBLE))
      comment: "Average promotional price across LTO and promotional price records. Tracks depth of promotional discounting."
    - name: "avg_channel_surcharge"
      expr: AVG(CAST(channel_surcharge AS DOUBLE))
      comment: "Average channel surcharge applied (e.g. delivery upcharge). Tracks channel monetization strategy and guest price impact."
    - name: "avg_cogs_pct"
      expr: AVG(CAST(cogs_pct AS DOUBLE))
      comment: "Average cost of goods sold percentage at the price record level. Primary food cost margin KPI for menu profitability management."
    - name: "avg_franchise_price_deviation_pct"
      expr: AVG(CAST(franchise_price_deviation_pct AS DOUBLE))
      comment: "Average percentage deviation of franchise prices from corporate recommended prices. Tracks franchise pricing compliance — high deviation signals brand price integrity risk."
    - name: "avg_promotional_discount_amount"
      expr: AVG(CAST(base_price AS DOUBLE) - CAST(promotional_price AS DOUBLE))
      comment: "Average discount amount between base price and promotional price. Tracks promotional discount depth for revenue impact assessment."
    - name: "pct_prices_approved"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN item_price_id END) / NULLIF(COUNT(item_price_id), 0), 2)
      comment: "Percentage of price records in Approved status. Tracks pricing governance compliance — unapproved prices represent operational and brand risk."
    - name: "pct_active_prices"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN item_price_id END) / NULLIF(COUNT(item_price_id), 0), 2)
      comment: "Percentage of price records that are currently active. Tracks pricing data hygiene and active price coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food cost and margin management KPIs at the item-cost-record level — covering theoretical vs. actual COGS, waste, yield, and cost variance. Used by finance, supply chain, and culinary operations to manage food cost targets."
  source: "`vibe_restaurants_v1`.`menu`.`item_cost`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Sales channel for this cost record. Enables channel-level food cost analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for this cost record. Enables daypart-level food cost analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format for this cost record. Enables format-level food cost benchmarking."
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering class for this cost record. Enables profitability-class-level cost analysis."
    - name: "cost_status"
      expr: cost_status
      comment: "Status of the cost record (e.g. Approved, Draft, Superseded). Filters for active cost records in reporting."
    - name: "cost_calculation_method"
      expr: cost_calculation_method
      comment: "Method used to calculate cost (e.g. Theoretical, Actual, Weighted Average). Enables methodology-level cost comparison."
    - name: "is_lto"
      expr: is_lto
      comment: "Whether this cost record is for a Limited Time Offer item. Separates LTO cost management from core menu."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for this cost record. Required for multi-currency cost analysis."
    - name: "cost_calculation_date"
      expr: DATE_TRUNC('month', cost_calculation_date)
      comment: "Month the cost was calculated. Enables trend analysis of food cost over time."
  measures:
    - name: "avg_actual_cogs_pct"
      expr: AVG(CAST(actual_cogs_pct AS DOUBLE))
      comment: "Average actual COGS percentage across cost records. Primary food cost KPI — directly tied to restaurant profitability and a key P&L line item."
    - name: "avg_target_cogs_pct"
      expr: AVG(CAST(target_cogs_pct AS DOUBLE))
      comment: "Average target COGS percentage. Benchmark for actual vs. target food cost performance management."
    - name: "avg_theoretical_cogs_pct"
      expr: AVG(CAST(theoretical_cogs_pct AS DOUBLE))
      comment: "Average theoretical COGS percentage based on recipe standards. Baseline for variance analysis against actual food cost."
    - name: "avg_cogs_pct_variance"
      expr: AVG(CAST(cogs_pct_variance AS DOUBLE))
      comment: "Average variance between actual and target COGS percentage. Tracks food cost control performance — positive variance signals overspend vs. plan."
    - name: "avg_theoretical_cost_variance_amount"
      expr: AVG(CAST(theoretical_cost_variance_amount AS DOUBLE))
      comment: "Average dollar variance between theoretical and actual cost. Quantifies the financial impact of food cost inefficiencies for P&L management."
    - name: "avg_waste_pct"
      expr: AVG(CAST(waste_pct AS DOUBLE))
      comment: "Average waste percentage across cost records. Tracks food waste efficiency — a key sustainability and cost control KPI."
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_pct AS DOUBLE))
      comment: "Average yield percentage across cost records. Tracks ingredient utilization efficiency — low yield drives higher effective food cost."
    - name: "avg_packaging_cost"
      expr: AVG(CAST(packaging_cost AS DOUBLE))
      comment: "Average packaging cost per item cost record. Tracks packaging as a component of total item cost for margin management."
    - name: "avg_primary_protein_cost"
      expr: AVG(CAST(primary_protein_cost AS DOUBLE))
      comment: "Average primary protein cost per item. Tracks the most volatile cost component — protein prices directly drive food cost fluctuations."
    - name: "avg_base_selling_price"
      expr: AVG(CAST(base_selling_price AS DOUBLE))
      comment: "Average base selling price at the cost record level. Used alongside COGS to assess margin at the item-cost snapshot level."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_combo_meal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Combo meal portfolio and bundle economics KPIs — covering bundle pricing, discount depth, food cost, and availability across channels and formats. Used by menu engineering, marketing, and finance to optimize combo strategy."
  source: "`vibe_restaurants_v1`.`menu`.`combo_meal`"
  dimensions:
    - name: "combo_status"
      expr: combo_status
      comment: "Current status of the combo meal (e.g. Active, Discontinued, Pending). Primary filter for active combo portfolio analysis."
    - name: "combo_type"
      expr: combo_type
      comment: "Type of combo (e.g. Value Meal, Family Bundle, Kids Meal). Enables combo-type-level performance analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the combo is available in. Enables daypart-level combo mix analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format the combo is available in. Enables format-level combo strategy analysis."
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering classification for the combo. Enables profitability-class-level combo portfolio analysis."
    - name: "is_national_launch"
      expr: is_national_launch
      comment: "Whether the combo is a national launch. Separates national vs. regional combo performance."
    - name: "is_3pd_available"
      expr: is_3pd_available
      comment: "Whether the combo is available on third-party delivery platforms. Tracks 3PD channel combo coverage."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for combo pricing. Required for multi-currency combo analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the combo is offered. Enables geographic combo strategy analysis."
    - name: "launch_date"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month the combo was launched. Enables cohort analysis of combo launches."
  measures:
    - name: "total_active_combos"
      expr: COUNT(CASE WHEN combo_status = 'Active' THEN combo_meal_id END)
      comment: "Count of currently active combo meals. Tracks combo portfolio breadth — a key input to menu complexity management."
    - name: "avg_bundle_price"
      expr: AVG(CAST(bundle_price AS DOUBLE))
      comment: "Average bundle price across combo meals. Core combo pricing KPI for value positioning and competitive benchmarking."
    - name: "avg_individual_items_price_sum"
      expr: AVG(CAST(individual_items_price_sum AS DOUBLE))
      comment: "Average sum of individual item prices if purchased separately. Baseline for calculating bundle discount value."
    - name: "avg_bundle_discount_amount"
      expr: AVG(CAST(bundle_discount_amount AS DOUBLE))
      comment: "Average discount amount provided by the combo bundle vs. individual items. Tracks bundle value proposition — a key driver of combo attachment rate."
    - name: "avg_food_cost_pct"
      expr: AVG(CAST(food_cost_pct AS DOUBLE))
      comment: "Average food cost percentage for combo meals. Tracks combo-level margin — combos with high food cost pct erode profitability despite high volume."
    - name: "avg_item_cost"
      expr: AVG(CAST(item_cost AS DOUBLE))
      comment: "Average item cost for combo meals. Tracks absolute cost structure of the combo portfolio."
    - name: "avg_pmix_target_pct"
      expr: AVG(CAST(pmix_target_pct AS DOUBLE))
      comment: "Average product mix target percentage for combo meals. Tracks planned combo contribution to overall sales mix."
    - name: "pct_combos_on_3pd"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_3pd_available = TRUE THEN combo_meal_id END) / NULLIF(COUNT(combo_meal_id), 0), 2)
      comment: "Percentage of combo meals available on third-party delivery platforms. Tracks 3PD channel coverage of the combo portfolio — a key digital revenue enabler."
    - name: "pct_national_launch_combos"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_national_launch = TRUE THEN combo_meal_id END) / NULLIF(COUNT(combo_meal_id), 0), 2)
      comment: "Percentage of combo meals that are national launches. Tracks national vs. regional combo strategy balance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe portfolio and culinary operations KPIs — covering food cost, nutritional profile, prep efficiency, waste, and yield at the recipe level. Used by culinary R&D, operations, and food safety teams to govern recipe standards."
  source: "`vibe_restaurants_v1`.`menu`.`recipe`"
  dimensions:
    - name: "recipe_status"
      expr: recipe_status
      comment: "Current status of the recipe (e.g. Active, Draft, Retired). Primary filter for active recipe portfolio analysis."
    - name: "recipe_type"
      expr: recipe_type
      comment: "Type of recipe (e.g. Core, LTO, Seasonal). Enables recipe-type-level portfolio analysis."
    - name: "category"
      expr: category
      comment: "Recipe category (e.g. Entree, Side, Beverage). Enables category-level recipe portfolio analysis."
    - name: "subcategory"
      expr: subcategory
      comment: "Recipe subcategory. Enables granular category-level recipe analysis."
    - name: "cook_method"
      expr: cook_method
      comment: "Cooking method (e.g. Fried, Grilled, Baked). Enables equipment utilization and operational complexity analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the recipe is used in. Enables daypart-level recipe portfolio analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format the recipe applies to. Enables format-level recipe standardization analysis."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Whether the recipe is gluten-free. Supports dietary portfolio mix reporting."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Whether the recipe is vegan. Supports dietary portfolio mix reporting."
    - name: "haccp_ccp_flag"
      expr: haccp_ccp_flag
      comment: "Whether the recipe has a HACCP Critical Control Point. Tracks food safety risk concentration in the recipe portfolio."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the recipe became effective. Enables recipe version trend analysis."
  measures:
    - name: "total_active_recipes"
      expr: COUNT(CASE WHEN recipe_status = 'Active' THEN recipe_id END)
      comment: "Count of currently active recipes. Tracks recipe portfolio complexity — a key input to kitchen operations and training burden."
    - name: "avg_food_cost"
      expr: AVG(CAST(food_cost AS DOUBLE))
      comment: "Average food cost per recipe. Core recipe-level cost KPI for culinary and finance teams."
    - name: "avg_food_cost_pct"
      expr: AVG(CAST(food_cost_pct AS DOUBLE))
      comment: "Average food cost percentage per recipe. Tracks recipe-level margin — directly tied to restaurant profitability."
    - name: "avg_menu_price"
      expr: AVG(CAST(menu_price AS DOUBLE))
      comment: "Average menu price across recipes. Tracks price positioning of the recipe portfolio."
    - name: "avg_calories"
      expr: AVG(CAST(calories AS DOUBLE))
      comment: "Average calorie count per recipe. Tracks nutritional profile of the recipe portfolio for health positioning and regulatory disclosure."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams per recipe. Tracks sodium levels for regulatory compliance and health positioning."
    - name: "avg_waste_pct"
      expr: AVG(CAST(waste_pct AS DOUBLE))
      comment: "Average waste percentage per recipe. Tracks food waste efficiency — a key sustainability and cost control KPI at the recipe level."
    - name: "avg_yield_quantity"
      expr: AVG(CAST(yield_quantity AS DOUBLE))
      comment: "Average yield quantity per recipe. Tracks recipe output efficiency for production planning and cost-per-serving calculations."
    - name: "avg_cook_temperature_f"
      expr: AVG(CAST(cook_temperature_f AS DOUBLE))
      comment: "Average cook temperature in Fahrenheit. Tracks food safety compliance — recipes below minimum safe temperatures represent HACCP risk."
    - name: "pct_recipes_with_haccp_ccp"
      expr: ROUND(100.0 * COUNT(CASE WHEN haccp_ccp_flag = TRUE THEN recipe_id END) / NULLIF(COUNT(recipe_id), 0), 2)
      comment: "Percentage of recipes with a HACCP Critical Control Point. Tracks food safety risk concentration — high CCP share requires robust training and monitoring investment."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_nutrition_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nutritional compliance and portfolio health KPIs at the nutrition profile level — covering macronutrient averages, sodium, and regulatory disclosure readiness. Used by regulatory affairs, culinary R&D, and marketing for menu health positioning and compliance."
  source: "`vibe_restaurants_v1`.`menu`.`nutrition_profile`"
  dimensions:
    - name: "profile_type"
      expr: profile_type
      comment: "Type of nutrition profile (e.g. As Served, As Prepared, Customized). Enables profile-type-level nutritional analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the nutrition profile. Tracks regulatory compliance readiness of nutritional data."
    - name: "is_current_version"
      expr: is_current_version
      comment: "Whether this is the current version of the nutrition profile. Primary filter for current nutritional data analysis."
    - name: "data_source"
      expr: data_source
      comment: "Source of nutritional data (e.g. Lab Analysis, Database, Calculated). Tracks data quality and regulatory defensibility."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the nutrition profile became effective. Enables trend analysis of nutritional profile changes over time."
    - name: "lab_analysis_date"
      expr: DATE_TRUNC('month', lab_analysis_date)
      comment: "Month of lab analysis. Tracks recency of lab-validated nutritional data for compliance purposes."
  measures:
    - name: "avg_total_fat_g"
      expr: AVG(CAST(total_fat_g AS DOUBLE))
      comment: "Average total fat in grams per nutrition profile. Tracks fat content of the menu portfolio for health positioning and regulatory disclosure."
    - name: "avg_saturated_fat_g"
      expr: AVG(CAST(saturated_fat_g AS DOUBLE))
      comment: "Average saturated fat in grams. Tracks saturated fat levels — a key regulatory and health-positioning metric for menu labeling compliance."
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium in milligrams per nutrition profile. Tracks sodium levels across the menu — a primary regulatory and public health KPI for restaurant chains."
    - name: "avg_total_carbohydrate_g"
      expr: AVG(CAST(total_carbohydrate_g AS DOUBLE))
      comment: "Average total carbohydrates in grams. Tracks carbohydrate content for dietary positioning and nutritional disclosure."
    - name: "avg_protein_g"
      expr: AVG(CAST(protein_g AS DOUBLE))
      comment: "Average protein in grams per nutrition profile. Tracks protein content — a key marketing and health positioning metric for restaurant menus."
    - name: "avg_dietary_fiber_g"
      expr: AVG(CAST(dietary_fiber_g AS DOUBLE))
      comment: "Average dietary fiber in grams. Tracks fiber content for health positioning and nutritional disclosure."
    - name: "avg_cholesterol_mg"
      expr: AVG(CAST(cholesterol_mg AS DOUBLE))
      comment: "Average cholesterol in milligrams. Tracks cholesterol levels for regulatory compliance and health positioning."
    - name: "avg_trans_fat_g"
      expr: AVG(CAST(trans_fat_g AS DOUBLE))
      comment: "Average trans fat in grams. Tracks trans fat content — a critical regulatory metric as many jurisdictions mandate near-zero trans fat levels."
    - name: "avg_added_sugars_g"
      expr: AVG(CAST(added_sugars_g AS DOUBLE))
      comment: "Average added sugars in grams. Tracks added sugar content — a key regulatory disclosure requirement under updated nutrition labeling rules."
    - name: "pct_profiles_approved"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN nutrition_profile_id END) / NULLIF(COUNT(nutrition_profile_id), 0), 2)
      comment: "Percentage of nutrition profiles in Approved status. Tracks regulatory compliance readiness — unapproved profiles represent menu labeling compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_allergen_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allergen compliance and food safety KPIs at the allergen declaration level — covering declaration status, cross-contact risk, and regulatory submission compliance. Used by food safety, regulatory affairs, and operations teams to manage allergen risk."
  source: "`vibe_restaurants_v1`.`menu`.`allergen_declaration`"
  dimensions:
    - name: "declaration_status"
      expr: CAST(declaration_status AS STRING)
      comment: "Status of the allergen declaration (e.g. Active, Superseded, Pending). Primary filter for active allergen compliance analysis."
    - name: "declaration_type"
      expr: CAST(declaration_type AS STRING)
      comment: "Type of allergen declaration (e.g. Contains, May Contain, Free From). Enables declaration-type-level compliance analysis."
    - name: "cross_contact_risk_level"
      expr: cross_contact_risk_level
      comment: "Cross-contact risk level (e.g. High, Medium, Low). Tracks allergen cross-contamination risk concentration across the menu."
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channel the declaration applies to. Enables channel-level allergen compliance analysis."
    - name: "daypart_applicability"
      expr: daypart_applicability
      comment: "Daypart the declaration applies to. Enables daypart-level allergen compliance analysis."
    - name: "gluten_free_certified"
      expr: gluten_free_certified
      comment: "Whether the item is gluten-free certified. Tracks certified gluten-free coverage of the menu for allergen-sensitive guests."
    - name: "regulatory_submission_required"
      expr: regulatory_submission_required
      comment: "Whether regulatory submission is required for this declaration. Tracks regulatory obligation scope."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the allergen declaration became effective. Enables trend analysis of allergen declaration changes."
    - name: "regulatory_submission_date"
      expr: DATE_TRUNC('month', regulatory_submission_date)
      comment: "Month of regulatory submission. Tracks regulatory submission cadence and timeliness."
  measures:
    - name: "total_active_declarations"
      expr: COUNT(allergen_declaration_id)
      comment: "Total count of allergen declarations. Tracks allergen declaration portfolio scope — a baseline for compliance coverage analysis."
    - name: "total_high_cross_contact_risk_declarations"
      expr: COUNT(CASE WHEN cross_contact_risk_level = 'High' THEN allergen_declaration_id END)
      comment: "Count of allergen declarations with high cross-contact risk. Tracks the highest-risk allergen exposure items — directly tied to guest safety and liability."
    - name: "pct_gluten_free_certified"
      expr: ROUND(100.0 * COUNT(CASE WHEN gluten_free_certified = TRUE THEN allergen_declaration_id END) / NULLIF(COUNT(allergen_declaration_id), 0), 2)
      comment: "Percentage of allergen declarations where the item is gluten-free certified. Tracks certified gluten-free portfolio coverage for allergen-sensitive guest segments."
    - name: "pct_regulatory_submission_required"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_submission_required = TRUE THEN allergen_declaration_id END) / NULLIF(COUNT(allergen_declaration_id), 0), 2)
      comment: "Percentage of allergen declarations requiring regulatory submission. Tracks regulatory obligation scope — high percentage signals significant compliance workload and risk."
    - name: "pct_high_cross_contact_risk"
      expr: ROUND(100.0 * COUNT(CASE WHEN cross_contact_risk_level = 'High' THEN allergen_declaration_id END) / NULLIF(COUNT(allergen_declaration_id), 0), 2)
      comment: "Percentage of allergen declarations with high cross-contact risk. Tracks allergen risk concentration — a key food safety and liability KPI for restaurant operations."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_recipe_ingredient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe ingredient cost, quality, and compliance KPIs — covering ingredient cost structure, waste, yield, and certification status. Used by supply chain, culinary, and food safety teams to manage ingredient standards and cost."
  source: "`vibe_restaurants_v1`.`menu`.`recipe_ingredient`"
  dimensions:
    - name: "ingredient_status"
      expr: ingredient_status
      comment: "Current status of the recipe ingredient (e.g. Active, Substituted, Discontinued). Primary filter for active ingredient analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ingredient quantity. Enables unit-level cost and quantity analysis."
    - name: "prep_state"
      expr: prep_state
      comment: "Preparation state of the ingredient (e.g. Raw, Cooked, Frozen). Tracks ingredient prep complexity and food safety implications."
    - name: "is_critical_ingredient"
      expr: is_critical_ingredient
      comment: "Whether the ingredient is critical to the recipe. Enables focused supply chain risk analysis on critical ingredients."
    - name: "is_organic"
      expr: is_organic
      comment: "Whether the ingredient is organic. Tracks organic sourcing coverage for sustainability and premium positioning."
    - name: "is_halal_certified"
      expr: is_halal_certified
      comment: "Whether the ingredient is halal certified. Tracks halal compliance coverage for relevant markets."
    - name: "is_kosher_certified"
      expr: is_kosher_certified
      comment: "Whether the ingredient is kosher certified. Tracks kosher compliance coverage for relevant markets."
    - name: "haccp_critical_control_point"
      expr: haccp_critical_control_point
      comment: "Whether this ingredient is a HACCP Critical Control Point. Tracks food safety risk at the ingredient level."
    - name: "contains_gluten"
      expr: contains_gluten
      comment: "Whether the ingredient contains gluten. Tracks gluten exposure across recipe ingredients for allergen management."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the ingredient became effective in the recipe. Enables trend analysis of ingredient changes over time."
  measures:
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across recipe ingredients. Core ingredient cost KPI for food cost management and supplier negotiation."
    - name: "avg_extended_cost"
      expr: AVG(CAST(extended_cost AS DOUBLE))
      comment: "Average extended cost (cost per unit × quantity) per recipe ingredient line. Tracks total ingredient cost contribution per recipe line for BOM cost analysis."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost across all recipe ingredient lines. Tracks aggregate ingredient spend — a key input to food cost and procurement budget management."
    - name: "avg_waste_factor_pct"
      expr: AVG(CAST(waste_factor_pct AS DOUBLE))
      comment: "Average waste factor percentage across recipe ingredients. Tracks ingredient-level waste — a key driver of food cost variance and sustainability performance."
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_pct AS DOUBLE))
      comment: "Average yield percentage across recipe ingredients. Tracks ingredient utilization efficiency — low yield increases effective cost per usable unit."
    - name: "avg_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average ingredient quantity per recipe line. Tracks portion standardization across recipes for consistency and cost control."
    - name: "pct_critical_ingredients"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical_ingredient = TRUE THEN recipe_ingredient_id END) / NULLIF(COUNT(recipe_ingredient_id), 0), 2)
      comment: "Percentage of recipe ingredients flagged as critical. Tracks supply chain risk concentration — high critical ingredient share signals vulnerability to supply disruptions."
    - name: "pct_haccp_ccp_ingredients"
      expr: ROUND(100.0 * COUNT(CASE WHEN haccp_critical_control_point = TRUE THEN recipe_ingredient_id END) / NULLIF(COUNT(recipe_ingredient_id), 0), 2)
      comment: "Percentage of recipe ingredients that are HACCP Critical Control Points. Tracks food safety risk density in the recipe portfolio — a key food safety governance KPI."
    - name: "pct_organic_ingredients"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_organic = TRUE THEN recipe_ingredient_id END) / NULLIF(COUNT(recipe_ingredient_id), 0), 2)
      comment: "Percentage of recipe ingredients that are organic. Tracks organic sourcing progress against sustainability and premium positioning commitments."
$$;