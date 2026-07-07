-- Schema for Domain: property | Business: Travel_Hospitality | Version: v2_mvm
-- Generated on: 2026-06-27 02:37:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`property` COMMENT 'Master data for physical hotel and resort assets including location, brand affiliation, property attributes, facility amenities, service levels, classifications, and operational status. Manages property hierarchy, geographic distribution, brand portfolio, franchise relationships, and PIP (Property Improvement Plan) records. Supports multi-property operations and STR competitive set benchmarking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`property` (
    `property_id` BIGINT COMMENT 'Primary key for property',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each property operates in ONE currency; each currency used by MANY properties. Normalize currency reference to master currency table. Remove currency_code string from property - will be retrieved via ',
    `address_line1` STRING COMMENT 'The primary street address of the property including street number and street name. Used for guest communications, GDS/OTA display, emergency services, and regulatory filings.',
    `address_line2` STRING COMMENT 'Secondary address information such as suite number, building name, or floor designation. Supplements address_line1 for complete physical address representation.',
    `brand_code` STRING COMMENT 'Short alphanumeric code identifying the hotel brand affiliation (e.g., HH for Hilton Hotels, MXY for Marriott, etc.). Used for brand-level reporting, loyalty program alignment, and STR competitive benchmarking. Maps to the brand reference product.. Valid values are `^[A-Z]{2,8}$`',
    `brand_name` STRING COMMENT 'Full name of the hotel brand (e.g., Hilton Hotels and Resorts, Marriott Hotels). Denormalized for reporting convenience and to support brand-level analytics without requiring a join to the brand reference product.',
    `brand_tier` STRING COMMENT 'The STR-aligned brand tier classification indicating the market positioning of the property brand. Used for RevPAR benchmarking, competitive set definition, and revenue strategy segmentation. Aligns with STR chain scale categories.. Valid values are `luxury|upper_upscale|upscale|upper_midscale|midscale|economy`',
    `city` STRING COMMENT 'The city or municipality in which the property is located. Used for geographic reporting, market segmentation, STR competitive set definition, and OTA search indexing.',
    `closure_date` DATE COMMENT 'The date on which the property permanently closed or was converted. Null for active properties. Used for portfolio lifecycle reporting, asset disposal accounting under IFRS/GAAP, and STR historical benchmarking exclusion.',
    `country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 three-letter country code for the country in which the property is located (e.g., USA, GBR, DEU). Used for international reporting, currency determination, regulatory jurisdiction, and GDPR/CCPA applicability assessment.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the property master record was first created in the data platform. Used for data lineage, audit trail, and record lifecycle management. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per platform conventions.',
    `dos_email` STRING COMMENT 'The business email address of the Director of Sales (DOS) for this property. Used for group lead routing, RFP notifications, and sales performance reporting distribution via Salesforce CRM and Delphi by Amadeus.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `dos_name` STRING COMMENT 'The full name of the Director of Sales (DOS) responsible for group, corporate, and MICE sales for this property. Used for Delphi by Amadeus event sales routing, Salesforce CRM account ownership, and sales performance reporting.',
    `franchise_agreement_number` STRING COMMENT 'The unique identifier of the franchise license agreement governing the propertys brand affiliation. Populated only when is_franchised is true. Used for franchise compliance tracking, royalty fee calculation, and brand standards audit management.',
    `gds_property_code` STRING COMMENT 'The property code used within Global Distribution Systems (GDS) such as Amadeus, Sabre, and Travelport for travel agent bookings and corporate rate distribution. Critical for channel distribution management and OTA/GDS rate parity monitoring.',
    `gm_email` STRING COMMENT 'The business email address of the current General Manager (GM). Used for operational communications, escalation routing, and executive reporting. Classified as confidential PII as it identifies a specific individual.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `gm_name` STRING COMMENT 'The full name of the current General Manager (GM) responsible for the propertys overall operations. Used for operational escalations, regulatory correspondence, and executive reporting. Classified confidential as an internal business contact.',
    `is_franchised` BOOLEAN COMMENT 'Indicates whether the property operates under a franchise agreement with the brand. When true, franchise fee structures, brand standards compliance, and PIP obligations apply. Drives franchise royalty reporting and brand audit scheduling.',
    `largest_meeting_room_sqft` STRING COMMENT 'The square footage of the largest single meeting or ballroom space at the property. Used for group sales qualification, event capacity planning, and MICE marketing collateral.',
    `last_renovation_date` DATE COMMENT 'The date on which the most recent significant renovation or Property Improvement Plan (PIP) was completed. Used for FF&E (Furniture, Fixtures and Equipment) lifecycle tracking, CapEx planning, brand standards compliance, and franchise renewal assessments.',
    `latitude` DECIMAL(18,2) COMMENT 'The geographic latitude coordinate of the property in decimal degrees (WGS84 datum). Used for mapping, proximity-based search, competitive set geographic analysis, and mobile guest experience features.',
    `longitude` DECIMAL(18,2) COMMENT 'The geographic longitude coordinate of the property in decimal degrees (WGS84 datum). Used for mapping, proximity-based search, competitive set geographic analysis, and mobile guest experience features.',
    `property_name` STRING COMMENT 'The full official trading name of the hotel, resort, or vacation property as displayed to guests, on signage, and in all guest-facing communications. This is the authoritative display name used across all channels.',
    `opening_date` DATE COMMENT 'The date on which the property first opened for guest operations. Used for property age calculations, depreciation schedules under IFRS/GAAP, STR comp set historical analysis, and anniversary-based marketing campaigns.',
    `opera_property_code` STRING COMMENT 'The unique alphanumeric property code assigned within Oracle OPERA PMS. This is the operational system-of-record identifier used for front desk, reservations, cashiering, and housekeeping transactions. Serves as the primary integration key between the lakehouse and OPERA.. Valid values are `^[A-Z0-9]{3,10}$`',
    `operational_status` STRING COMMENT 'The formal lifecycle state of the property. Governs whether the property is bookable, reportable in STR benchmarks, and included in revenue management optimization. Valid states: pre_opening (under development/fit-out), active (fully operational), suspended (temporarily closed), closed (permanently closed), converted (rebranded or repurposed).. Valid values are `pre_opening|active|suspended|closed|converted`',
    `parent_brand_group` STRING COMMENT 'The name of the parent hotel company or brand group that owns the brand (e.g., Hilton Worldwide, Marriott International, Hyatt Hotels Corporation). Supports portfolio-level reporting and corporate hierarchy analytics.',
    `phone_number` STRING COMMENT 'The main public-facing telephone number for the property in E.164 international format. Used for guest communications, GDS/OTA display, emergency contact, and regulatory filings.. Valid values are `^+[1-9]d{1,14}$`',
    `pip_status` STRING COMMENT 'The current status of the Property Improvement Plan (PIP) for this property. PIPs are typically required at franchise renewal, ownership transfer, or brand standard updates. Drives CapEx budget planning and franchise compliance monitoring.. Valid values are `not_required|planned|in_progress|completed|overdue`',
    `postal_code` STRING COMMENT 'The postal or ZIP code of the property location. Used for geographic analytics, tax jurisdiction mapping, OTA search, and regulatory reporting.',
    `property_type` STRING COMMENT 'The physical and operational type of the property asset. Drives applicable operating procedures, amenity expectations, and regulatory requirements. [ENUM-REF-CANDIDATE: hotel|resort|extended_stay|vacation_property|boutique|conference_center — promote to reference product]. Valid values are `hotel|resort|extended_stay|vacation_property|boutique|conference_center`',
    `revenue_manager_email` STRING COMMENT 'The business email address of the Revenue Manager for this property. Used for IDeaS G3 RMS notifications, rate strategy communications, and revenue performance reporting distribution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `revenue_manager_name` STRING COMMENT 'The full name of the Revenue Manager responsible for pricing, forecasting, and inventory controls for this property. Used for IDeaS G3 RMS access provisioning, escalation routing, and revenue strategy accountability.',
    `segment_classification` STRING COMMENT 'The operational segment classification of the property indicating service level and market positioning. Used for USALI-aligned financial reporting, revenue management strategy, and portfolio segmentation. [ENUM-REF-CANDIDATE: luxury|premium|upper_upscale|upscale|select_service|extended_stay|resort — promote to reference product]',
    `star_rating` DECIMAL(18,2) COMMENT 'The official star rating of the property on a 1.0 to 5.0 scale as awarded by the applicable national or international rating authority (e.g., AAA, Forbes Travel Guide, national tourism boards). Used for guest expectation setting, OTA display, and competitive benchmarking.',
    `state_province` STRING COMMENT 'The state, province, or administrative region in which the property is located. Used for tax jurisdiction determination, regulatory compliance (CCPA for California properties), and regional performance reporting.',
    `str_property_code` STRING COMMENT 'The unique property identifier assigned by STR (Smith Travel Research) for inclusion in the STAR Report competitive benchmarking program. Required for RGI (Revenue Generation Index), MPI (Market Penetration Index), and ARI (Average Rate Index) reporting.',
    `synxis_property_code` STRING COMMENT 'The property identifier assigned within Sabre SynXis CRS used for central reservations, channel management, and rate distribution. Required for reconciling CRS bookings to the property master record.',
    `time_zone` STRING COMMENT 'The IANA time zone identifier for the propertys local time zone (e.g., America/New_York, Europe/London). Critical for accurate check-in/check-out timestamp processing, night audit scheduling, and revenue management rate activation timing.',
    `total_floor_count` STRING COMMENT 'The total number of floors in the main hotel tower or building. Used for housekeeping scheduling, elevator capacity planning, and emergency evacuation planning per local fire safety and building codes.',
    `total_meeting_space_sqft` STRING COMMENT 'The total square footage of all meeting, conference, and event spaces within the property. Key metric for MICE (Meetings, Incentives, Conferences, Exhibitions) sales, group evaluation, and event revenue forecasting in Delphi by Amadeus.',
    `total_room_count` STRING COMMENT 'The total number of guest rooms and suites in the property inventory. This is the denominator for RevPAR, OCC (Occupancy Rate), and CPOR (Cost Per Occupied Room) calculations. Sourced from Oracle OPERA PMS room inventory configuration.',
    `total_suite_count` STRING COMMENT 'The number of suite-category rooms within the total room inventory. Used for premium inventory management, upsell strategy, and suite-specific RevPAR reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the property master record was most recently modified. Used for change data capture (CDC), ETL incremental load processing, and audit trail compliance. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per platform conventions.',
    CONSTRAINT pk_property PRIMARY KEY(`property_id`)
) COMMENT 'Master record for each physical hotel, resort, or vacation property in the portfolio. Captures the authoritative identity including brand affiliation (brand code, brand tier, parent brand group), segment classification (luxury, premium, select-service), ownership type, franchise status, operational status with formal lifecycle states (pre-opening, active, suspended, closed, converted), star rating, total room count, geographic coordinates, full physical address (street, city, state/province, postal code, country), time zone, currency, PMS system identifiers, and key operational contacts (GM name/email, DOS name/email, revenue manager name/email). This is the SSOT for property identity, location, brand affiliation, and operational state across all domains. Sourced from Oracle OPERA PMS property configuration.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` (
    `hierarchy_id` BIGINT COMMENT 'Unique surrogate identifier for each node in the property organizational and operational hierarchy. Serves as the primary key for this entity in the Silver Layer lakehouse.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each hierarchy node reports in ONE currency. Normalize currency reference to master currency table. Remove currency_code string - will be retrieved via JOIN.',
    `parent_node_hierarchy_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediate parent node in the hierarchy tree. Null for the corporate root node. Enables recursive parent-child traversal for consolidated reporting of RevPAR, ADR, OCC, and GOP across organizational tiers.',
    `property_id` BIGINT COMMENT 'Foreign key linking to property.property. Business justification: A hierarchy node CAN represent a single property (leaf node) or a grouping (branch node). Link leaf nodes to their property master record. This FK will be nullable - branch nodes (regions, portfolios)',
    `brand_portfolio` STRING COMMENT 'Name of the brand portfolio or brand family associated with this hierarchy node (e.g., Luxury Collection, Premium Brands, Select Service). Applicable to division and region nodes that manage a specific brand segment. Supports brand-level performance reporting and portfolio analytics.',
    `chain_scale` STRING COMMENT 'STR-defined chain scale classification for this hierarchy node, indicating the service and price tier of properties within this node. Used for competitive benchmarking, STR STAR Report alignment, and brand portfolio segmentation. Values align with STRs standard chain scale categories.. Valid values are `luxury|upper_upscale|upscale|upper_midscale|midscale|economy`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the geographic location of this hierarchy node (e.g., USA, GBR, SGP). Applicable primarily to property and cluster nodes. Used for regulatory compliance reporting, tax jurisdiction mapping, and geographic analytics.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy node record was first created in the system, in ISO 8601 format with timezone offset. Supports audit trail, data lineage tracking, and SOX compliance for financial reporting hierarchy changes.',
    `effective_from` DATE COMMENT 'Date from which this hierarchy node and its parent-child relationship became operationally effective. Used for point-in-time hierarchy reconstruction and historical reporting aligned with management reporting periods.',
    `effective_until` DATE COMMENT 'Date on which this hierarchy node or its parent-child relationship ceases to be effective. Null for currently active nodes. Supports temporal hierarchy versioning for historical consolidated reporting and audit compliance.',
    `fiscal_year_start_month` STRING COMMENT 'Month number (1-12) indicating the start of the fiscal year for this hierarchy node. Supports USALI-aligned financial period reporting and SAP S/4HANA fiscal year variant configuration for nodes that operate on non-calendar fiscal years.',
    `gds_chain_code` STRING COMMENT 'Chain code used to identify this portfolio or brand in Global Distribution Systems (GDS) such as Amadeus, Sabre, and Travelport. Applicable to corporate and brand-level hierarchy nodes. Supports channel distribution management and GDS booking analytics.. Valid values are `^[A-Z]{2,6}$`',
    `geographic_region` STRING COMMENT 'Major geographic region classification for this hierarchy node, aligned with STR geographic hierarchy and internal management reporting structures. Used for regional KPI roll-ups and competitive benchmarking via STR STAR Reports. [ENUM-REF-CANDIDATE: Americas|EMEA|APAC|GREATER_CHINA|MEA|EUROPE|NORTH_AMERICA|LATIN_AMERICA — 8 candidates stripped; promote to reference product]',
    `is_reporting_node` BOOLEAN COMMENT 'Indicates whether this hierarchy node is designated as a formal reporting node for consolidated KPI roll-ups (RevPAR, ADR, OCC, GOP). True for nodes that appear in management reporting packages; False for intermediate structural nodes used only for hierarchy traversal.',
    `is_str_market_node` BOOLEAN COMMENT 'Indicates whether this hierarchy node corresponds to a defined STR competitive market for benchmarking purposes. True for nodes that are directly mapped to an STR market for RGI, MPI, and ARI reporting via STR STAR Reports.',
    `kpi_rollup_method` STRING COMMENT 'Method used to aggregate KPIs (RevPAR, ADR, OCC, GOP) from child nodes to this parent node. sum for absolute metrics (room revenue, GOP); weighted_average for rate-based metrics (ADR, RevPAR) weighted by available rooms; simple_average for index metrics; none for leaf nodes with no children.. Valid values are `sum|weighted_average|simple_average|none`',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this node within the organizational hierarchy tree, starting at 1 for the corporate root. Enables efficient tree traversal, level-based filtering, and KPI aggregation at each tier (e.g., Level 1 = Corporate, Level 2 = Region, Level 3 = Division, Level 4 = Area Office, Level 5 = Cluster, Level 6 = Property).',
    `management_type` STRING COMMENT 'Operational management structure classification for this hierarchy node. owned indicates company-owned assets; managed indicates third-party owner with management contract; franchised indicates franchise agreement; leased indicates leasehold arrangement; joint_venture indicates shared ownership structure. Critical for financial consolidation and USALI reporting.. Valid values are `owned|managed|franchised|leased|joint_venture`',
    `node_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this hierarchy node across systems (e.g., CRS, PMS, ERP). Used as the business key for cross-system integration and reporting roll-ups. Aligns with SAP S/4HANA profit center codes and Oracle OPERA PMS property codes.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `node_description` STRING COMMENT 'Free-text description providing additional context about this hierarchy node, including its geographic scope, strategic purpose, or operational characteristics. Used for documentation, onboarding, and BI tool tooltips.',
    `node_name` STRING COMMENT 'Human-readable name of the hierarchy node (e.g., Americas Region, EMEA Division, Southeast Asia Cluster, Grand Hyatt New York). Used in management reporting, dashboards, and consolidated KPI roll-ups.',
    `node_status` STRING COMMENT 'Current lifecycle status of the hierarchy node. active indicates the node is operational and included in reporting; inactive indicates it has been decommissioned; pending indicates a newly created node awaiting activation; dissolved indicates a node that has been merged or restructured out of the hierarchy.. Valid values are `active|inactive|pending|dissolved`',
    `node_type` STRING COMMENT 'Classification of the hierarchy node indicating its organizational level. corporate is the top-level portfolio node; region represents major geographic divisions (Americas, EMEA, APAC); division is a sub-regional grouping; area_office is a local management unit; cluster is a grouping of nearby properties; property is an individual hotel or resort asset.. Valid values are `corporate|region|division|area_office|cluster|property`',
    `path` STRING COMMENT 'Materialized full path string from the root node to this node using delimiter-separated node codes (e.g., CORP/AMER/USEAST/NYC-CLUSTER). Enables efficient subtree queries and breadcrumb navigation in BI tools without recursive joins.',
    `property_count` STRING COMMENT 'Number of individual property assets directly or indirectly under this hierarchy node. Maintained as a denormalized count for reporting efficiency. Applicable to corporate, region, division, area office, and cluster nodes. Used in portfolio-level KPI reporting and capacity planning.',
    `reporting_segment_code` STRING COMMENT 'Internal financial reporting segment code assigned to this hierarchy node, aligned with SAP S/4HANA profit center and segment reporting structures. Used for USALI-compliant financial consolidation, EBITDA and NOI reporting, and SOX-compliant segment disclosures.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `responsible_executive` STRING COMMENT 'Name of the senior executive accountable for this hierarchy node (e.g., Regional Vice President, Area General Manager, General Manager). Used for management reporting accountability, escalation routing, and organizational governance.',
    `responsible_executive_email` STRING COMMENT 'Corporate email address of the executive accountable for this hierarchy node. Used for automated reporting distribution, escalation notifications, and governance communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_executive_title` STRING COMMENT 'Official job title of the executive accountable for this hierarchy node (e.g., Senior Vice President - Americas, Area General Manager - Southeast Asia). Supports organizational chart generation and governance documentation.',
    `restructure_reason` STRING COMMENT 'Free-text description of the business reason for any hierarchy restructuring event affecting this node (e.g., regional reorganization, brand portfolio realignment, merger, acquisition, or divestiture). Supports audit trail and change management documentation.',
    `sap_profit_center_code` STRING COMMENT 'SAP S/4HANA profit center code mapped to this hierarchy node for financial consolidation, USALI-aligned P&L reporting, and management accounting. Enables direct linkage between the property hierarchy and SAP financial reporting structures for EBITDA, NOI, and GOPPAR analysis.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `sort_order` STRING COMMENT 'Numeric display order for this node among its siblings within the same parent node. Controls the sequence in which nodes appear in management reports, dashboards, and organizational charts. Lower values appear first.',
    `str_geographic_code` STRING COMMENT 'STR-assigned geographic market code for this hierarchy node, used to align internal organizational hierarchy with STR competitive benchmarking markets. Enables direct mapping to STR STAR Report data for Revenue Generation Index (RGI), Market Penetration Index (MPI), and Average Rate Index (ARI) benchmarking.. Valid values are `^[A-Z0-9]{2,15}$`',
    `str_market_name` STRING COMMENT 'Human-readable STR market name corresponding to the STR geographic code (e.g., New York City, London, Singapore). Used in competitive benchmarking reports and STR STAR Report alignment for RevPAR and ADR market comparisons.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the primary geographic location of this hierarchy node (e.g., America/New_York, Europe/London, Asia/Singapore). Used for scheduling, reporting period alignment, and operational communications across multi-property portfolios.',
    `total_room_count` STRING COMMENT 'Aggregate number of guestrooms across all properties under this hierarchy node. Used for portfolio-level RevPAR and OCC calculations, capacity planning, and STR competitive set benchmarking. Maintained as a denormalized aggregate for reporting performance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this hierarchy node record, in ISO 8601 format with timezone offset. Used for incremental data pipeline processing, change detection, and audit compliance.',
    `version_number` STRING COMMENT 'Sequential version number for this hierarchy node record, incremented each time the nodes attributes or parent-child relationship is modified. Supports temporal versioning, audit compliance, and point-in-time hierarchy reconstruction for historical reporting.',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Defines the organizational and operational hierarchy of properties including corporate portfolio, regional divisions (e.g., Americas, EMEA, APAC), area offices, and property clusters. Captures parent-child relationships with hierarchy level, node name, node code, responsible executive, and effective date. Supports multi-property consolidated reporting with KPI roll-ups (RevPAR, ADR, OCC, GOP) across geographic and organizational tiers. Aligned with STR geographic hierarchy and internal management reporting structures.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` (
    `property_facility_id` BIGINT COMMENT 'Unique surrogate identifier for each physical facility or amenity record within the property domain. Primary key for the facility data product.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each facility usage fee is denominated in ONE currency. Normalize currency reference to master currency table. Remove currency_code string - will be retrieved via JOIN.',
    `property_id` BIGINT COMMENT 'Reference to the parent property at which this facility is located. Links the facility to its owning hotel or resort asset in the property master.',
    `property_outlet_id` BIGINT COMMENT 'Foreign key linking to property.property_outlet. Business justification: A facility CAN be associated with a revenue-generating outlet (e.g., restaurant facility linked to restaurant outlet). This FK will be nullable - not all facilities are outlets (e.g., pool, gym). Remo',
    `ada_features` STRING COMMENT 'Descriptive text listing specific ADA-compliant accessibility features available at the facility (e.g., Wheelchair ramp, pool lift, accessible restroom, braille signage). Supports guest accessibility requests and ADA compliance audit documentation.',
    `age_restriction` STRING COMMENT 'Age-based access restriction for the facility. Adults_only applies to facilities such as adult pools, bars, and certain spa areas; minimum_age values apply to facilities with safety or legal age requirements. Used for guest communication, liability management, and regulatory compliance.. Valid values are `none|adults_only|minimum_age_18|minimum_age_16|children_only`',
    `area_sqft` DECIMAL(18,2) COMMENT 'Total floor area of the facility measured in square feet. Used for event space marketing, FF&E (Furniture Fixtures and Equipment) planning, CapEx budgeting, and PIP documentation. Meeting and event spaces use this for per-square-foot revenue analysis.',
    `av_equipment_available` BOOLEAN COMMENT 'Indicates whether built-in audio-visual equipment (projectors, screens, microphones, video conferencing systems) is available in the facility. Primarily relevant for meeting rooms, ballrooms, and business centers. Used in MICE (Meetings Incentives Conferences Exhibitions) event sales and BEO configuration.',
    `building_wing` STRING COMMENT 'Named wing, tower, or zone of the property building where the facility is physically located (e.g., North Tower, Pool Deck, Conference Level). Supports wayfinding, housekeeping scheduling, and multi-building resort navigation.',
    `capacity` STRING COMMENT 'Maximum number of guests or persons the facility can accommodate simultaneously under normal operating conditions. For meeting rooms this is the maximum seating capacity; for pools it is the maximum bather load; for restaurants it is the total cover count. Used in event sales, operational scheduling, and safety compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the facility record was first created in the system (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for data lineage and compliance with SOX financial controls and GDPR data management requirements.',
    `property_facility_description` STRING COMMENT 'Long-form marketing and operational description of the facility for use in guest-facing channels, OTA listings, and property websites. Describes the facilitys features, ambiance, services offered, and unique selling points. Managed in Sabre SynXis CRS for channel distribution.',
    `dress_code` STRING COMMENT 'Required dress code for guests accessing the facility. Relevant for restaurants, bars, spas, and pool areas. Used in guest-facing amenity descriptions and front desk communication to set expectations and enforce property standards.. Valid values are `none|smart_casual|formal|resort_casual|swimwear_only`',
    `facility_category` STRING COMMENT 'High-level grouping of the facility into a business category for reporting and guest-facing amenity segmentation. Recreation covers pools, gyms, and sports; food_beverage covers restaurants and bars; meetings_events covers ballrooms and conference rooms; wellness covers spas and health centers; business_services covers business centers; transportation covers parking and valet. [ENUM-REF-CANDIDATE: recreation|food_beverage|meetings_events|wellness|business_services|transportation|retail|other — 8 candidates stripped; promote to reference product]',
    `facility_code` STRING COMMENT 'Externally-known alphanumeric code that uniquely identifies the facility within the property management and channel distribution systems (e.g., POOL-01, SPA-MAIN, GYM-24H). Used in OTA feeds, PMS configuration, and guest-facing amenity display.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `facility_name` STRING COMMENT 'Human-readable display name of the facility as presented to guests and staff (e.g., Infinity Pool, The Serenity Spa, Grand Ballroom). Used in guest-facing amenity listings, housekeeping schedules, and event coordination.',
    `facility_type` STRING COMMENT 'Categorical classification of the facility by its primary function (e.g., pool, spa, fitness_center, restaurant, bar, meeting_room, ballroom, business_center, parking, recreational_area, retail_outlet). Drives amenity display grouping, operational scheduling, and ADA compliance tracking. [ENUM-REF-CANDIDATE: pool|spa|fitness_center|restaurant|bar|meeting_room|ballroom|business_center|parking|recreational_area|retail_outlet|lounge — promote to reference product]',
    `floor_number` STRING COMMENT 'Floor level within the property building where the facility is located. Used for wayfinding, housekeeping zone assignment, and emergency evacuation planning. Negative values indicate below-grade levels (e.g., basement parking).',
    `inspection_result` STRING COMMENT 'Outcome of the most recent regulatory or safety inspection for this facility. Pass indicates full compliance; pass_with_conditions indicates compliance with minor corrective actions required; fail indicates non-compliance requiring closure or remediation; pending indicates inspection scheduled but not yet completed.. Valid values are `pass|pass_with_conditions|fail|pending`',
    `is_24_hour` BOOLEAN COMMENT 'Indicates whether the facility operates continuously 24 hours per day without a defined closing time (e.g., fitness centers, parking structures, business centers). When True, operating_hours_open and operating_hours_close are informational only.',
    `is_ada_compliant` BOOLEAN COMMENT 'Indicates whether the facility meets ADA (Americans with Disabilities Act) accessibility requirements including wheelchair access, accessible entrances, accessible restrooms, and assistive equipment. Critical for regulatory compliance reporting and guest accessibility communication.',
    `is_fee_based` BOOLEAN COMMENT 'Indicates whether the facility charges a separate usage fee beyond the room rate (e.g., resort fee, spa access fee, parking fee). When True, the associated outlet_code links to POS revenue tracking.',
    `is_reservation_required` BOOLEAN COMMENT 'Indicates whether guests must make a prior reservation to use the facility (e.g., spa treatment rooms, cabanas, private dining rooms). Drives guest-facing booking prompts and operational capacity management.',
    `is_seasonal` BOOLEAN COMMENT 'Indicates whether the facility is only available during specific seasons of the year (e.g., outdoor pools, ski facilities, beach clubs). When True, seasonal_open_date and seasonal_close_date define the operational window.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or safety inspection conducted for this facility (yyyy-MM-dd). Covers health department inspections for F&B outlets, pool safety inspections, fire safety checks, and ADA compliance audits. Supports regulatory compliance tracking.',
    `license_expiry_date` DATE COMMENT 'Expiration date of the facilitys operating license or permit (yyyy-MM-dd). Triggers renewal workflows to ensure continuous regulatory compliance. Critical for F&B outlets, spas, and pool facilities subject to periodic licensing.',
    `license_number` STRING COMMENT 'Government-issued operating license or permit number for regulated facilities such as restaurants (food service license), bars (liquor license), spas (cosmetology license), and pools (health department permit). Required for regulatory compliance documentation.',
    `max_occupancy_pct` DECIMAL(18,2) COMMENT 'Regulatory or operational maximum occupancy threshold expressed as a percentage of total capacity (e.g., 80.00 means 80% of capacity). Used for fire safety compliance, COVID-era capacity restrictions, and operational safety management.',
    `natural_light` BOOLEAN COMMENT 'Indicates whether the facility has access to natural daylight through windows or skylights. A key selling attribute for meeting and event spaces, as natural light is a premium feature in MICE sales. Also relevant for wellness facilities and restaurants.',
    `next_inspection_date` DATE COMMENT 'Date of the next scheduled regulatory or safety inspection for this facility (yyyy-MM-dd). Used for compliance calendar management and proactive maintenance scheduling to ensure facilities pass inspections without operational disruption.',
    `operating_hours_close` STRING COMMENT 'Standard daily closing time of the facility in HH:MM (24-hour) format. For facilities operating past midnight, this may be 23:59 with a separate overnight flag. Used alongside operating_hours_open for guest-facing display and staffing.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `operating_hours_open` STRING COMMENT 'Standard daily opening time of the facility in HH:MM (24-hour) format. Used for guest-facing amenity display, operational staffing schedules, and housekeeping preparation windows. For 24-hour facilities, set to 00:00.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `outdoor_indoor` STRING COMMENT 'Indicates whether the facility is located indoors, outdoors, or in a semi-outdoor (covered but open-air) environment. Affects seasonal availability, weather contingency planning for events, and guest-facing amenity descriptions.. Valid values are `indoor|outdoor|semi_outdoor`',
    `property_facility_status` STRING COMMENT 'Current lifecycle status of the facility indicating its operational availability. Active means fully operational; seasonal means available only during defined seasonal periods; under_renovation means temporarily closed for PIP (Property Improvement Plan) works; closed means permanently decommissioned; pending_opening means approved but not yet operational.. Valid values are `active|inactive|seasonal|under_renovation|closed|pending_opening`',
    `renovation_end_date` DATE COMMENT 'Planned or actual completion date of the most recent or current PIP (Property Improvement Plan) renovation for this facility (yyyy-MM-dd). Used for return-to-service planning, guest communication, and CapEx project closure.',
    `renovation_start_date` DATE COMMENT 'Planned or actual start date of the most recent or current PIP (Property Improvement Plan) renovation for this facility (yyyy-MM-dd). Used for operational impact planning, guest communication, and CapEx project tracking in SAP S/4HANA.',
    `renovation_status` STRING COMMENT 'Current PIP (Property Improvement Plan) renovation status of the facility. Planned indicates approved but not yet started; in_progress indicates active construction or refurbishment; completed indicates renovation finished and facility returned to service. Supports CapEx tracking and operational impact planning.. Valid values are `not_scheduled|planned|in_progress|completed`',
    `seasonal_close_date` DATE COMMENT 'Calendar date on which a seasonal facility closes at the end of the season (yyyy-MM-dd). Applicable only when is_seasonal is True. Used for operational planning and guest communication regarding amenity availability.',
    `seasonal_open_date` DATE COMMENT 'Calendar date on which a seasonal facility opens for the current or upcoming season (yyyy-MM-dd). Applicable only when is_seasonal is True. Used for operational planning, guest-facing amenity availability display, and housekeeping preparation scheduling.',
    `seating_configuration` STRING COMMENT 'Default or primary seating arrangement style for the facility, particularly relevant for meeting rooms and event spaces. Theater style is rows facing a stage; banquet is round tables; boardroom is a single conference table. Used in BEO (Banquet Event Order) management and event sales in Delphi by Amadeus. [ENUM-REF-CANDIDATE: theater|classroom|banquet|reception|boardroom|u_shape|cabaret|open_plan|not_applicable — 9 candidates stripped; promote to reference product]',
    `smoking_policy` STRING COMMENT 'Smoking policy applicable to this specific facility. Non_smoking indicates a fully smoke-free environment; smoking_permitted indicates smoking is allowed; designated_area indicates a specific smoking zone exists within the facility. Supports guest communication and regulatory compliance.. Valid values are `non_smoking|smoking_permitted|designated_area`',
    `sort_order` STRING COMMENT 'Numeric sequence controlling the display order of facilities within a category on guest-facing amenity listings and property websites. Lower numbers appear first. Managed by property marketing teams to prioritize premium or signature facilities.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the facility record was most recently modified (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC) in ETL pipelines, data lineage tracking, and audit compliance under SOX and GDPR.',
    `usage_fee_amount` DECIMAL(18,2) COMMENT 'Standard per-use or per-day fee charged to guests for accessing the facility, expressed in the propertys local currency. Applicable only when is_fee_based is True. Used for revenue forecasting and guest billing configuration in PMS.',
    CONSTRAINT pk_property_facility PRIMARY KEY(`property_facility_id`)
) COMMENT 'Catalog of physical facilities and amenities available at each property, including pools, spas, fitness centers, business centers, parking structures, restaurants, bars, meeting spaces, and recreational areas. Captures facility name, facility type, capacity, operating hours, accessibility (ADA compliance), seasonal availability, renovation status, and associated outlet codes. Supports guest-facing amenity display and operational scheduling.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` (
    `franchise_agreement_id` BIGINT COMMENT 'Unique surrogate identifier for the franchise or management contract agreement record in the property domain. Primary key for this entity. Role: MASTER_AGREEMENT.',
    `channel_contract_id` BIGINT COMMENT 'Foreign key linking to channel.channel_contract. Business justification: Franchise compliance audits require linking franchise agreements to the channel contracts they mandate (e.g., required GDS participation, approved OTA contracts). Brand standards enforcement and franc',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each franchise agreement is denominated in ONE currency. Normalize currency reference to master currency table. Remove currency_code string - will be retrieved via JOIN.',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property governed by this franchise or management contract agreement.',
    `agreement_number` STRING COMMENT 'Externally-known, human-readable contract reference number assigned by the franchisor or legal department. Used for cross-referencing with SAP S/4HANA contract management and legal document repositories. Serves as the BUSINESS_IDENTIFIER for this MASTER_AGREEMENT entity.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the franchise or management contract agreement. Active: agreement is in force. Pending: executed but effective date not yet reached. Expired: term ended without renewal. Terminated: early termination invoked. Suspended: temporarily inactive due to breach or force majeure. Under_Renewal: renewal negotiation in progress. Serves as LIFECYCLE_STATUS for this MASTER_AGREEMENT entity.. Valid values are `active|pending|expired|terminated|suspended|under_renewal`',
    `agreement_type` STRING COMMENT 'Classification of the contractual relationship governing the propertys brand affiliation and operational model. Franchise: brand license with owner-operated management. Management Contract: brand operates the property on behalf of owner. Lease: brand leases the physical asset. Owner-Operated: independent ownership and operation. License: limited brand usage rights. Serves as CLASSIFICATION_OR_TYPE for this MASTER_AGREEMENT entity.. Valid values are `franchise|management_contract|lease|owner_operated|license`',
    `brand_code` STRING COMMENT 'Standardized brand identifier code assigned by the franchisor representing the hotel brand under which the property operates (e.g., HH for Hilton Hotels, MC for Marriott Courtyard). Aligns with Sabre SynXis CRS brand configuration and STR benchmarking brand classification.',
    `brand_segment` STRING COMMENT 'Market segment classification of the brand under which the property operates per STR chain scale segmentation. Drives competitive benchmarking, RevPAR analysis, and STR STAR Report peer group assignment.. Valid values are `luxury|upper_upscale|upscale|upper_midscale|midscale|economy`',
    `brand_standard_version` STRING COMMENT 'Version identifier of the franchisors brand standards manual applicable to this agreement at time of execution. Brand standards govern FF&E specifications, service delivery, guest experience requirements, and quality assurance audit criteria.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this franchise agreement record was first created in the data platform. Supports data lineage, audit trail, and GDPR data processing records. Serves as RECORD_AUDIT_CREATED for this MASTER_AGREEMENT entity.',
    `crs_connectivity_required` BOOLEAN COMMENT 'Indicates whether the agreement mandates connectivity to the franchisors CRS (Central Reservation System) for rate and inventory distribution. Aligns with Sabre SynXis CRS integration requirements.',
    `effective_date` DATE COMMENT 'Date on which the franchise or management contract agreement becomes legally binding and operational. Serves as EFFECTIVE_FROM for this MASTER_AGREEMENT entity. Used for portfolio governance, brand compliance tracking, and financial reporting under USALI.',
    `exclusive_territory` BOOLEAN COMMENT 'Indicates whether the agreement grants the franchisee an exclusive geographic territory within which the franchisor agrees not to license competing properties under the same brand. Impacts competitive set analysis and new property development decisions.',
    `executed_date` DATE COMMENT 'Date on which the franchise or management contract agreement was fully executed (signed by all parties). May differ from effective_date if there is a gap between signing and commencement. Used for legal document management and audit trails.',
    `expiration_date` DATE COMMENT 'Date on which the franchise or management contract agreement is scheduled to expire if not renewed. Nullable for open-ended agreements. Serves as EFFECTIVE_UNTIL for this MASTER_AGREEMENT entity. Critical for portfolio renewal pipeline management.',
    `fdd_registration_number` STRING COMMENT 'Registration number of the Franchise Disclosure Document (FDD) filed with applicable state regulatory authorities. Required in registration states under the FTC Franchise Rule and state franchise laws. Supports regulatory compliance tracking.',
    `ff_and_e_reserve_pct` DECIMAL(18,2) COMMENT 'Percentage of gross revenue required to be set aside in a FF&E (Furniture, Fixtures and Equipment) reserve fund for ongoing property maintenance and capital replacement. Mandated under most franchise and management contract agreements per USALI standards.',
    `franchisee_entity_name` STRING COMMENT 'Legal name of the franchisee or property owner entity entering into the franchise or management contract agreement. Used for ownership structure tracking, portfolio governance, and SAP S/4HANA vendor/partner master alignment.',
    `governing_law_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction whose laws govern the interpretation and enforcement of this agreement. Critical for cross-border portfolio legal compliance and dispute resolution.. Valid values are `^[A-Z]{3}$`',
    `governing_law_state` STRING COMMENT 'State or province within the governing law country whose laws apply to this agreement. Relevant for US-based agreements where state franchise disclosure laws (FDD requirements) apply.',
    `initial_term_years` STRING COMMENT 'Duration in years of the initial franchise or management contract term as specified in the agreement. Typically ranges from 10 to 30 years for franchise agreements. Used for portfolio lifecycle planning and IFRS 16 lease accounting where applicable.',
    `last_brand_audit_date` DATE COMMENT 'Date of the most recent brand standards quality assurance audit conducted by the franchisor at this property. Used to track compliance status and schedule next audit cycle per agreement requirements.',
    `liquidated_damages_amount` DECIMAL(18,2) COMMENT 'Pre-agreed liquidated damages amount payable upon early termination of the agreement by the franchisee or property owner. Expressed in agreement currency. Critical for portfolio risk assessment and financial exposure reporting under SOX.',
    `loyalty_fee_pct` DECIMAL(18,2) COMMENT 'Percentage of revenue from loyalty member stays payable to the franchisor for loyalty program administration, points redemption funding, and member benefits. Tracked in Salesforce CRM loyalty management and SAP S/4HANA.',
    `management_fee_base_pct` DECIMAL(18,2) COMMENT 'Base management fee as a percentage of total gross revenue payable to the management company under a management contract agreement. Applicable only when agreement_type is management_contract. Reported under USALI management fee accounting.',
    `management_fee_incentive_pct` DECIMAL(18,2) COMMENT 'Incentive management fee as a percentage of GOP (Gross Operating Profit) or NOI (Net Operating Income) payable to the management company when performance thresholds are exceeded. Applicable for management contract agreements. Aligns with USALI GOP reporting.',
    `marketing_fee_pct` DECIMAL(18,2) COMMENT 'Percentage of gross room revenue payable to the franchisors brand marketing fund. Covers national and global advertising, loyalty program marketing, and brand awareness campaigns. Reported under USALI franchise cost accounting.',
    `next_brand_audit_date` DATE COMMENT 'Scheduled date for the next brand standards quality assurance audit. Supports proactive compliance management and operational readiness planning.',
    `pip_budget_amount` DECIMAL(18,2) COMMENT 'Total approved CapEx (Capital Expenditure) budget for PIP (Property Improvement Plan) obligations under this agreement, expressed in the agreement currency. Tracked in SAP S/4HANA asset management and reported under USALI FF&E accounting.',
    `pip_completion_date` DATE COMMENT 'Contractually required completion date for all PIP (Property Improvement Plan) obligations specified in the franchise or management contract agreement. Null if pip_required is false. Tracks CapEx compliance milestones.',
    `pip_required` BOOLEAN COMMENT 'Indicates whether a PIP (Property Improvement Plan) is mandated as a condition of this franchise or management contract agreement. PIP obligations are typically triggered at agreement signing, renewal, or brand standard compliance review.',
    `pms_system_required` STRING COMMENT 'Name or code of the Property Management System (PMS) mandated by the franchisor as a brand standard technology requirement under this agreement (e.g., Oracle OPERA PMS). Supports technology compliance tracking and integration planning.',
    `quality_assurance_score_min` DECIMAL(18,2) COMMENT 'Minimum quality assurance (QA) inspection score the property must maintain to remain in compliance with brand standards under this agreement. Failure to meet this threshold may trigger a cure period or termination clause.',
    `renewal_notice_days` STRING COMMENT 'Number of days advance written notice required by the franchisee to exercise a renewal option before the agreement expiration date. Supports portfolio renewal pipeline management and prevents inadvertent agreement lapse.',
    `renewal_option_count` STRING COMMENT 'Number of renewal option periods available to the franchisee or property owner upon expiration of the initial term. Supports portfolio renewal pipeline management and long-term asset planning.',
    `renewal_term_years` STRING COMMENT 'Duration in years of each renewal option period as specified in the agreement. Combined with renewal_option_count to determine maximum potential agreement duration for portfolio planning.',
    `reservation_fee_pct` DECIMAL(18,2) COMMENT 'Percentage of gross room revenue or per-reservation fee payable to the franchisor for CRS (Central Reservation System) and GDS (Global Distribution System) distribution services. Aligns with Sabre SynXis CRS fee structures.',
    `royalty_fee_pct` DECIMAL(18,2) COMMENT 'Percentage of gross room revenue payable to the franchisor as a royalty fee under the franchise agreement. Expressed as a decimal (e.g., 0.0500 = 5.00%). Core financial obligation tracked in SAP S/4HANA AP and reported under USALI franchise cost accounting.',
    `termination_date` DATE COMMENT 'Actual date on which the agreement was terminated, if applicable. Null for active or pending agreements. Distinct from expiration_date (scheduled end) — this captures early or involuntary termination events.',
    `termination_notice_days` STRING COMMENT 'Number of days advance written notice required by either party to invoke termination of the agreement without cause. Supports legal compliance tracking and portfolio risk management.',
    `termination_reason` STRING COMMENT 'Reason code for agreement termination. Used for portfolio analytics, brand exit tracking, and regulatory reporting. [ENUM-REF-CANDIDATE: mutual_agreement|franchisee_default|franchisor_default|brand_exit|sale_of_property|force_majeure|non_renewal — promote to reference product if additional values are needed]',
    `territory_description` STRING COMMENT 'Textual description of the exclusive or protected geographic territory granted under this agreement, if applicable. May reference radius in miles/kilometers, zip codes, or defined market boundaries. Null if exclusive_territory is false.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this franchise agreement record was last modified in the data platform. Supports change data capture, data lineage, and audit compliance.',
    CONSTRAINT pk_franchise_agreement PRIMARY KEY(`franchise_agreement_id`)
) COMMENT 'Records of franchise and management contract agreements governing each propertys brand affiliation and operational model. Captures franchisor entity, franchisee entity, agreement type (franchise, management contract, lease, owner-operated), effective date, expiration date, renewal terms, royalty fee structure, PIP obligations, brand standard compliance requirements, and termination clauses. Supports portfolio governance and brand compliance management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` (
    `meeting_space_id` BIGINT COMMENT 'Unique identifier for the meeting space. Primary key.',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Meeting space catering assignment: hotels designate a specific F&B outlet to handle catering for each meeting space. Event managers and banquet coordinators need this link to route catering orders, en',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.property_facility. Business justification: Meeting spaces are a specialized category of property facility. Linking meeting_space to property_facility via property_facility_id allows unified facility management, cross-referencing of operational',
    `property_id` BIGINT COMMENT 'Reference to the property where this meeting space is located.',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the meeting space meets ADA (Americans with Disabilities Act) accessibility requirements including wheelchair access, accessible restrooms, and assistive listening systems.',
    `adjacent_prefunction_space` BOOLEAN COMMENT 'Indicates whether the meeting space has an adjacent pre-function or foyer area for registration, breaks, or networking.',
    `blackout_capability` BOOLEAN COMMENT 'Indicates whether the space can be fully darkened using blackout curtains or shades. Critical for presentations and AV-heavy events.',
    `builtin_av_equipment` STRING COMMENT 'Description of permanently installed AV equipment in the space (e.g., projector, screen, sound system, microphones, video conferencing). Comma-separated list.',
    `capacity_banquet` STRING COMMENT 'Maximum number of attendees the space can accommodate in banquet-style seating (round tables with 8-10 guests per table).',
    `capacity_classroom` STRING COMMENT 'Maximum number of attendees the space can accommodate in classroom-style seating (rows of tables and chairs facing front).',
    `capacity_hollow_square` STRING COMMENT 'Maximum number of attendees the space can accommodate in hollow square configuration (tables arranged in square with open center).',
    `capacity_reception` STRING COMMENT 'Maximum number of attendees the space can accommodate for standing reception or cocktail-style events.',
    `capacity_theater` STRING COMMENT 'Maximum number of attendees the space can accommodate in theater-style seating (rows of chairs facing front).',
    `capacity_u_shape` STRING COMMENT 'Maximum number of attendees the space can accommodate in U-shape seating configuration (tables arranged in U formation).',
    `catering_required` BOOLEAN COMMENT 'Indicates whether food and beverage (F&B) catering is mandatory when booking this space. Common for ballrooms and premium spaces.',
    `ceiling_height_feet` DECIMAL(18,2) COMMENT 'Height of the ceiling measured in feet. Important for AV equipment setup, lighting design, and event atmosphere.',
    `climate_control_type` STRING COMMENT 'Type of heating, ventilation, and air conditioning (HVAC) control available (individual thermostat, shared zone control, or none).. Valid values are `individual|shared|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this meeting space record was first created in the system. Part of audit trail.',
    `dedicated_wifi_bandwidth_mbps` STRING COMMENT 'Dedicated internet bandwidth available for the meeting space measured in Mbps. Null if shared bandwidth or not applicable.',
    `divisible` BOOLEAN COMMENT 'Indicates whether the meeting space can be partitioned into smaller sections using airwalls or movable partitions. Enables flexible space utilization.',
    `emergency_exit_count` STRING COMMENT 'Number of emergency exits available in the meeting space. Required for fire safety compliance and event planning.',
    `entrance_width_inches` DECIMAL(18,2) COMMENT 'Width of the main entrance door measured in inches. Important for accessibility compliance and equipment load-in.',
    `fire_capacity_limit` STRING COMMENT 'Maximum occupancy allowed by local fire safety codes and building regulations. Must not be exceeded regardless of setup style.',
    `floor_level` STRING COMMENT 'Physical floor or level where the meeting space is located within the property (e.g., Ground Floor, Mezzanine, 2nd Floor, Rooftop).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this meeting space record was last updated. Part of audit trail for change tracking.',
    `last_renovation_date` DATE COMMENT 'Date when the meeting space last underwent renovation or significant refurbishment. Part of PIP (Property Improvement Plan) tracking.',
    `loading_dock_access` BOOLEAN COMMENT 'Indicates whether the meeting space has direct or convenient access to a loading dock for equipment and material delivery.',
    `meeting_space_status` STRING COMMENT 'Current operational status of the meeting space. Determines availability for booking and event planning.. Valid values are `active|inactive|under_renovation|temporarily_closed`',
    `minimum_catering_spend` DECIMAL(18,2) COMMENT 'Minimum food and beverage spend required when booking this space. Null if no minimum or catering not required.',
    `minimum_rental_hours` DECIMAL(18,2) COMMENT 'Minimum number of hours the space must be rented for a single event. Used for revenue management and booking policies.',
    `natural_light_available` BOOLEAN COMMENT 'Indicates whether the meeting space has windows or skylights providing natural daylight. Important for guest experience and event ambiance.',
    `number_of_sections` STRING COMMENT 'Number of separate sections the space can be divided into when partitions are deployed. Null if space is not divisible.',
    `rental_rate_tier` STRING COMMENT 'Pricing tier classification for the meeting space rental. Actual rates are managed in rate tables and vary by season, day of week, and booking terms.. Valid values are `premium|standard|value|complimentary`',
    `space_code` STRING COMMENT 'Unique alphanumeric code identifying the meeting space within the property. Used in PMS and event management systems for booking and BEO (Banquet Event Order) references.. Valid values are `^[A-Z0-9]{2,20}$`',
    `space_name` STRING COMMENT 'Full descriptive name of the meeting space as displayed to guests and event planners (e.g., Grand Ballroom, Executive Boardroom, Terrace Garden).',
    `space_type` STRING COMMENT 'Classification of the meeting space by functional type. Determines suitability for different event formats and MICE (Meetings Incentives Conferences Exhibitions) requirements. [ENUM-REF-CANDIDATE: ballroom|boardroom|breakout_room|conference_room|meeting_room|outdoor_terrace|pre_function_space — 7 candidates stripped; promote to reference product]',
    `total_square_footage` DECIMAL(18,2) COMMENT 'Total area of the meeting space measured in square feet. Critical for capacity planning and event layout design.',
    `wifi_available` BOOLEAN COMMENT 'Indicates whether wireless internet connectivity is available in the meeting space. Essential for modern business events.',
    CONSTRAINT pk_meeting_space PRIMARY KEY(`meeting_space_id`)
) COMMENT 'Master catalog of meeting, conference, and event spaces within each property. Captures space name, space code, space type (ballroom, boardroom, breakout room, outdoor terrace), total square footage, ceiling height, maximum capacity by setup style (theater, classroom, banquet, reception, U-shape), natural light availability, AV equipment inventory, divisibility (whether space can be partitioned), and rental rate tier. Feeds the event domain for MICE sales and BEO management via Delphi by Amadeus.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` (
    `property_outlet_id` BIGINT COMMENT 'Unique identifier for the property outlet. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each outlet prices in ONE currency (average_check_amount). Normalize currency reference to master currency table. Remove currency_code string - will be retrieved via JOIN.',
    `property_id` BIGINT COMMENT 'Identifier of the property where this outlet is located. Links to the property master data.',
    `alcohol_service_flag` BOOLEAN COMMENT 'Indicates whether the outlet is licensed to serve alcoholic beverages. True if alcohol service is permitted.',
    `average_check_amount` DECIMAL(18,2) COMMENT 'Average guest check amount for the outlet. Used for revenue forecasting and performance benchmarking. Expressed in property base currency.',
    `closure_date` DATE COMMENT 'Date when the outlet was permanently closed. Null if the outlet is still operational or temporarily closed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this outlet record was first created in the system. Used for audit trail and data lineage.',
    `cuisine_type` STRING COMMENT 'The primary cuisine or culinary style offered by the outlet. Applicable to Food and Beverage (F&B) outlets. Examples: Italian, Asian Fusion, Steakhouse, Mediterranean, International.',
    `delivery_service_available_flag` BOOLEAN COMMENT 'Indicates whether the outlet offers delivery service to guest rooms or external locations. True if delivery is available.',
    `dress_code` STRING COMMENT 'Dress code policy enforced at the outlet. Communicates guest attire expectations and supports brand positioning.. Valid values are `casual|smart_casual|business_casual|formal|resort_casual|no_dress_code`',
    `floor_number` STRING COMMENT 'Floor number where the outlet is located within the property. Used for wayfinding and facility management.',
    `gratuity_policy` STRING COMMENT 'Policy regarding gratuities (tips) at the outlet. Defines whether gratuity is included in pricing, optional, automatically added, or not accepted.. Valid values are `included|optional|not_accepted|automatic`',
    `health_permit_number` STRING COMMENT 'Health department permit number for food service operations. Required for Food and Beverage (F&B) outlets.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this outlet record was last updated. Used for audit trail and change tracking.',
    `last_renovation_date` DATE COMMENT 'Date of the most recent major renovation or refurbishment of the outlet. Supports Property Improvement Plan (PIP) tracking and Furniture Fixtures and Equipment (FF&E) lifecycle management.',
    `liquor_license_number` STRING COMMENT 'Official liquor license number issued by the local regulatory authority. Required for outlets serving alcohol.',
    `location_description` STRING COMMENT 'Textual description of the outlets physical location within the property (e.g., Lobby Level, Poolside, 5th Floor East Wing). Assists guests in finding the outlet.',
    `loyalty_points_eligible_flag` BOOLEAN COMMENT 'Indicates whether purchases at this outlet are eligible for loyalty program points accrual. True if loyalty points can be earned.',
    `menu_url` STRING COMMENT 'Web address where the outlets current menu can be accessed. Applicable to Food and Beverage (F&B) outlets.',
    `mobile_ordering_enabled_flag` BOOLEAN COMMENT 'Indicates whether the outlet supports mobile ordering through the propertys mobile application or third-party platforms. True if mobile ordering is available.',
    `opening_date` DATE COMMENT 'Date when the outlet first opened for business. Used for historical tracking and anniversary celebrations.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the outlet. Format varies by property but typically includes days of week and time ranges (e.g., Mon-Fri 6:00 AM - 10:00 PM).',
    `outdoor_seating_flag` BOOLEAN COMMENT 'Indicates whether the outlet offers outdoor seating. True if outdoor seating is available.',
    `outlet_code` STRING COMMENT 'Unique alphanumeric code identifying the outlet within the property. Used for operational reference and system integration.. Valid values are `^[A-Z0-9]{3,10}$`',
    `outlet_name` STRING COMMENT 'The business name of the outlet as displayed to guests and used in marketing materials.',
    `outlet_status` STRING COMMENT 'Current operational status of the outlet. Determines whether the outlet is available for guest use and revenue generation.. Valid values are `active|inactive|seasonal|under_renovation|temporarily_closed|permanently_closed`',
    `outlet_type` STRING COMMENT 'Classification of the outlet by its primary business function. Determines operational processes and revenue reporting categories. [ENUM-REF-CANDIDATE: restaurant|bar|lounge|cafe|spa|fitness_center|golf_course|retail_shop|pool_bar|room_service|banquet|conference_center|business_center|recreational_facility|other — 15 candidates stripped; promote to reference product]',
    `pos_system_code` STRING COMMENT 'Identifier of the Point of Sale (POS) system instance used by this outlet. Typically references Oracle Hospitality MICROS POS system configuration.',
    `private_dining_available_flag` BOOLEAN COMMENT 'Indicates whether the outlet offers private dining rooms or spaces for exclusive events. True if private dining is available.',
    `reservation_required_flag` BOOLEAN COMMENT 'Indicates whether advance reservations are required or recommended for this outlet. True if reservations are mandatory or strongly encouraged.',
    `revenue_center_code` STRING COMMENT 'USALI-compliant revenue center code used for financial reporting and general ledger (GL) integration. Maps outlet revenue to the appropriate financial statement line item.. Valid values are `^[0-9]{4,6}$`',
    `seasonal_close_date` DATE COMMENT 'Annual date when the outlet closes for seasonal operation. Applicable only to seasonal outlets.',
    `seasonal_open_date` DATE COMMENT 'Annual date when the outlet opens for seasonal operation. Applicable only to seasonal outlets.',
    `seasonal_operation_flag` BOOLEAN COMMENT 'Indicates whether the outlet operates on a seasonal schedule (e.g., summer only, winter only). True if seasonal.',
    `seating_capacity` STRING COMMENT 'Maximum number of guests that can be seated simultaneously in the outlet. Used for reservation management and capacity planning.',
    `service_charge_percentage` DECIMAL(18,2) COMMENT 'Standard service charge percentage applied to guest bills at this outlet. Expressed as a percentage (e.g., 18.00 for 18%).',
    `square_footage` STRING COMMENT 'Total square footage of the outlet space. Used for space utilization analysis and capital expenditure (CapEx) planning.',
    `website_url` STRING COMMENT 'Web address for the outlets dedicated website or property page. Used for online marketing and guest information.',
    CONSTRAINT pk_property_outlet PRIMARY KEY(`property_outlet_id`)
) COMMENT 'Single source of truth is fnb.fnb_outlet. Master catalog of revenue-generating outlets within each property including restaurants, bars, spas, golf courses, retail shops, and recreational facilities. Captures outlet name, outlet code, outlet type, cuisine type (for F&B), seating capacity, operating hours, POS system identifier (MICROS), revenue center code (USALI), and outlet status. Serves as the SSOT for outlet identity referenced by the foodandbeverage, finance, and event domains.property_outlet]fnb_outlet. [SSOT:outlet] Domain-specific specialization of the outlet concept; canonical SSOT owner is fnb.fnb_outlet.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` (
    `gds_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the GDS/CRS property profile record in the Silver layer lakehouse. Primary key for this entity. Entity role: MASTER_RESOURCE — represents a property listing/distribution profile asset managed and distributed across GDS and CRS channels.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: gds_profile.distribution_channel_type is a denormalized reference to channel.channel. Normalizing via FK enables channel-level GDS content reporting, rate parity audits by channel, and content syndica',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each GDS profile displays rates in ONE currency. Normalize currency reference to master currency table. Remove currency_code string - will be retrieved via JOIN.',
    `gds_connection_id` BIGINT COMMENT 'Foreign key linking to channel.gds_connection. Business justification: GDS content management requires linking a propertys GDS profile to its specific GDS connection record. Operations teams use this to audit which GDS network a profile is active on, validate content sy',
    `property_id` BIGINT COMMENT 'Reference to the parent property master record that this GDS profile describes. Links the distribution profile to the physical hotel or resort asset in the property domain.',
    `address_line1` STRING COMMENT 'The primary street address of the property as displayed in GDS and OTA channel listings. Used by guests and travel agents for navigation and correspondence. Classified as confidential organizational contact data.',
    `amadeus_property_code` STRING COMMENT 'The property identifier specific to the Amadeus GDS network. May differ from the Sabre GDS property code. Used for Amadeus channel distribution, rate loading, and availability display to travel agents on the Amadeus platform.. Valid values are `^[A-Z0-9]{2,10}$`',
    `brand_code` STRING COMMENT 'The brand identifier code as registered in the GDS and CRS systems. Identifies the hotel brand (e.g., luxury, premium, select-service) under which the property is marketed in distribution channels. Used for brand-level filtering in GDS searches.. Valid values are `^[A-Z0-9]{2,8}$`',
    `brand_name` STRING COMMENT 'The full marketing name of the hotel brand as displayed in GDS and OTA channels (e.g., Luxury Collection, Marriott Hotels, Hilton Garden Inn). Supports brand-level reporting and channel distribution analytics.',
    `chain_code` STRING COMMENT 'The hotel chain or brand code registered with the GDS networks identifying the parent brand or management company. Used by GDS systems to group properties under a common brand umbrella for travel agent searches and loyalty program linkage.. Valid values are `^[A-Z0-9]{2,6}$`',
    `check_in_time` TIMESTAMP COMMENT 'The standard guest check-in time for the property in HH:MM (24-hour) format as published in GDS and OTA channel profiles. Displayed to guests and travel agents during the booking process to set arrival expectations.',
    `check_out_time` TIMESTAMP COMMENT 'The standard guest check-out time for the property in HH:MM (24-hour) format as published in GDS and OTA channel profiles. Displayed to guests and travel agents during the booking process to set departure expectations.',
    `city_code` STRING COMMENT 'The IATA or GDS city/airport code associated with the property location (e.g., NYC, LON, PAR). Used by GDS systems to associate the property with a travel destination for search and booking purposes.. Valid values are `^[A-Z]{3}$`',
    `city_name` STRING COMMENT 'The full city name of the property location as displayed in GDS and OTA channel listings. Supports geographic search and filtering in distribution channels.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the property location as registered in the GDS profile. Used for geographic filtering in GDS and OTA search results and for regulatory compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this GDS profile record was first created in the Silver layer lakehouse. Supports data lineage, audit trail, and profile lifecycle tracking.',
    `crs_property_code` STRING COMMENT 'The property identifier assigned within the Central Reservation System (CRS), specifically Sabre SynXis CRS. This code is the primary key used for rate distribution, inventory allocation, and booking transactions flowing through the CRS. Distinct from the GDS property code.. Valid values are `^[A-Z0-9]{2,12}$`',
    `display_name` STRING COMMENT 'The property name as it appears in GDS and CRS search results and booking screens. This is the consumer-facing name used by travel agents and OTA partners. May differ from the legal property name or internal operating name.',
    `fax_number` STRING COMMENT 'The fax number for the property as listed in GDS channel profiles. Used by travel agents and corporate accounts for reservation confirmations and group booking correspondence. Classified as confidential organizational contact data.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `floor_count` STRING COMMENT 'The total number of floors in the main hotel building as published in GDS and OTA channel profiles. Used by travel agents and guests for property orientation and accessibility planning.',
    `galileo_property_code` STRING COMMENT 'The property identifier specific to the Galileo/Travelport GDS network. Used for Travelport channel distribution, rate loading, and availability display to travel agents on the Galileo platform.. Valid values are `^[A-Z0-9]{2,10}$`',
    `gds_property_code` STRING COMMENT 'The unique property identifier assigned within the GDS network (Sabre, Amadeus, Galileo/Travelport). This code is used by travel agents and OTA partners to look up and book the property across GDS channels. Sourced from Sabre SynXis CRS channel configuration.. Valid values are `^[A-Z0-9]{2,10}$`',
    `has_airport_shuttle` BOOLEAN COMMENT 'Indicates whether the property offers complimentary or paid airport shuttle service as published in GDS and OTA amenity flags. Used by travel agents and guests to filter properties by transportation amenities.',
    `has_fitness_center` BOOLEAN COMMENT 'Indicates whether the property has a fitness center or gym as published in GDS and OTA amenity flags. Used by travel agents and guests to filter properties by wellness amenities. Sourced from Sabre SynXis CRS amenity configuration.',
    `has_meeting_facilities` BOOLEAN COMMENT 'Indicates whether the property has meeting rooms or conference facilities (MICE — Meetings, Incentives, Conferences, Exhibitions) as published in GDS and OTA amenity flags. Used by corporate travel agents and event planners to filter properties for group and event bookings.',
    `has_parking` BOOLEAN COMMENT 'Indicates whether the property offers on-site parking (self-park or valet) as published in GDS and OTA amenity flags. Used by travel agents and guests to filter properties by parking availability.',
    `has_pool` BOOLEAN COMMENT 'Indicates whether the property has a swimming pool as published in GDS and OTA amenity flags. Used by travel agents and guests to filter properties by recreational amenities. Sourced from Sabre SynXis CRS amenity configuration.',
    `hero_image_url` STRING COMMENT 'The URL of the primary hero/banner image displayed on GDS and OTA property listing pages. This is the main visual asset representing the property in channel distribution. Must be a publicly accessible HTTPS URL conforming to OTA image specification standards.. Valid values are `^https?://.+$`',
    `is_ada_compliant` BOOLEAN COMMENT 'Indicates whether the property meets Americans with Disabilities Act (ADA) accessibility requirements as published in GDS and OTA profiles. Used by travel agents and guests requiring accessible accommodations. Supports ADA compliance reporting.',
    `is_pet_friendly` BOOLEAN COMMENT 'Indicates whether the property accepts pets as published in GDS and OTA amenity flags. Used by travel agents and guests to filter properties by pet policy. Sourced from Sabre SynXis CRS amenity configuration.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent successful synchronization of this property profile from the Sabre SynXis CRS channel configuration to the GDS networks and downstream distribution channels. Used to monitor data freshness and identify stale profiles requiring re-sync.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the property in decimal degrees (WGS84). Used for map-based search and proximity filtering in GDS, OTA, and direct booking channels. Supports geo-analytics and competitive set mapping.',
    `long_description` STRING COMMENT 'The full marketing narrative for the property displayed on GDS detail screens and OTA property pages. Covers property overview, location highlights, accommodation types, dining, recreation, and meeting facilities. Supports channel distribution and OTA partnership management.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the property in decimal degrees (WGS84). Used for map-based search and proximity filtering in GDS, OTA, and direct booking channels. Supports geo-analytics and competitive set mapping.',
    `phone_number` STRING COMMENT 'The primary reservations or front desk phone number for the property as listed in GDS and OTA channels. Used by travel agents and guests to contact the property directly. Classified as confidential organizational contact data.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `postal_code` STRING COMMENT 'The postal or ZIP code of the property location as registered in the GDS profile. Used for geographic proximity searches in GDS and OTA platforms. Classified as confidential organizational contact data.',
    `profile_effective_date` DATE COMMENT 'The date from which this GDS/CRS property profile version became active and live for distribution across GDS and OTA channels. Used for profile versioning, content audit trails, and channel distribution management.',
    `profile_expiry_date` DATE COMMENT 'The date on which this GDS/CRS property profile version expires or is scheduled for deactivation. Nullable for open-ended active profiles. Used for profile lifecycle management and scheduled content refresh cycles.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the GDS/CRS property profile. Controls whether the property is actively distributed and bookable across GDS channels. active = live and bookable; inactive = not distributed; suspended = temporarily removed from distribution; pending_review = awaiting content approval; draft = profile under construction.. Valid values are `active|inactive|suspended|pending_review|draft`',
    `property_category` STRING COMMENT 'The GDS/OTA property category classification used to filter search results. Determines how the property is categorized in GDS and OTA search interfaces. Aligned with OTA (OpenTravel Alliance) property type codes.. Valid values are `hotel|resort|vacation_rental|extended_stay|boutique|hostel`',
    `reservation_email` STRING COMMENT 'The reservations department email address for the property as listed in GDS and OTA channel profiles. Used by travel agents and corporate accounts for booking inquiries and group reservation correspondence. Classified as confidential organizational contact data.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `short_description` STRING COMMENT 'A concise marketing description of the property (typically 150–250 characters) displayed in GDS search result summaries and OTA listing previews. Highlights key selling points such as location, brand tier, and signature amenities.',
    `star_rating` DECIMAL(18,2) COMMENT 'The official star rating of the property as displayed in GDS and OTA channels (e.g., 3.0, 4.0, 5.0). Sourced from recognized rating bodies or brand classification standards. Influences GDS search filtering and OTA ranking algorithms.',
    `total_room_count` STRING COMMENT 'The total number of guest rooms and suites at the property as published in GDS and OTA channel profiles. Used by travel agents for property selection and by revenue management for inventory benchmarking. Represents the principal quantitative fact (MEASUREMENT_OR_VALUE) for this MASTER_RESOURCE.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this GDS profile record was last modified in the Silver layer lakehouse. Used to track content changes, monitor sync freshness, and support data quality audits.',
    `website_url` STRING COMMENT 'The official property website URL as listed in GDS and OTA channel profiles. Directs guests and travel agents to the brand.com direct booking page. Supports direct channel conversion and OTA partnership management.. Valid values are `^https?://.+$`',
    CONSTRAINT pk_gds_profile PRIMARY KEY(`gds_profile_id`)
) COMMENT 'GDS (Global Distribution System) and CRS property profile records defining how each property is listed and distributed across Sabre, Amadeus, Galileo/Travelport, and direct booking channels. Captures GDS property code, chain code, CRS property code (Sabre SynXis), property display name, short description, long description, hero image URL, amenity flags, and last sync timestamp. Sourced from Sabre SynXis CRS channel configuration. Supports channel distribution and OTA partnership management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`currency` (
    `currency_id` BIGINT COMMENT 'Unique identifier for the currency record. Primary key.',
    `base_currency_id` BIGINT COMMENT 'Self-referencing FK on currency (base_currency_id)',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 alphabetic currency code (e.g., USD, EUR, GBP, JPY). This is the standard international identifier for the currency used across all financial systems, property management systems, and revenue management platforms.. Valid values are `^[A-Z]{3}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166 country code for the primary country where this currency is the official legal tender (e.g., USA for USD, GBR for GBP). Used for geographic revenue analysis and Smith Travel Research (STR) market benchmarking.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this currency record was first created in the system. Used for data lineage, audit trails, and compliance with Sarbanes-Oxley Act (SOX) requirements for financial data.',
    `currency_status` STRING COMMENT 'Current operational status of the currency in the system. Active currencies are available for all transactions; inactive currencies are retained for historical reporting; deprecated currencies are being phased out; historical currencies are no longer in circulation (e.g., legacy European currencies replaced by EUR); pending currencies are configured but not yet live.. Valid values are `active|inactive|deprecated|historical|pending`',
    `decimal_places` STRING COMMENT 'Number of decimal places used for this currency in financial calculations and display. Most currencies use 2 (e.g., USD 100.50), some use 0 (e.g., JPY 1000), and a few use 3 (e.g., BHD 10.250). Critical for accurate revenue calculations, Average Daily Rate (ADR), and Revenue Per Available Room (RevPAR) reporting.',
    `display_format` STRING COMMENT 'The standard display format for this currency including symbol placement, decimal separator, and thousands separator (e.g., $1,234.56 for USD, 1.234,56 € for EUR). Used to ensure consistent presentation across guest-facing systems, reports, and Business Intelligence (BI) dashboards.',
    `effective_date` DATE COMMENT 'The date from which this currency configuration became or will become effective in the system. Used for managing currency transitions, redenominations, and historical accuracy in financial reporting.',
    `erp_currency_code` STRING COMMENT 'The currency code or identifier used in the Enterprise Resource Planning (ERP) system, such as SAP S/4HANA. Used for financial consolidation, General Ledger (GL) posting, Accounts Payable (AP), and Accounts Receivable (AR) integration.',
    `exchange_rate_source` STRING COMMENT 'The authoritative source or provider for exchange rate data for this currency (e.g., OANDA, XE.com, Bloomberg, Reuters, Central Bank). Used to ensure consistent exchange rate application across Central Reservation System (CRS), Revenue Management System (RMS), and Enterprise Resource Planning (ERP) systems.',
    `exchange_rate_update_frequency` STRING COMMENT 'The frequency at which exchange rates are refreshed for this currency. Critical for accurate revenue recognition, dynamic pricing in Revenue Management System (RMS), and financial consolidation under International Financial Reporting Standards (IFRS) and Generally Accepted Accounting Principles (GAAP).. Valid values are `real-time|hourly|daily|weekly|monthly|on-demand`',
    `expiration_date` DATE COMMENT 'The date on which this currency configuration expires or is no longer valid for new transactions. Nullable for currencies with indefinite validity. Used for managing currency transitions and ensuring historical data integrity.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this currency is currently active and available for use in transactions, reservations, and financial operations. Inactive currencies are retained for historical reporting but cannot be used for new transactions.',
    `is_base_currency` BOOLEAN COMMENT 'Indicates whether this currency is the base currency for financial consolidation and corporate reporting. Typically one currency per enterprise (e.g., USD for US-headquartered companies). Used for Gross Operating Profit (GOP), Earnings Before Interest Taxes Depreciation and Amortization (EBITDA), and consolidated financial statements under Uniform System of Accounts for the Lodging Industry (USALI).',
    `is_crypto_currency` BOOLEAN COMMENT 'Indicates whether this is a cryptocurrency (e.g., Bitcoin, Ethereum) rather than a traditional fiat currency. Used for special handling in payment processing, regulatory compliance, and financial reporting.',
    `minor_unit` STRING COMMENT 'The relationship between the major currency unit and its minor unit (e.g., 100 cents = 1 dollar). Defines the subdivision of the currency for precise financial calculations in Property Management System (PMS) and Point of Sale (POS) systems.',
    `currency_name` STRING COMMENT 'Full official name of the currency (e.g., United States Dollar, Euro, British Pound Sterling, Japanese Yen). Used for display purposes in financial reports and guest-facing materials.',
    `notes` STRING COMMENT 'Additional notes, special handling instructions, or contextual information about this currency. May include information about currency restrictions, regulatory requirements, or system-specific configuration details.',
    `numeric_code` STRING COMMENT 'Three-digit ISO 4217 numeric currency code used in systems where alphabetic codes are not practical. Provides an alternative identifier for the currency in legacy systems and international payment processing.. Valid values are `^[0-9]{3}$`',
    `payment_processing_enabled` BOOLEAN COMMENT 'Indicates whether this currency is enabled for payment processing through Point of Sale (POS) systems, online booking engines, and payment gateways. Must comply with Payment Card Industry Data Security Standard (PCI DSS) requirements.',
    `pms_currency_code` STRING COMMENT 'The currency code or identifier used in the Property Management System (PMS), such as Oracle OPERA. May differ from ISO 4217 code in legacy systems. Used for system integration and data mapping between PMS and enterprise data warehouse.',
    `rounding_method` STRING COMMENT 'The rounding method to be applied when performing calculations with this currency. Standard follows mathematical rounding rules; up always rounds up; down always rounds down; nearest rounds to nearest value; bankers rounding (round half to even) minimizes cumulative rounding errors in large transaction volumes. Critical for accurate Average Daily Rate (ADR) and Total Revenue Per Available Room (TRevPAR) calculations.. Valid values are `standard|up|down|nearest|bankers`',
    `symbol` STRING COMMENT 'Standard symbol used to represent the currency (e.g., $, €, £, ¥). Used in user interfaces, reports, and guest-facing displays for quick visual recognition.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this currency record was last modified. Used for change tracking, data quality monitoring, and audit compliance.',
    CONSTRAINT pk_currency PRIMARY KEY(`currency_id`)
) COMMENT 'Reference master for currencies used across the global property portfolio, including ISO 4217 currency codes, currency names, decimal precision, exchange rate source configuration, and base currency designation for financial consolidation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ADD CONSTRAINT `fk_property_property_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ADD CONSTRAINT `fk_property_hierarchy_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ADD CONSTRAINT `fk_property_hierarchy_parent_node_hierarchy_id` FOREIGN KEY (`parent_node_hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ADD CONSTRAINT `fk_property_hierarchy_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ADD CONSTRAINT `fk_property_property_facility_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ADD CONSTRAINT `fk_property_property_facility_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ADD CONSTRAINT `fk_property_property_facility_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ADD CONSTRAINT `fk_property_franchise_agreement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ADD CONSTRAINT `fk_property_franchise_agreement_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ADD CONSTRAINT `fk_property_meeting_space_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ADD CONSTRAINT `fk_property_meeting_space_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ADD CONSTRAINT `fk_property_gds_profile_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ADD CONSTRAINT `fk_property_gds_profile_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ADD CONSTRAINT `fk_property_currency_base_currency_id` FOREIGN KEY (`base_currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`property` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`property` SET TAGS ('dbx_domain' = 'property');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` SET TAGS ('dbx_subdomain' = 'property_identity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,8}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `brand_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `brand_tier` SET TAGS ('dbx_value_regex' = 'luxury|upper_upscale|upscale|upper_midscale|midscale|economy');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `city` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `dos_email` SET TAGS ('dbx_business_glossary_term' = 'Director of Sales (DOS) Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `dos_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `dos_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `dos_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `dos_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `dos_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `dos_name` SET TAGS ('dbx_business_glossary_term' = 'Director of Sales (DOS) Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `dos_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `gds_property_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Property Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `gm_email` SET TAGS ('dbx_business_glossary_term' = 'General Manager (GM) Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `gm_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `gm_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `gm_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `gm_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `gm_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `gm_name` SET TAGS ('dbx_business_glossary_term' = 'General Manager (GM) Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `gm_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `is_franchised` SET TAGS ('dbx_business_glossary_term' = 'Is Franchised Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `largest_meeting_room_sqft` SET TAGS ('dbx_business_glossary_term' = 'Largest Meeting Room Square Footage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `latitude` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `longitude` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `property_name` SET TAGS ('dbx_business_glossary_term' = 'Property Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `opera_property_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle OPERA Property Management System (PMS) Property Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `opera_property_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'pre_opening|active|suspended|closed|converted');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `parent_brand_group` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Group');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Property Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+[1-9]d{1,14}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `pip_status` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `pip_status` SET TAGS ('dbx_value_regex' = 'not_required|planned|in_progress|completed|overdue');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `property_type` SET TAGS ('dbx_business_glossary_term' = 'Property Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `property_type` SET TAGS ('dbx_value_regex' = 'hotel|resort|extended_stay|vacation_property|boutique|conference_center');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `revenue_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Revenue Manager Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `revenue_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `revenue_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `revenue_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `revenue_manager_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `revenue_manager_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `revenue_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Revenue Manager Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `revenue_manager_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `revenue_manager_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `segment_classification` SET TAGS ('dbx_business_glossary_term' = 'Segment Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `star_rating` SET TAGS ('dbx_business_glossary_term' = 'Star Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `str_property_code` SET TAGS ('dbx_business_glossary_term' = 'Smith Travel Research (STR) Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `synxis_property_code` SET TAGS ('dbx_business_glossary_term' = 'Sabre SynXis Central Reservation System (CRS) Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `total_floor_count` SET TAGS ('dbx_business_glossary_term' = 'Total Floor Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `total_meeting_space_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Meeting Space Square Footage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `total_room_count` SET TAGS ('dbx_business_glossary_term' = 'Total Room Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `total_suite_count` SET TAGS ('dbx_business_glossary_term' = 'Total Suite Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` SET TAGS ('dbx_subdomain' = 'property_identity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Property Hierarchy ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `parent_node_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Node ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Hotel Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `brand_portfolio` SET TAGS ('dbx_business_glossary_term' = 'Brand Portfolio');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `chain_scale` SET TAGS ('dbx_business_glossary_term' = 'STR Chain Scale');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `chain_scale` SET TAGS ('dbx_value_regex' = 'luxury|upper_upscale|upscale|upper_midscale|midscale|economy');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `fiscal_year_start_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Start Month');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `gds_chain_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Chain Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `gds_chain_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `geographic_region` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `is_reporting_node` SET TAGS ('dbx_business_glossary_term' = 'Is Reporting Node Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `is_str_market_node` SET TAGS ('dbx_business_glossary_term' = 'Is STR Market Node Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `kpi_rollup_method` SET TAGS ('dbx_business_glossary_term' = 'KPI Roll-Up Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `kpi_rollup_method` SET TAGS ('dbx_value_regex' = 'sum|weighted_average|simple_average|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `management_type` SET TAGS ('dbx_business_glossary_term' = 'Property Management Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `management_type` SET TAGS ('dbx_value_regex' = 'owned|managed|franchised|leased|joint_venture');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `management_type` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `node_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `node_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|dissolved');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `node_type` SET TAGS ('dbx_value_regex' = 'corporate|region|division|area_office|cluster|property');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `property_count` SET TAGS ('dbx_business_glossary_term' = 'Property Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `reporting_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `reporting_segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `responsible_executive` SET TAGS ('dbx_business_glossary_term' = 'Responsible Executive Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `responsible_executive_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Executive Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `responsible_executive_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `responsible_executive_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `responsible_executive_email` SET TAGS ('dbx_pii' = 'contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `responsible_executive_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `responsible_executive_title` SET TAGS ('dbx_business_glossary_term' = 'Responsible Executive Title');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `restructure_reason` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Restructure Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `sap_profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Profit Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `sap_profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `str_geographic_code` SET TAGS ('dbx_business_glossary_term' = 'STR (Smith Travel Research) Geographic Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `str_geographic_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,15}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `str_geographic_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `str_market_name` SET TAGS ('dbx_business_glossary_term' = 'STR (Smith Travel Research) Market Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `total_room_count` SET TAGS ('dbx_business_glossary_term' = 'Total Room Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Version Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` SET TAGS ('dbx_subdomain' = 'venue_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `property_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Property Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `ada_features` SET TAGS ('dbx_business_glossary_term' = 'ADA (Americans with Disabilities Act) Accessibility Features');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `age_restriction` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction Policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `age_restriction` SET TAGS ('dbx_value_regex' = 'none|adults_only|minimum_age_18|minimum_age_16|children_only');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `age_restriction` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Facility Area (Square Feet)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `av_equipment_available` SET TAGS ('dbx_business_glossary_term' = 'Audio-Visual (AV) Equipment Available Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `building_wing` SET TAGS ('dbx_business_glossary_term' = 'Building Wing or Zone');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `capacity` SET TAGS ('dbx_business_glossary_term' = 'Facility Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `capacity` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `property_facility_description` SET TAGS ('dbx_business_glossary_term' = 'Facility Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `dress_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Dress Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `dress_code` SET TAGS ('dbx_value_regex' = 'none|smart_casual|formal|resort_casual|swimwear_only');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `facility_category` SET TAGS ('dbx_business_glossary_term' = 'Facility Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Result');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|pass_with_conditions|fail|pending');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `is_24_hour` SET TAGS ('dbx_business_glossary_term' = '24-Hour Operation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `is_ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'ADA (Americans with Disabilities Act) Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `is_fee_based` SET TAGS ('dbx_business_glossary_term' = 'Fee-Based Facility Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `is_reservation_required` SET TAGS ('dbx_business_glossary_term' = 'Reservation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `is_seasonal` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Availability Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Facility License Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Facility Operating License Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `license_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `max_occupancy_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Occupancy Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `natural_light` SET TAGS ('dbx_business_glossary_term' = 'Natural Light Available Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `operating_hours_close` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Closing Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `operating_hours_close` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `operating_hours_open` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Opening Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `operating_hours_open` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `outdoor_indoor` SET TAGS ('dbx_business_glossary_term' = 'Indoor/Outdoor Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `outdoor_indoor` SET TAGS ('dbx_value_regex' = 'indoor|outdoor|semi_outdoor');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `property_facility_status` SET TAGS ('dbx_business_glossary_term' = 'Facility Operational Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `property_facility_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|under_renovation|closed|pending_opening');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `renovation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Renovation End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `renovation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Renovation Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `renovation_status` SET TAGS ('dbx_business_glossary_term' = 'Renovation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `renovation_status` SET TAGS ('dbx_value_regex' = 'not_scheduled|planned|in_progress|completed');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `seasonal_close_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Closing Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `seasonal_open_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Opening Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `seating_configuration` SET TAGS ('dbx_business_glossary_term' = 'Seating Configuration');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `smoking_policy` SET TAGS ('dbx_business_glossary_term' = 'Facility Smoking Policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `smoking_policy` SET TAGS ('dbx_value_regex' = 'non_smoking|smoking_permitted|designated_area');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Display Sort Order');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `usage_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Facility Usage Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `usage_fee_amount` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` SET TAGS ('dbx_subdomain' = 'property_identity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `channel_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Contract Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|terminated|suspended|under_renewal');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'franchise|management_contract|lease|owner_operated|license');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `brand_segment` SET TAGS ('dbx_business_glossary_term' = 'Brand Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `brand_segment` SET TAGS ('dbx_value_regex' = 'luxury|upper_upscale|upscale|upper_midscale|midscale|economy');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `brand_standard_version` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `crs_connectivity_required` SET TAGS ('dbx_business_glossary_term' = 'Central Reservation System (CRS) Connectivity Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `exclusive_territory` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Territory Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Executed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `executed_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `fdd_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Disclosure Document (FDD) Registration Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `fdd_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `ff_and_e_reserve_pct` SET TAGS ('dbx_business_glossary_term' = 'Furniture Fixtures and Equipment (FF&E) Reserve Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `ff_and_e_reserve_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `franchisee_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Entity Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `franchisee_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Country');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `governing_law_state` SET TAGS ('dbx_business_glossary_term' = 'Governing Law State/Province');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `governing_law_state` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `initial_term_years` SET TAGS ('dbx_business_glossary_term' = 'Initial Term (Years)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `initial_term_years` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `last_brand_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Brand Audit Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `loyalty_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Fee Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `loyalty_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `management_fee_base_pct` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Base Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `management_fee_base_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `management_fee_base_pct` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `management_fee_incentive_pct` SET TAGS ('dbx_business_glossary_term' = 'Incentive Management Fee Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `management_fee_incentive_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `management_fee_incentive_pct` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `marketing_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fee Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `marketing_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `next_brand_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Brand Audit Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `pip_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Budget Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `pip_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `pip_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `pip_required` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `pms_system_required` SET TAGS ('dbx_business_glossary_term' = 'Required Property Management System (PMS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `quality_assurance_score_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quality Assurance Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `renewal_option_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `renewal_option_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `renewal_term_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Years)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `renewal_term_years` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `reservation_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Reservation Fee Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `reservation_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `royalty_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Royalty Fee Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `royalty_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` SET TAGS ('dbx_subdomain' = 'venue_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Catering Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Property Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `accessibility_compliant` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliance');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `adjacent_prefunction_space` SET TAGS ('dbx_business_glossary_term' = 'Adjacent Pre-Function Space');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `blackout_capability` SET TAGS ('dbx_business_glossary_term' = 'Blackout Capability');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `builtin_av_equipment` SET TAGS ('dbx_business_glossary_term' = 'Built-In Audio-Visual (AV) Equipment');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `capacity_banquet` SET TAGS ('dbx_business_glossary_term' = 'Banquet Setup Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `capacity_banquet` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `capacity_classroom` SET TAGS ('dbx_business_glossary_term' = 'Classroom Setup Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `capacity_classroom` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `capacity_hollow_square` SET TAGS ('dbx_business_glossary_term' = 'Hollow Square Setup Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `capacity_hollow_square` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `capacity_reception` SET TAGS ('dbx_business_glossary_term' = 'Reception Setup Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `capacity_reception` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `capacity_theater` SET TAGS ('dbx_business_glossary_term' = 'Theater Setup Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `capacity_theater` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `capacity_u_shape` SET TAGS ('dbx_business_glossary_term' = 'U-Shape Setup Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `capacity_u_shape` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `catering_required` SET TAGS ('dbx_business_glossary_term' = 'Catering Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `ceiling_height_feet` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Height in Feet');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `climate_control_type` SET TAGS ('dbx_business_glossary_term' = 'Climate Control Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `climate_control_type` SET TAGS ('dbx_value_regex' = 'individual|shared|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `dedicated_wifi_bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Dedicated WiFi Bandwidth in Megabits Per Second (Mbps)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `divisible` SET TAGS ('dbx_business_glossary_term' = 'Space Divisibility');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `emergency_exit_count` SET TAGS ('dbx_business_glossary_term' = 'Emergency Exit Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `emergency_exit_count` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `entrance_width_inches` SET TAGS ('dbx_business_glossary_term' = 'Entrance Width in Inches');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `fire_capacity_limit` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Capacity Limit');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `fire_capacity_limit` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `loading_dock_access` SET TAGS ('dbx_business_glossary_term' = 'Loading Dock Access');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `meeting_space_status` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `meeting_space_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_renovation|temporarily_closed');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `minimum_catering_spend` SET TAGS ('dbx_business_glossary_term' = 'Minimum Catering Spend');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `minimum_rental_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rental Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `natural_light_available` SET TAGS ('dbx_business_glossary_term' = 'Natural Light Availability');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `number_of_sections` SET TAGS ('dbx_business_glossary_term' = 'Number of Divisible Sections');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `rental_rate_tier` SET TAGS ('dbx_business_glossary_term' = 'Rental Rate Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `rental_rate_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|value|complimentary');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `space_code` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `space_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `space_name` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `space_type` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `total_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Total Square Footage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `total_square_footage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `wifi_available` SET TAGS ('dbx_business_glossary_term' = 'WiFi Availability');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` SET TAGS ('dbx_subdomain' = 'venue_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `property_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Property Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `alcohol_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Service Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `average_check_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Check Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `average_check_amount` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `cuisine_type` SET TAGS ('dbx_business_glossary_term' = 'Cuisine Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `delivery_service_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Service Available Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `dress_code` SET TAGS ('dbx_business_glossary_term' = 'Dress Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `dress_code` SET TAGS ('dbx_value_regex' = 'casual|smart_casual|business_casual|formal|resort_casual|no_dress_code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `gratuity_policy` SET TAGS ('dbx_business_glossary_term' = 'Gratuity Policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `gratuity_policy` SET TAGS ('dbx_value_regex' = 'included|optional|not_accepted|automatic');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `health_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Health Permit Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `health_permit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `liquor_license_number` SET TAGS ('dbx_business_glossary_term' = 'Liquor License Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `liquor_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `liquor_license_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `liquor_license_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `loyalty_points_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `menu_url` SET TAGS ('dbx_business_glossary_term' = 'Menu URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `mobile_ordering_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Ordering Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `mobile_ordering_enabled_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `mobile_ordering_enabled_flag` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `mobile_ordering_enabled_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `mobile_ordering_enabled_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `outdoor_seating_flag` SET TAGS ('dbx_business_glossary_term' = 'Outdoor Seating Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `outlet_code` SET TAGS ('dbx_business_glossary_term' = 'Outlet Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `outlet_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `outlet_name` SET TAGS ('dbx_business_glossary_term' = 'Outlet Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `outlet_status` SET TAGS ('dbx_business_glossary_term' = 'Outlet Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `outlet_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|under_renovation|temporarily_closed|permanently_closed');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `outlet_type` SET TAGS ('dbx_business_glossary_term' = 'Outlet Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `pos_system_code` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) System ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `private_dining_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Dining Available Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `reservation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reservation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `seasonal_close_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Close Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `seasonal_open_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Open Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `seasonal_operation_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Operation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `service_charge_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `service_charge_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `square_footage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` SET TAGS ('dbx_subdomain' = 'property_identity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `gds_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `gds_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Gds Connection Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Property Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `amadeus_property_code` SET TAGS ('dbx_business_glossary_term' = 'Amadeus GDS Property Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `amadeus_property_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `chain_code` SET TAGS ('dbx_business_glossary_term' = 'GDS Chain Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `chain_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `check_in_time` SET TAGS ('dbx_business_glossary_term' = 'Standard Check-In Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `check_out_time` SET TAGS ('dbx_business_glossary_term' = 'Standard Check-Out Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `city_code` SET TAGS ('dbx_business_glossary_term' = 'GDS City Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `city_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `city_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `city_name` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `city_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `crs_property_code` SET TAGS ('dbx_business_glossary_term' = 'Central Reservation System (CRS) Property Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `crs_property_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'GDS Display Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Property Fax Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `fax_number` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii' = 'contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `floor_count` SET TAGS ('dbx_business_glossary_term' = 'Floor Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `galileo_property_code` SET TAGS ('dbx_business_glossary_term' = 'Galileo/Travelport GDS Property Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `galileo_property_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `gds_property_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Property Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `gds_property_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `has_airport_shuttle` SET TAGS ('dbx_business_glossary_term' = 'Has Airport Shuttle Amenity Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `has_fitness_center` SET TAGS ('dbx_business_glossary_term' = 'Has Fitness Center Amenity Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `has_meeting_facilities` SET TAGS ('dbx_business_glossary_term' = 'Has Meeting Facilities Amenity Flag (MICE)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `has_parking` SET TAGS ('dbx_business_glossary_term' = 'Has Parking Amenity Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `has_pool` SET TAGS ('dbx_business_glossary_term' = 'Has Swimming Pool Amenity Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `hero_image_url` SET TAGS ('dbx_business_glossary_term' = 'Hero Image URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `hero_image_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `hero_image_url` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `is_ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is ADA Compliant Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `is_pet_friendly` SET TAGS ('dbx_business_glossary_term' = 'Is Pet Friendly Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last GDS/CRS Sync Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Property Latitude');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `latitude` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'GDS Long Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Property Longitude');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `longitude` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Property Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `profile_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Profile Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `profile_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Profile Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'GDS Profile Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_review|draft');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `property_category` SET TAGS ('dbx_business_glossary_term' = 'Property Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `property_category` SET TAGS ('dbx_value_regex' = 'hotel|resort|vacation_rental|extended_stay|boutique|hostel');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `reservation_email` SET TAGS ('dbx_business_glossary_term' = 'Reservations Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `reservation_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `reservation_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `reservation_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `reservation_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `reservation_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'GDS Short Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `star_rating` SET TAGS ('dbx_business_glossary_term' = 'Star Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `total_room_count` SET TAGS ('dbx_business_glossary_term' = 'Total Room Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Property Website URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` SET TAGS ('dbx_subdomain' = 'venue_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `base_currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `base_currency_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Country Code (ISO 3166)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `currency_status` SET TAGS ('dbx_business_glossary_term' = 'Currency Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `currency_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|historical|pending');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `decimal_places` SET TAGS ('dbx_business_glossary_term' = 'Decimal Places');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `display_format` SET TAGS ('dbx_business_glossary_term' = 'Display Format');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `erp_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `exchange_rate_source` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `exchange_rate_update_frequency` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Update Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `exchange_rate_update_frequency` SET TAGS ('dbx_value_regex' = 'real-time|hourly|daily|weekly|monthly|on-demand');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `is_base_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `is_crypto_currency` SET TAGS ('dbx_business_glossary_term' = 'Cryptocurrency Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `minor_unit` SET TAGS ('dbx_business_glossary_term' = 'Minor Unit');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `currency_name` SET TAGS ('dbx_business_glossary_term' = 'Currency Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Currency Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `numeric_code` SET TAGS ('dbx_business_glossary_term' = 'Numeric Currency Code (ISO 4217)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `numeric_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `payment_processing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Payment Processing Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `pms_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Property Management System (PMS) Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `rounding_method` SET TAGS ('dbx_business_glossary_term' = 'Rounding Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `rounding_method` SET TAGS ('dbx_value_regex' = 'standard|up|down|nearest|bankers');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `symbol` SET TAGS ('dbx_business_glossary_term' = 'Currency Symbol');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
