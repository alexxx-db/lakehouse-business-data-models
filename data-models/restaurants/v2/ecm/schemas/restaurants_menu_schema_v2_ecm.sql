-- Schema for Domain: menu | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:00:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`menu` COMMENT 'Single source of truth for all menu items, recipes, BOMs (Bill of Materials), nutritional data, allergen declarations, pricing, product mix (PMIX), limited time offers (LTO), and menu engineering decisions across dayparts, channels (DT, OLO, 3PD), and restaurant formats (QSR, casual, fine-dining). Governs what the business sells.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`menu_item` (
    `menu_item_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Employee who created the item',
    `foodsafety_allergen_profile_id` BIGINT COMMENT 'Allergen profile reference',
    `gl_account_id` BIGINT COMMENT 'GL account for revenue',
    `haccp_plan_id` BIGINT COMMENT 'HACCP plan reference',
    `item_category_id` BIGINT COMMENT 'Inventory category',
    `allergen_flags` STRING COMMENT 'Allergen indicator flags',
    `base_price` DECIMAL(18,2) COMMENT 'Base selling price',
    `calorie_count` STRING COMMENT 'The count or quantity of calorie items in this menu item',
    `cost` DECIMAL(18,2) COMMENT 'The cost value in the applicable currency for this menu item',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this menu item',
    `daypart` STRING COMMENT 'Daypart availability',
    `discontinue_date` DATE COMMENT 'Date item discontinued',
    `image_url` STRING COMMENT 'The URL link to the image resource associated with this menu item',
    `is_3pd_available` BOOLEAN COMMENT 'Available on 3rd party delivery',
    `is_combo_eligible` BOOLEAN COMMENT 'Eligible for combo meals',
    `is_customizable` BOOLEAN COMMENT 'Can be customized',
    `is_dine_in_available` BOOLEAN COMMENT 'Available for dine-in',
    `is_dt_available` BOOLEAN COMMENT 'Available at drive-thru',
    `is_gluten_free` BOOLEAN COMMENT 'Gluten free flag',
    `is_lto` BOOLEAN COMMENT 'Limited time offer flag',
    `is_olo_available` BOOLEAN COMMENT 'Available for online ordering',
    `is_taxable` BOOLEAN COMMENT 'Subject to tax',
    `is_vegan` BOOLEAN COMMENT 'Vegan flag',
    `is_vegetarian` BOOLEAN COMMENT 'Vegetarian flag',
    `item_code` STRING COMMENT 'A standardized code representing the item classification for this menu item',
    `item_description` STRING COMMENT 'The item description attribute value for this menu item record in the menu domain',
    `item_name` STRING COMMENT 'The display name or label for the item in this menu item',
    `item_status` STRING COMMENT 'The current status of the item for this menu item',
    `launch_date` DATE COMMENT 'The date and time when the launch event occurred for this menu item',
    `lto_end_date` DATE COMMENT 'The date and time when the lto end event occurred for this menu item',
    `lto_start_date` DATE COMMENT 'The date and time when the lto start event occurred for this menu item',
    `menu_engineering_class` STRING COMMENT 'Menu engineering classification',
    `portion_size_grams` DECIMAL(18,2) COMMENT 'Portion size in grams',
    `prep_time_seconds` STRING COMMENT 'Preparation time',
    `restaurant_format` STRING COMMENT 'The restaurant format attribute value for this menu item record in the menu domain',
    `serving_temperature` STRING COMMENT 'The serving temperature attribute value for this menu item record in the menu domain',
    `sku_code` STRING COMMENT 'A standardized code representing the sku classification for this menu item',
    `sodium_mg` DECIMAL(18,2) COMMENT 'Sodium in mg',
    `sort_order` STRING COMMENT 'Display sort order',
    `source_system_code` STRING COMMENT 'A standardized code representing the source system classification for this menu item',
    `subcategory` STRING COMMENT 'Item subcategory',
    `tax_category_code` STRING COMMENT 'Tax category',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    CONSTRAINT pk_menu_item PRIMARY KEY(`menu_item_id`)
) COMMENT 'Individual food or beverage items available for sale on menus';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`menu` (
    `menu_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Creator employee',
    `franchisee_id` BIGINT COMMENT 'Franchisee reference',
    `haccp_plan_id` BIGINT COMMENT 'HACCP plan',
    `site_id` BIGINT COMMENT 'Site reference',
    `territory_id` BIGINT COMMENT 'Unique identifier for the territory associated with this menu',
    `unit_id` BIGINT COMMENT 'Restaurant unit',
    `allergen_disclosure_required` BOOLEAN COMMENT 'The allergen disclosure required attribute value for this menu record in the menu domain',
    `approval_status` STRING COMMENT 'The current status of the approval for this menu',
    `approved_by` STRING COMMENT 'Approver name',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp',
    `category_count` STRING COMMENT 'Number of categories',
    `channel` STRING COMMENT 'Sales channel',
    `menu_code` STRING COMMENT 'A standardized code representing the menu classification for this menu',
    `country_code` STRING COMMENT 'A standardized code representing the country classification for this menu',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this menu',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this menu',
    `daypart_end_time` TIMESTAMP COMMENT 'Daypart end',
    `daypart_start_time` TIMESTAMP COMMENT 'Daypart start',
    `menu_description` STRING COMMENT 'The menu description attribute value for this menu record in the menu domain',
    `digital_menu_board_enabled` BOOLEAN COMMENT 'The digital menu board enabled attribute value for this menu record in the menu domain',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this menu',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this menu',
    `engineering_tier` STRING COMMENT 'The engineering tier attribute value for this menu record in the menu domain',
    `haccp_reviewed` BOOLEAN COMMENT 'HACCP reviewed flag',
    `is_default` BOOLEAN COMMENT 'Default menu flag',
    `is_franchise_menu` BOOLEAN COMMENT 'Franchise menu flag',
    `is_lto` BOOLEAN COMMENT 'LTO menu flag',
    `item_count` STRING COMMENT 'Number of items',
    `kds_routing_profile` STRING COMMENT 'The kds routing profile attribute value for this menu record in the menu domain',
    `language_code` STRING COMMENT 'A standardized code representing the language classification for this menu',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified',
    `market_region` STRING COMMENT 'The market region attribute value for this menu record in the menu domain',
    `menu_name` STRING COMMENT 'The display name or label for the menu in this menu',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this menu',
    `nutritional_disclosure_required` BOOLEAN COMMENT 'The nutritional disclosure required attribute value for this menu record in the menu domain',
    `olo_menu_code` STRING COMMENT 'A standardized code representing the olo menu classification for this menu',
    `pmix_tracking_enabled` BOOLEAN COMMENT 'The pmix tracking enabled attribute value for this menu record in the menu domain',
    `pos_menu_code` STRING COMMENT 'A standardized code representing the pos menu classification for this menu',
    `price_tier` DECIMAL(18,2) COMMENT 'The price tier attribute value for this menu record in the menu domain',
    `publish_status` STRING COMMENT 'The current status of the publish for this menu',
    `published_timestamp` TIMESTAMP COMMENT 'The published timestamp attribute value for this menu record in the menu domain',
    `restaurant_format` STRING COMMENT 'The restaurant format attribute value for this menu record in the menu domain',
    `retired_timestamp` TIMESTAMP COMMENT 'The retired timestamp attribute value for this menu record in the menu domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this menu record in the menu domain',
    `version_number` STRING COMMENT 'The version number attribute value for this menu record in the menu domain',
    CONSTRAINT pk_menu PRIMARY KEY(`menu_id`)
) COMMENT 'Menu definitions containing collections of menu items';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`recipe` (
    `recipe_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the created by employee associated with this recipe record',
    `foodsafety_allergen_profile_id` BIGINT COMMENT 'Allergen profile',
    `haccp_plan_id` BIGINT COMMENT 'HACCP plan',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this recipe',
    `allergen_flags` STRING COMMENT 'The allergen flags attribute value for this recipe record in the menu domain',
    `approved_by` STRING COMMENT 'The approved by attribute value for this recipe record in the menu domain',
    `approved_date` DATE COMMENT 'Approval date',
    `boh_prep_notes` STRING COMMENT 'The boh prep notes attribute value for this recipe record in the menu domain',
    `calories` DECIMAL(18,2) COMMENT 'The calories attribute value for this recipe record in the menu domain',
    `calories_from_fat` DECIMAL(18,2) COMMENT 'The calories from fat attribute value for this recipe record in the menu domain',
    `recipe_category` STRING COMMENT 'The recipe category attribute value for this recipe record in the menu domain',
    `channel` STRING COMMENT 'The channel attribute value for this recipe record in the menu domain',
    `recipe_code` STRING COMMENT 'A standardized code representing the recipe classification for this recipe',
    `cook_method` STRING COMMENT 'The cook method attribute value for this recipe record in the menu domain',
    `cook_temperature_f` DECIMAL(18,2) COMMENT 'Cook temperature',
    `cook_time_seconds` STRING COMMENT 'The cook time seconds attribute value for this recipe record in the menu domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this recipe record in the menu domain',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this recipe',
    `effective_date` DATE COMMENT 'The date and time when the effective event occurred for this recipe',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this recipe',
    `food_cost` DECIMAL(18,2) COMMENT 'The food cost attribute value for this recipe record in the menu domain',
    `food_cost_pct` DECIMAL(18,2) COMMENT 'Food cost percent',
    `haccp_ccp_flag` BOOLEAN COMMENT 'Boolean indicator flag for haccp ccp flag status in this recipe',
    `holding_temperature_f` DECIMAL(18,2) COMMENT 'Holding temperature',
    `holding_time_max_minutes` STRING COMMENT 'Max holding time',
    `is_gluten_free` BOOLEAN COMMENT 'Gluten free',
    `is_vegan` BOOLEAN COMMENT 'Boolean indicator flag for is vegan status in this recipe',
    `is_vegetarian` BOOLEAN COMMENT 'Vegetarian',
    `menu_price` DECIMAL(18,2) COMMENT 'The menu price attribute value for this recipe record in the menu domain',
    `recipe_name` STRING COMMENT 'The display name or label for the recipe in this recipe',
    `plating_instructions` STRING COMMENT 'The plating instructions attribute value for this recipe record in the menu domain',
    `prep_method` STRING COMMENT 'The prep method attribute value for this recipe record in the menu domain',
    `prep_time_seconds` STRING COMMENT 'The prep time seconds attribute value for this recipe record in the menu domain',
    `recipe_status` STRING COMMENT 'The current status of the recipe for this recipe',
    `recipe_type` STRING COMMENT 'The classification type for recipe in this recipe',
    `restaurant_format` STRING COMMENT 'The restaurant format attribute value for this recipe record in the menu domain',
    `serving_size_g` DECIMAL(18,2) COMMENT 'Serving size grams',
    `shelf_life_hours` STRING COMMENT 'The shelf life hours attribute value for this recipe record in the menu domain',
    `sodium_mg` DECIMAL(18,2) COMMENT 'The sodium mg attribute value for this recipe record in the menu domain',
    `storage_temperature_f` DECIMAL(18,2) COMMENT 'Storage temperature',
    `subcategory` STRING COMMENT 'The subcategory attribute value for this recipe record in the menu domain',
    `total_time_seconds` DECIMAL(18,2) COMMENT 'Total time',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this recipe record in the menu domain',
    `version` STRING COMMENT 'The version attribute value for this recipe record in the menu domain',
    `waste_pct` DECIMAL(18,2) COMMENT 'Waste percent',
    `yield_quantity` DECIMAL(18,2) COMMENT 'The count or quantity of yield items in this recipe',
    `yield_unit` DECIMAL(18,2) COMMENT 'The yield unit attribute value for this recipe record in the menu domain',
    CONSTRAINT pk_recipe PRIMARY KEY(`recipe_id`)
) COMMENT 'Recipe definitions for menu items including preparation instructions';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` (
    `recipe_ingredient_id` BIGINT COMMENT 'Primary key',
    `ingredient_id` BIGINT COMMENT 'Ingredient reference',
    `primary_recipe_substitute_ingredient_id` BIGINT COMMENT 'Substitute ingredient',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the procurement supplier associated with this recipe ingredient',
    `recipe_id` BIGINT COMMENT 'Recipe reference',
    `allergen_flags` STRING COMMENT 'The allergen flags attribute value for this recipe ingredient record in the menu domain',
    `approved_by` STRING COMMENT 'The approved by attribute value for this recipe ingredient record in the menu domain',
    `approved_date` DATE COMMENT 'Approval date',
    `bom_version` STRING COMMENT 'The bom version attribute value for this recipe ingredient record in the menu domain',
    `contains_dairy` BOOLEAN COMMENT 'The contains dairy attribute value for this recipe ingredient record in the menu domain',
    `contains_gluten` BOOLEAN COMMENT 'The contains gluten attribute value for this recipe ingredient record in the menu domain',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'The cost per unit attribute value for this recipe ingredient record in the menu domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this recipe ingredient record in the menu domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this recipe ingredient',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this recipe ingredient',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this recipe ingredient',
    `extended_cost` DECIMAL(18,2) COMMENT 'The extended cost attribute value for this recipe ingredient record in the menu domain',
    `haccp_critical_control_point` BOOLEAN COMMENT 'The haccp critical control point attribute value for this recipe ingredient record in the menu domain',
    `ingredient_status` STRING COMMENT 'The current status of the ingredient for this recipe ingredient',
    `is_critical_ingredient` BOOLEAN COMMENT 'Critical ingredient',
    `is_halal_certified` BOOLEAN COMMENT 'Halal certified',
    `is_kosher_certified` BOOLEAN COMMENT 'Kosher certified',
    `is_organic` BOOLEAN COMMENT 'Boolean indicator flag for is organic status in this recipe ingredient',
    `is_substitution_allowed` BOOLEAN COMMENT 'Substitution allowed',
    `line_sequence` STRING COMMENT 'The line sequence attribute value for this recipe ingredient record in the menu domain',
    `min_internal_temp_f` DECIMAL(18,2) COMMENT 'Min internal temp',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this recipe ingredient',
    `par_level_quantity` DECIMAL(18,2) COMMENT 'The count or quantity of par level items in this recipe ingredient',
    `prep_state` STRING COMMENT 'The prep state attribute value for this recipe ingredient record in the menu domain',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity attribute value for this recipe ingredient record in the menu domain',
    `shelf_life_days` STRING COMMENT 'The shelf life days attribute value for this recipe ingredient record in the menu domain',
    `storage_temperature_max_f` DECIMAL(18,2) COMMENT 'Max storage temp',
    `storage_temperature_min_f` DECIMAL(18,2) COMMENT 'Min storage temp',
    `supplier_item_code` STRING COMMENT 'A standardized code representing the supplier item classification for this recipe ingredient',
    `unit_of_measure` STRING COMMENT 'The unit of measure attribute value for this recipe ingredient record in the menu domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this recipe ingredient record in the menu domain',
    `waste_factor_pct` DECIMAL(18,2) COMMENT 'Waste factor percent',
    `yield_pct` DECIMAL(18,2) COMMENT 'Yield percent',
    CONSTRAINT pk_recipe_ingredient PRIMARY KEY(`recipe_ingredient_id`)
) COMMENT 'Ingredients used in recipes with quantities and specifications';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`item_price` (
    `item_price_id` BIGINT COMMENT 'Primary key',
    `franchisee_id` BIGINT COMMENT 'Franchisee',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the item approved by employee associated with this item price record',
    `item_employee_id` BIGINT COMMENT 'Unique identifier referencing the item employee associated with this item price record',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this item price',
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this item price',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit associated with this item price',
    `approval_status` STRING COMMENT 'The current status of the approval for this item price',
    `approved_timestamp` TIMESTAMP COMMENT 'The approved timestamp attribute value for this item price record in the menu domain',
    `base_price` DECIMAL(18,2) COMMENT 'The base price attribute value for this item price record in the menu domain',
    `channel` STRING COMMENT 'The channel attribute value for this item price record in the menu domain',
    `channel_surcharge` DECIMAL(18,2) COMMENT 'The channel surcharge attribute value for this item price record in the menu domain',
    `cogs_pct` DECIMAL(18,2) COMMENT 'COGS percent',
    `cost_of_goods` DECIMAL(18,2) COMMENT 'The cost of goods attribute value for this item price record in the menu domain',
    `country_code` STRING COMMENT 'A standardized code representing the country classification for this item price',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this item price record in the menu domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this item price',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this item price',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this item price',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this item price',
    `franchise_price_deviation_pct` DECIMAL(18,2) COMMENT 'Franchise price deviation',
    `is_active` BOOLEAN COMMENT 'Active flag',
    `is_lto` BOOLEAN COMMENT 'Boolean indicator flag for is lto status in this item price',
    `is_price_override_allowed` BOOLEAN COMMENT 'Price override allowed',
    `lto_campaign_code` STRING COMMENT 'A standardized code representing the lto campaign classification for this item price',
    `max_order_quantity` STRING COMMENT 'The count or quantity of max order items in this item price',
    `menu_engineering_category` STRING COMMENT 'The menu engineering category attribute value for this item price record in the menu domain',
    `min_order_quantity` STRING COMMENT 'The count or quantity of min order items in this item price',
    `ordering_channel` STRING COMMENT 'The ordering channel attribute value for this item price record in the menu domain',
    `ownership_type` STRING COMMENT 'The classification type for ownership in this item price',
    `pos_price_level` DECIMAL(18,2) COMMENT 'The pos price level attribute value for this item price record in the menu domain',
    `price_change_reason` STRING COMMENT 'The price change reason attribute value for this item price record in the menu domain',
    `price_change_reason_notes` STRING COMMENT 'Price change notes',
    `price_display_label` STRING COMMENT 'The price display label attribute value for this item price record in the menu domain',
    `price_elasticity_band` STRING COMMENT 'The price elasticity band attribute value for this item price record in the menu domain',
    `price_override_limit` DECIMAL(18,2) COMMENT 'The price override limit attribute value for this item price record in the menu domain',
    `price_record_code` STRING COMMENT 'A standardized code representing the price record classification for this item price',
    `price_region_code` STRING COMMENT 'A standardized code representing the price region classification for this item price',
    `price_source_system` STRING COMMENT 'The price source system attribute value for this item price record in the menu domain',
    `price_version` STRING COMMENT 'The price version attribute value for this item price record in the menu domain',
    `promotional_price` DECIMAL(18,2) COMMENT 'The promotional price attribute value for this item price record in the menu domain',
    `restaurant_format` STRING COMMENT 'The restaurant format attribute value for this item price record in the menu domain',
    `source_system_price_code` STRING COMMENT 'A standardized code representing the source system price classification for this item price',
    `suggested_retail_price` DECIMAL(18,2) COMMENT 'The suggested retail price attribute value for this item price record in the menu domain',
    `tax_category_code` STRING COMMENT 'A standardized code representing the tax category classification for this item price',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this item price record in the menu domain',
    CONSTRAINT pk_item_price PRIMARY KEY(`item_price_id`)
) COMMENT 'Pricing information for menu items across locations and channels';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` (
    `nutrition_profile_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the created by employee associated with this nutrition profile record',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this nutrition profile',
    `recipe_id` BIGINT COMMENT 'Unique identifier for the recipe associated with this nutrition profile',
    `added_sugars_g` DECIMAL(18,2) COMMENT 'Added sugars grams',
    `approval_status` STRING COMMENT 'The current status of the approval for this nutrition profile',
    `approved_by` STRING COMMENT 'The approved by attribute value for this nutrition profile record in the menu domain',
    `approved_date` DATE COMMENT 'Approval date',
    `calcium_mg` DECIMAL(18,2) COMMENT 'The calcium mg attribute value for this nutrition profile record in the menu domain',
    `calorie_range_high` STRING COMMENT 'The calorie range high attribute value for this nutrition profile record in the menu domain',
    `calorie_range_low` STRING COMMENT 'The calorie range low attribute value for this nutrition profile record in the menu domain',
    `calories` STRING COMMENT 'The calories attribute value for this nutrition profile record in the menu domain',
    `calories_from_fat` STRING COMMENT 'The calories from fat attribute value for this nutrition profile record in the menu domain',
    `cholesterol_mg` DECIMAL(18,2) COMMENT 'The cholesterol mg attribute value for this nutrition profile record in the menu domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this nutrition profile record in the menu domain',
    `daily_value_basis_calories` DECIMAL(18,2) COMMENT 'Daily value basis',
    `data_source` STRING COMMENT 'The data source attribute value for this nutrition profile record in the menu domain',
    `dietary_fiber_g` DECIMAL(18,2) COMMENT 'Dietary fiber grams',
    `effective_date` DATE COMMENT 'The date and time when the effective event occurred for this nutrition profile',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this nutrition profile',
    `insoluble_fiber_g` DECIMAL(18,2) COMMENT 'Insoluble fiber grams',
    `iron_mg` DECIMAL(18,2) COMMENT 'The iron mg attribute value for this nutrition profile record in the menu domain',
    `is_current_version` BOOLEAN COMMENT 'Current version flag',
    `lab_accreditation_number` STRING COMMENT 'The lab accreditation number attribute value for this nutrition profile record in the menu domain',
    `lab_analysis_date` DATE COMMENT 'The date and time when the lab analysis event occurred for this nutrition profile',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified',
    `menu_board_calorie_display` STRING COMMENT 'The menu board calorie display attribute value for this nutrition profile record in the menu domain',
    `monounsaturated_fat_g` DECIMAL(18,2) COMMENT 'Monounsaturated fat grams',
    `polyunsaturated_fat_g` DECIMAL(18,2) COMMENT 'Polyunsaturated fat grams',
    `potassium_mg` DECIMAL(18,2) COMMENT 'The potassium mg attribute value for this nutrition profile record in the menu domain',
    `profile_code` STRING COMMENT 'A standardized code representing the profile classification for this nutrition profile',
    `profile_name` STRING COMMENT 'The display name or label for the profile in this nutrition profile',
    `profile_type` STRING COMMENT 'The classification type for profile in this nutrition profile',
    `protein_g` DECIMAL(18,2) COMMENT 'Protein grams',
    `saturated_fat_g` DECIMAL(18,2) COMMENT 'Saturated fat grams',
    `serving_size_description` STRING COMMENT 'The serving size description attribute value for this nutrition profile record in the menu domain',
    `serving_size_g` DECIMAL(18,2) COMMENT 'Serving size grams',
    `sodium_mg` DECIMAL(18,2) COMMENT 'The sodium mg attribute value for this nutrition profile record in the menu domain',
    `soluble_fiber_g` DECIMAL(18,2) COMMENT 'Soluble fiber grams',
    `total_carbohydrate_g` DECIMAL(18,2) COMMENT 'Total carbohydrate grams',
    `total_fat_g` DECIMAL(18,2) COMMENT 'Total fat grams',
    `total_sugars_g` DECIMAL(18,2) COMMENT 'Total sugars grams',
    `trans_fat_g` DECIMAL(18,2) COMMENT 'Trans fat grams',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this nutrition profile record in the menu domain',
    `version_number` STRING COMMENT 'The version number attribute value for this nutrition profile record in the menu domain',
    `vitamin_d_mcg` DECIMAL(18,2) COMMENT 'The vitamin d mcg attribute value for this nutrition profile record in the menu domain',
    CONSTRAINT pk_nutrition_profile PRIMARY KEY(`nutrition_profile_id`)
) COMMENT 'Nutritional information for menu items and recipes';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` (
    `allergen_declaration_id` DECIMAL(18,2) COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the created by employee associated with this allergen declaration record',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this allergen declaration',
    `superseded_by_allergen_declaration_id` DECIMAL(18,2) COMMENT 'Superseding declaration',
    `approved_by` STRING COMMENT 'The approved by attribute value for this allergen declaration record in the menu domain',
    `channel_applicability` STRING COMMENT 'The channel applicability attribute value for this allergen declaration record in the menu domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this allergen declaration record in the menu domain',
    `cross_contact_risk_level` STRING COMMENT 'The cross contact risk level attribute value for this allergen declaration record in the menu domain',
    `cross_contact_source` STRING COMMENT 'The cross contact source attribute value for this allergen declaration record in the menu domain',
    `daypart_applicability` STRING COMMENT 'The daypart applicability attribute value for this allergen declaration record in the menu domain',
    `declaration_date` DECIMAL(18,2) COMMENT 'The date and time when the declaration event occurred for this allergen declaration',
    `declaration_number` DECIMAL(18,2) COMMENT 'The declaration number attribute value for this allergen declaration record in the menu domain',
    `declaration_status` DECIMAL(18,2) COMMENT 'The current status of the declaration for this allergen declaration',
    `declaration_type` DECIMAL(18,2) COMMENT 'The classification type for declaration in this allergen declaration',
    `effective_date` DATE COMMENT 'The date and time when the effective event occurred for this allergen declaration',
    `eggs_status` STRING COMMENT 'The current status of the eggs for this allergen declaration',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this allergen declaration',
    `fish_species` STRING COMMENT 'The fish species attribute value for this allergen declaration record in the menu domain',
    `fish_status` STRING COMMENT 'The current status of the fish for this allergen declaration',
    `gluten_free_certified` BOOLEAN COMMENT 'The gluten free certified attribute value for this allergen declaration record in the menu domain',
    `guest_advisory_text` STRING COMMENT 'The guest advisory text attribute value for this allergen declaration record in the menu domain',
    `haccp_ccp_reference` STRING COMMENT 'The haccp ccp reference attribute value for this allergen declaration record in the menu domain',
    `internal_notes` STRING COMMENT 'The internal notes attribute value for this allergen declaration record in the menu domain',
    `may_contain_allergen_count` STRING COMMENT 'The count or quantity of may contain allergen items in this allergen declaration',
    `milk_status` STRING COMMENT 'The current status of the milk for this allergen declaration',
    `peanuts_status` STRING COMMENT 'The current status of the peanuts for this allergen declaration',
    `recipe_version` STRING COMMENT 'The recipe version attribute value for this allergen declaration record in the menu domain',
    `regulatory_submission_date` DATE COMMENT 'The date and time when the regulatory submission event occurred for this allergen declaration',
    `regulatory_submission_required` BOOLEAN COMMENT 'The regulatory submission required attribute value for this allergen declaration record in the menu domain',
    `restaurant_format_applicability` STRING COMMENT 'The restaurant format applicability attribute value for this allergen declaration record in the menu domain',
    `review_date` DATE COMMENT 'The date and time when the review event occurred for this allergen declaration',
    `reviewed_by` STRING COMMENT 'The reviewed by attribute value for this allergen declaration record in the menu domain',
    `sesame_status` STRING COMMENT 'The current status of the sesame for this allergen declaration',
    `shellfish_species` STRING COMMENT 'The shellfish species attribute value for this allergen declaration record in the menu domain',
    `shellfish_status` STRING COMMENT 'The current status of the shellfish for this allergen declaration',
    `soybeans_status` STRING COMMENT 'The current status of the soybeans for this allergen declaration',
    `total_allergen_count` STRING COMMENT 'The count or quantity of total allergen items in this allergen declaration',
    `tree_nut_varieties` STRING COMMENT 'The tree nut varieties attribute value for this allergen declaration record in the menu domain',
    `tree_nuts_status` STRING COMMENT 'The current status of the tree nuts for this allergen declaration',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this allergen declaration record in the menu domain',
    `wheat_status` STRING COMMENT 'The current status of the wheat for this allergen declaration',
    `zenput_audit_task_code` STRING COMMENT 'A standardized code representing the zenput audit task classification for this allergen declaration',
    CONSTRAINT pk_allergen_declaration PRIMARY KEY(`allergen_declaration_id`)
) COMMENT 'Allergen declarations for menu items';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`menu_lto` (
    `menu_lto_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'Unique identifier for the campaign associated with this menu lto',
    `franchisee_id` BIGINT COMMENT 'Franchisee',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this menu lto',
    `previous_lto_menu_lto_id` BIGINT COMMENT 'Previous LTO',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit associated with this menu lto',
    `actual_end_date` DATE COMMENT 'The date and time when the actual end event occurred for this menu lto',
    `actual_launch_date` DATE COMMENT 'The date and time when the actual launch event occurred for this menu lto',
    `allergen_reviewed` BOOLEAN COMMENT 'The allergen reviewed attribute value for this menu lto record in the menu domain',
    `approval_date` DATE COMMENT 'The date and time when the approval event occurred for this menu lto',
    `approval_status` STRING COMMENT 'The current status of the approval for this menu lto',
    `approved_by` STRING COMMENT 'The approved by attribute value for this menu lto record in the menu domain',
    `concept_description` STRING COMMENT 'The concept description attribute value for this menu lto record in the menu domain',
    `country_code` STRING COMMENT 'A standardized code representing the country classification for this menu lto',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this menu lto record in the menu domain',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this menu lto',
    `estimated_weekly_units` STRING COMMENT 'The estimated weekly units attribute value for this menu lto record in the menu domain',
    `food_safety_approved` BOOLEAN COMMENT 'The food safety approved attribute value for this menu lto record in the menu domain',
    `is_national_launch` BOOLEAN COMMENT 'National launch',
    `is_returning_item` BOOLEAN COMMENT 'Returning item',
    `is_test_market` BOOLEAN COMMENT 'Test market',
    `launch_lead_time_days` STRING COMMENT 'The launch lead time days attribute value for this menu lto record in the menu domain',
    `lifecycle_status` STRING COMMENT 'The current status of the lifecycle for this menu lto',
    `lto_code` STRING COMMENT 'A standardized code representing the lto classification for this menu lto',
    `lto_type` STRING COMMENT 'The classification type for lto in this menu lto',
    `marketing_headline` STRING COMMENT 'The marketing headline attribute value for this menu lto record in the menu domain',
    `menu_lto_name` STRING COMMENT 'The display name or label for the menu lto in this menu lto',
    `nutritional_approved` BOOLEAN COMMENT 'The nutritional approved attribute value for this menu lto record in the menu domain',
    `olo_item_code` STRING COMMENT 'A standardized code representing the olo item classification for this menu lto',
    `ownership_model` STRING COMMENT 'The ownership model attribute value for this menu lto record in the menu domain',
    `planned_duration_days` DECIMAL(18,2) COMMENT 'The planned duration days attribute value for this menu lto record in the menu domain',
    `planned_end_date` DATE COMMENT 'The date and time when the planned end event occurred for this menu lto',
    `planned_launch_date` DATE COMMENT 'The date and time when the planned launch event occurred for this menu lto',
    `pmix_target_pct` DECIMAL(18,2) COMMENT 'PMIX target percent',
    `pos_item_code` STRING COMMENT 'A standardized code representing the pos item classification for this menu lto',
    `region_code` STRING COMMENT 'A standardized code representing the region classification for this menu lto',
    `restaurant_format` STRING COMMENT 'The restaurant format attribute value for this menu lto record in the menu domain',
    `rollout_scope` STRING COMMENT 'The rollout scope attribute value for this menu lto record in the menu domain',
    `season_or_occasion` STRING COMMENT 'The season or occasion attribute value for this menu lto record in the menu domain',
    `suggested_retail_price` DECIMAL(18,2) COMMENT 'The suggested retail price attribute value for this menu lto record in the menu domain',
    `target_channel` STRING COMMENT 'The target channel attribute value for this menu lto record in the menu domain',
    `target_food_cost_pct` DECIMAL(18,2) COMMENT 'Target food cost percent',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this menu lto record in the menu domain',
    CONSTRAINT pk_menu_lto PRIMARY KEY(`menu_lto_id`)
) COMMENT 'Limited time offer menu items and promotions';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` (
    `modifier_group_id` BIGINT COMMENT 'Primary key',
    `allergen_relevance_flag` BOOLEAN COMMENT 'Allergen relevance',
    `approved_by` STRING COMMENT 'The approved by attribute value for this modifier group record in the menu domain',
    `approved_date` DATE COMMENT 'Approval date',
    `calorie_impact_flag` BOOLEAN COMMENT 'Calorie impact',
    `channel_applicability` STRING COMMENT 'The channel applicability attribute value for this modifier group record in the menu domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this modifier group record in the menu domain',
    `daypart_applicability` STRING COMMENT 'The daypart applicability attribute value for this modifier group record in the menu domain',
    `default_modifier_code` STRING COMMENT 'A standardized code representing the default modifier classification for this modifier group',
    `modifier_group_description` STRING COMMENT 'The modifier group description attribute value for this modifier group record in the menu domain',
    `display_name` STRING COMMENT 'The display name or label for the display in this modifier group',
    `display_sequence` STRING COMMENT 'The display sequence attribute value for this modifier group record in the menu domain',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this modifier group',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this modifier group',
    `free_modifier_limit` STRING COMMENT 'The free modifier limit attribute value for this modifier group record in the menu domain',
    `group_code` STRING COMMENT 'A standardized code representing the group classification for this modifier group',
    `group_name` STRING COMMENT 'The display name or label for the group in this modifier group',
    `group_type` STRING COMMENT 'The classification type for group in this modifier group',
    `image_url` STRING COMMENT 'The URL link to the image resource associated with this modifier group',
    `is_collapsible` BOOLEAN COMMENT 'Collapsible',
    `is_franchise_configurable` BOOLEAN COMMENT 'Franchise configurable',
    `is_kds_displayed` BOOLEAN COMMENT 'KDS displayed',
    `is_lto` BOOLEAN COMMENT 'Boolean indicator flag for is lto status in this modifier group',
    `is_printed_on_receipt` BOOLEAN COMMENT 'Printed on receipt',
    `is_required` BOOLEAN COMMENT 'Boolean indicator flag for is required status in this modifier group',
    `localization_key` STRING COMMENT 'The localization key attribute value for this modifier group record in the menu domain',
    `lto_end_date` DATE COMMENT 'The date and time when the lto end event occurred for this modifier group',
    `lto_start_date` DATE COMMENT 'The date and time when the lto start event occurred for this modifier group',
    `max_selections` STRING COMMENT 'The max selections attribute value for this modifier group record in the menu domain',
    `min_selections` STRING COMMENT 'The min selections attribute value for this modifier group record in the menu domain',
    `modifier_group_status` STRING COMMENT 'The current status of the modifier group for this modifier group',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this modifier group',
    `olo_group_ref` STRING COMMENT 'The olo group ref attribute value for this modifier group record in the menu domain',
    `pmix_tracking_enabled` BOOLEAN COMMENT 'The pmix tracking enabled attribute value for this modifier group record in the menu domain',
    `pos_group_ref` STRING COMMENT 'The pos group ref attribute value for this modifier group record in the menu domain',
    `restaurant_format_applicability` STRING COMMENT 'The restaurant format applicability attribute value for this modifier group record in the menu domain',
    `selection_type` STRING COMMENT 'The classification type for selection in this modifier group',
    `sort_order_method` STRING COMMENT 'The sort order method attribute value for this modifier group record in the menu domain',
    `upcharge_basis` DECIMAL(18,2) COMMENT 'The upcharge basis attribute value for this modifier group record in the menu domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this modifier group record in the menu domain',
    `version_number` STRING COMMENT 'The version number attribute value for this modifier group record in the menu domain',
    CONSTRAINT pk_modifier_group PRIMARY KEY(`modifier_group_id`)
) COMMENT 'Groups of modifiers that can be applied to menu items';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` (
    `menu_modifier_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the created by employee associated with this menu modifier record',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this menu modifier',
    `modifier_group_id` BIGINT COMMENT 'Modifier group',
    `allergen_flags` STRING COMMENT 'The allergen flags attribute value for this menu modifier record in the menu domain',
    `approved_by` STRING COMMENT 'The approved by attribute value for this menu modifier record in the menu domain',
    `approved_date` DATE COMMENT 'Approval date',
    `available_channels` STRING COMMENT 'The available channels attribute value for this menu modifier record in the menu domain',
    `available_dayparts` STRING COMMENT 'The available dayparts attribute value for this menu modifier record in the menu domain',
    `calorie_delta` STRING COMMENT 'The calorie delta attribute value for this menu modifier record in the menu domain',
    `carbohydrate_delta_g` DECIMAL(18,2) COMMENT 'Carbohydrate delta grams',
    `cogs_delta` DECIMAL(18,2) COMMENT 'The cogs delta attribute value for this menu modifier record in the menu domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this menu modifier record in the menu domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this menu modifier',
    `menu_modifier_description` STRING COMMENT 'The menu modifier description attribute value for this menu modifier record in the menu domain',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this menu modifier',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this menu modifier',
    `fat_delta_g` DECIMAL(18,2) COMMENT 'Fat delta grams',
    `image_url` STRING COMMENT 'The URL link to the image resource associated with this menu modifier',
    `is_allergen_free` BOOLEAN COMMENT 'Allergen free',
    `is_available` BOOLEAN COMMENT 'Boolean indicator flag for is available status in this menu modifier',
    `is_default` BOOLEAN COMMENT 'Boolean indicator flag for is default status in this menu modifier',
    `is_lto` BOOLEAN COMMENT 'Boolean indicator flag for is lto status in this menu modifier',
    `is_required` BOOLEAN COMMENT 'Boolean indicator flag for is required status in this menu modifier',
    `lto_end_date` DATE COMMENT 'The date and time when the lto end event occurred for this menu modifier',
    `lto_start_date` DATE COMMENT 'The date and time when the lto start event occurred for this menu modifier',
    `max_quantity` STRING COMMENT 'The count or quantity of max items in this menu modifier',
    `menu_modifier_status` STRING COMMENT 'The current status of the menu modifier for this menu modifier',
    `modifier_type` STRING COMMENT 'The classification type for modifier in this menu modifier',
    `menu_modifier_name` STRING COMMENT 'The display name or label for the menu modifier in this menu modifier',
    `plu_code` STRING COMMENT 'A standardized code representing the plu classification for this menu modifier',
    `pos_button_color` STRING COMMENT 'The pos button color attribute value for this menu modifier record in the menu domain',
    `prep_instruction` STRING COMMENT 'The prep instruction attribute value for this menu modifier record in the menu domain',
    `price_delta` DECIMAL(18,2) COMMENT 'The price delta attribute value for this menu modifier record in the menu domain',
    `protein_delta_g` DECIMAL(18,2) COMMENT 'Protein delta grams',
    `restaurant_format` STRING COMMENT 'The restaurant format attribute value for this menu modifier record in the menu domain',
    `short_name` STRING COMMENT 'The display name or label for the short in this menu modifier',
    `sku` STRING COMMENT 'The sku attribute value for this menu modifier record in the menu domain',
    `sodium_delta_mg` DECIMAL(18,2) COMMENT 'The sodium delta mg attribute value for this menu modifier record in the menu domain',
    `sort_order` STRING COMMENT 'The sort order attribute value for this menu modifier record in the menu domain',
    `tax_category_code` STRING COMMENT 'A standardized code representing the tax category classification for this menu modifier',
    `unavailability_reason` STRING COMMENT 'The unavailability reason attribute value for this menu modifier record in the menu domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this menu modifier record in the menu domain',
    CONSTRAINT pk_menu_modifier PRIMARY KEY(`menu_modifier_id`)
) COMMENT 'Individual modifiers that can be applied to menu items';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`pmix_record` (
    `pmix_record_id` BIGINT COMMENT 'Primary key',
    `financial_period_id` BIGINT COMMENT 'Fiscal period',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this pmix record',
    `promotion_id` BIGINT COMMENT 'Unique identifier for the promotion associated with this pmix record',
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this pmix record',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit associated with this pmix record',
    `avg_selling_price` DECIMAL(18,2) COMMENT 'Average selling price',
    `category_rank` STRING COMMENT 'The category rank attribute value for this pmix record record in the menu domain',
    `cogs_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for cogs in this pmix record',
    `cogs_pct` DECIMAL(18,2) COMMENT 'COGS percent',
    `comp_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for comp in this pmix record',
    `comp_count` STRING COMMENT 'The count or quantity of comp items in this pmix record',
    `contribution_margin_amount` DECIMAL(18,2) COMMENT 'Contribution margin',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this pmix record record in the menu domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this pmix record',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this pmix record',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for discount in this pmix record',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for gross sales in this pmix record',
    `is_available` BOOLEAN COMMENT 'Boolean indicator flag for is available status in this pmix record',
    `is_lto` BOOLEAN COMMENT 'Boolean indicator flag for is lto status in this pmix record',
    `menu_category` STRING COMMENT 'The menu category attribute value for this pmix record record in the menu domain',
    `menu_engineering_classification` STRING COMMENT 'The menu engineering classification attribute value for this pmix record record in the menu domain',
    `menu_list_price` DECIMAL(18,2) COMMENT 'The menu list price attribute value for this pmix record record in the menu domain',
    `menu_mix_pct` DECIMAL(18,2) COMMENT 'Menu mix percent',
    `net_sales_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for net sales in this pmix record',
    `overall_rank` STRING COMMENT 'The overall rank attribute value for this pmix record record in the menu domain',
    `ownership_type` STRING COMMENT 'The classification type for ownership in this pmix record',
    `pos_report_reference` STRING COMMENT 'The pos report reference attribute value for this pmix record record in the menu domain',
    `record_status` STRING COMMENT 'The current status of the record for this pmix record',
    `refund_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for refund in this pmix record',
    `refund_count` STRING COMMENT 'The count or quantity of refund items in this pmix record',
    `reporting_date` DATE COMMENT 'The date and time when the reporting event occurred for this pmix record',
    `reporting_period_type` STRING COMMENT 'The classification type for reporting period in this pmix record',
    `restaurant_format` STRING COMMENT 'The restaurant format attribute value for this pmix record record in the menu domain',
    `sales_channel` STRING COMMENT 'The sales channel attribute value for this pmix record record in the menu domain',
    `sales_mix_pct` DECIMAL(18,2) COMMENT 'Sales mix percent',
    `sku_code` STRING COMMENT 'A standardized code representing the sku classification for this pmix record',
    `unavailability_hours` DECIMAL(18,2) COMMENT 'The unavailability hours attribute value for this pmix record record in the menu domain',
    `units_sold` STRING COMMENT 'The units sold attribute value for this pmix record record in the menu domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this pmix record record in the menu domain',
    `void_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for void in this pmix record',
    `void_count` STRING COMMENT 'The count or quantity of void items in this pmix record',
    CONSTRAINT pk_pmix_record PRIMARY KEY(`pmix_record_id`)
) COMMENT 'Product mix records tracking sales performance of menu items';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`engineering_review` (
    `engineering_review_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the engineering approved by employee associated with this engineering review record',
    `engineering_employee_id` BIGINT COMMENT 'Unique identifier referencing the engineering employee associated with this engineering review record',
    `primary_engineering_employee_id` BIGINT COMMENT 'Primary engineer',
    `allergen_review_required` BOOLEAN COMMENT 'The allergen review required attribute value for this engineering review record in the menu domain',
    `avg_contribution_margin` DECIMAL(18,2) COMMENT 'The avg contribution margin attribute value for this engineering review record in the menu domain',
    `avg_menu_item_popularity_index` DECIMAL(18,2) COMMENT 'Avg popularity index',
    `channel_scope` STRING COMMENT 'The channel scope attribute value for this engineering review record in the menu domain',
    `cogs_pct_threshold` DECIMAL(18,2) COMMENT 'COGS percent threshold',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this engineering review record in the menu domain',
    `daypart_scope` STRING COMMENT 'The daypart scope attribute value for this engineering review record in the menu domain',
    `engineering_framework` STRING COMMENT 'The engineering framework attribute value for this engineering review record in the menu domain',
    `food_safety_review_required` BOOLEAN COMMENT 'The food safety review required attribute value for this engineering review record in the menu domain',
    `implementation_status` STRING COMMENT 'The current status of the implementation for this engineering review',
    `implementation_target_date` DATE COMMENT 'The date and time when the implementation target event occurred for this engineering review',
    `is_comp_sales_impact_assessed` BOOLEAN COMMENT 'Comp sales impact assessed',
    `is_franchise_applicable` BOOLEAN COMMENT 'Franchise applicable',
    `items_discontinue_count` STRING COMMENT 'Items to discontinue',
    `items_evaluated_count` STRING COMMENT 'Items evaluated',
    `items_keep_count` STRING COMMENT 'Items to keep',
    `items_reposition_count` STRING COMMENT 'Items to reposition',
    `items_reprice_count` STRING COMMENT 'Items to reprice',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last updated',
    `lto_items_evaluated_count` STRING COMMENT 'LTO items evaluated',
    `lto_pipeline_decision` STRING COMMENT 'The lto pipeline decision attribute value for this engineering review record in the menu domain',
    `menu_complexity_score_after` DECIMAL(18,2) COMMENT 'Menu complexity after',
    `menu_complexity_score_before` DECIMAL(18,2) COMMENT 'Menu complexity before',
    `next_review_date` DATE COMMENT 'The date and time when the next review event occurred for this engineering review',
    `nutritional_review_required` BOOLEAN COMMENT 'The nutritional review required attribute value for this engineering review record in the menu domain',
    `pmix_data_source` STRING COMMENT 'The pmix data source attribute value for this engineering review record in the menu domain',
    `pricing_strategy_notes` DECIMAL(18,2) COMMENT 'The pricing strategy notes attribute value for this engineering review record in the menu domain',
    `recommended_actions_summary` STRING COMMENT 'Recommended actions',
    `restaurant_format` STRING COMMENT 'The restaurant format attribute value for this engineering review record in the menu domain',
    `restaurant_group_code` STRING COMMENT 'A standardized code representing the restaurant group classification for this engineering review',
    `review_cycle` STRING COMMENT 'The review cycle attribute value for this engineering review record in the menu domain',
    `review_date` DATE COMMENT 'The date and time when the review event occurred for this engineering review',
    `review_number` STRING COMMENT 'The review number attribute value for this engineering review record in the menu domain',
    `review_period_end_date` DATE COMMENT 'Review period end',
    `review_period_start_date` DATE COMMENT 'Review period start',
    `review_scope_type` STRING COMMENT 'The classification type for review scope in this engineering review',
    `review_status` STRING COMMENT 'The current status of the review for this engineering review',
    `reviewer_name` STRING COMMENT 'The display name or label for the reviewer in this engineering review',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this engineering review record in the menu domain',
    CONSTRAINT pk_engineering_review PRIMARY KEY(`engineering_review_id`)
) COMMENT 'Menu engineering reviews and analysis';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`item_cost` (
    `item_cost_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this item cost',
    `recipe_id` BIGINT COMMENT 'Unique identifier for the recipe associated with this item cost',
    `actual_cogs_pct` DECIMAL(18,2) COMMENT 'Actual COGS percent',
    `approved_by` STRING COMMENT 'The approved by attribute value for this item cost record in the menu domain',
    `approved_date` DATE COMMENT 'Approval date',
    `base_selling_price` DECIMAL(18,2) COMMENT 'The base selling price attribute value for this item cost record in the menu domain',
    `channel` STRING COMMENT 'The channel attribute value for this item cost record in the menu domain',
    `cogs_pct_variance` DECIMAL(18,2) COMMENT 'COGS percent variance',
    `cost_calculation_date` DATE COMMENT 'The date and time when the cost calculation event occurred for this item cost',
    `cost_calculation_method` STRING COMMENT 'The cost calculation method attribute value for this item cost record in the menu domain',
    `cost_per_gram` DECIMAL(18,2) COMMENT 'The cost per gram attribute value for this item cost record in the menu domain',
    `cost_status` STRING COMMENT 'The current status of the cost for this item cost',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this item cost record in the menu domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this item cost',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this item cost',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this item cost',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this item cost',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this item cost record in the menu domain',
    `ingredient_count` STRING COMMENT 'The count or quantity of ingredient items in this item cost',
    `is_lto` BOOLEAN COMMENT 'Boolean indicator flag for is lto status in this item cost',
    `marktman_cost_record_code` STRING COMMENT 'A standardized code representing the marktman cost record classification for this item cost',
    `menu_engineering_class` STRING COMMENT 'The menu engineering class attribute value for this item cost record in the menu domain',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this item cost',
    `packaging_cost` DECIMAL(18,2) COMMENT 'The packaging cost attribute value for this item cost record in the menu domain',
    `portion_size_grams` DECIMAL(18,2) COMMENT 'The portion size grams attribute value for this item cost record in the menu domain',
    `price_basis` STRING COMMENT 'The price basis attribute value for this item cost record in the menu domain',
    `price_snapshot_date` DATE COMMENT 'The date and time when the price snapshot event occurred for this item cost',
    `price_snapshot_reference` STRING COMMENT 'The price snapshot reference attribute value for this item cost record in the menu domain',
    `primary_protein_cost` DECIMAL(18,2) COMMENT 'The primary protein cost attribute value for this item cost record in the menu domain',
    `recipe_version` STRING COMMENT 'The recipe version attribute value for this item cost record in the menu domain',
    `restaurant_format` STRING COMMENT 'The restaurant format attribute value for this item cost record in the menu domain',
    `target_cogs_pct` DECIMAL(18,2) COMMENT 'Target COGS percent',
    `target_variance_pct` DECIMAL(18,2) COMMENT 'Target variance percent',
    `theoretical_cogs_pct` DECIMAL(18,2) COMMENT 'Theoretical COGS percent',
    `theoretical_cost_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for theoretical cost in this item cost',
    `theoretical_cost_variance_amount` DECIMAL(18,2) COMMENT 'Theoretical cost variance',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this item cost record in the menu domain',
    `waste_pct` DECIMAL(18,2) COMMENT 'Waste percent',
    `yield_pct` DECIMAL(18,2) COMMENT 'Yield percent',
    CONSTRAINT pk_item_cost PRIMARY KEY(`item_cost_id`)
) COMMENT 'Cost information for menu items';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` (
    `combo_meal_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'Unique identifier for the campaign associated with this combo meal',
    `menu_id` BIGINT COMMENT 'Unique identifier for the menu associated with this combo meal',
    `allergen_flags` STRING COMMENT 'The allergen flags attribute value for this combo meal record in the menu domain',
    `approved_by` STRING COMMENT 'The approved by attribute value for this combo meal record in the menu domain',
    `approved_date` DATE COMMENT 'Approval date',
    `bundle_discount_amount` DECIMAL(18,2) COMMENT 'Bundle discount',
    `bundle_price` DECIMAL(18,2) COMMENT 'The bundle price attribute value for this combo meal record in the menu domain',
    `calorie_range_max` STRING COMMENT 'The calorie range max attribute value for this combo meal record in the menu domain',
    `calorie_range_min` STRING COMMENT 'The calorie range min attribute value for this combo meal record in the menu domain',
    `combo_code` STRING COMMENT 'A standardized code representing the combo classification for this combo meal',
    `combo_description` STRING COMMENT 'The combo description attribute value for this combo meal record in the menu domain',
    `combo_name` STRING COMMENT 'The display name or label for the combo in this combo meal',
    `combo_status` STRING COMMENT 'The current status of the combo for this combo meal',
    `combo_type` STRING COMMENT 'The classification type for combo in this combo meal',
    `country_code` STRING COMMENT 'A standardized code representing the country classification for this combo meal',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this combo meal record in the menu domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this combo meal',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this combo meal',
    `discontinue_date` DATE COMMENT 'The date and time when the discontinue event occurred for this combo meal',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this combo meal',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this combo meal',
    `food_cost_pct` DECIMAL(18,2) COMMENT 'Food cost percent',
    `image_url` STRING COMMENT 'The URL link to the image resource associated with this combo meal',
    `individual_items_price_sum` DECIMAL(18,2) COMMENT 'The individual items price sum attribute value for this combo meal record in the menu domain',
    `is_3pd_available` BOOLEAN COMMENT '3PD available',
    `is_customizable` BOOLEAN COMMENT 'Customizable',
    `is_dine_in_available` BOOLEAN COMMENT 'Dine-in available',
    `is_dt_available` BOOLEAN COMMENT 'Drive-thru available',
    `is_national_launch` BOOLEAN COMMENT 'National launch',
    `is_olo_available` BOOLEAN COMMENT 'OLO available',
    `is_taxable` BOOLEAN COMMENT 'Boolean indicator flag for is taxable status in this combo meal',
    `item_cost` DECIMAL(18,2) COMMENT 'The item cost attribute value for this combo meal record in the menu domain',
    `launch_date` DATE COMMENT 'The date and time when the launch event occurred for this combo meal',
    `menu_engineering_class` STRING COMMENT 'The menu engineering class attribute value for this combo meal record in the menu domain',
    `olo_item_code` STRING COMMENT 'A standardized code representing the olo item classification for this combo meal',
    `ownership_model` STRING COMMENT 'The ownership model attribute value for this combo meal record in the menu domain',
    `pmix_target_pct` DECIMAL(18,2) COMMENT 'PMIX target percent',
    `pos_item_code` STRING COMMENT 'A standardized code representing the pos item classification for this combo meal',
    `region_code` STRING COMMENT 'A standardized code representing the region classification for this combo meal',
    `restaurant_format` STRING COMMENT 'The restaurant format attribute value for this combo meal record in the menu domain',
    `sort_order` STRING COMMENT 'The sort order attribute value for this combo meal record in the menu domain',
    `tax_category_code` STRING COMMENT 'A standardized code representing the tax category classification for this combo meal',
    `total_calories` STRING COMMENT 'The total calories attribute value for this combo meal record in the menu domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this combo meal record in the menu domain',
    CONSTRAINT pk_combo_meal PRIMARY KEY(`combo_meal_id`)
) COMMENT 'Combo meal definitions bundling multiple menu items';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`item_86_event` (
    `item_86_event_id` BIGINT COMMENT 'Primary key',
    `ingredient_lot_id` BIGINT COMMENT 'Ingredient lot',
    `equipment_asset_id` BIGINT COMMENT 'Equipment asset',
    `item_equipment_equipment_asset_id` BIGINT COMMENT 'Equipment asset alt',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the primary item reported by employee associated with this item 86 event record',
    `menu_item_id` BIGINT COMMENT 'Primary menu item',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier for the procurement supplier associated with this item 86 event',
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this item 86 event',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit associated with this item 86 event',
    `channel_affected` STRING COMMENT 'The channel affected attribute value for this item 86 event record in the menu domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this item 86 event record in the menu domain',
    `daypart_affected` STRING COMMENT 'The daypart affected attribute value for this item 86 event record in the menu domain',
    `duration_minutes` DECIMAL(18,2) COMMENT 'The duration minutes attribute value for this item 86 event record in the menu domain',
    `end_timestamp` TIMESTAMP COMMENT 'The end timestamp attribute value for this item 86 event record in the menu domain',
    `escalated_to_team` STRING COMMENT 'The escalated to team attribute value for this item 86 event record in the menu domain',
    `escalation_timestamp` TIMESTAMP COMMENT 'The escalation timestamp attribute value for this item 86 event record in the menu domain',
    `estimated_lost_covers` STRING COMMENT 'The estimated lost covers attribute value for this item 86 event record in the menu domain',
    `event_number` STRING COMMENT 'The event number attribute value for this item 86 event record in the menu domain',
    `event_status` STRING COMMENT 'The current status of the event for this item 86 event',
    `guest_notification_sent` BOOLEAN COMMENT 'The guest notification sent attribute value for this item 86 event record in the menu domain',
    `haccp_ccp_reference` STRING COMMENT 'The haccp ccp reference attribute value for this item 86 event record in the menu domain',
    `inventory_quantity_on_hand` DECIMAL(18,2) COMMENT 'Inventory on hand',
    `inventory_unit_of_measure` STRING COMMENT 'Inventory UOM',
    `is_food_safety_related` BOOLEAN COMMENT 'Food safety related',
    `is_lto_item` BOOLEAN COMMENT 'Boolean indicator flag for is lto item status in this item 86 event',
    `is_recall_related` BOOLEAN COMMENT 'Recall related',
    `kds_alert_sent` BOOLEAN COMMENT 'The kds alert sent attribute value for this item 86 event record in the menu domain',
    `olo_item_code` STRING COMMENT 'A standardized code representing the olo item classification for this item 86 event',
    `olo_suppressed` BOOLEAN COMMENT 'The olo suppressed attribute value for this item 86 event record in the menu domain',
    `ownership_model` STRING COMMENT 'The ownership model attribute value for this item 86 event record in the menu domain',
    `par_level_quantity` DECIMAL(18,2) COMMENT 'The count or quantity of par level items in this item 86 event',
    `pos_item_code` STRING COMMENT 'A standardized code representing the pos item classification for this item 86 event',
    `pos_suppressed` BOOLEAN COMMENT 'The pos suppressed attribute value for this item 86 event record in the menu domain',
    `reason_code` STRING COMMENT 'A standardized code representing the reason classification for this item 86 event',
    `reason_detail` STRING COMMENT 'The reason detail attribute value for this item 86 event record in the menu domain',
    `reported_by_role` STRING COMMENT 'The reported by role attribute value for this item 86 event record in the menu domain',
    `resolution_action` STRING COMMENT 'The resolution action attribute value for this item 86 event record in the menu domain',
    `restaurant_format` STRING COMMENT 'The restaurant format attribute value for this item 86 event record in the menu domain',
    `start_timestamp` TIMESTAMP COMMENT 'The start timestamp attribute value for this item 86 event record in the menu domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this item 86 event record in the menu domain',
    `zenput_task_code` STRING COMMENT 'A standardized code representing the zenput task classification for this item 86 event',
    CONSTRAINT pk_item_86_event PRIMARY KEY(`item_86_event_id`)
) COMMENT 'Events when menu items are marked as unavailable (86ed)';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`dietary_tag` (
    `dietary_tag_id` BIGINT COMMENT 'Primary key',
    `parent_dietary_tag_id` BIGINT COMMENT 'Parent tag',
    `dietary_tag_category` STRING COMMENT 'The dietary tag category attribute value for this dietary tag record in the menu domain',
    `certification_required` BOOLEAN COMMENT 'The certification required attribute value for this dietary tag record in the menu domain',
    `certifying_body` STRING COMMENT 'The certifying body attribute value for this dietary tag record in the menu domain',
    `dietary_tag_code` STRING COMMENT 'A standardized code representing the dietary tag classification for this dietary tag',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this dietary tag record in the menu domain',
    `display_order` STRING COMMENT 'The display order attribute value for this dietary tag record in the menu domain',
    `effective_from` TIMESTAMP COMMENT 'The effective from attribute value for this dietary tag record in the menu domain',
    `effective_until` TIMESTAMP COMMENT 'The effective until attribute value for this dietary tag record in the menu domain',
    `guest_label` STRING COMMENT 'The guest label attribute value for this dietary tag record in the menu domain',
    `icon_url` STRING COMMENT 'The URL link to the icon resource associated with this dietary tag',
    `dietary_tag_name` STRING COMMENT 'The display name or label for the dietary tag in this dietary tag',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this dietary tag',
    `priority_score` DECIMAL(18,2) COMMENT 'The priority score attribute value for this dietary tag record in the menu domain',
    `scope` STRING COMMENT 'The scope attribute value for this dietary tag record in the menu domain',
    `dietary_tag_status` STRING COMMENT 'The current status of the dietary tag for this dietary tag',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this dietary tag record in the menu domain',
    CONSTRAINT pk_dietary_tag PRIMARY KEY(`dietary_tag_id`)
) COMMENT 'Dietary tags for categorizing menu items';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`combo_component` (
    `combo_component_id` BIGINT COMMENT 'Primary key',
    `combo_meal_id` BIGINT COMMENT 'Combo meal',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this combo component',
    `modifier_group_id` BIGINT COMMENT 'Modifier group',
    `allergen_warning_text` STRING COMMENT 'The allergen warning text attribute value for this combo component record in the menu domain',
    `calorie_contribution` STRING COMMENT 'The calorie contribution attribute value for this combo component record in the menu domain',
    `calorie_count` STRING COMMENT 'The count or quantity of calorie items in this combo component',
    `component_group_name` STRING COMMENT 'The display name or label for the component group in this combo component',
    `component_name` STRING COMMENT 'The display name or label for the component in this combo component',
    `component_quantity` STRING COMMENT 'The count or quantity of component items in this combo component',
    `component_role` STRING COMMENT 'The component role attribute value for this combo component record in the menu domain',
    `component_sequence` STRING COMMENT 'The component sequence attribute value for this combo component record in the menu domain',
    `component_type` STRING COMMENT 'The classification type for component in this combo component',
    `cost_contribution` DECIMAL(18,2) COMMENT 'The cost contribution attribute value for this combo component record in the menu domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this combo component record in the menu domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this combo component',
    `daypart_restriction` STRING COMMENT 'The daypart restriction attribute value for this combo component record in the menu domain',
    `default_flag` BOOLEAN COMMENT 'Default flag alt',
    `default_selection` BOOLEAN COMMENT 'The default selection attribute value for this combo component record in the menu domain',
    `display_name` STRING COMMENT 'The display name or label for the display in this combo component',
    `display_order` STRING COMMENT 'The display order attribute value for this combo component record in the menu domain',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this combo component',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this combo component',
    `is_default` BOOLEAN COMMENT 'Boolean indicator flag for is default status in this combo component',
    `is_default_flag` BOOLEAN COMMENT 'Default flag',
    `is_default_selection` BOOLEAN COMMENT 'Boolean indicator flag for is default selection status in this combo component',
    `is_featured` BOOLEAN COMMENT 'Boolean indicator flag for is featured status in this combo component',
    `is_required` BOOLEAN COMMENT 'Boolean indicator flag for is required status in this combo component',
    `is_substitutable` BOOLEAN COMMENT 'Substitutable',
    `is_swappable` BOOLEAN COMMENT 'Boolean indicator flag for is swappable status in this combo component',
    `item_price_override` DECIMAL(18,2) COMMENT 'Price override',
    `max_quantity` STRING COMMENT 'The count or quantity of max items in this combo component',
    `min_quantity` STRING COMMENT 'The count or quantity of min items in this combo component',
    `nutrition_multiplier` DECIMAL(18,2) COMMENT 'The nutrition multiplier attribute value for this combo component record in the menu domain',
    `portion_weight_grams` DECIMAL(18,2) COMMENT 'The portion weight grams attribute value for this combo component record in the menu domain',
    `prep_station_code` STRING COMMENT 'A standardized code representing the prep station classification for this combo component',
    `quantity` STRING COMMENT 'The quantity attribute value for this combo component record in the menu domain',
    `sequence_order` STRING COMMENT 'The sequence order attribute value for this combo component record in the menu domain',
    `sort_order` STRING COMMENT 'The sort order attribute value for this combo component record in the menu domain',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Substitution allowed',
    `substitution_group` STRING COMMENT 'The substitution group attribute value for this combo component record in the menu domain',
    `substitution_upcharge` DECIMAL(18,2) COMMENT 'The substitution upcharge attribute value for this combo component record in the menu domain',
    `upcharge_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for upcharge in this combo component',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this combo component record in the menu domain',
    CONSTRAINT pk_combo_component PRIMARY KEY(`combo_component_id`)
) COMMENT 'Components that make up combo meals';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`dietary_tag_assignment` (
    `dietary_tag_assignment_id` BIGINT COMMENT 'Primary key',
    `dietary_tag_id` BIGINT COMMENT 'Dietary tag',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this dietary tag assignment',
    `assigned_at` TIMESTAMP COMMENT 'The date and time when the assigned event occurred for this dietary tag assignment',
    `assigned_by` STRING COMMENT 'The assigned by attribute value for this dietary tag assignment record in the menu domain',
    `assigned_date` DATE COMMENT 'The date and time when the assigned event occurred for this dietary tag assignment',
    `assignment_date` DATE COMMENT 'The date and time when the assignment event occurred for this dietary tag assignment',
    `assignment_source` STRING COMMENT 'The assignment source attribute value for this dietary tag assignment record in the menu domain',
    `assignment_status` STRING COMMENT 'The current status of the assignment for this dietary tag assignment',
    `confidence_level` STRING COMMENT 'The confidence level attribute value for this dietary tag assignment record in the menu domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this dietary tag assignment record in the menu domain',
    `effective_date` DATE COMMENT 'The date and time when the effective event occurred for this dietary tag assignment',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this dietary tag assignment',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this dietary tag assignment',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this dietary tag assignment',
    `expiry_date` DATE COMMENT 'The date and time when the expiry event occurred for this dietary tag assignment',
    `is_active` BOOLEAN COMMENT 'Active flag',
    `is_primary` BOOLEAN COMMENT 'Primary flag',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this dietary tag assignment',
    `source` STRING COMMENT 'The source attribute value for this dietary tag assignment record in the menu domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this dietary tag assignment record in the menu domain',
    `verification_date` DATE COMMENT 'The date and time when the verification event occurred for this dietary tag assignment',
    `verification_method` STRING COMMENT 'The verification method attribute value for this dietary tag assignment record in the menu domain',
    `verification_status` STRING COMMENT 'The current status of the verification for this dietary tag assignment',
    `verified_at` TIMESTAMP COMMENT 'The date and time when the verified event occurred for this dietary tag assignment',
    `verified_by` STRING COMMENT 'The verified by attribute value for this dietary tag assignment record in the menu domain',
    `verified_flag` BOOLEAN COMMENT 'Boolean indicator flag for verified flag status in this dietary tag assignment',
    CONSTRAINT pk_dietary_tag_assignment PRIMARY KEY(`dietary_tag_assignment_id`)
) COMMENT 'Assignments of dietary tags to menu items';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` ADD CONSTRAINT `fk_menu_nutrition_profile_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` ADD CONSTRAINT `fk_menu_nutrition_profile_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ADD CONSTRAINT `fk_menu_allergen_declaration_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ADD CONSTRAINT `fk_menu_allergen_declaration_superseded_by_allergen_declaration_id` FOREIGN KEY (`superseded_by_allergen_declaration_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`allergen_declaration`(`allergen_declaration_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_previous_lto_menu_lto_id` FOREIGN KEY (`previous_lto_menu_lto_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_lto`(`menu_lto_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ADD CONSTRAINT `fk_menu_menu_modifier_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ADD CONSTRAINT `fk_menu_menu_modifier_modifier_group_id` FOREIGN KEY (`modifier_group_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`modifier_group`(`modifier_group_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` ADD CONSTRAINT `fk_menu_item_cost_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` ADD CONSTRAINT `fk_menu_item_cost_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ADD CONSTRAINT `fk_menu_combo_meal_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu`(`menu_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`dietary_tag` ADD CONSTRAINT `fk_menu_dietary_tag_parent_dietary_tag_id` FOREIGN KEY (`parent_dietary_tag_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`dietary_tag`(`dietary_tag_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ADD CONSTRAINT `fk_menu_combo_component_combo_meal_id` FOREIGN KEY (`combo_meal_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`combo_meal`(`combo_meal_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ADD CONSTRAINT `fk_menu_combo_component_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ADD CONSTRAINT `fk_menu_combo_component_modifier_group_id` FOREIGN KEY (`modifier_group_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`modifier_group`(`modifier_group_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`dietary_tag_assignment` ADD CONSTRAINT `fk_menu_dietary_tag_assignment_dietary_tag_id` FOREIGN KEY (`dietary_tag_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`dietary_tag`(`dietary_tag_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`dietary_tag_assignment` ADD CONSTRAINT `fk_menu_dietary_tag_assignment_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`menu` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_restaurants_v1`.`menu` SET TAGS ('dbx_domain' = 'menu');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` SET TAGS ('dbx_ssot_canonical' = 'order.order_item');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ALTER COLUMN `image_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ALTER COLUMN `item_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ALTER COLUMN `menu_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ALTER COLUMN `prep_state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` SET TAGS ('dbx_subdomain' = 'item_catalog');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ALTER COLUMN `item_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ALTER COLUMN `item_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` SET TAGS ('dbx_subdomain' = 'dietary_compliance');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` SET TAGS ('dbx_subdomain' = 'dietary_compliance');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ALTER COLUMN `cross_contact_risk_level` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ALTER COLUMN `cross_contact_source` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_lto` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_lto` SET TAGS ('dbx_subdomain' = 'promotional_engineering');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_lto` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_lto` ALTER COLUMN `menu_lto_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` SET TAGS ('dbx_subdomain' = 'promotional_engineering');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` ALTER COLUMN `display_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` ALTER COLUMN `group_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` ALTER COLUMN `image_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` SET TAGS ('dbx_subdomain' = 'promotional_engineering');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` SET TAGS ('dbx_ssot_canonical' = 'order.order_modifier');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ALTER COLUMN `image_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ALTER COLUMN `menu_modifier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ALTER COLUMN `short_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`pmix_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`pmix_record` SET TAGS ('dbx_subdomain' = 'performance_costing');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`engineering_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`engineering_review` SET TAGS ('dbx_subdomain' = 'performance_costing');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`engineering_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`engineering_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`engineering_review` ALTER COLUMN `engineering_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`engineering_review` ALTER COLUMN `engineering_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`engineering_review` ALTER COLUMN `primary_engineering_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`engineering_review` ALTER COLUMN `primary_engineering_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`engineering_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` SET TAGS ('dbx_subdomain' = 'performance_costing');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` SET TAGS ('dbx_subdomain' = 'promotional_engineering');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ALTER COLUMN `combo_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ALTER COLUMN `image_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_86_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_86_event` SET TAGS ('dbx_subdomain' = 'performance_costing');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_86_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_86_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`dietary_tag` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`dietary_tag` SET TAGS ('dbx_subdomain' = 'dietary_compliance');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`dietary_tag` ALTER COLUMN `dietary_tag_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` SET TAGS ('dbx_subdomain' = 'promotional_engineering');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ALTER COLUMN `component_group_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ALTER COLUMN `component_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ALTER COLUMN `display_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`dietary_tag_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`dietary_tag_assignment` SET TAGS ('dbx_subdomain' = 'dietary_compliance');
