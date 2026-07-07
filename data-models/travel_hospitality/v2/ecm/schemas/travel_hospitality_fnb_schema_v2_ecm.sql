-- Schema for Domain: fnb | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:50:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`fnb` COMMENT 'F&B operations including restaurant outlets, bars, room service, banquets, and catering. Manages menus, recipes, POS transactions, covers, check averages, and outlet performance. Tracks food cost, beverage cost, and F&B revenue contribution to TRevPAR. Integrates with Oracle Hospitality MICROS POS. Supports USALI F&B departmental reporting and ISO 22000 food safety compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` (
    `fnb_outlet_id` BIGINT COMMENT 'Primary key for outlet',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: F&B outlets are cost centers for labor and expense allocation in USALI departmental accounting. Outlet currently has cost_center_code (denormalized); proper FK enables expense tracking, budget varianc',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Outlet manager accountability is required for P&L ownership, labor scheduling, food safety compliance, and performance reviews. Links operational responsibility to workforce records for reporting and ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: F&B outlets operate under specific brands (e.g., Ritz-Carlton vs. Courtyard outlets have different positioning). Brand-level F&B performance reporting, menu standards enforcement, and brand compliance',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Outlets require liquor licenses and health permits tracked centrally in compliance.permit. Links outlet to its primary operating permit for regulatory tracking, renewal management, and compliance repo',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: F&B outlets are profit centers for revenue and margin analysis in hospitality financial reporting. Outlet has profit_center_code (denormalized); FK enables GOP analysis, performance dashboards, and co',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Menu approval workflow requires tracking which executive chef or F&B director authorized menu changes for cost control, brand standards compliance, allergen accuracy, and pricing authority. Critical f',
    `fnb_outlet_id` BIGINT COMMENT 'Reference to the Food and Beverage (F&B) outlet where this menu is offered (restaurant, bar, room service, banquet facility).',
    `revenue_center_id` BIGINT COMMENT 'Foreign key linking to fnb.revenue_center. Business justification: Menus are served through revenue centers for USALI departmental reporting. While menu already has fnb_outlet_id, adding revenue_center_id provides the USALI departmental link needed for financial repo',
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
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Menu items are classified into procurement categories (food, beverage, supplies) for cost analysis, margin reporting, procurement planning, and pricing strategy. Core F&B finance operation.',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key reference to the primary Food and Beverage (F&B) outlet where this menu item is offered. A menu item may be available at multiple outlets, but this represents the primary or originating outlet.',
    `menu_id` BIGINT COMMENT 'Foreign key linking to fnb.menu. Business justification: CRITICAL MISSING LINK. Menu items must belong to specific menus for proper menu management. Currently menu_item links to outlet but not to menu. This FK enables menu versioning, seasonal menu changes,',
    `recipe_id` BIGINT COMMENT 'Foreign key reference to the standardized recipe used to prepare this menu item. Links to detailed ingredient lists, preparation instructions, and cost breakdowns for kitchen operations and cost control.',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the primary supplier or vendor for the main ingredient or component of this menu item. Used for procurement planning and supply chain management.',
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
    `food_safety_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.food_safety_cert. Business justification: Recipes certified under ISO 22000 or HACCP standards must link to the certification record for audit trails, compliance verification, and regulatory reporting. Natural 1:N where recipe references its ',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` (
    `recipe_ingredient_id` BIGINT COMMENT 'Unique identifier for each ingredient line within a recipe. Primary key for the recipe ingredient entity.',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Recipe ingredients belong to procurement categories for spend analysis, vendor management, cost control, and sourcing strategy. Essential for F&B procurement operations and recipe costing.',
    `inventory_item_id` BIGINT COMMENT 'Reference to the ingredient master record. Links to the ingredient catalog for standardized ingredient definitions.',
    `recipe_id` BIGINT COMMENT 'Reference to the parent standardized recipe that this ingredient belongs to. Links to the recipe master data.',
    `vendor_id` BIGINT COMMENT 'Reference to the preferred supplier for this ingredient. Supports procurement planning and supplier performance tracking.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this ingredient is currently active in the recipe. False if ingredient has been removed or temporarily suspended. Supports recipe version control.',
    `allergen_contribution` STRING COMMENT 'Comma-separated list of allergens present in this ingredient (e.g., dairy, gluten, nuts, shellfish, soy, eggs). Critical for guest safety, menu labeling, and regulatory compliance with food allergen disclosure requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this recipe ingredient record was first created in the system. Audit trail for data lineage.',
    `critical_control_point_flag` BOOLEAN COMMENT 'Indicates whether this ingredient represents a Critical Control Point in the HACCP (Hazard Analysis and Critical Control Points) food safety plan. True if special handling, temperature control, or monitoring is required.',
    `effective_end_date` DATE COMMENT 'The date on which this ingredient was removed from the recipe or replaced. Null if ingredient is currently active. Supports recipe version history.',
    `effective_start_date` DATE COMMENT 'The date from which this ingredient became part of the recipe. Supports recipe change tracking and historical cost analysis.',
    `extended_cost` DECIMAL(18,2) COMMENT 'Total cost for this ingredient line, calculated as quantity_required multiplied by standard_cost_per_unit. Supports recipe-level food cost aggregation.',
    `ingredient_category` STRING COMMENT 'Classification of the ingredient by food category. Used for food cost analysis, procurement planning, and inventory management by category. [ENUM-REF-CANDIDATE: protein|produce|dairy|dry_goods|beverage|spice|condiment|oil_fat|seafood|bakery — 10 candidates stripped; promote to reference product]',
    `ingredient_name` STRING COMMENT 'Human-readable name of the ingredient as it appears in the recipe. May differ from master ingredient name for recipe-specific context.',
    `line_number` STRING COMMENT 'Sequential ordering of ingredients within the recipe. Used for display and preparation sequence.',
    `local_sourcing_flag` BOOLEAN COMMENT 'Indicates whether this ingredient is sourced locally (typically within 100 miles of the property). Supports sustainability initiatives and farm-to-table marketing programs.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered from the supplier for this ingredient. Used for procurement planning and inventory optimization.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this recipe ingredient record. Supports audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this recipe ingredient record was last modified. Supports change tracking and audit compliance.',
    `nutritional_value_per_unit` STRING COMMENT 'Nutritional information for one unit of this ingredient (calories, protein, fat, carbohydrates, sodium). Stored as structured text or JSON. Supports menu nutrition labeling and dietary analysis.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether this ingredient is certified organic by a recognized certification body. Supports menu labeling and premium positioning.',
    `par_level` DECIMAL(18,2) COMMENT 'The standard inventory level that should be maintained for this ingredient to support recipe production without stockouts. Used for automated reorder point calculation.',
    `preparation_instruction` STRING COMMENT 'Specific preparation notes for this ingredient within the recipe context (e.g., diced, julienned, blanched, room temperature). Supports kitchen execution and quality consistency.',
    `quantity_required` DECIMAL(18,2) COMMENT 'The amount of this ingredient required for one batch or serving of the recipe. Precision supports fractional measurements common in culinary applications.',
    `seasonality_flag` BOOLEAN COMMENT 'Indicates whether this ingredient has seasonal availability constraints. True if ingredient availability or cost varies significantly by season.',
    `shelf_life_days` STRING COMMENT 'Number of days this ingredient remains usable under proper storage conditions. Supports inventory rotation (FIFO) and waste reduction.',
    `standard_cost_per_unit` DECIMAL(18,2) COMMENT 'The standard cost of one unit of this ingredient at the time of recipe creation or last update. Used for recipe cost roll-up and food cost percentage calculation. Business-confidential pricing data.',
    `storage_requirement` STRING COMMENT 'Required storage condition for this ingredient to maintain quality and safety. Critical for inventory management and food safety compliance.. Valid values are `ambient|refrigerated|frozen|dry_storage|temperature_controlled`',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether this ingredient can be substituted with an alternative ingredient without compromising recipe quality or guest expectations. True if substitution is permitted, False if ingredient is critical.',
    `traceability_code` STRING COMMENT 'Unique code or lot number for ingredient traceability from supplier to finished dish. Required for ISO 22000 compliance and food safety incident response.',
    `unit_of_measure` STRING COMMENT 'The unit in which the ingredient quantity is measured. Standardized to support recipe costing and procurement conversion. [ENUM-REF-CANDIDATE: kg|g|lb|oz|l|ml|gal|qt|pt|cup|tbsp|tsp|each|dozen|case — 15 candidates stripped; promote to reference product]',
    `waste_percentage` DECIMAL(18,2) COMMENT 'The expected waste percentage for this ingredient during preparation (e.g., trim loss, bones, shells). Inverse of yield percentage, used for sustainability tracking and cost accuracy.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'The usable percentage of the ingredient after preparation and waste removal (e.g., 75% for vegetables after trimming). Used for accurate cost calculation and procurement planning.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this recipe ingredient record. Supports audit trail and accountability.',
    CONSTRAINT pk_recipe_ingredient PRIMARY KEY(`recipe_ingredient_id`)
) COMMENT 'Line-level ingredient composition for each standardized recipe, capturing ingredient name, ingredient category (protein, produce, dairy, dry goods, beverage), quantity required, unit of measure, standard cost per unit, substitution flag, and allergen contribution. Supports food cost roll-up per recipe, procurement demand planning, and ISO 22000 ingredient traceability requirements. Each row represents one ingredient within one recipe.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` (
    `pos_check_id` BIGINT COMMENT 'Unique identifier for the POS check transaction. Primary key.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: POS checks that are posted to guest folios or billed to corporate accounts need to link to AR invoices for consolidated billing and receivables management. This FK enables integration between F&B POS ',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: Corporate accounts have direct billing arrangements for F&B charges at outlets and restaurants. Required for AR posting, credit limit enforcement, contracted discount application, and monthly corporat',
    `discount_id` BIGINT COMMENT 'Foreign key linking to fnb.discount. Business justification: POS checks can have check-level discounts applied. Currently pos_check has discount_amount but no FK to the discount master. This FK enables tracking which discount program was applied, authorization ',
    `fnb_outlet_id` BIGINT COMMENT 'Identifier of the F&B outlet where the check was opened (restaurant, bar, room service, poolside, etc.).',
    `guest_group_block_id` BIGINT COMMENT 'Foreign key linking to guest.guest_group_block. Business justification: Group blocks often include F&B master billing where outlet charges are consolidated to group master folio. Required for group F&B spend tracking, contracted minimum tracking, attrition calculation, an',
    `profile_id` BIGINT COMMENT 'Identifier of the guest profile if the guest is a registered hotel guest or loyalty member. Null for walk-in non-registered guests.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: POS transactions must post to specific GL accounts for revenue recognition and financial reporting. While pos_check links to ar_invoice, direct ledger link enables real-time revenue classification (fo',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Core loyalty points earning process: F&B transactions post points to member accounts. pos_check.loyalty_points_earned exists, requiring direct member link for accrual posting, tier validation, and poi',
    `employee_id` BIGINT COMMENT 'Identifier of the server or service staff member assigned to this check. Used for tip allocation and performance tracking.',
    `property_id` BIGINT COMMENT 'Identifier of the property where the check was opened.',
    `reservation_booking_id` BIGINT COMMENT 'Identifier of the guest reservation if the check is associated with an in-house guest. Used to link F&B spend to guest stay.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Room service and in-room dining POS checks must link to physical room for folio posting, guest billing integration, housekeeping coordination, and delivery routing. Room_number is denormalized; room_i',
    `tertiary_pos_manager_employee_id` BIGINT COMMENT 'Identifier of the manager who approved exceptions on this check. Null if no manager approval was required.',
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
    `discount_id` BIGINT COMMENT 'Foreign key linking to fnb.discount. Business justification: Line-level discounts are common in F&B POS operations. Currently pos_check_line has discount_amount and discount_reason_code but no FK to discount master. This FK enables tracking which specific disco',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.promotion. Business justification: Item-level loyalty promotions: "earn 3x points on breakfast items" or "bonus 500 points on wine purchases over $100". Business process: promotion qualification tracking, bonus points calculation at li',
    `menu_item_id` BIGINT COMMENT 'Reference to the menu item master record that was ordered on this line. Links to menu item catalog for recipe, cost, and category information.',
    `parent_line_pos_check_line_id` BIGINT COMMENT 'Reference to another line item that this line is a modifier or add-on for. Null for standalone items. Enables hierarchical line item relationships for complex orders.',
    `pos_check_id` BIGINT COMMENT 'Reference to the parent POS check (guest check) that contains this line item. Links line to header transaction.',
    `revenue_center_id` BIGINT COMMENT 'Reference to the outlet or revenue center where this line item was sold. Links to property outlet master for location-based performance analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who authorized or performed the void of this line item. Used for accountability and fraud prevention.',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` (
    `revenue_center_id` BIGINT COMMENT 'Primary key for revenue_center',
    `parent_revenue_center_id` BIGINT COMMENT 'Reference to the parent revenue center in the reporting hierarchy. Null for top-level revenue centers.',
    `property_id` BIGINT COMMENT 'Reference to the property where this revenue center operates.',
    `allergen_menu_available_flag` BOOLEAN COMMENT 'Indicates whether allergen information is available for menu items in this revenue center. True if allergen menus are provided.',
    `average_check_target_amount` DECIMAL(18,2) COMMENT 'Target average check amount per cover for this revenue center. Used for revenue management and performance tracking.',
    `beverage_cost_target_percentage` DECIMAL(18,2) COMMENT 'Target beverage cost percentage for this revenue center. Used for cost control and GOP analysis.',
    `closure_date` DATE COMMENT 'Date when the revenue center permanently closed. Null if still operational or temporarily closed.',
    `revenue_center_code` STRING COMMENT 'Unique alphanumeric code identifying the revenue center within the property. Used in POS transactions and financial reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `cost_center_code` STRING COMMENT 'Cost center code for expense allocation and departmental P&L reporting in SAP S/4HANA.. Valid values are `^[A-Z0-9]{4,12}$`',
    `covers_per_day_target` STRING COMMENT 'Target number of covers (guests served) per day for this revenue center. Used for capacity planning and forecasting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue center record was first created in the system.',
    `cuisine_type` STRING COMMENT 'Type of cuisine offered (e.g., Italian, Asian Fusion, Steakhouse, International Buffet). Used for marketing and guest preference matching.',
    `day_part_service_flag` STRING COMMENT 'Primary day part(s) served by this revenue center for menu planning and revenue analysis. [ENUM-REF-CANDIDATE: breakfast|lunch|dinner|all_day|brunch|afternoon_tea|late_night — 7 candidates stripped; promote to reference product]',
    `dress_code` STRING COMMENT 'Dress code policy for the revenue center. Used for guest communication and service standards.. Valid values are `casual|smart_casual|business_casual|formal|resort_casual|no_code`',
    `food_cost_target_percentage` DECIMAL(18,2) COMMENT 'Target food cost percentage for this revenue center. Used for cost control and GOP analysis.',
    `gl_account_code` STRING COMMENT 'General ledger account code in SAP S/4HANA for revenue posting. Maps revenue center transactions to the financial chart of accounts.. Valid values are `^[0-9]{4,10}$`',
    `gratuity_policy` STRING COMMENT 'Gratuity policy for the revenue center. Defines how tips and service charges are handled.. Valid values are `included|optional|not_applicable|automatic_for_groups`',
    `iso_22000_certified_flag` BOOLEAN COMMENT 'Indicates whether this revenue center holds ISO 22000 food safety management certification. True if certified.',
    `labor_cost_target_percentage` DECIMAL(18,2) COMMENT 'Target labor cost percentage for this revenue center. Used for workforce planning and GOP analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue center record was last updated in the system.',
    `last_renovation_date` DATE COMMENT 'Date of the most recent renovation or significant refurbishment. Used for FF&E tracking and PIP planning.',
    `micros_rvc_number` STRING COMMENT 'Oracle Hospitality MICROS POS revenue center number. Used to map POS transactions to the revenue center.',
    `revenue_center_name` STRING COMMENT 'Business name of the F&B revenue center (e.g., Main Dining Room, Lobby Bar, Banquet Kitchen, Room Service).',
    `notes` STRING COMMENT 'Free-text notes for additional operational or administrative information about the revenue center.',
    `opening_date` DATE COMMENT 'Date when the revenue center first opened for business. Used for historical analysis and lifecycle tracking.',
    `operating_hours_description` STRING COMMENT 'Textual description of standard operating hours (e.g., Daily 6:00 AM - 10:00 PM, Breakfast 6:30-10:30, Dinner 18:00-22:00).',
    `outlet_type` STRING COMMENT 'Classification of the F&B outlet type for operational and reporting purposes. [ENUM-REF-CANDIDATE: restaurant|bar|lounge|room_service|banquet|catering|minibar|coffee_shop|poolside|in_room_dining|other — 11 candidates stripped; promote to reference product]',
    `pos_integration_enabled_flag` BOOLEAN COMMENT 'Indicates whether this revenue center is integrated with the POS system for transaction capture. True if integrated with Oracle Hospitality MICROS POS.',
    `profit_center_code` STRING COMMENT 'Profit center code for revenue and profitability analysis in SAP S/4HANA.. Valid values are `^[A-Z0-9]{4,12}$`',
    `reporting_hierarchy_level` STRING COMMENT 'Hierarchical level of this revenue center in the propertys organizational structure for roll-up reporting (e.g., 1=outlet, 2=department, 3=division).',
    `reservation_required_flag` BOOLEAN COMMENT 'Indicates whether reservations are required for this revenue center. True if reservations are mandatory, False if walk-ins are accepted.',
    `revenue_category` STRING COMMENT 'USALI revenue category classification for financial reporting and TRevPAR contribution analysis.. Valid values are `food_revenue|beverage_revenue|other_fnb_revenue|banquet_food_revenue|banquet_beverage_revenue|minibar_revenue`',
    `revenue_center_status` STRING COMMENT 'Current operational status of the revenue center. Used for availability management and reporting exclusions.. Valid values are `active|inactive|seasonal|under_renovation|temporarily_closed|permanently_closed`',
    `room_charge_posting_enabled_flag` BOOLEAN COMMENT 'Indicates whether charges from this revenue center can be posted to guest room folios. True if room charge posting is enabled.',
    `seating_capacity` STRING COMMENT 'Maximum number of guests that can be seated simultaneously in the revenue center. Used for capacity planning and yield management.',
    `service_charge_percentage` DECIMAL(18,2) COMMENT 'Standard service charge percentage applied to transactions in this revenue center (e.g., 18.00 for 18% gratuity on banquets).',
    `service_type` STRING COMMENT 'Type of service model offered by the revenue center for operational planning and labor scheduling. [ENUM-REF-CANDIDATE: table_service|counter_service|quick_service|buffet|banquet|room_service|grab_and_go|delivery|catering — 9 candidates stripped; promote to reference product]',
    `tax_rate_group_code` STRING COMMENT 'Tax rate group code applied to transactions in this revenue center. Maps to jurisdiction-specific tax rules.. Valid values are `^[A-Z0-9]{2,10}$`',
    `usali_department_code` STRING COMMENT 'USALI department code for P&L reporting (e.g., Food, Beverage, Other F&B).. Valid values are `^[0-9]{2,4}$`',
    `usali_revenue_center_code` STRING COMMENT 'Standard USALI revenue center code for financial reporting and benchmarking. Maps to USALI chart of accounts.. Valid values are `^[0-9]{4,6}$`',
    CONSTRAINT pk_revenue_center PRIMARY KEY(`revenue_center_id`)
) COMMENT 'Reference master for F&B revenue centers as defined under USALI departmental accounting standards. Maps each outlet and service type to its USALI revenue center code, department code, GL account mapping, cost center, revenue category (food revenue, beverage revenue, other F&B revenue, banquet food revenue, banquet beverage revenue, minibar revenue), and reporting hierarchy. Enables USALI-compliant P&L reporting at the outlet and property level. Serves as the authoritative bridge between operational POS transaction data and financial reporting in SAP S/4HANA. Required for month-end close, food cost percentage reporting, beverage cost percentage reporting, and banquet F&B revenue allocation.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` (
    `void_transaction_id` BIGINT COMMENT 'Primary key for void_transaction',
    `fnb_outlet_id` BIGINT COMMENT 'Reference to the F&B outlet where the void occurred (restaurant, bar, room service, banquet).',
    `pos_check_id` BIGINT COMMENT 'Reference to the original POS check that contains the voided item or transaction. Links to the parent check record in the POS system.',
    `pos_check_line_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check_line. Business justification: Line-level voids should reference the specific pos_check_line being voided for audit trail and reconciliation. Currently void_transaction has voided_item_name/code as strings but no FK to the actual l',
    `employee_id` BIGINT COMMENT 'Reference to the employee who initiated or requested the void transaction. May be the same as the server or a different staff member.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile associated with the original check, if applicable. Used for guest history and service recovery tracking.',
    `property_id` BIGINT COMMENT 'Reference to the property where the void transaction occurred.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the hotel reservation if the void was associated with a room charge or in-house guest transaction.',
    `authorization_code` STRING COMMENT 'Manager authorization code or PIN entered to approve the void. Used for audit trail and accountability.',
    `business_date` DATE COMMENT 'Operational business date (not calendar date) on which the void occurred. Aligns with property accounting day and shift periods.',
    `cost_center_code` STRING COMMENT 'Accounting cost center code associated with the outlet for expense allocation and variance analysis.',
    `covers_count` STRING COMMENT 'Number of guests (covers) on the original check. Used for per-cover analysis and service metrics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this void transaction record was first created in the data warehouse. Used for data lineage and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the voided amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `day_part` STRING COMMENT 'Meal period or day part during which the void occurred. Used for day-part performance analysis.. Valid values are `breakfast|lunch|dinner|late_night|all_day`',
    `investigation_notes` STRING COMMENT 'Free-text notes from loss prevention or management investigation of the void transaction. Used for audit documentation.',
    `is_employee_meal` BOOLEAN COMMENT 'Flag indicating whether the voided transaction was an employee meal. Used for labor cost allocation and benefit tracking.',
    `is_manager_meal` BOOLEAN COMMENT 'Flag indicating whether the voided transaction was a manager meal or comp. Used for tracking complimentary costs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this void transaction record was last updated in the data warehouse. Used for change tracking and data quality monitoring.',
    `original_check_number` STRING COMMENT 'Business identifier of the original POS check that contained the voided item or transaction. Used for cross-reference and audit trail.',
    `original_transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the original transaction or item was posted to the check, before it was voided.',
    `pos_terminal_code` STRING COMMENT 'Identifier of the POS terminal or workstation where the void was processed. Used for device-level audit and troubleshooting.',
    `requires_investigation` BOOLEAN COMMENT 'Flag indicating whether this void has been flagged for further investigation by loss prevention or management due to suspicious patterns or high value.',
    `revenue_center_code` STRING COMMENT 'USALI revenue center classification code for the outlet where the void occurred. Used for departmental P&L reporting.',
    `source_system_transaction_ref` STRING COMMENT 'Unique transaction identifier from the source POS system. Used for reconciliation and troubleshooting with operational systems.',
    `table_number` STRING COMMENT 'Table identifier where the original transaction occurred. Applicable for restaurant and bar outlets.',
    `void_number` STRING COMMENT 'Business identifier for the void transaction, typically system-generated sequential number or alphanumeric code used for audit trail and reference.',
    `void_reason_code` STRING COMMENT 'Standardized code indicating the reason for the void (e.g., guest_request, order_error, kitchen_error, pricing_error, system_error, manager_discretion). Used for loss prevention analysis and operational improvement.',
    `void_reason_description` STRING COMMENT 'Free-text explanation or additional detail provided by the staff member or manager describing why the void was necessary.',
    `void_status` STRING COMMENT 'Current lifecycle status of the void transaction in the approval and audit workflow.. Valid values are `pending|approved|rejected|completed|reversed`',
    `void_timestamp` TIMESTAMP COMMENT 'Date and time when the void transaction was executed in the POS system. This is the principal business event timestamp for the void action.',
    `void_type` STRING COMMENT 'Classification of the void transaction indicating what was voided: individual menu item, entire check, payment tender, discount, service charge, or tax adjustment.. Valid values are `item_void|check_void|payment_void|discount_void|service_charge_void|tax_void`',
    `voided_amount` DECIMAL(18,2) COMMENT 'Monetary value of the voided transaction or item, excluding tax. Represents the gross amount removed from the check.',
    `voided_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item that was voided. Typically an integer for countable items, may be decimal for weight-based items.',
    `voided_service_charge_amount` DECIMAL(18,2) COMMENT 'Service charge or gratuity amount associated with the voided transaction that was reversed.',
    `voided_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount associated with the voided transaction or item that was reversed.',
    `voided_total_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the void including base amount, tax, and service charges. Net impact on revenue.',
    CONSTRAINT pk_void_transaction PRIMARY KEY(`void_transaction_id`)
) COMMENT 'Audit record of voided POS transactions and check line voids, capturing void type (item void, check void, payment void), original check reference, voided item or amount, void reason code, void authorized by (manager ID), void timestamp, outlet, and shift reference. Supports loss prevention, cashiering audit, and USALI internal control compliance. Sourced from Oracle Hospitality MICROS POS void log.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` (
    `room_service_order_id` BIGINT COMMENT 'Unique identifier for the room service order. Primary key.',
    `fnb_outlet_id` BIGINT COMMENT 'Reference to the Food and Beverage (F&B) outlet fulfilling the room service order.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile who placed the room service order.',
    `pos_check_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check. Business justification: Room service orders generate POS checks for billing and revenue recognition. Currently room_service_order has pos_check_number as STRING but no FK to pos_check. Normalizing enables accurate revenue re',
    `employee_id` BIGINT COMMENT 'Reference to the staff member who delivered the order to the guest room.',
    `property_id` BIGINT COMMENT 'Reference to the property where the room service order was placed.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the guest reservation associated with this room service order.',
    `revenue_center_id` BIGINT COMMENT 'Foreign key linking to fnb.revenue_center. Business justification: Room service orders have revenue_center_code as STRING but no FK to revenue_center master. Normalizing enables proper USALI reporting, GL account mapping, and revenue center performance analysis. Remo',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Room service delivery requires physical room link for order routing, access control verification, delivery confirmation, and integration with property management system for guest billing. Room_number ',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to spa.appointment. Business justification: In-room spa services (massage, beauty treatments) coordinate with room service for post-treatment refreshments (herbal tea, fruit platters, wellness meals). Luxury properties track paired services for',
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
    `loyalty_member_number` STRING COMMENT 'Guest loyalty program member number for points accrual and benefit application.',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` (
    `banquet_event_order_id` BIGINT COMMENT 'Unique identifier for the banquet event order. Primary key for the BEO master record.',
    `banquet_menu_package_id` BIGINT COMMENT 'Reference to the catering menu package selected for this event. Links to the catering menu catalog.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Banquet events are frequently driven by marketing campaigns (wedding season promotions, holiday party packages, corporate event campaigns). Sales teams track campaign attribution for ROI analysis and ',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Banquet bookings frequently use promotional offers ("Book by March 31, save 15%", "Complimentary champagne toast"). Event coordinators track offer codes for pricing validation, contract terms enforcem',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: Corporate accounts book banquet events for meetings and conferences. Required for direct billing setup, contract rate application, credit limit monitoring, and AR invoice generation against corporate ',
    `event_booking_id` BIGINT COMMENT 'Reference to the parent event booking that originated this BEO. Links to the event domain booking record.',
    `function_space_id` BIGINT COMMENT 'Identifier of the function room or banquet space where the event will be held.',
    `guest_group_block_id` BIGINT COMMENT 'Foreign key linking to guest.guest_group_block. Business justification: Banquet events are frequently tied to group blocks (weddings, conferences, conventions). Required for group F&B revenue tracking, contracted minimum guarantee tracking, attrition analysis, and master ',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Banquet revenue posts to distinct GL accounts from restaurant operations for USALI reporting. BEO links to pos_check but needs direct ledger link for event-specific revenue classification (catering vs',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Group/banquet loyalty earning: corporate meeting planners and event organizers who are loyalty members earn points on banquet F&B spend. Business process: loyalty points accrual on group revenue, plan',
    `package_id` BIGINT COMMENT 'Foreign key linking to spa.spa_package. Business justification: Corporate events and weddings bundle banquet catering with spa packages (bridal party treatments, executive wellness sessions, conference attendee massages). Event planners book integrated F&B+spa exp',
    `pos_check_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check. Business justification: Banquet events often generate POS checks for actual consumption billing (especially for bar service, upgrades, or consumption-based beverage packages). This FK links the BEO to the actual POS transact',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property where the banquet event will take place.',
    `revenue_center_id` BIGINT COMMENT 'Foreign key linking to fnb.revenue_center. Business justification: Banquet events must be assigned to F&B revenue centers for USALI departmental reporting and cost center allocation. Currently BEO links to function_space and outlet but not to revenue_center. This FK ',
    `actual_covers` STRING COMMENT 'Actual number of guests who attended the banquet event. Recorded post-event for reconciliation and future forecasting.',
    `beo_number` STRING COMMENT 'Externally-known business identifier for the BEO document. Used for communication with clients and operations teams.',
    `beverage_package_type` STRING COMMENT 'Type of beverage service selected for the event. Determines billing method and beverage offerings. [ENUM-REF-CANDIDATE: hosted_bar|cash_bar|consumption_bar|beer_wine_only|soft_drinks_only|full_premium|none — 7 candidates stripped; promote to reference product]',
    `beverage_revenue` DECIMAL(18,2) COMMENT 'Total beverage revenue for the event. May be package-based or consumption-based depending on beverage package type.',
    `billing_instructions` STRING COMMENT 'Special billing instructions including payment method, billing contact, invoice delivery preferences, and split billing arrangements.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the banquet event was completed and the BEO was closed.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the BEO was confirmed by the client and moved to confirmed status.',
    `contact_email` STRING COMMENT 'Email address of the primary client contact for BEO distribution and event correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary client contact for this banquet event. Person responsible for event decisions and communication.',
    `contact_phone` STRING COMMENT 'Phone number of the primary client contact for day-of-event communication and coordination.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this BEO record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this BEO.. Valid values are `^[A-Z]{3}$`',
    `dietary_requirements` STRING COMMENT 'Special dietary needs and restrictions for event attendees including allergies, religious requirements, and preferences.',
    `event_date` DATE COMMENT 'Scheduled date when the banquet event will take place. Primary business event timestamp for the BEO.',
    `event_end_time` TIMESTAMP COMMENT 'Scheduled end time for the banquet event including date and time components.',
    `event_name` STRING COMMENT 'Name or title of the banquet event as provided by the client.',
    `event_start_time` TIMESTAMP COMMENT 'Scheduled start time for the banquet event including date and time components.',
    `event_status` STRING COMMENT 'Current lifecycle status of the banquet event order. Tracks progression from planning through execution to completion.. Valid values are `draft|confirmed|in_progress|completed|cancelled|no_show`',
    `event_type` STRING COMMENT 'Classification of the banquet event type. Determines service style, menu options, and operational requirements. [ENUM-REF-CANDIDATE: wedding|corporate_dinner|cocktail_reception|gala|meeting_break|conference_lunch|breakfast|awards_ceremony|charity_event|holiday_party — 10 candidates stripped; promote to reference product]',
    `food_revenue` DECIMAL(18,2) COMMENT 'Total food revenue for the event calculated from guaranteed covers and per-person food price.',
    `guaranteed_covers` STRING COMMENT 'Number of guests guaranteed by the client for billing purposes. Minimum number the client will be charged for regardless of actual attendance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this BEO record was last modified. Tracks changes to event details, pricing, or status.',
    `per_person_beverage_price` DECIMAL(18,2) COMMENT 'Beverage charge per guest for the selected beverage package. Applicable for hosted bar and package pricing models.',
    `per_person_food_price` DECIMAL(18,2) COMMENT 'Food charge per guest for the selected menu package. Excludes beverage, service charge, and tax.',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Service charge applied to the event. Typically a percentage of food and beverage revenue to cover labor and service costs.',
    `service_charge_percentage` DECIMAL(18,2) COMMENT 'Service charge rate applied to the event as a percentage of food and beverage revenue.',
    `setup_style` STRING COMMENT 'Room setup configuration for the event. Determines furniture arrangement, capacity, and service flow. [ENUM-REF-CANDIDATE: banquet_rounds|theater|classroom|u_shape|boardroom|hollow_square|reception|cocktail|buffet — 9 candidates stripped; promote to reference product]',
    `special_instructions` STRING COMMENT 'Additional operational notes and special requests for event execution including AV requirements, decor, timing, and client preferences.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged for the event including sales tax, VAT, or other applicable taxes.',
    `tax_percentage` DECIMAL(18,2) COMMENT 'Tax rate applied to the event as a percentage of taxable revenue.',
    `total_revenue` DECIMAL(18,2) COMMENT 'Total revenue for the banquet event including food, beverage, service charge, and tax. Grand total for billing.',
    CONSTRAINT pk_banquet_event_order PRIMARY KEY(`banquet_event_order_id`)
) COMMENT 'Banquet Event Order (BEO) master record for catered F&B functions, capturing event name, date, type (wedding, corporate dinner, cocktail reception, gala, meeting break), function room, guaranteed and actual cover counts, menu package, per-person price, beverage package, setup style, dietary requirements, F&B revenue total, service charge, tax, billing instructions, and event status. Serves as the F&B execution document for group events originated in the event domain.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` (
    `banquet_menu_package_id` BIGINT COMMENT 'Unique identifier for the banquet menu package. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Banquet package pricing and terms require director-level approval for contract authority and revenue protection. Links approval authority to workforce records for delegation of authority reporting and',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Banquet packages are often campaign-specific ("2024 Spring Wedding Collection", "Holiday Corporate Party Package"). Sales teams need to track package-campaign relationships for promotional period mana',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Banquet packages are assigned procurement categories for cost analysis, pricing strategy, profitability tracking, and sourcing decisions. Standard catering operations and event management practice.',
    `fnb_outlet_id` BIGINT COMMENT 'Identifier of the F&B (Food and Beverage) outlet or catering department responsible for delivering this package. Links to property outlet master data.',
    `property_id` BIGINT COMMENT 'Identifier of the property offering this banquet menu package. Links to property master data.',
    `advance_notice_days` STRING COMMENT 'Minimum number of days advance notice required to book this package. Ensures adequate time for procurement, preparation, and staffing.',
    `allergen_information` STRING COMMENT 'Detailed allergen disclosure for menu items in this package (e.g., Contains: Dairy, Eggs, Wheat, Tree Nuts). Required for ISO 22000 food safety compliance and guest safety.',
    `approval_date` DATE COMMENT 'Date when this banquet menu package was approved for sale. Used for audit trail and compliance tracking.',
    `beverage_cost_percentage` DECIMAL(18,2) COMMENT 'Target beverage cost as a percentage of the per-person price (if beverages are included). Used for F&B (Food and Beverage) profitability analysis.',
    `beverage_duration_hours` DECIMAL(18,2) COMMENT 'Number of hours of beverage service included in the package price (e.g., 2.0 for a two-hour cocktail reception). Null if beverage_inclusion is none.',
    `beverage_inclusion` STRING COMMENT 'Type of beverage service included in the per-person package price. None indicates beverages are charged separately. Impacts F&B (Food and Beverage) revenue allocation. [ENUM-REF-CANDIDATE: none|soft drinks|coffee and tea|beer and wine|full bar|premium bar|custom — 7 candidates stripped; promote to reference product]',
    `cancellation_policy` STRING COMMENT 'Cancellation terms and penalties specific to this package (e.g., 72-hour notice required, 50% penalty within 48 hours). Used in event contracts and BEO (Banquet Event Order) terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this banquet menu package record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the per-person price (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dietary_accommodations` STRING COMMENT 'Description of dietary options and accommodations available within this package (e.g., Vegetarian, Vegan, Gluten-Free, Kosher options available upon request). Supports ISO 22000 food safety compliance.',
    `food_cost_percentage` DECIMAL(18,2) COMMENT 'Target food cost as a percentage of the per-person price. Used for F&B (Food and Beverage) profitability analysis and GOP (Gross Operating Profit) contribution tracking.',
    `included_courses` STRING COMMENT 'Detailed description of all food courses included in the package (e.g., Appetizer, Salad, Entrée with Two Sides, Dessert, Bread Service). Used in BEO (Banquet Event Order) documentation.',
    `labor_hours_per_guest` DECIMAL(18,2) COMMENT 'Estimated service labor hours required per guest for this package. Used for workforce scheduling and CPOR (Cost Per Occupied Room) calculations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this banquet menu package record was last updated. Used for audit trail and change tracking.',
    `maximum_capacity` STRING COMMENT 'Maximum number of guests that can be served under this package configuration. Constrained by kitchen capacity, service staff, and function space limitations.',
    `menu_category` STRING COMMENT 'High-level menu category for reporting and analytics. Aligns with USALI (Uniform System of Accounts for the Lodging Industry) F&B (Food and Beverage) departmental reporting.. Valid values are `breakfast|lunch|dinner|break|reception|specialty`',
    `minimum_guarantee` STRING COMMENT 'Minimum number of guests required to book this package. Event will be charged for this minimum even if actual attendance is lower. Critical for group event revenue management.',
    `package_code` STRING COMMENT 'Externally-known unique business identifier for the banquet menu package used in Delphi by Amadeus and BEO (Banquet Event Order) generation. Typically alphanumeric code used in event sales quoting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `package_name` STRING COMMENT 'Human-readable name of the banquet menu package (e.g., Executive Breakfast Buffet, Gala Dinner Package, Cocktail Reception Deluxe).',
    `package_notes` STRING COMMENT 'Internal notes and special instructions for event sales and catering staff regarding this package. May include preparation tips, substitution rules, or operational considerations.',
    `package_status` STRING COMMENT 'Current lifecycle status of the banquet menu package. Only active and seasonal packages are available for booking in Delphi by Amadeus.. Valid values are `active|inactive|seasonal|discontinued|pending approval`',
    `package_type` STRING COMMENT 'Classification of the banquet menu package by meal period and service style. Determines pricing structure and operational requirements.. Valid values are `breakfast package|lunch buffet|dinner gala|coffee break|cocktail reception|wedding package`',
    `per_person_price` DECIMAL(18,2) COMMENT 'Base price per person for the banquet menu package in the propertys local currency. Used for event sales quoting and BEO (Banquet Event Order) pricing calculations.',
    `season_description` STRING COMMENT 'Description of the season or time period when this package is available (e.g., Holiday Season, Summer Months, Wedding Season). Null if not seasonal.',
    `seasonal_indicator` BOOLEAN COMMENT 'Indicates whether this package is offered only during specific seasons or year-round. True if seasonal, False if available year-round.',
    `service_charge_percentage` DECIMAL(18,2) COMMENT 'Percentage service charge (gratuity) applied to the package price. Typically ranges from 18% to 24% in the hospitality industry. Used in total event cost calculations.',
    `service_style` STRING COMMENT 'Method of food service delivery for the package (buffet, plated service, family style, food stations, reception style, cocktail service). Impacts labor requirements and guest experience.. Valid values are `buffet|plated|family style|stations|reception|cocktail`',
    `setup_requirements` STRING COMMENT 'Detailed description of room setup, table configuration, linen, centerpieces, and equipment required for this package (e.g., Rounds of 10, Floor-Length Linens, Centerpieces, Stage, AV Equipment). Used for event operations planning.',
    `tax_inclusive_flag` BOOLEAN COMMENT 'Indicates whether the per-person price includes applicable taxes. True if tax-inclusive, False if taxes are added separately. Critical for accurate event quoting.',
    `valid_from_date` DATE COMMENT 'Start date of the validity period for this package. Package can be booked for events on or after this date.',
    `valid_to_date` DATE COMMENT 'End date of the validity period for this package. Package can be booked for events on or before this date. Null indicates no expiration.',
    CONSTRAINT pk_banquet_menu_package PRIMARY KEY(`banquet_menu_package_id`)
) COMMENT 'Master catalog of banquet and catering menu packages offered for group events, capturing package name, package type (breakfast package, lunch buffet, dinner gala, coffee break, cocktail reception, wedding package), per-person price, minimum guarantee, included courses, beverage inclusions, setup requirements, and validity period. Supports event sales quoting in Delphi by Amadeus and BEO generation. Distinct from à la carte menus as packages are priced per-person for group consumption.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` (
    `inventory_item_id` BIGINT COMMENT 'Primary key for inventory_item',
    `category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Inventory items are classified into procurement categories for ABC analysis, vendor selection, spend management, and sourcing strategy. Fundamental inventory management and procurement planning practi',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: F&B inventory items map to procurement material master for standardized procurement, vendor management, cost tracking, and cross-property reporting. Core ERP integration pattern in multi-unit hospital',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory transactions (purchases, waste, transfers) must allocate to cost centers for departmental expense tracking and variance analysis. Stock_transaction has cost_center_code (denormalized); FK en',
    `fnb_outlet_id` BIGINT COMMENT 'Identifier of the destination location (outlet or storeroom) to which the item was moved. Null for waste/spoilage transactions.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Stock transactions for receipts link to GR documents for inventory reconciliation, quality tracking, financial posting, and three-way match validation. Core ERP receiving and inventory control process',
    `inventory_item_id` BIGINT COMMENT 'Identifier of the inventory item involved in the transaction.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Inventory movements post to GL accounts: purchases to inventory asset, issues to COGS, waste to expense. Direct ledger link enables automated GL posting, inventory valuation, and financial statement a',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Stock movements reference material master for standardized item identification, costing, cross-property reporting, and consolidated procurement analytics. Essential for multi-unit hospitality operatio',
    `original_transaction_stock_transaction_id` BIGINT COMMENT 'Reference to the original transaction ID if this is a reversal or correction transaction. Null for original transactions.',
    `physical_count_id` BIGINT COMMENT 'Reference to the physical inventory count session that generated this adjustment transaction. Null for non-adjustment transactions.',
    `pos_check_id` BIGINT COMMENT 'Reference to the POS transaction ID for end-of-day consumption or issue-to-outlet transactions linked to sales. Null for non-POS-linked transactions.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager who authorized or approved the transaction, particularly for waste, adjustments, and transfers.',
    `property_id` BIGINT COMMENT 'Identifier of the property where the stock transaction occurred.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Stock receipts from vendors reference originating PO for three-way matching, variance analysis, audit trails, and invoice reconciliation. Standard procurement control and financial compliance requirem',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to fnb.recipe. Business justification: Stock transactions for recipe production/consumption need to reference the recipe being prepared. When kitchen prepares a recipe, ingredients are consumed (stock transaction type = recipe_consumption',
    `storage_location_id` BIGINT COMMENT 'Identifier of the source location (outlet or storeroom) from which the item was moved. Null for receipts from vendors.',
    `stock_fnb_outlet_id` BIGINT COMMENT 'Identifier of the F&B outlet or storeroom involved in the transaction.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor for receipt or return-to-vendor transactions. Null for internal transactions.',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` (
    `discount_id` BIGINT COMMENT 'Primary key for discount',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Discount authorization requires manager-level approval for revenue protection and fraud prevention. Essential for audit trails, authorization limit enforcement, and tracking who approved promotional p',
    `campaign_id` BIGINT COMMENT 'Identifier linking this discount to a specific marketing campaign in the CRM system. Supports promotional campaign tracking and ROI analysis. Null if not campaign-driven.',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: F&B discounts are often implementations of marketing offers ("Loyalty Platinum 20% dining discount"). POS systems need to link discount codes to offer definitions for eligibility validation, redemptio',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Tier-based F&B discounts: platinum members receive 20% dining discount, gold 15%, etc. discount.loyalty_tier_required exists as text; FK enables POS validation, automated discount application, tier be',
    `amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount deducted from the check or item (e.g., 5.00 for $5 off). Applicable when discount_type is fixed_amount. Null for non-fixed-amount discount types.',
    `applicable_menu_item_scope` STRING COMMENT 'Defines which menu items are eligible for this discount: all_items (any item), specific_items (named items only), menu_category (e.g., appetizers, beverages), revenue_class (e.g., food, beverage, alcohol).. Valid values are `all_items|specific_items|menu_category|revenue_class`',
    `applicable_outlet_scope` STRING COMMENT 'Defines which F&B outlets can apply this discount: all_outlets (property-wide), specific_outlets (named outlets only), outlet_type (e.g., all restaurants, all bars).. Valid values are `all_outlets|specific_outlets|outlet_type`',
    `applies_to_service_charge` BOOLEAN COMMENT 'Indicates whether the discount is applied before or after service charge calculation. True if discount reduces service charge base, False if applied post-service-charge. Supports gratuity calculation rules.',
    `applies_to_tax` BOOLEAN COMMENT 'Indicates whether the discount is applied before or after tax calculation. True if discount reduces taxable amount, False if applied post-tax. Supports tax compliance and revenue recognition.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this discount configuration was approved for activation. Null if no approval required or pending approval. Supports authorization workflow and audit trail.',
    `authorization_level_required` STRING COMMENT 'Minimum staff authorization level required to apply this discount: none (no approval), server (server discretion), supervisor (shift supervisor), manager (outlet manager), director (F&B director), gm (general manager). Supports loss prevention and discount control.. Valid values are `none|server|supervisor|manager|director|gm`',
    `discount_category` STRING COMMENT 'Business classification grouping discounts by purpose: promotional (marketing campaign), loyalty (program benefit), employee (staff meal), vip (guest recognition), service_recovery (guest satisfaction), group (event/MICE), seasonal (time-based offer), other. [ENUM-REF-CANDIDATE: promotional|loyalty|employee|vip|service_recovery|group|seasonal|other — 8 candidates stripped; promote to reference product]',
    `discount_code` STRING COMMENT 'Unique alphanumeric code identifying the discount in the POS system. Used for transaction posting and reporting. Sourced from Oracle Hospitality MICROS POS discount configuration.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `combinable_with_other_discounts` BOOLEAN COMMENT 'Indicates whether this discount can be combined with other discounts on the same check. True if combinable, False if mutually exclusive. Supports discount stacking rules.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this discount configuration record was first created in the system. Supports audit trail and configuration history.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the discount amount (e.g., USD, EUR, GBP). Applicable when discount_amount is populated.. Valid values are `^[A-Z]{3}$`',
    `discount_description` STRING COMMENT 'Detailed description of the discount terms, conditions, and business purpose. Used for staff training and operational reference.',
    `discount_status` STRING COMMENT 'Current lifecycle state of the discount configuration: active (available for use), inactive (disabled), suspended (temporarily unavailable), expired (past validity period), pending_approval (awaiting authorization).. Valid values are `active|inactive|suspended|expired|pending_approval`',
    `discount_type` STRING COMMENT 'Classification of the discount mechanism: percentage (percent off), fixed_amount (dollar/currency off), complimentary (full comp), loyalty_redemption (points-based), employee_meal (staff benefit), manager_comp (manager discretionary comp).. Valid values are `percentage|fixed_amount|complimentary|loyalty_redemption|employee_meal|manager_comp`',
    `internal_notes` STRING COMMENT 'Internal operational notes for F&B management regarding discount usage, approval history, or special handling instructions. Not visible to guests.',
    `maximum_discount_amount_per_check` DECIMAL(18,2) COMMENT 'Maximum total discount amount that can be applied to a single check, regardless of check total. Null for no cap. Supports loss prevention and discount control.',
    `maximum_usage_per_check` STRING COMMENT 'Maximum number of times this discount can be applied to a single guest check. Null for unlimited usage. Supports discount control and loss prevention.',
    `maximum_usage_per_guest` STRING COMMENT 'Maximum number of times a single guest (identified by loyalty account or profile) can use this discount during the validity period. Null for unlimited. Supports promotional campaign tracking.',
    `minimum_check_amount` DECIMAL(18,2) COMMENT 'Minimum pre-discount check total required to qualify for this discount. Null if no minimum. Supports promotional campaign rules (e.g., $50 minimum for 20% off).',
    `modified_by` STRING COMMENT 'User ID or name of the staff member who last modified this discount configuration. Supports accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this discount configuration record was last modified. Supports change tracking and audit trail.',
    `discount_name` STRING COMMENT 'Business-friendly name of the discount or promotion displayed to staff and on guest receipts.',
    `percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the check or item (e.g., 15.00 for 15% off). Applicable when discount_type is percentage. Null for non-percentage discount types.',
    `promo_code_required` BOOLEAN COMMENT 'Indicates whether a promotional code must be entered by the guest or staff to activate this discount. True if promo code required, False if automatically available. Supports campaign tracking.',
    `revenue_class` STRING COMMENT 'Revenue classification for reporting purposes: food, beverage, alcohol, tobacco, other. Aligns with USALI F&B departmental reporting and supports revenue analysis.. Valid values are `food|beverage|alcohol|tobacco|other`',
    `valid_days_of_week` STRING COMMENT 'Comma-separated list of days when discount is applicable (e.g., Monday,Tuesday,Wednesday or All). Supports day-of-week restrictions for promotional campaigns.',
    `valid_from_date` DATE COMMENT 'Start date of the discount validity period. Discount becomes available for use on this date.',
    `valid_time_from` STRING COMMENT 'Start time of day when discount is applicable (HH:MM format, 24-hour). Supports daypart restrictions (e.g., happy hour, breakfast specials). Null if no time restriction.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `valid_time_to` STRING COMMENT 'End time of day when discount is applicable (HH:MM format, 24-hour). Supports daypart restrictions. Null if no time restriction.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `valid_to_date` DATE COMMENT 'End date of the discount validity period. Discount expires after this date. Null for open-ended discounts.',
    `created_by` STRING COMMENT 'User ID or name of the staff member who created this discount configuration. Supports accountability and audit trail.',
    CONSTRAINT pk_discount PRIMARY KEY(`discount_id`)
) COMMENT 'Master reference for F&B discount and promotion types applicable at POS, capturing discount name, discount type (percentage, fixed amount, complimentary, loyalty redemption, employee meal, manager comp, promotional offer), applicable outlet scope, applicable menu item scope, discount percentage or amount, authorization level required, validity period, and maximum usage limits. Supports discount control, loss prevention, and promotional campaign tracking. Sourced from Oracle Hospitality MICROS POS discount configuration.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` (
    `wine_cellar_id` BIGINT COMMENT 'Unique identifier for the wine cellar inventory record. Primary key for vintage-level wine and premium beverage tracking.',
    `inventory_item_id` BIGINT COMMENT 'Foreign key linking to fnb.inventory_item. Business justification: Wine cellar is specialized inventory tracking for premium beverages requiring vintage/bin management. Linking to inventory_item master enables integration with standard inventory processes (receiving,',
    `fnb_outlet_id` BIGINT COMMENT 'Identifier of the specific F&B outlet (restaurant, bar, banquet) that manages this wine inventory.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property where this wine cellar inventory is maintained.',
    `alcohol_by_volume_pct` DECIMAL(18,2) COMMENT 'Percentage of alcohol content by volume. Required for regulatory compliance and guest information.',
    `appellation` STRING COMMENT 'Geographic region or appellation of origin (e.g., Napa Valley, Bordeaux, Tuscany). Indicates terroir and quality designation.',
    `bin_location` STRING COMMENT 'Physical storage location identifier within the wine cellar (e.g., rack number, bin code). Enables efficient retrieval and inventory management.',
    `bottle_size_ml` STRING COMMENT 'Volume of the bottle in milliliters (e.g., 750, 1500, 375). Standard bottle is 750ml.',
    `by_the_glass_program_flag` BOOLEAN COMMENT 'Indicates whether this wine is available for individual glass pours. True if offered by the glass, False if bottle-only.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code of the wines origin (e.g., USA, FRA, ITA, AUS).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this wine cellar inventory record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `food_pairing_recommendations` STRING COMMENT 'Suggested food pairings and menu items that complement the wine. Supports upselling and guest experience enhancement.',
    `inventory_status` STRING COMMENT 'Current lifecycle status of the wine in the cellar inventory. Determines availability for ordering and wine list inclusion.. Valid values are `Active|Discontinued|Out of Stock|Allocated|Seasonal`',
    `last_inventory_count_date` DATE COMMENT 'Date of the most recent physical inventory count for this wine. Supports audit trail and shrinkage analysis.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order receipt for this wine. Supports aging and turnover analysis.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this wine cellar inventory record was most recently modified.',
    `optimal_drinking_window_end` STRING COMMENT 'Year when the wine is expected to pass its peak drinking quality. Guides inventory rotation and promotional timing.',
    `optimal_drinking_window_start` STRING COMMENT 'Year when the wine is expected to reach optimal maturity for consumption. Supports cellar aging strategy.',
    `par_level` STRING COMMENT 'Minimum inventory level that should be maintained. Triggers reorder when quantity on hand falls below this threshold.',
    `producer_name` STRING COMMENT 'Name of the winery, vineyard, or producer who created the wine.',
    `purchase_cost_per_bottle` DECIMAL(18,2) COMMENT 'Unit cost paid to supplier per bottle. Used for inventory valuation and food cost calculations.',
    `quantity_on_hand` STRING COMMENT 'Current number of bottles available in inventory. Updated by receipts, sales, and adjustments.',
    `quantity_reserved` STRING COMMENT 'Number of bottles reserved for upcoming events, banquets, or special orders. Not available for general sale.',
    `rating_source` STRING COMMENT 'Name of the publication or critic who provided the wine rating (e.g., Wine Spectator, Wine Advocate, Decanter).',
    `reorder_quantity` STRING COMMENT 'Standard quantity to order when inventory reaches par level. Optimized for supplier minimums and storage capacity.',
    `selling_price_bottle` DECIMAL(18,2) COMMENT 'Retail price charged to guests for a full bottle. Supports revenue management and menu pricing.',
    `selling_price_glass` DECIMAL(18,2) COMMENT 'Retail price charged to guests for a single glass pour. Applicable for by-the-glass program wines.',
    `sommelier_notes` STRING COMMENT 'Internal notes from the sommelier regarding optimal serving temperature, decanting requirements, aging potential, or special handling instructions.',
    `storage_temperature_celsius` DECIMAL(18,2) COMMENT 'Recommended storage temperature in Celsius for optimal preservation. Supports cellar climate control compliance.',
    `supplier_name` STRING COMMENT 'Name of the distributor or supplier from whom the wine is purchased.',
    `tasting_notes` STRING COMMENT 'Sommelier-curated description of the wines flavor profile, aroma, body, and finish. Used for wine list descriptions and staff training.',
    `varietal` STRING COMMENT 'Grape variety or blend composition (e.g., Cabernet Sauvignon, Chardonnay, Bordeaux Blend).',
    `vintage_year` STRING COMMENT 'Year the grapes were harvested. Critical for vintage-level tracking and valuation. Non-vintage wines may use a standard code (e.g., 9999).',
    `wine_list_category` STRING COMMENT 'Classification for wine list organization and guest navigation. Supports menu design and pricing strategy.. Valid values are `House Selection|Premium|Reserve|Rare & Collectible|Sommeliers Choice|Sustainable & Organic`',
    `wine_name` STRING COMMENT 'Full name of the wine as it appears on the label and wine list.',
    `wine_rating_score` STRING COMMENT 'Professional critic rating or score (e.g., Wine Spectator, Robert Parker). Typically on a 100-point scale. Used for marketing and wine list positioning.',
    `wine_type` STRING COMMENT 'Classification of wine by style and production method.. Valid values are `Red|White|Rosé|Sparkling|Dessert|Fortified`',
    CONSTRAINT pk_wine_cellar PRIMARY KEY(`wine_cellar_id`)
) COMMENT 'Master inventory record for property wine cellars and premium beverage collections requiring vintage-level tracking and sommelier-driven lifecycle management. Captures wine name, producer, vintage year, varietal, appellation/region, bin location, quantity on hand, quantity reserved, purchase cost, selling price (bottle and glass), par level, reorder quantity, tasting notes, food pairing recommendations, and sommelier notes. Supports cellar management, wine list curation, by-the-glass program management, and premium beverage cost control. Distinct from general F&B inventory due to vintage tracking, bin management, and sommelier-driven curation lifecycle that general inventory workflows cannot support.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` (
    `food_safety_inspection_id` BIGINT COMMENT 'Unique identifier for the food safety inspection record. Primary key.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Food safety inspections requiring corrective actions must link to compliance.corrective_action for CAPA tracking, verification of completion, and regulatory follow-up. Natural 1:N where inspection ref',
    `fnb_outlet_id` BIGINT COMMENT 'Identifier of the specific F&B outlet or kitchen facility inspected (restaurant, bar, banquet kitchen, room service kitchen, etc.).',
    `property_id` BIGINT COMMENT 'Identifier of the property where the inspection took place.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Health department inspections require documented manager accountability for corrective actions and regulatory compliance. Essential for OSHA/health authority reporting, performance reviews, and legal ',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` (
    `waste_log_id` BIGINT COMMENT 'Primary key for waste_log',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Waste must be allocated to responsible cost centers for variance analysis and cost control. Waste_log links to outlet/revenue_center but needs cost_center for expense allocation, enabling managers to ',
    `environmental_compliance_id` BIGINT COMMENT 'Foreign key linking to compliance.environmental_compliance. Business justification: Waste disposal tracking must link to environmental compliance permits for regulatory reporting, waste diversion metrics, and sustainability audits. Natural 1:N where waste log references the environme',
    `inventory_item_id` BIGINT COMMENT 'Foreign key linking to fnb.inventory_item. Business justification: Waste log currently has waste_item_name and waste_item_code as strings but no FK to inventory_item master. Normalizing to inventory_item enables accurate waste cost tracking, inventory variance analys',
    `fnb_outlet_id` BIGINT COMMENT 'Identifier of the F&B outlet or kitchen where the waste occurred.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Waste posts to specific expense GL accounts for P&L impact tracking. Direct ledger link enables automated waste expense posting, supports food cost variance analysis, and ensures accurate financial re',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to fnb.menu_item. Business justification: Waste can occur at finished menu item level (prepared dish not served, returned by guest, expired buffet item). This FK enables tracking waste by menu item for menu engineering analysis and portion co',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who recorded the waste event.',
    `property_id` BIGINT COMMENT 'Identifier of the property where the waste event occurred.',
    `revenue_center_id` BIGINT COMMENT 'Identifier of the revenue center associated with the waste event for USALI reporting.',
    `batch_number` STRING COMMENT 'The batch or lot number of the wasted item, used for traceability and recall management.',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective action taken in response to the waste event to prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the waste log record was first created in the system, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the waste cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `disposal_method` STRING COMMENT 'The method used to dispose of the waste (landfill, compost, recycling, donation, waste-to-energy, incineration) for sustainability reporting.. Valid values are `landfill|compost|recycling|donation|waste_to_energy|incineration`',
    `expiry_date` DATE COMMENT 'The expiration date of the wasted item, if applicable, in format yyyy-MM-dd.',
    `food_category` STRING COMMENT 'The food category of the wasted item (protein, dairy, produce, bakery, dry goods, beverage, condiment, prepared dish) for detailed cost analysis. [ENUM-REF-CANDIDATE: protein|dairy|produce|bakery|dry_goods|beverage|condiment|prepared_dish — 8 candidates stripped; promote to reference product]',
    `health_safety_incident_flag` BOOLEAN COMMENT 'Indicates whether the waste event was associated with a health or safety incident requiring regulatory reporting.',
    `iso_22000_compliant_flag` BOOLEAN COMMENT 'Indicates whether the waste event was handled in compliance with ISO 22000 food safety standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the waste log record was last modified, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `meal_period` STRING COMMENT 'The meal period or service type during which the waste occurred (breakfast, lunch, dinner, banquet, room service, bar).. Valid values are `breakfast|lunch|dinner|banquet|room_service|bar`',
    `notes` STRING COMMENT 'Additional notes or comments related to the waste event, providing supplementary context.',
    `quantity_wasted` DECIMAL(18,2) COMMENT 'The quantity of the item wasted, expressed in the unit of measure for the item.',
    `recording_staff_name` STRING COMMENT 'Name of the staff member who recorded the waste event.',
    `storage_location` STRING COMMENT 'The storage location (e.g., walk-in cooler, dry storage, bar) where the wasted item was stored prior to waste.',
    `sustainability_impact_flag` BOOLEAN COMMENT 'Indicates whether this waste event has been flagged for sustainability impact reporting or waste reduction initiatives.',
    `total_waste_cost` DECIMAL(18,2) COMMENT 'The total cost of the waste event, calculated as quantity wasted multiplied by unit cost.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of the wasted item, used to calculate total waste cost.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the wasted quantity (kg, lb, oz, g, liter, gallon, each, portion, case, bottle). [ENUM-REF-CANDIDATE: kg|lb|oz|g|liter|gallon|each|portion|case|bottle — 10 candidates stripped; promote to reference product]',
    `waste_category` STRING COMMENT 'The category of waste event: food spoilage, over-production, plate waste (customer leftovers), breakage, expired stock, or preparation error.. Valid values are `food_spoilage|over_production|plate_waste|breakage|expired_stock|preparation_error`',
    `waste_date` DATE COMMENT 'The date on which the waste event was recorded, in format yyyy-MM-dd.',
    `waste_reason` STRING COMMENT 'Detailed explanation or reason for the waste event, providing context for operational improvement and root cause analysis.',
    `waste_status` STRING COMMENT 'The current status of the waste log entry in the review and approval workflow (recorded, reviewed, approved, disputed, closed).. Valid values are `recorded|reviewed|approved|disputed|closed`',
    `waste_timestamp` TIMESTAMP COMMENT 'The precise date and time when the waste event occurred, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `waste_type` STRING COMMENT 'The type of waste: food, beverage, supplies, or packaging.. Valid values are `food|beverage|supplies|packaging`',
    CONSTRAINT pk_waste_log PRIMARY KEY(`waste_log_id`)
) COMMENT 'Food and beverage waste and spoilage log capturing daily waste events by outlet and kitchen, recording waste item, waste category (food spoilage, over-production, plate waste, breakage, expired stock), quantity wasted, unit cost, total waste cost, waste reason, meal period, outlet, and recording staff. Supports food cost variance analysis, sustainability reporting, waste reduction initiatives, and ISO 22000 food safety compliance. Distinct from stock transactions as it captures the reason and category of waste for operational improvement.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` (
    `fnb_supply_agreement_id` BIGINT COMMENT 'Primary key for fnb_supply_agreement',
    `inventory_item_id` BIGINT COMMENT 'Foreign key linking to the F&B inventory item being supplied under this agreement',
    `procurement_supply_agreement_id` BIGINT COMMENT 'Unique identifier for this supply agreement record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor supplying the item under this agreement',
    `agreement_end_date` DATE COMMENT 'Date when this supply agreement expires or was terminated. Null for ongoing agreements. Used for contract renewal planning and vendor relationship lifecycle management.',
    `agreement_start_date` DATE COMMENT 'Date when this supply agreement became effective. Used for contract management and historical tracking of vendor-item relationships.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of this supply agreement. Active agreements are available for procurement. Inactive or suspended agreements are not used for new orders but retained for historical reference.',
    `last_purchase_cost` DECIMAL(18,2) COMMENT 'Actual unit cost from the most recent purchase order with this vendor for this item. Used for cost variance analysis and price trend tracking. Historical data point for this specific supply relationship.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order placed with this vendor for this item. Used for supplier performance tracking and relationship management. Specific to this vendor-item pair.',
    `lead_time_days` STRING COMMENT 'Number of days from purchase order submission to delivery for this vendor-item combination. Critical for inventory planning and reorder point calculations. Varies by vendor.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered from this vendor for this item. Vendor-specific constraint that affects procurement batch sizing and inventory holding costs.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred/primary supplier for this item among multiple sourcing options. Used to prioritize vendors in automated procurement workflows while maintaining multi-sourcing capability.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Negotiated unit cost for this item from this specific vendor. Used for cost comparison across vendors and procurement decision-making. Varies by vendor for the same item.',
    `vendor_item_code` STRING COMMENT 'Suppliers unique identifier for this item. Used for purchase order line item matching and invoice reconciliation. This code is specific to the vendor-item combination.',
    CONSTRAINT pk_fnb_supply_agreement PRIMARY KEY(`fnb_supply_agreement_id`)
) COMMENT 'This association product represents the contractual supply relationship between F&B inventory items and vendors. It captures vendor-specific sourcing terms, pricing, lead times, and purchase history for each item-vendor combination. Each record links one inventory item to one vendor with attributes that exist only in the context of this specific supply relationship, enabling multi-sourcing strategies, cost optimization, and supply continuity management.. Existence Justification: In hotel F&B operations, inventory items are routinely sourced from multiple vendors to ensure supply continuity, optimize costs, and manage risk. A single item (e.g., olive oil) may have a primary supplier, a backup supplier, and spot market vendors, each with different pricing, lead times, and minimum order quantities. Conversely, each vendor supplies hundreds of different F&B items. This is an operational multi-sourcing strategy actively managed by procurement teams.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Primary key for storage_location',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Storage locations belong to specific F&B outlets. The storage_location table has outlet_id (BIGINT) which is clearly intended to be a FK to fnb_outlet but uses non-standard naming. Standardizing to fn',
    `parent_storage_location_id` BIGINT COMMENT 'Self-referencing FK on storage_location (parent_storage_location_id)',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where this storage location is physically located.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically F&B manager or chef) responsible for managing inventory in this storage location.',
    `access_restriction_level` STRING COMMENT 'Security classification defining who has authorized access to this storage location for inventory control and loss prevention.',
    `active_from_date` DATE COMMENT 'Date from which this storage location became operational and available for inventory storage.',
    `active_until_date` DATE COMMENT 'Date until which this storage location is scheduled to remain operational. Null for indefinite operation.',
    `allergen_segregation_required_flag` BOOLEAN COMMENT 'Indicates whether this location requires allergen segregation protocols to prevent cross-contamination per food safety standards.',
    `barcode` STRING COMMENT 'Barcode identifier used for scanning and tracking inventory movements to and from this storage location.',
    `building_name` STRING COMMENT 'Name of the building or structure where the storage location is situated within the property.',
    `capacity_cubic_meters` DECIMAL(18,2) COMMENT 'Total storage capacity of the location measured in cubic meters for space planning and inventory management.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which inventory stored in this location is allocated for USALI departmental reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when this storage location was permanently decommissioned and removed from active inventory use.',
    `decommission_reason` STRING COMMENT 'Business reason for decommissioning this storage location (e.g., renovation, consolidation, safety concerns).',
    `floor_level` STRING COMMENT 'Floor or level designation where the storage location is located (e.g., Basement, Ground, 1st Floor).',
    `hazmat_approved_flag` BOOLEAN COMMENT 'Indicates whether this storage location is approved for storing hazardous materials such as cleaning chemicals per safety regulations.',
    `inspection_frequency_days` STRING COMMENT 'Required frequency in days between mandatory inspections for this storage location per food safety compliance requirements.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent food safety or health inspection conducted for this storage location.',
    `location_code` STRING COMMENT 'Unique business identifier code for the storage location used in inventory and procurement systems.',
    `location_name` STRING COMMENT 'Human-readable name of the storage location (e.g., Main Kitchen Dry Storage, Bar Cooler 1, Banquet Freezer).',
    `location_type` STRING COMMENT 'Classification of the storage location based on storage conditions and purpose.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory food safety or health inspection of this storage location.',
    `notes` STRING COMMENT 'Additional operational notes, special handling instructions, or remarks about this storage location.',
    `primary_use_description` STRING COMMENT 'Detailed description of the primary intended use and contents of this storage location for operational reference.',
    `rfid_tag` STRING COMMENT 'RFID tag identifier for automated inventory tracking and access control at this storage location.',
    `room_number` STRING COMMENT 'Specific room or area number designation for the storage location within the building.',
    `storage_category` STRING COMMENT 'Primary category of items stored in this location for inventory segregation and food safety compliance.',
    `storage_location_status` STRING COMMENT 'Current operational status of the storage location in the inventory management system.',
    `target_temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum target temperature in Celsius for temperature-controlled storage locations to maintain food safety standards.',
    `target_temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum target temperature in Celsius for temperature-controlled storage locations to maintain food safety standards.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this storage location requires temperature control for food safety compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was last modified in the system.',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Master reference table for storage_location. Referenced by source_location_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` (
    `physical_count_id` BIGINT COMMENT 'Primary key for physical_count',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Physical counts are performed at specific F&B outlets. The physical_count table has outlet_id (BIGINT) which is clearly intended to be a FK to fnb_outlet but uses non-standard naming. Standardizing to',
    `parent_physical_count_id` BIGINT COMMENT 'Reference to the original physical count if this record represents a recount or follow-up count, establishing the audit trail.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who provided final approval of the physical count, typically a department head or controller.',
    `physical_counter_employee_id` BIGINT COMMENT 'Reference to the employee who performed the physical count, ensuring accountability and traceability.',
    `physical_supervisor_employee_id` BIGINT COMMENT 'Reference to the supervisor or manager who reviewed and approved the physical count results.',
    `primary_recount_physical_count_id` BIGINT COMMENT 'Self-referencing FK on physical_count (recount_physical_count_id)',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or vacation property where the physical count is conducted.',
    `adjustment_posted` BOOLEAN COMMENT 'Indicates whether the inventory adjustments resulting from this physical count have been posted to the general ledger and inventory system (True if posted).',
    `adjustment_posted_timestamp` TIMESTAMP COMMENT 'The date and time when the inventory adjustments were posted to the financial and inventory systems.',
    `adjustment_required` BOOLEAN COMMENT 'Indicates whether inventory adjustments are required to reconcile the physical count with the system book quantities (True if variances exist and adjustments are needed).',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the physical count was officially approved and accepted into the inventory system.',
    `compliance_verified` BOOLEAN COMMENT 'Indicates whether the physical count procedures and results have been verified for compliance with ISO 22000 food safety standards and USALI reporting requirements (True if verified).',
    `count_date` DATE COMMENT 'The business date (day-level) on which the physical count was performed, used for period-end reporting and financial close alignment.',
    `count_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the physical count activity was completed, marking the end of the inventory freeze period.',
    `count_method` STRING COMMENT 'The method used to perform the physical count: manual (visual count and paper recording), barcode_scan (handheld scanner), rfid (radio frequency identification), weight_scale (automated weighing), hybrid (combination of methods).',
    `count_number` STRING COMMENT 'Business identifier for the physical count event, typically formatted as PC-YYYYMMDD-NNNN for traceability and audit purposes.',
    `count_reason` STRING COMMENT 'The business reason or trigger for this physical count event (e.g., Month-end close, Annual audit, Suspected theft, System migration, New outlet opening).',
    `count_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the physical count activity began, marking the start of the inventory freeze period.',
    `count_status` STRING COMMENT 'Current lifecycle status of the physical count event: scheduled (planned but not started), in_progress (counting underway), completed (count finished, pending review), approved (verified and accepted), rejected (discrepancies require recount), cancelled (count aborted).',
    `count_type` STRING COMMENT 'Classification of the physical count: full (complete inventory), partial (selected items), cycle (scheduled rotation), spot (random check), variance_recount (follow-up after discrepancy), opening (new outlet), closing (outlet shutdown).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this physical count record was first created in the system, used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this physical count (e.g., USD, EUR, GBP).',
    `fiscal_period` STRING COMMENT 'The fiscal year and month (YYYY-MM format) to which this physical count is assigned for accounting and variance analysis purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this physical count record was most recently updated, tracking all changes for audit and compliance purposes.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the physical count, including explanations for variances, operational issues encountered, or special circumstances.',
    `pos_system_integration` STRING COMMENT 'The POS system from which inventory consumption data is sourced for variance analysis: oracle_micros (Oracle Hospitality MICROS), simphony (Oracle MICROS Simphony), opera (Oracle OPERA Property Management), manual (no system integration), other (third-party system).',
    `recount_reason` STRING COMMENT 'Explanation for why a recount was required, such as variance exceeds threshold, counting errors detected, or supervisor challenge.',
    `recount_required` BOOLEAN COMMENT 'Indicates whether a recount is required due to significant variances, procedural errors, or supervisor review findings (True if recount needed).',
    `scheduled_date` DATE COMMENT 'The date on which the physical count was originally scheduled to occur, used for planning and compliance tracking.',
    `storage_location` STRING COMMENT 'The specific storage area, storeroom, or inventory location where the physical count was performed (e.g., Main Kitchen Dry Store, Bar Cellar, Banquet Freezer).',
    `total_items_counted` STRING COMMENT 'The total number of distinct inventory items (SKUs) included in this physical count event.',
    `total_variance_items` STRING COMMENT 'The number of inventory items where the physical count differed from the system book quantity, requiring investigation.',
    `total_variance_value` DECIMAL(18,2) COMMENT 'The aggregate monetary value of all inventory variances (positive and negative) identified during the physical count, used for shrinkage and loss analysis.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance value expressed as a percentage of the total book inventory value, used as a key performance indicator for inventory accuracy.',
    CONSTRAINT pk_physical_count PRIMARY KEY(`physical_count_id`)
) COMMENT 'Master reference table for physical_count. Referenced by physical_count_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ADD CONSTRAINT `fk_fnb_menu_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ADD CONSTRAINT `fk_fnb_menu_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ADD CONSTRAINT `fk_fnb_menu_item_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ADD CONSTRAINT `fk_fnb_menu_item_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu`(`menu_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ADD CONSTRAINT `fk_fnb_menu_item_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ADD CONSTRAINT `fk_fnb_recipe_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ADD CONSTRAINT `fk_fnb_recipe_ingredient_inventory_item_id` FOREIGN KEY (`inventory_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`inventory_item`(`inventory_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ADD CONSTRAINT `fk_fnb_recipe_ingredient_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_discount_id` FOREIGN KEY (`discount_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`discount`(`discount_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ADD CONSTRAINT `fk_fnb_pos_check_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_discount_id` FOREIGN KEY (`discount_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`discount`(`discount_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_parent_line_pos_check_line_id` FOREIGN KEY (`parent_line_pos_check_line_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line`(`pos_check_line_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ADD CONSTRAINT `fk_fnb_pos_check_line_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ADD CONSTRAINT `fk_fnb_revenue_center_parent_revenue_center_id` FOREIGN KEY (`parent_revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ADD CONSTRAINT `fk_fnb_void_transaction_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ADD CONSTRAINT `fk_fnb_void_transaction_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ADD CONSTRAINT `fk_fnb_void_transaction_pos_check_line_id` FOREIGN KEY (`pos_check_line_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line`(`pos_check_line_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ADD CONSTRAINT `fk_fnb_room_service_order_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_banquet_menu_package_id` FOREIGN KEY (`banquet_menu_package_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package`(`banquet_menu_package_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ADD CONSTRAINT `fk_fnb_banquet_event_order_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ADD CONSTRAINT `fk_fnb_banquet_menu_package_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_inventory_item_id` FOREIGN KEY (`inventory_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`inventory_item`(`inventory_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_original_transaction_stock_transaction_id` FOREIGN KEY (`original_transaction_stock_transaction_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction`(`stock_transaction_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_physical_count_id` FOREIGN KEY (`physical_count_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`physical_count`(`physical_count_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_pos_check_id` FOREIGN KEY (`pos_check_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`pos_check`(`pos_check_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`recipe`(`recipe_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ADD CONSTRAINT `fk_fnb_stock_transaction_stock_fnb_outlet_id` FOREIGN KEY (`stock_fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ADD CONSTRAINT `fk_fnb_wine_cellar_inventory_item_id` FOREIGN KEY (`inventory_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`inventory_item`(`inventory_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ADD CONSTRAINT `fk_fnb_wine_cellar_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ADD CONSTRAINT `fk_fnb_food_safety_inspection_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ADD CONSTRAINT `fk_fnb_waste_log_inventory_item_id` FOREIGN KEY (`inventory_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`inventory_item`(`inventory_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ADD CONSTRAINT `fk_fnb_waste_log_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ADD CONSTRAINT `fk_fnb_waste_log_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`menu_item`(`menu_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ADD CONSTRAINT `fk_fnb_waste_log_revenue_center_id` FOREIGN KEY (`revenue_center_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`revenue_center`(`revenue_center_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ADD CONSTRAINT `fk_fnb_fnb_supply_agreement_inventory_item_id` FOREIGN KEY (`inventory_item_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`inventory_item`(`inventory_item_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ADD CONSTRAINT `fk_fnb_storage_location_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ADD CONSTRAINT `fk_fnb_storage_location_parent_storage_location_id` FOREIGN KEY (`parent_storage_location_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ADD CONSTRAINT `fk_fnb_physical_count_fnb_outlet_id` FOREIGN KEY (`fnb_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`(`fnb_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ADD CONSTRAINT `fk_fnb_physical_count_parent_physical_count_id` FOREIGN KEY (`parent_physical_count_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`physical_count`(`physical_count_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ADD CONSTRAINT `fk_fnb_physical_count_primary_recount_physical_count_id` FOREIGN KEY (`primary_recount_physical_count_id`) REFERENCES `vibe_travel_hospitality_v1`.`fnb`.`physical_count`(`physical_count_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`fnb` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`fnb` SET TAGS ('dbx_domain' = 'fnb');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_subdomain' = 'outlet_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_ssot_reference' = 'property.property_outlet');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_mvm_ssot_role' = 'referencing');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_ssot_concept' = 'outlet');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_ssot_references' = 'property.property_outlet');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_ssot' = 'alias');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_ssot_authority_defer_to' = 'property.property_outlet');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_ssot_ref' = 'property.property_outlet');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_ssot_group' = 'outlet');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_ssot_canonical' = 'property.property_outlet');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` SET TAGS ('dbx_subdomain' = 'menu_catalog');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu` ALTER COLUMN `revenue_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` SET TAGS ('dbx_subdomain' = 'menu_catalog');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`menu_item` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier ID');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` SET TAGS ('dbx_subdomain' = 'menu_catalog');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe` ALTER COLUMN `food_safety_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Cert Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` SET TAGS ('dbx_subdomain' = 'menu_catalog');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `recipe_ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Ingredient ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `inventory_item_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `allergen_contribution` SET TAGS ('dbx_business_glossary_term' = 'Allergen Contribution');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `critical_control_point_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point (CCP) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `extended_cost` SET TAGS ('dbx_business_glossary_term' = 'Extended Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `extended_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `ingredient_category` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `local_sourcing_flag` SET TAGS ('dbx_business_glossary_term' = 'Local Sourcing Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `nutritional_value_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Value Per Unit');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Par Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `preparation_instruction` SET TAGS ('dbx_business_glossary_term' = 'Preparation Instruction');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `quantity_required` SET TAGS ('dbx_business_glossary_term' = 'Quantity Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `seasonality_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `standard_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Per Unit');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `standard_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `storage_requirement` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirement');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `storage_requirement` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|dry_storage|temperature_controlled');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `storage_requirement` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `traceability_code` SET TAGS ('dbx_business_glossary_term' = 'Traceability Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `waste_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`recipe_ingredient` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` SET TAGS ('dbx_subdomain' = 'outlet_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Check ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `discount_id` SET TAGS ('dbx_business_glossary_term' = 'Discount Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `guest_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Server Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `tertiary_pos_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `tertiary_pos_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `tertiary_pos_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check` ALTER COLUMN `tertiary_pos_manager_employee_id` SET TAGS ('dbx_pii_tracked' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` SET TAGS ('dbx_subdomain' = 'outlet_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `pos_check_line_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Check Line ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `discount_id` SET TAGS ('dbx_business_glossary_term' = 'Discount Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Promotion Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `parent_line_pos_check_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Line ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Check ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `revenue_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Voided By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`pos_check_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` SET TAGS ('dbx_subdomain' = 'outlet_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `revenue_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `parent_revenue_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Revenue Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `allergen_menu_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Menu Available Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `average_check_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Check Target Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `average_check_target_amount` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `beverage_cost_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Beverage Cost Target Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `beverage_cost_target_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `covers_per_day_target` SET TAGS ('dbx_business_glossary_term' = 'Covers Per Day Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `cuisine_type` SET TAGS ('dbx_business_glossary_term' = 'Cuisine Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `day_part_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Day Part Service Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `dress_code` SET TAGS ('dbx_business_glossary_term' = 'Dress Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `dress_code` SET TAGS ('dbx_value_regex' = 'casual|smart_casual|business_casual|formal|resort_casual|no_code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `food_cost_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Food Cost Target Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `food_cost_target_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `gratuity_policy` SET TAGS ('dbx_business_glossary_term' = 'Gratuity Policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `gratuity_policy` SET TAGS ('dbx_value_regex' = 'included|optional|not_applicable|automatic_for_groups');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `iso_22000_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 22000 Certified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `labor_cost_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Target Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `labor_cost_target_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `micros_rvc_number` SET TAGS ('dbx_business_glossary_term' = 'Oracle Hospitality MICROS Revenue Center (RVC) Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `revenue_center_name` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `operating_hours_description` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `outlet_type` SET TAGS ('dbx_business_glossary_term' = 'Outlet Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `pos_integration_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Integration Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `reporting_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Reporting Hierarchy Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `reservation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reservation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `revenue_category` SET TAGS ('dbx_value_regex' = 'food_revenue|beverage_revenue|other_fnb_revenue|banquet_food_revenue|banquet_beverage_revenue|minibar_revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `revenue_center_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `revenue_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|under_renovation|temporarily_closed|permanently_closed');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `room_charge_posting_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Room Charge Posting Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `service_charge_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `service_charge_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `tax_rate_group_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Group Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `tax_rate_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform System of Accounts for the Lodging Industry (USALI) Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2,4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `usali_revenue_center_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform System of Accounts for the Lodging Industry (USALI) Revenue Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`revenue_center` ALTER COLUMN `usali_revenue_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` SET TAGS ('dbx_subdomain' = 'outlet_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `void_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Void Transaction Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Check ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `pos_check_line_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Check Line Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Void Initiated By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `covers_count` SET TAGS ('dbx_business_glossary_term' = 'Covers Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `day_part` SET TAGS ('dbx_business_glossary_term' = 'Day Part');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `day_part` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|all_day');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `is_employee_meal` SET TAGS ('dbx_business_glossary_term' = 'Is Employee Meal');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `is_manager_meal` SET TAGS ('dbx_business_glossary_term' = 'Is Manager Meal');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `is_manager_meal` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `original_check_number` SET TAGS ('dbx_business_glossary_term' = 'Original Check Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `original_transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `requires_investigation` SET TAGS ('dbx_business_glossary_term' = 'Requires Investigation');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `source_system_transaction_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `table_number` SET TAGS ('dbx_business_glossary_term' = 'Table Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `void_number` SET TAGS ('dbx_business_glossary_term' = 'Void Transaction Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `void_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `void_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Void Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `void_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Void Reason Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `void_status` SET TAGS ('dbx_business_glossary_term' = 'Void Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `void_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|completed|reversed');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `void_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Void Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `void_type` SET TAGS ('dbx_business_glossary_term' = 'Void Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `void_type` SET TAGS ('dbx_value_regex' = 'item_void|check_void|payment_void|discount_void|service_charge_void|tax_void');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `voided_amount` SET TAGS ('dbx_business_glossary_term' = 'Voided Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `voided_quantity` SET TAGS ('dbx_business_glossary_term' = 'Voided Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `voided_service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Voided Service Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `voided_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Voided Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`void_transaction` ALTER COLUMN `voided_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Voided Total Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` SET TAGS ('dbx_subdomain' = 'outlet_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `room_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Room Service Order ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Check Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Server Staff ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `revenue_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Appointment Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`room_service_order` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` SET TAGS ('dbx_subdomain' = 'banquet_catering');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `banquet_event_order_id` SET TAGS ('dbx_business_glossary_term' = 'Banquet Event Order (BEO) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `banquet_menu_package_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Package ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `banquet_menu_package_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Offer Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `guest_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Organizer Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Package Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `package_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Check Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `revenue_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `actual_covers` SET TAGS ('dbx_business_glossary_term' = 'Actual Covers');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `beo_number` SET TAGS ('dbx_business_glossary_term' = 'Banquet Event Order (BEO) Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `beverage_package_type` SET TAGS ('dbx_business_glossary_term' = 'Beverage Package Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `beverage_package_type` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `beverage_revenue` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Beverage Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `beverage_revenue` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `billing_instructions` SET TAGS ('dbx_business_glossary_term' = 'Billing Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `dietary_requirements` SET TAGS ('dbx_business_glossary_term' = 'Dietary Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `event_end_time` SET TAGS ('dbx_business_glossary_term' = 'Event End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `event_start_time` SET TAGS ('dbx_business_glossary_term' = 'Event Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|in_progress|completed|cancelled|no_show');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `food_revenue` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Food Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `guaranteed_covers` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Covers');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `per_person_beverage_price` SET TAGS ('dbx_business_glossary_term' = 'Per Person Beverage Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `per_person_beverage_price` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `per_person_food_price` SET TAGS ('dbx_business_glossary_term' = 'Per Person Food Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `service_charge_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `service_charge_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `setup_style` SET TAGS ('dbx_business_glossary_term' = 'Setup Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `tax_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `tax_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order` ALTER COLUMN `total_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` SET TAGS ('dbx_subdomain' = 'banquet_catering');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `banquet_menu_package_id` SET TAGS ('dbx_business_glossary_term' = 'Banquet Menu Package ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `banquet_menu_package_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `advance_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Notice Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `allergen_information` SET TAGS ('dbx_business_glossary_term' = 'Allergen Information');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `beverage_cost_percentage` SET TAGS ('dbx_business_glossary_term' = 'Beverage Cost Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `beverage_cost_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `beverage_cost_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `beverage_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Beverage Duration Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `beverage_duration_hours` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `beverage_inclusion` SET TAGS ('dbx_business_glossary_term' = 'Beverage Inclusion');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `beverage_inclusion` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `cancellation_policy` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `dietary_accommodations` SET TAGS ('dbx_business_glossary_term' = 'Dietary Accommodations');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `food_cost_percentage` SET TAGS ('dbx_business_glossary_term' = 'Food Cost Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `food_cost_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `food_cost_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `included_courses` SET TAGS ('dbx_business_glossary_term' = 'Included Courses');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `labor_hours_per_guest` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours Per Guest');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `maximum_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `maximum_capacity` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `menu_category` SET TAGS ('dbx_business_glossary_term' = 'Menu Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `menu_category` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|break|reception|specialty');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `minimum_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `package_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `package_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `package_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `package_notes` SET TAGS ('dbx_business_glossary_term' = 'Package Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `package_notes` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `package_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|discontinued|pending approval');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `package_status` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'breakfast package|lunch buffet|dinner gala|coffee break|cocktail reception|wedding package');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `package_type` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `per_person_price` SET TAGS ('dbx_business_glossary_term' = 'Per Person Price');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `season_description` SET TAGS ('dbx_business_glossary_term' = 'Season Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `seasonal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `service_charge_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `service_charge_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `service_style` SET TAGS ('dbx_business_glossary_term' = 'Service Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `service_style` SET TAGS ('dbx_value_regex' = 'buffet|plated|family style|stations|reception|cocktail');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `setup_requirements` SET TAGS ('dbx_business_glossary_term' = 'Setup Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `tax_inclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Inclusive Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` SET TAGS ('dbx_subdomain' = 'supply_inventory');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `inventory_item_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Item Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`inventory_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` SET TAGS ('dbx_subdomain' = 'supply_inventory');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `stock_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transaction Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `inventory_item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `original_transaction_stock_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Transaction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Manager ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `stock_fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`stock_transaction` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` SET TAGS ('dbx_subdomain' = 'outlet_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `discount_id` SET TAGS ('dbx_business_glossary_term' = 'Discount Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Offer Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Fixed Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `applicable_menu_item_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicable Menu Item Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `applicable_menu_item_scope` SET TAGS ('dbx_value_regex' = 'all_items|specific_items|menu_category|revenue_class');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `applicable_outlet_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicable Outlet Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `applicable_outlet_scope` SET TAGS ('dbx_value_regex' = 'all_outlets|specific_outlets|outlet_type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `applies_to_service_charge` SET TAGS ('dbx_business_glossary_term' = 'Applies To Service Charge');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `applies_to_tax` SET TAGS ('dbx_business_glossary_term' = 'Applies To Tax');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `authorization_level_required` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `authorization_level_required` SET TAGS ('dbx_value_regex' = 'none|server|supervisor|manager|director|gm');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `discount_category` SET TAGS ('dbx_business_glossary_term' = 'Discount Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `discount_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `discount_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `combinable_with_other_discounts` SET TAGS ('dbx_business_glossary_term' = 'Combinable With Other Discounts');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `discount_description` SET TAGS ('dbx_business_glossary_term' = 'Discount Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `discount_status` SET TAGS ('dbx_business_glossary_term' = 'Discount Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `discount_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired|pending_approval');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|complimentary|loyalty_redemption|employee_meal|manager_comp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `maximum_discount_amount_per_check` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount Per Check');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `maximum_usage_per_check` SET TAGS ('dbx_business_glossary_term' = 'Maximum Usage Per Check');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `maximum_usage_per_check` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `maximum_usage_per_guest` SET TAGS ('dbx_business_glossary_term' = 'Maximum Usage Per Guest');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `maximum_usage_per_guest` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `minimum_check_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Check Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `discount_name` SET TAGS ('dbx_business_glossary_term' = 'Discount Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `promo_code_required` SET TAGS ('dbx_business_glossary_term' = 'Promo Code Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `revenue_class` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `revenue_class` SET TAGS ('dbx_value_regex' = 'food|beverage|alcohol|tobacco|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `valid_days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Valid Days of Week');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `valid_time_from` SET TAGS ('dbx_business_glossary_term' = 'Valid Time From');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `valid_time_from` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `valid_time_to` SET TAGS ('dbx_business_glossary_term' = 'Valid Time To');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `valid_time_to` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`discount` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` SET TAGS ('dbx_subdomain' = 'supply_inventory');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `wine_cellar_id` SET TAGS ('dbx_business_glossary_term' = 'Wine Cellar ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `inventory_item_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Inventory Item Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `alcohol_by_volume_pct` SET TAGS ('dbx_business_glossary_term' = 'Alcohol By Volume (ABV) Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `appellation` SET TAGS ('dbx_business_glossary_term' = 'Appellation');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `bin_location` SET TAGS ('dbx_business_glossary_term' = 'Bin Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `bottle_size_ml` SET TAGS ('dbx_business_glossary_term' = 'Bottle Size (Milliliters)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `by_the_glass_program_flag` SET TAGS ('dbx_business_glossary_term' = 'By-The-Glass Program Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `food_pairing_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Food Pairing Recommendations');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'Active|Discontinued|Out of Stock|Allocated|Seasonal');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `last_inventory_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Count Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `optimal_drinking_window_end` SET TAGS ('dbx_business_glossary_term' = 'Optimal Drinking Window End Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `optimal_drinking_window_start` SET TAGS ('dbx_business_glossary_term' = 'Optimal Drinking Window Start Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Par Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `producer_name` SET TAGS ('dbx_business_glossary_term' = 'Producer Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `purchase_cost_per_bottle` SET TAGS ('dbx_business_glossary_term' = 'Purchase Cost Per Bottle');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `purchase_cost_per_bottle` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `rating_source` SET TAGS ('dbx_business_glossary_term' = 'Rating Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `reorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `selling_price_bottle` SET TAGS ('dbx_business_glossary_term' = 'Selling Price (Bottle)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `selling_price_glass` SET TAGS ('dbx_business_glossary_term' = 'Selling Price (Glass)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `sommelier_notes` SET TAGS ('dbx_business_glossary_term' = 'Sommelier Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `storage_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (Celsius)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `storage_temperature_celsius` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `tasting_notes` SET TAGS ('dbx_business_glossary_term' = 'Tasting Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `varietal` SET TAGS ('dbx_business_glossary_term' = 'Varietal');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `vintage_year` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `wine_list_category` SET TAGS ('dbx_business_glossary_term' = 'Wine List Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `wine_list_category` SET TAGS ('dbx_value_regex' = 'House Selection|Premium|Reserve|Rare & Collectible|Sommeliers Choice|Sustainable & Organic');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `wine_name` SET TAGS ('dbx_business_glossary_term' = 'Wine Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `wine_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Wine Rating Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `wine_type` SET TAGS ('dbx_business_glossary_term' = 'Wine Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`wine_cellar` ALTER COLUMN `wine_type` SET TAGS ('dbx_value_regex' = 'Red|White|Rosé|Sparkling|Dessert|Fortified');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` SET TAGS ('dbx_subdomain' = 'safety_quality');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `food_safety_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Inspection ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_tracked' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` SET TAGS ('dbx_subdomain' = 'safety_quality');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `waste_log_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Log Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `environmental_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `inventory_item_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Inventory Item Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recording Staff ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `revenue_center_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'landfill|compost|recycling|donation|waste_to_energy|incineration');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `food_category` SET TAGS ('dbx_business_glossary_term' = 'Food Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `health_safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Health and Safety Incident Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `health_safety_incident_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `health_safety_incident_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `iso_22000_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 22000 Compliant Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `meal_period` SET TAGS ('dbx_business_glossary_term' = 'Meal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `meal_period` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|banquet|room_service|bar');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `quantity_wasted` SET TAGS ('dbx_business_glossary_term' = 'Quantity Wasted');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `recording_staff_name` SET TAGS ('dbx_business_glossary_term' = 'Recording Staff Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `storage_location` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `sustainability_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Impact Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `total_waste_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Waste Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `waste_category` SET TAGS ('dbx_value_regex' = 'food_spoilage|over_production|plate_waste|breakage|expired_stock|preparation_error');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `waste_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `waste_reason` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `waste_status` SET TAGS ('dbx_business_glossary_term' = 'Waste Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `waste_status` SET TAGS ('dbx_value_regex' = 'recorded|reviewed|approved|disputed|closed');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `waste_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waste Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `waste_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`waste_log` ALTER COLUMN `waste_type` SET TAGS ('dbx_value_regex' = 'food|beverage|supplies|packaging');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` SET TAGS ('dbx_subdomain' = 'supply_inventory');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` SET TAGS ('dbx_association_edges' = 'fnb.inventory_item,procurement.vendor');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `fnb_supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'fnb_supply_agreement Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `inventory_item_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Fnb Inventory Item Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `procurement_supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `procurement_supply_agreement_id` SET TAGS ('dbx_ssot_owner' = 'procurement.procurement_supply_agreement');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `procurement_supply_agreement_id` SET TAGS ('dbx_ssot_entity' = 'supply_agreement');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `last_purchase_cost` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement` ALTER COLUMN `vendor_item_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` SET TAGS ('dbx_subdomain' = 'supply_inventory');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `parent_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Storage Location Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `parent_storage_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `parent_storage_location_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `active_from_date` SET TAGS ('dbx_business_glossary_term' = 'Active From Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `active_until_date` SET TAGS ('dbx_business_glossary_term' = 'Active Until Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `allergen_segregation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Segregation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `capacity_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Capacity Cubic Meters');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `capacity_cubic_meters` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `hazmat_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Approved Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `primary_use_description` SET TAGS ('dbx_business_glossary_term' = 'Primary Use Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `rfid_tag` SET TAGS ('dbx_business_glossary_term' = 'Rfid Tag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `storage_category` SET TAGS ('dbx_business_glossary_term' = 'Storage Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `storage_category` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `storage_location_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `storage_location_status` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `target_temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Max Celsius');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `target_temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature Min Celsius');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`storage_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` SET TAGS ('dbx_subdomain' = 'supply_inventory');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `parent_physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Count Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `physical_counter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Counter Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `physical_counter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `physical_counter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `physical_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `physical_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `physical_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `primary_recount_physical_count_id` SET TAGS ('dbx_business_glossary_term' = 'Recount Physical Count Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `primary_recount_physical_count_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `adjustment_posted` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posted');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `adjustment_posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posted Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `adjustment_required` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `compliance_verified` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Count Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `count_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count End Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `count_number` SET TAGS ('dbx_business_glossary_term' = 'Count Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `count_reason` SET TAGS ('dbx_business_glossary_term' = 'Count Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `count_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Start Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Count Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Count Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `pos_system_integration` SET TAGS ('dbx_business_glossary_term' = 'Pos System Integration');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `recount_reason` SET TAGS ('dbx_business_glossary_term' = 'Recount Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `recount_required` SET TAGS ('dbx_business_glossary_term' = 'Recount Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `storage_location` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `total_items_counted` SET TAGS ('dbx_business_glossary_term' = 'Total Items Counted');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `total_variance_items` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Items');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `total_variance_value` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `total_variance_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`fnb`.`physical_count` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
