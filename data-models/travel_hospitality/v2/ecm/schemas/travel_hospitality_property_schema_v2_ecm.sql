-- Schema for Domain: property | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:50:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`property` COMMENT 'Master data for physical hotel and resort assets including location, brand affiliation, property attributes, facility amenities, service levels, classifications, and operational status. Manages property hierarchy, geographic distribution, brand portfolio, franchise relationships, and PIP (Property Improvement Plan) records. Supports multi-property operations and STR competitive set benchmarking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`property` (
    `property_id` BIGINT COMMENT 'Primary key for property',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each property operates in ONE currency; each currency used by MANY properties. Normalize currency reference to master currency table. Remove currency_code string from property - will be retrieved via ',
    `ownership_entity_id` BIGINT COMMENT 'Foreign key linking to property.ownership_entity. Business justification: Each property has ONE ownership entity; each ownership entity can own MANY properties. This is a core master data relationship. Adding ownership_entity_id FK allows removal of ownership_type string (o',
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
    `cleaning_standard_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_standard. Business justification: Facilities (pools, spas, fitness centers) require specific cleaning protocols defined by brand standards. Operations managers assign cleaning standards to facilities to ensure compliance with health c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Facilities (pools, fitness centers, spas) are cost centers for expense allocation in USALI. Real operations track maintenance, utilities, and labor costs by facility for departmental profitability ana',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each facility usage fee is denominated in ONE currency. Normalize currency reference to master currency table. Remove currency_code string - will be retrieved via JOIN.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Facilities (pools, spas, fitness centers) operate as distinct organizational units with dedicated staff, labor budgets, and scheduling. Required for labor cost allocation, productivity tracking, and o',
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
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each franchise agreement is denominated in ONE currency. Normalize currency reference to master currency table. Remove currency_code string - will be retrieved via JOIN.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Franchise agreements impose specific compliance obligations (brand standard audits, quality assurance score minimums, PIP requirements). Linking franchise agreements to their mandated compliance oblig',
    `ownership_entity_id` BIGINT COMMENT 'Foreign key linking to property.ownership_entity. Business justification: Each franchise agreement has ONE franchisor entity. Normalize franchisor reference to ownership_entity master. This is the first of two FKs to ownership_entity (franchisor and franchisee). Remove fran',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` (
    `pip_plan_id` BIGINT COMMENT 'Unique identifier for the Property Improvement Plan record. Primary key for all capital improvement tracking.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each PIP plan is budgeted in ONE currency. Normalize currency reference to master currency table. Remove currency_code string - will be retrieved via JOIN.',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to property.franchise_agreement. Business justification: A PIP plan CAN be triggered by a franchise agreement requirement (brand-mandated property improvement). This FK will be nullable - PIPs can be triggered by other events (renovation, compliance, capita',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property subject to this improvement plan.',
    `actual_completion_date` DATE COMMENT 'Actual date the project was completed and all deliverables were accepted, used for performance tracking and variance analysis.',
    `actual_spend_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual capital expenditure incurred on the project to date in USD, tracked for budget variance analysis.',
    `ada_compliance_included` BOOLEAN COMMENT 'Indicates whether the project scope includes ADA accessibility improvements or compliance upgrades.',
    `approved_budget` DECIMAL(18,2) COMMENT 'Formally approved capital budget for the project in USD, authorized by ownership or executive management.',
    `brand_compliance_status` STRING COMMENT 'Current status of the propertys compliance with brand standards relative to this PIP: compliant (meets standards), non-compliant (deficiencies exist), pending-review (under brand evaluation), waived (exemption granted), or not-applicable (non-branded property).. Valid values are `compliant|non_compliant|pending_review|waived|not_applicable`',
    `brand_standard_compliance_deadline` DATE COMMENT 'Date by which the property must complete the PIP to maintain brand compliance and avoid penalties or franchise termination.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Current percentage of project completion (0.00 to 100.00), used for progress tracking and earned value analysis.',
    `contractor_license_number` STRING COMMENT 'State or local license number of the general contractor, required for regulatory compliance and vendor management.',
    `contractor_name` STRING COMMENT 'Name of the primary general contractor or construction firm executing the capital improvement work.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PIP plan record was first created in the system, used for audit trail and data lineage.',
    `expected_roi_percentage` DECIMAL(18,2) COMMENT 'Projected return on investment percentage for the capital improvement project, calculated from expected revenue lift and cost savings against total CapEx.',
    `ffe_actual_spend` DECIMAL(18,2) COMMENT 'Actual expenditure on furniture, fixtures, and equipment to date, used for budget variance tracking.',
    `ffe_budget` DECIMAL(18,2) COMMENT 'Allocated budget specifically for furniture, fixtures, and equipment purchases as part of the capital improvement project, tracked separately from construction costs.',
    `fire_safety_upgrade_included` BOOLEAN COMMENT 'Indicates whether the project scope includes fire safety system upgrades or compliance work.',
    `impacted_areas` STRING COMMENT 'Comma-separated list or narrative of physical areas affected by the project, such as guest rooms, lobby, F&B outlets, meeting spaces, back-of-house, or exterior.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this PIP plan record, used for accountability and audit purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this PIP plan record was last updated, used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form text field for additional project notes, special conditions, risk factors, or stakeholder comments.',
    `opex_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated change in annual operating expenses (positive or negative) resulting from the capital improvement, used for ROI and payback period calculations.',
    `payback_period_months` STRING COMMENT 'Estimated number of months required to recover the capital investment through incremental revenue and cost savings.',
    `permit_expiration_date` DATE COMMENT 'Date the construction permit expires, requiring renewal if work extends beyond this date.',
    `permit_issue_date` DATE COMMENT 'Date the construction permit was issued by local regulatory authorities.',
    `permit_number` STRING COMMENT 'Building or construction permit number issued by local authorities for the capital improvement work.',
    `project_manager_email` STRING COMMENT 'Primary email address of the project manager for communication and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `project_manager_name` STRING COMMENT 'Name of the individual responsible for managing and coordinating the capital improvement project.',
    `project_manager_phone` STRING COMMENT 'Primary contact phone number for the project manager.',
    `project_name` STRING COMMENT 'Human-readable name or title of the improvement project for reporting and communication purposes.',
    `project_reference_number` STRING COMMENT 'Externally-known unique business identifier for the capital improvement project, used across finance, operations, and brand compliance systems.',
    `project_status` STRING COMMENT 'Current lifecycle status of the capital improvement project: draft (planning), approved (authorized), in-progress (active work), on-hold (temporarily suspended), completed (finished), cancelled (terminated), or waived (brand exemption granted). [ENUM-REF-CANDIDATE: draft|approved|in_progress|on_hold|completed|cancelled|waived — 7 candidates stripped; promote to reference product]',
    `project_type` STRING COMMENT 'Discriminator for the kind of capital improvement project: brand-mandated PIP, owner-initiated renovation, infrastructure upgrade, technology upgrade, or regulatory compliance project.. Valid values are `brand_pip|owner_renovation|infrastructure|technology|compliance`',
    `projected_completion_date` DATE COMMENT 'Estimated date for project completion, used for operational planning and room inventory availability forecasting.',
    `revenue_displacement_estimate` DECIMAL(18,2) COMMENT 'Estimated total revenue loss in USD due to rooms out of service and operational disruption during the project, critical for financial impact analysis and GOP forecasting.',
    `rooms_out_of_service_count` STRING COMMENT 'Number of guest rooms temporarily unavailable during the project execution, critical for revenue displacement forecasting and occupancy planning.',
    `scheduled_start_date` DATE COMMENT 'Planned date for project commencement, used for resource planning and revenue displacement forecasting.',
    `scope_of_work_summary` STRING COMMENT 'Detailed narrative description of the planned capital improvements, including areas, systems, and deliverables covered by the project.',
    `sustainability_certification_target` STRING COMMENT 'Target environmental or sustainability certification the project aims to achieve (e.g., LEED, Green Key, EarthCheck), if applicable.',
    `total_estimated_capex` DECIMAL(18,2) COMMENT 'Initial estimated total capital expenditure for the project in USD, used for budgeting and financial planning.',
    `triggering_event` STRING COMMENT 'Business event or condition that initiated the PIP or capital project, such as ownership transition, periodic brand review, guest satisfaction decline, or regulatory mandate.',
    CONSTRAINT pk_pip_plan PRIMARY KEY(`pip_plan_id`)
) COMMENT 'Property Improvement Plan (PIP) and capital project records for each property, serving as the single source of truth for ALL capital improvement work. Covers brand-mandated PIPs triggered by ownership transitions or periodic brand reviews, owner-initiated renovations (soft goods refresh, full renovation, infrastructure upgrade, technology upgrade), and infrastructure capital projects. Captures project reference number, project type discriminator (brand_pip, owner_renovation, infrastructure, technology), triggering event, total estimated CapEx, approved budget, actual spend to date, scope of work summary, impacted areas, rooms out of service, project manager, brand standard compliance deadline, scheduled start date, projected completion date, actual completion date, completion percentage, and project status (draft, approved, in-progress, completed, waived). Critical for brand compliance, CapEx planning, revenue displacement forecasting, and OpEx impact analysis. This is the SSOT for all capital improvement tracking — no separate renovation tracking exists.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` (
    `pip_item_id` BIGINT COMMENT 'Unique surrogate identifier for each individual line-item work scope record within a Property Improvement Plan (PIP). Primary key for this entity.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each PIP item is costed in ONE currency. Normalize currency reference to master currency table. Remove currency_code string - will be retrieved via JOIN.',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: PIP capital projects include F&B outlet renovations (kitchen equipment, dining room refresh, bar upgrades). Capital planning tracks outlet-specific PIP items for budget allocation and ROI analysis. St',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Links PIP items to physical delivery receipts for capital assets. Critical for project milestone tracking, installation scheduling coordination, asset capitalization timing (GAAP/IFRS compliance), and',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: A PIP item CAN target a specific meeting space (e.g., ballroom renovation, AV equipment upgrade). This FK will be nullable - most PIP items target other areas. No columns to remove - property_area is ',
    `pip_plan_id` BIGINT COMMENT 'Reference to the parent Property Improvement Plan under which this line-item work scope belongs. Links the item to its governing PIP document and approved CapEx budget.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: PIP capital improvement items frequently reference master procurement contracts for FF&E purchases. Enables contract compliance verification, negotiated pricing validation, and ensures PIP spending ad',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: A PIP item CAN target a specific facility (e.g., pool resurfacing, restaurant kitchen upgrade). This FK will be nullable - some PIP items are property-wide (e.g., roof replacement, HVAC system). No co',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property at which this PIP line-item work scope is being executed. Enables multi-property portfolio tracking of improvement spend.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Each PIP item generates specific purchase orders for capital asset procurement. Essential for tracking capex spend against approved budgets, monitoring delivery timelines for project scheduling, and r',
    `vendor_id` BIGINT COMMENT 'Reference to the SAP S/4HANA vendor master record for the contractor responsible for this PIP item. Enables linkage to procurement contracts, insurance certificates, and payment terms.',
    `actual_completion_date` DATE COMMENT 'The actual date on which this PIP line item was fully completed, inspected, and accepted. Used for brand compliance verification, final cost reconciliation, asset capitalization triggering in SAP, and PIP progress reporting to ownership and brand.',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual invoiced and posted cost in the propertys functional currency for this PIP line item upon completion or at current spend date. Compared against estimated_cost for budget variance reporting. Sourced from SAP S/4HANA AP invoice postings against the PIP work order.',
    `actual_start_date` DATE COMMENT 'The actual date on which work for this PIP line item commenced on-site. Compared against scheduled_start_date to identify schedule slippage and its downstream impact on brand compliance deadlines and hotel operations.',
    `approved_by` STRING COMMENT 'Name or identifier of the ownership, asset management, or corporate authority who approved the CapEx budget for this PIP item. Required for SOX financial controls documentation and CapEx authorization audit trail.',
    `approved_date` DATE COMMENT 'The date on which the CapEx budget for this PIP item was formally approved by the designated authority. Required for SOX financial controls audit trail and for establishing the authorized spend baseline.',
    `asset_tag_number` STRING COMMENT 'The SAP S/4HANA fixed asset number assigned to the asset created or replaced by this PIP item upon capitalization. Links the PIP line item to the propertys fixed asset register for depreciation scheduling and asset lifecycle management.',
    `brand_requirement_flag` BOOLEAN COMMENT 'Indicates whether this PIP item is mandated by the brand franchisor as a condition of franchise agreement compliance (True) or is an ownership-initiated discretionary improvement (False). Brand-required items carry compliance deadlines and potential franchise termination risk if not completed.',
    `capex_budget_code` STRING COMMENT 'The SAP S/4HANA internal order or WBS (Work Breakdown Structure) element code to which this PIP items costs are allocated. Enables precise CapEx budget tracking, cost center assignment, and financial reporting per USALI and SOX requirements.',
    `compliance_deadline` DATE COMMENT 'The date by which this PIP item must be completed to satisfy brand franchisor compliance requirements. Failure to meet this deadline may result in franchise agreement penalties, brand standard deficiency notices, or franchise termination proceedings.',
    `contract_number` STRING COMMENT 'The procurement contract or purchase order number in SAP S/4HANA governing the contractors engagement for this PIP item. Used for invoice matching, lien waiver tracking, and contract compliance verification.',
    `contractor_name` STRING COMMENT 'The name of the primary contractor or vendor responsible for executing the work scope for this PIP item. Used for contractor performance tracking, lien waiver management, and procurement compliance. Sourced from SAP S/4HANA Vendor Master.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this PIP item record was first created in the data platform. Provides audit trail for record provenance and supports data lineage requirements in the Databricks Silver Layer.',
    `deferral_reason` STRING COMMENT 'Narrative explanation for why this PIP item has been deferred beyond its original scheduled completion date. Required for brand franchisor approval of deferrals and for ownership reporting on PIP execution delays. Populated only when item_status is deferred.',
    `deferred_completion_date` DATE COMMENT 'The revised target completion date approved by the brand franchisor for a deferred PIP item. Replaces the original scheduled_completion_date as the binding compliance deadline when a deferral has been formally granted.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'The budgeted or estimated cost in the propertys functional currency for completing this PIP line item, as approved in the CapEx budget. Used for budget variance analysis, ownership reporting, and CapEx authorization tracking per USALI and SAP S/4HANA project accounting.',
    `ffe_category` STRING COMMENT 'Classification of the PIP item into the FF&E (Furniture, Fixtures and Equipment) taxonomy per USALI and brand standards. Determines CapEx vs OpEx treatment, depreciation schedule, and procurement channel. [ENUM-REF-CANDIDATE: furniture|fixtures|equipment|soft_goods|technology|signage|artwork|building_infrastructure|os_and_e — promote to reference product]',
    `gl_account_code` STRING COMMENT 'The SAP S/4HANA General Ledger account code for posting costs associated with this PIP item. Determines whether the expenditure is capitalized (balance sheet) or expensed (P&L) per USALI and IFRS/GAAP accounting treatment.',
    `inspection_date` DATE COMMENT 'The date on which the brand quality assurance inspector conducted or is scheduled to conduct the formal inspection of this completed PIP item. Required for brand compliance certification and franchise agreement documentation.',
    `inspection_outcome` STRING COMMENT 'The result of the brand quality assurance inspection for this PIP item. A failed or conditional pass outcome triggers a punch list of remediation items that must be resolved before the item can be closed for brand compliance purposes.. Valid values are `passed|failed|conditional_pass|pending|waived`',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this PIP item requires a formal brand quality assurance inspection upon completion (True) before it can be marked as accepted and closed. Brand-mandated items typically require inspector sign-off as a condition of compliance certification.',
    `item_description` STRING COMMENT 'Detailed narrative description of the specific work scope for this PIP line item, including materials, finishes, quantities, and brand standard requirements (e.g., Replace all guestroom soft goods including headboards, drapery, and carpet per brand standard BS-2024-GR-07).',
    `item_number` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this PIP line item, typically matching the numbering scheme in the brand-issued PIP document or SAP work order. Used for cross-referencing with brand inspectors, contractors, and CapEx approval documentation.. Valid values are `^PIP-[A-Z0-9]{2,10}-[0-9]{4}-[0-9]{3}$`',
    `item_status` STRING COMMENT 'Current lifecycle status of this PIP line item within the execution workflow. Tracks progression from initial identification through approval, active construction, and final completion or deferral. Used for PIP compliance reporting to brand and ownership.. Valid values are `pending|approved|in_progress|completed|deferred|cancelled`',
    `life_safety_flag` BOOLEAN COMMENT 'Indicates whether this PIP item addresses a life safety, fire code, ADA accessibility, or OSHA regulatory compliance requirement (True). Life safety items are treated as critical priority and may not be deferred without regulatory authority approval.',
    `priority_level` STRING COMMENT 'Brand-assigned or ownership-assigned priority ranking for this PIP item. Critical items typically represent brand standard violations or life-safety issues requiring immediate remediation. Drives sequencing of work execution and resource allocation.. Valid values are `critical|high|medium|low`',
    `property_area` STRING COMMENT 'The physical area or zone of the property affected by this PIP line item. Drives scheduling coordination with hotel operations to minimize guest impact. [ENUM-REF-CANDIDATE: guestroom|lobby|corridor|exterior|food_and_beverage|meeting_space|fitness_center|pool|back_of_house|spa|parking|landscaping — promote to reference product]',
    `punch_list_notes` STRING COMMENT 'Free-text notes documenting outstanding deficiencies, remediation requirements, or conditional items identified during brand inspection or internal quality review. Captures specific corrective actions required before final acceptance of this PIP item.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of units, rooms, fixtures, or items covered by this PIP line items work scope (e.g., 120 guestrooms, 45 chairs, 3 elevators). Used for unit cost benchmarking, procurement quantity planning, and cost-per-unit analysis.',
    `rooms_out_of_order` STRING COMMENT 'The number of guestrooms placed out of order (OOO) in the PMS as a direct result of this PIP items work scope. Critical input for RevPAR impact modeling in IDeaS G3 RMS and for coordinating room inventory availability in Oracle OPERA PMS during renovation.',
    `scheduled_completion_date` DATE COMMENT 'The planned date by which this PIP line item is expected to be fully completed and ready for inspection. Used for milestone tracking, brand compliance deadline management, and rooms-out-of-order (OOO) planning to minimize RevPAR impact.',
    `scheduled_start_date` DATE COMMENT 'The planned date on which work for this PIP line item is scheduled to commence. Used for construction phasing, contractor mobilization planning, and coordination with hotel operations to manage guest impact and room inventory availability.',
    `sustainability_flag` BOOLEAN COMMENT 'Indicates whether this PIP item contributes to the propertys sustainability or energy efficiency program (True), such as LED lighting upgrades, low-flow plumbing fixtures, or HVAC efficiency improvements. Supports ESG reporting and green certification tracking.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity field on this PIP item (e.g., each, room, sqft, sqm, linear_ft, lot). Required for accurate cost-per-unit benchmarking and procurement specification.. Valid values are `each|room|sqft|sqm|linear_ft|lot`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this PIP item record was most recently modified in the data platform. Used for incremental ETL processing, change data capture, and audit trail compliance in the Databricks Silver Layer.',
    `work_type` STRING COMMENT 'Classification of the nature of work required for this PIP item. Distinguishes between full replacement, renovation/refresh, new installation, repair, technology upgrade, or regulatory compliance work. Drives cost estimation methodology and contractor selection.. Valid values are `replacement|renovation|new_installation|repair|upgrade|compliance`',
    CONSTRAINT pk_pip_item PRIMARY KEY(`pip_item_id`)
) COMMENT 'Individual line-item work scope records within a Property Improvement Plan (PIP). Captures item description, area of property affected (guestroom, lobby, F&B outlet, exterior), FF&E category, estimated cost, actual cost, responsible contractor, scheduled start date, scheduled completion date, actual completion date, and item status. Enables granular tracking of PIP execution progress and spend against approved CapEx budget.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique identifier for the property certification or audit record.',
    `food_safety_inspection_id` BIGINT COMMENT 'Foreign key linking to fnb.food_safety_inspection. Business justification: Property-level ISO 22000 certifications require supporting outlet-level inspection records. Certification audits trace property cert to individual outlet inspections. Regulatory compliance audit trail',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to property.franchise_agreement. Business justification: Brand certifications CAN be linked to their governing franchise agreements (e.g., Marriott brand standards certification tied to franchise agreement). This FK will be nullable - many certifications ar',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each certification permit fee is denominated in ONE currency. Normalize currency reference to master currency table. FK named permit_fee_currency_id to distinguish from potential other currency FKs. R',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property that holds this certification or was subject to this audit.',
    `accreditation_body` STRING COMMENT 'Name of the higher-level accreditation body that accredits the issuing authority or audit firm (e.g., ANSI-ASQ National Accreditation Board, UKAS). Provides additional credibility and traceability.',
    `audit_end_date` DATE COMMENT 'Date on which the on-site audit or inspection was completed.',
    `audit_section_scores` STRING COMMENT 'Detailed breakdown of scores by audit section or domain (e.g., Front Desk: 92, Housekeeping: 88, F&B: 85). Stored as structured text or JSON for granular analysis.',
    `audit_start_date` DATE COMMENT 'Date on which the on-site audit or inspection began.',
    `auditor_firm` STRING COMMENT 'Name of the third-party audit firm or consulting company that performed the audit or certification assessment.',
    `auditor_name` STRING COMMENT 'Name of the lead auditor or inspector who conducted the audit or certification assessment.',
    `certificate_number` STRING COMMENT 'The official certificate or audit report number issued by the certifying authority or audit firm.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Indicates whether the certification is active, has expired, is suspended, has been revoked, or is pending approval.. Valid values are `active|expired|suspended|revoked|pending|in_progress`',
    `certification_type` STRING COMMENT 'Category of certification or audit. Covers environmental certifications (LEED, Green Key), food safety (ISO 22000), accessibility (ADA), fire safety, health department permits, liquor licenses, and brand quality assurance audits. [ENUM-REF-CANDIDATE: green_certification|food_safety|accessibility|fire_safety|health_permit|liquor_license|brand_qa_audit|safety_inspection|other — 9 candidates stripped; promote to reference product]',
    `compliance_notes` STRING COMMENT 'Free-text field for additional notes, observations, or context related to the certification or audit. May include auditor comments, property responses, or follow-up actions.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Overall compliance or audit score expressed as a percentage or numeric rating. Represents the propertys performance against the certification or audit criteria.',
    `corrective_action_plan_reference` STRING COMMENT 'Reference number or identifier for the corrective action plan (CAP) developed in response to audit findings. Links to the document or system tracking remediation activities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system.',
    `critical_deficiency_count` STRING COMMENT 'Number of critical deficiencies or non-conformances identified during the audit or inspection. Critical deficiencies require immediate corrective action.',
    `document_url` STRING COMMENT 'URL or file path to the digital copy of the certification certificate, audit report, or permit document stored in the document management system.',
    `expiration_date` DATE COMMENT 'Date on which the certification expires and must be renewed. Null for certifications with no expiration or for one-time audits.',
    `issue_date` DATE COMMENT 'Date on which the certification was granted or the audit was completed and the report was issued.',
    `issuing_authority` STRING COMMENT 'Name of the organization, government agency, or audit firm that issued the certification or conducted the audit (e.g., U.S. Green Building Council, local health department, brand corporate QA team).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last modified or updated in the system.',
    `certification_level` STRING COMMENT 'Level or tier of the certification (e.g., LEED Certified, LEED Silver, LEED Gold, LEED Platinum; Green Key 1-5 stars). Indicates the degree of achievement or compliance.',
    `minor_deficiency_count` STRING COMMENT 'Number of minor deficiencies or observations noted during the audit. Minor deficiencies are recommended for improvement but are not critical.',
    `certification_name` STRING COMMENT 'Full name or title of the certification, accreditation, or audit program (e.g., LEED Gold, Green Key Eco-Rating, ISO 22000 Food Safety, ADA Compliance Certification).',
    `next_inspection_due_date` DATE COMMENT 'Date by which the next scheduled inspection or audit is due. Used for proactive compliance tracking and scheduling.',
    `permit_fee_amount` DECIMAL(18,2) COMMENT 'Fee paid to the issuing authority for the certification, permit, or license. Expressed in the propertys local currency.',
    `reaudit_scheduled_date` DATE COMMENT 'Date on which a follow-up audit or re-inspection is scheduled to verify that corrective actions have been implemented and deficiencies resolved.',
    `regulatory_jurisdiction` STRING COMMENT 'Geographic or administrative jurisdiction under which the certification or permit is issued (e.g., state, county, municipality). Relevant for health permits, liquor licenses, and fire safety inspections.',
    `renewal_status` STRING COMMENT 'Current renewal state of the certification. Indicates whether the certification is active, awaiting renewal, has expired, or has been successfully renewed.. Valid values are `current|pending_renewal|expired|renewed|not_applicable`',
    `scope` STRING COMMENT 'Description of the scope or coverage of the certification or audit (e.g., entire property, F&B operations only, specific building or facility). Clarifies what areas or functions are covered.',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Records of property-level certifications, accreditations, regulatory compliance credentials, and brand quality assurance audit results. Covers green certifications (LEED, Green Key), food safety (ISO 22000), accessibility (ADA), fire safety, health department permits, liquor licenses, and brand QA audit scores. Captures certification/audit type, issuing authority or audit firm, certificate number, issue date, expiration date, renewal status, compliance score, audit section scores, critical deficiency count, corrective action plan reference, and re-audit scheduled date. Supports regulatory reporting, brand standard audits, and compliance tracking.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` (
    `ownership_entity_id` BIGINT COMMENT 'Unique identifier for the ownership entity record. Primary key.',
    `party_id` BIGINT COMMENT 'FK connection added per structural fix',
    `acquisition_date` DATE COMMENT 'Date when the ownership entity acquired its first property or entered the portfolio. Used for investment performance tracking, ROI calculations, and ownership tenure analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ownership entity record was first created in the system. Used for data lineage and audit trail purposes.',
    `entity_name` STRING COMMENT '',
    `entity_type` STRING COMMENT 'Classification of the ownership entity structure. REIT (Real Estate Investment Trust) for publicly traded entities like Host Hotels or Park Hotels, private equity for PE-backed funds, individual for owner-operators, joint venture for multi-party ownership, institutional investor for pension funds or insurance companies, family office for high-net-worth family investment vehicles.. Valid values are `REIT|private_equity|individual|joint_venture|institutional_investor|family_office`',
    `investment_vehicle_name` STRING COMMENT 'Name of the specific investment fund, REIT portfolio, or investment vehicle through which the entity holds properties. Used for portfolio segmentation and fund-level performance reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ownership entity record was last updated. Used for change tracking and data quality monitoring.',
    `legal_entity_name` STRING COMMENT 'Full legal name of the ownership entity as registered with governing authorities. Used for franchise agreements, NOI reporting, and legal documentation.',
    `management_company_affiliation` STRING COMMENT 'Name of the property management company or hotel management firm affiliated with or contracted by the ownership entity. Used to identify management relationships and operational oversight structures.',
    `ownership_notes` STRING COMMENT 'Free-text field for additional ownership details, special arrangements, joint venture terms, or other contextual information relevant to the ownership entity.',
    `ownership_status` STRING COMMENT 'Current lifecycle status of the ownership entity within the portfolio. Active indicates current ownership, inactive for historical records, pending acquisition for entities in due diligence, divested for sold assets, under review for entities undergoing restructuring or compliance review.. Valid values are `active|inactive|pending_acquisition|divested|under_review`',
    `portfolio_acquisition_value_usd` DECIMAL(18,2) COMMENT 'Total acquisition cost in USD for all properties owned by this entity. Aggregated value used for ROI calculations, EBITDA analysis, and investment performance tracking.',
    `primary_contact_email` STRING COMMENT 'Primary email address for the ownership entity contact. Used for financial reporting distribution, asset management updates, and franchise agreement communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person for the ownership entity. Used for asset management communications, NOI reporting, and operational escalations.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the ownership entity contact. Used for urgent communications and operational escalations.',
    `registered_address_line1` STRING COMMENT 'First line of the legal registered address for the ownership entity. Used for legal correspondence, tax filings, and franchise agreement documentation.',
    `registered_address_line2` STRING COMMENT 'Second line of the legal registered address (suite, floor, building) for the ownership entity. Optional field for additional address details.',
    `registered_city` STRING COMMENT 'City of the legal registered address for the ownership entity.',
    `registered_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the legal registered address of the ownership entity (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code of the legal registered address for the ownership entity.',
    `registered_state_province` STRING COMMENT 'State or province of the legal registered address for the ownership entity. Used for state-level tax reporting and regulatory compliance.',
    `reit_compliance_flag` BOOLEAN COMMENT 'Indicates whether the ownership entity is subject to REIT regulatory compliance requirements (e.g., income distribution rules, asset composition tests). True for entities that must comply with REIT regulations.',
    `sox_compliance_required` BOOLEAN COMMENT 'Indicates whether the ownership entity is subject to Sarbanes-Oxley Act financial controls and reporting requirements. True for publicly traded entities or entities with publicly traded parent companies.',
    `tax_identification_number` STRING COMMENT 'Federal tax identification number (EIN in USA) or equivalent tax identifier for the ownership entity. Used for tax reporting, franchise agreements, and financial compliance.',
    `total_properties_owned` STRING COMMENT 'Current count of properties owned by this entity within the portfolio. Used for portfolio concentration analysis and ownership diversification metrics.',
    CONSTRAINT pk_ownership_entity PRIMARY KEY(`ownership_entity_id`)
) COMMENT 'Master records for property ownership entities including REITs (e.g., Host Hotels, Park Hotels), private equity sponsors, individual owner-operators, and joint venture structures. Captures legal entity name, EIN/tax ID, entity type (REIT, PE fund, individual, JV), ownership percentage per property, acquisition date, acquisition price, investment vehicle, management company affiliation, primary contact, and registered address. Supports franchise agreement counterparty identification, NOI/FFO reporting to owners, asset management communications, and REIT compliance reporting.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` (
    `meeting_space_id` BIGINT COMMENT 'Unique identifier for the meeting space. Primary key.',
    `cleaning_standard_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_standard. Business justification: Meeting spaces require event-specific cleaning protocols (pre-event setup cleaning, post-event breakdown cleaning, turnover between events). Banquet and conference services depend on this link to sche',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Meeting and event spaces are profit centers for MICE revenue tracking. Real hospitality operations attribute event revenue, catering, and AV charges to specific spaces for profitability analysis. Crit',
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
    `fnb_outlet_id` BIGINT COMMENT 'add column fnb_outlet_id (BIGINT) with FK to fnb.fnb_outlet.fnb_outlet_id - property outlet and fnb outlet overlap; link to resolve SSOT.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Every F&B outlet has an assigned manager tracked for P&L accountability, labor scheduling, operational oversight, and guest service escalations. Replaces denormalized manager contact fields with prope',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Outlets operate as distinct organizational units with dedicated labor budgets, schedules, and cost centers. Required for labor cost allocation, schedule generation, and USALI departmental reporting. R',
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
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each GDS profile displays rates in ONE currency. Normalize currency reference to master currency table. Remove currency_code string - will be retrieved via JOIN.',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: GDS distribution requires detailed outlet content (cuisine, hours, dress code, reservation policy) for booking channel display. has_restaurant boolean is insufficient; link to outlet master data enabl',
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
    `distribution_channel_type` STRING COMMENT 'Indicates the primary distribution channel scope this profile record covers. gds = GDS-only profile (Sabre/Amadeus/Galileo); crs = CRS direct booking profile; ota = OTA partner profile; direct = brand.com direct booking; all = unified profile across all channels.. Valid values are `gds|crs|ota|direct|all`',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`media` (
    `media_id` BIGINT COMMENT 'Unique identifier for the property media asset record. Primary key.',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Media assets CAN be meeting-space-specific (e.g., ballroom photos for sales materials). This FK will be nullable - most media is property-level or facility-level. hotel_id remains for property-level m',
    `parent_media_id` BIGINT COMMENT 'Self-referencing FK on media (parent_media_id)',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Media assets CAN be facility-specific (e.g., pool photo, restaurant photo). This FK will be nullable - hero images and property-wide media are not facility-specific. hotel_id remains for property-leve',
    `property_id` BIGINT COMMENT 'Reference to the property this media asset belongs to. Links to the property master data.',
    `alt_text` STRING COMMENT 'Descriptive alternative text for the media asset used for accessibility compliance (ADA) and SEO optimization.',
    `approval_date` DATE COMMENT 'Date when the media asset received final approval for distribution to OTA (Online Travel Agency) and GDS (Global Distribution System) channels.',
    `approval_status` STRING COMMENT 'Brand compliance and quality approval status for distribution to external channels.. Valid values are `approved|pending|rejected|not_submitted`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the media asset for channel distribution.',
    `aspect_ratio` STRING COMMENT 'Proportional relationship between width and height (e.g., 16:9, 4:3) used for responsive display optimization.',
    `asset_code` STRING COMMENT 'Unique business identifier for the media asset used across DAM (Digital Asset Management) system and distribution channels.. Valid values are `^[A-Z0-9_-]{6,20}$`',
    `brand_website_approved` BOOLEAN COMMENT 'Flag indicating whether the media asset is approved for display on the brand.com direct booking website.',
    `caption` STRING COMMENT 'Marketing caption or description text displayed with the media asset on guest-facing channels.',
    `capture_date` DATE COMMENT 'Date when the photo or video was originally captured, used for content freshness tracking.',
    `media_category` STRING COMMENT 'Functional area or space that the media asset depicts, used for organizing content by property feature. [ENUM-REF-CANDIDATE: property_exterior|lobby|guestroom|suite|pool|fitness_center|restaurant|meeting_space|spa|amenity|event_space|other — 12 candidates stripped; promote to reference product]',
    `cdn_path` STRING COMMENT 'CDN-optimized path for fast global delivery of the media asset to OTA (Online Travel Agency) and brand.com channels.',
    `copyright_holder` STRING COMMENT 'Legal entity or individual holding copyright ownership of the media asset.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the media asset record was first created in the system, used for audit trail and data lineage.',
    `display_order` STRING COMMENT 'Sequence number controlling the order in which media assets are displayed in galleries and listings.',
    `effective_end_date` DATE COMMENT 'Date when the media asset is scheduled to be retired or removed from active distribution channels.',
    `effective_start_date` DATE COMMENT 'Date from which the media asset becomes active and available for distribution to channels.',
    `file_format` STRING COMMENT 'Technical file format of the media asset (e.g., JPEG, PNG, MP4) used for compatibility validation. [ENUM-REF-CANDIDATE: JPEG|PNG|GIF|MP4|MOV|WEBP|SVG|PDF — 8 candidates stripped; promote to reference product]',
    `file_name` STRING COMMENT 'Original file name of the media asset as stored in the DAM system.',
    `file_size_kb` DECIMAL(18,2) COMMENT 'Size of the media file in kilobytes, used for performance optimization and storage management.',
    `file_url` STRING COMMENT 'Full URL path to the media asset file location for retrieval and display.',
    `gds_approved` BOOLEAN COMMENT 'Flag indicating whether the media asset is approved for syndication to GDS channels (Amadeus, Sabre, Galileo).',
    `is_hero_image` BOOLEAN COMMENT 'Flag indicating whether this media asset is the primary hero image for the property used in search results and main property pages.',
    `is_seasonal` BOOLEAN COMMENT 'Flag indicating whether the media asset is seasonal content (e.g., holiday decorations, summer pool scenes) with limited display periods.',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code for media assets with language-specific content (e.g., signage, menus in photos).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the media asset record was last modified, used for change tracking and synchronization across channels.',
    `last_updated_date` DATE COMMENT 'Date when the media asset metadata or file was last modified in the system.',
    `license_expiration_date` DATE COMMENT 'Date when the usage license for the media asset expires, requiring renewal or removal from channels.',
    `license_type` STRING COMMENT 'Type of usage license governing how the media asset can be used and distributed.. Valid values are `owned|licensed|royalty_free|rights_managed|creative_commons`',
    `media_status` STRING COMMENT 'Current lifecycle status of the media asset in the content management workflow.. Valid values are `active|inactive|pending_approval|rejected|archived`',
    `media_type` STRING COMMENT 'Classification of the media asset type used for content management and channel distribution.. Valid values are `hero_image|gallery_photo|virtual_tour|floor_plan|video|360_panorama`',
    `ota_approved` BOOLEAN COMMENT 'Flag indicating whether the media asset is approved for syndication to OTA partner channels (Expedia, Booking.com, etc.).',
    `photographer_name` STRING COMMENT 'Name of the photographer or content creator who produced the media asset, used for attribution and rights management.',
    `resolution_height` STRING COMMENT 'Height of the media asset in pixels, used for quality control and channel distribution requirements.',
    `resolution_width` STRING COMMENT 'Width of the media asset in pixels, used for quality control and channel distribution requirements.',
    `seo_keywords` STRING COMMENT 'Keywords associated with the media asset for search engine optimization and discoverability on brand.com and OTA platforms.',
    `tags` STRING COMMENT 'Comma-separated list of descriptive tags for content categorization, search optimization, and channel filtering (e.g., luxury, family-friendly, beachfront).',
    `thumbnail_url` STRING COMMENT 'URL path to the thumbnail version of the media asset used for preview and gallery navigation.',
    `upload_date` DATE COMMENT 'Date when the media asset was uploaded to the DAM (Digital Asset Management) system.',
    `view_count` BIGINT COMMENT 'Total number of times the media asset has been viewed across all distribution channels, used for content performance analytics.',
    CONSTRAINT pk_media PRIMARY KEY(`media_id`)
) COMMENT 'Catalog of property-level media assets including hero images, gallery photos, virtual tours, floor plans, and video content used for channel distribution, OTA listings, and marketing. Captures media type, file URL, CDN path, alt text, display order, applicable area (exterior, lobby, guestroom, pool), resolution, last updated date, and channel approval status. Sourced from DAM (Digital Asset Management) system and syndicated to GDS, OTA, and brand.com channels.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` (
    `seasonal_calendar_id` BIGINT COMMENT 'Unique identifier for the seasonal calendar entry. Primary key for the seasonal calendar product.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Each seasonal calendar uses ONE currency for ADR/RevPAR estimates. Normalize currency reference to master currency table. Remove currency_code string - will be retrieved via JOIN.',
    `prior_seasonal_calendar_id` BIGINT COMMENT 'Self-referencing FK on seasonal_calendar (prior_seasonal_calendar_id)',
    `property_id` BIGINT COMMENT 'Reference to the property for which this seasonal calendar entry applies. Links to the property master data.',
    `advance_booking_days` STRING COMMENT 'Typical number of days in advance that guests book for this seasonal period. Used for forecasting accuracy and inventory management. Based on historical booking patterns.',
    `blackout_reason` STRING COMMENT 'Explanation for why this period is designated as a blackout date (e.g., Major Convention, Peak Holiday Demand, Special Event). Null if not a blackout period.',
    `cancellation_rate_pct` DECIMAL(18,2) COMMENT 'Historical cancellation rate for reservations during this seasonal period expressed as a percentage. Used for overbooking strategy and revenue forecasting.',
    `climate_description` STRING COMMENT 'Description of typical weather and climate conditions during this seasonal period (e.g., Warm and Sunny, Rainy Season, Snow Season, Hurricane Risk). Used for guest communication and operational planning.',
    `competitive_set_position` STRING COMMENT 'Propertys expected market position relative to its STR competitive set during this seasonal period. Values: leader (outperforming), competitive (at par), lagging (underperforming), premium (high-end positioning), value (budget positioning).. Valid values are `leader|competitive|lagging|premium|value`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this seasonal calendar entry was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `demand_classification` STRING COMMENT 'Categorization of expected demand level during this seasonal period. Drives pricing strategy, staffing models, and inventory controls. Values: peak (high demand), shoulder (moderate demand), off-peak (low demand), super-peak (exceptional demand). [ENUM-REF-CANDIDATE: peak|shoulder|off-peak|super-peak|low|moderate|high — 7 candidates stripped; promote to reference product]',
    `end_date` DATE COMMENT 'Last date of the seasonal period (inclusive). Defines the conclusion of the season for rate strategy and operational planning.',
    `estimated_adr` DECIMAL(18,2) COMMENT 'Forecasted Average Daily Rate for this seasonal period in the propertys local currency. Used for revenue forecasting and rate strategy validation.',
    `estimated_occupancy_pct` DECIMAL(18,2) COMMENT 'Forecasted occupancy rate for this seasonal period expressed as a percentage. Used for revenue forecasting, staffing planning, and inventory management. Based on historical performance and market trends.',
    `estimated_revpar` DECIMAL(18,2) COMMENT 'Forecasted Revenue Per Available Room for this seasonal period in the propertys local currency. Key performance indicator for revenue management strategy validation.',
    `facility_closures` STRING COMMENT 'Comma-separated list of facilities or outlets that are closed during this seasonal period (e.g., Outdoor Pool, Beach Bar, Tennis Courts). Used for guest communication and operational planning.',
    `holiday_name` STRING COMMENT 'Name of the holiday or special event if this is a holiday period (e.g., Christmas, New Year, Independence Day, Local Festival). Null if not a holiday period.',
    `is_blackout_date` BOOLEAN COMMENT 'Indicates whether this period is designated as a blackout date for promotional rates, loyalty redemptions, or discounted packages. Used to protect revenue during high-demand periods.',
    `is_holiday_period` BOOLEAN COMMENT 'Flag indicating whether this seasonal period includes major holidays or special events that drive exceptional demand. Used for premium pricing and staffing adjustments.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who most recently updated this seasonal calendar entry. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this seasonal calendar entry was most recently updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `market_segment_focus` STRING COMMENT 'Primary market segment(s) targeted during this seasonal period (e.g., Leisure, Business, Group, MICE, FIT). Comma-separated if multiple segments. Drives marketing and sales strategy.',
    `maximum_los_restriction` STRING COMMENT 'Maximum number of nights allowed for reservations during this seasonal period. Used to prevent long-stay bookings from blocking high-demand dates. Null if no maximum restriction applies.',
    `minimum_los_restriction` STRING COMMENT 'Minimum number of nights required for reservations during this seasonal period. Used to optimize revenue during high-demand periods. Null if no minimum restriction applies.',
    `no_show_rate_pct` DECIMAL(18,2) COMMENT 'Historical no-show rate for reservations during this seasonal period expressed as a percentage. Used for overbooking strategy and revenue optimization.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, special considerations, or operational instructions for this seasonal period. Used for communication between revenue management, operations, and workforce teams.',
    `operating_status` STRING COMMENT 'Operational mode of the property during this seasonal period. Indicates whether full services are available or if there are seasonal closures or reduced operations.. Valid values are `full-service|limited-service|seasonal-closure|reduced-hours|maintenance`',
    `rate_season_code` STRING COMMENT 'Rate season identifier used by the Revenue Management System (RMS) to apply appropriate Best Available Rate (BAR) levels and dynamic pricing rules. Maps to IDeaS G3 RMS rate season configuration.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `reduced_operating_hours` STRING COMMENT 'Description of any reduced operating hours for facilities or services during this seasonal period (e.g., Restaurant: Dinner Only, Spa: Weekends Only). Null if no reductions apply.',
    `rgi_target` DECIMAL(18,2) COMMENT 'Target Revenue Generation Index for this seasonal period. RGI measures propertys RevPAR performance relative to its competitive set (100 = at par, >100 = outperforming, <100 = underperforming).',
    `season_code` STRING COMMENT 'Short alphanumeric code identifying the season (e.g., PEAK_SUM, SHOULDER_SPR, OFF_WIN). Used for rate plan mapping and operational planning.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `season_name` STRING COMMENT 'Descriptive name of the seasonal period (e.g., Summer Peak Season, Winter Off-Peak, Holiday Super Peak). Human-readable label for reporting and communication.',
    `season_year` STRING COMMENT 'Calendar year to which this seasonal period applies. Supports year-over-year comparison and multi-year planning.',
    `seasonal_calendar_status` STRING COMMENT 'Current lifecycle status of this seasonal calendar entry. Values: active (in use), draft (being planned), archived (historical), cancelled (no longer applicable).. Valid values are `active|draft|archived|cancelled`',
    `seasonal_hiring_required` BOOLEAN COMMENT 'Indicates whether additional seasonal staff hiring is required for this period. Used by HR and workforce planning teams to initiate recruitment.',
    `special_events` STRING COMMENT 'Description of major local or property-specific events occurring during this seasonal period that impact demand (e.g., Annual Music Festival, Marathon Weekend, Convention Center Trade Show). Null if no special events.',
    `staffing_level` STRING COMMENT 'Planned staffing level for this seasonal period. Drives workforce scheduling and seasonal hiring decisions. Values: full (standard staffing), reduced (lower than standard), minimal (skeleton crew), peak-augmented (additional seasonal staff).. Valid values are `full|reduced|minimal|peak-augmented`',
    `start_date` DATE COMMENT 'First date of the seasonal period (inclusive). Defines the beginning of the season for rate strategy and operational planning.',
    `yoy_demand_trend` STRING COMMENT 'Trend classification comparing this seasons expected demand to the same period in the prior year. Used for strategic planning and market positioning. Values: increasing (demand up), stable (demand flat), decreasing (demand down), volatile (unpredictable), new-season (no historical data).. Valid values are `increasing|stable|decreasing|volatile|new-season`',
    `yoy_demand_variance_pct` DECIMAL(18,2) COMMENT 'Percentage change in expected demand compared to the same seasonal period in the prior year. Positive values indicate growth, negative values indicate decline. Null for new seasons without historical data.',
    `created_by` STRING COMMENT 'Username or identifier of the revenue manager or system user who created this seasonal calendar entry. Used for audit trail and accountability.',
    CONSTRAINT pk_seasonal_calendar PRIMARY KEY(`seasonal_calendar_id`)
) COMMENT 'Defines property-level seasonal periods and operating calendars that drive rate strategy, staffing models, and operational planning. Captures season name, start date, end date, demand classification (peak, shoulder, off-peak, super-peak), applicable rate season code, holiday indicator, blackout date flag, seasonal facility closures, reduced operating hours, and year-over-year demand trend. Used by revenue management (IDeaS G3 RMS) for rate strategy and BAR level setting, by workforce domain for labor scheduling and seasonal hiring, and by operations for outlet hours and facility availability. Each property maintains its own seasonal calendar reflecting local demand patterns, events, and climate.';

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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` (
    `vendor_agreement_id` BIGINT COMMENT 'Unique identifier for this property-vendor agreement record. Primary key.',
    `property_id` BIGINT COMMENT 'Foreign key linking to the hotel property that has negotiated terms with this vendor',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing goods or services under this agreement',
    `contract_reference_number` STRING COMMENT 'The unique identifier of the formal contract or service agreement governing this property-vendor relationship. Links to contract management systems for compliance tracking.',
    `created_date` TIMESTAMP COMMENT 'The timestamp when this property-vendor agreement record was created in the system.',
    `delivery_lead_time_days` STRING COMMENT 'The standard number of days between order placement and delivery for this vendor to this property. Used for inventory planning and order scheduling.',
    `last_modified_by` STRING COMMENT 'The user ID or system identifier that last modified this property-vendor agreement record.',
    `last_modified_date` TIMESTAMP COMMENT 'The timestamp when this property-vendor agreement record was last updated.',
    `last_performance_review_date` DATE COMMENT 'The date of the most recent formal performance review conducted by the property for this vendor. Used to schedule periodic vendor evaluations.',
    `local_contact_email` STRING COMMENT 'The email address for the local vendor representative servicing this property. Used for order confirmations, delivery notifications, and operational communications.',
    `local_contact_name` STRING COMMENT 'The name of the vendor representative assigned to service this specific property. May differ from the vendors primary contact in the vendor master record.',
    `local_contact_phone` STRING COMMENT 'The direct phone number for the local vendor representative servicing this property. Used for urgent order inquiries, delivery coordination, and issue escalation.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'The minimum order value required by this vendor for deliveries to this property. Used to enforce ordering thresholds and optimize procurement batching.',
    `payment_terms_override` STRING COMMENT 'Property-specific payment terms that override the vendors standard payment terms. Examples: Net 30, Net 45, 2/10 Net 30. Null if standard vendor payment terms apply.',
    `performance_rating` DECIMAL(18,2) COMMENT 'The property-specific performance rating for this vendor on a 1.00 to 5.00 scale. Based on delivery timeliness, product quality, service responsiveness, and invoice accuracy. Used for vendor evaluation and sourcing decisions.',
    `preferred_vendor_tier` STRING COMMENT 'The vendor preference tier assigned to this vendor for this specific property. Indicates procurement priority and influences ordering workflows. Values: Preferred, Standard, Approved, Conditional.',
    `property_specific_discount_pct` DECIMAL(18,2) COMMENT 'The negotiated discount percentage that this vendor provides to this specific property, which may differ from corporate-level or other property-level agreements. Used for invoice validation and cost analysis.',
    `relationship_end_date` DATE COMMENT 'The date on which this property-vendor relationship ended or is scheduled to end. Null for active relationships. Used for historical analysis and vendor transition planning.',
    `relationship_start_date` DATE COMMENT 'The date on which this property began procuring from this vendor under the current agreement terms. Used for relationship tenure analysis and contract renewal planning.',
    `relationship_status` STRING COMMENT 'The current lifecycle status of this property-vendor relationship. Governs whether procurement orders can be placed. Values: Active, Suspended, Under Review, Terminated, Pending Activation.',
    `created_by` STRING COMMENT 'The user ID or system identifier that created this property-vendor agreement record.',
    CONSTRAINT pk_vendor_agreement PRIMARY KEY(`vendor_agreement_id`)
) COMMENT 'This association product represents the Contract between property and vendor. It captures the negotiated commercial terms, service-level agreements, and relationship parameters that govern procurement relationships between individual hotel properties and their suppliers. Each record links one property to one vendor with property-specific pricing, delivery terms, payment conditions, and local contact arrangements that exist only in the context of this specific property-vendor relationship.. Existence Justification: In travel hospitality operations, each hotel property maintains procurement relationships with multiple vendors across different supply categories (food & beverage suppliers, FF&E vendors, housekeeping suppliers, maintenance contractors), and each vendor serves multiple properties across the portfolio. Each property-vendor relationship has negotiated commercial terms including property-specific discount rates, delivery lead times, minimum order values, payment term overrides, and dedicated local vendor contacts that vary by property. The business actively manages these relationships for vendor performance evaluation, contract compliance monitoring, and procurement optimization.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` (
    `property_space_allocation_id` BIGINT COMMENT 'Primary key for property_space_allocation',
    `event_booking_id` BIGINT COMMENT 'Foreign key linking to the event booking receiving the space allocation',
    `event_space_allocation_id` BIGINT COMMENT 'Unique identifier for this space allocation record. Primary key.',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to the meeting space being allocated',
    `allocation_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this space allocation was created in the system. Used for audit trail and booking history.',
    `allocation_date` DATE COMMENT 'The specific date this meeting space is allocated to the event. Critical for multi-day events using the same or different spaces across days.',
    `allocation_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this space allocation was last modified. Tracks changes to timing, setup, or status.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this space allocation. Tracks progression from tentative reservation through setup, event execution, and breakdown. Critical for operations coordination.',
    `end_time` TIMESTAMP COMMENT 'The time when the meeting space allocation ends on the allocation date. Used for scheduling and calculating rental duration.',
    `guaranteed_attendance` STRING COMMENT 'The number of attendees guaranteed for this specific space allocation. Used for capacity validation, F&B planning, and billing. May differ from overall event attendance if event uses multiple concurrent breakout spaces.',
    `rental_charge` DECIMAL(18,2) COMMENT 'The rental fee charged for this specific space allocation. Calculated based on space rental_rate_tier, duration, and negotiated event terms. Each allocation may have different charges.',
    `setup_style` STRING COMMENT 'The seating/table configuration requested for this specific allocation. Determines capacity and drives BEO setup instructions. Same space may have different setups for different event sessions.',
    `special_requirements` STRING COMMENT 'Free-text field capturing specific requests or requirements for this space allocation (e.g., additional AV equipment, special lighting, temperature preferences, accessibility accommodations).',
    `start_time` STRING COMMENT 'The time when the meeting space allocation begins on the allocation date. Used for scheduling and avoiding double-booking.',
    CONSTRAINT pk_property_space_allocation PRIMARY KEY(`property_space_allocation_id`)
) COMMENT 'Single source of truth is event.event_space_allocation. This association product represents the allocation of a specific meeting space to an event booking for a defined time period. It captures the operational assignment of physical function space to MICE events, including setup configuration, timing, attendance guarantees, and rental charges. Each record links one meeting_space to one event_booking with attributes that exist only in the context of this specific space-time allocation.. Existence Justification: In MICE operations, a single multi-day conference event booking routinely requires multiple meeting spaces (e.g., main ballroom for general sessions, multiple breakout rooms for concurrent workshops, boardroom for VIP meetings). Conversely, a high-demand meeting space hosts multiple different event bookings across days and time slots. The allocation itself is an operational entity that event coordinators actively create, modify, and track, with specific attributes like time slots, setup configurations, guaranteed attendance per space, and individual rental charges that belong to neither the space nor the event alone.property_space_allocation]event_space_allocation. [SSOT:space_allocation] Domain-specific specialization of the space_allocation concept; canonical SSOT owner is event.event_space_allocation.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` (
    `channel_connection_id` BIGINT COMMENT 'Unique surrogate identifier for each property-channel connection record',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the distribution channel through which the property sells inventory',
    `property_id` BIGINT COMMENT 'Foreign key linking to the property that is connected to this distribution channel',
    `activation_date` DATE COMMENT 'Date on which this specific property was activated on this specific distribution channel and began accepting bookings through it',
    `commission_rate_override` DECIMAL(18,2) COMMENT 'Property-specific commission rate override for this channel, expressed as a percentage. Overrides the channels standard commission_rate_pct when negotiated at the property level. Null if standard channel rate applies.',
    `connectivity_status` STRING COMMENT 'Current operational status of the connectivity between this property and this channel. Tracks whether the technical integration is live, suspended, or experiencing issues.',
    `content_last_updated` TIMESTAMP COMMENT 'Timestamp of the last content update (room descriptions, images, amenities) pushed from this property to this channel. Used to track content freshness and synchronization status.',
    `contract_reference` STRING COMMENT 'Reference identifier or document number for the commercial contract governing this property-channel relationship. Links to the legal agreement that defines terms, commission rates, and obligations.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this property-channel connection record was first created in the system',
    `deactivation_date` DATE COMMENT 'Date on which this specific property was deactivated or disconnected from this specific distribution channel. Null for active connections.',
    `inventory_allocation_method` STRING COMMENT 'Method by which room inventory is allocated to this channel for this specific property. May differ from the channels default allocation method based on property-level negotiations or technical constraints.',
    `last_booking_received` TIMESTAMP COMMENT 'Timestamp of the most recent booking received from this channel for this property. Used to monitor channel performance and identify inactive connections.',
    `rate_loading_protocol` STRING COMMENT 'The technical protocol used to load rates and availability from the property PMS/CRS to this specific channel. May vary by property-channel combination based on technical capabilities and contractual agreements.',
    `rate_parity_exception` BOOLEAN COMMENT 'Indicates whether this specific property has negotiated an exception to the channels standard rate parity requirements. True if property is exempt from rate parity obligations for this channel.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when this property-channel connection record was last modified',
    CONSTRAINT pk_channel_connection PRIMARY KEY(`channel_connection_id`)
) COMMENT 'This association product represents the Contract between property and channel. It captures the commercial and technical relationship governing how a specific property distributes inventory through a specific distribution channel. Each record links one property to one channel with attributes that exist only in the context of this relationship: activation dates, connectivity configuration, commission overrides, rate loading protocols, and inventory allocation rules.. Existence Justification: In the travel hospitality industry, properties distribute inventory through multiple distribution channels simultaneously (GDS networks, OTA platforms, direct web, wholesalers), and each channel serves multiple properties across the portfolio. The business actively manages these property-channel connections as operational entities with specific configuration, activation dates, connectivity protocols, and property-specific commission overrides that cannot be stored on either the property or channel master records alone.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `legal_ultimate_parent_entity_id` BIGINT COMMENT 'Reference to the top-level parent entity in the corporate ownership structure, representing the ultimate controlling entity.',
    `parent_entity_id` BIGINT COMMENT 'Reference to the parent legal entity if this entity is a subsidiary or controlled entity within a corporate hierarchy.',
    `parent_legal_entity_id` BIGINT COMMENT 'Self-referencing FK on legal_entity (parent_legal_entity_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was first created in the system.',
    `dissolution_date` DATE COMMENT 'The date on which the legal entity was officially dissolved, liquidated, or ceased to exist. Null if entity is still active.',
    `doing_business_as_name` STRING COMMENT 'Trade name or fictitious business name under which the entity operates, if different from legal name.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet for business credit and identification purposes.',
    `entity_subtype` STRING COMMENT 'More granular classification of entity structure (e.g., S-Corp, C-Corp, LLP, GP, LP) specific to jurisdiction.',
    `entity_type` STRING COMMENT 'Classification of the legal structure of the entity (e.g., corporation, LLC, partnership, sole proprietorship, trust, joint venture).',
    `fiscal_year_end_day` STRING COMMENT 'The day of the month (1-31) on which the legal entitys fiscal year ends.',
    `fiscal_year_end_month` STRING COMMENT 'The month (1-12) in which the legal entitys fiscal year ends for financial reporting purposes.',
    `franchisee_name` STRING COMMENT 'Name of the franchisee organization or individual if this entity operates under a franchise model.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO currency code representing the primary currency of the economic environment in which the entity operates.',
    `incorporation_date` DATE COMMENT 'The official date on which the legal entity was incorporated or registered with the governing authority.',
    `incorporation_jurisdiction` STRING COMMENT 'The country, state, or province where the legal entity was originally incorporated or registered.',
    `is_franchise_entity` BOOLEAN COMMENT 'Indicates whether this legal entity operates under a franchise agreement rather than as a wholly-owned subsidiary.',
    `is_publicly_traded` BOOLEAN COMMENT 'Indicates whether the legal entity is publicly traded on a stock exchange.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was most recently updated in the system.',
    `legal_name` STRING COMMENT 'The official registered legal name of the entity as it appears on incorporation documents and legal filings.',
    `lei_code` STRING COMMENT '20-character ISO 17442 Legal Entity Identifier used for financial transaction reporting and regulatory compliance.',
    `naics_code` STRING COMMENT 'Six-digit code classifying the primary business activity of the legal entity according to NAICS standards.',
    `operational_status` STRING COMMENT 'Current operational state of the legal entity indicating whether it is actively conducting business, dormant, suspended, or dissolved.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership held by the parent entity, if applicable. Represents equity stake in subsidiary relationships.',
    `primary_business_activity` STRING COMMENT 'Textual description of the main business activities and operations conducted by the legal entity.',
    `primary_business_address_line_1` STRING COMMENT 'First line of the primary business operating address, which may differ from the registered address.',
    `primary_business_city` STRING COMMENT 'City of the primary business operating address.',
    `primary_business_country_code` STRING COMMENT 'Three-letter ISO country code for the primary business operating country.',
    `primary_contact_email` STRING COMMENT 'Primary email address for official correspondence with the legal entity.',
    `primary_contact_phone` STRING COMMENT 'Main telephone number for contacting the legal entity for business purposes.',
    `registered_address_line_1` STRING COMMENT 'First line of the official registered address of the legal entity as filed with the incorporation authority.',
    `registered_address_line_2` STRING COMMENT 'Second line of the registered address (suite, floor, building name) if applicable.',
    `registered_city` STRING COMMENT 'City or municipality of the registered address.',
    `registered_country_code` STRING COMMENT 'Three-letter ISO country code for the registered address country.',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code of the registered address.',
    `registered_state_province` STRING COMMENT 'State, province, or region of the registered address.',
    `registration_number` STRING COMMENT 'Official government-issued registration or incorporation number assigned to the legal entity by the jurisdiction of incorporation.',
    `regulatory_authority` STRING COMMENT 'Name of the primary government or regulatory body that oversees this legal entitys operations and compliance.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO currency code used for financial reporting by this legal entity.',
    `sic_code` STRING COMMENT 'Four-digit code classifying the primary industry of the legal entity according to SIC standards.',
    `stock_exchange_code` STRING COMMENT 'Code identifying the primary stock exchange where the entitys securities are listed (e.g., NYSE, NASDAQ, LSE), if publicly traded.',
    `stock_ticker_symbol` STRING COMMENT 'The ticker symbol under which the entitys stock is traded, if publicly traded.',
    `tax_identification_number` STRING COMMENT 'Tax identification number assigned by the tax authority in the primary jurisdiction (e.g., EIN in USA, VAT number in EU).',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master reference table for legal_entity. Referenced by legal_entity_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`property`.`party` (
    `party_id` BIGINT COMMENT 'Primary key for party',
    `parent_party_id` BIGINT COMMENT 'Reference to the parent party in a corporate hierarchy, enabling representation of subsidiaries, divisions, and organizational structures.',
    `address_line_1` STRING COMMENT 'The first line of the partys primary physical address, typically containing street number and street name.',
    `address_line_2` STRING COMMENT 'The second line of the partys primary physical address, typically containing suite, floor, building, or apartment information.',
    `annual_revenue_amount` DECIMAL(18,2) COMMENT 'The reported annual revenue of the party in the preferred currency, used for financial assessment and relationship management.',
    `city` STRING COMMENT 'The city or municipality where the party is located.',
    `party_code` STRING COMMENT 'External business identifier or code assigned to the party for operational reference and integration with external systems.',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the country where the party is located or registered.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this party record was first created in the system, used for audit trail and data lineage.',
    `credit_rating` STRING COMMENT 'The credit rating or creditworthiness assessment of the party, typically provided by credit rating agencies or internal risk assessment.',
    `effective_from_date` DATE COMMENT 'The date from which this party record becomes effective and valid for business operations, supporting temporal data management.',
    `effective_to_date` DATE COMMENT 'The date until which this party record remains effective and valid. Null indicates the record is currently active with no planned end date.',
    `employee_count` STRING COMMENT 'The total number of employees working for the party organization, used for sizing and segmentation analysis.',
    `fax_number` STRING COMMENT 'Facsimile number for document transmission, if applicable. Still used in some jurisdictions for legal and compliance documentation.',
    `incorporation_country_code` STRING COMMENT 'Three-letter ISO country code representing the country where the party is legally incorporated or registered, which may differ from the operational country.',
    `incorporation_date` DATE COMMENT 'The date on which the party was legally incorporated or registered with governing authorities. For individuals, this may represent the date of business registration.',
    `industry_classification_code` STRING COMMENT 'Standard industry classification code identifying the primary business sector or industry of the party, typically using NAICS or SIC codes.',
    `is_publicly_traded` BOOLEAN COMMENT 'Boolean indicator of whether the party is a publicly traded company listed on a stock exchange.',
    `is_tax_exempt` BOOLEAN COMMENT 'Boolean indicator of whether the party is exempt from certain taxes based on legal status (e.g., non-profit, government entity).',
    `legal_name` STRING COMMENT 'The full legal name of the party as registered with governing authorities. For individuals, this is the full legal name; for organizations, this is the registered business name.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this party record was last modified, used for audit trail and change tracking.',
    `party_name` STRING COMMENT '',
    `notes` STRING COMMENT 'Free-form text field for capturing additional information, special instructions, or contextual details about the party that do not fit structured fields.',
    `party_status` STRING COMMENT 'Current lifecycle status of the party indicating whether the party is actively engaged in business, temporarily suspended, pending approval, or dissolved.',
    `party_type` STRING COMMENT 'Classification of the party entity indicating whether it represents an individual person, corporate organization, government entity, vendor, partner, or franchise operator.',
    `payment_terms_days` STRING COMMENT 'Standard number of days allowed for payment settlement with this party, used for accounts payable and receivable management.',
    `postal_code` STRING COMMENT 'The postal or ZIP code for the partys address, used for mail delivery and geographic segmentation.',
    `preferred_currency_code` STRING COMMENT 'Three-letter ISO currency code representing the preferred currency for financial transactions with this party.',
    `preferred_language_code` STRING COMMENT 'Two-letter ISO language code representing the preferred language for communication with this party.',
    `primary_contact_name` STRING COMMENT 'The name of the primary contact person at the party organization for business communications and relationship management.',
    `primary_contact_title` STRING COMMENT 'The job title or role of the primary contact person at the party organization.',
    `primary_email` STRING COMMENT 'The primary email address for official communication with the party. This is the main contact channel for digital correspondence.',
    `primary_phone` STRING COMMENT 'The primary telephone number for voice communication with the party. Includes country code and area code where applicable.',
    `registration_number` STRING COMMENT 'Official registration or incorporation number assigned by the jurisdiction where the party is registered. For organizations, this is the company registration number; for individuals operating as sole proprietors, this may be a business license number.',
    `relationship_type` STRING COMMENT 'The nature of the business relationship between this party and the organization, such as property owner, franchise operator, vendor, strategic partner, contractor, or agent.',
    `secondary_phone` STRING COMMENT 'An alternate telephone number for the party, used as a backup contact method or for specific departments.',
    `state_province` STRING COMMENT 'The state, province, or primary administrative subdivision where the party is located.',
    `stock_ticker_symbol` STRING COMMENT 'The stock exchange ticker symbol for the party if publicly traded, used for financial market identification.',
    `tax_identification_number` STRING COMMENT 'Government-issued tax identification number for the party. For US entities, this may be an EIN (Employer Identification Number) or SSN (Social Security Number); for international entities, the equivalent national tax identifier.',
    `time_zone` STRING COMMENT 'The time zone in which the party primarily operates, using IANA time zone database naming convention (e.g., America/New_York, Europe/London).',
    `trade_name` STRING COMMENT 'The commercial or trade name under which the party conducts business, if different from the legal name. Also known as DBA (Doing Business As) name.',
    `website_url` STRING COMMENT 'The official website URL of the party, used for public information and digital presence.',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Master reference table for party. Referenced by operator_party_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ADD CONSTRAINT `fk_property_property_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ADD CONSTRAINT `fk_property_property_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ADD CONSTRAINT `fk_property_hierarchy_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ADD CONSTRAINT `fk_property_hierarchy_parent_node_hierarchy_id` FOREIGN KEY (`parent_node_hierarchy_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` ADD CONSTRAINT `fk_property_hierarchy_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ADD CONSTRAINT `fk_property_property_facility_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ADD CONSTRAINT `fk_property_property_facility_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ADD CONSTRAINT `fk_property_property_facility_property_outlet_id` FOREIGN KEY (`property_outlet_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_outlet`(`property_outlet_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ADD CONSTRAINT `fk_property_franchise_agreement_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ADD CONSTRAINT `fk_property_franchise_agreement_ownership_entity_id` FOREIGN KEY (`ownership_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`ownership_entity`(`ownership_entity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ADD CONSTRAINT `fk_property_franchise_agreement_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ADD CONSTRAINT `fk_property_pip_plan_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ADD CONSTRAINT `fk_property_pip_plan_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ADD CONSTRAINT `fk_property_pip_plan_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ADD CONSTRAINT `fk_property_pip_item_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ADD CONSTRAINT `fk_property_pip_item_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ADD CONSTRAINT `fk_property_pip_item_pip_plan_id` FOREIGN KEY (`pip_plan_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`pip_plan`(`pip_plan_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ADD CONSTRAINT `fk_property_pip_item_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ADD CONSTRAINT `fk_property_pip_item_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ADD CONSTRAINT `fk_property_certification_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ADD CONSTRAINT `fk_property_certification_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ADD CONSTRAINT `fk_property_certification_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ADD CONSTRAINT `fk_property_ownership_entity_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`party`(`party_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ADD CONSTRAINT `fk_property_meeting_space_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ADD CONSTRAINT `fk_property_property_outlet_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ADD CONSTRAINT `fk_property_gds_profile_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ADD CONSTRAINT `fk_property_gds_profile_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ADD CONSTRAINT `fk_property_media_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ADD CONSTRAINT `fk_property_media_parent_media_id` FOREIGN KEY (`parent_media_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`media`(`media_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ADD CONSTRAINT `fk_property_media_property_facility_id` FOREIGN KEY (`property_facility_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property_facility`(`property_facility_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ADD CONSTRAINT `fk_property_media_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ADD CONSTRAINT `fk_property_seasonal_calendar_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ADD CONSTRAINT `fk_property_seasonal_calendar_prior_seasonal_calendar_id` FOREIGN KEY (`prior_seasonal_calendar_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`(`seasonal_calendar_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ADD CONSTRAINT `fk_property_seasonal_calendar_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` ADD CONSTRAINT `fk_property_currency_base_currency_id` FOREIGN KEY (`base_currency_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`currency`(`currency_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ADD CONSTRAINT `fk_property_vendor_agreement_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ADD CONSTRAINT `fk_property_property_space_allocation_meeting_space_id` FOREIGN KEY (`meeting_space_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`meeting_space`(`meeting_space_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ADD CONSTRAINT `fk_property_channel_connection_property_id` FOREIGN KEY (`property_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`property`(`property_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ADD CONSTRAINT `fk_property_legal_entity_legal_ultimate_parent_entity_id` FOREIGN KEY (`legal_ultimate_parent_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ADD CONSTRAINT `fk_property_legal_entity_parent_entity_id` FOREIGN KEY (`parent_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ADD CONSTRAINT `fk_property_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ADD CONSTRAINT `fk_property_party_parent_party_id` FOREIGN KEY (`parent_party_id`) REFERENCES `vibe_travel_hospitality_v1`.`property`.`party`(`party_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`property` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`property` SET TAGS ('dbx_domain' = 'property');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property` ALTER COLUMN `ownership_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ownership Entity Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`hierarchy` SET TAGS ('dbx_structure_preserved' = 'v2');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_facility` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` SET TAGS ('dbx_subdomain' = 'ownership_governance');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`franchise_agreement` ALTER COLUMN `ownership_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisor Entity Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` SET TAGS ('dbx_subdomain' = 'capital_improvement');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `pip_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Plan ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `actual_spend_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend to Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `ada_compliance_included` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Included');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `approved_budget` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|waived|not_applicable');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `brand_standard_compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Compliance Deadline');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `contractor_license_number` SET TAGS ('dbx_business_glossary_term' = 'Contractor License Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `contractor_license_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `contractor_license_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `expected_roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Expected Return on Investment (ROI) Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `expected_roi_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `ffe_actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Furniture Fixtures and Equipment (FF&E) Actual Spend');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `ffe_budget` SET TAGS ('dbx_business_glossary_term' = 'Furniture Fixtures and Equipment (FF&E) Budget');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `fire_safety_upgrade_included` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Upgrade Included');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `impacted_areas` SET TAGS ('dbx_business_glossary_term' = 'Impacted Areas');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `opex_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OpEx) Impact Estimate');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `payback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Payback Period Months');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_manager_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_manager_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_manager_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Project Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'brand_pip|owner_renovation|infrastructure|technology|compliance');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `projected_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Projected Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `revenue_displacement_estimate` SET TAGS ('dbx_business_glossary_term' = 'Revenue Displacement Estimate');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `rooms_out_of_service_count` SET TAGS ('dbx_business_glossary_term' = 'Rooms Out of Service Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `scope_of_work_summary` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work Summary');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `sustainability_certification_target` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `total_estimated_capex` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Capital Expenditure (CapEx)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_plan` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` SET TAGS ('dbx_subdomain' = 'capital_improvement');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `pip_item_id` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Item ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `pip_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor / Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Capital Expenditure (CapEx) Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'CapEx Approval Authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'CapEx Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Tag Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `brand_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Requirement Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `capex_budget_code` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Budget Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Deadline');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contractor Agreement Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contractor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `contractor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `deferral_reason` SET TAGS ('dbx_business_glossary_term' = 'PIP Item Deferral Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `deferred_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Deferred Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capital Expenditure (CapEx) Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `ffe_category` SET TAGS ('dbx_business_glossary_term' = 'Furniture, Fixtures and Equipment (FF&E) Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Brand Inspection Outcome');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional_pass|pending|waived');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Inspection Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'PIP Item Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `item_number` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Item Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `item_number` SET TAGS ('dbx_value_regex' = '^PIP-[A-Z0-9]{2,10}-[0-9]{4}-[0-9]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'PIP Item Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'pending|approved|in_progress|completed|deferred|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `life_safety_flag` SET TAGS ('dbx_business_glossary_term' = 'Life Safety Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'PIP Item Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `property_area` SET TAGS ('dbx_business_glossary_term' = 'Property Area');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `punch_list_notes` SET TAGS ('dbx_business_glossary_term' = 'Punch List Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'PIP Item Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `rooms_out_of_order` SET TAGS ('dbx_business_glossary_term' = 'Rooms Out of Order (OOO) Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `sustainability_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|room|sqft|sqm|linear_ft|lot');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `work_type` SET TAGS ('dbx_business_glossary_term' = 'PIP Work Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`pip_item` ALTER COLUMN `work_type` SET TAGS ('dbx_value_regex' = 'replacement|renovation|new_installation|repair|upgrade|compliance');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` SET TAGS ('dbx_subdomain' = 'capital_improvement');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `food_safety_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Inspection Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `audit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `audit_section_scores` SET TAGS ('dbx_business_glossary_term' = 'Audit Section Scores');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `audit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `auditor_firm` SET TAGS ('dbx_business_glossary_term' = 'Auditor Firm');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending|in_progress');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `corrective_action_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `critical_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Deficiency Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `minor_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Deficiency Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `permit_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `reaudit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Audit Scheduled Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'current|pending_renewal|expired|renewed|not_applicable');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`certification` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` SET TAGS ('dbx_subdomain' = 'ownership_governance');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `ownership_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ownership Entity ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `entity_name` SET TAGS ('dbx_business_glossary_term' = 'Entity Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'REIT|private_equity|individual|joint_venture|institutional_investor|family_office');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `investment_vehicle_name` SET TAGS ('dbx_business_glossary_term' = 'Investment Vehicle Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `management_company_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Management Company Affiliation');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `management_company_affiliation` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `ownership_notes` SET TAGS ('dbx_business_glossary_term' = 'Ownership Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `ownership_status` SET TAGS ('dbx_business_glossary_term' = 'Ownership Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `ownership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_acquisition|divested|under_review');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `portfolio_acquisition_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Acquisition Value (USD)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `portfolio_acquisition_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `reit_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Investment Trust (REIT) Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `sox_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Compliance Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN) / Employer Identification Number (EIN)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`ownership_entity` ALTER COLUMN `total_properties_owned` SET TAGS ('dbx_business_glossary_term' = 'Total Properties Owned');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` SET TAGS ('dbx_subdomain' = 'space_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`meeting_space` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` SET TAGS ('dbx_subdomain' = 'space_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` SET TAGS ('dbx_mvm_ssot_role' = 'designated');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` SET TAGS ('dbx_ssot_concept' = 'outlet');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` SET TAGS ('dbx_ssot_duplicate' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` SET TAGS ('dbx_ssot' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` SET TAGS ('dbx_ssot_authority' = 'single_source_of_truth');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` SET TAGS ('dbx_ssot_group' = 'outlet');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` SET TAGS ('dbx_ssot_canonical' = 'property.property_outlet');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `property_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Property Outlet ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_outlet` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `gds_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `distribution_channel_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`gds_profile` ALTER COLUMN `distribution_channel_type` SET TAGS ('dbx_value_regex' = 'gds|crs|ota|direct|all');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` SET TAGS ('dbx_subdomain' = 'space_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `media_id` SET TAGS ('dbx_business_glossary_term' = 'Property Media ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `parent_media_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Media Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `parent_media_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `alt_text` SET TAGS ('dbx_business_glossary_term' = 'Alternative Text');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|not_submitted');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `asset_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `brand_website_approved` SET TAGS ('dbx_business_glossary_term' = 'Brand Website Approved Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `caption` SET TAGS ('dbx_business_glossary_term' = 'Media Caption');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `capture_date` SET TAGS ('dbx_business_glossary_term' = 'Capture Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `media_category` SET TAGS ('dbx_business_glossary_term' = 'Media Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `cdn_path` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Path');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `copyright_holder` SET TAGS ('dbx_business_glossary_term' = 'Copyright Holder');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Kilobytes (KB)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `file_url` SET TAGS ('dbx_business_glossary_term' = 'File Uniform Resource Locator (URL)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `gds_approved` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Approved Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `is_hero_image` SET TAGS ('dbx_business_glossary_term' = 'Is Hero Image Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `is_hero_image` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `is_seasonal` SET TAGS ('dbx_business_glossary_term' = 'Is Seasonal Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'owned|licensed|royalty_free|rights_managed|creative_commons');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `license_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `media_status` SET TAGS ('dbx_business_glossary_term' = 'Media Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `media_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|rejected|archived');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `media_type` SET TAGS ('dbx_value_regex' = 'hero_image|gallery_photo|virtual_tour|floor_plan|video|360_panorama');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `ota_approved` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Approved Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `photographer_name` SET TAGS ('dbx_business_glossary_term' = 'Photographer Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `resolution_height` SET TAGS ('dbx_business_glossary_term' = 'Resolution Height');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `resolution_width` SET TAGS ('dbx_business_glossary_term' = 'Resolution Width');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `seo_keywords` SET TAGS ('dbx_business_glossary_term' = 'Search Engine Optimization (SEO) Keywords');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Content Tags');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Uniform Resource Locator (URL)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `upload_date` SET TAGS ('dbx_business_glossary_term' = 'Upload Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`media` ALTER COLUMN `view_count` SET TAGS ('dbx_business_glossary_term' = 'View Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` SET TAGS ('dbx_subdomain' = 'space_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `seasonal_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Calendar ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `prior_seasonal_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Seasonal Calendar Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `prior_seasonal_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `advance_booking_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `blackout_reason` SET TAGS ('dbx_business_glossary_term' = 'Blackout Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `cancellation_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Rate Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `climate_description` SET TAGS ('dbx_business_glossary_term' = 'Climate Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `competitive_set_position` SET TAGS ('dbx_business_glossary_term' = 'Competitive Set Position');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `competitive_set_position` SET TAGS ('dbx_value_regex' = 'leader|competitive|lagging|premium|value');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `demand_classification` SET TAGS ('dbx_business_glossary_term' = 'Demand Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Season End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `estimated_adr` SET TAGS ('dbx_business_glossary_term' = 'Estimated Average Daily Rate (ADR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `estimated_occupancy_pct` SET TAGS ('dbx_business_glossary_term' = 'Estimated Occupancy Percentage (OCC)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `estimated_revpar` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Per Available Room (RevPAR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `facility_closures` SET TAGS ('dbx_business_glossary_term' = 'Facility Closures');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `holiday_name` SET TAGS ('dbx_business_glossary_term' = 'Holiday Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `is_blackout_date` SET TAGS ('dbx_business_glossary_term' = 'Blackout Date Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `is_holiday_period` SET TAGS ('dbx_business_glossary_term' = 'Holiday Period Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `market_segment_focus` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Focus');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `maximum_los_restriction` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length of Stay (LOS) Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `minimum_los_restriction` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay (LOS) Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `no_show_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'No-Show Rate Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Calendar Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `operating_status` SET TAGS ('dbx_business_glossary_term' = 'Operating Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `operating_status` SET TAGS ('dbx_value_regex' = 'full-service|limited-service|seasonal-closure|reduced-hours|maintenance');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `rate_season_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Season Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `rate_season_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `reduced_operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Reduced Operating Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `rgi_target` SET TAGS ('dbx_business_glossary_term' = 'Revenue Generation Index (RGI) Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `season_name` SET TAGS ('dbx_business_glossary_term' = 'Season Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `season_year` SET TAGS ('dbx_business_glossary_term' = 'Season Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `seasonal_calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Calendar Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `seasonal_calendar_status` SET TAGS ('dbx_value_regex' = 'active|draft|archived|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `seasonal_hiring_required` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Hiring Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `special_events` SET TAGS ('dbx_business_glossary_term' = 'Special Events');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `staffing_level` SET TAGS ('dbx_business_glossary_term' = 'Staffing Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `staffing_level` SET TAGS ('dbx_value_regex' = 'full|reduced|minimal|peak-augmented');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Season Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `yoy_demand_trend` SET TAGS ('dbx_business_glossary_term' = 'Year-Over-Year (YoY) Demand Trend');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `yoy_demand_trend` SET TAGS ('dbx_value_regex' = 'increasing|stable|decreasing|volatile|new-season');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `yoy_demand_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Year-Over-Year (YoY) Demand Variance Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`seasonal_calendar` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` SET TAGS ('dbx_subdomain' = 'space_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`currency` SET TAGS ('dbx_structure_preserved' = 'v2');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` SET TAGS ('dbx_association_edges' = 'property.property,procurement.vendor');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Property Vendor Agreement ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Vendor Agreement - Hotel Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Property Vendor Agreement - Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `local_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Local Contact Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `local_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `local_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `local_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `local_contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `local_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Local Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `local_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `local_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `local_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Local Contact Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `local_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `local_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `local_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `local_contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `payment_terms_override` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Override');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `preferred_vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `property_specific_discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Property Specific Discount Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`vendor_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` SET TAGS ('dbx_subdomain' = 'space_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` SET TAGS ('dbx_association_edges' = 'property.meeting_space,event.event_booking');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` SET TAGS ('dbx_mvm_ssot_role' = 'designated');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` SET TAGS ('dbx_ssot_concept' = 'space_allocation');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` SET TAGS ('dbx_ssot_duplicate' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` SET TAGS ('dbx_ssot' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` SET TAGS ('dbx_ssot_authority' = 'single_source_of_truth');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` SET TAGS ('dbx_ssot_group' = 'space_allocation');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` SET TAGS ('dbx_ssot_canonical' = 'property.property_space_allocation');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `property_space_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'property_space_allocation Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation - Event Booking Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `event_space_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation - Meeting Space Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `allocation_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `allocation_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `guaranteed_attendance` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Attendance');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `rental_charge` SET TAGS ('dbx_business_glossary_term' = 'Rental Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `setup_style` SET TAGS ('dbx_business_glossary_term' = 'Setup Style');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `special_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`property_space_allocation` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` SET TAGS ('dbx_association_edges' = 'property.property,channel.channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `channel_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Property Channel Connection ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Property Channel Connection - Distribution Channel Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Channel Connection - Hotel Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `commission_rate_override` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Override');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `connectivity_status` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `content_last_updated` SET TAGS ('dbx_business_glossary_term' = 'Content Last Updated');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `inventory_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Allocation Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `last_booking_received` SET TAGS ('dbx_business_glossary_term' = 'Last Booking Received');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `rate_loading_protocol` SET TAGS ('dbx_business_glossary_term' = 'Rate Loading Protocol');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `rate_parity_exception` SET TAGS ('dbx_business_glossary_term' = 'Rate Parity Exception');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`channel_connection` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` SET TAGS ('dbx_subdomain' = 'ownership_governance');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `legal_ultimate_parent_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Entity Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `legal_ultimate_parent_entity_id` SET TAGS ('dbx_relationship_role' = 'ultimate_parent');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `parent_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Entity Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Duns Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `entity_subtype` SET TAGS ('dbx_business_glossary_term' = 'Entity Subtype');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `fiscal_year_end_day` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Day');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `fiscal_year_end_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Month');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `franchisee_name` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `incorporation_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Jurisdiction');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `is_franchise_entity` SET TAGS ('dbx_business_glossary_term' = 'Is Franchise Entity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `is_publicly_traded` SET TAGS ('dbx_business_glossary_term' = 'Is Publicly Traded');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Lei Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'Naics Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_business_activity` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Activity');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_business_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_business_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_business_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_business_address_line_1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_business_address_line_1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_business_city` SET TAGS ('dbx_business_glossary_term' = 'Primary Business City');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_business_country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_business_country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_address_line_1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_address_line_1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_address_line_2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_address_line_2` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State Province');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Sic Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `stock_exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `stock_ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Stock Ticker Symbol');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` SET TAGS ('dbx_subdomain' = 'ownership_governance');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `parent_party_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Party Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `annual_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `annual_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `party_code` SET TAGS ('dbx_business_glossary_term' = 'Party Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii' = 'contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `incorporation_country_code` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `incorporation_country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `industry_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `is_publicly_traded` SET TAGS ('dbx_business_glossary_term' = 'Is Publicly Traded');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `is_tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Is Tax Exempt');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_business_glossary_term' = 'Party Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Party Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_business_glossary_term' = 'Secondary Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `stock_ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Stock Ticker Symbol');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`property`.`party` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
