-- Schema for Domain: restaurant | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:45:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`restaurant` COMMENT 'Master record for every restaurant unit — company-owned and franchised — including location attributes, format (QSR/casual/fine-dining), FOH/BOH configuration, operating hours, daypart schedules, equipment, throughput capacity, speed-of-service (SOS) benchmarks, table turns, cover counts, AUV, SSS, and comp sales. Operational anchor for brand standards and SOPs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`unit` (
    `unit_id` BIGINT COMMENT 'Unique identifier for the restaurant unit. Primary key for the unit master record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Unit should reference its brand via a foreign key rather than a free‑text code; brand_id provides referential integrity.',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: Units must be linked to the applicable brand standard for compliance tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost accounting reports allocate expenses per unit via a cost center; linking unit to cost_center enables accurate budgeting and variance analysis.',
    `department_id` BIGINT COMMENT 'Foreign key linking to restaurant.department. Business justification: Linking a unit to its department enables organizational reporting and eliminates the department table silo.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Facility‑to‑Unit link required for building‑level maintenance, energy‑rating compliance, and health‑inspection tracking.',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchisee entity that owns and operates this unit. Null for company-owned units.',
    `landlord_id` BIGINT COMMENT 'Foreign key linking to realestate.landlord. Business justification: Landlord‑to‑Unit link supports landlord contact management, rent negotiations, and compliance audits; each unit has a responsible landlord.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to realestate.lease. Business justification: Lease‑to‑Unit association needed for lease‑expiry alerts, rent schedule generation, and financial reporting; each unit operates under a specific lease.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Required for consolidated financial statements and tax compliance; each restaurant unit must be mapped to its legal entity for reporting.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Program Assignment per Restaurant Unit: needed for reporting which loyalty program each unit runs, enabling rollout planning and performance tracking.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Site‑to‑Unit link required for property‑level rent, CAPEX, and compliance reporting; experts expect each restaurant unit to be tied to its real‑estate site.',
    `trade_area_id` BIGINT COMMENT 'Foreign key linking to realestate.trade_area. Business justification: Trade_Area‑to‑Unit mapping drives market‑share analysis, demographic targeting, and site‑selection KPI reporting.',
    `sop_document_id` BIGINT COMMENT 'Foreign key linking to foodsafety.sop_document. Business justification: Regulatory compliance tracks which SOP document each unit must follow for food safety procedures.',
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
    `location_unit_id` BIGINT COMMENT 'Reference to the master restaurant unit record. Links this location profile to the operational restaurant entity.',
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
    `brand_id` BIGINT COMMENT 'add column brand_id (BIGINT) with FK to restaurant.brand.brand_id - format configurations (QSR/casual/fine-dining) should be brand-specific',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit to which this format configuration applies.',
    `format_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit to which this format configuration applies.',
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
    `scheduling_template_id` BIGINT COMMENT 'Identifier of the labor scheduling template associated with these operating hours. Links to workforce scheduling system for Full-Time Equivalent (FTE) planning and shift assignment.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this operating hours schedule. Used for audit trail and compliance tracking.',
    `operating_employee_id` BIGINT COMMENT 'Identifier of the user who approved this operating hours schedule. Used for audit trail and compliance tracking.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit to which these operating hours apply. Links to the restaurant master record.',
    `operating_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit to which these operating hours apply. Links to the restaurant master record.',
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
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where this equipment asset is installed.',
    `equipment_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where this equipment asset is installed.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Asset depreciation and financial reporting require each physical equipment asset to be tied to a fixed‑asset record in finance.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the vendor or service provider responsible for maintenance and repair of this equipment asset.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` (
    `throughput_benchmark_id` BIGINT COMMENT 'Unique identifier for the throughput benchmark record. Primary key for this entity.',
    `daypart_id` BIGINT COMMENT 'Identifier of the daypart (e.g., breakfast, lunch, dinner, late night) for which this benchmark applies. Links to the daypart reference table.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit to which this throughput benchmark applies. Links to the restaurant master record.',
    `throughput_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit to which this throughput benchmark applies. Links to the restaurant master record.',
    `approval_date` DATE COMMENT 'Date when this throughput benchmark was formally approved for use in operational performance measurement.',
    `approved_by` STRING COMMENT 'Name or identifier of the operations manager, regional director, or executive who approved this throughput benchmark.',
    `benchmark_source` STRING COMMENT 'Source or origin of the benchmark definition. Corporate_standard = company-wide standard, franchise_agreement = defined in franchise contract, regional_target = regional operations target, unit_specific = customized for individual unit, industry_benchmark = derived from industry standards.. Valid values are `corporate_standard|franchise_agreement|regional_target|unit_specific|industry_benchmark`',
    `benchmark_type` STRING COMMENT 'Classification of the benchmark: target = standard operational target, minimum = minimum acceptable performance, maximum = maximum achievable performance, stretch = aspirational goal for high-performing units.. Valid values are `target|minimum|maximum|stretch`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this throughput benchmark record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date until which this throughput benchmark remains effective. Null indicates the benchmark is currently active with no defined end date.',
    `effective_start_date` DATE COMMENT 'Date from which this throughput benchmark becomes effective. Supports temporal tracking of benchmark changes over time.',
    `equipment_capacity_constraint` STRING COMMENT 'Description of any equipment capacity constraints (e.g., grill capacity, fryer capacity, KDS screen count) that limit throughput for this service channel and daypart.',
    `labor_fte_requirement` DECIMAL(18,2) COMMENT 'Number of Full-Time Equivalent (FTE) staff required to achieve the target throughput for this service channel and daypart. Used for workforce scheduling and labor planning.',
    `last_review_date` DATE COMMENT 'Date when this throughput benchmark was last reviewed by operations management or performance analysts.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this throughput benchmark record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this throughput benchmark. Calculated based on last_review_date and review_frequency_days.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, rationale, or special considerations for this throughput benchmark. May include information about seasonal adjustments, promotional impacts, or facility-specific factors.',
    `off_peak_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base throughput targets during off-peak hours for this service channel and daypart. Used to adjust capacity expectations during low-demand periods.',
    `peak_hour_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base throughput targets during peak hours for this service channel and daypart. Used to adjust capacity expectations during high-demand periods.',
    `queue_length_threshold` STRING COMMENT 'Maximum acceptable queue length (number of waiting customers or orders) for this service channel and daypart before operational intervention is required.',
    `restaurant_format` STRING COMMENT 'Format classification of the restaurant for which this benchmark applies. QSR = Quick-Service Restaurant, casual = Casual dining, fine_dining = Fine-dining establishment. Benchmarks vary significantly by format.. Valid values are `QSR|casual|fine_dining`',
    `review_frequency_days` STRING COMMENT 'Frequency in days at which this throughput benchmark should be reviewed and potentially updated. Supports continuous improvement and operational excellence initiatives.',
    `service_channel` STRING COMMENT 'The service channel for which this benchmark is defined. DT = Drive-Thru, counter = Front counter service, OLO = Online Ordering, 3PD = Third-Party Delivery, dine_in = Dine-in service, curbside = Curbside pickup.. Valid values are `DT|counter|OLO|3PD|dine_in|curbside`',
    `sos_compliance_threshold_pct` DECIMAL(18,2) COMMENT 'Percentage threshold for Speed of Service (SOS) compliance. Represents the minimum percentage of orders that must meet the target ticket time to be considered compliant.',
    `target_acv` DECIMAL(18,2) COMMENT 'Target Average Check Value (ACV) in local currency for this service channel and daypart. Represents the expected revenue per transaction.',
    `target_adt` DECIMAL(18,2) COMMENT 'Target Average Daily Transactions (ADT) for this service channel and daypart. Represents the expected number of transactions per day.',
    `target_atc` DECIMAL(18,2) COMMENT 'Target Average Transaction Count (ATC) for this service channel and daypart. Represents the expected number of items per transaction.',
    `target_cover_count_capacity` STRING COMMENT 'Maximum number of covers (individual servings) that can be served simultaneously for this service channel and daypart, based on FOH (Front of House) and BOH (Back of House) capacity constraints.',
    `target_table_turn_minutes` STRING COMMENT 'Target time in minutes for a table turn (time from guest seating to table availability for next guest). Applicable primarily to dine-in service channels in casual and fine-dining formats.',
    `target_throughput_covers_per_hour` DECIMAL(18,2) COMMENT 'Target number of customer covers (individual servings) that should be served per hour for this service channel and daypart. Used for capacity planning and performance benchmarking.',
    `target_throughput_transactions_per_hour` DECIMAL(18,2) COMMENT 'Target number of transactions (orders) that should be processed per hour for this service channel and daypart. Used for operational performance benchmarking.',
    `target_ticket_time_seconds` STRING COMMENT 'Target time in seconds from order placement to order fulfillment for this service channel and daypart. Key Speed of Service (SOS) metric.',
    `throughput_benchmark_status` STRING COMMENT 'Current lifecycle status of the throughput benchmark record. Active = currently in use, inactive = temporarily disabled, draft = under review, archived = historical record.. Valid values are `active|inactive|draft|archived`',
    CONSTRAINT pk_throughput_benchmark PRIMARY KEY(`throughput_benchmark_id`)
) COMMENT 'Defines throughput capacity benchmarks and speed-of-service (SOS) targets for each restaurant unit by service channel (DT drive-thru, counter, OLO online, 3PD third-party delivery) and daypart. Captures target ticket time (seconds), target throughput (covers/hour or transactions/hour), ADT (Average Daily Transactions) target, ATC (Average Transaction Count) target, ACV (Average Check Value) target, table turn target (minutes), and cover count capacity. Used for operational performance benchmarking and SOS compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` (
    `sos_measurement_id` BIGINT COMMENT 'Unique identifier for each speed-of-service measurement event. Primary key for the SOS measurement transactional record.',
    `daypart_id` BIGINT COMMENT 'Identifier of the daypart during which this measurement occurred (breakfast, lunch, dinner, late-night). Links to daypart reference data.',
    `guest_order_id` BIGINT COMMENT 'Identifier of the guest order associated with this SOS measurement. Links to the order transaction record captured in the POS system.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where this SOS measurement was captured. Links to the restaurant master record.',
    `sos_target_id` BIGINT COMMENT 'Identifier of the applicable SOS target benchmark for this service channel and daypart combination. Links to the SOS target reference data for variance analysis.',
    `sos_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where this SOS measurement was captured. Links to the restaurant master record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SOS measurement record was first created in the data system, in format yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail for data lineage.',
    `equipment_issue_flag` BOOLEAN COMMENT 'Boolean indicator of whether any equipment malfunction or issue was reported during this service event. True if equipment issue was logged; False otherwise.',
    `exception_reason` STRING COMMENT 'Free-text description of any exceptional circumstances that impacted service time for this measurement. Examples include equipment failure, staff shortage, system outage, or unusual order requirements.',
    `guest_satisfaction_rating` STRING COMMENT 'Customer Satisfaction (CSAT) rating provided by the guest for this service event, typically on a scale of 1-5. Captured via receipt survey, mobile app feedback, or kiosk prompt.',
    `measurement_quality_score` DECIMAL(18,2) COMMENT 'Data quality score for this measurement record, ranging from 0.00 to 1.00. Reflects completeness, accuracy, and reliability of the captured timing data. Lower scores indicate potential data quality issues.',
    `measurement_source` STRING COMMENT 'System or device that captured the SOS measurement. Point of Sale (POS) timer, Kitchen Display System (KDS), drive-thru sensor array, manual staff entry, Online Ordering (OLO) platform, or third-party delivery API.. Valid values are `pos_timer|kds_system|drive_thru_sensor|manual_entry|olo_platform|third_party_api`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the speed-of-service measurement was captured, in format yyyy-MM-ddTHH:mm:ss.SSSXXX. Represents the business event time of the service completion.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SOS measurement record was last modified in the data system, in format yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail for data lineage and change tracking.',
    `nps_score` STRING COMMENT 'Net Promoter Score (NPS) rating provided by the guest for this service event, typically on a scale of 0-10. Measures guest loyalty and likelihood to recommend.',
    `order_complexity_score` DECIMAL(18,2) COMMENT 'Calculated complexity score for the order based on item count, customizations, and preparation requirements. Higher scores indicate more complex orders that may require longer service times.',
    `order_item_count` STRING COMMENT 'Total number of menu items in the order associated with this SOS measurement. Used to analyze SOS performance relative to order complexity.',
    `order_to_delivery_time_seconds` STRING COMMENT 'Total elapsed time in seconds from order placement to order delivered to guest. Includes preparation time plus handoff time. End-to-end service time metric.',
    `order_to_ready_time_seconds` STRING COMMENT 'Elapsed time in seconds from order placement to order ready for pickup or delivery. Measured from POS order entry timestamp to Kitchen Display System (KDS) completion timestamp.',
    `peak_period_flag` BOOLEAN COMMENT 'Boolean indicator of whether the measurement occurred during a designated peak service period. True for peak hours; False for off-peak hours.',
    `queue_depth_count` STRING COMMENT 'Number of vehicles or guests in the service queue at the time of measurement. Indicates throughput capacity and congestion level.',
    `queue_wait_time_seconds` STRING COMMENT 'Time in seconds the guest or vehicle spent waiting in queue before placing order. Applicable primarily to Drive-Thru (DT) and counter service channels.',
    `service_channel` STRING COMMENT 'The channel through which the guest order was placed and fulfilled. Drive-Thru (DT), Front of House (FOH) counter, self-service kiosk, Online Ordering (OLO), Third-Party Delivery (3PD), or curbside pickup.. Valid values are `drive_thru|counter|kiosk|online_ordering|third_party_delivery|curbside`',
    `service_recovery_flag` BOOLEAN COMMENT 'Boolean indicator of whether service recovery actions were taken for this order due to SOS delays or other service failures. True if recovery actions were applied; False otherwise.',
    `staff_count_on_duty` STRING COMMENT 'Number of Full-Time Equivalent (FTE) staff members on duty in the service area at the time of measurement. Used to correlate staffing levels with SOS performance.',
    `target_met_flag` BOOLEAN COMMENT 'Boolean indicator of whether the SOS measurement met or exceeded the target benchmark. True if actual time was at or below target; False if actual time exceeded target.',
    `target_variance_seconds` STRING COMMENT 'Difference in seconds between actual order-to-delivery time and the SOS target benchmark. Positive values indicate slower than target; negative values indicate faster than target.',
    `ticket_time_seconds` STRING COMMENT 'Total time in seconds the order ticket was active in the kitchen or service queue. Represents Back of House (BOH) processing duration from ticket creation to fulfillment.',
    `weather_condition` STRING COMMENT 'Weather condition at the restaurant location during the measurement period. Used to analyze external factors impacting drive-thru and curbside service times. [ENUM-REF-CANDIDATE: clear|rain|snow|fog|wind|extreme_heat|extreme_cold — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_sos_measurement PRIMARY KEY(`sos_measurement_id`)
) COMMENT 'Transactional records of actual speed-of-service (SOS), throughput measurements, and table turn events captured per service event at each restaurant unit across all channels. For drive-thru/counter/kiosk/OLO: captures measurement timestamp, service channel, daypart, order-to-ready time, order-to-delivery time, ticket time, queue wait time, and measurement source (POS timer, KDS, sensor). For dine-in table service: captures table identifier, cover count, seating time, order-placed time, food-delivered time, check-presented time, table-cleared time, total turn time, server station, party size, and table status transitions. This is the single source of truth for all operational timing and throughput measurements across every service model. Enables unified SOS trend analysis, table turn rate optimization, cover count tracking, FOH throughput benchmarking, and benchmark gap identification.';

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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` (
    `unit_performance_id` BIGINT COMMENT 'Unique identifier for the unit performance record. Primary key for this periodic operational and financial performance snapshot.',
    `performance_period_id` BIGINT COMMENT 'Foreign key linking to restaurant.performance_period. Business justification: Linking unit_performance to the master performance_period table provides a single source of period metadata and eliminates redundant date fields.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit for which this performance record is captured. Links to the restaurant master record.',
    `acv_amount` DECIMAL(18,2) COMMENT 'Average Check Value (ACV) - average revenue per customer transaction during the performance period. Calculated as total revenue divided by transaction count.',
    `adt_count` STRING COMMENT 'Average Daily Transactions (ADT) - average number of customer transactions processed per day during the performance period.',
    `atc_count` STRING COMMENT 'Average Transaction Count (ATC) - total number of customer transactions during the performance period.',
    `auc_amount` DECIMAL(18,2) COMMENT 'Average Unit Volume (AUV) - total revenue generated by the restaurant unit during the performance period. Key metric for unit-level revenue performance.',
    `cogs_amount` DECIMAL(18,2) COMMENT 'Cost of Goods Sold (COGS) - total cost of food and beverage inventory consumed during the performance period.',
    `cogs_percent` DECIMAL(18,2) COMMENT 'Cost of Goods Sold (COGS) Percentage - COGS as a percentage of total revenue. Key metric for food cost management.',
    `comp_sales_amount` DECIMAL(18,2) COMMENT 'Comparable Store Sales (Comp Sales) - revenue for the current period for units that were operational in both the current and prior comparison period.',
    `comp_sales_variance_amount` DECIMAL(18,2) COMMENT 'Variance in Comparable Store Sales between current period and prior period, expressed as an absolute amount.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this performance record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `ebitda_amount` DECIMAL(18,2) COMMENT 'Earnings Before Interest, Taxes, Depreciation, and Amortization (EBITDA) - key profitability metric for unit-level P&L management.',
    `fiscal_month` STRING COMMENT 'Fiscal month within the fiscal year (1-12) to which this performance period belongs.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter within the fiscal year (1, 2, 3, or 4) to which this performance period belongs.',
    `fiscal_week` STRING COMMENT 'Fiscal week within the fiscal year (1-52 or 1-53) to which this performance period belongs.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this performance period belongs (e.g., 2024).',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'Gross revenue before any deductions (discounts, promotions, refunds, voids) during the performance period.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost including wages, benefits, and payroll taxes for the performance period.',
    `labor_percent` DECIMAL(18,2) COMMENT 'Labor Cost Percentage - total labor cost as a percentage of total revenue. Key metric for workforce efficiency.',
    `marketing_expense_amount` DECIMAL(18,2) COMMENT 'Marketing and promotional expenses allocated to this unit during the performance period, including local store marketing and national campaign contributions.',
    `net_income_amount` DECIMAL(18,2) COMMENT 'Net income (profit after all expenses, taxes, interest, depreciation, and amortization) for the performance period.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Net revenue after deducting discounts, promotions, refunds, and voids during the performance period.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this performance period, including explanations for anomalies, special events, or operational issues.',
    `operating_income_amount` DECIMAL(18,2) COMMENT 'Operating income (revenue minus operating expenses) for the performance period. Excludes interest, taxes, depreciation, and amortization.',
    `performance_status` STRING COMMENT 'Status of the performance record indicating whether the data is draft, preliminary, final, revised, or archived.. Valid values are `draft|preliminary|final|revised|archived`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance record was last updated in the system.',
    `rent_expense_amount` DECIMAL(18,2) COMMENT 'Rent or lease expense for the restaurant facility during the performance period. Includes base rent and Common Area Maintenance (CAM) charges for leased locations.',
    `rm_expense_amount` DECIMAL(18,2) COMMENT 'Repairs and Maintenance (R&M) expense for equipment, facilities, and infrastructure during the performance period.',
    `sss_growth_percent` DECIMAL(18,2) COMMENT 'Same-Store Sales (SSS) growth percentage comparing current period revenue to the same period in the prior year for units open at least 12 months. Excludes new restaurant openings.',
    `total_operating_expenses_amount` DECIMAL(18,2) COMMENT 'Total operating expenses including COGS, labor, utilities, rent, repairs and maintenance, and other operational costs.',
    `utility_expense_amount` DECIMAL(18,2) COMMENT 'Total utility expenses (electricity, gas, water, waste disposal) during the performance period.',
    `waste_amount` DECIMAL(18,2) COMMENT 'Total cost of food waste (spoilage, preparation errors, expired inventory) during the performance period.',
    `waste_percent` DECIMAL(18,2) COMMENT 'Food Waste Percentage - waste cost as a percentage of total COGS. Key metric for inventory and quality management.',
    CONSTRAINT pk_unit_performance PRIMARY KEY(`unit_performance_id`)
) COMMENT 'Periodic operational and financial performance record for each restaurant unit capturing AUV (Average Unit Volume), SSS (Same-Store Sales) growth %, comp sales (Comparable Store Sales) vs. prior period, ADT (Average Daily Transactions), ATC (Average Transaction Count), ACV (Average Check Value), COGS% (Cost of Goods Sold Percentage), Labor% (Labor Cost Percentage), Waste% (Food Waste Percentage), EBITDA, and net revenue. Sourced from Oracle MICROS POS and SAP S/4HANA. Primary performance scorecard for unit-level P&L management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` (
    `table_turn_log_id` BIGINT COMMENT 'Unique identifier for each table turn event record. Primary key for the table turn log.',
    `guest_order_id` BIGINT COMMENT 'Identifier linking to the guest order record in the POS system. Enables correlation of table turn metrics with order details and revenue.',
    `performance_period_id` BIGINT COMMENT 'Identifier linking to the specific service period definition. Provides detailed service window context beyond daypart classification.',
    `employee_id` BIGINT COMMENT 'Identifier of the server or waiter assigned to this table. Used for server performance analysis and labor productivity metrics.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the table turn event occurred. Links to the restaurant location profile.',
    `table_server_employee_id` BIGINT COMMENT 'Identifier of the server or waiter assigned to this table. Used for server performance analysis and labor productivity metrics.',
    `table_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the table turn event occurred. Links to the restaurant location profile.',
    `check_presented_timestamp` TIMESTAMP COMMENT 'Date and time when the check was presented to the guest. Indicates the end of the dining experience and start of payment processing.',
    `check_to_cleared_minutes` DECIMAL(18,2) COMMENT 'Time in minutes from check presentation to table cleared. Measures payment processing and table reset efficiency.',
    `check_total_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of the check for this table turn. Used to calculate revenue per table turn and average check value (ACV) by turn time.',
    `cover_count` STRING COMMENT 'Number of guests seated at the table for this turn. Critical metric for capacity planning and revenue per available seat hour (RevPASH) analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this table turn log record was created in the system. Used for data lineage and audit trail.',
    `day_of_week` STRING COMMENT 'Day of the week when the table turn occurred. Used for day-of-week table turn pattern analysis and staffing optimization. [ENUM-REF-CANDIDATE: monday|tuesday|wednesday|thursday|friday|saturday|sunday — 7 candidates stripped; promote to reference product]',
    `daypart` STRING COMMENT 'The service period or daypart during which the table turn occurred. Used for daypart-specific table turn benchmarking and capacity planning.. Valid values are `breakfast|lunch|dinner|late_night|brunch`',
    `delivery_to_check_minutes` DECIMAL(18,2) COMMENT 'Time in minutes from food delivery to check presentation. Represents the dining and service interaction period.',
    `food_delivered_timestamp` TIMESTAMP COMMENT 'Date and time when food was delivered to the table. Used to calculate kitchen ticket time and overall speed of service (SOS) from order to delivery.',
    `is_peak_period` BOOLEAN COMMENT 'Indicates whether this table turn occurred during a peak service period (True) or off-peak (False). Used to benchmark turn times against service volume.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this table turn log record was last modified. Used for change tracking and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text notes or comments about the table turn event. May include service issues, guest requests, or operational exceptions.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'Date and time when the guest order was placed with the server or entered into the POS (Point of Sale) system. Used to measure greeting and order-taking speed of service.',
    `order_to_delivery_minutes` DECIMAL(18,2) COMMENT 'Time in minutes from order placement to food delivery. Measures BOH (Back of House) kitchen speed and KDS (Kitchen Display System) ticket time.',
    `party_size` STRING COMMENT 'The number of guests in the dining party. May differ from cover count if party splits across multiple tables or if seats remain empty.',
    `payment_completed_timestamp` TIMESTAMP COMMENT 'Date and time when payment was completed and processed. Marks the financial close of the table turn.',
    `reservation_flag` BOOLEAN COMMENT 'Indicates whether this table turn was for a reserved party (True) or walk-in (False). Used to analyze reservation vs walk-in turn time differences.',
    `revenue_per_cover` DECIMAL(18,2) COMMENT 'Average revenue per guest cover for this table turn. Calculated as check_total_amount divided by cover_count. Key metric for per-guest revenue analysis.',
    `seating_timestamp` TIMESTAMP COMMENT 'Date and time when guests were seated at the table. Marks the start of the table turn cycle and is used to calculate total turn time.',
    `seating_to_order_minutes` DECIMAL(18,2) COMMENT 'Time in minutes from guest seating to order placement. Measures FOH greeting and order-taking efficiency.',
    `server_station` STRING COMMENT 'The FOH station or section assignment for the server handling this table. Used for workload balancing and station performance analysis.',
    `sos_target_minutes` DECIMAL(18,2) COMMENT 'Target table turn time in minutes for this daypart and restaurant format. Used to measure actual performance against SOS benchmarks.',
    `sos_variance_minutes` DECIMAL(18,2) COMMENT 'Variance between actual total turn time and SOS target in minutes. Positive values indicate slower than target; negative values indicate faster than target.',
    `special_occasion_flag` BOOLEAN COMMENT 'Indicates whether this table turn was for a special occasion (birthday, anniversary, celebration). Special occasions may have longer turn times due to enhanced service.',
    `table_capacity` STRING COMMENT 'Maximum seating capacity of the table. Used to calculate table utilization percentage (cover_count / table_capacity).',
    `table_cleared_timestamp` TIMESTAMP COMMENT 'Date and time when the table was cleared and reset for the next party. Marks the end of the table turn cycle and availability for next seating.',
    `table_number` STRING COMMENT 'The unique identifier or number assigned to the table within the restaurant. Used for FOH (Front of House) table management and server station assignment.',
    `table_section` STRING COMMENT 'The physical section or zone of the restaurant where the table is located (e.g., main dining, patio, bar area). Used for section-level throughput analysis.',
    `total_turn_time_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time in minutes from seating to table cleared. Primary metric for table turn rate analysis and throughput optimization. Calculated as the difference between table_cleared_timestamp and seating_timestamp.',
    `turn_date` DATE COMMENT 'Business date on which the table turn occurred. Used for daily table turn rate reporting and trend analysis. May differ from seating_timestamp date for late-night service.',
    `turn_sequence_number` STRING COMMENT 'Sequential number indicating which turn this represents for the table during the service period (1st turn, 2nd turn, etc.). Used to track table utilization throughout the day.',
    `turn_status` STRING COMMENT 'Current status of the table turn event. Completed indicates normal turn cycle; incomplete indicates missing timestamps; voided indicates cancelled service; abandoned indicates guests left before service completion.. Valid values are `completed|incomplete|voided|abandoned`',
    `wait_time_minutes` DECIMAL(18,2) COMMENT 'Time in minutes that the party waited before being seated. Used to correlate wait times with table turn efficiency and guest satisfaction.',
    CONSTRAINT pk_table_turn_log PRIMARY KEY(`table_turn_log_id`)
) COMMENT 'Transactional log of table turn events at each restaurant unit capturing table identifier, cover count seated, seating time, order-placed time, food-delivered time, check-presented time, table-cleared time, total turn time (minutes), daypart, server station, and party size. Enables table turn rate analysis, cover count optimization, and FOH throughput benchmarking for casual and fine-dining formats.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` (
    `capacity_config_id` BIGINT COMMENT 'Unique identifier for the capacity configuration record. Primary key.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit to which this capacity configuration applies.',
    `capacity_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit to which this capacity configuration applies.',
    `ada_compliant_seating_count` STRING COMMENT 'Number of seating positions that meet ADA accessibility requirements for guests with disabilities.',
    `avg_party_size` DECIMAL(18,2) COMMENT 'Average number of guests per dining party used for capacity planning and labor forecasting.',
    `bar_seating_count` STRING COMMENT 'Number of seats available at the bar or counter service area.',
    `config_effective_date` DATE COMMENT 'The date from which this capacity configuration becomes effective for the restaurant unit.',
    `config_end_date` DATE COMMENT 'The date on which this capacity configuration ceases to be effective. Null indicates the configuration is currently active.',
    `config_notes` STRING COMMENT 'Free-text notes documenting special considerations, constraints, or context for this capacity configuration.',
    `config_status` STRING COMMENT 'Current lifecycle status of the capacity configuration record.. Valid values are `active|inactive|pending|superseded`',
    `counter_service_positions` STRING COMMENT 'Number of staffed counter service positions available for order taking and guest interaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity configuration record was first created in the system.',
    `curbside_pickup_spaces` STRING COMMENT 'Number of designated parking spaces available for curbside pickup and online ordering (OLO) fulfillment.',
    `delivery_staging_capacity` STRING COMMENT 'Number of completed delivery orders that can be staged simultaneously in the designated pickup area for third-party delivery (3PD) drivers.',
    `drive_thru_sos_target_seconds` STRING COMMENT 'Target time in seconds for drive-thru order fulfillment from order point to pickup window.',
    `drive_thru_stacking_capacity` STRING COMMENT 'Maximum number of vehicles that can queue in the drive-thru lane before reaching the order point.',
    `fire_code_occupancy_limit` STRING COMMENT 'Maximum number of occupants (guests and staff) permitted in the facility as determined by local fire safety regulations.',
    `health_permit_capacity` STRING COMMENT 'Maximum seating capacity approved by the local health department on the restaurant operating permit.',
    `indoor_seating_capacity` STRING COMMENT 'Total number of indoor seats available for guest dining in the Front of House (FOH) area.',
    `kiosk_count` STRING COMMENT 'Number of self-service ordering kiosks available in the Front of House (FOH) for guest order placement.',
    `kitchen_production_capacity_orders_per_hour` STRING COMMENT 'Maximum number of orders the Back of House (BOH) kitchen can produce per hour at full operational capacity.',
    `labor_staffing_ratio` DECIMAL(18,2) COMMENT 'Target ratio of Full-Time Equivalent (FTE) staff to seating capacity or covers, used for workforce scheduling and labor cost planning.',
    `max_cover_count_breakfast` STRING COMMENT 'Maximum number of guest covers (individual diners) that can be served during the breakfast daypart based on seating and throughput capacity.',
    `max_cover_count_dinner` STRING COMMENT 'Maximum number of guest covers that can be served during the dinner daypart based on seating and throughput capacity.',
    `max_cover_count_late_night` STRING COMMENT 'Maximum number of guest covers that can be served during the late night daypart based on seating and throughput capacity.',
    `max_cover_count_lunch` STRING COMMENT 'Maximum number of guest covers that can be served during the lunch daypart based on seating and throughput capacity.',
    `outdoor_seating_capacity` STRING COMMENT 'Total number of outdoor or patio seats available for guest dining.',
    `peak_hour_throughput_capacity` STRING COMMENT 'Maximum number of guest transactions or covers that can be processed during the busiest hour of operation.',
    `private_dining_capacity` STRING COMMENT 'Total seating capacity in private dining rooms or event spaces within the restaurant.',
    `sos_target_seconds` STRING COMMENT 'Target time in seconds from order placement to order delivery, used as a key operational performance metric.',
    `table_turn_target_minutes` STRING COMMENT 'Target time in minutes for a complete table turn cycle from guest seating to table reset for the next guest.',
    `total_seating_capacity` STRING COMMENT 'Aggregate seating capacity across all dining areas including indoor, outdoor, bar, and private dining.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity configuration record was last modified.',
    CONSTRAINT pk_capacity_config PRIMARY KEY(`capacity_config_id`)
) COMMENT 'Defines the seating and service capacity configuration for each restaurant unit including total indoor seating capacity, outdoor/patio seating capacity, bar seating count, private dining room capacity, drive-thru stacking capacity (number of vehicles), kiosk count, counter service positions, maximum cover count per daypart, and ADA-compliant seating count. Used for throughput planning, labor staffing ratios, and health department permit compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` (
    `unit_status_history_id` BIGINT COMMENT 'Unique identifier for each unit status history record. Primary key for the unit status history tracking entity.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit to which this status history record applies. Links to the master restaurant entity.',
    `employee_id` BIGINT COMMENT 'System user identifier of the individual who recorded or approved the status change. Used for audit trail and accountability.',
    `unit_initiated_by_user_employee_id` BIGINT COMMENT 'System user identifier of the individual who recorded or approved the status change. Used for audit trail and accountability.',
    `actual_reopen_date` DATE COMMENT 'The actual date when the restaurant unit returned to active status. Used to measure variance against expected reopen date and assess project execution.',
    `approval_date` DATE COMMENT 'Date when the status change was formally approved by the appropriate authority. Null if no approval was required or approval is still pending.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether the status change required formal approval from corporate leadership, franchise partner, or regulatory authority before implementation.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or role that approved the status change. Used for governance and audit trail purposes.',
    `closure_type` STRING COMMENT 'Classification of the closure event distinguishing between planned maintenance closures, emergency shutdowns, regulatory actions, and other closure scenarios. [ENUM-REF-CANDIDATE: planned|unplanned|emergency|seasonal|regulatory|voluntary|involuntary — 7 candidates stripped; promote to reference product]',
    `compliance_notes` STRING COMMENT 'Free-text field capturing compliance-related information associated with the status change, including regulatory requirements, corrective actions, or legal considerations.',
    `effective_date` DATE COMMENT 'The date on which this status became effective for the restaurant unit. Used to determine SSS eligibility windows and operational reporting periods.',
    `end_date` DATE COMMENT 'The date on which this status ceased to be effective, marking the transition to the next status. Null for the current active status record.',
    `estimated_revenue_impact` DECIMAL(18,2) COMMENT 'Projected financial impact on unit revenue during the status period, expressed in local currency. Used for financial planning and P&L forecasting.',
    `expected_reopen_date` DATE COMMENT 'Anticipated date when the restaurant unit is expected to return to active status following a temporary closure or renovation. Null if not applicable or unknown.',
    `grand_opening_date` DATE COMMENT 'Official grand opening date for the restaurant unit. Marks the beginning of full operational status and SSS eligibility countdown.',
    `health_department_case_number` STRING COMMENT 'Official case or incident number assigned by the local health department if the status change was triggered by a health inspection failure or food safety violation.',
    `impact_on_franchise_agreement` STRING COMMENT 'Description of how this status change affects the franchise agreement terms, royalty obligations, or compliance requirements. Relevant for franchise partner relations and legal review.',
    `initiated_by` STRING COMMENT 'The party or department that initiated the status change. Identifies accountability and decision authority for lifecycle transitions. [ENUM-REF-CANDIDATE: corporate_operations|franchise_partner|health_department|real_estate|finance|legal|system — 7 candidates stripped; promote to reference product]',
    `is_sss_eligible` BOOLEAN COMMENT 'Indicates whether the restaurant unit is eligible for inclusion in Same-Store Sales (SSS) calculations during this status period. Typically requires 12+ months of continuous active operation.',
    `notification_sent_date` DATE COMMENT 'Date when formal notification of the status change was communicated to relevant stakeholders including franchise partners, corporate operations, and regulatory bodies.',
    `nro_flag` BOOLEAN COMMENT 'Indicates whether this status record is associated with a New Restaurant Opening (NRO) event. Used to track grand opening milestones and ramp-up performance.',
    `previous_status` STRING COMMENT 'The status of the restaurant unit immediately prior to this status change. Enables transition analysis and lifecycle pattern identification.. Valid values are `active|temporarily_closed|permanently_closed|under_renovation|pre_opening|soft_open`',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for the status change. Examples include health_violation, lease_expiration, remodel, nro_launch, seasonal_closure, natural_disaster, underperformance, franchise_termination.',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the reason for the status change. Provides context beyond the standardized reason code for audit and operational review.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this status history record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this status history record was last modified. Used for audit trail and change tracking.',
    `renovation_scope` STRING COMMENT 'Classification of the renovation or remodel scope when the status change is related to facility improvements. Impacts expected duration and capital expenditure (CapEx) tracking.. Valid values are `minor_refresh|major_remodel|equipment_upgrade|expansion|full_rebuild`',
    `restaurant_number` STRING COMMENT 'Business identifier for the restaurant unit. Human-readable store number used in operational systems and reporting.',
    `soft_open_start_date` DATE COMMENT 'Date when the restaurant unit began soft-open operations prior to the official grand opening. Used to track pre-launch performance and operational readiness.',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this status history record in the source operational system. Enables traceability and reconciliation with upstream systems.',
    `unit_status_history_status` STRING COMMENT 'Current operational status of the restaurant unit at this point in the lifecycle. Determines eligibility for Same-Store Sales (SSS) calculations and operational reporting.. Valid values are `active|temporarily_closed|permanently_closed|under_renovation|pre_opening|soft_open`',
    CONSTRAINT pk_unit_status_history PRIMARY KEY(`unit_status_history_id`)
) COMMENT 'Tracks the full lifecycle status history of each restaurant unit including status transitions (active, temporarily closed, permanently closed, under renovation, pre-opening, soft-open, NRO new restaurant opening), effective date of each status change, reason code, change initiated by (franchise partner, corporate operations, health department), and expected reopen date where applicable. Provides audit trail for unit lifecycle management and SSS eligibility determination.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` (
    `area_management_id` BIGINT COMMENT 'Unique identifier for the area management record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the area manager or district manager responsible for this area. Links to workforce management system.',
    `parent_area_area_management_id` BIGINT COMMENT 'Identifier of the parent area in the management hierarchy. Null for top-level areas.',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - area management structures must link to the units they oversee',
    `area_code` STRING COMMENT 'Business identifier code for the area or district. Used in operational reporting and area manager assignment.. Valid values are `^[A-Z0-9]{3,10}$`',
    `area_name` STRING COMMENT 'Descriptive name of the area or district (e.g., Northeast Metro, Southern California Region).',
    `area_status` STRING COMMENT 'Current operational status of the area management record.. Valid values are `active|inactive|pending|closed`',
    `area_type` STRING COMMENT 'Classification of the area management level within the organizational hierarchy.. Valid values are `district|region|territory|zone|market`',
    `auv_target` DECIMAL(18,2) COMMENT 'Target Average Unit Volume (AUV) for restaurants in this area, representing expected annual sales per unit.',
    `brand` STRING COMMENT 'Restaurant brand or concept associated with this area (e.g., Quick-Service Brand A, Casual Dining Brand B).',
    `cogs_percent_target` DECIMAL(18,2) COMMENT 'Target Cost of Goods Sold (COGS) as a percentage of sales for restaurants in this area.',
    `company_owned_unit_count` STRING COMMENT 'Number of company-owned restaurant units within this area.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the primary country in which this area operates.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this area management record was first created in the system.',
    `csat_target_score` DECIMAL(18,2) COMMENT 'Target Customer Satisfaction (CSAT) score for this area, typically measured on a scale of 0-100.',
    `division` STRING COMMENT 'Corporate division or business unit to which this area is assigned.',
    `effective_date` DATE COMMENT 'Date when this area management configuration became effective.',
    `expiration_date` DATE COMMENT 'Date when this area management configuration expires or is superseded. Null for current configurations.',
    `franchise_agreement_flag` BOOLEAN COMMENT 'Indicates whether this area is governed by a franchise area development agreement.',
    `franchise_unit_count` STRING COMMENT 'Number of franchised restaurant units within this area.',
    `geographic_region` STRING COMMENT 'Broader geographic region to which this area belongs (e.g., West Coast, Midwest, Southeast).',
    `hierarchy_level` STRING COMMENT 'Numeric level in the area management hierarchy, with 1 being the top level (e.g., national) and higher numbers representing more granular levels (e.g., region, district).',
    `labor_percent_target` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of sales for restaurants in this area.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this area management record was last updated.',
    `marketing_fund_contribution_percent` DECIMAL(18,2) COMMENT 'Percentage of sales contributed to the marketing fund by units in this area.',
    `notes` STRING COMMENT 'Additional notes or comments regarding this area management record.',
    `nps_target_score` DECIMAL(18,2) COMMENT 'Target Net Promoter Score (NPS) for this area, measuring customer loyalty and likelihood to recommend.',
    `nro_target_count` STRING COMMENT 'Target number of New Restaurant Openings (NRO) planned for this area within the current fiscal year.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Standard royalty rate percentage applied to franchise units in this area.',
    `sos_target_seconds` STRING COMMENT 'Target Speed of Service (SOS) in seconds for restaurants in this area, measuring average transaction time.',
    `sss_target_percent` DECIMAL(18,2) COMMENT 'Target Same-Store Sales (SSS) growth percentage for this area, used to measure year-over-year comparable store performance.',
    `state_province` STRING COMMENT 'Primary state or province for this area. May be null for multi-state areas.',
    `territory_boundary_description` STRING COMMENT 'Textual description of the geographic or operational boundaries defining this area (e.g., All units within 50 miles of downtown Chicago).',
    `unit_count` STRING COMMENT 'Total number of restaurant units (company-owned and franchised) within this area.',
    CONSTRAINT pk_area_management PRIMARY KEY(`area_management_id`)
) COMMENT 'Defines the operational management hierarchy above the restaurant unit level. Captures area/district/region boundaries, area manager assignment (name, employee ID, assignment effective dates), number of units in area, geographic region, division, brand, and area performance targets (AUV target, SSS target, CSAT target, Labor% target). Supports multi-unit management accountability, area manager performance reviews, regional performance rollups, and franchise territory alignment. One row per area/district assignment period.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` (
    `renovation_project_id` BIGINT COMMENT 'Unique identifier for the renovation project. Primary key.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Renovation projects are initiated, approved, and funded by the franchisee; linking enables franchise‑level renovation cost reporting and compliance tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the renovation project for execution.',
    `renovation_employee_id` BIGINT COMMENT 'Identifier of the user who approved the renovation project for execution.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit undergoing renovation. Links to the restaurant location being renovated.',
    `renovation_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit undergoing renovation. Links to the restaurant location being renovated.',
    `actual_auv_lift_percent` DECIMAL(18,2) COMMENT 'Actual measured percentage increase in Average Unit Volume (AUV) achieved post-renovation, typically measured 6-12 months after completion.',
    `actual_capex_usd` DECIMAL(18,2) COMMENT 'Actual total capital expenditure incurred for the renovation project in US dollars.',
    `actual_completion_date` DATE COMMENT 'Actual date when the renovation project was completed and the restaurant was ready for operations.',
    `actual_start_date` DATE COMMENT 'Actual date when the renovation project work commenced.',
    `ada_compliance_flag` BOOLEAN COMMENT 'Indicates whether the renovation project includes ADA compliance upgrades to meet accessibility requirements.',
    `approval_date` DATE COMMENT 'Date when the renovation project was officially approved for execution.',
    `architect_firm_name` STRING COMMENT 'Name of the architectural firm that designed the renovation plans.',
    `brand_standard_version` STRING COMMENT 'Version of the brand standards and design guidelines being implemented in this renovation project.',
    `budget_variance_usd` DECIMAL(18,2) COMMENT 'Difference between actual and estimated CapEx (actual minus estimated) in US dollars, indicating over or under budget performance.',
    `building_permit_number` STRING COMMENT 'Official building permit number issued by local authorities for the renovation work.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the renovation project was cancelled, if applicable.',
    `closure_duration_days` STRING COMMENT 'Number of days the restaurant was closed to customers during the renovation project.',
    `contractor_license_number` STRING COMMENT 'State or local license number of the contractor performing the renovation work.',
    `contractor_name` STRING COMMENT 'Name of the primary general contractor or construction firm responsible for executing the renovation project.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the renovation project record was first created in the system.',
    `energy_efficiency_upgrade_flag` BOOLEAN COMMENT 'Indicates whether the renovation includes energy efficiency improvements such as LED lighting, HVAC upgrades, or insulation enhancements.',
    `estimated_capex_usd` DECIMAL(18,2) COMMENT 'Estimated total capital expenditure budget for the renovation project in US dollars.',
    `expected_auv_lift_percent` DECIMAL(18,2) COMMENT 'Expected percentage increase in Average Unit Volume (AUV) following completion of the renovation project.',
    `final_inspection_date` DATE COMMENT 'Date when the final building inspection was completed and the renovation was approved for occupancy.',
    `financing_method` STRING COMMENT 'Method used to finance the renovation project (corporate funds, franchise funded, loan, lease, mixed).. Valid values are `corporate_funds|franchise_funded|loan|lease|mixed`',
    `inspection_status` STRING COMMENT 'Current status of the final building inspection (pending, passed, failed, conditional approval).. Valid values are `pending|passed|failed|conditional_approval`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the renovation project record was last updated in the system.',
    `notes` STRING COMMENT 'Additional free-form notes and comments about the renovation project for internal reference.',
    `partial_closure_flag` BOOLEAN COMMENT 'Indicates whether the restaurant remained partially operational during renovation (True) or was fully closed (False).',
    `permit_issue_date` DATE COMMENT 'Date when the building permit was issued by local authorities.',
    `planned_completion_date` DATE COMMENT 'Originally scheduled date for the renovation project to be completed.',
    `planned_start_date` DATE COMMENT 'Originally scheduled date for the renovation project to begin.',
    `project_manager_name` STRING COMMENT 'Name of the internal project manager overseeing the renovation project.',
    `project_name` STRING COMMENT 'Descriptive name of the renovation project for easy identification and reporting.',
    `project_number` STRING COMMENT 'Externally-known unique business identifier for the renovation project, used for tracking and communication with contractors and stakeholders.. Valid values are `^[A-Z0-9]{8,20}$`',
    `project_priority` STRING COMMENT 'Business priority level assigned to the renovation project for resource allocation and scheduling decisions.. Valid values are `critical|high|medium|low`',
    `project_status` STRING COMMENT 'Current lifecycle status of the renovation project (planned, approved, in-progress, completed, cancelled, on-hold).. Valid values are `planned|approved|in_progress|completed|cancelled|on_hold`',
    `project_type` STRING COMMENT 'Classification of the renovation project type indicating the scope and nature of work (full remodel, refresh, equipment upgrade, ADA retrofit, brand reimaging, expansion).. Valid values are `full_remodel|refresh|equipment_upgrade|ada_retrofit|brand_reimaging|expansion`',
    `roi_payback_period_months` STRING COMMENT 'Estimated number of months required to recover the renovation investment through increased revenue and operational savings.',
    `scope_description` STRING COMMENT 'Detailed description of the renovation scope including specific areas, systems, and improvements included in the project.',
    `warranty_expiration_date` DATE COMMENT 'Date when the contractor warranty for the renovation work expires.',
    `warranty_period_months` STRING COMMENT 'Duration in months of the contractor warranty covering workmanship and materials for the renovation.',
    CONSTRAINT pk_renovation_project PRIMARY KEY(`renovation_project_id`)
) COMMENT 'Tracks restaurant unit renovation, remodel, and refresh projects including project type (full remodel, refresh, equipment upgrade, ADA retrofit, brand reimaging), project status (planned, approved, in-progress, completed, cancelled), planned start date, actual start date, planned completion date, actual completion date, estimated CapEx, actual CapEx, contractor name, closure duration (days), and expected AUV lift post-renovation. Coordinates with realestate domain for facility management and finance domain for CapEx tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` (
    `ops_visit_id` BIGINT COMMENT 'Unique identifier for the operational field visit record. Primary key.',
    `checklist_template_id` BIGINT COMMENT 'Identifier of the standardized checklist or audit template used during the operational visit to ensure consistent evaluation criteria.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the manager or supervisor who reviewed and approved the operational visit report and findings.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the operational visit was conducted.',
    `ops_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the operational visit was conducted.',
    `primary_ops_visitor_employee_id` BIGINT COMMENT 'Employee identifier of the individual who conducted the operational visit, linking to the workforce management system.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the operational visit report was officially approved by the reviewing manager or supervisor.',
    `brand_standard_compliance_status` STRING COMMENT 'Overall assessment of the restaurant units compliance with brand standards and Standard Operating Procedures (SOPs) based on the visit findings.. Valid values are `compliant|non_compliant|partially_compliant|under_review`',
    `checklist_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of checklist items completed during the operational visit, indicating thoroughness of the inspection.',
    `cleanliness_score` DECIMAL(18,2) COMMENT 'Sub-score assessing the cleanliness and sanitation of Front of House (FOH) and Back of House (BOH) areas, including dining areas, restrooms, and kitchen.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which all corrective actions identified during the visit must be completed and verified.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether corrective actions are required as a result of findings from the operational visit.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the operational visit record was first created in the source system.',
    `critical_findings_count` STRING COMMENT 'Number of critical violations or findings identified during the operational visit that require immediate corrective action.',
    `customer_count_observed` STRING COMMENT 'Approximate number of customers served or present during the operational visit, providing context for throughput and service observations.',
    `daypart_observed` STRING COMMENT 'The daypart (e.g., breakfast, lunch, dinner, late night) during which the operational visit was conducted, relevant for assessing performance during specific service periods.',
    `follow_up_visit_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether a follow-up visit is required to verify corrective action completion.',
    `follow_up_visit_scheduled_date` DATE COMMENT 'Scheduled date for a follow-up operational visit to verify that corrective actions have been implemented and findings have been resolved.',
    `food_quality_score` DECIMAL(18,2) COMMENT 'Sub-score evaluating the quality, freshness, preparation, and presentation of food items during the visit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the operational visit record was last updated or modified in the source system.',
    `non_critical_findings_count` STRING COMMENT 'Number of non-critical observations or minor violations identified during the visit that should be addressed but do not pose immediate risk.',
    `overall_visit_score` DECIMAL(18,2) COMMENT 'Composite score representing the overall performance of the restaurant unit during the operational visit, typically on a 0-100 scale.',
    `safety_score` DECIMAL(18,2) COMMENT 'Sub-score assessing food safety compliance, Hazard Analysis Critical Control Points (HACCP) adherence, and workplace safety standards during the visit.',
    `service_score` DECIMAL(18,2) COMMENT 'Sub-score evaluating the quality of customer service, staff friendliness, order accuracy, and guest interaction during the visit.',
    `speed_score` DECIMAL(18,2) COMMENT 'Sub-score measuring the Speed of Service (SOS), ticket time, and throughput efficiency during the visit, benchmarked against brand standards.',
    `staff_count_observed` STRING COMMENT 'Number of staff members (Full-Time Equivalent or FTE) observed working during the visit, relevant for labor efficiency and service quality assessment.',
    `visit_category` STRING COMMENT 'Broad category of the operational visit indicating whether it is routine, targeted at specific issues, driven by customer complaints, regulatory-mandated, or pre-opening inspection.. Valid values are `routine|targeted|complaint_driven|regulatory|pre_opening`',
    `visit_date` DATE COMMENT 'The calendar date on which the operational field visit was conducted at the restaurant unit.',
    `visit_duration_minutes` STRING COMMENT 'Total duration of the operational visit in minutes, calculated from start to end timestamp.',
    `visit_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the operational visit concluded, marking the completion of the on-site inspection or audit.',
    `visit_notes` STRING COMMENT 'Free-text field capturing detailed observations, comments, recommendations, and contextual information from the operational visit.',
    `visit_number` STRING COMMENT 'Business-facing unique identifier for the operational visit, used for tracking and reference in operational compliance systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `visit_priority_level` STRING COMMENT 'Priority classification of the operational visit based on the severity of findings, risk level, or strategic importance of the restaurant unit.. Valid values are `low|medium|high|critical`',
    `visit_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the operational visit began, capturing the start of the on-site inspection or audit.',
    `visit_status` STRING COMMENT 'Current lifecycle status of the operational visit indicating whether it is scheduled, in progress, completed, cancelled, or rescheduled.. Valid values are `scheduled|in_progress|completed|cancelled|rescheduled`',
    `visit_type` STRING COMMENT 'Classification of the operational visit indicating whether it was scheduled, unannounced, a follow-up to previous findings, New Restaurant Opening (NRO) support, compliance audit, or quality inspection.. Valid values are `scheduled|unannounced|follow_up|nro_opening_support|compliance_audit|quality_inspection`',
    `visitor_name` STRING COMMENT 'Full name of the individual who conducted the operational visit, typically an area manager, brand consultant, or corporate operations team member.',
    `visitor_role` STRING COMMENT 'Job title or role of the individual who conducted the visit, such as Area Manager, Brand Consultant, Operations Director, or Quality Assurance Specialist.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions during the visit, which may impact customer traffic, throughput, and operational performance observations.',
    CONSTRAINT pk_ops_visit PRIMARY KEY(`ops_visit_id`)
) COMMENT 'Records operational field visits conducted by area managers, brand consultants, or corporate operations teams at each restaurant unit. Captures visit date, visit type (scheduled, unannounced, follow-up, NRO opening support), visitor name and role, overall visit score, sub-scores by category (food quality, cleanliness, service, speed, safety), critical findings count, corrective actions required flag, and follow-up visit scheduled date. Sourced from Zenput operational compliance platform.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` (
    `ops_visit_finding_id` BIGINT COMMENT 'Unique identifier for the operational visit finding record. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the auditor who recorded this finding. Links to workforce management system for auditor credentials and certification tracking.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where this finding was observed. Links to the restaurant product.',
    `ops_unit_id` BIGINT COMMENT 'Reference to the restaurant unit where this finding was observed. Links to the restaurant product.',
    `ops_visit_id` BIGINT COMMENT 'Reference to the parent operational field visit during which this finding was recorded. Links to the ops_visit product.',
    `previous_finding_ops_visit_finding_id` BIGINT COMMENT 'Reference to the ops_visit_finding_id of the prior occurrence if this is a repeat finding. Enables tracking of finding recurrence patterns and corrective action effectiveness.',
    `primary_ops_employee_id` BIGINT COMMENT 'Name of the manager or executive who approved the waiver. Populated only when status is waived. Used for accountability and audit trail.',
    `auditor_name` STRING COMMENT 'Name of the field auditor or inspector who recorded this finding during the operational visit. Used for auditor performance tracking and finding validation.',
    `brand_standard_code` STRING COMMENT 'Reference code for the specific brand standard or SOP (Standard Operating Procedure) that was violated or not met. Links to the brand standards repository for detailed requirement documentation.',
    `brand_standard_name` STRING COMMENT 'Human-readable name of the brand standard or SOP that was violated. Examples: Hand Washing Protocol, Temperature Log Maintenance, Uniform and Appearance Standard, Drive-Thru Speed of Service.',
    `corrective_action_completed_flag` BOOLEAN COMMENT 'Indicates whether the required corrective action has been completed and verified. True when action is complete and verified; False when pending or in progress.',
    `corrective_action_completion_date` DATE COMMENT 'Actual date when the corrective action was completed and verified. Populated when corrective_action_completed_flag is set to True. Used to calculate resolution time and track overdue items.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the corrective action must be completed. Set based on severity level: critical findings typically require same-day or next-day resolution, major findings within 7 days, minor findings within 30 days.',
    `corrective_action_required` STRING COMMENT 'Detailed description of the corrective action that must be taken to resolve the finding. Specifies what needs to be done, by whom, and any specific requirements or standards that must be met.',
    `corrective_action_verification_method` STRING COMMENT 'Method used to verify that the corrective action was completed satisfactorily. Options include on-site inspection by field manager, photographic evidence submitted by unit, document review, manager attestation, or scheduled follow-up visit.. Valid values are `on_site_inspection|photo_evidence|document_review|manager_attestation|follow_up_visit`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this finding record was first created in the system. System-generated audit field for data lineage and compliance tracking.',
    `escalation_level` STRING COMMENT 'Organizational level to which this finding has been escalated. Unit: handled at restaurant level. Area: escalated to area manager. Region: escalated to regional director. Corporate: escalated to corporate compliance or executive leadership.. Valid values are `unit|area|region|corporate`',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this finding requires escalation beyond the restaurant unit level to area management, regional leadership, or corporate compliance. True for critical findings, repeat major findings, or regulatory violations requiring senior leadership notification.',
    `financial_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact of the finding in US dollars. May include cost of waste, potential fines, equipment repair costs, or revenue impact from service disruption. Used for prioritization and ROI analysis of corrective actions.',
    `finding_category` STRING COMMENT 'High-level classification of the finding type. Categories include food safety (HACCP violations, temperature control), cleanliness (sanitation, hygiene), equipment (maintenance, functionality), service (guest experience, speed of service), brand standard (SOP compliance, visual standards), labor (staffing, scheduling, training), and inventory (stock levels, waste management). [ENUM-REF-CANDIDATE: food_safety|cleanliness|equipment|service|brand_standard|labor|inventory — 7 candidates stripped; promote to reference product]',
    `finding_description` STRING COMMENT 'Detailed narrative description of the observed finding. Captures what was observed, where it was observed, and the specific condition or behavior that triggered the finding. Free-text field for auditor notes.',
    `finding_sequence_number` STRING COMMENT 'Sequential ordering of findings within the parent visit. Used to maintain the order in which findings were recorded during the field visit.',
    `finding_subcategory` STRING COMMENT 'Detailed sub-classification within the finding category. Examples: temperature_control, hand_washing, equipment_calibration, uniform_compliance, waste_tracking. Provides granular segmentation for trend analysis.',
    `finding_timestamp` TIMESTAMP COMMENT 'Date and time when the finding was observed and recorded during the field visit. Captures the precise moment of observation for time-sensitive findings such as temperature violations or service delays.',
    `guest_impact_flag` BOOLEAN COMMENT 'Indicates whether this finding has direct impact on guest experience, satisfaction, or safety. True if the finding affects FOH (Front of House) operations, service quality, food safety, or guest-facing brand standards; False if it is purely BOH (Back of House) or administrative.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this finding record was last updated. System-generated audit field for change tracking and data quality monitoring.',
    `notes` STRING COMMENT 'Additional free-text notes, context, or observations related to the finding. May include mitigating circumstances, root cause analysis, or special instructions for corrective action.',
    `ops_visit_finding_status` STRING COMMENT 'Current lifecycle status of the finding. Open: newly recorded, awaiting action. In Progress: corrective action underway. Resolved: action completed, awaiting verification. Closed: verified and complete. Waived: finding acknowledged but action waived with justification.. Valid values are `open|in_progress|resolved|closed|waived`',
    `photo_evidence_url` STRING COMMENT 'URL or file path to photographic evidence documenting the finding. Used for visual verification, training purposes, and dispute resolution. Links to document management system or cloud storage.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulatory code, section, or requirement that was violated. Examples: FDA Food Code 3-501.16, OSHA 1910.22, Local Health Code Section 12.4. Populated only when regulatory_violation_flag is True.',
    `regulatory_violation_flag` BOOLEAN COMMENT 'Indicates whether this finding constitutes a violation of regulatory requirements (FDA, OSHA, local health department). True if the finding violates a legal or regulatory standard; False if it is an internal brand standard deviation only.',
    `repeat_finding_flag` BOOLEAN COMMENT 'Indicates whether this finding is a repeat of a previously identified issue at this restaurant unit. True if the same or similar finding was recorded in a prior visit; False if this is the first occurrence. Used to identify systemic compliance gaps.',
    `repeat_occurrence_count` STRING COMMENT 'Number of times this specific finding has been recorded at this restaurant unit. Incremented each time the same finding is observed in subsequent visits. Used for escalation and intervention triggers.',
    `responsible_party_name` STRING COMMENT 'Name of the individual assigned responsibility for completing the corrective action. Typically the restaurant general manager, area manager, or specific department lead depending on the finding category.',
    `responsible_party_role` STRING COMMENT 'Job title or role of the individual responsible for the corrective action. Examples: General Manager, Kitchen Manager, Area Manager, Facilities Manager, Training Coordinator.',
    `severity_level` STRING COMMENT 'Classification of the findings impact and urgency. Critical: immediate health/safety risk or major brand violation requiring immediate action. Major: significant compliance gap with potential regulatory or brand impact. Minor: deviation from standard with limited impact. Observation: opportunity for improvement without compliance violation.. Valid values are `critical|major|minor|observation`',
    `waiver_approval_date` DATE COMMENT 'Date when the waiver was approved. Populated only when status is waived.',
    `waiver_reason` STRING COMMENT 'Justification for waiving the corrective action requirement. Populated only when status is waived. Requires approval from authorized manager and documentation of business rationale.',
    CONSTRAINT pk_ops_visit_finding PRIMARY KEY(`ops_visit_finding_id`)
) COMMENT 'Line-item findings recorded during an operational field visit at a restaurant unit. Each record captures the parent visit reference, finding category (food safety, cleanliness, equipment, service, brand standard, labor), finding description, severity level (critical, major, minor, observation), brand standard violated, corrective action required, corrective action due date, corrective action completed flag, and completion date. Enables granular compliance gap tracking and repeat-finding trend analysis.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` (
    `unit_ownership_id` BIGINT COMMENT 'Unique identifier for each unit ownership record. Primary key for the unit ownership history table.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit for which this ownership record applies. Links to the restaurant master record.',
    `employee_id` BIGINT COMMENT 'The identifier of the user who created this ownership record. Used for audit trail and accountability.',
    `unit_employee_id` BIGINT COMMENT 'The identifier of the user who created this ownership record. Used for audit trail and accountability.',
    `franchisee_id` BIGINT COMMENT 'Reference to the franchise partner master record when ownership_type is franchised, licensed, joint_venture, master_franchise, or area_development. Null for company-owned units.',
    `unit_franchisee_id` BIGINT COMMENT 'Reference to the franchise partner master record when ownership_type is franchised, licensed, joint_venture, master_franchise, or area_development. Null for company-owned units.',
    `unit_last_modified_by_user_employee_id` BIGINT COMMENT 'The identifier of the user who last modified this ownership record. Used for audit trail and accountability.',
    `area_development_agreement_flag` BOOLEAN COMMENT 'Indicates whether this ownership is part of a multi-unit area development agreement. Used for franchise development tracking and compliance reporting.',
    `compliance_status` STRING COMMENT 'Current compliance status of this ownership arrangement with franchise agreement terms and brand standards. Used for franchise compliance reporting and risk management.. Valid values are `compliant|non_compliant|under_review|remediation_in_progress`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ownership record was first created in the system. Used for audit trail and data lineage tracking.',
    `financial_reporting_entity_code` STRING COMMENT 'The code identifying the financial reporting entity for P&L consolidation. Maps to the ERP system company code or business unit for financial reporting.',
    `franchise_agreement_expiration_date` DATE COMMENT 'The expiration date of the franchise agreement. Used for renewal planning and compliance tracking.',
    `franchise_agreement_number` STRING COMMENT 'The legal agreement number governing this franchise ownership arrangement. Null for company-owned units. Used for compliance tracking and legal reference.',
    `franchise_agreement_start_date` DATE COMMENT 'The start date of the franchise agreement governing this ownership. May differ from ownership_effective_start_date if ownership transferred mid-agreement.',
    `initial_franchise_fee_usd` DECIMAL(18,2) COMMENT 'The one-time initial franchise fee paid at the start of this ownership arrangement. Null for company-owned units. Used for revenue recognition and franchise economics analysis.',
    `joint_venture_partner_name` STRING COMMENT 'The name of the joint venture partner if ownership_type is joint_venture. Used for partnership management and financial reporting.',
    `last_compliance_audit_date` DATE COMMENT 'The date of the most recent compliance audit for this ownership arrangement. Used for audit scheduling and compliance tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this ownership record was last modified. Used for audit trail and change tracking.',
    `marketing_fee_percent` DECIMAL(18,2) COMMENT 'The percentage of gross sales contributed to the marketing fund under this ownership arrangement. Used for marketing fund accounting and campaign budget allocation.',
    `master_franchise_flag` BOOLEAN COMMENT 'Indicates whether this ownership operates under a master franchise arrangement with sub-franchising rights. Used for franchise hierarchy management and royalty flow tracking.',
    `next_compliance_audit_due_date` DATE COMMENT 'The scheduled date for the next compliance audit. Used for audit planning and compliance management.',
    `operating_entity_legal_name` STRING COMMENT 'The full legal name of the entity that owns and operates this restaurant unit. Used for legal compliance, tax reporting, and franchise agreement documentation.',
    `operating_license_expiration_date` DATE COMMENT 'The expiration date of the operating license. Used for renewal tracking and compliance management.',
    `operating_license_number` STRING COMMENT 'The business operating license number issued by local authorities for this ownership entity. Used for regulatory compliance and legal documentation.',
    `ownership_effective_end_date` DATE COMMENT 'The date on which this ownership arrangement ended or will end. Null for current active ownership. Used to close out royalty periods and finalize P&L attribution.',
    `ownership_effective_start_date` DATE COMMENT 'The date on which this ownership arrangement became effective. Used to determine royalty calculation periods and P&L attribution windows.',
    `ownership_notes` STRING COMMENT 'Free-text notes capturing additional context about this ownership arrangement, including special terms, conditions, or historical information.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The percentage of ownership stake held by this entity in joint venture arrangements. 100% for sole ownership. Used for P&L attribution and profit distribution.',
    `ownership_record_number` STRING COMMENT 'Business-facing unique identifier for this ownership record, used in franchise agreements and legal documentation.. Valid values are `^OWN-[0-9]{8}$`',
    `ownership_status` STRING COMMENT 'Current lifecycle status of this ownership record. Active indicates current operational ownership; pending indicates ownership transfer in progress; transferred indicates completed ownership change; terminated indicates closure or reversion; suspended indicates temporary operational hold.. Valid values are `active|pending|transferred|terminated|suspended`',
    `ownership_transfer_date` DATE COMMENT 'The date on which ownership was transferred from a previous owner to the current owner. Used for historical tracking and transfer analysis.',
    `ownership_type` STRING COMMENT 'Classification of the ownership model for this restaurant unit. Determines royalty calculation, P&L attribution, and compliance reporting requirements.. Valid values are `company_owned|franchised|licensed|joint_venture|master_franchise|area_development`',
    `previous_owner_name` STRING COMMENT 'The name of the previous owner if this ownership record represents a transfer or resale. Used for historical tracking and franchise relationship management.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of gross sales paid as royalty fees under this ownership arrangement. Null for company-owned units. Used for royalty calculation and financial forecasting.',
    `tax_identification_number` STRING COMMENT 'The tax identification number (EIN, VAT, or equivalent) of the operating entity. Used for tax reporting and regulatory compliance.',
    `territory_code` STRING COMMENT 'The geographic territory code assigned to this franchise ownership. Used for territory management, market planning, and franchise compliance.',
    `transfer_approval_date` DATE COMMENT 'The date on which the franchisor approved the ownership transfer. Used for compliance tracking and transfer timeline analysis.',
    `transfer_approved_by` STRING COMMENT 'The name or identifier of the franchisor representative who approved the ownership transfer. Used for audit trail and compliance documentation.',
    `transfer_reason` STRING COMMENT 'The business reason for this ownership record being created or terminated. Used for franchise compliance reporting, trend analysis, and strategic planning. [ENUM-REF-CANDIDATE: new_franchise_award|resale|corporate_acquisition|refranchising|closure|default|voluntary_termination|expiration — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_unit_ownership PRIMARY KEY(`unit_ownership_id`)
) COMMENT 'Tracks the ownership and operational control history of each restaurant unit including ownership type (company-owned, franchised, licensed, joint-venture), franchise partner reference, ownership effective start date, ownership effective end date, transfer reason (new franchise award, resale, corporate acquisition, closure), and operating entity legal name. Provides the authoritative ownership timeline for royalty calculation, P&L attribution, and franchise compliance reporting. Complements the franchise domain without duplicating franchise partner master data.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` (
    `performance_period_id` BIGINT COMMENT 'Unique identifier for the performance period record. Primary key for the performance period entity.',
    `performance_prior_period_id` BIGINT COMMENT 'Reference to the immediately preceding performance period of the same type. Used for sequential period-over-period trending and variance analysis.',
    `performance_prior_year_period_id` BIGINT COMMENT 'Reference to the corresponding performance period from the prior fiscal year. Used for year-over-year variance analysis and SSS calculations.',
    `primary_prior_performance_period_id` BIGINT COMMENT 'Self-referencing FK on performance_period (prior_performance_period_id)',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - performance periods need unit context unless they are global calendar periods, in which case they should link to finance.financial_period',
    `auv_calculation_window_months` STRING COMMENT 'The number of trailing months used to calculate Average Unit Volume (AUV) for this period. Typically 12 months for annual AUV or 3 months for quarterly AUV. Defines the rolling window for revenue averaging.',
    `business_day_count` STRING COMMENT 'The number of operating days in this performance period, excluding holidays and closures. Used for calculating business-day-adjusted metrics.',
    `calendar_month` STRING COMMENT 'The calendar month number (1-12) in which the period starts. Used for month-over-month trending and seasonality analysis.',
    `calendar_quarter` STRING COMMENT 'The calendar quarter number (1-4) in which the period starts. Used for calendar-based quarterly comparisons.',
    `calendar_year` STRING COMMENT 'The calendar year in which the period starts. Used for calendar-based reporting and alignment with external benchmarks.',
    `comp_sales_eligible_flag` BOOLEAN COMMENT 'Indicates whether this period qualifies for comparable sales analysis. Synonymous with SSS eligibility; requires 12+ months of continuous operation for year-over-year performance comparison.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this performance period record was first created in the system. Used for audit trail and data lineage tracking.',
    `day_count` STRING COMMENT 'The total number of calendar days in this performance period. Used for normalizing metrics and calculating daily averages.',
    `fiscal_month` STRING COMMENT 'Month number (1‑12) of the fiscal year for the period.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter number (1-4) within the fiscal year. Used for quarterly performance aggregation and reporting.',
    `fiscal_week` STRING COMMENT 'Week number (1‑53) of the fiscal year for the period.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this performance period belongs. Represents the 12-month accounting period used for financial reporting and performance measurement.',
    `holiday_flag` BOOLEAN COMMENT 'Indicates whether this period contains one or more major holidays that significantly impact restaurant traffic and sales patterns. Used for seasonality adjustments and forecasting.',
    `holiday_list` STRING COMMENT 'Comma-separated list of major holidays occurring within this performance period (e.g., Thanksgiving, Black Friday). Used for detailed seasonality analysis and promotional planning.',
    `is_closed` BOOLEAN COMMENT 'True when the period has been finalized and no further data edits are allowed.',
    `is_current` BOOLEAN COMMENT 'Indicates whether this period is the active reporting window.',
    `is_leap_year` BOOLEAN COMMENT 'Indicates whether the fiscal year for this period is a leap year (366 days). Used for accurate day-count adjustments in financial calculations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this performance period record was most recently updated. Used for change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-text field for capturing special circumstances, adjustments, or contextual information about this performance period (e.g., System outage on 3/15, Major weather event impacted sales).',
    `performance_period_status` STRING COMMENT 'Current lifecycle status of the period record.. Valid values are `active|inactive|archived`',
    `period_category` STRING COMMENT 'High‑level business domain the period is primarily used for.. Valid values are `operational|financial|marketing|workforce|supply_chain`',
    `period_close_date` DATE COMMENT 'The date on which the performance period was officially closed for reporting. Represents when preliminary financial and operational results were finalized.',
    `period_code` STRING COMMENT 'Business-friendly code used to reference the period in reports and systems.',
    `period_duration_days` STRING COMMENT 'Number of calendar days covered by the period (derived from start and end dates).',
    `period_end_date` DATE COMMENT 'The last calendar date included in this performance period. Defines the ending boundary for all transactions and metrics captured within this period.',
    `period_lock_date` DATE COMMENT 'The date on which the performance period was locked, preventing any further transactional or adjustment entries. Ensures data integrity for audited financial reporting.',
    `period_name` STRING COMMENT 'Human-readable name or label for the performance period (e.g., FY2024 Period 3, Q1 2024, Week 12). Used for reporting displays and user interfaces.',
    `period_number` STRING COMMENT 'Sequential number of the period within the fiscal year (e.g., Period 1, Period 2). Used for ordering and identification of periods within a fiscal year.',
    `period_start_date` DATE COMMENT 'The first calendar date included in this performance period. Defines the beginning boundary for all transactions and metrics captured within this period.',
    `period_status` STRING COMMENT 'Current lifecycle status of the performance period. Future indicates the period has not yet started; open indicates the period is in progress and transactions are being recorded; closed indicates the period has ended and preliminary results are available; locked indicates the period is finalized and no further changes are allowed; restated indicates the period has been reopened for corrections or adjustments.. Valid values are `future|open|closed|locked|restated`',
    `period_type` STRING COMMENT 'Classification of the reporting period granularity. Daily for day-level tracking, weekly for 7-day cycles, period for 4-week accounting periods, quarter for 13-week fiscal quarters, and annual for full fiscal year.. Valid values are `daily|weekly|period|quarter|annual`',
    `reporting_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code used for financial reporting in this period (e.g., USD, EUR, GBP). All monetary metrics for this period are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
    `seasonality_index` DECIMAL(18,2) COMMENT 'Statistical index representing the expected seasonal variation for this period relative to the annual average (1.00 = average, >1.00 = above average, <1.00 = below average). Used for demand forecasting and labor planning.',
    `source_system_record_code` STRING COMMENT 'Native identifier of the period record in the source system.',
    `sss_eligible_flag` BOOLEAN COMMENT 'Indicates whether this period is eligible for Same-Store Sales (SSS) / Comparable Store Sales (Comp Sales) calculations. True if the period is at least 12 months after the restaurant opening date, enabling year-over-year comparisons.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the period record.',
    `version_number` STRING COMMENT 'Incremental version of the period definition for change‑tracking.',
    `week_number` STRING COMMENT 'The ISO week number (1-53) within the calendar year. Used for weekly performance tracking and labor scheduling alignment.',
    CONSTRAINT pk_performance_period PRIMARY KEY(`performance_period_id`)
) COMMENT 'Master reference table for performance_period. ';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` (
    `pos_terminal_id` BIGINT COMMENT 'Unique identifier for the POS terminal. Primary key.',
    `pos_replacement_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal that replaced this unit, if applicable.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit to which the terminal is assigned.',
    `pos_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where this POS terminal is deployed.',
    `primary_replaced_pos_terminal_id` BIGINT COMMENT 'Self-referencing FK on pos_terminal (replaced_pos_terminal_id)',
    `assigned_station` STRING COMMENT 'Physical station or service point where the terminal is deployed (e.g., FOH counter, DT window 1, DT window 2, bar, patio, expo).',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` (
    `store_campaign_assignment_id` BIGINT COMMENT 'Primary key for the store_campaign_assignment association',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the marketing campaign',
    `unit_id` BIGINT COMMENT 'Identifier of the sponsoring restaurant (if applicable)',
    `store_unit_id` BIGINT COMMENT 'Foreign key linking to the restaurant unit',
    `actual_adt_lift_percent` DECIMAL(18,2) COMMENT 'Measured lift in average daily transactions',
    `actual_comp_sales_lift_percent` DECIMAL(18,2) COMMENT 'Measured lift in comparable store sales',
    `actual_spend` DECIMAL(18,2) COMMENT 'Actual spend recorded for the unit on this campaign',
    `approval_date` DATE COMMENT 'Date when the assignment was approved',
    `approval_status` STRING COMMENT 'Approval status of the units participation',
    `approved_by` STRING COMMENT 'Name of approver for the units campaign assignment',
    `channel` STRING COMMENT 'Marketing channel(s) used for the unit',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the unit complies with campaign guidelines',
    `end_date` DATE COMMENT 'Planned end date of the campaign for the unit',
    `execution_end_date` DATE COMMENT 'Actual execution end date at the unit',
    `execution_start_date` DATE COMMENT 'Actual execution start date at the unit',
    `expected_adt_lift_percent` DECIMAL(18,2) COMMENT 'Planned lift in average daily transactions',
    `expected_comp_sales_lift_percent` DECIMAL(18,2) COMMENT 'Planned lift in comparable store sales',
    `initiative_code` STRING COMMENT 'Business code for the initiative',
    `initiative_name` STRING COMMENT 'Name of the initiative linking unit and campaign',
    `lmf_fund_amount` DECIMAL(18,2) COMMENT 'Local marketing fund amount allocated',
    `lmf_fund_used` DECIMAL(18,2) COMMENT 'Local marketing fund amount used',
    `lmf_remaining_amount` DECIMAL(18,2) COMMENT 'Remaining local marketing fund amount',
    `market_dma` STRING COMMENT 'Designated market DMA for the unit in this campaign',
    `notes` STRING COMMENT 'Free‑form notes about the units campaign execution',
    `planned_spend` DECIMAL(18,2) COMMENT 'Budgeted spend for the unit on this campaign',
    `start_date` DATE COMMENT 'Planned start date of the campaign for the unit',
    `store_campaign_assignment_status` STRING COMMENT 'Current status of the units participation in the campaign',
    `target_audience` STRING COMMENT 'Target guest segment for the unit',
    CONSTRAINT pk_store_campaign_assignment PRIMARY KEY(`store_campaign_assignment_id`)
) COMMENT 'Represents the assignment of a marketing campaign to a specific restaurant unit. Each record captures spend, performance, compliance, and other campaign‑specific attributes that exist only in the context of that unit‑campaign pairing.. Existence Justification: A restaurant unit can participate in multiple marketing campaigns, and each campaign is executed across many units. The business actively tracks per‑unit spend, performance metrics, compliance flags, and other campaign‑specific details, making the relationship a managed entity rather than a simple reference.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` (
    `kitchen_station_id` BIGINT COMMENT 'Primary key for kitchen_station',
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
    `kitchen_station_status` STRING COMMENT 'Current operational status of the station.',
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
    `brand_status` STRING COMMENT 'Current lifecycle state of the brand.',
    `tagline` STRING COMMENT 'Short marketing slogan associated with the brand.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the brand record.',
    `website_url` STRING COMMENT 'Public website address for the brand.',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Master reference table for brand. Referenced by brand_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` (
    `checklist_template_id` BIGINT COMMENT 'Primary key for checklist_template',
    `brand_id` BIGINT COMMENT 'add column brand_id (BIGINT) with FK to restaurant.brand.brand_id - checklist templates should be scoped to a brand for multi-brand operations',
    `parent_checklist_template_id` BIGINT COMMENT 'Self-referencing FK on checklist_template (parent_checklist_template_id)',
    `applicable_restaurant_type` STRING COMMENT 'Restaurant format(s) for which the checklist is intended.',
    `approval_required` BOOLEAN COMMENT 'True if the checklist must be approved before use.',
    `checklist_template_code` STRING COMMENT 'Business identifier or code used to reference the template in operational systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the template record was first created.',
    `checklist_template_description` STRING COMMENT 'Detailed free‑text description of the template purpose and scope.',
    `duration_minutes` STRING COMMENT 'Typical time required to complete the checklist, in minutes.',
    `effective_from` DATE COMMENT 'Date when the checklist template becomes effective for use.',
    `effective_until` DATE COMMENT 'Date when the checklist template expires or is superseded (null if open‑ended).',
    `frequency` STRING COMMENT 'How often the checklist should be executed.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether completion of the checklist is mandatory.',
    `language` STRING COMMENT 'ISO 639‑1 language code of the template content.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the template was last reviewed.',
    `checklist_template_name` STRING COMMENT 'Human‑readable name of the checklist template.',
    `owner_role` STRING COMMENT 'Organizational role responsible for maintaining the template (e.g., Operations Manager).',
    `region` STRING COMMENT 'Three‑letter ISO country/region code where the template is applicable.',
    `review_cycle` STRING COMMENT 'Scheduled interval for formal review of the template.',
    `checklist_template_status` STRING COMMENT 'Current lifecycle status of the template.',
    `template_file_path` STRING COMMENT 'File system or storage path where the template document resides.',
    `template_format` STRING COMMENT 'File format of the stored template.',
    `checklist_template_type` STRING COMMENT 'Category that defines the purpose of the checklist (e.g., safety, training).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the template record.',
    `version` STRING COMMENT 'Version identifier for change control (e.g., v1.2).',
    CONSTRAINT pk_checklist_template PRIMARY KEY(`checklist_template_id`)
) COMMENT 'Master reference table for checklist_template. Referenced by checklist_template_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_brand_standard_id` FOREIGN KEY (`brand_standard_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand_standard`(`brand_standard_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ADD CONSTRAINT `fk_restaurant_location_profile_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ADD CONSTRAINT `fk_restaurant_location_profile_location_unit_id` FOREIGN KEY (`location_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ADD CONSTRAINT `fk_restaurant_format_config_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ADD CONSTRAINT `fk_restaurant_format_config_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ADD CONSTRAINT `fk_restaurant_format_config_format_unit_id` FOREIGN KEY (`format_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ADD CONSTRAINT `fk_restaurant_operating_hours_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ADD CONSTRAINT `fk_restaurant_operating_hours_operating_unit_id` FOREIGN KEY (`operating_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ADD CONSTRAINT `fk_restaurant_equipment_asset_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ADD CONSTRAINT `fk_restaurant_equipment_asset_equipment_unit_id` FOREIGN KEY (`equipment_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ADD CONSTRAINT `fk_restaurant_throughput_benchmark_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ADD CONSTRAINT `fk_restaurant_throughput_benchmark_throughput_unit_id` FOREIGN KEY (`throughput_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ADD CONSTRAINT `fk_restaurant_sos_measurement_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ADD CONSTRAINT `fk_restaurant_sos_measurement_sos_unit_id` FOREIGN KEY (`sos_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ADD CONSTRAINT `fk_restaurant_brand_standard_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` ADD CONSTRAINT `fk_restaurant_brand_standard_superseded_by_standard_brand_standard_id` FOREIGN KEY (`superseded_by_standard_brand_standard_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand_standard`(`brand_standard_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ADD CONSTRAINT `fk_restaurant_unit_performance_performance_period_id` FOREIGN KEY (`performance_period_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`performance_period`(`performance_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ADD CONSTRAINT `fk_restaurant_unit_performance_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ADD CONSTRAINT `fk_restaurant_table_turn_log_performance_period_id` FOREIGN KEY (`performance_period_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`performance_period`(`performance_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ADD CONSTRAINT `fk_restaurant_table_turn_log_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ADD CONSTRAINT `fk_restaurant_table_turn_log_table_unit_id` FOREIGN KEY (`table_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ADD CONSTRAINT `fk_restaurant_capacity_config_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ADD CONSTRAINT `fk_restaurant_capacity_config_capacity_unit_id` FOREIGN KEY (`capacity_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ADD CONSTRAINT `fk_restaurant_unit_status_history_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ADD CONSTRAINT `fk_restaurant_area_management_parent_area_area_management_id` FOREIGN KEY (`parent_area_area_management_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`area_management`(`area_management_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ADD CONSTRAINT `fk_restaurant_area_management_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ADD CONSTRAINT `fk_restaurant_renovation_project_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ADD CONSTRAINT `fk_restaurant_renovation_project_renovation_unit_id` FOREIGN KEY (`renovation_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ADD CONSTRAINT `fk_restaurant_ops_visit_checklist_template_id` FOREIGN KEY (`checklist_template_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`checklist_template`(`checklist_template_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ADD CONSTRAINT `fk_restaurant_ops_visit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ADD CONSTRAINT `fk_restaurant_ops_visit_ops_unit_id` FOREIGN KEY (`ops_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ADD CONSTRAINT `fk_restaurant_ops_visit_finding_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ADD CONSTRAINT `fk_restaurant_ops_visit_finding_ops_unit_id` FOREIGN KEY (`ops_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ADD CONSTRAINT `fk_restaurant_ops_visit_finding_ops_visit_id` FOREIGN KEY (`ops_visit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`ops_visit`(`ops_visit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ADD CONSTRAINT `fk_restaurant_ops_visit_finding_previous_finding_ops_visit_finding_id` FOREIGN KEY (`previous_finding_ops_visit_finding_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding`(`ops_visit_finding_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ADD CONSTRAINT `fk_restaurant_unit_ownership_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ADD CONSTRAINT `fk_restaurant_performance_period_performance_prior_period_id` FOREIGN KEY (`performance_prior_period_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`performance_period`(`performance_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ADD CONSTRAINT `fk_restaurant_performance_period_performance_prior_year_period_id` FOREIGN KEY (`performance_prior_year_period_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`performance_period`(`performance_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ADD CONSTRAINT `fk_restaurant_performance_period_primary_prior_performance_period_id` FOREIGN KEY (`primary_prior_performance_period_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`performance_period`(`performance_period_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ADD CONSTRAINT `fk_restaurant_performance_period_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ADD CONSTRAINT `fk_restaurant_pos_terminal_pos_replacement_terminal_id` FOREIGN KEY (`pos_replacement_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ADD CONSTRAINT `fk_restaurant_pos_terminal_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ADD CONSTRAINT `fk_restaurant_pos_terminal_pos_unit_id` FOREIGN KEY (`pos_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ADD CONSTRAINT `fk_restaurant_pos_terminal_primary_replaced_pos_terminal_id` FOREIGN KEY (`primary_replaced_pos_terminal_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ADD CONSTRAINT `fk_restaurant_store_campaign_assignment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ADD CONSTRAINT `fk_restaurant_store_campaign_assignment_store_unit_id` FOREIGN KEY (`store_unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ADD CONSTRAINT `fk_restaurant_kitchen_station_location_profile_id` FOREIGN KEY (`location_profile_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`location_profile`(`location_profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ADD CONSTRAINT `fk_restaurant_kitchen_station_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ADD CONSTRAINT `fk_restaurant_kitchen_station_upstream_kitchen_station_id` FOREIGN KEY (`upstream_kitchen_station_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`kitchen_station`(`kitchen_station_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ADD CONSTRAINT `fk_restaurant_brand_parent_brand_id` FOREIGN KEY (`parent_brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ADD CONSTRAINT `fk_restaurant_checklist_template_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ADD CONSTRAINT `fk_restaurant_checklist_template_parent_checklist_template_id` FOREIGN KEY (`parent_checklist_template_id`) REFERENCES `vibe_restaurants_v1`.`restaurant`.`checklist_template`(`checklist_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`restaurant` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_restaurants_v1`.`restaurant` SET TAGS ('dbx_domain' = 'restaurant');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` SET TAGS ('dbx_subdomain' = 'location_management');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `landlord_id` SET TAGS ('dbx_business_glossary_term' = 'Landlord Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `trade_area_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Area Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit` ALTER COLUMN `sop_document_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Document Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` SET TAGS ('dbx_subdomain' = 'location_management');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `location_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Location Profile ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`location_profile` ALTER COLUMN `location_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
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
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` SET TAGS ('dbx_subdomain' = 'location_management');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `format_config_id` SET TAGS ('dbx_business_glossary_term' = 'Format Configuration ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`format_config` ALTER COLUMN `format_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
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
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` SET TAGS ('dbx_subdomain' = 'location_management');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `operating_hours_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `scheduling_template_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Scheduling Template ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `operating_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `operating_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `operating_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`operating_hours` ALTER COLUMN `operating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
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
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `equipment_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`equipment_asset` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
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
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `throughput_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Throughput Benchmark ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `throughput_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `benchmark_source` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Source');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `benchmark_source` SET TAGS ('dbx_value_regex' = 'corporate_standard|franchise_agreement|regional_target|unit_specific|industry_benchmark');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_value_regex' = 'target|minimum|maximum|stretch');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `equipment_capacity_constraint` SET TAGS ('dbx_business_glossary_term' = 'Equipment Capacity Constraint');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `labor_fte_requirement` SET TAGS ('dbx_business_glossary_term' = 'Labor Full-Time Equivalent (FTE) Requirement');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `off_peak_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Off-Peak Hour Multiplier');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `peak_hour_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Peak Hour Multiplier');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `queue_length_threshold` SET TAGS ('dbx_business_glossary_term' = 'Queue Length Threshold');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `restaurant_format` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Format');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `restaurant_format` SET TAGS ('dbx_value_regex' = 'QSR|casual|fine_dining');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `service_channel` SET TAGS ('dbx_business_glossary_term' = 'Service Channel');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `service_channel` SET TAGS ('dbx_value_regex' = 'DT|counter|OLO|3PD|dine_in|curbside');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `sos_compliance_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Compliance Threshold Percentage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `target_acv` SET TAGS ('dbx_business_glossary_term' = 'Target Average Check Value (ACV)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `target_adt` SET TAGS ('dbx_business_glossary_term' = 'Target Average Daily Transactions (ADT)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `target_atc` SET TAGS ('dbx_business_glossary_term' = 'Target Average Transaction Count (ATC)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `target_cover_count_capacity` SET TAGS ('dbx_business_glossary_term' = 'Target Cover Count Capacity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `target_table_turn_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target Table Turn (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `target_throughput_covers_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Target Throughput Covers Per Hour');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `target_throughput_transactions_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Target Throughput Transactions Per Hour');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `target_ticket_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Target Ticket Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `throughput_benchmark_status` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`throughput_benchmark` ALTER COLUMN `throughput_benchmark_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `sos_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Measurement ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `sos_target_id` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Target ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `sos_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `equipment_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Issue Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `guest_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction (CSAT) Rating');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `measurement_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Measurement Quality Score');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'pos_timer|kds_system|drive_thru_sensor|manual_entry|olo_platform|third_party_api');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `order_complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Order Complexity Score');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `order_item_count` SET TAGS ('dbx_business_glossary_term' = 'Order Item Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `order_to_delivery_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Order to Delivery Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `order_to_ready_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Order to Ready Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `peak_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Peak Period Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `queue_depth_count` SET TAGS ('dbx_business_glossary_term' = 'Queue Depth Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `queue_wait_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Queue Wait Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `service_channel` SET TAGS ('dbx_business_glossary_term' = 'Service Channel');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `service_channel` SET TAGS ('dbx_value_regex' = 'drive_thru|counter|kiosk|online_ordering|third_party_delivery|curbside');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `service_recovery_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `staff_count_on_duty` SET TAGS ('dbx_business_glossary_term' = 'Staff Count on Duty');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `target_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Target Met Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `target_variance_seconds` SET TAGS ('dbx_business_glossary_term' = 'Target Variance (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `ticket_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ticket Time (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`sos_measurement` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand_standard` SET TAGS ('dbx_subdomain' = 'brand_standards');
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
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `unit_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Performance ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `performance_period_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `acv_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Check Value (ACV) Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `adt_count` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Transactions (ADT) Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `atc_count` SET TAGS ('dbx_business_glossary_term' = 'Average Transaction Count (ATC)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `auc_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV) Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `cogs_percent` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Percentage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `comp_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Comparable Store Sales (Comp Sales) Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `comp_sales_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Comparable Store Sales Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `ebitda_amount` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `fiscal_week` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Week');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `labor_percent` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Percentage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `marketing_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Marketing Expense Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `net_income_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Income Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Performance Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `operating_income_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Income Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `performance_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Record Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `performance_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|revised|archived');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `rent_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Rent Expense Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `rm_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Repairs and Maintenance (R&M) Expense Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `sss_growth_percent` SET TAGS ('dbx_business_glossary_term' = 'Same-Store Sales (SSS) Growth Percent');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `total_operating_expenses_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Operating Expenses Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `utility_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Utility Expense Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `waste_amount` SET TAGS ('dbx_business_glossary_term' = 'Food Waste Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_performance` ALTER COLUMN `waste_percent` SET TAGS ('dbx_business_glossary_term' = 'Food Waste Percentage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `table_turn_log_id` SET TAGS ('dbx_business_glossary_term' = 'Table Turn Log ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Order ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `performance_period_id` SET TAGS ('dbx_business_glossary_term' = 'Service Period ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Server ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `table_server_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Server ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `table_server_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `table_server_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `table_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `check_presented_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check Presented Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `check_to_cleared_minutes` SET TAGS ('dbx_business_glossary_term' = 'Check to Cleared Time (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `check_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Check Total Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `cover_count` SET TAGS ('dbx_business_glossary_term' = 'Cover Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|brunch');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `delivery_to_check_minutes` SET TAGS ('dbx_business_glossary_term' = 'Delivery to Check Time (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `food_delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Food Delivered Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `is_peak_period` SET TAGS ('dbx_business_glossary_term' = 'Peak Period Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Turn Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `order_to_delivery_minutes` SET TAGS ('dbx_business_glossary_term' = 'Order to Delivery Time (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `party_size` SET TAGS ('dbx_business_glossary_term' = 'Party Size');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `payment_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Completed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `reservation_flag` SET TAGS ('dbx_business_glossary_term' = 'Reservation Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `revenue_per_cover` SET TAGS ('dbx_business_glossary_term' = 'Revenue Per Cover');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `seating_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Seating Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `seating_to_order_minutes` SET TAGS ('dbx_business_glossary_term' = 'Seating to Order Time (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `server_station` SET TAGS ('dbx_business_glossary_term' = 'Server Station');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `sos_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Target (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `sos_variance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Variance (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `special_occasion_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Occasion Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `table_capacity` SET TAGS ('dbx_business_glossary_term' = 'Table Capacity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `table_cleared_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Table Cleared Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `table_number` SET TAGS ('dbx_business_glossary_term' = 'Table Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `table_section` SET TAGS ('dbx_business_glossary_term' = 'Table Section');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `total_turn_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Turn Time (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `turn_date` SET TAGS ('dbx_business_glossary_term' = 'Turn Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `turn_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Turn Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `turn_status` SET TAGS ('dbx_business_glossary_term' = 'Turn Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `turn_status` SET TAGS ('dbx_value_regex' = 'completed|incomplete|voided|abandoned');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`table_turn_log` ALTER COLUMN `wait_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Wait Time (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` SET TAGS ('dbx_subdomain' = 'location_management');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `capacity_config_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Configuration ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `capacity_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `ada_compliant_seating_count` SET TAGS ('dbx_business_glossary_term' = 'ADA (Americans with Disabilities Act) Compliant Seating Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `avg_party_size` SET TAGS ('dbx_business_glossary_term' = 'Average Party Size');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `bar_seating_count` SET TAGS ('dbx_business_glossary_term' = 'Bar Seating Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `config_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `config_end_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration End Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `config_notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `counter_service_positions` SET TAGS ('dbx_business_glossary_term' = 'Counter Service Positions');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `curbside_pickup_spaces` SET TAGS ('dbx_business_glossary_term' = 'Curbside Pickup Spaces');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `delivery_staging_capacity` SET TAGS ('dbx_business_glossary_term' = 'Delivery Staging Capacity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `drive_thru_sos_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Speed of Service (SOS) Target (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `drive_thru_stacking_capacity` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Stacking Capacity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `fire_code_occupancy_limit` SET TAGS ('dbx_business_glossary_term' = 'Fire Code Occupancy Limit');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `health_permit_capacity` SET TAGS ('dbx_business_glossary_term' = 'Health Permit Capacity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `health_permit_capacity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `health_permit_capacity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `indoor_seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Indoor Seating Capacity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `kiosk_count` SET TAGS ('dbx_business_glossary_term' = 'Self-Service Kiosk Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `kitchen_production_capacity_orders_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Production Capacity (Orders Per Hour)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `labor_staffing_ratio` SET TAGS ('dbx_business_glossary_term' = 'Labor Staffing Ratio');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `max_cover_count_breakfast` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cover Count - Breakfast Daypart');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `max_cover_count_dinner` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cover Count - Dinner Daypart');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `max_cover_count_late_night` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cover Count - Late Night Daypart');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `max_cover_count_lunch` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cover Count - Lunch Daypart');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `outdoor_seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Outdoor Seating Capacity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `peak_hour_throughput_capacity` SET TAGS ('dbx_business_glossary_term' = 'Peak Hour Throughput Capacity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `private_dining_capacity` SET TAGS ('dbx_business_glossary_term' = 'Private Dining Room Capacity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `sos_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Target (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `table_turn_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Table Turn Target (Minutes)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `total_seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Total Seating Capacity');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`capacity_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` SET TAGS ('dbx_subdomain' = 'location_management');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `unit_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Status History ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating User ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `unit_initiated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating User ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `unit_initiated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `actual_reopen_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Reopen Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `closure_type` SET TAGS ('dbx_business_glossary_term' = 'Closure Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Status End Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `estimated_revenue_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `expected_reopen_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Reopen Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `grand_opening_date` SET TAGS ('dbx_business_glossary_term' = 'Grand Opening Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `health_department_case_number` SET TAGS ('dbx_business_glossary_term' = 'Health Department Case Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `health_department_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `impact_on_franchise_agreement` SET TAGS ('dbx_business_glossary_term' = 'Impact on Franchise Agreement');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `impact_on_franchise_agreement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Status Change Initiated By');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `is_sss_eligible` SET TAGS ('dbx_business_glossary_term' = 'Same-Store Sales (SSS) Eligible Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `nro_flag` SET TAGS ('dbx_business_glossary_term' = 'New Restaurant Opening (NRO) Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Unit Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_value_regex' = 'active|temporarily_closed|permanently_closed|under_renovation|pre_opening|soft_open');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `renovation_scope` SET TAGS ('dbx_business_glossary_term' = 'Renovation Scope');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `renovation_scope` SET TAGS ('dbx_value_regex' = 'minor_refresh|major_remodel|equipment_upgrade|expansion|full_rebuild');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `restaurant_number` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `soft_open_start_date` SET TAGS ('dbx_business_glossary_term' = 'Soft Open Start Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `unit_status_history_status` SET TAGS ('dbx_business_glossary_term' = 'Unit Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_status_history` ALTER COLUMN `unit_status_history_status` SET TAGS ('dbx_value_regex' = 'active|temporarily_closed|permanently_closed|under_renovation|pre_opening|soft_open');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` SET TAGS ('dbx_subdomain' = 'location_management');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `area_management_id` SET TAGS ('dbx_business_glossary_term' = 'Area Management ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Area Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `parent_area_area_management_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Area ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Area Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `area_name` SET TAGS ('dbx_business_glossary_term' = 'Area Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `area_status` SET TAGS ('dbx_business_glossary_term' = 'Area Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `area_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `area_type` SET TAGS ('dbx_business_glossary_term' = 'Area Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `area_type` SET TAGS ('dbx_value_regex' = 'district|region|territory|zone|market');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `auv_target` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV) Target');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `brand` SET TAGS ('dbx_business_glossary_term' = 'Brand');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `cogs_percent_target` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Percentage Target');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `company_owned_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Company-Owned Unit Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `csat_target_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Target Score');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `franchise_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `franchise_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Franchise Unit Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `labor_percent_target` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Percentage Target');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `marketing_fund_contribution_percent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Contribution Percentage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `marketing_fund_contribution_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `nps_target_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Target');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `nro_target_count` SET TAGS ('dbx_business_glossary_term' = 'New Restaurant Opening (NRO) Target Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `sos_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Speed of Service (SOS) Target Seconds');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `sss_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Same-Store Sales (SSS) Target Percentage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `territory_boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Boundary Description');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`area_management` ALTER COLUMN `unit_count` SET TAGS ('dbx_business_glossary_term' = 'Unit Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `renovation_project_id` SET TAGS ('dbx_business_glossary_term' = 'Renovation Project ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `renovation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `renovation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `renovation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `renovation_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `actual_auv_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Average Unit Volume (AUV) Lift Percent');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `actual_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Capital Expenditure (CapEx) USD');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `ada_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `architect_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Architect Firm Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `brand_standard_version` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Version');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `budget_variance_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance USD');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `building_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Building Permit Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `closure_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Closure Duration Days');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `contractor_license_number` SET TAGS ('dbx_business_glossary_term' = 'Contractor License Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `energy_efficiency_upgrade_flag` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency Upgrade Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `estimated_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capital Expenditure (CapEx) USD');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `expected_auv_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Average Unit Volume (AUV) Lift Percent');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `final_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Final Inspection Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `financing_method` SET TAGS ('dbx_business_glossary_term' = 'Financing Method');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `financing_method` SET TAGS ('dbx_value_regex' = 'corporate_funds|franchise_funded|loan|lease|mixed');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|conditional_approval');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `partial_closure_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Closure Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `project_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `project_priority` SET TAGS ('dbx_business_glossary_term' = 'Project Priority');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `project_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'planned|approved|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'full_remodel|refresh|equipment_upgrade|ada_retrofit|brand_reimaging|expansion');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `roi_payback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Payback Period Months');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`renovation_project` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Months');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `ops_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Visit ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `checklist_template_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Template ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Manager ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `ops_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `primary_ops_visitor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Visitor Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `primary_ops_visitor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `primary_ops_visitor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `brand_standard_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `brand_standard_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partially_compliant|under_review');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `checklist_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Checklist Completion Percentage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `cleanliness_score` SET TAGS ('dbx_business_glossary_term' = 'Cleanliness Score');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `customer_count_observed` SET TAGS ('dbx_business_glossary_term' = 'Customer Count Observed');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `daypart_observed` SET TAGS ('dbx_business_glossary_term' = 'Daypart Observed');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `follow_up_visit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Visit Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `follow_up_visit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Visit Scheduled Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `food_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Food Quality Score');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `non_critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Critical Findings Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `overall_visit_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Visit Score');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `safety_score` SET TAGS ('dbx_business_glossary_term' = 'Safety Score');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `service_score` SET TAGS ('dbx_business_glossary_term' = 'Service Score');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `speed_score` SET TAGS ('dbx_business_glossary_term' = 'Speed Score');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `staff_count_observed` SET TAGS ('dbx_business_glossary_term' = 'Staff Count Observed');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_category` SET TAGS ('dbx_business_glossary_term' = 'Visit Category');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_category` SET TAGS ('dbx_value_regex' = 'routine|targeted|complaint_driven|regulatory|pre_opening');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Visit Duration Minutes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Visit End Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_notes` SET TAGS ('dbx_business_glossary_term' = 'Visit Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_number` SET TAGS ('dbx_business_glossary_term' = 'Visit Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Visit Priority Level');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Visit Start Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|rescheduled');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_value_regex' = 'scheduled|unannounced|follow_up|nro_opening_support|compliance_audit|quality_inspection');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visitor_name` SET TAGS ('dbx_business_glossary_term' = 'Visitor Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `visitor_role` SET TAGS ('dbx_business_glossary_term' = 'Visitor Role');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `ops_visit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Visit Finding ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `ops_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `ops_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Visit ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `previous_finding_ops_visit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `primary_ops_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `primary_ops_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `primary_ops_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `brand_standard_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `brand_standard_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `corrective_action_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `corrective_action_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Verification Method');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `corrective_action_verification_method` SET TAGS ('dbx_value_regex' = 'on_site_inspection|photo_evidence|document_review|manager_attestation|follow_up_visit');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'unit|area|region|corporate');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `financial_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact (USD)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `financial_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `finding_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Sequence Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `finding_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Finding Subcategory');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `finding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `guest_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Impact Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `ops_visit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `ops_visit_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|waived');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `photo_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence URL');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `regulatory_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Violation Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `repeat_occurrence_count` SET TAGS ('dbx_business_glossary_term' = 'Repeat Occurrence Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `responsible_party_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Role');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`ops_visit_finding` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` SET TAGS ('dbx_subdomain' = 'location_management');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `unit_ownership_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Ownership ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `unit_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `unit_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `unit_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Partner ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `unit_franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Partner ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `unit_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `unit_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `unit_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `area_development_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Area Development Agreement Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|remediation_in_progress');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `financial_reporting_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Entity Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `franchise_agreement_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `franchise_agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Start Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `initial_franchise_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Initial Franchise Fee (USD)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `initial_franchise_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `joint_venture_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Partner Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `joint_venture_partner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `last_compliance_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Audit Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `marketing_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fee Percentage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `marketing_fee_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `master_franchise_flag` SET TAGS ('dbx_business_glossary_term' = 'Master Franchise Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `next_compliance_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Audit Due Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `operating_entity_legal_name` SET TAGS ('dbx_business_glossary_term' = 'Operating Entity Legal Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `operating_entity_legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `operating_license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Operating License Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `operating_license_number` SET TAGS ('dbx_business_glossary_term' = 'Operating License Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `ownership_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Ownership Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `ownership_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Ownership Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `ownership_notes` SET TAGS ('dbx_business_glossary_term' = 'Ownership Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `ownership_record_number` SET TAGS ('dbx_business_glossary_term' = 'Ownership Record Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `ownership_record_number` SET TAGS ('dbx_value_regex' = '^OWN-[0-9]{8}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `ownership_status` SET TAGS ('dbx_business_glossary_term' = 'Ownership Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `ownership_status` SET TAGS ('dbx_value_regex' = 'active|pending|transferred|terminated|suspended');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `ownership_transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Ownership Transfer Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'company_owned|franchised|licensed|joint_venture|master_franchise|area_development');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `previous_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Previous Owner Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `previous_owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `transfer_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `transfer_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Transfer Approved By');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`unit_ownership` ALTER COLUMN `transfer_reason` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `performance_period_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `performance_prior_period_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Performance Period Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `performance_prior_year_period_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Performance Period Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `primary_prior_performance_period_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Performance Period Id');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `primary_prior_performance_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `auv_calculation_window_months` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV) Calculation Window Months');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `business_day_count` SET TAGS ('dbx_business_glossary_term' = 'Business Day Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `calendar_month` SET TAGS ('dbx_business_glossary_term' = 'Calendar Month');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `calendar_quarter` SET TAGS ('dbx_business_glossary_term' = 'Calendar Quarter');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `calendar_year` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `comp_sales_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Comparable Sales (Comp Sales) Eligible Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `day_count` SET TAGS ('dbx_business_glossary_term' = 'Day Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `fiscal_week` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Week');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `holiday_flag` SET TAGS ('dbx_business_glossary_term' = 'Holiday Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `holiday_list` SET TAGS ('dbx_business_glossary_term' = 'Holiday List');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `is_closed` SET TAGS ('dbx_business_glossary_term' = 'Is Closed Period Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Period Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `is_leap_year` SET TAGS ('dbx_business_glossary_term' = 'Is Leap Year');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Period Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `performance_period_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `performance_period_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_category` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Category');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_category` SET TAGS ('dbx_value_regex' = 'operational|financial|marketing|workforce|supply_chain');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_close_date` SET TAGS ('dbx_business_glossary_term' = 'Period Close Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Period Duration (Days)');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Period Lock Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Period Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'future|open|closed|locked|restated');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|period|quarter|annual');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `seasonality_index` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Index');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `sss_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Same-Store Sales (SSS) Eligible Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`performance_period` ALTER COLUMN `week_number` SET TAGS ('dbx_business_glossary_term' = 'Week Number');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` SET TAGS ('dbx_subdomain' = 'equipment_operations');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `pos_replacement_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Terminal ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `pos_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `primary_replaced_pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Replaced Pos Terminal Id');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `primary_replaced_pos_terminal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`pos_terminal` ALTER COLUMN `assigned_station` SET TAGS ('dbx_business_glossary_term' = 'Assigned Station');
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
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` SET TAGS ('dbx_association_edges' = 'restaurant.unit,marketing.campaign');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `store_campaign_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Store Campaign Assignment Id');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Campaign Id');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Sponsor Restaurant Id');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `store_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Unit Id');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `actual_adt_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Actual Adt Lift Percent');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `actual_comp_sales_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Actual Comp Sales Lift Percent');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Actual Spend');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Approved By');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Channel');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - End Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `execution_end_date` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Execution End Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `execution_start_date` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Execution Start Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `expected_adt_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Expected Adt Lift Percent');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `expected_comp_sales_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Expected Comp Sales Lift Percent');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `initiative_code` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Initiative Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `initiative_name` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Initiative Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `lmf_fund_amount` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Lmf Fund Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `lmf_fund_used` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Lmf Fund Used');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `lmf_remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Lmf Remaining Amount');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `market_dma` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Market Dma');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Notes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `planned_spend` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Planned Spend');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Start Date');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `store_campaign_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Store Campaign Assignment - Target Audience');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` SET TAGS ('dbx_subdomain' = 'brand_standards');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `kitchen_station_id` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Station Identifier');
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
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `kitchen_station_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `temperature_control` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `temperature_range_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range C');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`kitchen_station` ALTER COLUMN `throughput_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Throughput Per Hour');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` SET TAGS ('dbx_subdomain' = 'brand_standards');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `parent_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Id');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `average_annual_sales_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Annual Sales Usd');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `average_check_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Check Amount Usd');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `average_daily_customers` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Customers');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `average_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Average Employee Count');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `average_store_size_sqft` SET TAGS ('dbx_business_glossary_term' = 'Average Store Size Sqft');
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
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `tagline` SET TAGS ('dbx_business_glossary_term' = 'Brand Tagline');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`brand` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` SET TAGS ('dbx_subdomain' = 'brand_standards');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `checklist_template_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Template Identifier');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `parent_checklist_template_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Checklist Template Id');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `parent_checklist_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `applicable_restaurant_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Restaurant Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `checklist_template_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `checklist_template_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `checklist_template_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Owner Role');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `checklist_template_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `template_file_path` SET TAGS ('dbx_business_glossary_term' = 'Template File Path');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `template_format` SET TAGS ('dbx_business_glossary_term' = 'Template Format');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `checklist_template_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`restaurant`.`checklist_template` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
