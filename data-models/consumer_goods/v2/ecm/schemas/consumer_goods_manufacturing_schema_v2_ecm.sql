-- Schema for Domain: manufacturing | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`manufacturing` COMMENT 'Owns production planning, scheduling, and execution across manufacturing facilities. Manages production orders, batch records, work orders, MES integration (Siemens Opcenter), line performance (OEE), yield tracking, MRP runs, GMP compliance events, changeover management, and shop floor data collection aligned with ISO 22716 standards.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` (
    `manufacturing_facility_id` BIGINT COMMENT 'Unique identifier for the manufacturing facility. Primary key. Role: MASTER_RESOURCE.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: ESG commitments are defined per facility for compliance; linking facility to its commitment enables facility‑level ESG reporting.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Facility compliance reporting must reference the jurisdiction governing its operations for regulatory filings and audit purposes.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Facility manager required for safety compliance, production reporting, and labor accountability; obvious to a consumer‑goods plant manager.',
    `region_id` BIGINT COMMENT 'The region id of the manufacturing facility record',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Required for Supply Network Planning report to map each plant to its network node, enabling ATP, capacity, and logistics calculations; domain experts expect this mapping.',
    `distribution_facility_id` BIGINT COMMENT 'References authoritative SSOT record in distribution.distribution_facility.',
    `address_line_1` STRING COMMENT 'Primary street address line for the manufacturing facility location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or additional location details. Organizational contact data classified as confidential.',
    `capacity_units_per_year` DECIMAL(18,2) COMMENT 'The capacity units per year of the manufacturing facility record',
    `city` STRING COMMENT 'City or municipality where the manufacturing facility is located.',
    `commissioning_date` DATE COMMENT 'Date when the facility was officially commissioned and began production operations.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the manufacturing facility is located (e.g., USA, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the manufacturing facility record was first created in the system.',
    `email_address` STRING COMMENT 'Primary email contact for the manufacturing facility operations team. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `energy_consumption_kwh_per_year` DECIMAL(18,2) COMMENT 'Annual energy consumption of the facility measured in kilowatt-hours, used for sustainability reporting and cost management.',
    `epa_site_number` STRING COMMENT 'EPA facility identifier for environmental compliance tracking and reporting under EPA regulations.',
    `erp_plant_code` STRING COMMENT 'Plant identifier in the SAP S/4HANA ERP system used for integration with MM, PP, SD, and WM modules.',
    `facility_code` STRING COMMENT 'The facility code of the manufacturing facility record',
    `facility_name` STRING COMMENT 'Official business name of the manufacturing facility or plant site.',
    `facility_type` STRING COMMENT 'Classification of the manufacturing facility based on primary production function: mixing (formulation), filling (liquid/semi-solid), packaging (secondary), co-manufacturing (third-party), integrated (end-to-end), or contract (toll manufacturing).. Valid values are `mixing|filling|packaging|co-manufacturing|integrated|contract`',
    `fda_establishment_number` STRING COMMENT 'FDA-issued establishment identifier for facilities manufacturing FDA-regulated products (cosmetics, OTC drugs, food). Required for US market distribution.. Valid values are `^[0-9]{7,10}$`',
    `gmp_certification_date` DATE COMMENT 'Date when the facility received its current GMP certification.',
    `gmp_certified` BOOLEAN COMMENT 'Indicates whether the facility holds current Good Manufacturing Practice certification required for consumer goods production.',
    `gmp_expiration_date` DATE COMMENT 'Date when the current GMP certification expires and requires renewal.',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the facility holds ISO 14001 Environmental Management System certification.',
    `iso_22716_compliance_tier` STRING COMMENT 'Internal classification of the facilitys compliance level with ISO 22716 cosmetics GMP standards: tier_1 (full compliance), tier_2 (partial compliance), tier_3 (basic compliance), non_compliant.. Valid values are `tier_1|tier_2|tier_3|non_compliant`',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the facility holds ISO 9001 Quality Management System certification.',
    `iso_certification` STRING COMMENT 'The iso certification of the manufacturing facility record',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality or compliance audit conducted at the facility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the manufacturing facility record was last updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the facility location in decimal degrees for mapping and logistics optimization.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the facility location in decimal degrees for mapping and logistics optimization.',
    `manufacturing_facility_status` STRING COMMENT 'The manufacturing facility status of the manufacturing facility record',
    `mes_system_integrated` BOOLEAN COMMENT 'Indicates whether the facility is integrated with Siemens Opcenter MES for real-time production tracking and shop floor data collection.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next quality or compliance audit at the facility.',
    `number_of_production_lines` STRING COMMENT 'Total count of active production lines within the facility available for manufacturing operations.',
    `operational_status` STRING COMMENT 'Current operational state of the manufacturing facility in its lifecycle.. Valid values are `active|inactive|maintenance|startup|decommissioned|seasonal`',
    `osha_establishment_number` STRING COMMENT 'OSHA establishment identifier for workplace safety reporting and compliance tracking.',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the facility: owned (company-owned), leased (long-term lease), contract (third-party operated), joint_venture (shared ownership).. Valid values are `owned|leased|contract|joint_venture`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the manufacturing facility. Organizational contact data classified as confidential.',
    `plant_code` STRING COMMENT 'Unique business identifier for the manufacturing plant used across SAP S/4HANA PP module and operational systems. Typically 4-10 alphanumeric characters.. Valid values are `^[A-Z0-9]{4,10}$`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the facility address. Organizational contact data classified as confidential.',
    `primary_product_category` STRING COMMENT 'Main product category or line manufactured at this facility (e.g., skincare, haircare, household cleaning, personal care).',
    `production_capacity_units_per_day` DECIMAL(18,2) COMMENT 'Maximum daily production capacity of the facility measured in finished goods units per day under normal operating conditions.',
    `shift_pattern` STRING COMMENT 'Standard operating shift pattern for the facility: single (8 hours), two_shift (16 hours), three_shift (24 hours), continuous (24/7), flexible (variable).. Valid values are `single|two_shift|three_shift|continuous|flexible`',
    `source_system_code` STRING COMMENT 'The source system code of the manufacturing facility record',
    `square_footage` DECIMAL(18,2) COMMENT 'Total floor area of the manufacturing facility in square feet, including production, warehouse, and administrative spaces.',
    `state_province` STRING COMMENT 'State, province, or regional administrative division where the facility is located.',
    `sustainability_rating` STRING COMMENT 'Internal sustainability performance rating for the facility based on environmental impact, energy efficiency, waste reduction, and sustainable sourcing practices.. Valid values are `platinum|gold|silver|bronze|not_rated`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the facility location (e.g., America/New_York, Europe/Berlin) used for production scheduling and shift planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the manufacturing facility record',
    `water_consumption_cubic_meters_per_year` DECIMAL(18,2) COMMENT 'Annual water consumption of the facility measured in cubic meters, tracked for environmental compliance and sustainability reporting.',
    `workforce_headcount` STRING COMMENT 'Total number of employees (full-time equivalent) assigned to the manufacturing facility.',
    CONSTRAINT pk_manufacturing_facility PRIMARY KEY(`manufacturing_facility_id`)
) COMMENT 'Master record for each manufacturing facility (plant/site) in the Consumer Goods network. Captures plant code, site name, address, GMP certification status, ISO 22716 compliance tier, production capacity (units/day), facility type (mixing, filling, packaging, co-manufacturing), regulatory registration numbers (FDA establishment ID, EPA site ID), and operational status. SSOT for all plant-level master data referenced by production orders, batch records, and OEE metrics. [SSOT] Superseded by authoritative table distribution.distribution_facility for concept facility. SSOT: canonical table is distribution.distribution_facility. [SSOT for concept facility.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` (
    `production_line_id` BIGINT COMMENT 'Unique identifier for the production line. Primary key for the production line master record.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Production line belongs to a specific manufacturing facility; replace generic facility reference with direct link to manufacturing_facility.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Line supervisor drives OEE, quality and shift planning; plant experts expect a dedicated supervisor link per line.',
    `allergen_handling_flag` BOOLEAN COMMENT 'Indicates whether this production line handles products containing allergens. Critical for cross-contamination prevention and regulatory compliance.',
    `allergen_types` STRING COMMENT 'Comma-separated list of allergen types handled on this line (e.g., nuts, dairy, gluten). Used for allergen management and cleaning validation protocols.',
    `asset_tag_number` STRING COMMENT 'Physical asset tag number assigned to the production line for asset management and tracking purposes. Links to the fixed asset register in the ERP system.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `automation_level` STRING COMMENT 'Degree of automation on the production line. Indicates the level of human intervention required and impacts labor planning and quality consistency.. Valid values are `manual|semi_automated|fully_automated|lights_out`',
    `changeover_time_standard_minutes` DECIMAL(18,2) COMMENT 'Standard time in minutes required to change over the production line from one product or batch to another. Used for production scheduling and OEE loss calculation.',
    `cleaning_validation_protocol` STRING COMMENT 'Reference to the cleaning validation protocol document applicable to this production line. Ensures GMP compliance and prevents cross-contamination.',
    `commissioning_date` DATE COMMENT 'Date when the production line was commissioned and became operational. Used for asset lifecycle tracking and depreciation calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production line record was first created in the system. Used for data lineage and audit trail purposes.',
    `crew_size_standard` STRING COMMENT 'Standard number of operators required to run the production line at full capacity. Used for labor planning and cost allocation.',
    `depreciation_method` STRING COMMENT 'Accounting depreciation method applied to this production line asset. Used for financial reporting and asset valuation.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years`',
    `design_capacity` DECIMAL(18,2) COMMENT 'The design capacity of the production line record',
    `design_capacity_units_per_hour` DECIMAL(18,2) COMMENT 'The design capacity units per hour of the production line record',
    `design_speed_units_per_hour` DECIMAL(18,2) COMMENT 'Theoretical maximum production capacity of the line measured in units per hour under ideal conditions. Used for capacity planning and scheduling.',
    `energy_consumption_kwh_per_unit` DECIMAL(18,2) COMMENT 'Average energy consumption per unit produced on this line, measured in kilowatt-hours. Key metric for sustainability reporting and cost analysis.',
    `environmental_control_required` BOOLEAN COMMENT 'Indicates whether the production line requires controlled environmental conditions such as temperature, humidity, or air quality. Critical for GMP compliance and product quality.',
    `gmp_classification` STRING COMMENT 'GMP classification level of the production line indicating the quality and cleanliness standards required for products manufactured on this line. Critical for regulatory compliance and product safety.. Valid values are `gmp_a|gmp_b|gmp_c|gmp_d|non_gmp`',
    `humidity_range_percent` STRING COMMENT 'Acceptable relative humidity range for the production line as a percentage. Format: min-max (e.g., 40-60). Used for environmental monitoring and compliance.',
    `installed_power_kw` DECIMAL(18,2) COMMENT 'Total installed electrical power capacity of the production line in kilowatts. Used for energy consumption tracking and sustainability reporting.',
    `last_major_overhaul_date` DATE COMMENT 'Date of the most recent major overhaul or refurbishment of the production line. Used for maintenance planning and asset condition assessment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production line record was last updated. Used for change tracking and data quality monitoring.',
    `line_code` STRING COMMENT 'Business identifier code for the production line. Unique within the facility and used for operational reference in MES systems and production scheduling.. Valid values are `^[A-Z0-9]{3,12}$`',
    `line_length_meters` DECIMAL(18,2) COMMENT 'Physical length of the production line in meters. Used for facility layout planning and material flow analysis.',
    `line_name` STRING COMMENT 'Human-readable name of the production line. Used for display in dashboards, reports, and operator interfaces.',
    `line_status` STRING COMMENT 'The line status of the production line record',
    `line_type` STRING COMMENT 'Classification of the production line based on its primary manufacturing function. Determines the type of operations and products that can be processed on this line.. Valid values are `filling|blending|packaging|assembly|labeling|palletizing`',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'Average time in hours between equipment failures on this production line. Key reliability metric used for maintenance optimization and capacity planning.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Average time in hours required to repair and restore the production line to operational status after a failure. Used for downtime analysis and maintenance resource planning.',
    `mes_asset_tag` STRING COMMENT 'Unique asset identifier for this production line in the Siemens Opcenter MES system. Used for real-time data collection, production tracking, and integration with shop floor systems.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `modified_by_user` STRING COMMENT 'User identifier of the person who last modified this production line record. Used for audit trail and accountability.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance activity for this production line. Used for maintenance scheduling and production planning coordination.',
    `nominal_oee_target_percent` DECIMAL(18,2) COMMENT 'Target OEE percentage for this production line. OEE is calculated as Availability × Performance × Quality and represents the benchmark for line performance evaluation.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or operational considerations specific to this production line.',
    `operational_status` STRING COMMENT 'Current operational status of the production line. Indicates whether the line is available for production scheduling and execution.. Valid values are `active|inactive|maintenance|decommissioned|startup|idle`',
    `plc_system_type` STRING COMMENT 'Type and model of the PLC system controlling the production line. Used for technical support, integration planning, and system upgrade management.',
    `product_category` STRING COMMENT 'The product category of the production line record',
    `product_category_capability` STRING COMMENT 'Comma-separated list of product categories that can be manufactured on this line. Used for production planning and product-line matching in scheduling systems.',
    `production_line_status` STRING COMMENT 'The production line status of the production line record',
    `quality_inspection_frequency` STRING COMMENT 'Standard frequency for quality control inspections on this production line. Defines the QC sampling plan and compliance with GMP requirements.. Valid values are `continuous|hourly|per_batch|per_shift|daily`',
    `rated_speed_uph` DECIMAL(18,2) COMMENT 'The rated speed uph of the production line record',
    `record_source_system` STRING COMMENT 'Source system from which this production line record originated (e.g., SAP S/4HANA PP, Siemens Opcenter MES). Used for data lineage and integration troubleshooting.',
    `scada_integration_enabled` BOOLEAN COMMENT 'Indicates whether the production line is integrated with the SCADA system for real-time monitoring and control. Enables remote visibility and data collection.',
    `scrap_rate_target_percent` DECIMAL(18,2) COMMENT 'Target scrap rate percentage for this production line. Used for quality performance benchmarking and waste reduction initiatives.',
    `shift_pattern` STRING COMMENT 'Standard operating shift pattern for this production line. Defines the daily operating schedule and impacts capacity calculations.. Valid values are `single_shift|two_shift|three_shift|continuous|custom`',
    `source_system_code` STRING COMMENT 'The source system code of the production line record',
    `temperature_range_celsius` STRING COMMENT 'Acceptable operating temperature range for the production line in Celsius. Format: min-max (e.g., 18-25). Used for environmental monitoring and compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the production line record',
    `useful_life_years` STRING COMMENT 'Expected useful life of the production line in years for depreciation and asset lifecycle planning purposes.',
    CONSTRAINT pk_production_line PRIMARY KEY(`production_line_id`)
) COMMENT 'Master record for each physical production line within a manufacturing facility. Captures line code, line name, facility reference, line type (filling, blending, packaging, assembly), design speed (units/hour), nominal OEE target, GMP classification, MES asset tag (Siemens Opcenter), changeover time standard (minutes), and current operational status. Enables OEE benchmarking, scheduling capacity allocation, and MES integration at the line level.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` (
    `work_center_id` BIGINT COMMENT 'Unique identifier for the work center. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Labor and overhead budgeting links each work center to a finance cost center for expense tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for managing and maintaining this work center, supporting accountability and contact management.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant where this work center is physically located.',
    `production_line_id` BIGINT COMMENT 'Reference to the production line to which this work center belongs, enabling line-level capacity and performance analysis.',
    `available_capacity_hours_per_day` DECIMAL(18,2) COMMENT 'Total available production hours per day for this work center after accounting for planned downtime, breaks, and maintenance windows.',
    `calibration_due_date` DATE COMMENT 'Next scheduled calibration date for measurement and control instruments on this work center, ensuring accuracy and compliance with quality standards.',
    `capacity_category` STRING COMMENT 'The capacity category of the work center record',
    `capacity_per_hour` DECIMAL(18,2) COMMENT 'The capacity per hour of the work center record',
    `capacity_unit` STRING COMMENT 'Unit of measure for the rated capacity indicating how production output is quantified for this work center.. Valid values are `units_per_hour|units_per_shift|kg_per_hour|liters_per_hour|cases_per_hour`',
    `work_center_category` STRING COMMENT 'High-level category grouping work centers by operational domain for capacity planning and resource allocation.. Valid values are `machine|production_line|assembly_station|quality_control|warehouse|maintenance`',
    `clean_room_class` STRING COMMENT 'ISO 14644 clean room classification for work centers in controlled environments, critical for cosmetics and personal care product manufacturing per GMP requirements. [ENUM-REF-CANDIDATE: iso_3|iso_4|iso_5|iso_6|iso_7|iso_8|not_applicable — 7 candidates stripped; promote to reference product]',
    `work_center_code` STRING COMMENT 'Business identifier code for the work center used in production planning and scheduling systems. Externally known unique code.. Valid values are `^[A-Z0-9]{4,20}$`',
    `commissioning_date` DATE COMMENT 'Date when the work center was first commissioned and put into production service, establishing the asset lifecycle baseline.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center record was first created in the system, supporting audit trail and data lineage.',
    `crew_size` STRING COMMENT 'Standard number of operators required to run this work center during normal production operations, used for labor planning and scheduling.',
    `decommissioning_date` DATE COMMENT 'Date when the work center was retired from production service, supporting asset lifecycle tracking and capacity planning.',
    `work_center_description` STRING COMMENT 'Detailed description of the work center including its purpose, capabilities, and operational characteristics.',
    `energy_consumption_kwh_per_hour` DECIMAL(18,2) COMMENT 'Average energy consumption in kilowatt-hours per operating hour, supporting sustainability reporting and cost allocation per ISO 14001 environmental management.',
    `gmp_qualification_status` STRING COMMENT 'Current qualification status of the work center per GMP requirements. IQ (Installation Qualification), OQ (Operational Qualification), PQ (Performance Qualification) track equipment validation stages per ISO 22716.. Valid values are `not_qualified|iq_complete|oq_complete|pq_complete|fully_qualified|requalification_required`',
    `hazardous_area_classification` STRING COMMENT 'Electrical area classification for work centers handling flammable or explosive materials, ensuring compliance with Occupational Safety and Health Administration (OSHA) and ATEX directives. [ENUM-REF-CANDIDATE: non_hazardous|class_1_div_1|class_1_div_2|class_2_div_1|class_2_div_2|atex_zone_0|atex_zone_1|atex_zone_2 — 8 candidates stripped; promote to reference product]',
    `humidity_controlled_flag` BOOLEAN COMMENT 'Indicates whether this work center operates in a humidity-controlled environment requiring environmental monitoring per GMP standards.',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration performed on this work center, supporting traceability and compliance documentation.',
    `maintenance_class` STRING COMMENT 'Classification of the work center by maintenance priority and frequency requirements, driving preventive maintenance scheduling.. Valid values are `critical|high|medium|low`',
    `maintenance_strategy` STRING COMMENT 'Maintenance approach applied to this work center defining how maintenance activities are planned and executed.. Valid values are `preventive|predictive|reactive|condition_based`',
    `manufacturer_name` STRING COMMENT 'Name of the equipment manufacturer, supporting warranty management, spare parts procurement, and technical support.',
    `mes_equipment_code` STRING COMMENT 'Unique equipment identifier in the Siemens Opcenter MES system enabling real-time production tracking and shop floor data collection.. Valid values are `^[A-Z0-9_-]{4,30}$`',
    `model_number` STRING COMMENT 'Manufacturer model number of the work center equipment, enabling precise identification for maintenance, parts ordering, and technical documentation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center record was last modified, supporting change tracking and audit compliance.',
    `work_center_name` STRING COMMENT 'Human-readable name of the work center for identification and reporting purposes.',
    `operator_skill_level_required` STRING COMMENT 'Minimum operator skill level required to operate this work center safely and effectively, supporting workforce planning and training requirements.. Valid values are `entry|intermediate|advanced|expert|certified`',
    `qualification_date` DATE COMMENT 'Date when the work center achieved its current GMP qualification status, establishing the baseline for requalification scheduling.',
    `rated_capacity` DECIMAL(18,2) COMMENT 'Maximum production capacity of the work center expressed in units per time period, used for Material Requirements Planning (MRP) capacity calculations.',
    `requalification_due_date` DATE COMMENT 'Date by which the work center must undergo requalification to maintain GMP compliance and production authorization.',
    `safety_certification` STRING COMMENT 'Safety certifications held by this work center such as CE marking, UL listing, or other regulatory approvals required for operation.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific equipment unit, supporting warranty tracking and asset identification.',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Standard time in minutes required to prepare the work center for production, including changeover and configuration activities.',
    `shift_pattern` STRING COMMENT 'Standard shift pattern for this work center defining operational hours and crew rotation schedules.. Valid values are `single_shift|two_shift|three_shift|continuous|custom`',
    `source_system_code` STRING COMMENT 'The source system code of the work center record',
    `standard_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Standard time in minutes required to complete one production cycle or unit at this work center, used for scheduling and costing.',
    `standard_rate` DECIMAL(18,2) COMMENT 'The standard rate of the work center record',
    `standard_rate_per_hour` DECIMAL(18,2) COMMENT 'The standard rate per hour of the work center record',
    `teardown_time_minutes` DECIMAL(18,2) COMMENT 'Standard time in minutes required to clean, sanitize, and reset the work center after production completion per Good Manufacturing Practice (GMP) requirements.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this work center operates in a temperature-controlled environment requiring environmental monitoring per GMP standards.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the work center record',
    `utilization_rate_percent` DECIMAL(18,2) COMMENT 'Target utilization rate as a percentage of available capacity, used for capacity planning and Overall Equipment Effectiveness (OEE) benchmarking.',
    `work_center_status` STRING COMMENT 'Current operational status of the work center indicating availability for production scheduling and capacity planning.. Valid values are `active|inactive|maintenance|decommissioned|under_qualification|blocked`',
    `work_center_type` STRING COMMENT 'Classification of the work center by its primary function in the manufacturing process. Categorizes equipment by operational role.. Valid values are `mixing_vessel|filling_machine|labeler|capper|palletizer|packaging_line`',
    CONSTRAINT pk_work_center PRIMARY KEY(`work_center_id`)
) COMMENT 'Master record for individual work centers (machines, stations, cells) within a production line. Captures work center code, description, work center type (mixing vessel, filling machine, labeler, capper, palletizer), rated capacity, standard cycle time, maintenance class, MES equipment ID (Siemens Opcenter), GMP equipment qualification status (IQ/OQ/PQ), and calibration due date. Supports MRP capacity planning, scheduling, and equipment qualification tracking per ISO 22716.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` (
    `manufacturing_bom_id` BIGINT COMMENT 'Unique identifier for the bill of materials record. Primary key for the manufacturing BOM entity.',
    `manufacturing_facility_id` BIGINT COMMENT 'The manufacturing facility id of the manufacturing bom record',
    `sku_id` BIGINT COMMENT 'The manufacturing sku id of the manufacturing bom record',
    `primary_manufacturing_sku_id` BIGINT COMMENT 'Reference to the finished good or semi-finished SKU that this BOM defines. Links to the product master for which this material structure applies.',
    `product_bom_id` BIGINT COMMENT 'The product bom id of the manufacturing bom record',
    `supplier_id` BIGINT COMMENT 'Reference to the preferred or sole-source supplier for this component. Used for procurement planning, supplier performance tracking, and supply chain risk management. Nullable if multiple suppliers are available.',
    `allergen_flag` BOOLEAN COMMENT 'Indicates whether this component contains or may contain allergens as defined by FDA and EU REACH regulations. True if allergen present. Used for product labeling, consumer safety warnings, and regulatory compliance.',
    `alternative_item_group` STRING COMMENT 'Identifier for a group of interchangeable components that can substitute for each other in production. Used for supply chain flexibility, multi-sourcing strategies, and material availability optimization.',
    `alternative_item_priority` STRING COMMENT 'The selection priority for this component within its alternative item group. Lower numbers indicate higher priority. Used by MRP to determine preferred material selection when multiple alternatives are available.',
    `approval_date` DATE COMMENT 'The date when this BOM version was formally approved for production use. Establishes the official release date for regulatory compliance and change control purposes.',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved this BOM version for production use. Required for GMP compliance and quality assurance. Typically a product development manager, quality manager, or regulatory affairs specialist.',
    `backflush_indicator` BOOLEAN COMMENT 'Indicates whether this component is automatically consumed (backflushed) when the finished good is confirmed in the MES system, rather than requiring explicit material issue transactions. True if backflushed. Common for high-volume, low-value components.',
    `base_quantity` DECIMAL(18,2) COMMENT 'The reference quantity of the finished good for which the component quantities are defined. Typically 1 unit, 100 units, or 1 batch. All component quantities are expressed per this base quantity.',
    `base_unit_of_measure` STRING COMMENT 'The unit of measure for the base quantity (e.g., EA for each, KG for kilogram, L for liter, BOX for box). Must align with the SKU primary UOM.',
    `base_uom` STRING COMMENT 'The base uom of the manufacturing bom record',
    `bom_number` STRING COMMENT 'The externally-known unique business identifier for this BOM, typically assigned by the PLM or ERP system. Used for cross-system reference and production order material requirements.',
    `bom_status` STRING COMMENT 'Current lifecycle status of the BOM. Active BOMs are used for production planning and MRP runs. Inactive or obsolete BOMs are retained for historical reference and regulatory traceability.. Valid values are `active|inactive|pending|obsolete|under_review`',
    `bom_type` STRING COMMENT 'Classification of the BOM structure. Production BOM is used for standard manufacturing, co-product for joint production scenarios, phantom for intermediate assemblies not stocked, engineering for R&D prototypes, and planning for demand forecasting.. Valid values are `production|co-product|phantom|engineering|planning`',
    `bom_version` STRING COMMENT 'The bom version of the manufacturing bom record',
    `component_effective_end_date` DATE COMMENT 'The date after which this specific component is no longer valid within the BOM structure. Nullable for open-ended components. Used for material phase-out and supplier transition management.',
    `component_effective_start_date` DATE COMMENT 'The date from which this specific component becomes valid within the BOM structure. Supports phased material transitions, supplier changes, and cost optimization initiatives.',
    `component_item_category` STRING COMMENT 'Classification of the component type. Stock items are inventory-managed materials, non-stock are direct procurement items, phantom are intermediate assemblies not physically stocked, text items are instructions, and variable size items have flexible dimensions.. Valid values are `stock|non-stock|phantom|text|variable_size`',
    `component_item_number` STRING COMMENT 'Sequential line number for each component within the BOM structure. Defines the order of components for display, reporting, and regulatory ingredient listing (descending order by weight for INCI compliance).',
    `component_quantity` DECIMAL(18,2) COMMENT 'The quantity of this component required to produce the base quantity of the finished good. Used for MRP explosion, production order material requirements, and COGS calculation.',
    `component_unit_of_measure` STRING COMMENT 'The unit of measure for the component quantity (e.g., KG for raw materials, EA for packaging units, L for liquids). Must align with the component material master UOM.',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of total product cost attributed to this component. Used for COGS calculation, profitability analysis, and cost optimization initiatives. Sum of all component cost allocations should equal 100% for the BOM.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM record was first created in the system. Used for audit trail, change tracking, and regulatory compliance documentation per ISO 9001 requirements.',
    `critical_component_flag` BOOLEAN COMMENT 'Indicates whether this component is critical for product quality, safety, or regulatory compliance. True if critical. Triggers enhanced quality control, supplier qualification requirements, and inventory safety stock policies.',
    `effective_end_date` DATE COMMENT 'The date after which this BOM version is no longer valid for new production orders. Nullable for open-ended BOMs. Used for phase-out management and regulatory compliance transitions.',
    `effective_from` DATE COMMENT 'The effective from of the manufacturing bom record',
    `effective_start_date` DATE COMMENT 'The date from which this BOM version becomes valid for production planning and MRP explosion. Supports planned material transitions and new product launches.',
    `effective_until` DATE COMMENT 'The effective until of the manufacturing bom record',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether this component is classified as a hazardous material requiring special handling, storage, and disposal per OSHA and EPA regulations. True if hazardous. Triggers safety data sheet requirements and GMP compliance protocols.',
    `inci_name` STRING COMMENT 'The standardized INCI name for cosmetic ingredients as required by FDA and EU regulations. Used for product labeling, regulatory submissions, and consumer transparency. Mandatory for personal care and cosmetic products.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM record was last updated. Tracks formulation changes, component substitutions, and regulatory updates. Critical for change control and GMP compliance.',
    `lead_time_days` STRING COMMENT 'The procurement or production lead time for this component in days. Used for MRP scheduling, production order release timing, and inventory planning. Includes supplier lead time plus internal processing time.',
    `lot_size_requirement` STRING COMMENT 'Defines the lot sizing rule for this component in production orders. Exact requires precise quantity, minimum allows overages, multiple requires quantities in specific increments, none has no restriction. Impacts material planning and waste management.. Valid values are `exact|minimum|multiple|none`',
    `manufacturing_bom_status` STRING COMMENT 'The manufacturing bom status of the manufacturing bom record',
    `minimum_lot_size` DECIMAL(18,2) COMMENT 'The minimum quantity that must be procured or produced for this component. Driven by supplier MOQ, production batch constraints, or economic order quantity calculations. Nullable if no minimum applies.',
    `plm_system_reference` STRING COMMENT 'External reference identifier linking this BOM to the source PLM system record. Enables traceability to engineering change orders, formulation documents, and R&D specifications.',
    `regulatory_compliance_notes` STRING COMMENT 'Free-text field capturing regulatory compliance requirements, restrictions, or special handling instructions for this component. Includes FDA registration numbers, EU REACH compliance status, GMP requirements, and safety data sheet references.',
    `scrap_factor_percentage` DECIMAL(18,2) COMMENT 'The expected waste or loss percentage for this component during production. Used to adjust gross material requirements in MRP runs. Typical values range from 0% to 10% depending on material type and process complexity.',
    `source_system_code` STRING COMMENT 'The source system code of the manufacturing bom record',
    `sustainability_certification` STRING COMMENT 'Certification or standard that this component meets for sustainable sourcing (e.g., FSC for paper, RSPO for palm oil, Fair Trade, Organic). Used for corporate sustainability reporting and consumer transparency initiatives.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the manufacturing bom record',
    `version` STRING COMMENT 'Version identifier for the BOM structure. Incremented when material composition changes due to reformulation, cost optimization, or regulatory compliance updates. Supports change control and audit trail.',
    CONSTRAINT pk_manufacturing_bom PRIMARY KEY(`manufacturing_bom_id`)
) COMMENT 'Bill of Materials master record (header + component lines) defining the complete material structure for each finished good or semi-finished SKU. Header captures BOM number, BOM type (production, co-product, phantom), base quantity, unit of measure, validity dates, PLM system reference, and BOM status. Component lines capture item number, material reference (raw material, packaging, semi-finished), component quantity per base quantity, scrap factor percentage, item category (stock, non-stock, phantom), INCI name for cosmetic ingredients, allergen flag, hazardous material flag, and component validity dates. SSOT for MRP explosion, production order material requirements, COGS calculation, and regulatory ingredient disclosure per FDA/EU REACH. This is the single authoritative source for all BOM component data — no separate component entity exists.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` (
    `routing_id` BIGINT COMMENT 'Unique identifier for the production routing master record. Primary key.',
    `manufacturing_facility_id` BIGINT COMMENT 'The manufacturing facility id of the routing record',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created this routing record. Supports audit trail and data lineage.',
    `product_bom_id` BIGINT COMMENT 'Reference to the Bill of Materials (BOM) that defines the raw materials and components consumed by this routing. Links routing to material requirements.',
    `sku_id` BIGINT COMMENT 'Reference to the finished or semi-finished SKU that this routing defines the manufacturing process for.',
    `tertiary_routing_last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this routing record. Supports audit trail and change tracking.',
    `work_center_id` BIGINT COMMENT 'The work center id of the routing record',
    `approval_status` STRING COMMENT 'Approval status of the routing for production use. Approved routings are validated and authorized; pending routings await review; rejected routings require rework.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this routing was approved for production use. Supports audit trail and compliance requirements.',
    `base_quantity` DECIMAL(18,2) COMMENT 'Standard production lot size for which the routing operation times and resource requirements are defined. Used as the basis for scaling production schedules.',
    `base_unit_of_measure` STRING COMMENT 'Unit of measure for the base quantity (e.g., KG, L, EA, M). Aligns with GS1 unit codes.. Valid values are `^[A-Z]{2,5}$`',
    `changeover_time_minutes` DECIMAL(18,2) COMMENT 'Time required to transition production lines from the previous product to this routing. Critical for production scheduling and minimizing downtime.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the standard cost amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this routing record was first created in the system. Supports audit trail and data lineage.',
    `routing_description` STRING COMMENT 'Detailed textual description of the routing, including its purpose, scope, and any special instructions for production planners and shop floor operators.',
    `effective_from` DATE COMMENT 'The effective from of the routing record',
    `effective_until` DATE COMMENT 'The effective until of the routing record',
    `expected_scrap_percentage` DECIMAL(18,2) COMMENT 'Overall expected scrap percentage for the routing, representing anticipated waste or defects. Used for material planning and cost estimation.',
    `expected_yield_percentage` DECIMAL(18,2) COMMENT 'Overall expected yield percentage for the routing, representing the ratio of good output to total input. Used for production planning and variance analysis.',
    `gmp_critical_flag` BOOLEAN COMMENT 'Indicates whether this routing includes GMP-critical operations requiring enhanced documentation, validation, and compliance controls per ISO 22716 and FDA regulations.',
    `ipc_checkpoint_count` STRING COMMENT 'Number of in-process control checkpoints defined in this routing. IPC checkpoints are quality inspection points during production per ISO 22716 and GMP requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this routing record was last modified. Supports audit trail and change tracking.',
    `lot_size_restriction` STRING COMMENT 'Constraint on production lot sizes for this routing. Fixed requires exact base quantity; minimum/maximum define bounds; multiple requires lot sizes to be multiples of base quantity; none allows any lot size.. Valid values are `none|fixed|minimum|maximum|multiple`',
    `maximum_lot_size` DECIMAL(18,2) COMMENT 'Maximum production lot size allowed for this routing. Nullable if no maximum constraint exists.',
    `minimum_lot_size` DECIMAL(18,2) COMMENT 'Minimum production lot size allowed for this routing. Nullable if no minimum constraint exists.',
    `operation_count` STRING COMMENT 'The operation count of the routing record',
    `operation_description` STRING COMMENT 'The operation description of the routing record',
    `operation_number` STRING COMMENT 'The operation number of the routing record',
    `operation_sequence` STRING COMMENT 'JSON array or delimited string capturing the complete sequence of operation steps. Each operation includes: operation_number, work_center_code, operation_description, control_key (internal_processing|external_processing|milestone), setup_time_minutes, machine_time_minutes, labor_time_minutes, yield_quantity, scrap_percentage, gmp_critical_step_flag, ipc_checkpoint_flag. This is the single authoritative source for all routing operation data — no separate operation entity exists.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility where this routing is executed. Aligns with organizational plant master data.. Valid values are `^[A-Z0-9]{4,10}$`',
    `production_scheduler_code` STRING COMMENT 'Code identifying the production scheduling strategy or algorithm used for this routing (e.g., forward scheduling, backward scheduling, finite capacity).. Valid values are `^[A-Z0-9]{4,10}$`',
    `routing_number` STRING COMMENT 'Business identifier for the routing. Externally-known unique code used in production planning and scheduling systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `routing_status` STRING COMMENT 'Current lifecycle status of the routing. Active routings are available for production scheduling; draft routings are under development; inactive routings are temporarily disabled; obsolete routings are retired; under_review routings are pending approval.. Valid values are `draft|active|inactive|obsolete|under_review`',
    `routing_type` STRING COMMENT 'Classification of the routing defining its usage pattern. Standard routings are default production paths; reference routings are templates; rate routings define production rates; alternative routings provide backup paths; special routings are for one-time or custom production runs.. Valid values are `standard|reference|rate|alternative|special`',
    `run_time_per_unit_minutes` DECIMAL(18,2) COMMENT 'The run time per unit minutes of the routing record',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'The setup time minutes of the routing record',
    `source_system_code` STRING COMMENT 'The source system code of the routing record',
    `standard_cost_amount` DECIMAL(18,2) COMMENT 'Standard production cost per base quantity for this routing, including labor, machine, and overhead costs. Used for cost accounting and variance analysis.',
    `total_labor_time_minutes` DECIMAL(18,2) COMMENT 'Cumulative labor time across all operations in the routing, used for workforce planning and standard cost calculation.',
    `total_machine_time_minutes` DECIMAL(18,2) COMMENT 'Cumulative machine processing time across all operations in the routing, used for capacity planning and Overall Equipment Effectiveness (OEE) calculations.',
    `total_setup_time_minutes` DECIMAL(18,2) COMMENT 'Cumulative setup time across all operations in the routing, used for capacity planning and scheduling.',
    `total_standard_lead_time_hours` DECIMAL(18,2) COMMENT 'Total cumulative lead time in hours required to complete all operations in this routing, including setup, processing, and queue times. Used for Material Requirements Planning (MRP) and capacity planning.',
    `total_standard_time_min` DECIMAL(18,2) COMMENT 'The total standard time min of the routing record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the routing record',
    `valid_from_date` DATE COMMENT 'Date from which this routing becomes effective and available for production scheduling.',
    `valid_to_date` DATE COMMENT 'Date until which this routing remains effective. Nullable for open-ended routings.',
    `version` STRING COMMENT 'Version identifier for the routing, enabling tracking of routing changes over time. Supports engineering change management and audit trails.. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Production routing master (header + operation steps) defining the complete manufacturing process sequence for a finished or semi-finished SKU. Header captures routing number, routing type (standard, reference, rate), base quantity, plant, validity dates, and total standard lead time. Operation steps capture operation number, work center assignment, standard values (setup time, machine time, labor time), control key (internal processing, external processing, milestone), yield quantity, scrap percentage, GMP critical step flag, and IPC checkpoint flag. SSOT for production scheduling, capacity planning, standard cost calculation, and GMP batch record generation per ISO 22716. This is the single authoritative source for all routing operation data — no separate operation entity exists. Aligned with SAP PP Routing master.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` (
    `production_order_id` BIGINT COMMENT 'Unique identifier for the production order. Primary key for the production order entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost accounting report requires each production order to be charged to a finance cost center for OPEX allocation.',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Production orders trigger an inspection plan; linking allows the order execution system to retrieve the exact inspection plan governing sampling and testing for that batch.',
    `manufacturing_bom_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_bom. Business justification: Production order consumes a specific manufacturing BOM; adding manufacturing_bom_id FK connects BOM to order and eliminates isolation of manufacturing_bom.',
    `manufacturing_facility_id` BIGINT COMMENT 'The manufacturing facility id of the production order record',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Production Planning Dashboard ties orders to brands to enable demand forecasting and coordinated marketing launch planning.',
    `product_bom_id` BIGINT COMMENT 'Reference to the bill of materials used for this production order. Defines component requirements.',
    `production_line_id` BIGINT COMMENT 'FK to manufacturing.production_line',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Pilot production orders are generated from R&D projects; the Production Planning system needs the project ID to track development cost and schedule.',
    `routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.routing. Business justification: Each production order follows a routing; adding routing_id FK links routing to order and eliminates isolation of routing.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Order fulfillment process requires linking each production order to the originating sales order to track manufacturing against sales commitments.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU being produced in this production order. Links to the product master data.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Order‑level supervisor oversees execution, cost tracking and GMP compliance; required for order‑performance dashboards.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Required for Production Order to Customer Account linkage for OTIF SLA reporting and order fulfillment traceability.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred for the production order. Includes material, labor, and overhead costs. Used for variance analysis.',
    `actual_end` TIMESTAMP COMMENT 'The actual end of the production order record',
    `actual_end_date` DATE COMMENT 'The actual end date of the production order record',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when production execution completed. Used for OEE calculation and performance analysis.',
    `actual_start` TIMESTAMP COMMENT 'The actual start of the production order record',
    `actual_start_date` DATE COMMENT 'The actual start date of the production order record',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when production execution began on the shop floor. Captured from MES system.',
    `batch_number` STRING COMMENT 'Unique batch or lot number assigned to the production run. Critical for traceability and recall management per GMP requirements.. Valid values are `^[A-Z0-9]{8,20}$`',
    `changeover_time_minutes` STRING COMMENT 'Time in minutes required for line changeover before starting this production order. Used for scheduling and efficiency analysis.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Actual quantity produced and confirmed as good output. Represents yield after quality inspection.',
    `cost_object` STRING COMMENT 'Cost object (production order number or process order) used for collecting actual costs. Links to CO-PC product costing.. Valid values are `^[A-Z0-9]{12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the production order was created in the system. First event in order lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost amounts. Typically company code currency.. Valid values are `^[A-Z]{3}$`',
    `downtime_minutes` STRING COMMENT 'Total unplanned downtime in minutes during production execution. Impacts OEE availability component.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether this production order is subject to GMP compliance requirements per ISO 22716 standards. True for regulated products.',
    `inspection_lot_number` STRING COMMENT 'Inspection lot number created for quality control of the production output. Links to QM inspection results.. Valid values are `^[A-Z0-9]{10,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the production order record. Used for change tracking and audit compliance.',
    `material_number` STRING COMMENT 'SAP material number for the finished good being produced. Business identifier for the product in ERP system.. Valid values are `^[A-Z0-9]{8,18}$`',
    `mrp_controller` STRING COMMENT 'Three-character code identifying the MRP controller responsible for planning this material. Links to planner master data.. Valid values are `^[A-Z0-9]{3}$`',
    `notes` STRING COMMENT 'Free-text notes or comments related to the production order. Captures special instructions, issues, or observations from shop floor.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Overall Equipment Effectiveness percentage for this production run. Calculated as Availability × Performance × Quality. Industry standard KPI.',
    `order_number` STRING COMMENT 'Business identifier for the production order. Externally-known unique order number assigned by SAP S/4HANA PP system.. Valid values are `^[A-Z0-9]{10,12}$`',
    `order_quantity` DECIMAL(18,2) COMMENT 'Planned quantity to be produced in base unit of measure. Target output for the production order.',
    `order_status` STRING COMMENT 'Current lifecycle status of the production order. CRTD=Created, REL=Released, PCNF=Partially Confirmed, TECO=Technically Complete, CNF=Confirmed, DLV=Delivered, CLSD=Closed. [ENUM-REF-CANDIDATE: CRTD|REL|PCNF|TECO|CNF|DLV|CLSD — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of production order. PP01=Standard Production, PP03=Rework, PP05=Co-Product, PP10=Process Order, PP20=Batch Order.. Valid values are `PP01|PP03|PP05|PP10|PP20`',
    `planned_cost` DECIMAL(18,2) COMMENT 'Standard or planned cost for producing the order quantity. Calculated from BOM and routing costs.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'The planned quantity of the production order record',
    `plant_code` STRING COMMENT 'Four-character code identifying the manufacturing facility where production occurs. Maps to SAP plant master.. Valid values are `^[A-Z0-9]{4}$`',
    `priority` STRING COMMENT 'Priority level for production scheduling. 1=Highest priority (rush/expedite), 5=Lowest priority (standard). Used for sequencing and resource allocation.. Valid values are `1|2|3|4|5`',
    `production_supervisor` STRING COMMENT 'Name of the production supervisor responsible for overseeing execution of this order on the shop floor.',
    `production_version` STRING COMMENT 'Production version defining the specific BOM and routing combination used. Enables multiple production methods for same material.. Valid values are `^[A-Z0-9]{4}$`',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether quality inspection is mandatory before goods receipt. Drives QM integration and inspection lot creation.',
    `released_by` STRING COMMENT 'User ID of the person who released the production order for execution. Audit trail for production authorization.',
    `released_timestamp` TIMESTAMP COMMENT 'Date and time when the production order was released for shop floor execution. Triggers material availability check and capacity reservation.',
    `scheduled_end` TIMESTAMP COMMENT 'The scheduled end of the production order record',
    `scheduled_end_date` DATE COMMENT 'The scheduled end date of the production order record',
    `scheduled_finish_date` DATE COMMENT 'Planned date when production is scheduled to complete. Used for capacity planning and delivery commitments.',
    `scheduled_start` TIMESTAMP COMMENT 'The scheduled start of the production order record',
    `scheduled_start_date` DATE COMMENT 'Planned date when production is scheduled to begin. Set during production planning and MRP run.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of material scrapped or rejected during production. Used for yield analysis and cost accounting.',
    `settlement_rule` STRING COMMENT 'Rule for settling production order costs. FUL=Full settlement, PAR=Partial settlement, PER=Periodic settlement.. Valid values are `FUL|PAR|PER`',
    `source_system_code` STRING COMMENT 'The source system code of the production order record',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for quantities. Standard ISO codes such as EA (each), KG (kilogram), L (liter), M (meter).. Valid values are `^[A-Z]{2,3}$`',
    `uom` STRING COMMENT 'The uom of the production order record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the production order record',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Actual yield percentage calculated as (confirmed_quantity / order_quantity) * 100. Key performance metric for production efficiency.',
    `created_by` STRING COMMENT 'User ID of the person who created the production order in the system. Audit trail for order origination.',
    CONSTRAINT pk_production_order PRIMARY KEY(`production_order_id`)
) COMMENT 'Core transactional record representing a manufacturing production order issued to produce a specific SKU quantity at a facility. Captures order number, order type (PP01 standard, PP03 rework), SKU reference, plant, production line, scheduled start/finish dates, actual start/finish dates, order quantity, confirmed quantity, scrap quantity, order status (created, released, partially confirmed, technically complete, closed), MRP controller, and cost object. SSOT for production execution tracking in SAP S/4HANA PP.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` (
    `batch_record_id` BIGINT COMMENT 'Unique identifier for the electronic batch manufacturing record (eBMR). Primary key for GMP-compliant batch traceability.',
    `carbon_offset_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset. Business justification: Batch‑level carbon neutrality uses purchased offsets; linking batch to offset record provides traceability and reporting of offset usage.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Batch cost roll‑up uses finance cost center to allocate raw material and labor expenses per batch.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Batch record should reference the specific manufacturing facility for traceability.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand Batch Traceability Report requires linking each batch to its brand for recall, quality and marketing performance analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the quality assurance personnel who performed final batch release. Links to workforce master data.',
    `production_line_id` BIGINT COMMENT 'Reference to the specific production line used for this batch. Links to equipment master data.',
    `production_order_id` BIGINT COMMENT 'Reference to the production order that authorized this batch manufacturing run. Links to SAP PP production order master.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Batch‑to‑PO traceability is needed for audit, recall, and cost allocation linking each manufactured batch to its sourcing PO.',
    `research_formulation_id` BIGINT COMMENT 'Foreign key linking to research.research_formulation. Business justification: Traceability report requires linking each manufacturing batch to the exact formulation used, essential for regulatory compliance and product recall.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Batch traceability for recalls and quality investigations needs to associate each batch with the sales order that generated the demand.',
    `sku_id` BIGINT COMMENT 'Reference to the finished goods SKU produced in this batch. Links to product master data.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Regulatory traceability: links each production batch to its inventory lot batch for recall investigations and quality audits.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual cost per unit incurred for this batch. Includes material, labor, and overhead variances.',
    `batch_number` STRING COMMENT 'Unique manufacturing batch identifier assigned at production initiation. Used for product traceability and recall management per GMP requirements.. Valid values are `^[A-Z0-9]{8,20}$`',
    `batch_size_actual` DECIMAL(18,2) COMMENT 'Actual production quantity achieved for this batch. Used for yield calculation and inventory reconciliation.',
    `batch_size_planned` DECIMAL(18,2) COMMENT 'Planned production quantity for this batch as specified in the production order. Measured in base unit of measure.',
    `batch_status` STRING COMMENT 'Current lifecycle status of the batch. Controls inventory availability and distribution eligibility per GMP workflow.. Valid values are `in_process|released|rejected|quarantine|recalled|expired`',
    `bom_version` STRING COMMENT 'Version of the bill of materials used for this batch. Ensures traceability of raw material specifications.. Valid values are `^[A-Z0-9.]{1,20}$`',
    `changeover_minutes` STRING COMMENT 'Time in minutes required for line changeover before this batch. Key metric for SMED and lean manufacturing initiatives.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this batch record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for cost amounts. Supports multi-currency manufacturing operations.. Valid values are `^[A-Z]{3}$`',
    `downtime_minutes` STRING COMMENT 'Total unplanned downtime in minutes during batch production. Used for OEE calculation and maintenance planning.',
    `electronic_signature_count` STRING COMMENT 'Number of electronic signatures captured during batch record lifecycle. Required for FDA 21 CFR Part 11 compliance.',
    `expiry_date` DATE COMMENT 'Date after which the product should not be used or sold. Critical for FEFO inventory management and consumer safety.',
    `gmp_compliant` BOOLEAN COMMENT 'The gmp compliant of the batch record record',
    `gmp_deviation_count` STRING COMMENT 'Number of GMP deviations recorded for this batch. Used for quality trend analysis and CAPA tracking.',
    `gmp_deviation_flag` BOOLEAN COMMENT 'Indicates whether any GMP deviations were recorded during batch production. Triggers quality review workflow.',
    `gmp_reviewed` BOOLEAN COMMENT 'The gmp reviewed of the batch record record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this batch record was last updated. Audit trail for GMP compliance and data integrity.',
    `lot_genealogy_complete_flag` BOOLEAN COMMENT 'Indicates whether complete raw material lot traceability has been captured for this batch. Required for recall readiness.',
    `lot_number` STRING COMMENT 'The lot number of the batch record record',
    `manufacture_date` DATE COMMENT 'The manufacture date of the batch record record',
    `manufactured_quantity` DECIMAL(18,2) COMMENT 'The manufactured quantity of the batch record record',
    `manufacturing_date` DATE COMMENT 'Calendar date of batch production. Printed on product packaging for consumer information and regulatory compliance.',
    `manufacturing_end_timestamp` TIMESTAMP COMMENT 'Date and time when batch production was completed and final packaging finished. Used for cycle time analysis.',
    `manufacturing_start_timestamp` TIMESTAMP COMMENT 'Date and time when batch production was initiated on the shop floor. Captured from MES system.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Overall equipment effectiveness achieved during batch production. Composite metric of availability, performance, and quality.',
    `quality_release_flag` BOOLEAN COMMENT 'Indicates whether the batch has been released by Quality Assurance for distribution. Required before inventory availability.',
    `quality_release_timestamp` TIMESTAMP COMMENT 'Date and time when Quality Assurance approved the batch for release. Marks transition from quarantine to available inventory.',
    `quantity_produced` DECIMAL(18,2) COMMENT 'The quantity produced of the batch record record',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether this batch is subject to a product recall. Triggers supply chain hold and customer notification.',
    `recall_initiated_date` DATE COMMENT 'Date when recall was initiated for this batch. Used for regulatory reporting and recall effectiveness tracking.',
    `record_locked_flag` BOOLEAN COMMENT 'Indicates whether this batch record is locked from further edits. Required for GMP record integrity after quality release.',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Indicates whether batch is on regulatory hold pending investigation or approval. Prevents distribution until cleared.',
    `release_date` DATE COMMENT 'The release date of the batch record record',
    `released` BOOLEAN COMMENT 'The released of the batch record record',
    `review_by_exception` BOOLEAN COMMENT 'The review by exception of the batch record record',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Quantity of product requiring rework during batch production. Indicator of process capability and quality issues.',
    `routing_version` STRING COMMENT 'Version of the production routing used for this batch. Documents the manufacturing process steps executed.. Valid values are `^[A-Z0-9.]{1,20}$`',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of product scrapped during batch production. Used for yield calculation and waste reduction analysis.',
    `shelf_life_days` STRING COMMENT 'Number of days between manufacturing date and expiry date. Derived from product stability testing.',
    `source_system_code` STRING COMMENT 'The source system code of the batch record record',
    `standard_cost_amount` DECIMAL(18,2) COMMENT 'Standard cost per unit for this batch based on BOM and routing. Used for cost variance analysis.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for batch size quantities (e.g., KG, LTR, EA, CS). Aligns with GS1 standards.. Valid values are `^[A-Z]{2,6}$`',
    `uom` STRING COMMENT 'The uom of the batch record record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the batch record record',
    `veeva_vault_document_reference` STRING COMMENT 'Reference to the master batch record document stored in Veeva Vault. Links to regulatory document management system.. Valid values are `^VV[A-Z0-9]{10,30}$`',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Ratio of actual batch size to planned batch size expressed as percentage. Key performance indicator for manufacturing efficiency.',
    CONSTRAINT pk_batch_record PRIMARY KEY(`batch_record_id`)
) COMMENT 'Electronic batch manufacturing record (eBMR) capturing the complete GMP-compliant execution history for a production batch. Captures batch number, production order reference, SKU, batch size, manufacturing date, expiry date (FEFO), facility, production line, batch status (in-process, released, rejected, quarantine, recalled), GMP deviation flag, electronic signature records, yield percentage, and Veeva Vault document reference. SSOT for GMP batch traceability per ISO 22716 and FDA 21 CFR Part 211.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` (
    `oee_record_id` BIGINT COMMENT 'Unique identifier for the OEE measurement record. Primary key for the OEE record entity.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: OEE records are captured per manufacturing facility; add direct FK for accurate reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor responsible for the production shift.',
    `production_line_id` BIGINT COMMENT 'Identifier of the specific production line for which OEE was measured.',
    `production_order_id` BIGINT COMMENT 'Identifier of the manufacturing work order executed during this shift.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU that was produced during this shift. Links OEE performance to specific product.',
    `work_center_id` BIGINT COMMENT 'The work center id of the oee record record',
    `actual_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Average actual time in seconds to produce one unit during the shift, calculated as Actual Operating Time / Total Units Produced.',
    `actual_operating_time_minutes` DECIMAL(18,2) COMMENT 'Actual time the production line was operating during the shift in minutes, after subtracting unplanned downtime.',
    `actual_runtime_min` DECIMAL(18,2) COMMENT 'The actual runtime min of the oee record record',
    `availability_pct` DECIMAL(18,2) COMMENT 'The availability pct of the oee record record',
    `availability_rate` DECIMAL(18,2) COMMENT 'Percentage of planned production time that the line was actually operating, calculated as (Planned Production Time - Downtime) / Planned Production Time. Component of OEE calculation.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number produced during the shift. Critical for traceability and GMP compliance.',
    `changeover_count` STRING COMMENT 'Number of product or format changeovers performed during the shift. Impacts availability and performance metrics.',
    `changeover_time_minutes` DECIMAL(18,2) COMMENT 'Total time spent on changeovers during the shift in minutes.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the OEE measurement, including explanations for anomalies or performance issues.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the oee record record',
    `data_collection_method` STRING COMMENT 'Method by which OEE data was captured (automated from sensors, manual entry, or semi-automated).. Valid values are `automated|manual|semi_automated`',
    `downtime_minutes` DECIMAL(18,2) COMMENT 'Total unplanned downtime during the shift in minutes, including equipment failures, material shortages, and unscheduled stoppages.',
    `good_units_produced` BIGINT COMMENT 'Count of units that passed quality inspection and met specifications, calculated as Total Units Produced - Total Units Rejected.',
    `ideal_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Theoretical minimum time in seconds to produce one unit at maximum design speed under optimal conditions.',
    `mes_data_source` STRING COMMENT 'Source system identifier for the OEE data, typically Siemens Opcenter MES or equivalent system.',
    `micro_stop_count` STRING COMMENT 'Number of brief stoppages (typically under 5 minutes) that impact performance but may not be classified as downtime.',
    `oee_pct` DECIMAL(18,2) COMMENT 'The oee pct of the oee record record',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Composite OEE metric calculated as Availability Rate × Performance Rate × Quality Rate. Single measure of manufacturing productivity and effectiveness.',
    `oee_status` STRING COMMENT 'Current lifecycle status of the OEE record indicating validation and approval state.. Valid values are `draft|validated|approved|rejected`',
    `operator_count` STRING COMMENT 'Number of operators assigned to the production line during the shift.',
    `performance_pct` DECIMAL(18,2) COMMENT 'The performance pct of the oee record record',
    `performance_rate` DECIMAL(18,2) COMMENT 'Percentage of ideal production speed achieved, calculated as (Ideal Cycle Time × Total Units Produced) / Actual Operating Time. Component of OEE calculation.',
    `planned_production_time_minutes` DECIMAL(18,2) COMMENT 'Total scheduled production time for the shift in minutes, excluding planned downtime such as breaks and scheduled maintenance.',
    `planned_runtime_min` DECIMAL(18,2) COMMENT 'The planned runtime min of the oee record record',
    `quality_loss_minutes` DECIMAL(18,2) COMMENT 'Time equivalent of production lost due to quality defects and rework in minutes.',
    `quality_pct` DECIMAL(18,2) COMMENT 'The quality pct of the oee record record',
    `quality_rate` DECIMAL(18,2) COMMENT 'Percentage of good units produced without defects, calculated as (Total Units Produced - Total Units Rejected) / Total Units Produced. Component of OEE calculation.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when the OEE record was first created in the system.',
    `record_date` DATE COMMENT 'The record date of the oee record record',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the OEE record was last modified.',
    `rework_units` BIGINT COMMENT 'Count of units that required rework or reprocessing to meet quality standards during the shift.',
    `scrap_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of scrap material generated during the shift in kilograms.',
    `shift` STRING COMMENT 'The shift of the oee record record',
    `shift_code` STRING COMMENT 'The shift code of the oee record record',
    `shift_date` DATE COMMENT 'Calendar date on which the production shift occurred. Principal business event timestamp for OEE measurement.',
    `shift_name` STRING COMMENT 'Descriptive name of the production shift (e.g., day, evening, night).. Valid values are `day|evening|night|morning|afternoon|graveyard`',
    `shift_number` STRING COMMENT 'Sequential shift identifier within the shift date (e.g., 1 for first shift, 2 for second shift, 3 for third shift).',
    `source_system_code` STRING COMMENT 'The source system code of the oee record record',
    `speed_loss_minutes` DECIMAL(18,2) COMMENT 'Time lost due to production running below ideal cycle time in minutes, representing performance inefficiency.',
    `total_units_produced` BIGINT COMMENT 'Total count of units produced during the shift, including both good units and rejected units.',
    `total_units_rejected` BIGINT COMMENT 'Total count of units rejected due to quality defects during the shift.',
    `unplanned_stop_count` STRING COMMENT 'Number of unplanned production stoppages during the shift.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the oee record record',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the OEE record was validated by production management.',
    CONSTRAINT pk_oee_record PRIMARY KEY(`oee_record_id`)
) COMMENT 'Overall Equipment Effectiveness (OEE) measurement record captured per production line per shift. Captures OEE record ID, facility, production line, shift date, shift number, planned production time (minutes), downtime (minutes), speed loss (minutes), quality loss (minutes), availability rate, performance rate, quality rate, composite OEE percentage, total units produced, total units rejected, and MES data source (Siemens Opcenter). SSOT for line performance analytics and continuous improvement programs.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` (
    `downtime_event_id` BIGINT COMMENT 'Unique identifier for the downtime event record. Primary key for the downtime event entity.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Downtime events are tied to a manufacturing facility; replace generic reference with direct FK.',
    `employee_id` BIGINT COMMENT 'Identifier of the production operator who reported or was present during the downtime event.',
    `production_line_id` BIGINT COMMENT 'Identifier of the production line where the downtime event occurred.',
    `production_order_id` BIGINT COMMENT 'Identifier of the production order that was impacted by this downtime event.',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the production shift during which the downtime event occurred.',
    `work_center_id` BIGINT COMMENT 'Identifier of the specific work center or machine that experienced the downtime.',
    `batch_hold_required` BOOLEAN COMMENT 'Indicates whether production batches affected by this downtime event require quality hold pending investigation.',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective action taken to resolve the downtime event and restore production.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this downtime event record was first created in the data platform.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Source system or method by which the downtime event was captured (MES automatic detection, manual operator entry, sensor, SCADA).. Valid values are `mes_automatic|manual_entry|sensor|scada`',
    `downtime_category` STRING COMMENT 'High-level classification of the downtime event type. [ENUM-REF-CANDIDATE: mechanical_failure|electrical_failure|changeover|material_shortage|operator_absence|planned_maintenance|cleaning_sanitation|quality_hold|tooling_issue|system_failure|unplanned_maintenance — promote to reference product]. Valid values are `mechanical_failure|electrical_failure|changeover|material_shortage|operator_absence|planned_maintenance`',
    `downtime_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the downtime event ended and production resumed. Null if downtime is ongoing.',
    `downtime_reason_code` STRING COMMENT 'The downtime reason code of the downtime event record',
    `downtime_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the downtime event began. Captured from MES system or manual entry.',
    `downtime_type` STRING COMMENT 'Indicates whether the downtime was planned (scheduled maintenance, changeover) or unplanned (breakdown, shortage).. Valid values are `planned|unplanned`',
    `duration_min` DECIMAL(18,2) COMMENT 'The duration min of the downtime event record',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the downtime event measured in minutes. Calculated as the difference between end and start timestamps.',
    `end_timestamp` TIMESTAMP COMMENT 'The end timestamp of the downtime event record',
    `equipment_failure_mode` STRING COMMENT 'Specific failure mode of the equipment that caused the downtime, used for reliability analysis and FMEA.',
    `escalation_level` STRING COMMENT 'Level of management escalation required or triggered by this downtime event based on duration and impact.. Valid values are `none|supervisor|manager|director|executive`',
    `event_end_timestamp` TIMESTAMP COMMENT 'The event end timestamp of the downtime event record',
    `event_start_timestamp` TIMESTAMP COMMENT 'The event start timestamp of the downtime event record',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the downtime event in local currency, including lost production value and recovery costs.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the downtime event and its resolution comply with GMP requirements per ISO 22716.',
    `is_planned` BOOLEAN COMMENT 'The is planned of the downtime event record',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the downtime event, root cause investigation, or resolution.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether automated notifications were sent to relevant stakeholders about this downtime event.',
    `oee_impact_flag` BOOLEAN COMMENT 'Indicates whether this downtime event is included in OEE availability loss calculations.',
    `preventive_action_required` BOOLEAN COMMENT 'Indicates whether preventive action is required to avoid recurrence of this downtime event.',
    `production_loss_units` DECIMAL(18,2) COMMENT 'Estimated number of production units lost due to this downtime event, based on standard production rate.',
    `reason_code` STRING COMMENT 'The reason code of the downtime event record',
    `reported_timestamp` TIMESTAMP COMMENT 'Timestamp when the downtime event was first reported or logged in the system.',
    `resolution_status` STRING COMMENT 'Current status of the downtime event resolution process.. Valid values are `open|in_progress|resolved|closed`',
    `responsible_department` STRING COMMENT 'Department responsible for addressing or preventing this type of downtime event.. Valid values are `production|maintenance|quality|materials|engineering|utilities`',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the root cause of the downtime event. Aligned with facility-specific root cause taxonomy.',
    `root_cause_description` STRING COMMENT 'Detailed textual description of the root cause analysis findings for this downtime event.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether the downtime event was associated with a safety incident or near-miss.',
    `severity_level` STRING COMMENT 'Severity classification of the downtime event based on impact to production schedule and safety.. Valid values are `critical|high|medium|low`',
    `source_system_code` STRING COMMENT 'The source system code of the downtime event record',
    `start_timestamp` TIMESTAMP COMMENT 'The start timestamp of the downtime event record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this downtime event record was last updated in the data platform.',
    CONSTRAINT pk_downtime_event PRIMARY KEY(`downtime_event_id`)
) COMMENT 'Individual downtime event record capturing each unplanned or planned stoppage on a production line or work center. Captures event ID, facility, production line, work center, downtime start/end timestamps, duration (minutes), downtime category (mechanical failure, changeover, material shortage, operator absence, planned maintenance, cleaning/sanitation), root cause code, responsible department, production order impacted, and corrective action taken. Feeds OEE loss analysis and maintenance work order creation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` (
    `changeover_id` BIGINT COMMENT 'Unique identifier for the changeover event. Primary key for the changeover record.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU that was being produced before the changeover.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Changeover events occur at a specific manufacturing facility; link directly to manufacturing_facility.',
    `employee_id` BIGINT COMMENT 'Identifier of the primary operator or technician responsible for executing the changeover.',
    `production_line_id` BIGINT COMMENT 'Identifier of the production line or work center where the changeover was executed.',
    `production_order_id` BIGINT COMMENT 'Identifier of the production order that triggered or required this changeover event.',
    `to_sku_id` BIGINT COMMENT 'Identifier of the SKU that will be produced after the changeover.',
    `work_center_id` BIGINT COMMENT 'FK to manufacturing.work_center',
    `actual_duration_minutes` DECIMAL(18,2) COMMENT 'Actual elapsed time in minutes from changeover start to completion, calculated from actual start and end timestamps.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the changeover execution was completed and the line was ready for production.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the changeover execution began on the shop floor.',
    `changeover_status` STRING COMMENT 'Current lifecycle status of the changeover event indicating its progress through the execution workflow.. Valid values are `planned|in_progress|completed|cancelled|delayed`',
    `changeover_type` STRING COMMENT 'Classification of the changeover based on the nature of the change: flavor (product variant), format (packaging type), size (package size), cleaning (sanitation), material (raw material switch), or color (product color change).. Valid values are `flavor|format|size|cleaning|material|color`',
    `cleaning_required` BOOLEAN COMMENT 'The cleaning required of the changeover record',
    `cleaning_verification_timestamp` TIMESTAMP COMMENT 'Date and time when the GMP cleaning verification was completed and approved by quality assurance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this changeover record was first created in the system.',
    `downtime_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for any delays or extended downtime during the changeover.. Valid values are `^[A-Z0-9]{2,8}$`',
    `downtime_reason_description` STRING COMMENT 'Detailed description of the reason for any delays or extended downtime during the changeover execution.',
    `duration_min` DECIMAL(18,2) COMMENT 'The duration min of the changeover record',
    `duration_minutes` DECIMAL(18,2) COMMENT 'The duration minutes of the changeover record',
    `end_timestamp` TIMESTAMP COMMENT 'The end timestamp of the changeover record',
    `equipment_adjustment_required_flag` BOOLEAN COMMENT 'Indicates whether mechanical or equipment adjustments were required as part of the changeover process.',
    `first_pass_yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of production output that met quality standards on the first production run immediately following the changeover, indicating changeover quality effectiveness.',
    `gmp_cleaning_verified_flag` BOOLEAN COMMENT 'Indicates whether the required GMP cleaning and sanitation procedures were completed and verified as part of the changeover process.',
    `improvement_initiative_code` BIGINT COMMENT 'Identifier linking this changeover to a specific continuous improvement initiative or project.',
    `material_waste_kg` DECIMAL(18,2) COMMENT 'Quantity of raw material or work-in-process material wasted or scrapped during the changeover, measured in kilograms.',
    `notes` STRING COMMENT 'Free-text notes or comments from operators, supervisors, or quality inspectors regarding the changeover execution, issues encountered, or lessons learned.',
    `oee_impact_percentage` DECIMAL(18,2) COMMENT 'Calculated impact of this changeover event on the production lines overall equipment effectiveness for the shift or day, expressed as a percentage.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned date and time when the changeover was scheduled to be completed according to the production schedule.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when the changeover was scheduled to begin according to the production schedule.',
    `shift_code` STRING COMMENT 'Code identifying the production shift during which the changeover occurred.. Valid values are `^[A-Z0-9]{1,4}$`',
    `smed_improvement_flag` BOOLEAN COMMENT 'Indicates whether this changeover was part of a SMED continuous improvement initiative or pilot program.',
    `source_system_code` STRING COMMENT 'The source system code of the changeover record',
    `standard_duration_minutes` DECIMAL(18,2) COMMENT 'Standard or target duration in minutes for this type of changeover based on engineering standards and historical performance.',
    `start_timestamp` TIMESTAMP COMMENT 'The start timestamp of the changeover record',
    `team_size` STRING COMMENT 'Number of operators or technicians involved in executing the changeover.',
    `tooling_change_required_flag` BOOLEAN COMMENT 'Indicates whether tooling or die changes were required as part of the changeover process.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this changeover record was last modified or updated in the system.',
    `variance_minutes` DECIMAL(18,2) COMMENT 'Difference in minutes between actual and standard changeover duration. Positive values indicate the changeover took longer than standard; negative values indicate faster than standard performance.',
    CONSTRAINT pk_changeover PRIMARY KEY(`changeover_id`)
) COMMENT 'Changeover execution record capturing each line or work center changeover event between production runs. Captures changeover ID, facility, production line, from-SKU, to-SKU, changeover type (flavor, format, size, cleaning), scheduled start/end, actual start/end, actual duration (minutes), standard duration (minutes), variance (minutes), changeover status (planned, in-progress, completed), operator ID, and GMP cleaning verification flag. Supports SMED improvement programs and scheduling optimization.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` (
    `yield_record_id` BIGINT COMMENT 'Unique identifier for the yield tracking record. Primary key for the yield record entity.',
    `batch_record_id` BIGINT COMMENT 'The batch record id of the yield record record',
    `employee_id` BIGINT COMMENT 'Reference to the production operator or technician who recorded the yield measurement. Links to workforce master data for training and performance tracking.',
    `production_order_id` BIGINT COMMENT 'Reference to the production order for which this yield record is captured. Links yield data to the manufacturing order in SAP S/4HANA PP module.',
    `sku_id` BIGINT COMMENT 'The sku id of the yield record record',
    `tertiary_yield_last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person or system account that last modified this yield record. Audit trail for data governance and regulatory compliance.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center (production line, machine, or station) where the yield measurement was captured. Links to manufacturing resource master data.',
    `actual_yield` DECIMAL(18,2) COMMENT 'The actual yield of the yield record record',
    `actual_yield_percentage` DECIMAL(18,2) COMMENT 'Actual yield percentage achieved calculated as (output_quantity / input_quantity) * 100. Key Performance Indicator (KPI) for manufacturing efficiency.',
    `actual_yield_qty` DECIMAL(18,2) COMMENT 'The actual yield qty of the yield record record',
    `batch_number` STRING COMMENT 'Manufacturing batch identifier for traceability and Good Manufacturing Practice (GMP) compliance. Critical for product recall and quality investigations.. Valid values are `^[A-Z0-9]{6,20}$`',
    `batch_record_status` STRING COMMENT 'Current lifecycle status of the batch record documentation. Tracks progression through Good Manufacturing Practice (GMP) review and approval workflow.. Valid values are `DRAFT|IN_PROGRESS|COMPLETED|REVIEWED|APPROVED|REJECTED`',
    `comments` STRING COMMENT 'Free-text comments or notes from production operators or quality personnel regarding yield performance, issues encountered, or corrective actions taken.',
    `cost_center_code` STRING COMMENT 'Cost center responsible for this manufacturing operation. Used for Cost of Goods Sold (COGS) allocation and variance accounting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this yield record was first created in the system. Audit trail for data governance and compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this yield record. Typically the plants local currency or corporate reporting currency.. Valid values are `^[A-Z]{3}$`',
    `erp_document_number` STRING COMMENT 'Document number in the Enterprise Resource Planning (ERP) system (SAP S/4HANA) that records the goods movement associated with this yield. Links to material document for inventory reconciliation.. Valid values are `^[A-Z0-9]{10,20}$`',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether this yield record meets Good Manufacturing Practice (GMP) documentation and traceability requirements. Critical for regulatory audits and product release.',
    `input_quantity` DECIMAL(18,2) COMMENT 'Total quantity of raw materials or semi-finished goods consumed as input for this operation. Used to calculate theoretical yield and material consumption variance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this yield record was last updated. Audit trail for data governance and Good Manufacturing Practice (GMP) compliance.',
    `material_number` STRING COMMENT 'Material master identifier for the finished or semi-finished good being produced. Links to product master data and Stock Keeping Unit (SKU) registry.. Valid values are `^[A-Z0-9]{8,18}$`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the yield measurement was captured at the work center. Critical for Manufacturing Execution System (MES) integration and real-time production monitoring.',
    `mes_transaction_reference` STRING COMMENT 'Unique transaction identifier from the Manufacturing Execution System (MES) that originated this yield record. Enables traceability to Siemens Opcenter MES source data.. Valid values are `^[A-Z0-9]{10,30}$`',
    `operation_end_timestamp` TIMESTAMP COMMENT 'Date and time when the manufacturing operation completed. Used to calculate cycle time and Overall Equipment Effectiveness (OEE).',
    `operation_start_timestamp` TIMESTAMP COMMENT 'Date and time when the manufacturing operation began. Used to calculate cycle time and Overall Equipment Effectiveness (OEE).',
    `output_quantity` DECIMAL(18,2) COMMENT 'Total quantity of finished or semi-finished goods produced as output from this operation. Represents the good production yield before scrap and rework.',
    `planned_yield_qty` DECIMAL(18,2) COMMENT 'The planned yield qty of the yield record record',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility identifier where the yield measurement was captured. Links to organizational hierarchy and site master data.. Valid values are `^[A-Z0-9]{4,10}$`',
    `production_line_code` STRING COMMENT 'Specific production line identifier within the plant. Enables line-level yield analysis and capacity planning.. Valid values are `^[A-Z0-9]{4,15}$`',
    `quality_inspection_lot_number` STRING COMMENT 'Quality Control (QC) inspection lot number associated with this yield record. Links yield data to quality inspection results for Good Manufacturing Practice (GMP) compliance.. Valid values are `^[A-Z0-9]{8,20}$`',
    `record_date` DATE COMMENT 'The record date of the yield record record',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Quantity of material that required rework or reprocessing to meet quality specifications. Impacts production efficiency and cycle time.',
    `routing_operation_number` STRING COMMENT 'Specific operation sequence number within the production routing where yield is measured. Identifies the manufacturing step in the Bill of Materials (BOM) routing.. Valid values are `^[0-9]{4,10}$`',
    `scrap_qty` DECIMAL(18,2) COMMENT 'The scrap qty of the yield record record',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of material that failed quality checks and was scrapped during this operation. Contributes to yield loss and Cost of Goods Sold (COGS) variance.',
    `shift_code` STRING COMMENT 'Production shift identifier during which the yield measurement was captured. Used for shift-level performance analysis and labor productivity tracking.. Valid values are `SHIFT_1|SHIFT_2|SHIFT_3|DAY|NIGHT|WEEKEND`',
    `source_system_code` STRING COMMENT 'The source system code of the yield record record',
    `standard_cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost per unit of output based on Bill of Materials (BOM) and routing. Used to calculate yield variance impact on Cost of Goods Sold (COGS).',
    `theoretical_yield` DECIMAL(18,2) COMMENT 'The theoretical yield of the yield record record',
    `theoretical_yield_percentage` DECIMAL(18,2) COMMENT 'Expected yield percentage based on Bill of Materials (BOM) specifications and standard operating procedures. Baseline for variance analysis.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for all quantity fields in this yield record. Must be consistent across input, output, scrap, and rework quantities. [ENUM-REF-CANDIDATE: KG|L|EA|M|M2|M3|TON|LB|GAL|OZ — 10 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the yield record record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the yield record record',
    `yield_loss_reason_code` STRING COMMENT 'Standardized code identifying the root cause of yield variance. Used for Pareto analysis and continuous improvement initiatives. Examples: EQUIP_FAIL, MAT_DEFECT, PROC_ERROR, QUAL_REJECT.. Valid values are `^[A-Z0-9]{2,10}$`',
    `yield_loss_reason_description` STRING COMMENT 'Detailed description of the yield loss root cause. Provides context for quality investigations and corrective action planning.',
    `yield_pct` DECIMAL(18,2) COMMENT 'The yield pct of the yield record record',
    `yield_variance_cost_impact` DECIMAL(18,2) COMMENT 'Financial impact of yield variance calculated as (theoretical_yield - actual_yield) * standard_cost_per_unit. Feeds into Cost of Goods Sold (COGS) variance reporting.',
    `yield_variance_percentage` DECIMAL(18,2) COMMENT 'Variance between actual and theoretical yield expressed as percentage. Calculated as (actual_yield_percentage - theoretical_yield_percentage). Negative values indicate yield loss.',
    CONSTRAINT pk_yield_record PRIMARY KEY(`yield_record_id`)
) COMMENT 'Yield tracking record capturing input vs. output quantities at each stage of the manufacturing process for a production order or batch. Captures yield record ID, production order reference, batch number, routing operation, work center, input quantity, output quantity, scrap quantity, rework quantity, theoretical yield percentage, actual yield percentage, yield variance, unit of measure, and yield loss reason code. Enables yield variance analysis, COGS accuracy, and GMP batch record reconciliation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` (
    `gmp_event_id` BIGINT COMMENT 'Unique surrogate identifier for the GMP compliance event record. Primary key for the gmp_event data product. Entity role: TRANSACTION_HEADER — represents a discrete GMP compliance business event with a clear lifecycle.',
    `employee_id` BIGINT COMMENT 'Reference to the quality manager or authorized person who reviewed and electronically signed off on the GMP event record. Required for 21 CFR Part 11 electronic signature compliance. Nullable until event reaches approval stage.',
    `batch_record_id` BIGINT COMMENT 'Reference to the manufacturing batch record against which this GMP event was detected. Links the compliance event to the specific production batch in the batch record master. Serves as the PARTY_REFERENCE (resource reference) category for TRANSACTION_HEADER role.',
    `capa_id` BIGINT COMMENT 'Reference to the Corrective and Preventive Action (CAPA) record initiated in response to this GMP event. Nullable when no CAPA has been raised yet or when event severity does not require CAPA. Managed in Veeva Vault Quality module.',
    `equipment_id` BIGINT COMMENT 'Reference to the specific piece of manufacturing equipment involved in or associated with the GMP event. Particularly relevant for equipment_failure and process_parameter_breach event types. Links to equipment master in SAP PM (Plant Maintenance) module.',
    `gmp_reported_by_employee_id` BIGINT COMMENT 'The gmp reported by employee id of the gmp event record',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: GMP events must be linked to the specific manufacturing facility where they occurred.',
    `primary_gmp_detected_by_employee_id` BIGINT COMMENT 'Reference to the employee (operator, quality technician, or supervisor) who first detected and reported the GMP event. Links to Workday HCM employee master. Required for GMP accountability and electronic signature audit trail under 21 CFR Part 11.',
    `prior_event_gmp_event_id` BIGINT COMMENT 'Reference to the previous GMP event of the same type that this event is a recurrence of. Populated only when recurrence_flag is true. Enables recurrence trend analysis and CAPA effectiveness assessment across event lineage.',
    `production_line_id` BIGINT COMMENT 'FK to manufacturing.production_line',
    `production_order_id` BIGINT COMMENT 'Reference to the SAP S/4HANA PP production order or Siemens Opcenter MES work order associated with this GMP event. Enables traceability from compliance event back to the manufacturing execution context.',
    `regulatory_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: GMP event investigations reference the product registration to ensure corrective actions align with the approved registration details.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) being manufactured when the GMP event occurred. Enables product-level compliance traceability, recall risk assessment, and regulatory reporting by product.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Regulatory GMP incident reports must identify the raw‑material supplier causing the event for root‑cause analysis.',
    `affected_quantity` DECIMAL(18,2) COMMENT 'Quantity of product (in the batch unit of measure) potentially affected by the GMP event. Used for impact assessment, recall scope estimation, and financial exposure calculation. Serves as the QUANTITATIVE_RESULT measurement for this non-monetary transaction.',
    `affected_quantity_uom` STRING COMMENT 'Unit of measure for the affected batch quantity (e.g., KG for kilograms, L for liters, EA for each/units). Aligned with GS1 unit of measure codes and SAP S/4HANA base unit of measure configuration.. Valid values are `KG|L|EA|G|ML|LB`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the authorized quality manager electronically signed and approved the GMP event record. Distinct from detection and creation timestamps. Required for regulatory audit trail and SLA compliance measurement.',
    `batch_disposition` STRING COMMENT 'Quality disposition decision for the affected batch resulting from the GMP event investigation. released: batch meets quality standards and is approved for distribution. quarantined: batch held pending investigation outcome. rejected: batch fails quality standards and cannot be released. reworked: batch underwent approved rework procedure. destroyed: batch disposed of due to quality failure.. Valid values are `released|quarantined|rejected|reworked|destroyed`',
    `batch_number` STRING COMMENT 'Human-readable batch or lot number of the product being manufactured when the GMP event was detected. Denormalized from the batch record for direct traceability in compliance reports and regulatory submissions without requiring a join.',
    `ccp_code` STRING COMMENT 'Identifier of the Critical Control Point (CCP) in the manufacturing process where the GMP event was detected. Applicable for process_parameter_breach and environmental_monitoring_excursion event types. Aligned with HACCP and GMP process control frameworks.',
    `closure_timestamp` TIMESTAMP COMMENT 'Date and time when the GMP event was formally closed after all required CAPA actions were completed and verified effective. Nullable for open or in-progress events. Used to calculate event resolution cycle time for quality KPI reporting.',
    `containment_action_timestamp` TIMESTAMP COMMENT 'Date and time when the immediate containment action was executed following GMP event detection (e.g., line stoppage, batch quarantine). Used to calculate detection-to-containment response time, a key GMP performance metric.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the GMP event record was first created in the system (Veeva Vault or SAP QM). Serves as the RECORD_AUDIT_CREATED category for TRANSACTION_HEADER role. Used for audit trail and data lineage purposes.',
    `gmp_event_description` STRING COMMENT 'The gmp event description of the gmp event record',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the GMP compliance event was first detected or observed on the shop floor or in the laboratory. This is the principal real-world event time (BUSINESS_EVENT_TIMESTAMP category). Distinct from the record creation timestamp. Critical for regulatory timelines and investigation SLA tracking.',
    `electronic_signature` STRING COMMENT 'Electronic signature token or hash of the approver who reviewed and closed the GMP event record, as required by FDA 21 CFR Part 11. Captures the meaning of the signature (e.g., Reviewed and Approved), the signer identity reference, and timestamp encoded in the token. Managed by Veeva Vault e-signature module.',
    `environmental_zone` STRING COMMENT 'ISO cleanroom classification zone or EU GMP environmental grade where the GMP event occurred. Relevant for environmental_monitoring_excursion event types. Grade A/B are highest cleanliness requirements; Grade C/D are controlled areas. Used for contamination risk assessment.. Valid values are `grade_a|grade_b|grade_c|grade_d|unclassified`',
    `event_date` DATE COMMENT 'The event date of the gmp event record',
    `event_description` STRING COMMENT 'Detailed narrative description of the GMP compliance event, including what was observed, where it occurred, and the immediate circumstances. Captured by the detecting operator or quality technician at time of detection. Serves as the QUANTITATIVE_RESULT (qualitative payload) category for non-monetary TRANSACTION_HEADER.',
    `event_number` STRING COMMENT 'Externally-known, human-readable business identifier for the GMP compliance event, used in regulatory submissions, CAPA tracking, and cross-system references. Format: GMP-{YYYY}-{NNNNNN}. Serves as the BUSINESS_IDENTIFIER category for TRANSACTION_HEADER role.. Valid values are `^GMP-[0-9]{4}-[0-9]{6}$`',
    `event_severity` STRING COMMENT 'Risk-based severity classification of the GMP event. Critical: potential impact on product safety or patient/consumer harm; requires immediate escalation and regulatory notification. Major: significant departure from GMP requirements with potential quality impact. Minor: low-risk deviation with minimal quality impact. Drives CAPA prioritization and regulatory reporting obligations.. Valid values are `critical|major|minor`',
    `event_status` STRING COMMENT 'Current lifecycle status of the GMP compliance event. open: newly detected, investigation not yet started. under_investigation: root cause analysis in progress. pending_capa: investigation complete, awaiting CAPA closure. closed: all actions completed and verified effective. cancelled: event determined to be erroneous or duplicate. Serves as the LIFECYCLE_STATUS category for TRANSACTION_HEADER role.. Valid values are `open|under_investigation|pending_capa|closed|cancelled`',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp of the gmp event record',
    `event_type` STRING COMMENT 'Classification of the GMP compliance event by its nature. Values: deviation (unplanned departure from approved procedure), oos_result (Out-of-Specification laboratory result), environmental_monitoring_excursion (EM limit breach), equipment_failure (critical equipment malfunction), process_parameter_breach (critical process parameter out of range), contamination_event (microbial or cross-contamination incident). [ENUM-REF-CANDIDATE: deviation|oos_result|environmental_monitoring_excursion|equipment_failure|process_parameter_breach|contamination_event — promote to reference product]. Valid values are `deviation|oos_result|environmental_monitoring_excursion|equipment_failure|process_parameter_breach|contamination_event`',
    `gmp_event_status` STRING COMMENT 'The gmp event status of the gmp event record',
    `immediate_action_taken` STRING COMMENT 'Description of the immediate containment or corrective action taken at the time of GMP event detection to prevent further impact (e.g., line stoppage, batch quarantine, equipment isolation). Distinct from the formal CAPA which addresses root cause prevention.',
    `investigation_due_date` DATE COMMENT 'Target date by which the root cause investigation must be completed, based on event severity and regulatory SLA requirements. Critical events typically require investigation within 3 business days; major within 10 days; minor within 30 days. Used for overdue investigation tracking.',
    `is_product_recall_trigger` BOOLEAN COMMENT 'Indicates whether this GMP event has been assessed as a potential trigger for a product recall or market withdrawal. True when the event involves a safety risk to consumers that may require removal of product from distribution channels. Activates recall management workflow.',
    `process_step` STRING COMMENT 'Name or code of the specific manufacturing process step (e.g., mixing, filling, packaging, sterilization, labeling) during which the GMP event was detected. Sourced from Siemens Opcenter MES routing. Used for process-level failure mode analysis.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this GMP event is a recurrence of a previously closed event of the same type at the same facility or production line. True when a similar event has occurred within the past 12 months. Triggers escalated investigation and CAPA effectiveness review.',
    `regulation_reference` STRING COMMENT 'Specific regulatory standard or clause that this GMP event relates to or potentially violates. Examples: ISO 22716:2007 Section 10.2, FDA 21 CFR Part 211.113, EU GMP Annex 1. Used for regulatory submission mapping and compliance gap analysis.',
    `regulatory_notification_date` DATE COMMENT 'Date on which the regulatory authority was formally notified of this GMP event. Populated only when regulatory_notification_required is true and notification has been submitted. Used for regulatory compliance timeline tracking.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether this GMP event requires formal notification to a regulatory authority (e.g., FDA, EU Competent Authority, CPSC). Typically true for critical events involving potential consumer safety risk, product recall triggers, or serious GMP failures. Drives regulatory affairs workflow.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assigned to the GMP event based on ICH Q9 risk assessment methodology, combining probability of occurrence, severity of impact, and detectability. Typically scored on a 1-100 scale. Used for risk-based prioritization of investigations and CAPA resources.',
    `root_cause_category` STRING COMMENT 'Categorized root cause of the GMP event as determined through investigation. Populated after investigation is complete. Used for trend analysis, systemic failure identification, and CAPA effectiveness measurement. [ENUM-REF-CANDIDATE: human_error|equipment_malfunction|raw_material|process_design|environmental|documentation|training — promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the identified root cause of the GMP event, as documented by the quality investigator. Populated upon completion of root cause analysis (RCA). Supports regulatory inspection readiness and CAPA justification.',
    `sap_qm_notification_number` STRING COMMENT 'SAP S/4HANA Quality Management (QM) notification number associated with this GMP event. Quality notifications in SAP QM are the operational system of record for defect tracking and corrective actions. Enables reconciliation between the lakehouse and SAP QM.',
    `severity` STRING COMMENT 'The severity of the gmp event record',
    `shift_code` STRING COMMENT 'Manufacturing shift during which the GMP event was detected (e.g., A-shift, B-shift, night shift). Used for shift-level quality performance analysis, operator accountability, and identifying shift-specific patterns in GMP deviations.',
    `source_system_code` STRING COMMENT 'The source system code of the gmp event record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the GMP event record. Serves as the RECORD_AUDIT_UPDATED category for TRANSACTION_HEADER role. Supports audit trail requirements under 21 CFR Part 11 electronic records regulations.',
    `veeva_document_reference` STRING COMMENT 'Cross-reference identifier of the corresponding GMP event record in Veeva Vault Quality Document Management system. Enables bidirectional traceability between the lakehouse silver layer and the system of record for regulatory document management.',
    CONSTRAINT pk_gmp_event PRIMARY KEY(`gmp_event_id`)
) COMMENT 'GMP compliance event record capturing deviations, non-conformances, and critical control point (CCP) observations during manufacturing. Captures event ID, batch record reference, facility, event type (deviation, OOS result, environmental monitoring excursion, equipment failure, process parameter breach), event severity (critical, major, minor), event description, detection timestamp, GMP regulation reference (ISO 22716, FDA 21 CFR 211), CAPA reference, event status (open, under investigation, closed), and electronic signature of approver. SSOT for GMP compliance event management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` (
    `production_confirmation_id` BIGINT COMMENT 'Unique identifier for the production confirmation record. Primary key for shop floor execution tracking.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which labor and overhead costs for this operation are allocated for financial accounting.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this operation was performed.',
    `employee_id` BIGINT COMMENT 'Reference to the shop floor operator or employee who executed and confirmed this manufacturing operation.',
    `production_confirmed_by_employee_id` BIGINT COMMENT 'The production confirmed by employee id of the production confirmation record',
    `production_employee_id` BIGINT COMMENT 'The production employee id of the production confirmation record',
    `production_order_id` BIGINT COMMENT 'Reference to the parent production order under which this operation was executed.',
    `routing_id` BIGINT COMMENT 'The routing id of the production confirmation record',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Production confirmation reports must reference the sales order they fulfill for accurate shipping and invoicing.',
    `sku_id` BIGINT COMMENT 'Reference to the finished or semi-finished material (SKU) produced by this operation.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center (production line, machine, or station) where this operation was performed.',
    `activity_type` STRING COMMENT 'SAP CO activity type code representing the type of work performed (e.g., machine hours, labor hours, setup hours) for cost allocation purposes.. Valid values are `^[A-Z0-9]{4,6}$`',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when the operation was completed and confirmed by the operator. Used for OEE calculation and production order settlement.',
    `actual_labor_time_minutes` DECIMAL(18,2) COMMENT 'Actual operator labor time spent on this operation including manual work, monitoring, and quality checks. Measured in minutes.',
    `actual_machine_time_minutes` DECIMAL(18,2) COMMENT 'Actual time the machine or equipment was actively running during this operation. Excludes setup and downtime. Measured in minutes.',
    `actual_setup_time_minutes` DECIMAL(18,2) COMMENT 'Actual time spent on machine setup, changeover, and preparation activities before production began. Measured in minutes.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the operator began executing this operation on the shop floor. Captured from MES or manual confirmation.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number assigned to the output produced in this operation. Critical for traceability and recall management.. Valid values are `^[A-Z0-9]{6,12}$`',
    `confirmation_notes` STRING COMMENT 'Free-text notes or comments entered by the operator or supervisor regarding this operation execution, including any issues or observations.',
    `confirmation_number` STRING COMMENT 'The confirmation number of the production confirmation record',
    `confirmation_timestamp` TIMESTAMP COMMENT 'System timestamp when this confirmation record was created and submitted to the ERP or MES system.',
    `confirmation_type` STRING COMMENT 'Classification of the confirmation event indicating whether this is a partial progress update, final completion, milestone checkpoint, rework confirmation, or cancellation.. Valid values are `partial|final|milestone|rework|cancelled`',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The confirmed quantity of the production confirmation record',
    `confirmed_scrap_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of defective or waste material generated during this operation. Used for yield variance analysis and quality tracking.',
    `confirmed_yield_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of good output produced and confirmed for this operation. Measured in the base unit of measure for the material.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the production confirmation record',
    `downtime_minutes` DECIMAL(18,2) COMMENT 'Total unplanned downtime during this operation due to equipment failure, material shortage, or other interruptions. Measured in minutes.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether this operation was executed in compliance with GMP standards as required for regulated consumer goods products.',
    `labor_hours` DECIMAL(18,2) COMMENT 'The labor hours of the production confirmation record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this confirmation record was last updated or modified. Used for change tracking and audit purposes.',
    `machine_hours` DECIMAL(18,2) COMMENT 'The machine hours of the production confirmation record',
    `mes_transaction_reference` STRING COMMENT 'Unique transaction reference from the Siemens Opcenter MES system that originated this confirmation. Used for traceability and system reconciliation.. Valid values are `^MES[A-Z0-9]{10,20}$`',
    `oee_availability_percent` DECIMAL(18,2) COMMENT 'Calculated availability component of OEE for this operation, representing the percentage of scheduled time that equipment was available for production.',
    `oee_performance_percent` DECIMAL(18,2) COMMENT 'Calculated performance component of OEE for this operation, representing actual production speed versus ideal speed.',
    `oee_quality_percent` DECIMAL(18,2) COMMENT 'Calculated quality component of OEE for this operation, representing the percentage of good output versus total output produced.',
    `operation_number` STRING COMMENT 'Sequential operation identifier within the production order routing. Typically a 4-digit numeric code representing the step in the manufacturing process.. Valid values are `^[0-9]{4}$`',
    `operation_status` STRING COMMENT 'Current lifecycle status of the manufacturing operation indicating its execution state in the production workflow.. Valid values are `open|in_progress|completed|cancelled|on_hold`',
    `posting_date` DATE COMMENT 'Financial posting date when this confirmation was recorded in the ERP system for inventory and cost accounting purposes.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this operation output requires quality inspection before release to inventory or next operation.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this confirmation has been reversed or cancelled due to error correction or process adjustment.',
    `reversal_reason_code` STRING COMMENT 'Standardized code explaining why this confirmation was reversed, if applicable. Used for process improvement and error tracking.. Valid values are `^[A-Z0-9]{2,4}$`',
    `rework_flag` BOOLEAN COMMENT 'Indicates whether this confirmation represents a rework operation to correct defects from a previous production run.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Planned completion date and time for this operation as determined by production scheduling or MES system.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned start date and time for this operation as determined by production scheduling or MES system.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'The scrap quantity of the production confirmation record',
    `shift_code` STRING COMMENT 'Production shift identifier during which this operation was executed (e.g., SHIFT_1, DAY, NIGHT). Used for shift performance analysis.. Valid values are `^(SHIFT_[1-3]|DAY|NIGHT|SWING)$`',
    `source_system_code` STRING COMMENT 'Identifier of the originating system that created this confirmation record (SAP PP, Siemens Opcenter MES, or manual entry).. Valid values are `SAP_PP|OPCENTER_MES|MANUAL`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the confirmed quantities (e.g., KG for kilograms, EA for each, LT for liters). Aligns with material master UOM.. Valid values are `^[A-Z]{2,3}$`',
    `uom` STRING COMMENT 'The uom of the production confirmation record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the production confirmation record',
    `variance_reason_code` STRING COMMENT 'Standardized code explaining any significant variance between planned and actual quantities or times. Used for root cause analysis.. Valid values are `^[A-Z0-9]{2,6}$`',
    `work_order_number` STRING COMMENT 'Business identifier for the work order assigned to this manufacturing operation. Externally visible reference used across shop floor systems.. Valid values are `^WO[0-9]{8,12}$`',
    `yield_quantity` DECIMAL(18,2) COMMENT 'The yield quantity of the production confirmation record',
    CONSTRAINT pk_production_confirmation PRIMARY KEY(`production_confirmation_id`)
) COMMENT 'Shop floor execution and confirmation record capturing the complete lifecycle of each manufacturing operation within a production order — from assignment and scheduling through actual execution and final confirmation. Captures work order number, parent production order reference, operation number, work center, assigned operator, scheduled start/end, actual start/end, confirmation type (partial, final), confirmed yield quantity, confirmed scrap quantity, actual setup/machine/labor time, operation status (open, in-progress, completed, cancelled), posting date, and MES transaction reference (Siemens Opcenter). SSOT for granular shop floor execution tracking, labor confirmation, production order settlement, and OEE calculation. Subsumes discrete work order assignment data.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` (
    `process_parameter_id` BIGINT COMMENT 'Unique identifier for the process parameter record. Primary key for in-process control and critical process parameter measurements.',
    `batch_record_id` BIGINT COMMENT 'Reference to the batch manufacturing record under which this parameter was measured. Links to the batch master record for traceability.',
    `capa_id` BIGINT COMMENT 'Reference to the corrective and preventive action (CAPA) record initiated in response to an out-of-specification measurement.',
    `employee_id` BIGINT COMMENT 'Identifier of the production operator or technician who recorded or verified the parameter measurement. Links to workforce management system.',
    `equipment_id` BIGINT COMMENT 'Identifier of the specific manufacturing equipment or instrument used to measure or control the parameter.',
    `production_order_id` BIGINT COMMENT 'The production order id of the process parameter record',
    `specification_id` BIGINT COMMENT 'Reference to the product specification or process specification document that defines the control limits for this parameter.',
    `work_center_id` BIGINT COMMENT 'The work center id of the process parameter record',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual measured value of the process parameter recorded during manufacturing operations.',
    `calibration_due_date` DATE COMMENT 'The date when the measuring instrument or sensor is next due for calibration. Ensures measurement validity per GMP requirements.',
    `comments` STRING COMMENT 'Free-text comments or notes recorded by the operator or quality personnel regarding the parameter measurement, including any anomalies or observations.',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean indicator whether the measurement result requires corrective action or investigation (True = action required, False = no action needed).',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the process parameter record',
    `data_source` STRING COMMENT 'The source system from which the parameter measurement was captured: MES (Manufacturing Execution System), SCADA, LIMS, manual entry, or ERP.. Valid values are `MES|SCADA|LIMS|manual_entry|ERP`',
    `deviation_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage deviation of the actual value from the target value. Used for trend analysis and process capability assessment.',
    `facility_code` STRING COMMENT 'Code identifying the manufacturing facility or plant where the parameter measurement was recorded. Supports multi-site manufacturing operations.. Valid values are `^[A-Z]{3}[0-9]{3}$`',
    `in_spec` BOOLEAN COMMENT 'The in spec of the process parameter record',
    `in_spec_flag` BOOLEAN COMMENT 'The in spec flag of the process parameter record',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'The lower acceptable boundary for the parameter value. Values below this threshold trigger out-of-specification alerts.',
    `lower_limit` DECIMAL(18,2) COMMENT 'The lower limit of the process parameter record',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'The lower spec limit of the process parameter record',
    `measured_timestamp` TIMESTAMP COMMENT 'The measured timestamp of the process parameter record',
    `measured_value` DECIMAL(18,2) COMMENT 'The measured value of the process parameter record',
    `measurement_method` STRING COMMENT 'The method used to capture the parameter measurement: manual entry by operator, automated sensor reading, inline PAT sensor, or laboratory analysis.. Valid values are `manual|automated|inline_sensor|laboratory|PAT`',
    `measurement_timestamp` TIMESTAMP COMMENT 'The date and time when the parameter measurement was taken during the manufacturing process. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `oos_flag` BOOLEAN COMMENT 'Boolean indicator whether the measured value falls outside the defined control limits (True = out of specification, False = within specification).',
    `parameter_code` STRING COMMENT 'The parameter code of the process parameter record',
    `parameter_name` STRING COMMENT 'Name of the process parameter being measured (e.g., temperature, pH, viscosity, fill weight, torque, pressure, mixing speed, dwell time).',
    `parameter_type` STRING COMMENT 'Classification of the parameter: CPP (Critical Process Parameter), CQA (Critical Quality Attribute), IPC (In-Process Control), PAT (Process Analytical Technology).. Valid values are `CPP|CQA|IPC|PAT`',
    `parameter_value` DECIMAL(18,2) COMMENT 'The parameter value of the process parameter record',
    `process_stage` STRING COMMENT 'The manufacturing process stage or operation step during which the parameter was measured (e.g., mixing, heating, filling, cooling, packaging).',
    `production_line` STRING COMMENT 'Identifier of the specific production line within the work center where the parameter was measured. Enables line-level performance analysis.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this process parameter record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this process parameter record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `regulatory_reportable` BOOLEAN COMMENT 'Boolean indicator whether this parameter measurement must be included in regulatory submissions or audit documentation (True = reportable, False = internal only).',
    `sample_code` STRING COMMENT 'Identifier of the physical sample taken for measurement, if applicable. Links to laboratory information management system (LIMS).. Valid values are `^[A-Z0-9]{8,20}$`',
    `sensor_code` STRING COMMENT 'Identifier of the specific sensor or probe that captured the measurement, if applicable. Used for sensor calibration tracking.. Valid values are `^[A-Z0-9]{6,15}$`',
    `shift_code` STRING COMMENT 'Code identifying the production shift during which the parameter measurement was taken (e.g., A, B, C, or day/night shift codes).. Valid values are `^[A-Z0-9]{1,3}$`',
    `source_system_code` STRING COMMENT 'The source system code of the process parameter record',
    `target_value` DECIMAL(18,2) COMMENT 'The target or setpoint value for the process parameter as defined in the batch master recipe or process specification.',
    `unit_of_measure` STRING COMMENT 'The unit in which the parameter is measured (e.g., Celsius, pH units, cP for viscosity, grams, PSI, RPM, seconds).',
    `uom` STRING COMMENT 'The uom of the process parameter record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the process parameter record',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'The upper acceptable boundary for the parameter value. Values above this threshold trigger out-of-specification alerts.',
    `upper_limit` DECIMAL(18,2) COMMENT 'The upper limit of the process parameter record',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'The upper spec limit of the process parameter record',
    `verification_status` STRING COMMENT 'Status of the parameter measurement verification by quality assurance: pending review, verified as acceptable, rejected, or under investigation.. Valid values are `pending|verified|rejected|under_investigation`',
    `verification_timestamp` TIMESTAMP COMMENT 'The date and time when the parameter measurement was verified by quality assurance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `verified_by` STRING COMMENT 'Identifier of the quality assurance personnel who verified or approved the parameter measurement record.. Valid values are `^[A-Z0-9]{6,12}$`',
    CONSTRAINT pk_process_parameter PRIMARY KEY(`process_parameter_id`)
) COMMENT 'In-process control (IPC) and critical process parameter (CPP) record capturing measured process variables during manufacturing operations. Captures parameter record ID, batch record reference, work order reference, work center, parameter name (temperature, pH, viscosity, fill weight, torque, pressure), parameter type (CPP, CQA, IPC), target value, lower control limit, upper control limit, actual measured value, unit of measure, measurement timestamp, measurement method, operator ID, and out-of-specification (OOS) flag. Supports GMP process validation and real-time SPC monitoring.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` (
    `planned_order_id` BIGINT COMMENT 'Unique system-generated identifier for the planned order record. Primary key for the planned order entity.',
    `production_order_id` BIGINT COMMENT 'Reference to the production order that was created from this planned order upon conversion. Null if not yet converted.',
    `employee_id` BIGINT COMMENT 'Reference to the production planner or planning team responsible for managing this planned order.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where production is planned to occur.',
    `production_line_id` BIGINT COMMENT 'The production line id of the planned order record',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) that this planned order is for. Links to the product master data.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Supports demand‑planning reports linking planned production to specific customer accounts and forecast agreements.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Planned Promotional Production aligns MRP planned orders with upcoming trade promotions to ensure supply availability.',
    `availability_date` DATE COMMENT 'The date when the produced or procured material from this planned order is expected to be available for consumption or shipment.',
    `conversion_date` DATE COMMENT 'The date when this planned order was converted to a production order. Null if not yet converted.',
    `conversion_status` STRING COMMENT 'Indicates whether this planned order has been converted to a production order: NOT_CONVERTED (still in planning), PARTIALLY_CONVERTED (split conversion), FULLY_CONVERTED (completely converted).. Valid values are `NOT_CONVERTED|PARTIALLY_CONVERTED|FULLY_CONVERTED`',
    `created_by_user` STRING COMMENT 'User ID or system identifier of the person or automated process that created this planned order.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this planned order record was first created in the system.',
    `demand_source_reference` STRING COMMENT 'Reference number or identifier of the originating demand document (sales order number, forecast ID, transfer request number, etc.).',
    `demand_source_type` STRING COMMENT 'Classification of the demand signal that triggered this planned order: FORECAST (demand planning), CUSTOMER_ORDER (firm sales order), STOCK_TRANSFER (inter-plant), SAFETY_STOCK (replenishment), PROMOTION (trade promotion demand).. Valid values are `FORECAST|CUSTOMER_ORDER|STOCK_TRANSFER|SAFETY_STOCK|PROMOTION`',
    `exception_message_code` STRING COMMENT 'Code representing MRP exception conditions (e.g., EX01 = reschedule in, EX02 = reschedule out, EX03 = cancel, EX10 = expedite). Empty if no exception.. Valid values are `^(EX[0-9]{2})?$`',
    `exception_message_text` STRING COMMENT 'Human-readable description of the MRP exception condition requiring planner attention.',
    `firmed_flag` BOOLEAN COMMENT 'The firmed flag of the planned order record',
    `firming_date` DATE COMMENT 'The date when this planned order was firmed by a planner. Null if not yet firmed.',
    `firming_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this planned order is firmed (locked from automatic MRP changes). True = firmed, False = subject to MRP rescheduling.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether this planned order must comply with GMP regulations. True for pharmaceutical and cosmetic products requiring ISO 22716 compliance.',
    `ibp_plan_version` STRING COMMENT 'Version identifier from SAP IBP system that generated the demand signal driving this planned order. Format: IBP-YYYYMM.. Valid values are `^IBP-[0-9]{6}$`',
    `last_modified_by_user` STRING COMMENT 'User ID or system identifier of the person or automated process that last modified this planned order.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this planned order record was last updated or modified.',
    `lot_size_key` STRING COMMENT 'Code indicating the lot-sizing procedure used: EX (exact lot size), HB (lot-for-lot), FX (fixed lot size), PD (periodic lot size), WM (weekly lot size).. Valid values are `EX|HB|FX|PD|WM`',
    `mrp_controller` STRING COMMENT 'Code identifying the MRP controller or planning group responsible for this material and plant combination.. Valid values are `^[A-Z0-9]{3,10}$`',
    `mrp_run_code` BIGINT COMMENT 'Reference to the specific MRP run that generated or last modified this planned order. Links to MRP execution history.',
    `mrp_run_date` DATE COMMENT 'The mrp run date of the planned order record',
    `notes` STRING COMMENT 'Free-text field for planners to add comments, special instructions, or contextual information about this planned order.',
    `order_number` STRING COMMENT 'Business-readable unique identifier for the planned order, typically system-generated following organizational numbering conventions.. Valid values are `^[A-Z0-9]{8,12}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the planned order: DRAFT (initial creation), FIRMED (locked from MRP changes), RELEASED (approved for execution), CONVERTED (converted to production order), DELETED (marked for deletion), CANCELLED (cancelled before conversion).. Valid values are `DRAFT|FIRMED|RELEASED|CONVERTED|DELETED|CANCELLED`',
    `order_type` STRING COMMENT 'Classification of the planned order origin: MPS (Master Production Schedule), MRP (Material Requirements Planning generated), CBP (Consumption-Based Planning), MANUAL (manually created), FORECAST (forecast-driven), SAFETY (safety stock replenishment).. Valid values are `MPS|MRP|CBP|MANUAL|FORECAST|SAFETY`',
    `planned_end_date` DATE COMMENT 'The planned end date of the planned order record',
    `planned_order_number` STRING COMMENT 'The planned order number of the planned order record',
    `planned_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU planned to be produced or procured in this order, expressed in the base unit of measure.',
    `planned_start_date` DATE COMMENT 'The planned start date of the planned order record',
    `planning_period` STRING COMMENT 'The planning time bucket this order belongs to, expressed as YYYY-Wnn (week), YYYY-Mnn (month), or YYYY-Qn (quarter). Used for MPS and S&OP alignment.. Valid values are `^[0-9]{4}-(W[0-9]{2}|M[0-9]{2}|Q[1-4])$`',
    `planning_strategy_group` STRING COMMENT 'Two-digit code defining the planning strategy (e.g., 10 = make-to-stock, 20 = make-to-order, 40 = planning with final assembly, 50 = planning without final assembly).. Valid values are `^[0-9]{2}$`',
    `priority_code` STRING COMMENT 'Priority level assigned to this planned order for scheduling and resource allocation: LOW, NORMAL, HIGH, URGENT.. Valid values are `LOW|NORMAL|HIGH|URGENT`',
    `procurement_type` STRING COMMENT 'Indicates whether this planned order is for in-house production (IN_HOUSE), external procurement (EXTERNAL), or can be either (BOTH).. Valid values are `IN_HOUSE|EXTERNAL|BOTH`',
    `production_version` STRING COMMENT 'Identifies the specific combination of BOM (Bill of Materials) and routing to be used for production. Links to production master data.. Valid values are `^[0-9]{4}$`',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'The inventory level that triggers generation of a planned order for replenishment.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The safety stock level maintained for this SKU at this plant, influencing planned order generation.',
    `schedule_version` STRING COMMENT 'Version identifier for the MPS schedule that generated or governs this planned order. Enables tracking of schedule changes over time.. Valid values are `^V[0-9]{3}$`',
    `scheduled_finish_date` DATE COMMENT 'The planned date when production or procurement activities for this order should be completed and goods available.',
    `scheduled_start_date` DATE COMMENT 'The planned date when production or procurement activities for this order should begin.',
    `sop_cycle_reference` STRING COMMENT 'Reference to the S&OP planning cycle that this planned order aligns with. Format: SOP-YYYY-Mnn or SOP-YYYY-Qn.. Valid values are `^SOP-[0-9]{4}-(M[0-9]{2}|Q[1-4])$`',
    `source_system_code` STRING COMMENT 'The source system code of the planned order record',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the planned quantity (e.g., EA for each, KG for kilogram, L for liter). Follows ISO standard unit codes.. Valid values are `^[A-Z]{2,3}$`',
    `uom` STRING COMMENT 'The uom of the planned order record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the planned order record',
    CONSTRAINT pk_planned_order PRIMARY KEY(`planned_order_id`)
) COMMENT 'Production planning record representing the complete planning pipeline from S&OP/IBP through MRP execution to production order conversion. Encompasses both Master Production Schedule (MPS) entries (planned quantities by SKU/facility/period with schedule versioning) and MRP-generated planned orders (system-proposed production or procurement proposals). Captures planned order ID, order type (MPS, MRP planned, CBP), SKU, plant, MRP run reference, planned quantity, scheduled start/finish dates, planning period (week/month), schedule version, S&OP cycle reference, IBP plan version, firming indicator, schedule status (draft, firmed, released, converted, deleted), exception message code, planner ID, and conversion status. SSOT for MRP exception management, MPS governance, and the complete production planning pipeline from demand signal through to production order creation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` (
    `equipment_id` BIGINT COMMENT 'Primary key for equipment',
    `equipment_production_line_id` BIGINT COMMENT 'The equipment production line id of the equipment record',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the plant entity that houses the equipment.',
    `parent_equipment_id` BIGINT COMMENT 'Self-referencing FK on equipment (parent_equipment_id)',
    `production_line_id` BIGINT COMMENT 'Reference to the production line on which the equipment operates.',
    `work_center_id` BIGINT COMMENT 'The work center id of the equipment record',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Purchase price paid for the equipment.',
    `asset_tag` STRING COMMENT 'Internal tag or barcode used to physically label the equipment.',
    `calibration_due_date` DATE COMMENT 'Scheduled date for the next calibration.',
    `capacity_units` STRING COMMENT 'Unit of measure for the equipments capacity.',
    `capacity_value` DECIMAL(18,2) COMMENT 'Numeric capacity of the equipment expressed in the specified units.',
    `equipment_code` STRING COMMENT 'The equipment code of the equipment record',
    `compliance_gmp` BOOLEAN COMMENT 'Indicates whether the equipment complies with GMP standards.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the equipment record',
    `currency` STRING COMMENT 'Currency in which the acquisition cost is expressed.',
    `department` STRING COMMENT 'Organizational department responsible for the equipment.',
    `depreciation_end_date` DATE COMMENT 'Date when the equipment is fully depreciated.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the equipment.',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation of the equipment begins.',
    `equipment_description` STRING COMMENT 'Free‑form text describing the equipments purpose and characteristics.',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Total energy consumed by the equipment in kilowatt‑hours.',
    `equipment_status` STRING COMMENT 'Current operational state of the equipment.',
    `equipment_type` STRING COMMENT 'Category of equipment based on function or form factor.',
    `hazard_classification` STRING COMMENT 'Level of hazard associated with equipment operation.',
    `install_date` DATE COMMENT 'The install date of the equipment record',
    `installation_date` DATE COMMENT 'Date the equipment was installed and became operational.',
    `last_calibration_date` DATE COMMENT 'Date when the equipment was last calibrated.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance.',
    `location_code` STRING COMMENT 'Code identifying the plant or facility where the equipment resides.',
    `maintenance_cost` DECIMAL(18,2) COMMENT 'Cost incurred for the most recent maintenance activity.',
    `maintenance_frequency_days` STRING COMMENT 'Number of days between routine maintenance events.',
    `manufacturer` STRING COMMENT 'Company that produced the equipment.',
    `model_number` STRING COMMENT 'Model identifier assigned by the manufacturer.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating hours between equipment failures.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair equipment after a failure.',
    `equipment_name` STRING COMMENT 'Human‑readable name or designation of the equipment.',
    `next_calibration_date` DATE COMMENT 'The next calibration date of the equipment record',
    `next_maintenance_date` DATE COMMENT 'The next maintenance date of the equipment record',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next maintenance activity.',
    `oee_actual` DECIMAL(18,2) COMMENT 'Measured Overall Equipment Effectiveness percentage.',
    `oee_target` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness percentage.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Maximum power consumption of the equipment in kilowatts.',
    `purchase_date` DATE COMMENT 'Date the equipment was purchased.',
    `safety_rating` STRING COMMENT 'Safety classification of the equipment.',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the equipment.',
    `source_system_code` STRING COMMENT 'The source system code of the equipment record',
    `total_usage_hours` DECIMAL(18,2) COMMENT 'Cumulative operating hours since installation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the equipment record',
    `voltage` DECIMAL(18,2) COMMENT 'Nominal operating voltage of the equipment.',
    `warranty_end_date` DATE COMMENT 'Date when the equipment warranty expires.',
    `warranty_start_date` DATE COMMENT 'Date when the equipment warranty period begins.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight of the equipment in kilograms.',
    CONSTRAINT pk_equipment PRIMARY KEY(`equipment_id`)
) COMMENT 'Master reference table for equipment. Referenced by equipment_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_manufacturing_bom_id` FOREIGN KEY (`manufacturing_bom_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom`(`manufacturing_bom_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ADD CONSTRAINT `fk_manufacturing_oee_record_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ADD CONSTRAINT `fk_manufacturing_oee_record_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ADD CONSTRAINT `fk_manufacturing_oee_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ADD CONSTRAINT `fk_manufacturing_oee_record_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ADD CONSTRAINT `fk_manufacturing_yield_record_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_prior_event_gmp_event_id` FOREIGN KEY (`prior_event_gmp_event_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event`(`gmp_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ADD CONSTRAINT `fk_manufacturing_gmp_event_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ADD CONSTRAINT `fk_manufacturing_planned_order_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_equipment_production_line_id` FOREIGN KEY (`equipment_production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_manufacturing_facility_id` FOREIGN KEY (`manufacturing_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`(`manufacturing_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_parent_equipment_id` FOREIGN KEY (`parent_equipment_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_consumer_goods_v1`.`manufacturing`.`work_center`(`work_center_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`manufacturing` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`manufacturing` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` SET TAGS ('dbx_ssot_concept' = 'facility');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` SET TAGS ('dbx_ssot_canonical' = 'distribution.distribution_facility');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` SET TAGS ('dbx_ssot_role' = 'primary');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `capacity_units_per_year` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Year');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `capacity_units_per_year` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `capacity_units_per_year` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `city` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `energy_consumption_kwh_per_year` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (Kilowatt-Hours Per Year)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `epa_site_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Site ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `erp_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'mixing|filling|packaging|co-manufacturing|integrated|contract');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `fda_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Establishment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `fda_establishment_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `gmp_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `gmp_certified` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `gmp_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `iso_22716_compliance_tier` SET TAGS ('dbx_business_glossary_term' = 'ISO 22716 Compliance Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `iso_22716_compliance_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|non_compliant');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `iso_certification` SET TAGS ('dbx_business_glossary_term' = 'Iso Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `manufacturing_facility_status` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `mes_system_integrated` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Integrated');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `number_of_production_lines` SET TAGS ('dbx_business_glossary_term' = 'Number of Production Lines');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|startup|decommissioned|seasonal');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `osha_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Establishment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|contract|joint_venture');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `primary_product_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `production_capacity_units_per_day` SET TAGS ('dbx_business_glossary_term' = 'Production Capacity (Units Per Day)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `production_capacity_units_per_day` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `production_capacity_units_per_day` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single|two_shift|three_shift|continuous|flexible');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|not_rated');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `water_consumption_cubic_meters_per_year` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption (Cubic Meters Per Year)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility` ALTER COLUMN `workforce_headcount` SET TAGS ('dbx_business_glossary_term' = 'Workforce Headcount');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `allergen_handling_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Handling Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `allergen_types` SET TAGS ('dbx_business_glossary_term' = 'Allergen Types');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated|lights_out');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `changeover_time_standard_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time Standard (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `changeover_time_standard_minutes` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `changeover_time_standard_minutes` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `cleaning_validation_protocol` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Validation Protocol');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `crew_size_standard` SET TAGS ('dbx_business_glossary_term' = 'Standard Crew Size');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `design_capacity` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `design_capacity` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `design_capacity` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `design_capacity_units_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Units Per Hour');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `design_capacity_units_per_hour` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `design_capacity_units_per_hour` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `design_speed_units_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Design Speed (Units Per Hour)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `energy_consumption_kwh_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (Kilowatt-Hours Per Unit)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `environmental_control_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Control Required');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'gmp_a|gmp_b|gmp_c|gmp_d|non_gmp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `humidity_range_percent` SET TAGS ('dbx_business_glossary_term' = 'Operating Humidity Range (Percent)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `installed_power_kw` SET TAGS ('dbx_business_glossary_term' = 'Installed Power (Kilowatts)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `last_major_overhaul_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Overhaul Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Production Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `line_length_meters` SET TAGS ('dbx_business_glossary_term' = 'Production Line Length (Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Production Line Name');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Production Line Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'filling|blending|packaging|assembly|labeling|palletizing');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `mean_time_between_failures_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR) Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `mes_asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Asset Tag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `mes_asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `nominal_oee_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Nominal Overall Equipment Effectiveness (OEE) Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Production Line Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned|startup|idle');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `plc_system_type` SET TAGS ('dbx_business_glossary_term' = 'Programmable Logic Controller (PLC) System Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `product_category_capability` SET TAGS ('dbx_business_glossary_term' = 'Product Category Capability');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `production_line_status` SET TAGS ('dbx_business_glossary_term' = 'Production Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `quality_inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `quality_inspection_frequency` SET TAGS ('dbx_value_regex' = 'continuous|hourly|per_batch|per_shift|daily');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `rated_speed_uph` SET TAGS ('dbx_business_glossary_term' = 'Rated Speed Uph');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `scada_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control And Data Acquisition (SCADA) Integration Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `scrap_rate_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Scrap Rate Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single_shift|two_shift|three_shift|continuous|custom');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `temperature_range_celsius` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Range (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_line` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `available_capacity_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Hours Per Day');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `available_capacity_hours_per_day` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `available_capacity_hours_per_day` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `capacity_category` SET TAGS ('dbx_business_glossary_term' = 'Capacity Category');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `capacity_category` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `capacity_category` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `capacity_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Capacity Per Hour');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `capacity_per_hour` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `capacity_per_hour` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'units_per_hour|units_per_shift|kg_per_hour|liters_per_hour|cases_per_hour');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_business_glossary_term' = 'Work Center Category');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_value_regex' = 'machine|production_line|assembly_station|quality_control|warehouse|maintenance');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `clean_room_class` SET TAGS ('dbx_business_glossary_term' = 'Clean Room Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `crew_size` SET TAGS ('dbx_business_glossary_term' = 'Crew Size');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `work_center_description` SET TAGS ('dbx_business_glossary_term' = 'Work Center Description');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `energy_consumption_kwh_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (kWh per Hour)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `gmp_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Qualification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `gmp_qualification_status` SET TAGS ('dbx_value_regex' = 'not_qualified|iq_complete|oq_complete|pq_complete|fully_qualified|requalification_required');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `hazardous_area_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Area Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `humidity_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Humidity Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `maintenance_class` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Class');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `maintenance_class` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'preventive|predictive|reactive|condition_based');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `mes_equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Equipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `mes_equipment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `work_center_name` SET TAGS ('dbx_business_glossary_term' = 'Work Center Name');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `operator_skill_level_required` SET TAGS ('dbx_business_glossary_term' = 'Operator Skill Level Required');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `operator_skill_level_required` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|expert|certified');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Requalification Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `safety_certification` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single_shift|two_shift|three_shift|continuous|custom');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `standard_cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Cycle Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `standard_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `standard_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Standard Rate Per Hour');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `teardown_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Teardown Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `utilization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `work_center_status` SET TAGS ('dbx_business_glossary_term' = 'Work Center Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `work_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned|under_qualification|blocked');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `work_center_type` SET TAGS ('dbx_business_glossary_term' = 'Work Center Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`work_center` ALTER COLUMN `work_center_type` SET TAGS ('dbx_value_regex' = 'mixing_vessel|filling_machine|labeler|capper|palletizer|packaging_line');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `manufacturing_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Bill of Materials (BOM) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `primary_manufacturing_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `alternative_item_group` SET TAGS ('dbx_business_glossary_term' = 'Alternative Item Group');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `alternative_item_priority` SET TAGS ('dbx_business_glossary_term' = 'Alternative Item Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `backflush_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backflush Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `base_uom` SET TAGS ('dbx_business_glossary_term' = 'Base Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|obsolete|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_type` SET TAGS ('dbx_value_regex' = 'production|co-product|phantom|engineering|planning');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `bom_version` SET TAGS ('dbx_business_glossary_term' = 'Bom Version');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `component_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Component Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `component_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Component Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `component_item_category` SET TAGS ('dbx_business_glossary_term' = 'Component Item Category');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `component_item_category` SET TAGS ('dbx_value_regex' = 'stock|non-stock|phantom|text|variable_size');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `component_item_number` SET TAGS ('dbx_business_glossary_term' = 'Component Item Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `component_quantity` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `component_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Component Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `critical_component_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Component Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `inci_name` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Name');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `lot_size_requirement` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Requirement');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `lot_size_requirement` SET TAGS ('dbx_value_regex' = 'exact|minimum|multiple|none');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `manufacturing_bom_status` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Bom Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `minimum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `plm_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `scrap_factor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Factor Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `tertiary_routing_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `tertiary_routing_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `tertiary_routing_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_description` SET TAGS ('dbx_business_glossary_term' = 'Routing Description');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `expected_scrap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Expected Scrap Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `expected_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Expected Yield Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `gmp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Critical Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `ipc_checkpoint_count` SET TAGS ('dbx_business_glossary_term' = 'In-Process Control (IPC) Checkpoint Count');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `lot_size_restriction` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Restriction');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `lot_size_restriction` SET TAGS ('dbx_value_regex' = 'none|fixed|minimum|maximum|multiple');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `maximum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lot Size');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `minimum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `operation_count` SET TAGS ('dbx_business_glossary_term' = 'Operation Count');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `operation_description` SET TAGS ('dbx_business_glossary_term' = 'Operation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `operation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Operation Sequence');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `production_scheduler_code` SET TAGS ('dbx_business_glossary_term' = 'Production Scheduler Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `production_scheduler_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|obsolete|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_value_regex' = 'standard|reference|rate|alternative|special');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `run_time_per_unit_minutes` SET TAGS ('dbx_business_glossary_term' = 'Run Time Per Unit Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `total_labor_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `total_machine_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Machine Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `total_setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Setup Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `total_standard_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Standard Lead Time (Hours)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `total_standard_time_min` SET TAGS ('dbx_business_glossary_term' = 'Total Standard Time Min');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Routing Version');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`routing` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_subdomain' = 'shop_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `manufacturing_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Bom Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `product_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `production_line_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `actual_end` SET TAGS ('dbx_business_glossary_term' = 'Actual End');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `actual_start` SET TAGS ('dbx_business_glossary_term' = 'Actual Start');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time in Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Production Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `cost_object` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Object');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `cost_object` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Production Downtime in Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Production Order Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Production Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Production Order Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'PP01|PP03|PP05|PP10|PP20');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `planned_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Production Order Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `production_supervisor` SET TAGS ('dbx_business_glossary_term' = 'Production Supervisor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `production_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `released_by` SET TAGS ('dbx_business_glossary_term' = 'Released By User');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Release Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `scheduled_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `scheduled_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_business_glossary_term' = 'Cost Settlement Rule');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_value_regex' = 'FUL|PAR|PER');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Production Yield Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` SET TAGS ('dbx_subdomain' = 'shop_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `carbon_offset_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspector ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Formulation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `research_formulation_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `batch_size_actual` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Actual');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `batch_size_planned` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Planned');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'in_process|released|rejected|quarantine|recalled|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `bom_version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `bom_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{1,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `changeover_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `changeover_minutes` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `changeover_minutes` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `electronic_signature_count` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Count');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `gmp_compliant` SET TAGS ('dbx_business_glossary_term' = 'Gmp Compliant');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `gmp_deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Deviation Count');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `gmp_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Deviation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `gmp_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Gmp Reviewed');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `lot_genealogy_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Lot Genealogy Complete Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `manufactured_quantity` SET TAGS ('dbx_business_glossary_term' = 'Manufactured Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `manufacturing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `manufacturing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `quality_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Release Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `quality_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Release Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `quantity_produced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Produced');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `recall_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiated Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `record_locked_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Locked Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `released` SET TAGS ('dbx_business_glossary_term' = 'Released');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `review_by_exception` SET TAGS ('dbx_business_glossary_term' = 'Review By Exception');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `routing_version` SET TAGS ('dbx_business_glossary_term' = 'Routing Version');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `routing_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{1,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_value_regex' = '^VV[A-Z0-9]{10,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`batch_record` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` SET TAGS ('dbx_subdomain' = 'performance_quality');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `oee_record_id` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Supervisor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `actual_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Cycle Time (Seconds)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `actual_operating_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Operating Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `actual_runtime_min` SET TAGS ('dbx_business_glossary_term' = 'Actual Runtime Min');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `availability_pct` SET TAGS ('dbx_business_glossary_term' = 'Availability Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `availability_rate` SET TAGS ('dbx_business_glossary_term' = 'Availability Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `changeover_count` SET TAGS ('dbx_business_glossary_term' = 'Changeover Count');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `changeover_count` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `changeover_count` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'OEE Record Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'automated|manual|semi_automated');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `good_units_produced` SET TAGS ('dbx_business_glossary_term' = 'Good Units Produced');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `ideal_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ideal Cycle Time (Seconds)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `mes_data_source` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `micro_stop_count` SET TAGS ('dbx_business_glossary_term' = 'Micro Stop Count');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `oee_pct` SET TAGS ('dbx_business_glossary_term' = 'Oee Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `oee_status` SET TAGS ('dbx_business_glossary_term' = 'OEE Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `oee_status` SET TAGS ('dbx_value_regex' = 'draft|validated|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `operator_count` SET TAGS ('dbx_business_glossary_term' = 'Operator Count');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `performance_pct` SET TAGS ('dbx_business_glossary_term' = 'Performance Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `performance_rate` SET TAGS ('dbx_business_glossary_term' = 'Performance Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `planned_production_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `planned_runtime_min` SET TAGS ('dbx_business_glossary_term' = 'Planned Runtime Min');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `quality_loss_minutes` SET TAGS ('dbx_business_glossary_term' = 'Quality Loss (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `quality_pct` SET TAGS ('dbx_business_glossary_term' = 'Quality Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `quality_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `rework_units` SET TAGS ('dbx_business_glossary_term' = 'Rework Units');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `scrap_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Scrap Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `shift_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Name');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `shift_name` SET TAGS ('dbx_value_regex' = 'day|evening|night|morning|afternoon|graveyard');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `shift_number` SET TAGS ('dbx_business_glossary_term' = 'Shift Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `speed_loss_minutes` SET TAGS ('dbx_business_glossary_term' = 'Speed Loss (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `total_units_produced` SET TAGS ('dbx_business_glossary_term' = 'Total Units Produced');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `total_units_rejected` SET TAGS ('dbx_business_glossary_term' = 'Total Units Rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `unplanned_stop_count` SET TAGS ('dbx_business_glossary_term' = 'Unplanned Stop Count');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`oee_record` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` SET TAGS ('dbx_subdomain' = 'performance_quality');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_event_id` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `batch_hold_required` SET TAGS ('dbx_business_glossary_term' = 'Batch Hold Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'mes_automatic|manual_entry|sensor|scada');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Downtime Category');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_category` SET TAGS ('dbx_value_regex' = 'mechanical_failure|electrical_failure|changeover|material_shortage|operator_absence|planned_maintenance');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_type` SET TAGS ('dbx_business_glossary_term' = 'Downtime Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `downtime_type` SET TAGS ('dbx_value_regex' = 'planned|unplanned');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `duration_min` SET TAGS ('dbx_business_glossary_term' = 'Duration Min');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `equipment_failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Equipment Failure Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|supervisor|manager|director|executive');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `is_planned` SET TAGS ('dbx_business_glossary_term' = 'Is Planned');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `oee_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Impact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `preventive_action_required` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `production_loss_units` SET TAGS ('dbx_business_glossary_term' = 'Production Loss in Units');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `responsible_department` SET TAGS ('dbx_value_regex' = 'production|maintenance|quality|materials|engineering|utilities');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` SET TAGS ('dbx_subdomain' = 'shop_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `changeover_id` SET TAGS ('dbx_business_glossary_term' = 'Changeover ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `changeover_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `changeover_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'From Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `employee_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `to_sku_id` SET TAGS ('dbx_business_glossary_term' = 'To Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `work_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `changeover_status` SET TAGS ('dbx_business_glossary_term' = 'Changeover Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `changeover_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|delayed');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `changeover_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `changeover_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `changeover_type` SET TAGS ('dbx_business_glossary_term' = 'Changeover Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `changeover_type` SET TAGS ('dbx_value_regex' = 'flavor|format|size|cleaning|material|color');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `changeover_type` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `changeover_type` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `cleaning_required` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Required');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `cleaning_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Verification Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `downtime_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `downtime_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `downtime_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `duration_min` SET TAGS ('dbx_business_glossary_term' = 'Duration Min');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `equipment_adjustment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Adjustment Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `first_pass_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'First Pass Yield Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `gmp_cleaning_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Cleaning Verified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `improvement_initiative_code` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `material_waste_kg` SET TAGS ('dbx_business_glossary_term' = 'Material Waste (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `oee_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Impact Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `smed_improvement_flag` SET TAGS ('dbx_business_glossary_term' = 'Single-Minute Exchange of Die (SMED) Improvement Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `standard_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Duration (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `team_size` SET TAGS ('dbx_business_glossary_term' = 'Team Size');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `tooling_change_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Tooling Change Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`changeover` ALTER COLUMN `variance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Variance (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` SET TAGS ('dbx_subdomain' = 'shop_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `tertiary_yield_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `tertiary_yield_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `tertiary_yield_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `actual_yield` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `actual_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `actual_yield_qty` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Qty');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `batch_record_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `batch_record_status` SET TAGS ('dbx_value_regex' = 'DRAFT|IN_PROGRESS|COMPLETED|REVIEWED|APPROVED|REJECTED');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `erp_document_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `erp_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `input_quantity` SET TAGS ('dbx_business_glossary_term' = 'Input Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `operation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operation End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `operation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operation Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `output_quantity` SET TAGS ('dbx_business_glossary_term' = 'Output Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `planned_yield_qty` SET TAGS ('dbx_business_glossary_term' = 'Planned Yield Qty');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `production_line_code` SET TAGS ('dbx_business_glossary_term' = 'Production Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `production_line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `quality_inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `quality_inspection_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `routing_operation_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Operation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `routing_operation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `scrap_qty` SET TAGS ('dbx_business_glossary_term' = 'Scrap Qty');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'SHIFT_1|SHIFT_2|SHIFT_3|DAY|NIGHT|WEEKEND');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `standard_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `standard_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `theoretical_yield` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Yield');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `theoretical_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Yield Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `yield_loss_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `yield_loss_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `yield_loss_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Yield Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `yield_variance_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Yield Variance Cost Impact');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `yield_variance_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`yield_record` ALTER COLUMN `yield_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Variance Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` SET TAGS ('dbx_subdomain' = 'performance_quality');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `gmp_event_id` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `gmp_reported_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `gmp_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `gmp_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `primary_gmp_detected_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Detected By Employee ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `primary_gmp_detected_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `primary_gmp_detected_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `prior_event_gmp_event_id` SET TAGS ('dbx_business_glossary_term' = 'Prior GMP Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `production_line_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `affected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Affected Batch Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `affected_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Affected Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `affected_quantity_uom` SET TAGS ('dbx_value_regex' = 'KG|L|EA|G|ML|LB');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'GMP Event Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `batch_disposition` SET TAGS ('dbx_business_glossary_term' = 'Batch Disposition Decision');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `batch_disposition` SET TAGS ('dbx_value_regex' = 'released|quarantined|rejected|reworked|destroyed');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `ccp_code` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point (CCP) Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'GMP Event Closure Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `containment_action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Containment Action Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `gmp_event_description` SET TAGS ('dbx_business_glossary_term' = 'Gmp Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'GMP Event Detection Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `electronic_signature` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `electronic_signature` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `environmental_zone` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `environmental_zone` SET TAGS ('dbx_value_regex' = 'grade_a|grade_b|grade_c|grade_d|unclassified');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'GMP Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'GMP Event Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^GMP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_business_glossary_term' = 'GMP Event Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'GMP Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_capa|closed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'GMP Event Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'deviation|oos_result|environmental_monitoring_excursion|equipment_failure|process_parameter_breach|contamination_event');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `gmp_event_status` SET TAGS ('dbx_business_glossary_term' = 'Gmp Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Corrective Action Taken');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `investigation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `is_product_recall_trigger` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Trigger Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Process Step');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'GMP Regulation Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'GMP Event Risk Score');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `sap_qm_notification_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Quality Management (QM) Notification Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Production Shift Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`gmp_event` ALTER COLUMN `veeva_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_subdomain' = 'shop_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `production_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Production Confirmation ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `production_confirmed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Confirmed By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `production_confirmed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `production_confirmed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `production_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `production_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `production_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date Time');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `actual_labor_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `actual_machine_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Machine Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `actual_setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Setup Time (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date Time');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmation_notes` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmation_type` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmation_type` SET TAGS ('dbx_value_regex' = 'partial|final|milestone|rework|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmed_scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Scrap Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `confirmed_yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Yield Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime (Minutes)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `machine_hours` SET TAGS ('dbx_business_glossary_term' = 'Machine Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_value_regex' = '^MES[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `oee_availability_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Availability Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `oee_performance_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Performance Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `oee_quality_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Quality Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `operation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `operation_status` SET TAGS ('dbx_business_glossary_term' = 'Operation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `operation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `rework_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date Time');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date Time');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^(SHIFT_[1-3]|DAY|NIGHT|SWING)$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_PP|OPCENTER_MES|MANUAL');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO[0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Yield Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` SET TAGS ('dbx_subdomain' = 'performance_quality');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `process_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Process Parameter ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Measured Value');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Measurement Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'MES|SCADA|LIMS|manual_entry|ERP');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `deviation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deviation Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `in_spec` SET TAGS ('dbx_business_glossary_term' = 'In Spec');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `in_spec_flag` SET TAGS ('dbx_business_glossary_term' = 'In Spec Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Spec Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `measured_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measured Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'manual|automated|inline_sensor|laboratory|PAT');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Specification (OOS) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `parameter_type` SET TAGS ('dbx_business_glossary_term' = 'Parameter Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `parameter_type` SET TAGS ('dbx_value_regex' = 'CPP|CQA|IPC|PAT');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `parameter_value` SET TAGS ('dbx_business_glossary_term' = 'Parameter Value');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `process_stage` SET TAGS ('dbx_business_glossary_term' = 'Process Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `production_line` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `sample_code` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `sample_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `sensor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Production Shift Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Spec Limit');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|under_investigation');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `verified_by` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `verified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Production Order Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Production Planner Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `availability_date` SET TAGS ('dbx_business_glossary_term' = 'Material Availability Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Conversion to Production Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `conversion_status` SET TAGS ('dbx_value_regex' = 'NOT_CONVERTED|PARTIALLY_CONVERTED|FULLY_CONVERTED');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `demand_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Demand Source Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `demand_source_type` SET TAGS ('dbx_business_glossary_term' = 'Demand Source Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `demand_source_type` SET TAGS ('dbx_value_regex' = 'FORECAST|CUSTOMER_ORDER|STOCK_TRANSFER|SAFETY_STOCK|PROMOTION');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `exception_message_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Exception Message Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `exception_message_code` SET TAGS ('dbx_value_regex' = '^(EX[0-9]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `exception_message_text` SET TAGS ('dbx_business_glossary_term' = 'Exception Message Description');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `firmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Firmed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `firming_date` SET TAGS ('dbx_business_glossary_term' = 'Firming Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `firming_indicator` SET TAGS ('dbx_business_glossary_term' = 'Firming Indicator Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `ibp_plan_version` SET TAGS ('dbx_business_glossary_term' = 'Integrated Business Planning (IBP) Plan Version');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `ibp_plan_version` SET TAGS ('dbx_value_regex' = '^IBP-[0-9]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `lot_size_key` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Calculation Key');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `lot_size_key` SET TAGS ('dbx_value_regex' = 'EX|HB|FX|PD|WM');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `mrp_run_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Run Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `mrp_run_date` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Planning Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'DRAFT|FIRMED|RELEASED|CONVERTED|DELETED|CANCELLED');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'MPS|MRP|CBP|MANUAL|FORECAST|SAFETY');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `planned_order_number` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `planning_period` SET TAGS ('dbx_business_glossary_term' = 'Planning Period');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `planning_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(W[0-9]{2}|M[0-9]{2}|Q[1-4])$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `planning_strategy_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Strategy Group');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `planning_strategy_group` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Planning Priority Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'LOW|NORMAL|HIGH|URGENT');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'IN_HOUSE|EXTERNAL|BOTH');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `production_version` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Master Production Schedule (MPS) Version');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `schedule_version` SET TAGS ('dbx_value_regex' = '^V[0-9]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `sop_cycle_reference` SET TAGS ('dbx_business_glossary_term' = 'Sales and Operations Planning (S&OP) Cycle Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `sop_cycle_reference` SET TAGS ('dbx_value_regex' = '^SOP-[0-9]{4}-(M[0-9]{2}|Q[1-4])$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`planned_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `equipment_production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `parent_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Equipment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `parent_equipment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `capacity_units` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `capacity_units` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `capacity_value` SET TAGS ('dbx_business_glossary_term' = 'Capacity Value');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `capacity_value` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `capacity_value` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `compliance_gmp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gmp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `equipment_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Kwh');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `equipment_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `install_date` SET TAGS ('dbx_business_glossary_term' = 'Install Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `installation_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `installation_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `maintenance_cost` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `maintenance_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency Days');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mtbf Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mttr Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `next_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `oee_actual` SET TAGS ('dbx_business_glossary_term' = 'Oee Actual');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `oee_target` SET TAGS ('dbx_business_glossary_term' = 'Oee Target');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating Kw');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `total_usage_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Usage Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `voltage` SET TAGS ('dbx_business_glossary_term' = 'Voltage');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`manufacturing`.`equipment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kg');
