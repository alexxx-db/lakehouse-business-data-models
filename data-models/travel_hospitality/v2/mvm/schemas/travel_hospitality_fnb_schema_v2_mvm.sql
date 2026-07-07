-- Schema for Domain: fnb | Business: Travel_Hospitality | Version: v2_mvm
-- Generated on: 2026-06-27 02:37:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`fnb` COMMENT 'F&B operations including restaurant outlets, bars, room service, banquets, and catering. Manages menus, recipes, POS transactions, covers, check averages, and outlet performance. Tracks food cost, beverage cost, and F&B revenue contribution to TRevPAR. Integrates with Oracle Hospitality MICROS POS. Supports USALI F&B departmental reporting and ISO 22000 food safety compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` (
    `fnb_outlet_id` BIGINT COMMENT 'Primary key for outlet',
    `property_id` BIGINT COMMENT 'Reference to the property where this F&B outlet operates.',
    `property_outlet_id` BIGINT COMMENT '',
    `accepts_reservations_flag` BOOLEAN COMMENT 'Indicates whether the outlet accepts advance guest reservations through Property Management System (PMS), Customer Relationship Management (CRM), or third-party reservation platforms.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether the outlet meets ADA accessibility requirements including wheelchair access, accessible seating, and accessible restroom facilities.',
    `average_check_target` DECIMAL(18,2) COMMENT 'Target average guest check amount in property base currency. Key performance indicator for revenue management and menu pricing strategy. Used in Food and Beverage (F&B) revenue contribution to Total Revenue Per Available Room (TRevPAR).',
    `beverage_cost_percentage_target` DECIMAL(18,2) COMMENT 'Target beverage cost as a percentage of beverage revenue. Standard USALI metric for bar and beverage profitability. Typical range 18-24% for alcoholic beverages.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this outlet record was first created in the system. Audit trail for data lineage and compliance.',
    `cuisine_category` STRING COMMENT 'Primary cuisine type or culinary style offered by the outlet (e.g., Italian, Asian Fusion, American Steakhouse, International Buffet, Contemporary, Seafood). Used for guest preference matching and marketing segmentation.',
    `dress_code` STRING COMMENT 'Guest attire requirements for the outlet. Communicated during reservation and at property arrival. Impacts guest experience and outlet positioning.. Valid values are `casual|smart_casual|business_casual|formal|resort_casual|no_dress_code`',
    `email_address` STRING COMMENT 'Official email address for the outlet. Used for reservation confirmations, guest communication, and vendor correspondence. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `food_cost_percentage_target` DECIMAL(18,2) COMMENT 'Target food cost as a percentage of food revenue. Standard USALI metric for F&B profitability management. Typical range 28-35% depending on outlet type and cuisine.',
    `iso_22000_certification_date` DATE COMMENT 'Date when ISO 22000 certification was granted or last renewed. Used for compliance tracking and audit scheduling.',
    `iso_22000_certified_flag` BOOLEAN COMMENT 'Indicates whether the outlet holds ISO 22000 Food Safety Management System certification. Required for certain international brand standards and regulatory compliance in multiple jurisdictions.',
    `iso_22000_expiry_date` DATE COMMENT 'Date when current ISO 22000 certification expires. Triggers renewal workflow and compliance alerts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this outlet record was last updated. Audit trail for change tracking and data quality monitoring.',
    `last_renovation_date` DATE COMMENT 'Date of the most recent major renovation or refurbishment. Used for Furniture Fixtures and Equipment (FF&E) reserve planning and Property Improvement Plan (PIP) tracking.',
    `location_description` STRING COMMENT 'Physical location description within the property (e.g., Lobby Level, 2nd Floor Overlooking Pool, Rooftop, Beachfront). Used for guest wayfinding and marketing collateral.',
    `menu_last_updated_date` DATE COMMENT 'Date when the outlet menu was last revised or updated. Used for menu lifecycle management, seasonal menu tracking, and guest communication.',
    `opening_date` DATE COMMENT 'Date when the outlet first opened for guest service. Used for anniversary tracking, historical performance analysis, and asset lifecycle management.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for Monday through Friday, formatted as time ranges (e.g., 07:00-22:00, 11:30-14:30,18:00-23:00 for split shifts). Used for labor scheduling and guest communication.',
    `operating_hours_weekend` STRING COMMENT 'Standard operating hours for Saturday and Sunday, formatted as time ranges. May differ from weekday hours to accommodate leisure travel patterns.',
    `outlet_code` STRING COMMENT 'Unique business identifier code for the outlet used in Oracle Hospitality MICROS Point of Sale (POS) and revenue reporting systems. Typically a short alphanumeric code assigned during outlet setup.. Valid values are `^[A-Z0-9]{3,10}$`',
    `outlet_name` STRING COMMENT 'The official business name of the F&B outlet as displayed to guests and used in marketing materials (e.g., The Terrace Grill, Lobby Bar, In-Room Dining).',
    `outlet_status` STRING COMMENT 'Current operational lifecycle status of the outlet. Determines availability for reservations, POS transactions, and revenue reporting inclusion.. Valid values are `active|inactive|seasonal|under_renovation|temporarily_closed|permanently_closed`',
    `outlet_type` STRING COMMENT 'Classification of the F&B outlet by operational format and service model. Determines reporting category and operational standards. [ENUM-REF-CANDIDATE: restaurant|bar|lounge|room_service|pool_bar|coffee_shop|banquet_kitchen|grab_and_go|buffet|specialty_dining|nightclub — 11 candidates stripped; promote to reference product]',
    `phone_number` STRING COMMENT 'Direct contact phone number for the outlet. Used for guest reservations, inquiries, and internal property communication. Organizational contact data classified as confidential.',
    `pos_terminal_code` STRING COMMENT 'Primary Oracle Hospitality MICROS POS terminal identifier assigned to this outlet. Used for transaction reconciliation and system integration.',
    `revenue_center_code` STRING COMMENT 'USALI-compliant revenue center identifier used in General Ledger (GL) and financial reporting. Maps F&B outlet transactions to departmental Profit and Loss (P&L) statements and Gross Operating Profit (GOP) calculations.. Valid values are `^[0-9]{4,6}$`',
    `seating_capacity` STRING COMMENT 'Maximum number of guest seats available in the outlet under normal operating configuration. Used for covers forecasting and Revenue Per Available Seat Hour (RevPASH) calculations.',
    `service_style` STRING COMMENT 'The service delivery model and dining experience format. Impacts staffing requirements, Average Check (AC), and Guest Satisfaction Score (GSS). [ENUM-REF-CANDIDATE: a_la_carte|buffet|grab_and_go|quick_service|fine_dining|casual_dining|family_style|tasting_menu — 8 candidates stripped; promote to reference product]',
    `smoking_policy` STRING COMMENT 'Smoking policy for the outlet. Must comply with local health regulations and property standards. Communicated to guests during reservation and seating.. Valid values are `non_smoking|smoking_allowed|outdoor_smoking_area|designated_smoking_section`',
    CONSTRAINT pk_fnb_outlet PRIMARY KEY(`fnb_outlet_id`)
) COMMENT 'Master record for each F&B outlet (restaurant, bar, lounge, room service, pool bar, banquet kitchen) operating within a property. Captures outlet type, cuisine category, seating capacity, operating hours, POS terminal assignments, revenue center code per USALI, outlet status, service style (à la carte, buffet, grab-and-go), and ISO 22000 food safety certification status. Single source of truth for F&B outlet identity across Oracle Hospitality MICROS POS and USALI departmental reporting. SSOT: defers to property.property_outlet (MVM). [SSOT_OWNER] [SSOT:outlet] Canonical single-source-of-truth for the outlet concept; other domain variants are domain-specific specializations referencing this owner. SSOT: defers to canonical property.property_outlet (MVM cross-domain dedup).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` (
    `menu_id` BIGINT COMMENT 'Unique identifier for the menu. Primary key.',
    `fnb_outlet_id` BIGINT COMMENT 'Reference to the Food and Beverage (F&B) outlet where this menu is offered (restaurant, bar, room service, banquet facility).',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the menu is currently active and available for ordering (True) or inactive (False). Used for operational control in Point of Sale (POS) systems.',
    `allergen_information` STRING COMMENT 'Allergen disclosure and warning information for the menu. Required for ISO 22000 food safety compliance and guest health protection.',
    `approved_date` DATE COMMENT 'Date when the menu was approved for service. Part of menu lifecycle audit trail.',
    `beverage_description` STRING COMMENT 'Description of included beverages for package menus (e.g., Unlimited coffee, tea, and soft drinks, House wine and beer for 2 hours, Premium open bar).',
    `beverage_inclusion_flag` BOOLEAN COMMENT 'Indicates whether beverages are included in the menu package price (True) or charged separately (False). Critical for banquet and catering packages.',
    `menu_code` STRING COMMENT 'Unique business identifier or code for the menu used in Oracle Hospitality MICROS Point of Sale (POS) and Delphi by Amadeus systems for menu lookup and event quoting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `course_count` STRING COMMENT 'Number of courses included in prix fixe, tasting, and banquet menus (e.g., 3-course, 5-course, 7-course).',
    `course_description` STRING COMMENT 'Detailed description of the courses included in the menu (e.g., Appetizer, Soup, Salad, Entrée, Dessert). Used in Banquet Event Order (BEO) documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the menu record was first created in the system. Part of audit trail for menu lifecycle management.',
    `cuisine_type` STRING COMMENT 'The culinary style or cuisine category of the menu (e.g., Italian, French, Contemporary American, Asian Fusion, Mediterranean). [ENUM-REF-CANDIDATE: italian|french|american|asian|mediterranean|latin|middle_eastern|fusion|international — promote to reference product]',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for menu pricing (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `menu_description` STRING COMMENT 'Detailed marketing description of the menu, its theme, culinary style, and guest experience positioning. Used in event sales materials and guest-facing communications.',
    `dietary_options` STRING COMMENT 'Available dietary accommodations and special menu options (e.g., Vegetarian, Vegan, Gluten-Free, Kosher, Halal available upon request). Critical for ADA (Americans with Disabilities Act) compliance and guest satisfaction.',
    `effective_end_date` DATE COMMENT 'The date when this menu is no longer available. Nullable for permanent menus. Supports seasonal menu rotation and limited-time offers.',
    `effective_start_date` DATE COMMENT 'The date when this menu becomes active and available for ordering. Supports seasonal menu rotation and promotional menu campaigns.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the menu record was last updated. Supports change tracking and menu version control.',
    `maximum_capacity` STRING COMMENT 'Maximum number of guests that can be served with this menu configuration, constrained by kitchen capacity and service standards.',
    `meal_period` STRING COMMENT 'The meal period or daypart when this menu is available. [ENUM-REF-CANDIDATE: breakfast|brunch|lunch|dinner|all_day|afternoon_tea|late_night|happy_hour — promote to reference product]. Valid values are `breakfast|brunch|lunch|dinner|all_day|afternoon_tea`',
    `menu_status` STRING COMMENT 'Current lifecycle status of the menu indicating availability and operational state.. Valid values are `active|inactive|draft|archived|seasonal|pending_approval`',
    `menu_type` STRING COMMENT 'Classification of the menu format and service style. [ENUM-REF-CANDIDATE: a_la_carte|prix_fixe|buffet|banquet_package|coffee_break|cocktail_reception|wedding_package|tasting_menu|seasonal_menu|promotional_menu — promote to reference product]. Valid values are `a_la_carte|prix_fixe|buffet|banquet_package|coffee_break|cocktail_reception`',
    `minimum_guarantee` STRING COMMENT 'Minimum number of guests required for banquet packages and group menus. Used in Banquet Event Order (BEO) generation and event sales quoting in Delphi by Amadeus.',
    `menu_name` STRING COMMENT 'Human-readable name of the menu (e.g., Spring Dinner Menu, Executive Lunch, Wedding Gold Package, Coffee Break Premium).',
    `notes` STRING COMMENT 'Additional operational notes, special instructions, or internal comments about the menu for staff reference.',
    `per_person_price` DECIMAL(18,2) COMMENT 'The price per person for banquet packages, coffee breaks, cocktail receptions, and other per-guest priced menus. Null for à la carte menus where items are individually priced.',
    `preparation_lead_time_hours` STRING COMMENT 'Minimum advance notice required in hours for kitchen preparation and ingredient procurement. Used in event sales quoting and reservation acceptance rules.',
    `pricing_tier` STRING COMMENT 'The pricing category or tier of this menu, used for revenue management and market positioning.. Valid values are `standard|premium|luxury|budget|promotional|seasonal`',
    `print_sequence` STRING COMMENT 'Display order sequence for menu presentation in Oracle Hospitality MICROS POS, printed materials, and digital menu boards.',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this menu is part of a limited-time promotional campaign (True) or a standard offering (False). Used for marketing analytics and revenue management.',
    `seasonal_flag` BOOLEAN COMMENT 'Indicates whether this is a seasonal menu (True) with limited availability based on ingredient seasonality and market demand, or a year-round menu (False).',
    `service_charge_inclusive_flag` BOOLEAN COMMENT 'Indicates whether the menu price includes service charges or gratuity (True) or these are added separately (False). Important for banquet and catering pricing transparency.',
    `service_style` STRING COMMENT 'The method of food service delivery for this menu. Critical for labor planning and guest experience management.. Valid values are `plated|buffet|family_style|stations|passed|self_service`',
    `setup_requirements` STRING COMMENT 'Physical setup and service requirements for the menu (e.g., Buffet stations with chafing dishes, Plated service with white glove, Family-style service). Used in Banquet Event Order (BEO) planning.',
    `target_guest_segment` STRING COMMENT 'The primary guest segment this menu is designed for (e.g., Corporate Groups, Wedding Parties, Leisure Travelers, VIP Guests, MICE (Meetings Incentives Conferences Exhibitions) Attendees).',
    `tax_inclusive_flag` BOOLEAN COMMENT 'Indicates whether the menu price includes applicable taxes (True) or taxes are added at Point of Sale (POS) (False). Critical for revenue recognition and guest billing transparency.',
    `version_number` STRING COMMENT 'Version number for menu lifecycle management and change tracking. Incremented with each menu revision to support outlet-level menu versioning.',
    CONSTRAINT pk_menu PRIMARY KEY(`menu_id`)
) COMMENT 'Master catalog of all menus offered across F&B outlets, banquet operations, and catering services. Covers restaurant menus, bar menus, room service menus, banquet menu packages, seasonal/promotional menus, coffee break packages, cocktail reception packages, and wedding packages. Tracks menu name, menu type (à la carte, prix fixe, buffet, banquet package, coffee break, cocktail reception, wedding package, tasting menu), effective date range, outlet assignment, meal period, pricing tier, per-person price (for banquet/catering packages), minimum guarantee, beverage inclusions, included courses, setup requirements, validity period, and active/inactive status. Supports menu lifecycle management, outlet-level menu versioning, event sales quoting in Delphi by Amadeus, and BEO generation for group events.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` (
    `menu_item_id` BIGINT COMMENT 'Unique identifier for the menu item. Primary key.',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key reference to the primary Food and Beverage (F&B) outlet where this menu item is offered. A menu item may be available at multiple outlets, but this represents the primary or originating outlet.',
    `menu_id` BIGINT COMMENT 'Foreign key linking to fnb.menu. Business justification: CRITICAL MISSING LINK. Menu items must belong to specific menus for proper menu management. Currently menu_item links to outlet but not to menu. This FK enables menu versioning, seasonal menu changes,',
    `recipe_id` BIGINT COMMENT 'Foreign key reference to the standardized recipe used to prepare this menu item. Links to detailed ingredient lists, preparation instructions, and cost breakdowns for kitchen operations and cost control.',
    `alcohol_content_percent` DECIMAL(18,2) COMMENT 'The alcohol by volume (ABV) percentage for alcoholic beverages. Required for regulatory compliance and responsible service of alcohol programs.',
    `allergen_flags` STRING COMMENT 'Comma-separated list of major allergens present in the menu item (e.g., dairy, eggs, fish, shellfish, tree nuts, peanuts, wheat, soy, sesame). Critical for guest safety and regulatory compliance.',
    `calorie_count` STRING COMMENT 'The total caloric content per standard portion. Required for nutritional disclosure compliance in many jurisdictions and increasingly expected by health-conscious guests.',
    `cost_price` DECIMAL(18,2) COMMENT 'The standard cost to produce one unit of this menu item, including ingredients, labor, and direct overhead. Used for food cost percentage calculation and Gross Operating Profit (GOP) analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this menu item record was first created in the system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard price and cost price (e.g., USD, EUR, GBP). Required for multi-property operations across different countries.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date when this menu item is no longer available for sale. Null for items with no planned end date. Used for menu rotations and limited-time offers.',
    `effective_start_date` DATE COMMENT 'The date when this menu item becomes available for sale. Used for menu launches, seasonal transitions, and promotional campaigns.',
    `food_safety_classification` STRING COMMENT 'Risk classification for food safety management based on ISO 22000 standards. High-risk items (e.g., raw seafood, undercooked eggs) require enhanced handling protocols and temperature monitoring.. Valid values are `low_risk|medium_risk|high_risk`',
    `gross_margin_percent` DECIMAL(18,2) COMMENT 'The gross profit margin percentage calculated as (standard_price - cost_price) / standard_price * 100. Key metric for menu engineering and profitability analysis.',
    `is_alcoholic` BOOLEAN COMMENT 'Indicates whether the menu item contains alcohol. Used for age verification requirements, licensing compliance, and separate revenue tracking per USALI standards.',
    `is_available_banquet` BOOLEAN COMMENT 'Indicates whether this menu item is available for banquet, catering, and group event menus. Used for Banquet Event Order (BEO) planning and MICE (Meetings Incentives Conferences Exhibitions) operations.',
    `is_available_room_service` BOOLEAN COMMENT 'Indicates whether this menu item is available for in-room dining / room service orders. Some items may be outlet-only due to preparation complexity or presentation requirements.',
    `is_gluten_free` BOOLEAN COMMENT 'Indicates whether the menu item is free from gluten-containing ingredients. Critical for guests with celiac disease or gluten sensitivity.',
    `is_halal` BOOLEAN COMMENT 'Indicates whether the menu item meets halal dietary requirements according to Islamic law. Important for properties serving Muslim guests.',
    `is_kosher` BOOLEAN COMMENT 'Indicates whether the menu item meets kosher dietary requirements according to Jewish law. Important for properties serving Jewish guests.',
    `is_seasonal` BOOLEAN COMMENT 'Indicates whether this menu item is only available during specific seasons or time periods. Used for menu planning and inventory management.',
    `is_signature_item` BOOLEAN COMMENT 'Indicates whether this menu item is designated as a signature or specialty item that represents the property or outlets culinary identity. Used for marketing, menu engineering, and upselling strategies.',
    `is_vegan` BOOLEAN COMMENT 'Indicates whether the menu item is suitable for vegan diets (contains no animal products or by-products). Used for dietary filtering and guest preference matching.',
    `is_vegetarian` BOOLEAN COMMENT 'Indicates whether the menu item is suitable for vegetarian diets (contains no meat or fish but may contain dairy or eggs). Used for dietary filtering and guest preference matching.',
    `item_category` STRING COMMENT 'High-level classification of the menu item distinguishing between food, beverage, modifiers (add-ons), packages, combos, or merchandise.. Valid values are `food|beverage|modifier|package|combo|merchandise`',
    `item_code` STRING COMMENT 'Unique alphanumeric code used to identify the menu item in the Point of Sale (POS) system. This is the externally-known business identifier used by staff and in reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `item_description` STRING COMMENT 'Detailed description of the menu item including ingredients, preparation method, and presentation style. Used for guest communication and staff training.',
    `item_name` STRING COMMENT 'The display name of the menu item as it appears on menus and guest-facing materials.',
    `item_status` STRING COMMENT 'Current lifecycle status of the menu item indicating availability for sale. Active items are currently available, seasonal items are available during specific periods, inactive items are temporarily unavailable, discontinued items are permanently removed, and pending items are awaiting approval.. Valid values are `active|inactive|seasonal|discontinued|pending`',
    `item_subcategory` STRING COMMENT 'Detailed classification within the item category. Examples: appetizer, entrée, dessert, cocktail, wine, beer, non-alcoholic, side dish, condiment. Used for menu organization and sales analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this menu item record was last updated. Used for change tracking and data quality monitoring.',
    `menu_section` STRING COMMENT 'The section or grouping on the menu where this item appears (e.g., Starters, Main Courses, Desserts, Signature Cocktails, Wine List). Used for menu layout and guest navigation.',
    `minimum_age_requirement` STRING COMMENT 'The minimum age required to purchase this menu item, typically applicable to alcoholic beverages. Null for items with no age restriction. Used for Point of Sale (POS) age verification prompts.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this menu item record. Used for accountability and audit purposes.',
    `portion_size` STRING COMMENT 'The standard serving size or portion measurement for the menu item (e.g., 8 oz, 250 ml, 1 piece, serves 2). Used for consistency, cost control, and nutritional disclosure.',
    `preparation_time_minutes` STRING COMMENT 'The standard time in minutes required to prepare and serve this menu item from order placement to guest delivery. Used for kitchen workflow planning and guest expectation management.',
    `revenue_center_code` STRING COMMENT 'The USALI revenue center code to which sales of this menu item are posted for financial reporting. Examples: F&B-REST (Restaurant), F&B-BAR (Bar), F&B-RMSERV (Room Service), F&B-BANQ (Banquet).. Valid values are `^[A-Z0-9]{2,6}$`',
    `seasonal_availability` STRING COMMENT 'Description of when the seasonal item is available (e.g., Summer Menu, Holiday Special, Spring 2024). Null for non-seasonal items.',
    `spice_level` STRING COMMENT 'Indicates the heat or spiciness level of the menu item. Used for guest preference matching and expectation setting.. Valid values are `none|mild|medium|hot|extra_hot`',
    `standard_price` DECIMAL(18,2) COMMENT 'The standard selling price of the menu item before any discounts, promotions, or service charges. This is the base price used for revenue calculation and Average Daily Rate (ADR) contribution analysis.',
    `tax_category` STRING COMMENT 'The tax classification for this menu item determining applicable sales tax, VAT, or GST rates. Categories vary by jurisdiction (e.g., food, alcohol, non-alcoholic beverage, prepared food, grocery).',
    CONSTRAINT pk_menu_item PRIMARY KEY(`menu_item_id`)
) COMMENT 'Individual food and beverage items available for sale across all outlets and menus. Captures item name, item category (food/beverage/modifier), sub-category (appetizer, entrée, dessert, cocktail, wine, beer, non-alcoholic), menu section, standard selling price, cost price, gross margin, allergen flags, dietary attributes (vegan, gluten-free, halal, kosher), calorie count, portion size, preparation time, and ISO 22000 food safety classification. Linked to recipe for cost control and to MICROS POS item master.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` (
    `recipe_id` BIGINT COMMENT 'Unique identifier for the recipe. Primary key.',
    `fnb_outlet_id` BIGINT COMMENT 'Reference to the primary F&B outlet where this recipe is prepared and served. Links to property_outlet master data.',
    `allergen_information` STRING COMMENT 'Comprehensive list of allergens present in this recipe (e.g., Contains: milk, eggs, tree nuts, shellfish). Critical for guest safety, menu labeling compliance, and service staff training.',
    `ccp_details` STRING COMMENT 'Detailed description of ISO 22000 Critical Control Points in this recipe, including monitoring procedures, critical limits, corrective actions, and verification steps. Essential for food safety compliance and audit readiness.',
    `chef_notes` STRING COMMENT 'Additional notes, tips, or special instructions from the executive chef. May include substitution options, quality standards, or presentation variations.',
    `recipe_code` STRING COMMENT 'Externally-known unique alphanumeric code for the recipe, used across Oracle Hospitality MICROS POS and kitchen systems for item lookup and ordering.. Valid values are `^[A-Z0-9]{6,12}$`',
    `cooking_instructions` STRING COMMENT 'Specific cooking instructions including equipment, temperatures, techniques, and quality checkpoints. Supports standardization and training of kitchen staff.',
    `cooking_time_minutes` STRING COMMENT 'Standard time in minutes required to cook or finish the recipe. Critical for kitchen capacity planning, guest wait time estimation, and service flow management.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all cost amounts in this recipe (e.g., USD, EUR, GBP). Supports multi-currency operations and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipe record was first created in the system. Audit trail for data governance and compliance.',
    `cuisine_type` STRING COMMENT 'Culinary style or regional cuisine classification (e.g., Italian, Asian Fusion, Contemporary American). Supports menu diversity analysis and guest preference tracking.',
    `dietary_attributes` STRING COMMENT 'Dietary classifications and attributes (e.g., vegetarian, vegan, gluten-free, dairy-free, halal, kosher). Supports menu filtering, guest preference matching, and inclusive dining experiences.',
    `effective_date` DATE COMMENT 'Date when this recipe version became active and available for use. Supports historical costing and menu change tracking.',
    `expiration_date` DATE COMMENT 'Date when this recipe version was superseded or discontinued. Null for currently active recipes. Supports historical analysis and audit trails.',
    `haccp_hazard_analysis` STRING COMMENT 'Documented hazard analysis identifying biological, chemical, and physical hazards associated with this recipe. Required for HACCP compliance and food safety management.',
    `iso_22000_ccp_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this recipe contains one or more ISO 22000 Critical Control Points requiring food safety monitoring and documentation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipe record was last updated. Supports change tracking and data quality monitoring.',
    `recipe_name` STRING COMMENT 'Human-readable name of the recipe as it appears on menus and in kitchen systems (e.g., Grilled Atlantic Salmon, Signature Chocolate Lava Cake).',
    `nutritional_calories` STRING COMMENT 'Total calories per standard portion. Required for menu labeling compliance in many jurisdictions and supports wellness-focused guest preferences.',
    `nutritional_carbohydrate_grams` DECIMAL(18,2) COMMENT 'Total carbohydrate content in grams per standard portion. Supports dietary planning and menu labeling compliance.',
    `nutritional_fat_grams` DECIMAL(18,2) COMMENT 'Total fat content in grams per standard portion. Required for nutritional labeling and dietary analysis.',
    `nutritional_protein_grams` DECIMAL(18,2) COMMENT 'Protein content in grams per standard portion. Supports nutritional transparency and wellness program requirements.',
    `nutritional_sodium_milligrams` STRING COMMENT 'Sodium content in milligrams per standard portion. Critical for health-conscious guests and dietary restriction management.',
    `plating_instructions` STRING COMMENT 'Detailed instructions for plating and presentation, including garnish placement, portion arrangement, and visual standards. Ensures brand consistency and guest experience quality.',
    `portion_size_unit` STRING COMMENT 'Unit of measure for the standard portion size (e.g., ounce, gram, milliliter). Ensures consistency in portioning and cost calculation.. Valid values are `ounce|gram|milliliter|piece|slice|cup`',
    `preparation_method` STRING COMMENT 'Detailed step-by-step instructions for preparing the recipe, including ingredient handling, cooking techniques, temperatures, and timing. Ensures consistency and quality across all outlets.',
    `preparation_time_minutes` STRING COMMENT 'Standard time in minutes required to prepare ingredients before cooking (e.g., chopping, marinating, mixing). Used for kitchen labor planning and workflow optimization.',
    `recipe_status` STRING COMMENT 'Current lifecycle status of the recipe. Active recipes are available for service; seasonal recipes are available during specific periods; testing recipes are in development; discontinued recipes are archived.. Valid values are `active|inactive|seasonal|discontinued|testing`',
    `recipe_type` STRING COMMENT 'Classification of the recipe by menu category or preparation type. Supports menu engineering and F&B departmental reporting per USALI standards. [ENUM-REF-CANDIDATE: appetizer|entree|dessert|beverage|side|sauce|garnish|base_prep — 8 candidates stripped; promote to reference product]',
    `seasonal_availability` STRING COMMENT 'Seasonal availability window for this recipe (e.g., Summer Menu June-August, Holiday Special December, Year-Round). Supports menu planning and ingredient procurement.',
    `shelf_life_hours` STRING COMMENT 'Maximum time in hours that the prepared recipe can be safely held before service or disposal. Critical for food safety, waste management, and batch production planning.',
    `skill_level_required` STRING COMMENT 'The culinary skill level required to execute this recipe consistently (basic, intermediate, advanced, expert). Used for staff assignment, training planning, and labor scheduling.. Valid values are `basic|intermediate|advanced|expert`',
    `standard_beverage_cost_per_portion` DECIMAL(18,2) COMMENT 'The calculated cost of beverage ingredients (wine, spirits, mixers) required to produce one standard portion. Applicable to beverage recipes and cocktails. Supports beverage cost percentage tracking.',
    `standard_food_cost_per_portion` DECIMAL(18,2) COMMENT 'The calculated cost of ingredients required to produce one standard portion of this recipe. Foundation for menu pricing, food cost percentage analysis, and GOP calculation per USALI standards.',
    `standard_portion_size` DECIMAL(18,2) COMMENT 'The standard serving size per portion in the specified unit of measure. Critical for portion control, cost consistency, and nutritional labeling compliance.',
    `storage_instructions` STRING COMMENT 'Proper storage requirements for prepared recipe or components, including temperature range, container type, and maximum hold time. Critical for food safety and quality maintenance.',
    `total_recipe_cost` DECIMAL(18,2) COMMENT 'The total cost to produce the full recipe yield (all portions). Calculated as sum of all ingredient costs. Used for batch costing and procurement planning.',
    `total_time_minutes` STRING COMMENT 'Total time in minutes from start to finish, including preparation, cooking, and plating. Used for kitchen scheduling and service time commitments.',
    `version_number` STRING COMMENT 'Version number of this recipe specification. Incremented when recipe is modified. Supports change tracking and historical cost analysis.',
    `yield_quantity` DECIMAL(18,2) COMMENT 'The number of portions or servings this recipe produces when prepared according to standard method. Used for portion cost calculation and inventory planning.',
    `yield_unit_of_measure` STRING COMMENT 'Unit of measure for the recipe yield quantity (e.g., portion, ounce, liter). Standardizes recipe costing and inventory consumption tracking. [ENUM-REF-CANDIDATE: portion|serving|ounce|gram|liter|milliliter|piece|dozen — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_recipe PRIMARY KEY(`recipe_id`)
) COMMENT 'Standardized recipe master for all food and beverage items, capturing recipe name, yield quantity, unit of measure, preparation method, cooking instructions, plating notes, standard food cost per portion, beverage cost per pour, ingredient list with quantities, and ISO 22000 critical control points (CCPs) for food safety compliance. Enables food cost percentage calculation, variance analysis, and supports procurement planning. Owned by F&B domain as the authoritative source for recipe costing.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` (
    `pos_check_id` BIGINT COMMENT 'Unique identifier for the POS check transaction. Primary key.',
    `beo_id` BIGINT COMMENT 'Foreign key linking to event.beo. Business justification: POS checks generated during banquet event execution must be reconciled against the BEO for actual vs. estimated revenue reporting and billing. This link is essential for event post-con reporting, attr',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: Corporate accounts have direct billing arrangements for F&B charges at outlets and restaurants. Required for AR posting, credit limit enforcement, contracted discount application, and monthly corporat',
    `event_booking_id` BIGINT COMMENT 'Foreign key linking to event.event_booking. Business justification: F&B charges incurred during an event (receptions, breaks, dinners) are posted to the event bookings master account. This link enables total event F&B spend tracking, contracted F&B minimum compliance',
    `fnb_outlet_id` BIGINT COMMENT 'Identifier of the F&B outlet where the check was opened (restaurant, bar, room service, poolside, etc.).',
    `profile_id` BIGINT COMMENT 'Identifier of the guest profile if the guest is a registered hotel guest or loyalty member. Null for walk-in non-registered guests.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Core loyalty points earning process: F&B transactions post points to member accounts. pos_check.loyalty_points_earned exists, requiring direct member link for accrual posting, tier validation, and poi',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Banquet and event billing: POS checks generated for meeting/event catering must reference the specific meeting space to enable space-level revenue reporting, master account folio posting, and event pr',
    `property_id` BIGINT COMMENT 'Identifier of the property where the check was opened.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Room service and in-room dining POS checks must link to physical room for folio posting, guest billing integration, housekeeping coordination, and delivery routing. Room_number is denormalized; room_i',
    `package_id` BIGINT COMMENT 'Foreign key linking to spa.package. Business justification: When a guest redeems a spa package that includes F&B dining, the pos_check must reference the spa package for package redemption tracking, cross-domain revenue allocation, and package fulfillment audi',
    `actual_delivery_time` TIMESTAMP COMMENT 'Actual time when the order was delivered to the guest room or delivery address. Used to calculate on-time delivery rate.',
    `business_date` DATE COMMENT 'Business operating date for the check, which may differ from the calendar date for late-night operations. Used for daily revenue reporting.',
    `check_number` STRING COMMENT 'Business-facing check number displayed on guest receipt and used for operational reference.',
    `check_status` STRING COMMENT 'Current lifecycle status of the check. Open: check is active and items can be added. Closed: check has been settled and payment completed. Voided: check has been cancelled. Transferred: check has been moved to another table or server. Suspended: check is temporarily on hold.. Valid values are `open|closed|voided|transferred|suspended`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the check was closed and payment was completed. Null for open or suspended checks.',
    `cover_count` STRING COMMENT 'Number of guests (covers) served on this check. Used to calculate check average and revenue per cover metrics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this check record was first created in the data warehouse. Used for data lineage and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this check.. Valid values are `^[A-Z]{3}$`',
    `delivery_duration_minutes` STRING COMMENT 'Time in minutes from order placement to delivery completion. Key performance indicator for room service operations.',
    `delivery_status` STRING COMMENT 'Current status of room service or delivery order fulfillment. Tracks order through kitchen preparation and delivery workflow.. Valid values are `received|in-preparation|dispatched|delivered|cancelled`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the check including promotional discounts, employee discounts, and manager comps.',
    `folio_reference_number` STRING COMMENT 'Reference number of the guest folio in the PMS where this check was posted. Used for reconciliation between POS and PMS systems.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the guest for this F&B transaction. Null if guest is not a loyalty member.',
    `manager_approval_required` BOOLEAN COMMENT 'Indicates whether this check required manager approval due to discounts, voids, or policy exceptions.',
    `meal_period` STRING COMMENT 'Meal period or daypart during which the check was opened. Used for revenue analysis by daypart and menu engineering. [ENUM-REF-CANDIDATE: breakfast|brunch|lunch|afternoon-tea|dinner|late-night|all-day — 7 candidates stripped; promote to reference product]',
    `opened_timestamp` TIMESTAMP COMMENT 'Date and time when the check was first opened in the POS system. Represents the start of the guest dining experience.',
    `order_source` STRING COMMENT 'Channel or interface through which the order was placed. Particularly relevant for room service and delivery orders.. Valid values are `phone|in-room-tablet|mobile-app|walk-in|kiosk|web`',
    `order_type` STRING COMMENT 'Type of service channel through which the order was placed. Dine-in: guest seated at table. Bar: bar service. Room Service: in-room dining. Takeaway: guest pickup. Delivery: off-premise delivery. Poolside: pool or beach service. Banquet: event service. Catering: catered function. [ENUM-REF-CANDIDATE: dine-in|bar|room-service|takeaway|delivery|poolside|banquet|catering — 8 candidates stripped; promote to reference product]',
    `payment_method` STRING COMMENT 'Primary payment method used to settle the check. Room-charge: posted to guest folio. Comp: complimentary/no charge. [ENUM-REF-CANDIDATE: cash|credit-card|debit-card|room-charge|gift-card|mobile-payment|comp — 7 candidates stripped; promote to reference product]',
    `pos_terminal_code` STRING COMMENT 'Identifier of the POS terminal or workstation where the check was processed. Used for system reconciliation and troubleshooting.',
    `requested_delivery_time` TIMESTAMP COMMENT 'Guest-requested delivery time for room service or delivery orders. Null for dine-in and immediate service orders.',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Mandatory service charge or gratuity added to the check, typically for large parties or banquet events. Distinct from discretionary tips.',
    `service_duration_minutes` STRING COMMENT 'Total duration in minutes from check open to check close. Used to analyze table turn time and service efficiency.',
    `special_instructions` STRING COMMENT 'Guest special requests or dietary instructions for the order. Examples: no nuts, extra spicy, gluten-free preparation.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all menu item charges before discounts, service charges, and taxes. Base revenue amount.',
    `table_number` STRING COMMENT 'Table number or service location identifier where the guest was seated. Null for room service, takeaway, and delivery orders.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the check including sales tax, VAT, GST, or other applicable taxes per jurisdiction.',
    `tender_amount` DECIMAL(18,2) COMMENT 'Amount tendered by the guest for payment. May exceed total_amount if change is due.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Discretionary gratuity amount added by the guest. Used for tip pooling and server compensation tracking.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount due including subtotal, service charges, taxes, minus discounts. Amount presented to guest for payment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this check record was last modified in the data warehouse. Used for change tracking and incremental processing.',
    `void_reason` STRING COMMENT 'Reason code or description for why the check was voided. Required for audit trail and revenue reconciliation. Null for non-voided checks.',
    CONSTRAINT pk_pos_check PRIMARY KEY(`pos_check_id`)
) COMMENT 'Core POS transaction record representing a guest check opened at any F&B outlet or service channel including dine-in, bar, room service, takeaway, delivery, and poolside. Captures check number, outlet, table, server, cover count, open/close timestamps, status (open, closed, voided, transferred), meal period, order type (dine-in, bar, room service, takeaway, delivery, poolside), subtotal, discounts, service charge, tax, total, payment method, tender amount, tip, and PMS folio posting reference. For room service orders: guest room number, requested delivery time, actual delivery time, delivery duration (minutes), order source (phone, in-room tablet, mobile app), and delivery status (received, in-preparation, dispatched, delivered, cancelled). Supports room service operational KPIs including on-time delivery rate and average delivery time. Primary transactional entity sourced from Oracle Hospitality MICROS POS. Single source of truth for all F&B guest orders regardless of service channel.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` (
    `pos_check_line_id` BIGINT COMMENT 'Unique identifier for the POS check line item. Primary key for this transaction line entity.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.promotion. Business justification: Item-level loyalty promotions: "earn 3x points on breakfast items" or "bonus 500 points on wine purchases over $100". Business process: promotion qualification tracking, bonus points calculation at li',
    `menu_item_id` BIGINT COMMENT 'Reference to the menu item master record that was ordered on this line. Links to menu item catalog for recipe, cost, and category information.',
    `parent_line_pos_check_line_id` BIGINT COMMENT 'Reference to another line item that this line is a modifier or add-on for. Null for standalone items. Enables hierarchical line item relationships for complex orders.',
    `pos_check_id` BIGINT COMMENT 'Reference to the parent POS check (guest check) that contains this line item. Links line to header transaction.',
    `cost_of_sales` DECIMAL(18,2) COMMENT 'Standard recipe cost for this line item based on ingredient costs at time of sale. Used for food cost percentage calculation and gross profit analysis. Business-confidential financial data.',
    `course_number` STRING COMMENT 'Course sequence indicator for multi-course dining. Determines kitchen firing order and service timing. Common values: 1=appetizer, 2=entree, 3=dessert.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this line item record was first created in the POS system. Represents the moment the item was ordered by the guest or server.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line. Supports multi-currency operations and foreign exchange tracking.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this line item. Includes promotional discounts, employee discounts, manager comps, and loyalty redemptions.',
    `family_group_code` STRING COMMENT 'Mid-level menu category classification within major group. Examples: appetizers, entrees, desserts, wine, beer, spirits. Enables detailed menu mix reporting.',
    `is_complimentary` BOOLEAN COMMENT 'Indicates whether this line item was provided as a complimentary item (no charge to guest). True for comps, false for paid items. Used for cost tracking and guest recovery analysis.',
    `is_inclusive_tax` BOOLEAN COMMENT 'Indicates whether tax is included in the unit price (true) or added separately (false). Varies by jurisdiction and pricing strategy.',
    `is_open_item` BOOLEAN COMMENT 'Indicates whether this line was entered as an open-priced item where the server manually entered the price rather than selecting from menu. Used for special items and manager overrides.',
    `is_voided` BOOLEAN COMMENT 'Indicates whether this line item was voided after being ordered. True if voided, false if active. Voided lines are excluded from revenue but tracked for audit and waste analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this line item record was last updated. Tracks modifications such as quantity changes, price adjustments, or void actions.',
    `line_sequence_number` STRING COMMENT 'Sequential ordering of this line item within the parent check. Determines display and printing order.',
    `line_subtotal_amount` DECIMAL(18,2) COMMENT 'Extended amount for this line calculated as quantity multiplied by unit price, before discounts and taxes. Base revenue for the line item.',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Final total amount for this line item including all charges, discounts, taxes, and service charges. Net revenue contribution from this line.',
    `major_group_code` STRING COMMENT 'High-level menu category classification for this item. Examples: food, beverage, alcohol, non-alcohol. Used for USALI departmental reporting and revenue mix analysis.',
    `modifier_text` STRING COMMENT 'Free-form text capturing cooking instructions, preparation preferences, add-ons, substitutions, and removals for this menu item. Examples: no onions, extra cheese, well done, gluten-free bun.',
    `preparation_time_minutes` STRING COMMENT 'Standard kitchen preparation time for this menu item in minutes. Used for kitchen capacity planning and guest wait time estimation.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Number of units of this menu item ordered on this line. Supports fractional quantities for items sold by weight or partial portions.',
    `seat_number` STRING COMMENT 'Seat position at the table for this line item. Enables per-guest ordering and split-check processing. Used in full-service restaurant operations.',
    `sent_to_kitchen_timestamp` TIMESTAMP COMMENT 'Date and time when this line item order was transmitted to the kitchen display system or printed to kitchen printer. Marks start of preparation cycle.',
    `served_timestamp` TIMESTAMP COMMENT 'Date and time when this item was marked as served to the guest. Used for service time analysis and kitchen performance measurement.',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Mandatory service charge or gratuity applied to this line item. Common for banquet events, room service, and large party dining.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on this line item. Includes sales tax, VAT, GST, or other applicable consumption taxes based on jurisdiction and item taxability.',
    `unit_price` DECIMAL(18,2) COMMENT 'Selling price per unit of the menu item at the time of order. Reflects the base price before modifiers, discounts, or service charges.',
    `void_reason_code` STRING COMMENT 'Code identifying the reason this line item was voided. Examples: guest changed mind, kitchen error, wrong item entered, quality issue. Required when is_voided is true.',
    `void_timestamp` TIMESTAMP COMMENT 'Date and time when this line item was voided. Null if not voided. Used for void pattern analysis and operational controls.',
    CONSTRAINT pk_pos_check_line PRIMARY KEY(`pos_check_line_id`)
) COMMENT 'Line-item detail for each POS check, capturing the individual menu items ordered within a guest check. Records menu item reference, quantity ordered, unit selling price, line total, discount applied, modifier details (cooking instructions, add-ons, removals), course sequence, void flag, void reason, seat number, and item-level tax. Enables per-item revenue analysis, food cost matching, and menu item performance reporting. Sourced from Oracle Hospitality MICROS POS.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` (
    `room_service_order_id` BIGINT COMMENT 'Unique identifier for the room service order. Primary key.',
    `fnb_outlet_id` BIGINT COMMENT 'Reference to the Food and Beverage (F&B) outlet fulfilling the room service order.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile who placed the room service order.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Points accrual for room service spend requires linking the order to the loyalty member account. room_service_order.loyalty_member_number is a denormalized text field; replacing with a proper FK enable',
    `pos_check_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check. Business justification: Room service orders generate POS checks for billing and revenue recognition. Currently room_service_order has pos_check_number as STRING but no FK to pos_check. Normalizing enables accurate revenue re',
    `property_id` BIGINT COMMENT 'Reference to the property where the room service order was placed.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the guest reservation associated with this room service order.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Room service delivery requires physical room link for order routing, access control verification, delivery confirmation, and integration with property management system for guest billing. Room_number ',
    `actual_delivery_time` TIMESTAMP COMMENT 'Date and time when the order was actually delivered to the guest room. Used to calculate on-time delivery performance.',
    `business_date` DATE COMMENT 'Business date (hotel operating day) on which the order is recorded for financial reporting purposes. May differ from order timestamp for late-night orders.',
    `cancellation_reason` STRING COMMENT 'Reason provided for order cancellation if status is cancelled. Used for service recovery and operational analysis.',
    `cover_count` STRING COMMENT 'Number of guests (covers) the order is intended to serve. Used for F&B revenue per cover analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the room service order record was first created in the database.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this order.. Valid values are `^[A-Z]{3}$`',
    `delivery_charge` DECIMAL(18,2) COMMENT 'Fixed or variable fee charged for delivering the order to the guest room.',
    `delivery_duration_minutes` STRING COMMENT 'Total time in minutes from order placement to actual delivery. Key operational KPI for room service efficiency.',
    `dietary_restrictions` STRING COMMENT 'Specific dietary restrictions or allergen information provided by the guest (e.g., gluten-free, nut allergy, vegan).',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the order from promotions, loyalty benefits, or service recovery.',
    `dispatch_time` TIMESTAMP COMMENT 'Date and time when the order left the kitchen for delivery to the guest room.',
    `folio_reference` STRING COMMENT 'Reference to the guest folio in the Property Management System (PMS) where charges are posted.',
    `gratuity_amount` DECIMAL(18,2) COMMENT 'Optional tip or gratuity amount added by the guest for service staff.',
    `guest_feedback_comment` STRING COMMENT 'Free-text feedback or comments provided by the guest about the room service experience.',
    `guest_satisfaction_rating` STRING COMMENT 'Guest-provided satisfaction rating for the room service experience, typically on a scale of 1-5 or 1-10.',
    `is_vip_guest` BOOLEAN COMMENT 'Boolean indicator whether the order is for a VIP guest requiring special handling or priority service.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the room service order record was last updated.',
    `on_time_delivery_flag` BOOLEAN COMMENT 'Boolean indicator whether the order was delivered within the promised or standard delivery timeframe. Key operational KPI.',
    `order_number` STRING COMMENT 'Business-facing order number displayed to guests and staff for tracking and reference.',
    `order_source` STRING COMMENT 'Channel or interface through which the guest placed the room service order.. Valid values are `phone|in-room-tablet|mobile-app|front-desk|concierge`',
    `order_status` STRING COMMENT 'Current lifecycle status of the room service order tracking its progression from placement to fulfillment.. Valid values are `received|in-preparation|dispatched|delivered|cancelled|rejected`',
    `order_timestamp` TIMESTAMP COMMENT 'Date and time when the guest placed the room service order. Primary business event timestamp.',
    `payment_method` STRING COMMENT 'Method of payment used for the room service order.. Valid values are `room-charge|credit-card|cash|loyalty-points|comp`',
    `preparation_start_time` TIMESTAMP COMMENT 'Date and time when kitchen staff began preparing the order.',
    `requested_delivery_time` TIMESTAMP COMMENT 'Date and time when the guest requested the order to be delivered. May differ from order timestamp for advance orders.',
    `service_charge` DECIMAL(18,2) COMMENT 'Mandatory or optional service charge applied to the order, typically a percentage of subtotal.',
    `special_instructions` STRING COMMENT 'Guest-provided special requests or instructions for order preparation or delivery (e.g., dietary restrictions, delivery instructions).',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Total amount for all food and beverage items before delivery charge, service charge, and tax.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the order including sales tax, VAT, or other applicable taxes.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount charged to the guest including all items, charges, taxes, and gratuity minus discounts.',
    CONSTRAINT pk_room_service_order PRIMARY KEY(`room_service_order_id`)
) COMMENT 'In-room dining order record capturing guest room number, order timestamp, requested delivery time, actual delivery time, delivery duration (minutes), order status (received, in-preparation, dispatched, delivered, cancelled), order source (phone, in-room tablet, mobile app), cover count, subtotal, delivery charge, service charge, tax, total, and PMS folio posting reference. Tracks room service operational KPIs including on-time delivery rate and average delivery time. Sourced from Oracle Hospitality MICROS POS room service module.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` (
    `inventory_item_id` BIGINT COMMENT 'Primary key for inventory_item',
    `alcohol_by_volume_percent` DECIMAL(18,2) COMMENT 'Percentage of alcohol content by volume for alcoholic beverages. Required for regulatory reporting and responsible service of alcohol programs.',
    `alcohol_flag` BOOLEAN COMMENT 'Indicates whether the item contains alcohol. Used for regulatory compliance, age verification at POS, and beverage cost tracking.',
    `allergen_flag` BOOLEAN COMMENT 'Indicates whether the item contains or may contain common allergens (dairy, nuts, gluten, shellfish, etc.). Required for guest safety and regulatory compliance.',
    `allergen_types` STRING COMMENT 'Comma-separated list of specific allergens present in the item (e.g., dairy, tree nuts, gluten, soy, eggs, fish, shellfish, peanuts). Used for menu labeling and guest communication.',
    `brand_name` STRING COMMENT 'Manufacturer or brand name of the item (e.g., Coca-Cola, Grey Goose, Sysco). Used for brand-specific reporting and guest preference tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the inventory item record was first created in the system.',
    `current_on_hand_quantity` DECIMAL(18,2) COMMENT 'Real-time quantity of the item currently available in inventory across all storage locations. Updated by receipts, issues, and physical counts.',
    `gluten_free_flag` BOOLEAN COMMENT 'Indicates whether the item is certified gluten-free or naturally contains no gluten. Critical for guests with celiac disease or gluten sensitivity.',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicates whether the item is certified Halal. Required for properties serving Muslim guests and for menu compliance.',
    `iso_food_safety_classification` STRING COMMENT 'Risk classification based on ISO 22000 food safety standards. High-risk items (e.g., raw meat, dairy) require stricter handling and monitoring.. Valid values are `high_risk|medium_risk|low_risk|non_food`',
    `item_category` STRING COMMENT 'Primary classification of the inventory item distinguishing food, beverage, and supply types. Critical for F&B cost accounting and USALI departmental reporting. [ENUM-REF-CANDIDATE: food|beverage|dry_goods|perishable|frozen|alcohol|non_alcohol|dairy|meat|seafood|produce|bakery|condiment|disposable — 14 candidates stripped; promote to reference product]',
    `item_code` STRING COMMENT 'Unique business identifier for the inventory item used across Oracle Hospitality MICROS POS and central F&B stores. Typically alphanumeric SKU or internal catalog number.. Valid values are `^[A-Z0-9]{6,20}$`',
    `item_name` STRING COMMENT 'Full descriptive name of the inventory item as it appears in menus, recipes, and POS systems.',
    `item_status` STRING COMMENT 'Current lifecycle status of the inventory item. Inactive or discontinued items are excluded from ordering and recipe planning.. Valid values are `active|inactive|discontinued|seasonal|pending_approval|out_of_stock`',
    `item_subcategory` STRING COMMENT 'Secondary classification providing granular segmentation within the primary category (e.g., red wine, white wine, spirits under beverage-alcohol).',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicates whether the item is certified Kosher. Required for properties serving Jewish guests and for menu compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the inventory item record was last updated. Used for change tracking and audit trails.',
    `last_physical_count_date` DATE COMMENT 'Date of the most recent physical inventory count for this item. Used for inventory accuracy monitoring and audit compliance.',
    `last_physical_count_quantity` DECIMAL(18,2) COMMENT 'Quantity recorded during the most recent physical inventory count. Used for variance analysis against system on-hand quantity.',
    `last_purchase_cost` DECIMAL(18,2) COMMENT 'Unit cost from the most recent purchase order. Used for cost variance analysis and standard cost updates.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order receipt for this item. Used for supplier performance tracking and inventory aging analysis.',
    `local_sourced_flag` BOOLEAN COMMENT 'Indicates whether the item is sourced from local suppliers within a defined geographic radius. Supports farm-to-table programs and sustainability initiatives.',
    `notes` STRING COMMENT 'Free-text field for additional item information, handling instructions, or special considerations not captured in structured fields.',
    `organic_flag` BOOLEAN COMMENT 'Indicates whether the item is certified organic. Used for menu labeling and sustainability reporting.',
    `package_size` STRING COMMENT 'Size or quantity per package unit (e.g., 750ml bottle, 12-count case, 5kg bag). Used for ordering and yield calculations.',
    `par_level` DECIMAL(18,2) COMMENT 'Target inventory quantity that should be maintained to meet operational demand without overstocking. Used for automated reorder triggers.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Minimum inventory quantity threshold that triggers a purchase requisition or reorder workflow. Calculated based on lead time and consumption rate.',
    `required_storage_temperature_max` DECIMAL(18,2) COMMENT 'Maximum safe storage temperature in Celsius for temperature-controlled items. Exceeding this threshold triggers food safety alerts.',
    `required_storage_temperature_min` DECIMAL(18,2) COMMENT 'Minimum safe storage temperature in Celsius for temperature-controlled items. Used for cold chain monitoring and food safety audits.',
    `shelf_life_days` STRING COMMENT 'Number of days the item remains safe and usable from receipt date. Critical for perishable items and ISO 22000 food safety compliance.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Average unit cost of the item used for inventory valuation and F&B cost calculations. Updated periodically based on purchase history and supplier pricing.',
    `storage_location` STRING COMMENT 'Physical location where the item is stored (e.g., central F&B store, outlet storeroom, walk-in cooler, dry storage, bar). Supports multi-location inventory tracking.',
    `supplier_reference` STRING COMMENT 'Identifier or name of the primary supplier for this item. Links to procurement vendor master for purchase order generation.',
    `tax_category` STRING COMMENT 'Tax classification code used to determine applicable tax rates and exemptions (e.g., food, beverage, alcohol). Varies by jurisdiction.',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether the item is subject to sales tax when sold through F&B outlets. Drives POS tax calculation logic.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the item requires refrigeration or freezing to maintain safety and quality. Drives storage location assignment and handling procedures.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the item is stocked, ordered, and issued. Used for inventory valuation and recipe costing. [ENUM-REF-CANDIDATE: each|case|bottle|liter|kilogram|pound|ounce|gallon|dozen|box|bag|can|jar — 13 candidates stripped; promote to reference product]',
    `vegan_flag` BOOLEAN COMMENT 'Indicates whether the item contains no animal products or by-products. Used for menu labeling and dietary preference tracking.',
    `vendor_item_code` STRING COMMENT 'Suppliers unique identifier for this item. Used for purchase order line item matching and invoice reconciliation.',
    `yield_percent` DECIMAL(18,2) COMMENT 'Percentage of usable product after preparation and waste (e.g., 75% yield for whole fish after filleting). Used for accurate recipe costing.',
    CONSTRAINT pk_inventory_item PRIMARY KEY(`inventory_item_id`)
) COMMENT 'F&B-specific inventory item master tracking food and beverage stock items held in outlet storerooms and central F&B stores. Captures item name, item category (food, beverage, dry goods, perishable, frozen, alcohol), unit of measure, par level, reorder point, standard cost, current on-hand quantity, storage location, supplier reference, shelf life, and ISO 22000 food safety classification (allergen, temperature-controlled). Distinct from the procurement domains general inventory as this is F&B-specific with food safety attributes.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` (
    `stock_transaction_id` BIGINT COMMENT 'Primary key for stock_transaction',
    `beo_id` BIGINT COMMENT 'Foreign key linking to event.beo. Business justification: Inventory consumption triggered by BEO execution must be attributed to the specific banquet event for food cost analysis, waste tracking, and event profitability reporting. This link enables event-lev',
    `fnb_outlet_id` BIGINT COMMENT 'Identifier of the destination location (outlet or storeroom) to which the item was moved. Null for waste/spoilage transactions.',
    `inventory_item_id` BIGINT COMMENT 'Identifier of the inventory item involved in the transaction.',
    `original_transaction_stock_transaction_id` BIGINT COMMENT 'Reference to the original transaction ID if this is a reversal or correction transaction. Null for original transactions.',
    `pos_check_id` BIGINT COMMENT 'Reference to the POS transaction ID for end-of-day consumption or issue-to-outlet transactions linked to sales. Null for non-POS-linked transactions.',
    `primary_stock_fnb_outlet_id` BIGINT COMMENT 'Identifier of the F&B outlet or storeroom involved in the transaction.',
    `property_id` BIGINT COMMENT 'Identifier of the property where the stock transaction occurred.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to fnb.recipe. Business justification: Stock transactions for recipe production/consumption need to reference the recipe being prepared. When kitchen prepares a recipe, ingredients are consumed (stock transaction type = recipe_consumption',
    `room_amenity_id` BIGINT COMMENT 'Foreign key linking to inventory.room_amenity. Business justification: Minibar restocking generates F&B stock transactions tied to specific room amenity records. This link enables per-room minibar consumption tracking, cost allocation, variance reporting, and housekeepin',
    `batch_number` STRING COMMENT 'Batch or lot number of the item for traceability and food safety compliance.',
    `corrective_action_notes` STRING COMMENT 'Notes describing corrective actions taken or planned in response to waste or spoilage events. Null for non-waste transactions.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the transaction cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'Expiration or best-before date of the item batch, used for stock rotation and waste prevention.',
    `invoice_number` STRING COMMENT 'Vendor invoice number for receipt transactions. Null for non-receipt transactions.',
    `meal_period` STRING COMMENT 'Meal period during which the transaction occurred (breakfast, lunch, dinner, all-day, banquet, room service). Primarily used for waste tracking and consumption analysis.. Valid values are `breakfast|lunch|dinner|all_day|banquet|room_service`',
    `notes` STRING COMMENT 'Additional notes or comments about the transaction for operational reference.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the item involved in the transaction, expressed in the items unit of measure.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last updated in the data platform.',
    `reversal_reason` STRING COMMENT 'Reason for reversing or cancelling the transaction. Null for active transactions.',
    `source_system_transaction_ref` STRING COMMENT 'Unique transaction identifier in the source system for traceability and reconciliation.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the transaction (quantity × unit cost), in property base currency.',
    `transaction_date` DATE COMMENT 'Business date of the stock transaction, used for daily reporting and period-end reconciliation.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number or reference code for the stock movement.',
    `transaction_status` STRING COMMENT 'Current status of the transaction: pending (awaiting approval), completed (finalized), cancelled (voided before completion), or reversed (corrected after completion).. Valid values are `pending|completed|cancelled|reversed`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the stock transaction occurred in the operational system.',
    `transaction_type` STRING COMMENT 'Type of stock transaction: receipt (goods received from vendor), issue-to-outlet (storeroom to outlet), inter-outlet transfer (outlet to outlet), spoilage, over-production waste, plate waste, breakage, expired stock, physical count adjustment, end-of-day consumption, or return-to-vendor. [ENUM-REF-CANDIDATE: receipt|issue_to_outlet|inter_outlet_transfer|spoilage|over_production_waste|plate_waste|breakage|expired_stock|physical_count_adjustment|end_of_day_consumption|return_to_vendor — 11 candidates stripped; promote to reference product]',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the item at the time of the transaction, in property base currency.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity (e.g., kg, liter, case, bottle, portion, each).',
    `variance_amount` DECIMAL(18,2) COMMENT 'Cost variance amount for physical count adjustment transactions (difference between book and actual). Null for non-adjustment transactions.',
    `waste_category` STRING COMMENT 'Category of waste for waste transactions: spoilage, over-production, plate waste (customer leftovers), breakage, expired stock, or other. Null for non-waste transactions.. Valid values are `spoilage|over_production|plate_waste|breakage|expired|other`',
    `waste_reason` STRING COMMENT 'Detailed reason or description for the waste event. Null for non-waste transactions.',
    CONSTRAINT pk_stock_transaction PRIMARY KEY(`stock_transaction_id`)
) COMMENT 'Single source of truth for all F&B inventory movements and waste events across outlets and storerooms. Captures transaction type (receipt, issue-to-outlet, inter-outlet transfer, spoilage, over-production waste, plate waste, breakage, expired stock, physical count adjustment, end-of-day consumption, return-to-vendor), item reference, quantity, unit cost, total cost, source location, destination location, transaction timestamp, and authorizing manager. For waste/spoilage transactions: waste category, waste reason, meal period, recording staff, and corrective action notes. Supports food cost variance analysis, par level management, sustainability reporting, waste reduction KPIs, and ISO 22000 stock traceability. Integrates waste tracking previously in separate waste logs to provide unified inventory and waste analytics.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` (
    `food_safety_inspection_id` BIGINT COMMENT 'Unique identifier for the food safety inspection record. Primary key.',
    `fnb_outlet_id` BIGINT COMMENT 'Identifier of the specific F&B outlet or kitchen facility inspected (restaurant, bar, banquet kitchen, room service kitchen, etc.).',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.property_facility. Business justification: Regulatory compliance: health inspectors inspect physical kitchen and prep facilities, not just outlet concepts. Linking food_safety_inspection to property_facility enables facility-level compliance t',
    `property_id` BIGINT COMMENT 'Identifier of the property where the inspection took place.',
    `areas_inspected` STRING COMMENT 'List or description of specific areas, zones, or stations within the outlet or kitchen that were inspected (e.g., prep area, cold storage, dishwashing station, dining room).',
    `compliance_status` STRING COMMENT 'Overall compliance status of the outlet or facility following the inspection (compliant, non-compliant, conditional compliance, pending review).. Valid values are `compliant|non_compliant|conditional_compliance|pending_review`',
    `corrective_action_completion_date` DATE COMMENT 'The actual date on which all required corrective actions were completed and verified.',
    `corrective_action_due_date` DATE COMMENT 'The deadline by which all corrective actions must be completed to achieve compliance.',
    `corrective_action_status` STRING COMMENT 'Current status of corrective action implementation (not started, in progress, completed, verified, overdue).. Valid values are `not_started|in_progress|completed|verified|overdue`',
    `corrective_actions_required` STRING COMMENT 'Detailed description of corrective actions that must be taken to address identified violations and achieve compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the system.',
    `critical_violations_count` STRING COMMENT 'Number of critical violations identified during the inspection. Critical violations pose immediate health risks (e.g., improper food temperatures, cross-contamination, pest infestation).',
    `haccp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the outlet or facility is in compliance with HACCP principles based on this inspection (True/False).',
    `inspection_checklist_used` STRING COMMENT 'Name or identifier of the standardized inspection checklist or audit protocol used during the inspection.',
    `inspection_date` DATE COMMENT 'The date on which the food safety inspection was conducted.',
    `inspection_duration_minutes` STRING COMMENT 'Total duration of the inspection in minutes, from start to completion.',
    `inspection_grade` STRING COMMENT 'Letter grade or categorical rating assigned based on the inspection score (e.g., A, B, C, Pass, Fail, Satisfactory, Unsatisfactory).',
    `inspection_notes` STRING COMMENT 'Additional notes, observations, or comments recorded by the inspector during the inspection.',
    `inspection_number` STRING COMMENT 'Business identifier or reference number assigned to this inspection for tracking and reporting purposes.',
    `inspection_report_url` STRING COMMENT 'URL or file path to the full inspection report document stored in the document management system.',
    `inspection_score` DECIMAL(18,2) COMMENT 'Numerical score or rating assigned to the inspection, typically on a scale defined by the inspecting authority (e.g., 0-100).',
    `inspection_score_scale` STRING COMMENT 'Description of the scoring scale used for this inspection (e.g., 0-100 scale, A-F letter grade, Pass/Fail).',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection (scheduled, in progress, completed, failed, passed, pending corrective action).. Valid values are `scheduled|in_progress|completed|failed|passed|pending_corrective_action`',
    `inspection_type` STRING COMMENT 'The category or type of inspection conducted (internal audit, health department inspection, ISO 22000 audit, HACCP review, pest control inspection, fire safety inspection, third-party audit). [ENUM-REF-CANDIDATE: internal_audit|health_department|iso_22000_audit|haccp_review|pest_control|fire_safety|third_party_audit — 7 candidates stripped; promote to reference product]',
    `inspector_certification_number` STRING COMMENT 'Professional certification or license number of the inspector, if applicable.',
    `inspector_name` STRING COMMENT 'Full name of the individual or lead inspector who conducted the inspection.',
    `inspector_organization` STRING COMMENT 'Name of the organization or agency the inspector represents (e.g., local health department, ISO certification body, internal audit team, pest control vendor).',
    `iso_22000_compliance_flag` BOOLEAN COMMENT 'Indicates whether the outlet or facility is in compliance with ISO 22000 Food Safety Management System standards based on this inspection (True/False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last updated or modified in the system.',
    `non_critical_violations_count` STRING COMMENT 'Number of non-critical violations identified during the inspection. Non-critical violations do not pose immediate health risks but require correction (e.g., minor equipment maintenance, documentation gaps).',
    `notification_sent_date` DATE COMMENT 'Date on which the inspection results and corrective action requirements were formally communicated to the responsible manager or property management.',
    `permit_number_verified` STRING COMMENT 'Health permit or food service license number that was verified or reviewed during the inspection.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority or governing body under whose jurisdiction this inspection was conducted (e.g., County Health Department, State Food Safety Division, ISO Certification Body).',
    `reinspection_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up reinspection is required to verify corrective actions (True/False).',
    `reinspection_scheduled_date` DATE COMMENT 'The scheduled date for the follow-up reinspection, if required.',
    `violations_summary` STRING COMMENT 'Textual summary of all violations identified during the inspection, including descriptions and locations.',
    CONSTRAINT pk_food_safety_inspection PRIMARY KEY(`food_safety_inspection_id`)
) COMMENT 'Food safety inspection and audit records for F&B outlets and kitchen facilities, capturing inspection date, outlet or kitchen area inspected, inspection type (internal audit, health department inspection, ISO 22000 audit, HACCP review, pest control inspection), inspector name, inspection score, critical violations count, non-critical violations count, corrective actions required, corrective action due date, corrective action completion date, and overall compliance status. Supports ISO 22000 compliance, regulatory reporting, and food safety management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` (
    `recipe_ingredient_id` BIGINT COMMENT 'Primary key for the recipe_ingredient association',
    `inventory_item_id` BIGINT COMMENT 'Foreign key linking to the inventory item (ingredient) used in this recipe.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to the parent recipe that this ingredient line belongs to.',
    `is_optional_ingredient` BOOLEAN COMMENT 'Indicates whether this ingredient is optional or a suggested substitution within the recipe (e.g., garnish, allergen-free alternative). Optional ingredients are excluded from mandatory food cost calculations but included in full BOM documentation. Belongs to the recipe-ingredient combination.',
    `preparation_step_sequence` STRING COMMENT 'The sequential order in which this ingredient is introduced during recipe preparation. Supports structured kitchen workflow and is specific to each ingredients role within a particular recipe. Belongs to the recipe-ingredient combination, not to the recipe or item alone.',
    `quantity_per_portion` DECIMAL(18,2) COMMENT 'The precise quantity of this inventory item required to produce one standard portion of the recipe. Used for theoretical food cost calculation and automatic stock depletion from POS sales. Belongs to the recipe-ingredient combination, not to either entity alone.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which this ingredient is specified within this recipe (e.g., grams, ml, each). May differ from the inventory items stock UOM and requires a UOM conversion factor for accurate depletion. Belongs to the recipe-ingredient combination.',
    `waste_factor_percent` DECIMAL(18,2) COMMENT 'The percentage of trim, peeling, or preparation waste applied to this ingredient when used in this specific recipe (e.g., 15% trim loss on carrots for this dish). Used to calculate the gross quantity to order versus the net quantity in the portion. Specific to the recipe-ingredient combination as waste varies by preparation method.',
    CONSTRAINT pk_recipe_ingredient PRIMARY KEY(`recipe_ingredient_id`)
) COMMENT 'This association product represents the Recipe Ingredient relationship between recipe and inventory_item. It captures the precise quantity, unit of measure, preparation sequence, optionality, and waste factor for each ingredient within a specific recipe — the F&B Bill of Materials. Each record links one recipe to one inventory_item and carries attributes that exist only in the context of that specific recipe-ingredient combination. This is the operational foundation for food cost calculation, theoretical stock depletion from POS sales, and ISO 22000 ingredient-level traceability.. Existence Justification: In F&B operations, a recipe is composed of multiple inventory items (ingredients), and a single inventory item (e.g., olive oil, chicken breast) is used across many recipes. This recipe-ingredient relationship is the foundational Bill of Materials concept in every hospitality F&B management system — it is the operational backbone of food cost calculation, stock depletion from POS sales, and ISO 22000 ingredient traceability. The relationship carries rich per-combination data (quantity per portion, unit of measure, preparation step sequence, waste factor) that belongs to neither the recipe nor the inventory item alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ADD CONSTRAINT `fk_fnb_menu_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ADD CONSTRAINT `fk_fnb_menu_item_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ADD CONSTRAINT `fk_fnb_menu_item_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ADD CONSTRAINT `fk_fnb_menu_item_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ADD CONSTRAINT `fk_fnb_recipe_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_parent_line_pos_check_line_id` FOREIGN KEY (`parent_line_pos_check_line_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line`(`pos_check_line_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_inventory_item_id` FOREIGN KEY (`inventory_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`inventory_item`(`inventory_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_original_transaction_stock_transaction_id` FOREIGN KEY (`original_transaction_stock_transaction_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction`(`stock_transaction_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_primary_stock_fnb_outlet_id` FOREIGN KEY (`primary_stock_fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ADD CONSTRAINT `fk_fnb_food_safety_inspection_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ADD CONSTRAINT `fk_fnb_recipe_ingredient_inventory_item_id` FOREIGN KEY (`inventory_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`inventory_item`(`inventory_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ADD CONSTRAINT `fk_fnb_recipe_ingredient_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`recipe`(`recipe_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`fnb` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`fnb` SET TAGS ('dbx_domain' = 'fnb');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_subdomain' = 'outlet_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `property_outlet_id` SET TAGS ('dbx_ssot_owner' = 'property.property_outlet');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `property_outlet_id` SET TAGS ('dbx_ssot_entity' = 'outlet');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `accepts_reservations_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepts Reservations Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `average_check_target` SET TAGS ('dbx_business_glossary_term' = 'Average Check Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `average_check_target` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `beverage_cost_percentage_target` SET TAGS ('dbx_business_glossary_term' = 'Beverage Cost Percentage Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `beverage_cost_percentage_target` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `cuisine_category` SET TAGS ('dbx_business_glossary_term' = 'Cuisine Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `dress_code` SET TAGS ('dbx_business_glossary_term' = 'Dress Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `dress_code` SET TAGS ('dbx_value_regex' = 'casual|smart_casual|business_casual|formal|resort_casual|no_dress_code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Outlet Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `food_cost_percentage_target` SET TAGS ('dbx_business_glossary_term' = 'Food Cost Percentage Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `food_cost_percentage_target` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `iso_22000_certification_date` SET TAGS ('dbx_business_glossary_term' = 'ISO 22000 Certification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `iso_22000_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 22000 Certified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `iso_22000_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'ISO 22000 Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `menu_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Menu Last Updated Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Outlet Opening Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekend');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `outlet_code` SET TAGS ('dbx_business_glossary_term' = 'Outlet Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `outlet_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `outlet_name` SET TAGS ('dbx_business_glossary_term' = 'Outlet Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `outlet_status` SET TAGS ('dbx_business_glossary_term' = 'Outlet Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `outlet_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|under_renovation|temporarily_closed|permanently_closed');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `outlet_type` SET TAGS ('dbx_business_glossary_term' = 'Outlet Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Outlet Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `service_style` SET TAGS ('dbx_business_glossary_term' = 'Service Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `smoking_policy` SET TAGS ('dbx_business_glossary_term' = 'Smoking Policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `smoking_policy` SET TAGS ('dbx_value_regex' = 'non_smoking|smoking_allowed|outdoor_smoking_area|designated_smoking_section');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` SET TAGS ('dbx_subdomain' = 'menu_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `allergen_information` SET TAGS ('dbx_business_glossary_term' = 'Allergen Information');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `beverage_description` SET TAGS ('dbx_business_glossary_term' = 'Beverage Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `beverage_description` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `beverage_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Beverage Inclusion Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `beverage_inclusion_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `menu_code` SET TAGS ('dbx_business_glossary_term' = 'Menu Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `menu_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `course_count` SET TAGS ('dbx_business_glossary_term' = 'Course Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `cuisine_type` SET TAGS ('dbx_business_glossary_term' = 'Cuisine Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `menu_description` SET TAGS ('dbx_business_glossary_term' = 'Menu Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `dietary_options` SET TAGS ('dbx_business_glossary_term' = 'Dietary Options');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `maximum_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `maximum_capacity` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `meal_period` SET TAGS ('dbx_business_glossary_term' = 'Meal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `meal_period` SET TAGS ('dbx_value_regex' = 'breakfast|brunch|lunch|dinner|all_day|afternoon_tea');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `menu_status` SET TAGS ('dbx_business_glossary_term' = 'Menu Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `menu_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|seasonal|pending_approval');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `menu_type` SET TAGS ('dbx_business_glossary_term' = 'Menu Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `menu_type` SET TAGS ('dbx_value_regex' = 'a_la_carte|prix_fixe|buffet|banquet_package|coffee_break|cocktail_reception');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `minimum_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `menu_name` SET TAGS ('dbx_business_glossary_term' = 'Menu Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `per_person_price` SET TAGS ('dbx_business_glossary_term' = 'Per Person Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `preparation_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Preparation Lead Time (Hours)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|luxury|budget|promotional|seasonal');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `print_sequence` SET TAGS ('dbx_business_glossary_term' = 'Print Sequence');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `seasonal_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `service_charge_inclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Inclusive Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `service_style` SET TAGS ('dbx_business_glossary_term' = 'Service Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `service_style` SET TAGS ('dbx_value_regex' = 'plated|buffet|family_style|stations|passed|self_service');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `setup_requirements` SET TAGS ('dbx_business_glossary_term' = 'Setup Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `target_guest_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `tax_inclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Inclusive Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` SET TAGS ('dbx_subdomain' = 'menu_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `alcohol_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Content Percentage (ABV)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `allergen_flags` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flags');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `calorie_count` SET TAGS ('dbx_business_glossary_term' = 'Calorie Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `cost_price` SET TAGS ('dbx_business_glossary_term' = 'Cost Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `cost_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `food_safety_classification` SET TAGS ('dbx_business_glossary_term' = 'ISO 22000 Food Safety Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `food_safety_classification` SET TAGS ('dbx_value_regex' = 'low_risk|medium_risk|high_risk');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `gross_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `gross_margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `is_alcoholic` SET TAGS ('dbx_business_glossary_term' = 'Alcoholic Beverage Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `is_available_banquet` SET TAGS ('dbx_business_glossary_term' = 'Banquet Availability Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `is_available_room_service` SET TAGS ('dbx_business_glossary_term' = 'Room Service Availability Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `is_gluten_free` SET TAGS ('dbx_business_glossary_term' = 'Gluten-Free Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `is_halal` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `is_kosher` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `is_seasonal` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Item Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `is_signature_item` SET TAGS ('dbx_business_glossary_term' = 'Signature Item Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `is_vegan` SET TAGS ('dbx_business_glossary_term' = 'Vegan Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `is_vegetarian` SET TAGS ('dbx_business_glossary_term' = 'Vegetarian Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'food|beverage|modifier|package|combo|merchandise');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `item_code` SET TAGS ('dbx_business_glossary_term' = 'Item Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `item_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `item_name` SET TAGS ('dbx_business_glossary_term' = 'Item Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Item Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|discontinued|pending');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `item_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Item Subcategory');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `menu_section` SET TAGS ('dbx_business_glossary_term' = 'Menu Section');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `portion_size` SET TAGS ('dbx_business_glossary_term' = 'Portion Size');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `preparation_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Preparation Time (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Availability Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `spice_level` SET TAGS ('dbx_business_glossary_term' = 'Spice Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `spice_level` SET TAGS ('dbx_value_regex' = 'none|mild|medium|hot|extra_hot');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Selling Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` SET TAGS ('dbx_subdomain' = 'menu_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `allergen_information` SET TAGS ('dbx_business_glossary_term' = 'Allergen Information');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `ccp_details` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point (CCP) Details');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `chef_notes` SET TAGS ('dbx_business_glossary_term' = 'Chef Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `recipe_code` SET TAGS ('dbx_business_glossary_term' = 'Recipe Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `recipe_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `cooking_instructions` SET TAGS ('dbx_business_glossary_term' = 'Cooking Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `cooking_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Cooking Time (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `cuisine_type` SET TAGS ('dbx_business_glossary_term' = 'Cuisine Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `dietary_attributes` SET TAGS ('dbx_business_glossary_term' = 'Dietary Attributes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `haccp_hazard_analysis` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis and Critical Control Points (HACCP) Hazard Analysis');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `iso_22000_ccp_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 22000 Critical Control Point (CCP) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `nutritional_calories` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Calories');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `nutritional_carbohydrate_grams` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Carbohydrate (Grams)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `nutritional_fat_grams` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Fat (Grams)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `nutritional_protein_grams` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Protein (Grams)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `nutritional_sodium_milligrams` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Sodium (Milligrams)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `plating_instructions` SET TAGS ('dbx_business_glossary_term' = 'Plating Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `portion_size_unit` SET TAGS ('dbx_business_glossary_term' = 'Portion Size Unit');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `portion_size_unit` SET TAGS ('dbx_value_regex' = 'ounce|gram|milliliter|piece|slice|cup');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `preparation_method` SET TAGS ('dbx_business_glossary_term' = 'Preparation Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `preparation_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Preparation Time (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `recipe_status` SET TAGS ('dbx_business_glossary_term' = 'Recipe Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `recipe_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|discontinued|testing');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `recipe_type` SET TAGS ('dbx_business_glossary_term' = 'Recipe Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Availability');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `shelf_life_hours` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Hours)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `skill_level_required` SET TAGS ('dbx_business_glossary_term' = 'Skill Level Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `skill_level_required` SET TAGS ('dbx_value_regex' = 'basic|intermediate|advanced|expert');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `standard_beverage_cost_per_portion` SET TAGS ('dbx_business_glossary_term' = 'Standard Beverage Cost Per Portion');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `standard_beverage_cost_per_portion` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `standard_beverage_cost_per_portion` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `standard_food_cost_per_portion` SET TAGS ('dbx_business_glossary_term' = 'Standard Food Cost Per Portion');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `standard_food_cost_per_portion` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `standard_portion_size` SET TAGS ('dbx_business_glossary_term' = 'Standard Portion Size');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `storage_instructions` SET TAGS ('dbx_business_glossary_term' = 'Storage Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `storage_instructions` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `total_recipe_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Recipe Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `total_recipe_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `total_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Time (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Yield Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `yield_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Yield Unit of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` SET TAGS ('dbx_subdomain' = 'sales_transactions');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Check ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `beo_id` SET TAGS ('dbx_business_glossary_term' = 'Beo Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Package Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `actual_delivery_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `check_status` SET TAGS ('dbx_business_glossary_term' = 'Check Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `check_status` SET TAGS ('dbx_value_regex' = 'open|closed|voided|transferred|suspended');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check Closed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `cover_count` SET TAGS ('dbx_business_glossary_term' = 'Cover Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `delivery_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Duration (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'received|in-preparation|dispatched|delivered|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `folio_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Property Management System (PMS) Folio Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `manager_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Manager Approval Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `manager_approval_required` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `meal_period` SET TAGS ('dbx_business_glossary_term' = 'Meal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check Opened Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'phone|in-room-tablet|mobile-app|walk-in|kiosk|web');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `requested_delivery_time` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `service_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Duration (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `table_number` SET TAGS ('dbx_business_glossary_term' = 'Table Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `tender_amount` SET TAGS ('dbx_business_glossary_term' = 'Tender Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` SET TAGS ('dbx_subdomain' = 'sales_transactions');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `pos_check_line_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Check Line ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Promotion Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `parent_line_pos_check_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Line ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Check ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `cost_of_sales` SET TAGS ('dbx_business_glossary_term' = 'Cost of Sales');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `cost_of_sales` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `course_number` SET TAGS ('dbx_business_glossary_term' = 'Course Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `family_group_code` SET TAGS ('dbx_business_glossary_term' = 'Family Group Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `is_complimentary` SET TAGS ('dbx_business_glossary_term' = 'Is Complimentary Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `is_inclusive_tax` SET TAGS ('dbx_business_glossary_term' = 'Is Inclusive Tax Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `is_open_item` SET TAGS ('dbx_business_glossary_term' = 'Is Open Item Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `line_subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Subtotal Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `major_group_code` SET TAGS ('dbx_business_glossary_term' = 'Major Group Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `modifier_text` SET TAGS ('dbx_business_glossary_term' = 'Modifier Text');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `preparation_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Preparation Time Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `seat_number` SET TAGS ('dbx_business_glossary_term' = 'Seat Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `sent_to_kitchen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sent to Kitchen Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `served_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Served Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `void_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Void Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `void_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Void Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` SET TAGS ('dbx_subdomain' = 'sales_transactions');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `room_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Room Service Order ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Check Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `actual_delivery_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `cover_count` SET TAGS ('dbx_business_glossary_term' = 'Cover Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `delivery_charge` SET TAGS ('dbx_business_glossary_term' = 'Delivery Charge');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `delivery_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Duration (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `dietary_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restrictions');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `dispatch_time` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `folio_reference` SET TAGS ('dbx_business_glossary_term' = 'Folio Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `gratuity_amount` SET TAGS ('dbx_business_glossary_term' = 'Gratuity Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `guest_feedback_comment` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback Comment');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `guest_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `is_vip_guest` SET TAGS ('dbx_business_glossary_term' = 'Is VIP Guest Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `on_time_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `order_source` SET TAGS ('dbx_business_glossary_term' = 'Order Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `order_source` SET TAGS ('dbx_value_regex' = 'phone|in-room-tablet|mobile-app|front-desk|concierge');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'received|in-preparation|dispatched|delivered|cancelled|rejected');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'room-charge|credit-card|cash|loyalty-points|comp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `preparation_start_time` SET TAGS ('dbx_business_glossary_term' = 'Preparation Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `requested_delivery_time` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `service_charge` SET TAGS ('dbx_business_glossary_term' = 'Service Charge');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` SET TAGS ('dbx_subdomain' = 'outlet_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `inventory_item_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Item Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `alcohol_by_volume_percent` SET TAGS ('dbx_business_glossary_term' = 'Alcohol by Volume (ABV) Percent');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `alcohol_flag` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `allergen_types` SET TAGS ('dbx_business_glossary_term' = 'Allergen Types');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `current_on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Current On-Hand Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `gluten_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Gluten Free Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `iso_food_safety_classification` SET TAGS ('dbx_business_glossary_term' = 'ISO Food Safety Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `iso_food_safety_classification` SET TAGS ('dbx_value_regex' = 'high_risk|medium_risk|low_risk|non_food');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `item_code` SET TAGS ('dbx_business_glossary_term' = 'Item Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `item_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `item_name` SET TAGS ('dbx_business_glossary_term' = 'Item Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Item Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|seasonal|pending_approval|out_of_stock');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `item_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Item Subcategory');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `last_physical_count_quantity` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `last_purchase_cost` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `last_purchase_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `local_sourced_flag` SET TAGS ('dbx_business_glossary_term' = 'Local Sourced Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `organic_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `package_size` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Par Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `required_storage_temperature_max` SET TAGS ('dbx_business_glossary_term' = 'Required Storage Temperature Maximum (Celsius)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `required_storage_temperature_max` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `required_storage_temperature_min` SET TAGS ('dbx_business_glossary_term' = 'Required Storage Temperature Minimum (Celsius)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `required_storage_temperature_min` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `supplier_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `vegan_flag` SET TAGS ('dbx_business_glossary_term' = 'Vegan Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `vendor_item_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percent');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` SET TAGS ('dbx_subdomain' = 'outlet_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `stock_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transaction Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `beo_id` SET TAGS ('dbx_business_glossary_term' = 'Beo Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `inventory_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `original_transaction_stock_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Transaction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `primary_stock_fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `room_amenity_id` SET TAGS ('dbx_business_glossary_term' = 'Room Amenity Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `corrective_action_notes` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `meal_period` SET TAGS ('dbx_business_glossary_term' = 'Meal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `meal_period` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|all_day|banquet|room_service');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `source_system_transaction_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|completed|cancelled|reversed');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `waste_category` SET TAGS ('dbx_value_regex' = 'spoilage|over_production|plate_waste|breakage|expired|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `waste_reason` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` SET TAGS ('dbx_subdomain' = 'outlet_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `food_safety_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Inspection ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Property Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `areas_inspected` SET TAGS ('dbx_business_glossary_term' = 'Areas Inspected');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional_compliance|pending_review');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|overdue');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `critical_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Violations Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `haccp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis and Critical Control Points) Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspection_checklist_used` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist Used');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspection_grade` SET TAGS ('dbx_business_glossary_term' = 'Inspection Grade');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspection_report_url` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspection_score` SET TAGS ('dbx_business_glossary_term' = 'Inspection Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspection_score_scale` SET TAGS ('dbx_business_glossary_term' = 'Inspection Score Scale');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|failed|passed|pending_corrective_action');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `inspector_organization` SET TAGS ('dbx_business_glossary_term' = 'Inspector Organization');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `iso_22000_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 22000 Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `non_critical_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Critical Violations Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `permit_number_verified` SET TAGS ('dbx_business_glossary_term' = 'Permit Number Verified');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `reinspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `reinspection_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Scheduled Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `violations_summary` SET TAGS ('dbx_business_glossary_term' = 'Violations Summary');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` SET TAGS ('dbx_subdomain' = 'menu_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` SET TAGS ('dbx_association_edges' = 'fnb.recipe,fnb.inventory_item');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `recipe_ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Ingredient - Recipe Ingredient Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `inventory_item_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Ingredient - Inventory Item Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Ingredient - Recipe Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `is_optional_ingredient` SET TAGS ('dbx_business_glossary_term' = 'Optional Ingredient Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `preparation_step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Preparation Step Sequence');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `quantity_per_portion` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Quantity Per Portion');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Recipe Ingredient Unit of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `waste_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Waste Factor Percentage');
