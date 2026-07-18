-- Metric views for domain: menu | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 19:59:49

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core menu item performance metrics including pricing, cost efficiency, and availability across channels and formats"
  source: "`vibe_restaurants_v1`.`menu`.`menu_item`"
  dimensions:
    - name: "item_name"
      expr: item_name
      comment: "Name of the menu item"
    - name: "item_code"
      expr: item_code
      comment: "Unique code identifying the menu item"
    - name: "item_status"
      expr: item_status
      comment: "Current status of the menu item (active, discontinued, etc.)"
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format where item is available (QSR, casual dining, etc.)"
    - name: "daypart"
      expr: daypart
      comment: "Daypart when item is available (breakfast, lunch, dinner, etc.)"
    - name: "subcategory"
      expr: subcategory
      comment: "Menu subcategory classification"
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering classification (star, plow horse, puzzle, dog)"
    - name: "is_lto"
      expr: is_lto
      comment: "Whether item is a limited time offer"
    - name: "is_combo_eligible"
      expr: is_combo_eligible
      comment: "Whether item can be included in combo meals"
    - name: "channel_availability"
      expr: CASE WHEN is_3pd_available AND is_olo_available AND is_dine_in_available AND is_dt_available THEN 'Omnichannel' WHEN is_dine_in_available AND is_dt_available THEN 'In-Store Only' WHEN is_olo_available OR is_3pd_available THEN 'Digital Only' ELSE 'Limited' END
      comment: "Channel availability classification based on enabled ordering channels"
    - name: "dietary_classification"
      expr: CASE WHEN is_vegan THEN 'Vegan' WHEN is_vegetarian THEN 'Vegetarian' WHEN is_gluten_free THEN 'Gluten-Free' ELSE 'Standard' END
      comment: "Primary dietary classification of the item"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the menu item was launched"
    - name: "launch_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month the menu item was launched"
  measures:
    - name: "total_menu_items"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Total count of distinct menu items"
    - name: "avg_item_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across menu items"
    - name: "avg_item_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per menu item"
    - name: "avg_contribution_margin"
      expr: AVG(CAST(base_price AS DOUBLE) - CAST(cost AS DOUBLE))
      comment: "Average contribution margin per menu item (price minus cost)"
    - name: "avg_portion_size_grams"
      expr: AVG(CAST(portion_size_grams AS DOUBLE))
      comment: "Average portion size in grams across menu items"
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams per menu item"
    - name: "pct_items_customizable"
      expr: ROUND(100.0 * SUM(CASE WHEN is_customizable THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of menu items that allow customization"
    - name: "pct_items_omnichannel"
      expr: ROUND(100.0 * SUM(CASE WHEN is_3pd_available AND is_olo_available AND is_dine_in_available AND is_dt_available THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of items available across all ordering channels"
    - name: "pct_items_lto"
      expr: ROUND(100.0 * SUM(CASE WHEN is_lto THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of menu items that are limited time offers"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_pmix`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product mix performance metrics tracking sales volume, revenue, profitability, and menu engineering classification by item and channel"
  source: "`vibe_restaurants_v1`.`menu`.`pmix_record`"
  dimensions:
    - name: "reporting_date"
      expr: reporting_date
      comment: "Date of the product mix reporting period"
    - name: "reporting_year"
      expr: YEAR(reporting_date)
      comment: "Year of the product mix reporting period"
    - name: "reporting_month"
      expr: DATE_TRUNC('MONTH', reporting_date)
      comment: "Month of the product mix reporting period"
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (daily, weekly, monthly, etc.)"
    - name: "daypart"
      expr: daypart
      comment: "Daypart of sales (breakfast, lunch, dinner, etc.)"
    - name: "menu_category"
      expr: menu_category
      comment: "Menu category classification"
    - name: "menu_engineering_classification"
      expr: menu_engineering_classification
      comment: "Menu engineering classification (star, plow horse, puzzle, dog)"
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (QSR, casual dining, etc.)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (corporate, franchise, etc.)"
    - name: "is_lto"
      expr: is_lto
      comment: "Whether item is a limited time offer"
    - name: "is_available"
      expr: is_available
      comment: "Whether item was available during the period"
    - name: "record_status"
      expr: record_status
      comment: "Status of the product mix record"
  measures:
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS BIGINT))
      comment: "Total units sold across all items and periods"
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales revenue before discounts and refunds"
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales revenue after discounts and refunds"
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold"
    - name: "total_contribution_margin"
      expr: SUM(CAST(contribution_margin_amount AS DOUBLE))
      comment: "Total contribution margin (net sales minus COGS)"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to sales"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount processed"
    - name: "total_comp_amount"
      expr: SUM(CAST(comp_amount AS DOUBLE))
      comment: "Total complimentary (comped) amount"
    - name: "total_void_amount"
      expr: SUM(CAST(void_amount AS DOUBLE))
      comment: "Total voided transaction amount"
    - name: "avg_selling_price"
      expr: AVG(CAST(avg_selling_price AS DOUBLE))
      comment: "Average selling price per item"
    - name: "avg_cogs_pct"
      expr: AVG(CAST(cogs_pct AS DOUBLE))
      comment: "Average cost of goods sold as percentage of sales"
    - name: "avg_menu_mix_pct"
      expr: AVG(CAST(menu_mix_pct AS DOUBLE))
      comment: "Average menu mix percentage (item contribution to total unit sales)"
    - name: "avg_sales_mix_pct"
      expr: AVG(CAST(sales_mix_pct AS DOUBLE))
      comment: "Average sales mix percentage (item contribution to total revenue)"
    - name: "total_unavailability_hours"
      expr: SUM(CAST(unavailability_hours AS DOUBLE))
      comment: "Total hours items were unavailable for sale"
    - name: "contribution_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(contribution_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_sales_amount AS DOUBLE)), 0), 2)
      comment: "Contribution margin as percentage of net sales"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Discount rate as percentage of gross sales"
    - name: "refund_rate"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Refund rate as percentage of gross sales"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item pricing strategy metrics including price positioning, elasticity, COGS efficiency, and channel surcharges"
  source: "`vibe_restaurants_v1`.`menu`.`item_price`"
  dimensions:
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date when price becomes effective"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year when price becomes effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when price becomes effective"
    - name: "ordering_channel"
      expr: ordering_channel
      comment: "Ordering channel (dine-in, drive-thru, online, 3rd party delivery, etc.)"
    - name: "daypart"
      expr: daypart
      comment: "Daypart pricing applies to (breakfast, lunch, dinner, etc.)"
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (QSR, casual dining, etc.)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (corporate, franchise, etc.)"
    - name: "price_region_code"
      expr: price_region_code
      comment: "Geographic pricing region code"
    - name: "country_code"
      expr: country_code
      comment: "Country code for pricing"
    - name: "menu_engineering_category"
      expr: menu_engineering_category
      comment: "Menu engineering category classification"
    - name: "price_elasticity_band"
      expr: price_elasticity_band
      comment: "Price elasticity band (high, medium, low sensitivity)"
    - name: "is_lto"
      expr: is_lto
      comment: "Whether pricing is for a limited time offer"
    - name: "is_active"
      expr: is_active
      comment: "Whether price is currently active"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the price"
    - name: "price_change_reason"
      expr: price_change_reason
      comment: "Reason for price change"
  measures:
    - name: "total_price_records"
      expr: COUNT(DISTINCT item_price_id)
      comment: "Total count of distinct price records"
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across items"
    - name: "avg_promotional_price"
      expr: AVG(CAST(promotional_price AS DOUBLE))
      comment: "Average promotional price across items"
    - name: "avg_suggested_retail_price"
      expr: AVG(CAST(suggested_retail_price AS DOUBLE))
      comment: "Average suggested retail price"
    - name: "avg_channel_surcharge"
      expr: AVG(CAST(channel_surcharge AS DOUBLE))
      comment: "Average surcharge applied for specific ordering channels"
    - name: "avg_cogs"
      expr: AVG(CAST(cost_of_goods AS DOUBLE))
      comment: "Average cost of goods sold per item"
    - name: "avg_cogs_pct"
      expr: AVG(CAST(cogs_pct AS DOUBLE))
      comment: "Average COGS as percentage of price"
    - name: "avg_franchise_price_deviation_pct"
      expr: AVG(CAST(franchise_price_deviation_pct AS DOUBLE))
      comment: "Average percentage deviation of franchise pricing from corporate pricing"
    - name: "avg_price_override_limit"
      expr: AVG(CAST(price_override_limit AS DOUBLE))
      comment: "Average maximum price override limit allowed"
    - name: "promotional_discount_rate"
      expr: ROUND(100.0 * (SUM(CAST(base_price AS DOUBLE)) - SUM(CAST(promotional_price AS DOUBLE))) / NULLIF(SUM(CAST(base_price AS DOUBLE)), 0), 2)
      comment: "Average promotional discount rate as percentage of base price"
    - name: "contribution_margin_pct"
      expr: ROUND(100.0 * (SUM(CAST(base_price AS DOUBLE)) - SUM(CAST(cost_of_goods AS DOUBLE))) / NULLIF(SUM(CAST(base_price AS DOUBLE)), 0), 2)
      comment: "Contribution margin as percentage of base price"
    - name: "pct_prices_with_override_allowed"
      expr: ROUND(100.0 * SUM(CASE WHEN is_price_override_allowed THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of price records that allow override"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_item_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item cost efficiency metrics tracking theoretical vs actual COGS, variance analysis, and ingredient cost drivers"
  source: "`vibe_restaurants_v1`.`menu`.`item_cost`"
  dimensions:
    - name: "cost_calculation_date"
      expr: cost_calculation_date
      comment: "Date when cost was calculated"
    - name: "cost_year"
      expr: YEAR(cost_calculation_date)
      comment: "Year of cost calculation"
    - name: "cost_month"
      expr: DATE_TRUNC('MONTH', cost_calculation_date)
      comment: "Month of cost calculation"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for cost reporting"
    - name: "channel"
      expr: channel
      comment: "Sales channel for cost analysis"
    - name: "daypart"
      expr: daypart
      comment: "Daypart for cost analysis"
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format"
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering classification"
    - name: "cost_status"
      expr: cost_status
      comment: "Status of the cost record"
    - name: "cost_calculation_method"
      expr: cost_calculation_method
      comment: "Method used to calculate cost (standard, actual, weighted average, etc.)"
    - name: "is_lto"
      expr: is_lto
      comment: "Whether item is a limited time offer"
    - name: "price_basis"
      expr: price_basis
      comment: "Basis for pricing (cost-plus, market-based, etc.)"
  measures:
    - name: "total_cost_records"
      expr: COUNT(DISTINCT item_cost_id)
      comment: "Total count of distinct cost records"
    - name: "avg_theoretical_cost"
      expr: AVG(CAST(theoretical_cost_amount AS DOUBLE))
      comment: "Average theoretical cost per item based on recipe"
    - name: "avg_base_selling_price"
      expr: AVG(CAST(base_selling_price AS DOUBLE))
      comment: "Average base selling price"
    - name: "avg_theoretical_cogs_pct"
      expr: AVG(CAST(theoretical_cogs_pct AS DOUBLE))
      comment: "Average theoretical COGS as percentage of selling price"
    - name: "avg_actual_cogs_pct"
      expr: AVG(CAST(actual_cogs_pct AS DOUBLE))
      comment: "Average actual COGS as percentage of selling price"
    - name: "avg_target_cogs_pct"
      expr: AVG(CAST(target_cogs_pct AS DOUBLE))
      comment: "Average target COGS percentage"
    - name: "avg_cogs_variance_pct"
      expr: AVG(CAST(cogs_pct_variance AS DOUBLE))
      comment: "Average variance between actual and theoretical COGS percentage"
    - name: "avg_theoretical_cost_variance"
      expr: AVG(CAST(theoretical_cost_variance_amount AS DOUBLE))
      comment: "Average variance amount between actual and theoretical cost"
    - name: "avg_packaging_cost"
      expr: AVG(CAST(packaging_cost AS DOUBLE))
      comment: "Average packaging cost per item"
    - name: "avg_primary_protein_cost"
      expr: AVG(CAST(primary_protein_cost AS DOUBLE))
      comment: "Average cost of primary protein ingredient"
    - name: "avg_cost_per_gram"
      expr: AVG(CAST(cost_per_gram AS DOUBLE))
      comment: "Average cost per gram of product"
    - name: "avg_portion_size_grams"
      expr: AVG(CAST(portion_size_grams AS DOUBLE))
      comment: "Average portion size in grams"
    - name: "avg_waste_pct"
      expr: AVG(CAST(waste_pct AS DOUBLE))
      comment: "Average waste percentage in production"
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_pct AS DOUBLE))
      comment: "Average yield percentage from raw ingredients"
    - name: "cogs_efficiency_ratio"
      expr: ROUND(100.0 * AVG(CAST(theoretical_cogs_pct AS DOUBLE)) / NULLIF(AVG(CAST(actual_cogs_pct AS DOUBLE)), 0), 2)
      comment: "Ratio of theoretical to actual COGS percentage (higher is better efficiency)"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe efficiency and food safety metrics tracking yield, waste, cost, and HACCP compliance"
  source: "`vibe_restaurants_v1`.`menu`.`recipe`"
  dimensions:
    - name: "recipe_name"
      expr: recipe_name
      comment: "Name of the recipe"
    - name: "recipe_code"
      expr: recipe_code
      comment: "Unique code identifying the recipe"
    - name: "recipe_status"
      expr: recipe_status
      comment: "Current status of the recipe"
    - name: "recipe_type"
      expr: recipe_type
      comment: "Type of recipe (entree, side, sauce, etc.)"
    - name: "category"
      expr: recipe_category
      comment: "Recipe category classification"
    - name: "subcategory"
      expr: subcategory
      comment: "Recipe subcategory classification"
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format where recipe is used"
    - name: "channel"
      expr: channel
      comment: "Sales channel for recipe"
    - name: "daypart"
      expr: daypart
      comment: "Daypart when recipe is used"
    - name: "cook_method"
      expr: cook_method
      comment: "Primary cooking method (grill, fry, bake, etc.)"
    - name: "prep_method"
      expr: prep_method
      comment: "Preparation method"
    - name: "haccp_ccp_flag"
      expr: haccp_ccp_flag
      comment: "Whether recipe has HACCP critical control points"
    - name: "is_vegan"
      expr: is_vegan
      comment: "Whether recipe is vegan"
    - name: "is_vegetarian"
      expr: is_vegetarian
      comment: "Whether recipe is vegetarian"
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Whether recipe is gluten-free"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year recipe became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month recipe became effective"
  measures:
    - name: "total_recipes"
      expr: COUNT(DISTINCT recipe_id)
      comment: "Total count of distinct recipes"
    - name: "avg_food_cost"
      expr: AVG(CAST(food_cost AS DOUBLE))
      comment: "Average food cost per recipe"
    - name: "avg_food_cost_pct"
      expr: AVG(CAST(food_cost_pct AS DOUBLE))
      comment: "Average food cost as percentage of menu price"
    - name: "avg_menu_price"
      expr: AVG(CAST(menu_price AS DOUBLE))
      comment: "Average menu price for recipe"
    - name: "avg_yield_quantity"
      expr: AVG(CAST(yield_quantity AS DOUBLE))
      comment: "Average yield quantity per recipe batch"
    - name: "avg_serving_size_grams"
      expr: AVG(CAST(serving_size_g AS DOUBLE))
      comment: "Average serving size in grams"
    - name: "avg_waste_pct"
      expr: AVG(CAST(waste_pct AS DOUBLE))
      comment: "Average waste percentage in recipe production"
    - name: "avg_prep_time_minutes"
      expr: AVG(CAST(prep_time_seconds AS BIGINT)) / 60.0
      comment: "Average preparation time in minutes"
    - name: "avg_cook_time_minutes"
      expr: AVG(CAST(cook_time_seconds AS BIGINT)) / 60.0
      comment: "Average cooking time in minutes"
    - name: "avg_total_time_minutes"
      expr: AVG(CAST(total_time_seconds AS BIGINT)) / 60.0
      comment: "Average total production time in minutes"
    - name: "avg_cook_temperature_f"
      expr: AVG(CAST(cook_temperature_f AS DOUBLE))
      comment: "Average cooking temperature in Fahrenheit"
    - name: "avg_holding_temperature_f"
      expr: AVG(CAST(holding_temperature_f AS DOUBLE))
      comment: "Average holding temperature in Fahrenheit"
    - name: "avg_storage_temperature_f"
      expr: AVG(CAST(storage_temperature_f AS DOUBLE))
      comment: "Average storage temperature in Fahrenheit"
    - name: "avg_shelf_life_hours"
      expr: AVG(CAST(shelf_life_hours AS BIGINT))
      comment: "Average shelf life in hours"
    - name: "avg_calories"
      expr: AVG(CAST(calories AS DOUBLE))
      comment: "Average calories per serving"
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams"
    - name: "pct_recipes_haccp_critical"
      expr: ROUND(100.0 * SUM(CASE WHEN haccp_ccp_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recipes with HACCP critical control points"
    - name: "recipe_efficiency_score"
      expr: ROUND(100.0 * (1 - AVG(CAST(waste_pct AS DOUBLE)) / 100.0), 2)
      comment: "Recipe efficiency score based on waste percentage (100 minus waste pct)"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_combo_meal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Combo meal bundle performance metrics tracking discount effectiveness, pricing strategy, and profitability"
  source: "`vibe_restaurants_v1`.`menu`.`combo_meal`"
  dimensions:
    - name: "combo_name"
      expr: combo_name
      comment: "Name of the combo meal"
    - name: "combo_code"
      expr: combo_code
      comment: "Unique code identifying the combo meal"
    - name: "combo_status"
      expr: combo_status
      comment: "Current status of the combo meal"
    - name: "combo_type"
      expr: combo_type
      comment: "Type of combo meal (value meal, premium combo, etc.)"
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format where combo is offered"
    - name: "daypart"
      expr: daypart
      comment: "Daypart when combo is available"
    - name: "country_code"
      expr: country_code
      comment: "Country where combo is offered"
    - name: "region_code"
      expr: region_code
      comment: "Region where combo is offered"
    - name: "ownership_model"
      expr: ownership_model
      comment: "Ownership model (corporate, franchise, etc.)"
    - name: "menu_engineering_class"
      expr: menu_engineering_class
      comment: "Menu engineering classification"
    - name: "is_national_launch"
      expr: is_national_launch
      comment: "Whether combo is a national launch"
    - name: "is_customizable"
      expr: is_customizable
      comment: "Whether combo allows customization"
    - name: "channel_availability"
      expr: CASE WHEN is_3pd_available AND is_olo_available AND is_dine_in_available AND is_dt_available THEN 'Omnichannel' WHEN is_dine_in_available AND is_dt_available THEN 'In-Store Only' WHEN is_olo_available OR is_3pd_available THEN 'Digital Only' ELSE 'Limited' END
      comment: "Channel availability classification"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year combo was launched"
    - name: "launch_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month combo was launched"
  measures:
    - name: "total_combo_meals"
      expr: COUNT(DISTINCT combo_meal_id)
      comment: "Total count of distinct combo meals"
    - name: "avg_bundle_price"
      expr: AVG(CAST(bundle_price AS DOUBLE))
      comment: "Average bundle price of combo meals"
    - name: "avg_individual_items_price"
      expr: AVG(CAST(individual_items_price_sum AS DOUBLE))
      comment: "Average sum of individual item prices if purchased separately"
    - name: "avg_bundle_discount"
      expr: AVG(CAST(bundle_discount_amount AS DOUBLE))
      comment: "Average discount amount offered in bundle"
    - name: "avg_item_cost"
      expr: AVG(CAST(item_cost AS DOUBLE))
      comment: "Average cost of combo meal items"
    - name: "avg_food_cost_pct"
      expr: AVG(CAST(food_cost_pct AS DOUBLE))
      comment: "Average food cost as percentage of bundle price"
    - name: "avg_pmix_target_pct"
      expr: AVG(CAST(pmix_target_pct AS DOUBLE))
      comment: "Average target product mix percentage for combo meals"
    - name: "bundle_discount_rate"
      expr: ROUND(100.0 * SUM(CAST(bundle_discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(individual_items_price_sum AS DOUBLE)), 0), 2)
      comment: "Average bundle discount rate as percentage of individual items price"
    - name: "bundle_value_proposition"
      expr: ROUND(SUM(CAST(individual_items_price_sum AS DOUBLE)) / NULLIF(SUM(CAST(bundle_price AS DOUBLE)), 0), 2)
      comment: "Ratio of individual items price to bundle price (value multiplier)"
    - name: "contribution_margin_pct"
      expr: ROUND(100.0 * (SUM(CAST(bundle_price AS DOUBLE)) - SUM(CAST(item_cost AS DOUBLE))) / NULLIF(SUM(CAST(bundle_price AS DOUBLE)), 0), 2)
      comment: "Contribution margin as percentage of bundle price"
    - name: "pct_combos_omnichannel"
      expr: ROUND(100.0 * SUM(CASE WHEN is_3pd_available AND is_olo_available AND is_dine_in_available AND is_dt_available THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of combos available across all channels"
    - name: "pct_combos_customizable"
      expr: ROUND(100.0 * SUM(CASE WHEN is_customizable THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of combos that allow customization"
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`menu_nutrition_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nutritional compliance and health metrics tracking calorie content, macronutrients, and regulatory disclosure requirements"
  source: "`vibe_restaurants_v1`.`menu`.`nutrition_profile`"
  dimensions:
    - name: "profile_name"
      expr: profile_name
      comment: "Name of the nutrition profile"
    - name: "profile_type"
      expr: profile_type
      comment: "Type of nutrition profile (standard, modified, allergen-free, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the nutrition profile"
    - name: "data_source"
      expr: data_source
      comment: "Source of nutritional data (lab analysis, calculation, supplier, etc.)"
    - name: "is_current_version"
      expr: is_current_version
      comment: "Whether this is the current active version"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year profile became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month profile became effective"
    - name: "calorie_band"
      expr: CASE WHEN CAST(calories AS BIGINT) < 300 THEN 'Low (<300)' WHEN CAST(calories AS BIGINT) < 600 THEN 'Medium (300-600)' WHEN CAST(calories AS BIGINT) < 900 THEN 'High (600-900)' ELSE 'Very High (900+)' END
      comment: "Calorie band classification"
    - name: "sodium_band"
      expr: CASE WHEN sodium_mg < 500 THEN 'Low (<500mg)' WHEN sodium_mg < 1000 THEN 'Medium (500-1000mg)' WHEN sodium_mg < 1500 THEN 'High (1000-1500mg)' ELSE 'Very High (1500mg+)' END
      comment: "Sodium content band classification"
  measures:
    - name: "total_nutrition_profiles"
      expr: COUNT(DISTINCT nutrition_profile_id)
      comment: "Total count of distinct nutrition profiles"
    - name: "avg_calories"
      expr: AVG(CAST(calories AS BIGINT))
      comment: "Average calories per serving"
    - name: "avg_calories_from_fat"
      expr: AVG(CAST(calories_from_fat AS BIGINT))
      comment: "Average calories from fat per serving"
    - name: "avg_total_fat_g"
      expr: AVG(CAST(total_fat_g AS DOUBLE))
      comment: "Average total fat in grams"
    - name: "avg_saturated_fat_g"
      expr: AVG(CAST(saturated_fat_g AS DOUBLE))
      comment: "Average saturated fat in grams"
    - name: "avg_trans_fat_g"
      expr: AVG(CAST(trans_fat_g AS DOUBLE))
      comment: "Average trans fat in grams"
    - name: "avg_cholesterol_mg"
      expr: AVG(CAST(cholesterol_mg AS DOUBLE))
      comment: "Average cholesterol in milligrams"
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium in milligrams"
    - name: "avg_total_carbohydrate_g"
      expr: AVG(CAST(total_carbohydrate_g AS DOUBLE))
      comment: "Average total carbohydrates in grams"
    - name: "avg_dietary_fiber_g"
      expr: AVG(CAST(dietary_fiber_g AS DOUBLE))
      comment: "Average dietary fiber in grams"
    - name: "avg_total_sugars_g"
      expr: AVG(CAST(total_sugars_g AS DOUBLE))
      comment: "Average total sugars in grams"
    - name: "avg_added_sugars_g"
      expr: AVG(CAST(added_sugars_g AS DOUBLE))
      comment: "Average added sugars in grams"
    - name: "avg_protein_g"
      expr: AVG(CAST(protein_g AS DOUBLE))
      comment: "Average protein in grams"
    - name: "avg_serving_size_g"
      expr: AVG(CAST(serving_size_g AS DOUBLE))
      comment: "Average serving size in grams"
    - name: "pct_calories_from_fat"
      expr: ROUND(100.0 * SUM(CAST(calories_from_fat AS BIGINT)) / NULLIF(SUM(CAST(calories AS BIGINT)), 0), 2)
      comment: "Percentage of total calories from fat"
    - name: "pct_profiles_lab_verified"
      expr: ROUND(100.0 * SUM(CASE WHEN data_source = 'lab_analysis' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of profiles verified by lab analysis"
    - name: "avg_calorie_density"
      expr: AVG(CAST(calories AS BIGINT) / NULLIF(CAST(serving_size_g AS DOUBLE), 0))
      comment: "Average calorie density (calories per gram)"
$$;
