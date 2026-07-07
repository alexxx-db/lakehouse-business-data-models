-- Schema for Domain: menu | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-02 04:02:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`menu` COMMENT 'Single source of truth for all menu items, recipes, BOMs (Bill of Materials), nutritional data, allergen declarations, pricing, product mix (PMIX), limited time offers (LTO), and menu engineering decisions across dayparts, channels (DT, OLO, 3PD), and restaurant formats (QSR, casual, fine-dining). Governs what the business sells.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`menu_item` (
    `menu_item_id` BIGINT COMMENT 'Primary key',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Menu items are brand-owned catalog assets. Brand managers use this FK for brand-level menu compliance audits, franchise IP tracking, and brand P&L reporting. In multi-brand enterprises, every menu ite',
    `employee_id` BIGINT COMMENT 'Employee who created the item',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Brand-level master menus (national templates, franchise master menus) exist independently of any single unit. Brand culinary and marketing teams publish brand-wide menus. restaurant.unit_id covers unit-spec',
    `employee_id` BIGINT COMMENT 'Creator employee',
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
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Restaurant operations maintain an approved-supplier list per recipe ingredient to ensure quality consistency, drive procurement decisions, and support supplier performance reporting against specific m',
    `ingredient_id` BIGINT COMMENT 'Substitute ingredient',
    `recipe_id` BIGINT COMMENT 'Recipe reference',
    `recipe_main_ingredient_id` BIGINT COMMENT 'Ingredient reference',
    `allergen_flags` STRING COMMENT 'The allergen flags attribute value for this recipe ingredient record in the menu domain',
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
    `unit_of_measure` STRING COMMENT 'The unit of measure attribute value for this recipe ingredient record in the menu domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this recipe ingredient record in the menu domain',
    `waste_factor_pct` DECIMAL(18,2) COMMENT 'Waste factor percent',
    `yield_pct` DECIMAL(18,2) COMMENT 'Yield percent',
    CONSTRAINT pk_recipe_ingredient PRIMARY KEY(`recipe_ingredient_id`)
) COMMENT 'Ingredients used in recipes with quantities and specifications';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`item_price` (
    `item_price_id` BIGINT COMMENT 'Primary key',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this item price',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the item approved by employee associated with this item price record',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Allergen declarations are brand-level regulatory compliance documents. Brand compliance officers submit allergen disclosures to health authorities per brand. allergen_declaration has regulatory_submis',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the created by employee associated with this allergen declaration record',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this allergen declaration',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to menu.recipe. Business justification: Allergen declarations are version-specific to a recipe — changing a recipe (ingredients, preparation) directly impacts allergen status. Adding recipe_id FK normalizes the existing recipe_version STRIN',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` (
    `modifier_group_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Modifier group approval is part of menu governance — a manager approves new modifier groups before POS/OLO deployment. This FK supports menu change management audits and franchise configuration compli',
    `allergen_relevance_flag` BOOLEAN COMMENT 'Allergen relevance',
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
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Each menu modifier (e.g., add bacon, extra cheese) maps to a specific ingredient for COGS delta calculation, allergen flagging, and inventory deduction. Restaurant operations require this link to ',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this menu modifier',
    `modifier_group_id` BIGINT COMMENT 'Modifier group',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Menu modifiers (e.g., add bacon, extra cheese) map directly to a stock_item for inventory depletion tracking, 86d modifier management when stock runs out, and modifier-level food cost calculation',
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
    `sodium_delta_mg` DECIMAL(18,2) COMMENT 'The sodium delta mg attribute value for this menu modifier record in the menu domain',
    `sort_order` STRING COMMENT 'The sort order attribute value for this menu modifier record in the menu domain',
    `tax_category_code` STRING COMMENT 'A standardized code representing the tax category classification for this menu modifier',
    `unavailability_reason` STRING COMMENT 'The unavailability reason attribute value for this menu modifier record in the menu domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this menu modifier record in the menu domain',
    CONSTRAINT pk_menu_modifier PRIMARY KEY(`menu_modifier_id`)
) COMMENT 'Individual modifiers that can be applied to menu items';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`item_cost` (
    `item_cost_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cost approval is a financial control process — a manager or finance employee must formally sign off on theoretical vs. actual COGS variances. This FK enables cost variance audit reports and financial ',
    `food_cost_period_id` BIGINT COMMENT 'Foreign key linking to inventory.food_cost_period. Business justification: item_cost records theoretical vs actual COGS per menu item within a fiscal period. Linking to food_cost_period enables period-level food cost variance reports that drill from unit-level aggregate (foo',
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item associated with this item cost',
    `recipe_id` BIGINT COMMENT 'Unique identifier for the recipe associated with this item cost',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Unit-level COGS variance reporting is a core restaurant operations process. Food cost controllers track theoretical vs. actual cost per menu item per unit per fiscal period. item_cost has fiscal_perio',
    `actual_cogs_pct` DECIMAL(18,2) COMMENT 'Actual COGS percent',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Combo meal launch approval is a named marketing/ops governance process — a specific employee (e.g., VP Menu) must approve before national launch. Tracking the approver enables launch accountability re',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Combo meals are brand-governed promotional bundles. Brand marketing teams track national vs. regional combo launches, bundle pricing strategy, and franchise combo compliance by brand. combo_meal has i',
    `menu_id` BIGINT COMMENT 'Unique identifier for the menu associated with this combo meal',
    `allergen_flags` STRING COMMENT 'The allergen flags attribute value for this combo meal record in the menu domain',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`item_listing` (
    `item_listing_id` BIGINT COMMENT 'Primary key for the menu_item_listing association',
    `menu_id` BIGINT COMMENT 'Foreign key linking this listing record to the parent menu on which the item appears',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking this listing record to the menu item that appears on the menu',
    `channel_override_price` DECIMAL(18,2) COMMENT 'A menu-and-channel-specific price for this item that overrides the base_price on the menu_item record. Captures pricing variations such as delivery surcharges or promotional menu pricing.',
    `daypart_override` STRING COMMENT 'A daypart restriction or override specific to this menu-item pairing, superseding the default daypart on either the menu or the item. For example, a burger available all-day on the dine-in menu but only at lunch on the drive-thru menu.',
    `effective_end_date` DATE COMMENT 'The date on which this menu item is removed from or deactivated on this specific menu. Supports LTO removals and seasonal menu changes at the listing level.',
    `effective_start_date` DATE COMMENT 'The date on which this menu item becomes active and visible on this specific menu. Allows items to be pre-scheduled for listing without being immediately visible.',
    `is_featured_item` BOOLEAN COMMENT 'Indicates whether this menu item is featured or promoted on this specific menu. A featured flag is a property of the listing context, not of the item globally.',
    `item_count` STRING COMMENT 'Number of items [Moved from menu: item_count on the menu entity is a denormalized aggregate count of how many items are listed on the menu. This value is derivable from COUNT(*) on the menu_item_listing association and should not be stored as a static attribute on menu, as it becomes stale whenever listings are added or removed. It should be removed from menu and computed from the association.]',
    `sort_order` BIGINT COMMENT 'The display position of this menu item within the menu. Determines the order in which items are presented to customers on this specific menu. Belongs to the listing, not to the item or menu independently.',
    CONSTRAINT pk_item_listing PRIMARY KEY(`item_listing_id`)
) COMMENT 'This association product represents the Listing (role-based assignment) between menu and menu_item. It captures the operational fact that a specific menu item has been placed on a specific menu, along with the display, pricing, and availability rules that govern that particular pairing. Each record links one menu to one menu_item with attributes — sort order, featured status, channel price override, effective dates, and daypart override — that exist only in the context of this menu-item combination and cannot reside on either entity alone.. Existence Justification: In restaurant operations, menu items are not owned by a single menu — a cheeseburger appears on the Breakfast menu, the All-Day menu, the Drive-Thru menu, and the Digital menu simultaneously, each with potentially different sort orders, featured status, and pricing overrides. Conversely, a single menu contains many items. The business actively manages these listings: items are added to or removed from menus, featured placements are curated, and channel-specific price overrides are applied per listing. This is a first-class operational concept called a menu item listing or menu item assignment that restaurant operators create, update, and delete as part of daily menu management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`menu`.`combo_component` (
    `combo_component_id` BIGINT COMMENT 'Primary key for the combo_component association',
    `combo_meal_id` BIGINT COMMENT 'Foreign key linking this component record to its parent combo meal definition',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking this component record to the specific menu item included in the combo',
    `component_type` STRING COMMENT 'The role this menu item plays within the combo meal (e.g., main entrée, side, beverage). Belongs to the pairing — the same menu item can be a SIDE in one combo and a MAIN in another.',
    `is_combo_eligible` BOOLEAN COMMENT 'Eligible for combo meals [Moved from menu_item: This boolean flag on menu_item was a workaround to indicate combo participation. With the combo_component association table explicitly recording which items are in which combos, is_combo_eligible becomes derivable (any menu_item with at least one combo_component record is combo-eligible) and is therefore redundant on menu_item. It should be deprecated from menu_item once the association is populated.]',
    `is_required_component` BOOLEAN COMMENT 'Indicates whether this component slot is mandatory in the combo or optional. A combo may have required items (e.g., the burger) and optional items (e.g., a dessert upgrade).',
    `quantity` STRING COMMENT 'The number of units of this menu item included in the combo meal slot. Belongs to the pairing, not to the item or the combo definition alone.',
    `sort_order` STRING COMMENT 'The display sequence of this component within the combo meal, used for menu rendering and POS display. Belongs to the pairing context.',
    `substitution_allowed` BOOLEAN COMMENT 'Indicates whether the customer may substitute a different menu item for this component slot. Belongs to the combo-item pairing, not to either entity alone.',
    `upcharge_amount` DECIMAL(18,2) COMMENT 'The additional price charged when this specific menu item is selected in this combo slot, above the base combo price. This is a pairing-level attribute — the same item may have different upcharges in different combos.',
    CONSTRAINT pk_combo_component PRIMARY KEY(`combo_component_id`)
) COMMENT 'This association product represents the Component Role between combo_meal and menu_item. It captures which menu items are included in each combo meal, in what quantity, in what role (main/side/drink), and under what substitution and pricing rules. Each record links one combo_meal to one menu_item and carries attributes that exist only in the context of that specific combo-item pairing — such as component type, sort order, and upcharge amount.. Existence Justification: In restaurant operations, a combo meal is explicitly defined as a bundle of multiple menu items (e.g., a burger + fries + drink), and a single menu item (e.g., Medium Fries) can appear in many different combo meals simultaneously. This is a genuine operational M:N relationship: the business actively creates, manages, and prices these component assignments, and the composition of a combo is a core business concept that menu engineers and product managers work with daily.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` ADD CONSTRAINT `fk_menu_nutrition_profile_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` ADD CONSTRAINT `fk_menu_nutrition_profile_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ADD CONSTRAINT `fk_menu_allergen_declaration_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ADD CONSTRAINT `fk_menu_allergen_declaration_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ADD CONSTRAINT `fk_menu_allergen_declaration_superseded_by_allergen_declaration_id` FOREIGN KEY (`superseded_by_allergen_declaration_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`allergen_declaration`(`allergen_declaration_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ADD CONSTRAINT `fk_menu_menu_modifier_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ADD CONSTRAINT `fk_menu_menu_modifier_modifier_group_id` FOREIGN KEY (`modifier_group_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`modifier_group`(`modifier_group_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` ADD CONSTRAINT `fk_menu_item_cost_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` ADD CONSTRAINT `fk_menu_item_cost_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ADD CONSTRAINT `fk_menu_combo_meal_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu`(`menu_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` ADD CONSTRAINT `fk_menu_item_listing_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu`(`menu_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` ADD CONSTRAINT `fk_menu_item_listing_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ADD CONSTRAINT `fk_menu_combo_component_combo_meal_id` FOREIGN KEY (`combo_meal_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`combo_meal`(`combo_meal_id`);
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ADD CONSTRAINT `fk_menu_combo_component_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_restaurants_v1`.`menu`.`menu_item`(`menu_item_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`menu` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_restaurants_v1`.`menu` SET TAGS ('dbx_domain' = 'menu');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` SET TAGS ('dbx_subdomain' = 'menu_catalog');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ALTER COLUMN `image_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_item` ALTER COLUMN `item_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` SET TAGS ('dbx_subdomain' = 'menu_catalog');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu` ALTER COLUMN `menu_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` SET TAGS ('dbx_subdomain' = 'recipe_nutrition');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` SET TAGS ('dbx_subdomain' = 'recipe_nutrition');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`recipe_ingredient` ALTER COLUMN `prep_state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` SET TAGS ('dbx_subdomain' = 'item_costing');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_price` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` SET TAGS ('dbx_subdomain' = 'recipe_nutrition');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`nutrition_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` SET TAGS ('dbx_subdomain' = 'recipe_nutrition');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ALTER COLUMN `cross_contact_risk_level` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`allergen_declaration` ALTER COLUMN `cross_contact_source` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` SET TAGS ('dbx_subdomain' = 'menu_catalog');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` ALTER COLUMN `display_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` ALTER COLUMN `group_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`modifier_group` ALTER COLUMN `image_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` SET TAGS ('dbx_subdomain' = 'menu_catalog');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Modifier Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ALTER COLUMN `image_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ALTER COLUMN `menu_modifier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`menu_modifier` ALTER COLUMN `short_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` SET TAGS ('dbx_subdomain' = 'item_costing');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` ALTER COLUMN `food_cost_period_id` SET TAGS ('dbx_business_glossary_term' = 'Food Cost Period Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_cost` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` SET TAGS ('dbx_subdomain' = 'menu_catalog');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ALTER COLUMN `combo_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_meal` ALTER COLUMN `image_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` SET TAGS ('dbx_subdomain' = 'menu_catalog');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` SET TAGS ('dbx_association_edges' = 'menu.menu,menu.menu_item');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` ALTER COLUMN `item_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Listing - Menu Item Listing Id');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Listing - Menu Id');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Listing - Menu Item Id');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` ALTER COLUMN `channel_override_price` SET TAGS ('dbx_business_glossary_term' = 'Channel Override Price');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` ALTER COLUMN `daypart_override` SET TAGS ('dbx_business_glossary_term' = 'Daypart Override');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Listing Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Listing Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` ALTER COLUMN `is_featured_item` SET TAGS ('dbx_business_glossary_term' = 'Featured Item Flag');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`item_listing` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Item Sort Order');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` SET TAGS ('dbx_subdomain' = 'menu_catalog');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` SET TAGS ('dbx_association_edges' = 'menu.combo_meal,menu.menu_item');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ALTER COLUMN `combo_component_id` SET TAGS ('dbx_business_glossary_term' = 'Combo Component - Combo Component Id');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ALTER COLUMN `combo_meal_id` SET TAGS ('dbx_business_glossary_term' = 'Combo Component - Combo Meal Id');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Combo Component - Menu Item Id');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ALTER COLUMN `is_required_component` SET TAGS ('dbx_business_glossary_term' = 'Required Component Flag');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Display Sort Order');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ALTER COLUMN `substitution_allowed` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `vibe_restaurants_v1`.`menu`.`combo_component` ALTER COLUMN `upcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Component Upcharge Amount');
