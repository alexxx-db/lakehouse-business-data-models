-- Schema for Domain: restaurant | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-10 20:02:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`restaurant` COMMENT 'Master record for every restaurant unit — company-owned and franchised — including location attributes, format (QSR/casual/fine-dining), FOH/BOH configuration, operating hours, daypart schedules, equipment, throughput capacity, speed-of-service (SOS) benchmarks, table turns, cover counts, AUV, SSS, and comp sales. Operational anchor for brand standards and SOPs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`unit` (
    `unit_id` BIGINT COMMENT 'Unique identifier for the restaurant unit. Primary key for the unit master record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Unit should reference its brand via a foreign key rather than a free‑text code; brand_id provides referential integrity.',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: Units must be linked to the applicable brand standard for compliance tracking.',
    `department_id` BIGINT COMMENT 'Foreign key linking to workforce.department. Business justification: Linking a unit to its department enables organizational reporting and eliminates the department table silo.',
    `address_line1` STRING COMMENT 'Primary street address of the restaurant unit including street number and name.',
    `address_line2` STRING COMMENT 'Secondary address information such as suite number, building name, or floor.',
    `average_cover_count` STRING COMMENT 'Average number of guests (covers) served per day. Used for labor planning and revenue forecasting in table-service restaurants.',
    `average_ticket_time_seconds` STRING COMMENT 'Average time in seconds for a customer order to be completed from entry to fulfillment, tracked via KDS (Kitchen Display System).',
    `average_unit_volume_usd` DECIMAL(18,2) COMMENT 'Average annual sales revenue for this unit in US dollars. Key performance metric for franchise valuation and benchmarking.',
    `city` STRING COMMENT 'City or municipality where the restaurant unit is located.',
    `closure_date` DATE COMMENT 'The date this restaurant unit permanently ceased operations. Null for active units.',
    `concept_type` STRING COMMENT 'The restaurant format classification. QSR (Quick-Service Restaurant) for fast food, casual dining for table service, fast casual for counter service with higher quality, fine dining for upscale full service, food court for mall locations, ghost kitchen for delivery-only.. Valid values are `QSR|casual_dining|fast_casual|fine_dining|food_court|ghost_kitchen`',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the restaurant unit is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this unit record was first created in the system.',
    `daypart_schedule` STRING COMMENT 'Structured schedule defining daypart time windows (breakfast, lunch, dinner, late night) for menu and pricing management.',
    `drive_thru_lanes` STRING COMMENT 'Number of drive-thru lanes available at this unit. Zero indicates no drive-thru capability.',
    `email_address` STRING COMMENT 'Primary email address for the restaurant unit used for operational communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `haccp_certified` BOOLEAN COMMENT 'Indicates whether this unit maintains current HACCP certification for food safety management.',
    `has_online_ordering` BOOLEAN COMMENT 'Indicates whether this unit supports online ordering through web or mobile app channels.',
    `has_third_party_delivery` BOOLEAN COMMENT 'Indicates whether this unit is enabled for third-party delivery services such as DoorDash, Uber Eats, or Grubhub.',
    `health_inspection_score` STRING COMMENT 'Most recent health inspection score from local health department. Scale and passing thresholds vary by jurisdiction.',
    `kds_station_count` STRING COMMENT 'Number of KDS stations installed in the BOH for order routing and kitchen workflow management.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent health and safety inspection by local regulatory authority.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this unit record was most recently updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the restaurant unit in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the restaurant unit in decimal degrees.',
    `opening_date` DATE COMMENT 'The date this restaurant unit first opened for business to customers.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the unit, typically formatted as day ranges with time windows (e.g., Mon-Fri 6:00-22:00, Sat-Sun 7:00-23:00).',
    `operational_status` STRING COMMENT 'Current lifecycle state of the restaurant unit. Active indicates normal operations, temporarily closed for renovations or seasonal closure, permanently closed for shut down units, under construction for new builds, pending opening for units awaiting launch.. Valid values are `active|temporarily_closed|permanently_closed|under_construction|pending_opening`',
    `ownership_model` STRING COMMENT 'The operating model for this unit: company-owned (corporate operated), franchised (independent franchisee), joint venture (shared ownership), or licensed (brand licensing agreement).. Valid values are `company_owned|franchised|joint_venture|licensed`',
    `parking_spaces` STRING COMMENT 'Number of dedicated parking spaces available for guest use at this location.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the restaurant unit.',
    `pos_system_version` STRING COMMENT 'Version identifier of the POS system software deployed at this unit.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the restaurant unit location.',
    `same_store_sales_pct` DECIMAL(18,2) COMMENT 'Year-over-year comparable store sales growth percentage. Measures organic growth for units open at least 12 months.',
    `seating_capacity` STRING COMMENT 'Maximum number of guest seats available in the FOH (Front of House) dining area.',
    `speed_of_service_seconds` STRING COMMENT 'Average time in seconds from order placement to order delivery. Critical QSR operational metric for customer satisfaction.',
    `square_footage` STRING COMMENT 'Total interior floor space of the restaurant unit in square feet, including FOH and BOH (Back of House) areas.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the restaurant unit is located.. Valid values are `^[A-Z]{2}$`',
    `table_turn_rate` DECIMAL(18,2) COMMENT 'Average number of times a table is occupied by different parties during a service period. Relevant for casual and fine-dining concepts.',
    `throughput_capacity_orders_per_hour` STRING COMMENT 'Maximum number of customer orders this unit can process per hour at peak efficiency, based on equipment and staffing design.',
    `trade_name` STRING COMMENT 'The customer-facing name of the restaurant unit as displayed on signage and marketing materials.',
    `unit_number` STRING COMMENT 'Business identifier for the restaurant unit. Externally-known unique code used across operational systems and franchise communications.. Valid values are `^[A-Z0-9]{4,12}$`',
    CONSTRAINT pk_unit PRIMARY KEY(`unit_id`)
) COMMENT 'Master record for every restaurant unit — company-owned and franchised. The authoritative identity of each physical location including unit number, brand, concept type (QSR/casual/fine-dining), ownership model (company-owned vs. franchised), legal entity name, trade name, opening date, closure date, current operational status, and geographic coordinates. This is the operational anchor for the entire restaurant domain and the primary FK target for all cross-domain joins (order, inventory, workforce, finance, franchise). One row per physical restaurant location. All other restaurant domain products reference this entity.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` (
    `location_profile_id` BIGINT COMMENT 'Unique identifier for the restaurant location profile. Primary key for this entity.',
    `unit_id` BIGINT COMMENT 'Reference to the master restaurant unit record. Links this location profile to the operational restaurant entity.',
    `address_line_1` STRING COMMENT 'Primary street address of the restaurant location including street number and name. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, unit, or building number. Organizational contact data classified as confidential.',
    `building_ownership_type` STRING COMMENT 'Type of ownership or lease arrangement for the restaurant building. Impacts financial reporting and CapEx decisions.. Valid values are `owned|leased|franchisee_owned|ground_lease`',
    `city` STRING COMMENT 'City or municipality where the restaurant is located. Organizational contact data classified as confidential.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the restaurant operates.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this location profile record was first created in the system. Audit trail for data lineage.',
    `delivery_radius_km` DECIMAL(18,2) COMMENT 'Maximum delivery radius in kilometers for online ordering and third-party delivery services. Configured per location based on geography and capacity.',
    `dma_code` STRING COMMENT 'Nielsen Designated Market Area code identifying the media market. Used for marketing campaign planning and regional media analysis.',
    `drive_thru_lane_count` STRING COMMENT 'Number of drive-thru lanes at the restaurant. Critical for throughput capacity planning and speed of service benchmarking.',
    `email_address` STRING COMMENT 'Primary email address for the restaurant location. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the restaurant location if applicable. Organizational contact data classified as confidential.',
    `has_accessible_parking` BOOLEAN COMMENT 'Indicates whether the restaurant has ADA-compliant accessible parking spaces. Required for regulatory compliance.',
    `has_drive_thru` BOOLEAN COMMENT 'Indicates whether the restaurant has drive-thru service capability. Key differentiator for QSR format and operational model.',
    `has_patio_seating` BOOLEAN COMMENT 'Indicates whether the restaurant has outdoor patio seating available. Impacts cover count and seasonal capacity.',
    `has_playground` BOOLEAN COMMENT 'Indicates whether the restaurant has a childrens playground. Differentiator for family-oriented locations.',
    `has_restroom` BOOLEAN COMMENT 'Indicates whether the restaurant has customer restroom facilities. Impacts guest experience and local health code compliance.',
    `has_wheelchair_access` BOOLEAN COMMENT 'Indicates whether the restaurant has wheelchair-accessible entrances and facilities. Required for ADA compliance.',
    `has_wifi` BOOLEAN COMMENT 'Indicates whether the restaurant offers guest WiFi service. Enhances guest experience and supports digital ordering.',
    `last_remodel_date` DATE COMMENT 'Date of the most recent major remodel or renovation. Used for CapEx tracking and brand standard compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this location profile record was last modified. Audit trail for data lineage and change tracking.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the restaurant location in decimal degrees. Used for mapping, delivery radius calculation, and proximity analytics.',
    `lease_expiration_date` DATE COMMENT 'Date when the current lease agreement expires. Critical for real estate planning and renewal negotiations.',
    `locale` STRING COMMENT 'Locale identifier for language and regional formatting preferences. Used for menu display, signage, and customer communications.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the restaurant location in decimal degrees. Used for mapping, delivery radius calculation, and proximity analytics.',
    `lot_size_sqft` STRING COMMENT 'Total lot size in square feet including building, parking, and landscaping. Used for site selection and property management.',
    `parking_capacity` STRING COMMENT 'Total number of parking spaces available at or near the restaurant location. Influences site selection and accessibility.',
    `patio_seat_count` STRING COMMENT 'Number of seats available on the outdoor patio. Used for capacity planning and table turn analysis.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the restaurant location. Organizational contact data classified as confidential.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the restaurant location. Organizational contact data classified as confidential.',
    `proximity_to_airport_km` DECIMAL(18,2) COMMENT 'Distance in kilometers from the restaurant to the nearest airport. Influences traveler traffic and site classification.',
    `proximity_to_highway_km` DECIMAL(18,2) COMMENT 'Distance in kilometers from the restaurant to the nearest major highway. Used for site selection and trade area analysis.',
    `proximity_to_mall_km` DECIMAL(18,2) COMMENT 'Distance in kilometers from the restaurant to the nearest shopping mall. Impacts foot traffic and co-location strategy.',
    `restaurant_number` STRING COMMENT 'Business identifier for the restaurant unit. Externally-known code used in operations, reporting, and franchise communications.',
    `site_closed_date` DATE COMMENT 'Date when the restaurant location permanently closed. Used for portfolio analysis and historical reporting.',
    `site_opened_date` DATE COMMENT 'Date when the restaurant location first opened for business. Used for NRO tracking, maturity analysis, and comp sales calculations.',
    `site_status` STRING COMMENT 'Current operational status of the restaurant site. Used for reporting, site portfolio management, and NRO tracking.. Valid values are `active|under_construction|planned|closed|temporarily_closed`',
    `square_footage` STRING COMMENT 'Total interior square footage of the restaurant building. Used for real estate valuation, CapEx planning, and operational benchmarking.',
    `state_province` STRING COMMENT 'State, province, or administrative region code. Organizational contact data classified as confidential.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the restaurant location. Used for daypart scheduling, operating hours, and time-based reporting.',
    `trade_area_classification` STRING COMMENT 'Classification of the trade area type where the restaurant is located. Influences site selection, menu offerings, and operational strategies. [ENUM-REF-CANDIDATE: urban|suburban|rural|highway|airport|mall|downtown|neighborhood — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_location_profile PRIMARY KEY(`location_profile_id`)
) COMMENT 'Physical and geographic attributes of each restaurant unit including full street address, city, state, province, postal code, country, DMA (Designated Market Area), trade area classification, latitude/longitude, timezone, locale, accessibility features, parking capacity, drive-thru lane count, patio seating availability, and proximity to key landmarks. Supports site analytics, delivery radius configuration, and regional reporting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` (
    `format_config_id` BIGINT COMMENT 'Unique identifier for the restaurant format configuration record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Format configuration changes (service model, seating capacity, drive-thru layout) require management approval. Tracking the approving employee is a real operational audit and brand-standard compliance',
    `brand_id` BIGINT COMMENT 'add column brand_id (BIGINT) with FK to restaurant.brand.brand_id - format configurations (QSR/casual/fine-dining) should be brand-specific',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: A format configuration (QSR, casual, fine-dining) must comply with specific brand standards and SOPs. format_config already tracks brand_standard_compliance_status as a STRING, indicating the relation',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit to which this format configuration applies.',
    `alcohol_service_flag` BOOLEAN COMMENT 'Indicates whether the restaurant format is licensed and configured to serve alcoholic beverages.',
    `boh_cooking_line_count` STRING COMMENT 'Number of cooking lines or production stations in the Back of House (BOH) kitchen.',
    `boh_kitchen_sq_ft` DECIMAL(18,2) COMMENT 'Total square footage of the Back of House (BOH) kitchen and food preparation area.',
    `boh_prep_station_count` STRING COMMENT 'Number of food preparation stations in the Back of House (BOH) kitchen.',
    `brand_standard_compliance_status` STRING COMMENT 'Current compliance status of the format configuration against brand standards and Standard Operating Procedures (SOPs).. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `breakfast_daypart_flag` BOOLEAN COMMENT 'Indicates whether the restaurant format operates during the breakfast daypart and serves breakfast menu items.',
    `config_version` STRING COMMENT 'Version identifier for this format configuration, used to track changes and updates over time.',
    `cover_count_capacity_per_daypart` STRING COMMENT 'Maximum number of covers (individual meals served) the restaurant can accommodate during a single daypart (breakfast, lunch, dinner) based on seating and throughput.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this format configuration record was first created in the system.',
    `curbside_pickup_enabled_flag` BOOLEAN COMMENT 'Indicates whether the restaurant format supports curbside pickup service for online orders.',
    `dining_format_type` STRING COMMENT 'The primary dining format classification of the restaurant unit: Quick-Service Restaurant (QSR), fast-casual, casual dining, or fine-dining.. Valid values are `QSR|fast_casual|casual_dining|fine_dining`',
    `drive_thru_lane_config` STRING COMMENT 'Drive-Thru (DT) lane configuration: none (no drive-thru), single lane, dual lane, or triple lane.. Valid values are `none|single|dual|triple`',
    `drive_thru_window_count` STRING COMMENT 'Number of Drive-Thru (DT) service windows available for order pickup.',
    `effective_date` DATE COMMENT 'Date when this format configuration became or will become effective for the restaurant unit.',
    `expiration_date` DATE COMMENT 'Date when this format configuration expires or is superseded by a new configuration. Null indicates current active configuration.',
    `foh_bar_seating_count` STRING COMMENT 'Number of bar seats available in the Front of House (FOH) area, if applicable.',
    `foh_outdoor_seating_count` STRING COMMENT 'Number of outdoor patio or sidewalk seats available in the Front of House (FOH) area.',
    `foh_seating_capacity` STRING COMMENT 'Total number of guest seats available in the Front of House (FOH) dining area, including indoor and outdoor seating.',
    `foh_table_count` STRING COMMENT 'Total number of dining tables in the Front of House (FOH) area.',
    `format_name` STRING COMMENT 'Human-readable name or label for this format configuration (e.g., Standard QSR with DT, Urban Fast-Casual).',
    `kds_screen_count` STRING COMMENT 'Number of Kitchen Display System (KDS) screens installed in the Back of House (BOH) for order routing and production management.',
    `kiosk_count` STRING COMMENT 'Number of self-service digital ordering kiosks installed in the restaurant.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this format configuration record was last updated or modified.',
    `last_remodel_date` DATE COMMENT 'Date of the most recent remodel or renovation that affected the format configuration of the restaurant.',
    `late_night_daypart_flag` BOOLEAN COMMENT 'Indicates whether the restaurant format operates during late-night hours (typically after 10 PM).',
    `notes` STRING COMMENT 'Free-text notes or comments regarding special considerations, exceptions, or unique characteristics of this format configuration.',
    `olo_enabled_flag` BOOLEAN COMMENT 'Indicates whether the restaurant format supports Online Ordering (OLO) through web or mobile app channels.',
    `parking_space_count` STRING COMMENT 'Number of parking spaces available for guest use at the restaurant location.',
    `pos_terminal_count` STRING COMMENT 'Number of Point of Sale (POS) terminals installed for order capture and payment processing.',
    `service_model` STRING COMMENT 'Primary service delivery model: counter service, table service, drive-thru, self-service kiosk, or hybrid combination.. Valid values are `counter|table|drive_thru|kiosk|hybrid`',
    `sos_benchmark_seconds` STRING COMMENT 'Target Speed of Service (SOS) benchmark in seconds from order placement to order delivery, based on format and service model.',
    `table_turn_target_minutes` STRING COMMENT 'Target table turn time in minutes for table-service formats, representing the average time from guest seating to table availability.',
    `third_party_delivery_enabled_flag` BOOLEAN COMMENT 'Indicates whether the restaurant format supports Third-Party Delivery (3PD) integration with external delivery platforms.',
    `throughput_capacity_per_hour` STRING COMMENT 'Maximum number of customer transactions the restaurant can process per hour under optimal conditions, based on format configuration.',
    `twenty_four_hour_operation_flag` BOOLEAN COMMENT 'Indicates whether the restaurant operates 24 hours per day, 7 days per week.',
    CONSTRAINT pk_format_config PRIMARY KEY(`format_config_id`)
) COMMENT 'Defines the operational format, physical configuration, and total capacity of a restaurant unit. Includes dining format (QSR, fast-casual, casual, fine-dining), service model (counter, table, drive-thru, kiosk), FOH layout (total indoor seating capacity, outdoor/patio seating capacity, bar seating count, private dining room capacity, ADA-compliant seating count, table count, cover count), BOH layout (kitchen footprint sq ft, cooking lines, prep stations), drive-thru configuration (lane count, stacking capacity for vehicles), kiosk count, counter service positions, and maximum cover count per daypart. This is the single source of truth for all physical capacity and layout attributes of a unit — governs brand standard compliance, throughput benchmarking, labor staffing ratios, health department permit compliance, and fire marshal occupancy limits.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` (
    `operating_hours_id` BIGINT COMMENT 'Unique identifier for the operating hours record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this operating hours schedule. Used for audit trail and compliance tracking.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit to which these operating hours apply. Links to the restaurant master record.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this operating hours schedule was approved, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trail and compliance tracking.',
    `close_time` TIMESTAMP COMMENT 'The time the restaurant closes for the specified day and daypart, in 24-hour HH:mm format (e.g., 22:00). May extend past midnight for late-night operations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this operating hours record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trail and data lineage.',
    `day_of_week` STRING COMMENT 'The day of the week for which these operating hours are defined. [ENUM-REF-CANDIDATE: monday|tuesday|wednesday|thursday|friday|saturday|sunday — 7 candidates stripped; promote to reference product]',
    `daypart` STRING COMMENT 'The daypart segment (breakfast, lunch, dinner, late-night, all-day, overnight) for which these hours apply. Used for menu availability, labor scheduling, and Same-Store Sales (SSS) period alignment.. Valid values are `breakfast|lunch|dinner|late_night|all_day|overnight`',
    `daypart_end_time` TIMESTAMP COMMENT 'The end time of the specific daypart window (e.g., breakfast ends at 11:00), in 24-hour HH:mm format. Used for menu engineering and Product Mix (PMIX) analysis.',
    `daypart_start_time` TIMESTAMP COMMENT 'The start time of the specific daypart window (e.g., breakfast starts at 06:00), in 24-hour HH:mm format. Used for menu engineering and Product Mix (PMIX) analysis.',
    `delivery_window_close_time` TIMESTAMP COMMENT 'The time the restaurant stops accepting delivery orders (Online Ordering (OLO) and Third-Party Delivery (3PD)), in 24-hour HH:mm format. May differ from dine-in hours.',
    `delivery_window_open_time` TIMESTAMP COMMENT 'The time the restaurant begins accepting delivery orders (Online Ordering (OLO) and Third-Party Delivery (3PD)), in 24-hour HH:mm format. May differ from dine-in hours.',
    `drive_thru_close_time` TIMESTAMP COMMENT 'The time the Drive-Thru (DT) lane closes, in 24-hour HH:mm format. May differ from Front of House (FOH) close time for QSR (Quick-Service Restaurant) units.',
    `drive_thru_open_time` TIMESTAMP COMMENT 'The time the Drive-Thru (DT) lane opens, in 24-hour HH:mm format. May differ from Front of House (FOH) open time for QSR (Quick-Service Restaurant) units.',
    `effective_end_date` DATE COMMENT 'The date on which these operating hours expire, in yyyy-MM-dd format. Null for open-ended schedules. Used for temporary hour changes and seasonal adjustments.',
    `effective_start_date` DATE COMMENT 'The date from which these operating hours become effective, in yyyy-MM-dd format. Used for scheduling future hour changes and seasonal adjustments.',
    `expected_cover_count` STRING COMMENT 'The expected number of covers (individual diners served) during this daypart for casual and fine-dining establishments. Used for labor scheduling and inventory planning.',
    `expected_table_turn_count` DECIMAL(18,2) COMMENT 'The expected number of table turns (times a table is occupied and vacated) during this daypart for casual and fine-dining establishments. Used for capacity planning and revenue forecasting.',
    `holiday_name` STRING COMMENT 'The name of the holiday for which this schedule override applies (e.g., Christmas, Thanksgiving, New Years Day). Null if not a holiday override.',
    `holiday_schedule_override_flag` BOOLEAN COMMENT 'Indicates whether these operating hours represent a holiday schedule override. True if this is a holiday exception, False for regular schedule.',
    `is_24_hour_operation` BOOLEAN COMMENT 'Indicates whether the restaurant operates 24 hours a day for the specified day. True if open continuously, False otherwise.',
    `is_closed` BOOLEAN COMMENT 'Indicates whether the restaurant is closed for the specified day and daypart. True if closed, False if open.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this operating hours record was last modified, in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trail and change tracking.',
    `last_order_cutoff_time` TIMESTAMP COMMENT 'The time by which the last order must be placed before the restaurant stops accepting new orders, in 24-hour HH:mm format. Used for Online Ordering (OLO) and Third-Party Delivery (3PD) routing.',
    `notes` STRING COMMENT 'Free-text notes or comments about this operating hours schedule. May include reasons for schedule changes, special instructions, or operational context.',
    `open_time` TIMESTAMP COMMENT 'The time the restaurant opens for the specified day and daypart, in 24-hour HH:mm format (e.g., 06:00).',
    `schedule_status` STRING COMMENT 'The current lifecycle status of this operating hours record. Active schedules are in effect; pending schedules are future-dated; expired schedules are past their end date; suspended schedules are temporarily disabled.. Valid values are `active|inactive|pending|expired|suspended`',
    `schedule_type` STRING COMMENT 'The type of operating hours schedule. Regular for standard weekly hours, holiday for holiday overrides, seasonal for seasonal adjustments, temporary for one-time changes, special_event for event-driven hours.. Valid values are `regular|holiday|seasonal|temporary|special_event`',
    `seasonal_adjustment_flag` BOOLEAN COMMENT 'Indicates whether these operating hours represent a seasonal adjustment (e.g., extended summer hours, reduced winter hours). True if seasonal, False for standard schedule.',
    `seasonal_period_name` STRING COMMENT 'The name of the seasonal period for which this schedule adjustment applies (e.g., Summer, Winter, Back-to-School). Null if not a seasonal adjustment.',
    `special_event_name` STRING COMMENT 'The name of the special event for which these operating hours apply (e.g., Super Bowl Sunday, Local Festival, Grand Opening). Null if not a special event schedule.',
    `target_speed_of_service_seconds` STRING COMMENT 'The target Speed of Service (SOS) in seconds for this daypart. Represents the benchmark time from order placement to order fulfillment. Used for operational performance tracking.',
    `target_ticket_time_seconds` STRING COMMENT 'The target ticket time in seconds for this daypart. Represents the benchmark time from order entry to Kitchen Display System (KDS) completion. Used for Back of House (BOH) performance tracking.',
    `throughput_capacity_per_hour` STRING COMMENT 'The estimated number of customer transactions the restaurant can process per hour during this daypart. Used for labor scheduling and Speed of Service (SOS) benchmarking.',
    CONSTRAINT pk_operating_hours PRIMARY KEY(`operating_hours_id`)
) COMMENT 'Scheduled operating hours for each restaurant unit by day of week and daypart (breakfast, lunch, dinner, late-night, 24hr). Captures open time, close time, daypart start/end times, holiday schedule overrides, seasonal hour adjustments, drive-thru-specific hours, delivery window hours, and last-order cutoff times. Used for order routing, labor scheduling, and SSS (Same-Store Sales) period alignment.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` (
    `equipment_asset_id` BIGINT COMMENT 'Unique identifier for the equipment asset record. Primary key.',
    `department_id` BIGINT COMMENT 'Foreign key linking to workforce.department. Business justification: Equipment assets are owned and maintained by a department (e.g., kitchen equipment under BOH department). Maintenance budgets, depreciation allocation, and HACCP compliance audits are tracked by depar',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Asset depreciation and financial reporting require each physical equipment asset to be tied to a fixed‑asset record in finance.',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: Equipment assets are physically installed at specific kitchen stations (e.g., fryers at the fry station, grills at the grill station). equipment_asset currently tracks location_zone as a free-text STR',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where this equipment asset is installed.',
    `acquisition_cost_usd` DECIMAL(18,2) COMMENT 'Original purchase price paid for the equipment asset in US dollars, used for CapEx (Capital Expenditure) tracking and depreciation calculations.',
    `asset_condition_rating` STRING COMMENT 'Current physical and operational condition assessment of the equipment asset based on inspection and performance criteria.. Valid values are `excellent|good|fair|poor|critical`',
    `asset_tag_number` STRING COMMENT 'Externally visible unique asset tag or barcode identifier affixed to the equipment for tracking and inventory purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `compliance_certification_expiry_date` DATE COMMENT 'Date when the current compliance certification expires and recertification or inspection is required.',
    `compliance_certification_number` STRING COMMENT 'Certification or approval number from regulatory bodies (FDA, NSF, UL, OSHA) confirming the equipment meets safety and sanitation standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this equipment asset record was first created in the system.',
    `depreciation_method` STRING COMMENT 'Accounting method used to allocate the cost of the equipment asset over its useful life for financial reporting and tax purposes.. Valid values are `straight_line|declining_balance|units_of_production`',
    `disposal_date` DATE COMMENT 'Date when the equipment asset was decommissioned and removed from the restaurant, marking the end of its operational lifecycle.',
    `disposal_method` STRING COMMENT 'Method by which the equipment was disposed of at end of life, supporting asset lifecycle tracking and environmental compliance.. Valid values are `sold|scrapped|donated|recycled|returned_to_vendor`',
    `energy_rating` STRING COMMENT 'Energy efficiency rating or certification (e.g., Energy Star rating) indicating the equipments power consumption performance.',
    `equipment_category` STRING COMMENT 'High-level classification grouping equipment by operational domain (cooking, refrigeration, POS systems, etc.). [ENUM-REF-CANDIDATE: cooking|refrigeration|food_prep|beverage|pos_system|kitchen_display|sanitation|hvac — 8 candidates stripped; promote to reference product]',
    `equipment_name` STRING COMMENT 'Human-readable name or designation of the equipment asset (e.g., Fryer Station 1, POS Terminal 3, Walk-in Cooler).',
    `equipment_type` STRING COMMENT 'Category of equipment asset distinguishing its primary function within BOH (Back of House) or FOH (Front of House) operations. [ENUM-REF-CANDIDATE: fryer|grill|oven|refrigeration_unit|freezer|ice_machine|pos_terminal|kds_display|espresso_machine|beverage_dispenser|dishwasher|ventilation_hood|warming_cabinet|prep_table — 14 candidates stripped; promote to reference product]',
    `installation_date` DATE COMMENT 'Date when the equipment asset was installed and commissioned at the restaurant location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this equipment asset record was most recently updated.',
    `last_service_date` DATE COMMENT 'Most recent date when preventive maintenance or repair service was performed on this equipment asset.',
    `last_temperature_check_timestamp` TIMESTAMP COMMENT 'Most recent date and time when temperature was verified for temperature-critical equipment, supporting food safety audit trails.',
    `lease_expiry_date` DATE COMMENT 'Date when the lease or rental agreement for this equipment expires, requiring renewal or return of the asset.',
    `location_zone` STRING COMMENT 'Physical zone within the restaurant where the equipment is installed: BOH (Back of House), FOH (Front of House), Drive-Thru, Storage, or Outdoor.. Valid values are `boh|foh|drive_thru|storage|outdoor`',
    `maintenance_frequency_days` STRING COMMENT 'Number of days between scheduled preventive maintenance services as defined by manufacturer guidelines or internal SOPs.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactured the equipment asset.',
    `model_number` STRING COMMENT 'Manufacturer-assigned model number or designation for the equipment.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Planned date for the next preventive maintenance service visit based on manufacturer recommendations and SOP (Standard Operating Procedure) schedules.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special handling instructions, or historical context about the equipment asset.',
    `operational_status` STRING COMMENT 'Current lifecycle status indicating whether the equipment is actively in use, under maintenance, or retired from service.. Valid values are `in_service|out_of_service|under_repair|scheduled_replacement|decommissioned`',
    `ownership_type` STRING COMMENT 'Indicates whether the equipment is owned outright by the restaurant, leased under a capital or operating lease, or rented short-term.. Valid values are `owned|leased|rented`',
    `power_consumption_watts` STRING COMMENT 'Rated electrical power consumption of the equipment in watts under normal operating conditions, used for energy cost forecasting.',
    `replacement_cost_usd` DECIMAL(18,2) COMMENT 'Estimated current market cost to replace this equipment asset with a comparable new unit, used for R&M (Repairs and Maintenance) budgeting and insurance valuation.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific equipment unit for warranty and service tracking.',
    `service_contract_number` STRING COMMENT 'Reference number of the active service or maintenance contract covering this equipment asset, if applicable.',
    `temperature_critical_flag` BOOLEAN COMMENT 'Indicates whether this equipment maintains temperature-sensitive food products and requires continuous monitoring for HACCP (Hazard Analysis Critical Control Points) compliance.',
    `temperature_max_f` DECIMAL(18,2) COMMENT 'Maximum safe operating temperature threshold in Fahrenheit for temperature-critical equipment, above which food safety is compromised.',
    `temperature_min_f` DECIMAL(18,2) COMMENT 'Minimum safe operating temperature threshold in Fahrenheit for temperature-critical equipment, below which food safety is compromised.',
    `useful_life_years` STRING COMMENT 'Expected operational lifespan of the equipment asset in years, used for depreciation calculations and replacement planning.',
    `warranty_expiry_date` DATE COMMENT 'Date when the manufacturer or vendor warranty coverage ends, after which repairs and parts are at the restaurants expense.',
    `warranty_start_date` DATE COMMENT 'Date when the manufacturer or vendor warranty coverage begins for this equipment asset.',
    CONSTRAINT pk_equipment_asset PRIMARY KEY(`equipment_asset_id`)
) COMMENT 'Inventory of all BOH and FOH equipment assets installed at each restaurant unit including all equipment types (fryer, grill, oven, KDS stations, POS terminals, refrigeration units, ice machines, espresso machines, drive-thru timers). Captures make, model, serial number, installation date, warranty expiry, last service date, next scheduled maintenance date, asset condition rating, replacement cost, software version (for digital equipment), and equipment-specific configuration attributes. Supports R&M (Repairs and Maintenance) planning, CapEx forecasting, PCI DSS compliance for payment terminals, and food safety compliance for temperature-critical equipment.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` (
    `brand_standard_id` BIGINT COMMENT 'Unique identifier for the brand standard record. Primary key.',
    `brand_id` BIGINT COMMENT 'add column brand_id (BIGINT) with FK to restaurant.brand.brand_id - brand standards must explicitly reference which brand they belong to',
    `superseded_by_standard_brand_standard_id` BIGINT COMMENT 'Reference to the brand_standard_id of the newer standard that replaces this one. Null if this standard is current and has not been superseded.',
    `applicable_format` STRING COMMENT 'Restaurant format(s) to which this brand standard applies. QSR (Quick-Service Restaurant) for fast food, casual for casual dining, fine_dining for upscale establishments, or combinations/all formats. [ENUM-REF-CANDIDATE: all|qsr|casual|fine_dining|qsr_casual|qsr_fine_dining|casual_fine_dining — 7 candidates stripped; promote to reference product]',
    `applicable_ownership_model` STRING COMMENT 'Ownership model(s) to which this standard applies: company-owned units, franchised units, or all units regardless of ownership.. Valid values are `all|company_owned|franchised`',
    `audit_frequency` STRING COMMENT 'Expected frequency at which compliance with this standard should be audited or inspected (e.g., daily temperature logs, monthly cleanliness audits, annual safety inspections). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|ad_hoc — 7 candidates stripped; promote to reference product]',
    `brand_standard_status` STRING COMMENT 'Current lifecycle status of the brand standard. Active standards are in force. Inactive standards are no longer enforced. Draft standards are under development. Under_review standards are being revised. Superseded standards have been replaced by a newer version.. Valid values are `active|inactive|draft|under_review|superseded`',
    `certification_body` STRING COMMENT 'Name of the external organization or authority that issues the required certification (e.g., National Restaurant Association ServSafe, OSHA, Local Health Department). Null if no certification is required.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether staff must obtain a formal certification to perform tasks related to this standard (e.g., ServSafe Food Handler certification for food safety standards). True if certification is mandatory, False otherwise.',
    `compliance_requirement_level` STRING COMMENT 'Enforcement level of the standard. Mandatory standards must be met for operational compliance and are subject to audit consequences. Recommended standards are best practices encouraged but not enforced. Aspirational standards represent future-state goals.. Valid values are `mandatory|recommended|aspirational`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand standard record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which this brand standard becomes active and enforceable. Standards are not applicable before this date.',
    `expiry_date` DATE COMMENT 'Date on which this brand standard is no longer active or enforceable. Null indicates an open-ended standard with no planned expiration.',
    `governing_body_reference` STRING COMMENT 'External regulatory or industry body that mandates or influences this standard (e.g., FDA, USDA, OSHA, NRA ServSafe, Local Health Department, ISO 22000). Null if the standard is purely internal.',
    `guest_facing_flag` BOOLEAN COMMENT 'Indicates whether this standard directly impacts the guest experience and is visible or perceptible to customers (e.g., FOH cleanliness, service speed, food presentation). True if guest-facing, False if back-of-house or internal only.',
    `last_review_date` DATE COMMENT 'Date on which this brand standard was last reviewed for accuracy, relevance, and compliance with current regulations. Used to track review cycles and ensure standards remain current.',
    `measurement_method` STRING COMMENT 'Method by which compliance with this standard is assessed: direct observation (visual inspection), checklist (structured audit form), measurement (thermometer, timer), testing (lab analysis, swab test), documentation review (log verification), or guest feedback (CSAT, NPS).. Valid values are `observation|checklist|measurement|testing|documentation_review|guest_feedback`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this brand standard. Ensures periodic reassessment to maintain relevance and regulatory alignment.',
    `non_compliance_consequence` STRING COMMENT 'Consequence or remediation action triggered when a unit fails to meet this standard. Ranges from warnings and corrective action plans to financial penalties, operational suspension, or franchise termination for critical violations.. Valid values are `warning|corrective_action_plan|financial_penalty|operational_suspension|franchise_termination|none`',
    `owner_department` STRING COMMENT 'Internal department or functional area responsible for defining, maintaining, and enforcing this brand standard (e.g., Food Safety, Operations, Quality Assurance, Franchise Development, Marketing).',
    `priority_level` STRING COMMENT 'Business priority level of the standard. Critical standards directly impact guest safety or regulatory compliance. High standards affect brand reputation or operational efficiency. Medium and low standards are important but less urgent.. Valid values are `critical|high|medium|low`',
    `sop_document_reference` STRING COMMENT 'Reference identifier or URI to the detailed SOP document that operationalizes this brand standard. May be a document management system ID, SharePoint link, or file path.',
    `standard_category` STRING COMMENT 'High-level classification of the brand standard into operational domains: food quality (taste, temperature, freshness), food safety (HACCP compliance, contamination prevention), cleanliness (sanitation, hygiene), service excellence (guest interaction, speed of service), brand presentation (signage, uniforms, decor), workplace safety (OSHA compliance, injury prevention), or equipment maintenance (preventive maintenance, calibration). [ENUM-REF-CANDIDATE: food_quality|food_safety|cleanliness|service_excellence|brand_presentation|workplace_safety|equipment_maintenance — 7 candidates stripped; promote to reference product]',
    `standard_code` STRING COMMENT 'Unique business identifier code for the brand standard, typically following a category-number pattern (e.g., FS-001 for Food Safety standard 001, CL-042 for Cleanliness standard 042).. Valid values are `^[A-Z]{2,4}-[0-9]{3,5}$`',
    `standard_description` STRING COMMENT 'Detailed narrative description of the brand standard, including the specific requirement, rationale, and expected outcome. May reference specific procedures, thresholds, or quality criteria.',
    `standard_name` STRING COMMENT 'Full descriptive name of the brand standard (e.g., Proper Handwashing Protocol, Drive-Thru Speed of Service Target, Uniform and Appearance Guidelines).',
    `target_metric_unit` STRING COMMENT 'Unit of measure for the target metric value (e.g., degrees Fahrenheit, seconds, percentage, count). Null if the standard does not have a quantitative metric.',
    `target_metric_value` DECIMAL(18,2) COMMENT 'Specific quantitative or qualitative target that defines compliance with this standard (e.g., Food temperature >= 165°F, Speed of Service <= 90 seconds, Cleanliness score >= 95%, Zero critical violations). Null if the standard is qualitative without a numeric threshold.',
    `training_module_reference` STRING COMMENT 'Reference identifier to the training module or course that covers this brand standard. May be an LMS (Learning Management System) course ID or training document reference. Null if no formal training module exists.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether formal training is required for staff to understand and comply with this standard. True if training is mandatory, False otherwise.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand standard record was last modified in the system.',
    `version_number` STRING COMMENT 'Version identifier for the standard, following semantic versioning (e.g., 1.0, 2.1, 3.0). Incremented when the standard is revised or updated.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_brand_standard PRIMARY KEY(`brand_standard_id`)
) COMMENT 'Defines the brand standards and SOPs (Standard Operating Procedures) applicable to each restaurant unit by concept type and ownership model. Captures standard code, standard name, standard category (food quality, cleanliness, service, safety, brand presentation), applicable format (QSR/casual/fine-dining), compliance requirement level (mandatory/recommended), effective date, expiry date, governing body reference (NRA, FDA, OSHA), and linked SOP document reference. Operational anchor for audit and compliance workflows.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` (
    `pos_terminal_id` BIGINT COMMENT 'Unique identifier for the POS terminal. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: POS terminal accountability tracking — which employee is the primary responsible operator for a terminal — is required for theft prevention audits, PCI compliance accountability, and end-of-shift cash',
    `kitchen_station_id` BIGINT COMMENT 'Foreign key linking to restaurant.kitchen_station. Business justification: pos_terminal has an assigned_station STRING column that captures which station the terminal is assigned to. kitchen_station is the authoritative reference table for stations (as noted in its descripti',
    `department_id` BIGINT COMMENT 'Foreign key linking to workforce.department. Business justification: POS terminals are assigned to departments (bar POS under bar department, drive-thru POS under drive-thru ops). Department-level POS assignment supports revenue attribution, labor cost allocation, and ',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit to which the terminal is assigned.',
    `primary_replaced_pos_terminal_id` BIGINT COMMENT 'Self-referencing FK on pos_terminal (replaced_pos_terminal_id)',
    `cash_drawer_attached` BOOLEAN COMMENT 'Indicates whether a cash drawer is attached to this POS terminal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this POS terminal record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the POS terminal was decommissioned and removed from active service.',
    `encryption_key_reference` STRING COMMENT 'Identifier of the encryption key used to secure transaction data on the terminal.',
    `firmware_version` STRING COMMENT 'Version of the firmware currently running on the terminal.',
    `floor_number` STRING COMMENT 'Numeric floor level of the terminal location, useful for multi‑story venues.',
    `hardware_model` STRING COMMENT 'Manufacturer model number or designation of the physical POS terminal hardware.',
    `installation_date` DATE COMMENT 'Date when the POS terminal was first installed and commissioned at the restaurant location.',
    `ip_address` STRING COMMENT 'Network IP address assigned to the POS terminal for connectivity and remote management.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the POS terminal is currently active and operational.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance or security audit performed on the terminal.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance or service performed on the terminal.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this POS terminal record was last updated.',
    `last_pci_audit_date` DATE COMMENT 'Date of the most recent PCI DSS compliance audit or assessment for this terminal.',
    `last_software_update_date` DATE COMMENT 'Date of the most recent software update or patch applied to the terminal.',
    `location_description` STRING COMMENT 'Free‑form description of where the terminal is situated within the restaurant (e.g., "Front Counter – Station 3").',
    `mac_address` STRING COMMENT 'Hardware MAC address of the POS terminal network interface.',
    `maintenance_frequency_days` STRING COMMENT 'Scheduled interval in days between routine maintenance activities.',
    `manufacturer` STRING COMMENT 'Company that produced the POS terminal hardware.',
    `model_number` STRING COMMENT 'Model identifier assigned by the manufacturer.',
    `network_type` STRING COMMENT 'Physical or logical network connection type used by the terminal.. Valid values are `wired|wireless|cellular`',
    `next_maintenance_due_date` DATE COMMENT 'Planned date for the next routine maintenance.',
    `next_pci_audit_date` DATE COMMENT 'Scheduled date for the next PCI DSS compliance audit or assessment.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance or service check.',
    `notes` STRING COMMENT 'Free-text notes for additional context, special configurations, or operational remarks about the terminal.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the POS terminal in the restaurant operations.. Valid values are `active|inactive|maintenance|decommissioned|pending_install`',
    `payment_methods_supported` STRING COMMENT 'Comma‑separated list of payment method codes the terminal can accept (e.g., "credit,debit,cash,applepay").',
    `payment_processing_capability` STRING COMMENT 'Comma-separated list of payment methods supported by this terminal (e.g., credit, debit, NFC, gift_card, mobile_wallet).',
    `payment_processing_vendor` STRING COMMENT 'Name of the third‑party processor handling card authorizations for this terminal.',
    `pci_compliance_status` STRING COMMENT 'Current PCI DSS compliance status of the terminal for secure payment processing.. Valid values are `compliant|non_compliant|pending_audit|expired`',
    `pos_terminal_status` STRING COMMENT 'Current lifecycle status of the terminal.. Valid values are `active|inactive|decommissioned|maintenance`',
    `printer_attached` BOOLEAN COMMENT 'Indicates whether a receipt printer is attached to this POS terminal.',
    `security_compliance` STRING COMMENT 'Compliance certification applicable to the terminals payment processing.. Valid values are `PCI_DSS|PCI_SA|PCI_SAQ`',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for the POS terminal hardware unit.',
    `service_channel` STRING COMMENT 'Primary service channel that this terminal supports for order capture and fulfillment.. Valid values are `dine_in|drive_thru|takeout|delivery|curbside|kiosk`',
    `software_version` STRING COMMENT 'Current version of the Oracle MICROS POS software installed on the terminal.',
    `station_type` STRING COMMENT 'Classification of the station area: Front of House (FOH), Back of House (BOH), Drive-Thru (DT), kiosk, or mobile.. Valid values are `foh|boh|drive_thru|kiosk|mobile`',
    `supports_chip` BOOLEAN COMMENT 'Indicates whether the terminal can read EMV chip cards.',
    `supports_contactless` BOOLEAN COMMENT 'Indicates whether the terminal can process contactless (NFC) payments.',
    `supports_credit_card` BOOLEAN COMMENT 'Indicates whether the terminal can process credit card payments.',
    `supports_debit_card` BOOLEAN COMMENT 'Indicates whether the terminal can process debit card payments.',
    `supports_gift_card` BOOLEAN COMMENT 'Indicates whether the terminal can process gift card payments.',
    `supports_magstripe` BOOLEAN COMMENT 'Indicates whether the terminal can read magnetic stripe cards.',
    `supports_mobile_wallet` BOOLEAN COMMENT 'Indicates whether the terminal supports mobile wallet payments.',
    `supports_nfc` BOOLEAN COMMENT 'Indicates whether the terminal supports contactless NFC payments (e.g., Apple Pay, Google Pay).',
    `supports_olo` BOOLEAN COMMENT 'Indicates whether the terminal can process online orders placed through digital channels.',
    `supports_qr` BOOLEAN COMMENT 'Indicates whether the terminal can scan QR codes for payment or ordering.',
    `supports_third_party_delivery` BOOLEAN COMMENT 'Indicates whether the terminal can process orders from third-party delivery platforms.',
    `terminal_code` STRING COMMENT 'Business identifier or asset tag used in inventory and reporting.',
    `terminal_currency_code` STRING COMMENT 'ISO 4217 currency code used for transactions processed by this terminal.. Valid values are `^[A-Z]{3}$`',
    `terminal_name` STRING COMMENT 'Human‑readable name assigned to the terminal for operational identification.',
    `terminal_number` STRING COMMENT 'Business-facing terminal number or code used for operational identification and reporting.',
    `terminal_type` STRING COMMENT 'Classification of the POS terminal by its operational role and form factor.. Valid values are `counter_pos|drive_thru_pos|kiosk|handheld|mobile_pos|kitchen_display`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the terminal record.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty for the POS terminal hardware expires.',
    `zone` STRING COMMENT 'Area of the restaurant where the terminal operates.. Valid values are `FOH|BOH|kitchen|drive_thru|outside`',
    CONSTRAINT pk_pos_terminal PRIMARY KEY(`pos_terminal_id`)
) COMMENT 'Master reference table for pos_terminal. Referenced by: loyalty.offer_redemption.pos_terminal_id, loyalty.payment_method_link.pos_terminal_id, loyalty.redemption.pos_terminal_id, loyalty.visit.pos_terminal_id, order.drive_thru_event.pos_terminal_id';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` (
    `kitchen_station_id` BIGINT COMMENT 'Primary key for kitchen_station',
    `department_id` BIGINT COMMENT 'Foreign key linking to workforce.department. Business justification: Kitchen stations belong to a department (BOH prep, grill, expo). Workforce scheduling, labor cost allocation, and compliance audits are reported by department. Linking kitchen_station to department en',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the station.',
    `location_profile_id` BIGINT COMMENT 'Reference to the restaurant location where the station resides.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Kitchen stations belong to a specific restaurant unit; adding unit_id creates the necessary parent link and eliminates isolation.',
    `upstream_kitchen_station_id` BIGINT COMMENT 'Self-referencing FK on kitchen_station (upstream_kitchen_station_id)',
    `area_sqft` DECIMAL(18,2) COMMENT 'Physical floor area occupied by the station.',
    `average_ticket_time_seconds` STRING COMMENT 'Average time a ticket spends at this station.',
    `capacity_dishes` STRING COMMENT 'Maximum number of dishes the station can handle concurrently.',
    `daypart_schedule` STRING COMMENT 'Meal periods during which the station is active.',
    `effective_from` DATE COMMENT 'Date when the station became operational.',
    `effective_until` DATE COMMENT 'Date when the station is scheduled to be retired or decommissioned (null if open‑ended).',
    `equipment_list` STRING COMMENT 'Comma‑separated list of major equipment assigned to the station.',
    `health_inspection_date` DATE COMMENT 'Date of the most recent health inspection.',
    `health_inspection_status` STRING COMMENT 'Result of the most recent health inspection for the station.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the station includes automated equipment.',
    `kitchen_station_status` STRING COMMENT 'Current operational status of the station.',
    `last_maintenance_date` DATE COMMENT 'Date when the station last underwent preventive maintenance.',
    `maintenance_interval_days` STRING COMMENT 'Scheduled number of days between routine maintenance events.',
    `operational_hours` STRING COMMENT 'Standard daily operating window (e.g., "08:00-22:00").',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Maximum electrical power consumption of the station.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the kitchen station record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the kitchen station record.',
    `speed_of_service_sos_seconds` STRING COMMENT 'Target time in seconds to complete a dish at this station.',
    `station_code` STRING COMMENT 'Business identifier code used in operational systems and SOPs.',
    `station_name` STRING COMMENT 'Human‑readable name of the kitchen station (e.g., "Grill Station 1").',
    `station_type` STRING COMMENT 'Category of the station based on function (e.g., prep, cook, plating).',
    `temperature_control` BOOLEAN COMMENT 'Indicates if the station has temperature‑control capabilities.',
    `temperature_range_c` STRING COMMENT 'Allowed temperature range for the station (e.g., "0-5").',
    `throughput_per_hour` STRING COMMENT 'Average number of dishes processed by the station each hour.',
    CONSTRAINT pk_kitchen_station PRIMARY KEY(`kitchen_station_id`)
) COMMENT 'Master reference table for kitchen_station. Referenced by station_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`brand` (
    `brand_id` BIGINT COMMENT 'Primary key for brand',
    `parent_brand_id` BIGINT COMMENT 'Identifier of the parent brand in a brand hierarchy, if applicable.',
    `average_annual_sales_usd` DECIMAL(18,2) COMMENT 'Typical yearly sales revenue per brand unit, expressed in US dollars.',
    `average_check_amount_usd` DECIMAL(18,2) COMMENT 'Typical spend per guest (average ticket) in US dollars.',
    `average_daily_customers` STRING COMMENT 'Mean number of guests served per day across brand locations.',
    `average_employee_count` STRING COMMENT 'Typical number of staff employed per restaurant for the brand.',
    `average_store_size_sqft` DECIMAL(18,2) COMMENT 'Mean square‑footage of restaurants operating under the brand.',
    `brand_status` STRING COMMENT 'Current lifecycle state of the brand.',
    `brand_type` STRING COMMENT 'Classification of the brand by service format.',
    `brand_category` STRING COMMENT 'High‑level category describing the brands product focus.',
    `brand_code` STRING COMMENT 'External alphanumeric code used to reference the brand in corporate systems.',
    `color_hex` STRING COMMENT 'Hexadecimal representation of the brands primary color.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the brand record was first created in the system.',
    `brand_description` STRING COMMENT 'Narrative description of the brands positioning and concept.',
    `established_date` DATE COMMENT 'Date the brand was first launched.',
    `franchise_allowed` BOOLEAN COMMENT 'Indicates whether the brand is offered as a franchise model.',
    `franchise_fee_percent` DECIMAL(18,2) COMMENT 'Initial franchise fee expressed as a percent of initial investment.',
    `headquarters_city` STRING COMMENT 'City where the brands corporate headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three‑letter ISO country code of the brands headquarters.',
    `logo_url` STRING COMMENT 'Link to the brands primary logo image.',
    `market_share_percent` DECIMAL(18,2) COMMENT 'Estimated share of the market segment held by the brand.',
    `brand_name` STRING COMMENT 'Human‑readable name of the brand.',
    `primary_market_region` STRING COMMENT 'Geographic region where the brand has its strongest presence.',
    `royalty_fee_percent` DECIMAL(18,2) COMMENT 'Ongoing royalty fee charged to franchisees, expressed as a percent of sales.',
    `segment` STRING COMMENT 'Target consumer segment for the brand.',
    `social_media_handle` STRING COMMENT 'Primary social media identifier (e.g., @brand) used for marketing.',
    `sos_target_seconds` STRING COMMENT 'Targeted service time from order to delivery for the brand.',
    `tagline` STRING COMMENT 'Short marketing slogan associated with the brand.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the brand record.',
    `website_url` STRING COMMENT 'Public website address for the brand.',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Master reference table for brand. Referenced by brand_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_brand_standard_id` FOREIGN KEY (`brand_standard_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand_standard`(`brand_standard_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ADD CONSTRAINT `fk_restaurant_location_profile_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ADD CONSTRAINT `fk_restaurant_format_config_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ADD CONSTRAINT `fk_restaurant_format_config_brand_standard_id` FOREIGN KEY (`brand_standard_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand_standard`(`brand_standard_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ADD CONSTRAINT `fk_restaurant_format_config_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ADD CONSTRAINT `fk_restaurant_operating_hours_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ADD CONSTRAINT `fk_restaurant_equipment_asset_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ADD CONSTRAINT `fk_restaurant_equipment_asset_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ADD CONSTRAINT `fk_restaurant_brand_standard_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ADD CONSTRAINT `fk_restaurant_brand_standard_superseded_by_standard_brand_standard_id` FOREIGN KEY (`superseded_by_standard_brand_standard_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand_standard`(`brand_standard_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ADD CONSTRAINT `fk_restaurant_pos_terminal_kitchen_station_id` FOREIGN KEY (`kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ADD CONSTRAINT `fk_restaurant_pos_terminal_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ADD CONSTRAINT `fk_restaurant_pos_terminal_primary_replaced_pos_terminal_id` FOREIGN KEY (`primary_replaced_pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ADD CONSTRAINT `fk_restaurant_kitchen_station_location_profile_id` FOREIGN KEY (`location_profile_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`location_profile`(`location_profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ADD CONSTRAINT `fk_restaurant_kitchen_station_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ADD CONSTRAINT `fk_restaurant_kitchen_station_upstream_kitchen_station_id` FOREIGN KEY (`upstream_kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ADD CONSTRAINT `fk_restaurant_brand_parent_brand_id` FOREIGN KEY (`parent_brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`restaurant` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`restaurant` SET TAGS ('dbx_domain' = 'restaurant');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` SET TAGS ('dbx_subdomain' = 'location_identity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `average_cover_count` SET TAGS ('dbx_business_glossary_term' = 'Average Cover Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `average_ticket_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Ticket Time Seconds');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `average_unit_volume_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV) USD');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `average_unit_volume_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `concept_type` SET TAGS ('dbx_business_glossary_term' = 'Concept Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `concept_type` SET TAGS ('dbx_value_regex' = 'QSR|casual_dining|fast_casual|fine_dining|food_court|ghost_kitchen');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `daypart_schedule` SET TAGS ('dbx_business_glossary_term' = 'Daypart Schedule');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `drive_thru_lanes` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Lanes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `haccp_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Certified');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `has_online_ordering` SET TAGS ('dbx_business_glossary_term' = 'Has Online Ordering (OLO)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `has_third_party_delivery` SET TAGS ('dbx_business_glossary_term' = 'Has Third-Party Delivery (3PD)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Score');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `kds_station_count` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Display System (KDS) Station Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|temporarily_closed|permanently_closed|under_construction|pending_opening');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Ownership Model');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `ownership_model` SET TAGS ('dbx_value_regex' = 'company_owned|franchised|joint_venture|licensed');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `parking_spaces` SET TAGS ('dbx_business_glossary_term' = 'Parking Spaces');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `pos_system_version` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) System Version');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `same_store_sales_pct` SET TAGS ('dbx_business_glossary_term' = 'Same-Store Sales (SSS) Percentage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `same_store_sales_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `speed_of_service_seconds` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Seconds');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `table_turn_rate` SET TAGS ('dbx_business_glossary_term' = 'Table Turn Rate');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `throughput_capacity_orders_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity Orders Per Hour');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `unit_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `unit_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` SET TAGS ('dbx_subdomain' = 'location_identity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `location_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Location Profile ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `building_ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Building Ownership Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `building_ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|franchisee_owned|ground_lease');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `delivery_radius_km` SET TAGS ('dbx_business_glossary_term' = 'Delivery Radius (Kilometers)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `drive_thru_lane_count` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Lane Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `has_accessible_parking` SET TAGS ('dbx_business_glossary_term' = 'Has Accessible Parking');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `has_drive_thru` SET TAGS ('dbx_business_glossary_term' = 'Has Drive-Thru (DT)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `has_patio_seating` SET TAGS ('dbx_business_glossary_term' = 'Has Patio Seating');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `has_playground` SET TAGS ('dbx_business_glossary_term' = 'Has Playground');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `has_restroom` SET TAGS ('dbx_business_glossary_term' = 'Has Restroom');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `has_wheelchair_access` SET TAGS ('dbx_business_glossary_term' = 'Has Wheelchair Access');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `has_wifi` SET TAGS ('dbx_business_glossary_term' = 'Has WiFi');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `last_remodel_date` SET TAGS ('dbx_business_glossary_term' = 'Last Remodel Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `lot_size_sqft` SET TAGS ('dbx_business_glossary_term' = 'Lot Size (Square Feet)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `parking_capacity` SET TAGS ('dbx_business_glossary_term' = 'Parking Capacity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `patio_seat_count` SET TAGS ('dbx_business_glossary_term' = 'Patio Seat Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `proximity_to_airport_km` SET TAGS ('dbx_business_glossary_term' = 'Proximity to Airport (Kilometers)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `proximity_to_highway_km` SET TAGS ('dbx_business_glossary_term' = 'Proximity to Highway (Kilometers)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `proximity_to_mall_km` SET TAGS ('dbx_business_glossary_term' = 'Proximity to Mall (Kilometers)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `restaurant_number` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `site_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Site Closed Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `site_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Site Opened Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|under_construction|planned|closed|temporarily_closed');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `trade_area_classification` SET TAGS ('dbx_business_glossary_term' = 'Trade Area Classification');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` SET TAGS ('dbx_subdomain' = 'location_identity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `format_config_id` SET TAGS ('dbx_business_glossary_term' = 'Format Configuration ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `alcohol_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Service Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `boh_cooking_line_count` SET TAGS ('dbx_business_glossary_term' = 'Back of House (BOH) Cooking Line Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `boh_kitchen_sq_ft` SET TAGS ('dbx_business_glossary_term' = 'Back of House (BOH) Kitchen Square Footage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `boh_prep_station_count` SET TAGS ('dbx_business_glossary_term' = 'Back of House (BOH) Prep Station Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `brand_standard_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `brand_standard_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempt');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `breakfast_daypart_flag` SET TAGS ('dbx_business_glossary_term' = 'Breakfast Daypart Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `config_version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `cover_count_capacity_per_daypart` SET TAGS ('dbx_business_glossary_term' = 'Cover Count Capacity Per Daypart');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `curbside_pickup_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Curbside Pickup Enabled Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `dining_format_type` SET TAGS ('dbx_business_glossary_term' = 'Dining Format Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `dining_format_type` SET TAGS ('dbx_value_regex' = 'QSR|fast_casual|casual_dining|fine_dining');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `drive_thru_lane_config` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Lane Configuration');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `drive_thru_lane_config` SET TAGS ('dbx_value_regex' = 'none|single|dual|triple');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `drive_thru_window_count` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Window Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `foh_bar_seating_count` SET TAGS ('dbx_business_glossary_term' = 'Front of House (FOH) Bar Seating Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `foh_outdoor_seating_count` SET TAGS ('dbx_business_glossary_term' = 'Front of House (FOH) Outdoor Seating Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `foh_seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Front of House (FOH) Seating Capacity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `foh_table_count` SET TAGS ('dbx_business_glossary_term' = 'Front of House (FOH) Table Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `format_name` SET TAGS ('dbx_business_glossary_term' = 'Format Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `kds_screen_count` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Display System (KDS) Screen Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `kiosk_count` SET TAGS ('dbx_business_glossary_term' = 'Digital Ordering Kiosk Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `last_remodel_date` SET TAGS ('dbx_business_glossary_term' = 'Last Remodel Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `late_night_daypart_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Night Daypart Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `olo_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Ordering (OLO) Enabled Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `parking_space_count` SET TAGS ('dbx_business_glossary_term' = 'Parking Space Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `pos_terminal_count` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `service_model` SET TAGS ('dbx_business_glossary_term' = 'Service Model');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `service_model` SET TAGS ('dbx_value_regex' = 'counter|table|drive_thru|kiosk|hybrid');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `sos_benchmark_seconds` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Benchmark Seconds');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `table_turn_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Table Turn Target Minutes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `third_party_delivery_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Enabled Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `throughput_capacity_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity Per Hour');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `twenty_four_hour_operation_flag` SET TAGS ('dbx_business_glossary_term' = '24-Hour Operation Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` SET TAGS ('dbx_subdomain' = 'location_identity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `operating_hours_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `close_time` SET TAGS ('dbx_business_glossary_term' = 'Close Time');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|all_day|overnight');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `daypart_end_time` SET TAGS ('dbx_business_glossary_term' = 'Daypart End Time');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `daypart_start_time` SET TAGS ('dbx_business_glossary_term' = 'Daypart Start Time');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `delivery_window_close_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Close Time');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `delivery_window_open_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Open Time');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `drive_thru_close_time` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Close Time');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `drive_thru_open_time` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Open Time');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `expected_cover_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Cover Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `expected_table_turn_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Table Turn Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `holiday_name` SET TAGS ('dbx_business_glossary_term' = 'Holiday Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `holiday_schedule_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Holiday Schedule Override Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `is_24_hour_operation` SET TAGS ('dbx_business_glossary_term' = 'Is 24-Hour Operation');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `is_closed` SET TAGS ('dbx_business_glossary_term' = 'Is Closed');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `last_order_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Last Order Cutoff Time');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `open_time` SET TAGS ('dbx_business_glossary_term' = 'Open Time');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'regular|holiday|seasonal|temporary|special_event');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `seasonal_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Adjustment Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `seasonal_period_name` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Period Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `special_event_name` SET TAGS ('dbx_business_glossary_term' = 'Special Event Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `target_speed_of_service_seconds` SET TAGS ('dbx_business_glossary_term' = 'Target Speed of Service (SOS) Seconds');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `target_ticket_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Target Ticket Time Seconds');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `throughput_capacity_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity Per Hour');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` SET TAGS ('dbx_subdomain' = 'operations_standards');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost (USD)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `asset_condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Rating');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `asset_condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `compliance_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `compliance_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sold|scrapped|donated|recycled|returned_to_vendor');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `energy_rating` SET TAGS ('dbx_business_glossary_term' = 'Energy Rating');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `last_service_date` SET TAGS ('dbx_business_glossary_term' = 'Last Service Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `last_temperature_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Temperature Check Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `location_zone` SET TAGS ('dbx_business_glossary_term' = 'Location Zone');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `location_zone` SET TAGS ('dbx_value_regex' = 'boh|foh|drive_thru|storage|outdoor');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `maintenance_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency Days');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|under_repair|scheduled_replacement|decommissioned');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|rented');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `power_consumption_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption Watts');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost (USD)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `service_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `service_contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `temperature_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Critical Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `temperature_max_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Maximum Fahrenheit');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `temperature_min_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Minimum Fahrenheit');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` SET TAGS ('dbx_subdomain' = 'operations_standards');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `superseded_by_standard_brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Brand Standard ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `applicable_format` SET TAGS ('dbx_business_glossary_term' = 'Applicable Restaurant Format');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `applicable_ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Applicable Ownership Model');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `applicable_ownership_model` SET TAGS ('dbx_value_regex' = 'all|company_owned|franchised');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `brand_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Standard Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `brand_standard_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under_review|superseded');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `compliance_requirement_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Level');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `compliance_requirement_level` SET TAGS ('dbx_value_regex' = 'mandatory|recommended|aspirational');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `governing_body_reference` SET TAGS ('dbx_business_glossary_term' = 'Governing Body Reference');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `guest_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest-Facing Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'observation|checklist|measurement|testing|documentation_review|guest_feedback');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `non_compliance_consequence` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Consequence');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `non_compliance_consequence` SET TAGS ('dbx_value_regex' = 'warning|corrective_action_plan|financial_penalty|operational_suspension|franchise_termination|none');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `sop_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Document Reference');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `standard_category` SET TAGS ('dbx_business_glossary_term' = 'Standard Category');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{3,5}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `standard_description` SET TAGS ('dbx_business_glossary_term' = 'Standard Description');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `standard_name` SET TAGS ('dbx_business_glossary_term' = 'Standard Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `target_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `target_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Value');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `training_module_reference` SET TAGS ('dbx_business_glossary_term' = 'Training Module Reference');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` SET TAGS ('dbx_subdomain' = 'operations_standards');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Kitchen Station Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `primary_replaced_pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Replaced Pos Terminal Id');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `primary_replaced_pos_terminal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `cash_drawer_attached` SET TAGS ('dbx_business_glossary_term' = 'Cash Drawer Attached');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Identifier');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `hardware_model` SET TAGS ('dbx_business_glossary_term' = 'Hardware Model');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `last_pci_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Card Industry (PCI) Audit Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `last_software_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Software Update Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `maintenance_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency (Days)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Terminal Manufacturer');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Terminal Model Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = 'wired|wireless|cellular');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `next_pci_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Card Industry (PCI) Audit Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned|pending_install');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `payment_methods_supported` SET TAGS ('dbx_business_glossary_term' = 'Payment Methods Supported');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `payment_processing_capability` SET TAGS ('dbx_business_glossary_term' = 'Payment Processing Capability');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `payment_processing_vendor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processing Vendor');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `pci_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry Data Security Standard (PCI DSS) Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `pci_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_audit|expired');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `pos_terminal_status` SET TAGS ('dbx_business_glossary_term' = 'POS Terminal Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `pos_terminal_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|maintenance');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `printer_attached` SET TAGS ('dbx_business_glossary_term' = 'Printer Attached');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `security_compliance` SET TAGS ('dbx_business_glossary_term' = 'Security Compliance Level');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `security_compliance` SET TAGS ('dbx_value_regex' = 'PCI_DSS|PCI_SA|PCI_SAQ');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `service_channel` SET TAGS ('dbx_business_glossary_term' = 'Service Channel');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `service_channel` SET TAGS ('dbx_value_regex' = 'dine_in|drive_thru|takeout|delivery|curbside|kiosk');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `station_type` SET TAGS ('dbx_business_glossary_term' = 'Station Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `station_type` SET TAGS ('dbx_value_regex' = 'foh|boh|drive_thru|kiosk|mobile');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_chip` SET TAGS ('dbx_business_glossary_term' = 'Chip Card Support Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_contactless` SET TAGS ('dbx_business_glossary_term' = 'Contactless Support Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_credit_card` SET TAGS ('dbx_business_glossary_term' = 'Supports Credit Card');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_credit_card` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_credit_card` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_debit_card` SET TAGS ('dbx_business_glossary_term' = 'Supports Debit Card');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_debit_card` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_debit_card` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_gift_card` SET TAGS ('dbx_business_glossary_term' = 'Supports Gift Card');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_magstripe` SET TAGS ('dbx_business_glossary_term' = 'Magstripe Support Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_mobile_wallet` SET TAGS ('dbx_business_glossary_term' = 'Supports Mobile Wallet');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_mobile_wallet` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_mobile_wallet` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_nfc` SET TAGS ('dbx_business_glossary_term' = 'Supports Near Field Communication (NFC)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_olo` SET TAGS ('dbx_business_glossary_term' = 'Supports Online Ordering (OLO)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_qr` SET TAGS ('dbx_business_glossary_term' = 'QR Code Support Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `supports_third_party_delivery` SET TAGS ('dbx_business_glossary_term' = 'Supports Third-Party Delivery (3PD)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `terminal_code` SET TAGS ('dbx_business_glossary_term' = 'POS Terminal Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `terminal_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Terminal Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `terminal_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `terminal_name` SET TAGS ('dbx_business_glossary_term' = 'POS Terminal Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `terminal_number` SET TAGS ('dbx_business_glossary_term' = 'Terminal Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `terminal_type` SET TAGS ('dbx_business_glossary_term' = 'Terminal Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `terminal_type` SET TAGS ('dbx_value_regex' = 'counter_pos|drive_thru_pos|kiosk|handheld|mobile_pos|kitchen_display');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `zone` SET TAGS ('dbx_business_glossary_term' = 'Operational Zone');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `zone` SET TAGS ('dbx_value_regex' = 'FOH|BOH|kitchen|drive_thru|outside');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` SET TAGS ('dbx_subdomain' = 'operations_standards');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station Identifier');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `location_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Location Profile Id');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `upstream_kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Kitchen Station Id');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `upstream_kitchen_station_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Area Sqft');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `average_ticket_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Ticket Time Seconds');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `capacity_dishes` SET TAGS ('dbx_business_glossary_term' = 'Capacity Dishes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `daypart_schedule` SET TAGS ('dbx_business_glossary_term' = 'Daypart Schedule');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `equipment_list` SET TAGS ('dbx_business_glossary_term' = 'Equipment List');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `health_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `health_inspection_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `health_inspection_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `health_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `health_inspection_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `health_inspection_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `kitchen_station_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `maintenance_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval Days');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `operational_hours` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating Kw');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `speed_of_service_sos_seconds` SET TAGS ('dbx_business_glossary_term' = 'Speed Of Service Sos Seconds');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `station_name` SET TAGS ('dbx_business_glossary_term' = 'Station Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `station_type` SET TAGS ('dbx_business_glossary_term' = 'Station Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `temperature_control` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `temperature_range_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range C');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `throughput_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Throughput Per Hour');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` SET TAGS ('dbx_subdomain' = 'operations_standards');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `parent_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Id');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `average_annual_sales_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Annual Sales Usd');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `average_check_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Check Amount Usd');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `average_daily_customers` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Customers');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `average_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Average Employee Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `average_store_size_sqft` SET TAGS ('dbx_business_glossary_term' = 'Average Store Size Sqft');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `brand_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `brand_category` SET TAGS ('dbx_business_glossary_term' = 'Brand Category');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `color_hex` SET TAGS ('dbx_business_glossary_term' = 'Brand Color Hex');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `brand_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Established Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `franchise_allowed` SET TAGS ('dbx_business_glossary_term' = 'Franchise Allowed');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `franchise_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee Percent');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `logo_url` SET TAGS ('dbx_business_glossary_term' = 'Logo Url');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `market_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Market Share Percent');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `primary_market_region` SET TAGS ('dbx_business_glossary_term' = 'Primary Market Region');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `royalty_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Fee Percent');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Brand Segment');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `social_media_handle` SET TAGS ('dbx_business_glossary_term' = 'Social Media Handle');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `sos_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Brand Sos Target Seconds');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `tagline` SET TAGS ('dbx_business_glossary_term' = 'Brand Tagline');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
