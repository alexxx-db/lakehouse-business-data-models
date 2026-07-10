-- Schema for Domain: asset | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-10 20:15:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`asset` COMMENT 'Enterprise asset management domain owning the full lifecycle of physical infrastructure assets including WTP/WWTP equipment, pipes, pumps, valves, electrical systems, and vehicles. Manages asset registry, condition assessments, criticality ratings, preventive and corrective maintenance, work order management, depreciation schedules, and CAPEX/OPEX planning. Integrates with IBM Maximo CMMS and SAP PM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`registry` (
    `registry_id` BIGINT COMMENT 'Unique surrogate primary key for each physical infrastructure asset record in the enterprise asset registry. This is the authoritative SSOT identifier that IBM Maximo Asset Management and SAP Plant Maintenance (PM) equipment master synchronize against.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Registry stores asset classification as a free‑text field; linking to the asset_class taxonomy enables consistent classification and removes the redundant string column.',
    `facility_id` BIGINT COMMENT 'Reference to the facility or site where the asset is physically located (e.g., Water Treatment Plant, Wastewater Treatment Plant, pump station, reservoir). Links the asset to its parent facility for geographic and operational grouping in GIS and CMMS.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Registry currently has no explicit location reference; adding a foreign key to location allows assets to be tied to a physical site and supports location‑based reporting.',
    `parent_asset_registry_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent asset in the asset hierarchy (e.g., a pump impellers parent is the pump assembly; the pump assemblys parent is the pump station). Enables parent-child asset hierarchy navigation for maintenance cost roll-up and condition assessment aggregation. Null for top-level assets.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Meters and service line assets in the asset registry must be assigned to specific premises for billing reads, field service dispatch, and regulatory asset inventory (LCRR lead service line inventory r',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Every physical asset must be territory-scoped for SDWA regulatory reporting by jurisdiction, capital planning by service area, and operational dispatch. A water utility domain expert expects assets to',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase or construction cost of the asset in US dollars at the time of acquisition. Represents the capitalized cost basis used for depreciation calculations and fixed asset register reporting. Sourced from SAP FI/CO asset accounting module. Required for GASB Statement No. 34 infrastructure asset reporting.',
    `asset_category` STRING COMMENT 'Operational domain category indicating which business process area the asset belongs to (e.g., water_treatment for WTP equipment, wastewater_treatment for WWTP equipment, distribution for pipes and valves in the distribution network, collection for sewer infrastructure, metering for AMI/AMR devices). [ENUM-REF-CANDIDATE: water_treatment|wastewater_treatment|distribution|collection|metering|electrical|mechanical|civil|vehicle|instrumentation_control — 10 candidates stripped; promote to reference product]',
    `asset_name` STRING COMMENT 'Human-readable name or short description of the asset (e.g., Raw Water Pump No. 3, Influent Gate Valve 12-inch, Chlorine Contact Basin Filter 2). Used as the primary display label in CMMS, GIS, and reporting interfaces.',
    `asset_tag` STRING COMMENT 'Physical asset tag number (barcode, QR code, or RFID label) affixed to the asset in the field. Used by field technicians for asset identification during inspections, maintenance, and inventory audits. Corresponds to the Maximo asset tag field.',
    `asset_type` STRING COMMENT 'Sub-classification within the asset class providing more granular categorization (e.g., Centrifugal Pump, Gate Valve, Ductile Iron Pipe, AMI Smart Meter). Aligns with IBM Maximo asset type and SAP PM equipment category for maintenance planning and spare parts management.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the rated_capacity field. Common units include GPM (Gallons per Minute) for pumps, MGD (Million Gallons per Day) for treatment processes, gallons for storage tanks, kW for electrical equipment, and PSI (Pounds per Square Inch) for pressure vessels. [ENUM-REF-CANDIDATE: GPM|MGD|gallons|kW|kVA|HP|PSI|NTU|mg_L — 9 candidates stripped; promote to reference product]',
    `condition_assessment_date` DATE COMMENT 'Date of the most recent formal condition assessment performed on the asset. Used to determine assessment currency and schedule the next inspection cycle. Condition assessments may be visual inspections, CCTV surveys, vibration analysis, or other diagnostic methods.',
    `condition_grade` STRING COMMENT 'Standardized condition rating of the asset based on the most recent condition assessment, using a 1-5 scale where 1=Excellent/New, 2=Good, 3=Fair, 4=Poor, 5=Very Poor/Failed. Aligned with AWWA and WEF condition assessment frameworks. Drives maintenance prioritization and renewal planning.. Valid values are `1|2|3|4|5`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was first created in the enterprise asset registry. Provides audit trail for record provenance and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `criticality_rating` STRING COMMENT 'Risk-based criticality classification of the asset based on consequence of failure analysis (CoFA). critical assets have the highest consequence of failure impacting public health, regulatory compliance, or major service disruption. Used to prioritize maintenance resources, Capital Improvement Program (CIP) investments, and emergency response planning. Aligned with AWWA risk and resilience assessment methodology.. Valid values are `critical|high|medium|low`',
    `decommission_date` DATE COMMENT 'Date the asset was permanently decommissioned, retired, or removed from service. Null for active assets. Used for asset lifecycle reporting, fixed asset register reconciliation, and Capital Improvement Program (CIP) tracking. Triggers write-off in SAP FI/CO fixed asset module.',
    `diameter_mm` DECIMAL(18,2) COMMENT 'Nominal diameter of the asset in millimeters. For pipes and valves, this is the internal bore diameter. For pumps, this is the discharge diameter. Used for hydraulic capacity calculations, spare parts specification, and network modeling in Innovyze InfoWater.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the asset above mean sea level in meters. Critical for hydraulic modeling, pressure zone assignment, and gravity-fed system design. Used in Innovyze InfoWater hydraulic models and Esri ArcGIS 3D network analysis.',
    `expected_useful_life_years` STRING COMMENT 'The estimated total useful life of the asset in years as defined by engineering standards, manufacturer specifications, or utility policy. Used for depreciation calculations, Capital Improvement Program (CIP) planning, and asset renewal forecasting. Aligns with GASB Statement No. 34 infrastructure reporting requirements.',
    `functional_location` STRING COMMENT 'Hierarchical functional location code representing the physical or functional position of the asset within the utilitys infrastructure (e.g., WTP-PUMP-STATION-01-PUMP-03). Mirrors the SAP PM Functional Location (FLOC) structure and IBM Maximo Location field. Used for structured asset hierarchy navigation and maintenance cost allocation.',
    `gis_feature_code` STRING COMMENT 'The unique feature identifier for this asset in the Esri ArcGIS geographic information system. Enables spatial queries, network tracing, and hydraulic model integration via Innovyze InfoWater. Used for field crew navigation and infrastructure mapping.',
    `installation_date` DATE COMMENT 'Date the asset was physically installed and placed into service at its current location. Used as the baseline for age calculations, depreciation schedules, warranty period tracking, and remaining useful life (RUL) estimation. Sourced from IBM Maximo installation date field.',
    `is_lead_service_line` BOOLEAN COMMENT 'Indicates whether this asset is a lead service line or contains lead components. Critical for compliance with the EPA Lead and Copper Rule Revisions (LCRR) which requires utilities to inventory and replace lead service lines. True = confirmed lead service line; False = non-lead or unknown.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recently completed maintenance activity (preventive or corrective) performed on this asset. Used to calculate maintenance intervals, identify overdue assets, and support compliance reporting for regulatory-mandated maintenance activities.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset record in the enterprise asset registry. Used for change tracking, data synchronization with IBM Maximo and SAP PM, and audit trail maintenance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the asset location in decimal degrees (WGS84 datum). Used for GIS mapping, field crew navigation, spatial analysis, and hydraulic network modeling in Innovyze InfoWater. Sourced from Esri ArcGIS asset layer.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the asset location in decimal degrees (WGS84 datum). Used for GIS mapping, field crew navigation, spatial analysis, and hydraulic network modeling in Innovyze InfoWater. Sourced from Esri ArcGIS asset layer.',
    `maintenance_strategy` STRING COMMENT 'The primary maintenance approach applied to this asset as defined in the Computerized Maintenance Management System (CMMS). preventive indicates time-based scheduled maintenance; predictive indicates condition-monitoring-based maintenance; condition_based indicates maintenance triggered by condition thresholds; run_to_failure is applied to non-critical, easily replaceable assets.. Valid values are `preventive|predictive|corrective|run_to_failure|condition_based`',
    `manufacture_date` DATE COMMENT 'Date the asset was manufactured by the OEM. May differ from installation date for assets stored in inventory before deployment. Used for age-based condition assessment and manufacturer warranty calculations.',
    `manufacturer` STRING COMMENT 'Name of the original equipment manufacturer (OEM) of the asset (e.g., Xylem, Grundfos, Flowserve, Siemens, ABB). Used for warranty management, spare parts procurement, and vendor performance analysis. Sourced from IBM Maximo manufacturer field.',
    `maximo_asset_num` STRING COMMENT 'The asset number as assigned and maintained in IBM Maximo Asset Management (CMMS). This is the operational cross-reference key used by maintenance crews and work order management. Must be unique within the Maximo instance.',
    `model_num` STRING COMMENT 'Manufacturers model or product number for the asset (e.g., LF 3196 STX, NK 65-200). Used for spare parts identification, technical documentation retrieval, and procurement of replacement units. Sourced from IBM Maximo model field.',
    `next_maintenance_date` DATE COMMENT 'Date on which the next scheduled preventive maintenance activity is due for this asset. Derived from the PM schedule and last maintenance date. Used for maintenance planning, resource scheduling, and compliance tracking in IBM Maximo.',
    `operational_status` STRING COMMENT 'Current operational lifecycle state of the asset. in_service indicates the asset is active and performing its intended function. standby indicates the asset is available but not currently operating. out_of_service indicates the asset is temporarily removed from service for maintenance or repair. decommissioned indicates permanent retirement. Drives maintenance scheduling and regulatory reporting.. Valid values are `in_service|out_of_service|standby|decommissioned|under_construction|abandoned`',
    `pipe_material` STRING COMMENT 'Material composition of the asset (e.g., Ductile Iron, PVC, HDPE, Cast Iron, Concrete, Stainless Steel, Copper). Critical for corrosion risk assessment, Lead and Copper Rule Revisions (LCRR) compliance, Cured-in-Place Pipe (CIPP) rehabilitation planning, and remaining useful life estimation. Applicable primarily to pipe and fitting assets.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Nameplate power rating of the asset in kilowatts (kW). Applicable to pumps, blowers, motors, generators, and other electrical equipment. Used for energy consumption analysis, Variable Frequency Drive (VFD) sizing, electrical load planning, and OPEX budgeting.',
    `pressure_zone` STRING COMMENT 'The hydraulic pressure zone or District Metered Area (DMA) in which the asset is located. Used for pressure management, Non-Revenue Water (NRW) analysis, and distribution network operations. Aligns with Innovyze InfoWater zone definitions and GIS pressure zone polygons.',
    `rated_capacity` DECIMAL(18,2) COMMENT 'The manufacturer-rated operational capacity of the asset expressed in the appropriate unit of measure (see capacity_unit field). For pumps: Gallons per Minute (GPM); for treatment units: Million Gallons per Day (MGD); for tanks: gallons. Used for capacity planning, hydraulic modeling, and performance benchmarking.',
    `regulatory_asset_code` STRING COMMENT 'Asset identifier assigned by a regulatory authority (e.g., state drinking water program, EPA) for compliance tracking and reporting purposes. Used in regulatory submissions such as the Consumer Confidence Report (CCR), Discharge Monitoring Report (DMR), and NPDES permit compliance documentation.',
    `replacement_cost` DECIMAL(18,2) COMMENT 'Current estimated cost to replace the asset with a new equivalent unit in US dollars. Updated periodically based on market pricing and engineering estimates. Used for Capital Improvement Program (CIP) budgeting, insurance valuation, and risk-based asset management decision-making.',
    `sap_equipment_num` STRING COMMENT 'The equipment number assigned in SAP Plant Maintenance (PM) module. Used for integration with SAP FI/CO for depreciation, CAPEX/OPEX tracking, and maintenance cost postings. Enables bidirectional synchronization between SAP PM and the asset registry.',
    `scada_tag` STRING COMMENT 'The Supervisory Control and Data Acquisition (SCADA) tag name used to identify this assets data point(s) in the OSIsoft PI Historian system. Enables linkage between the physical asset registry and real-time operational data streams for performance monitoring, alarm management, and predictive maintenance analytics.',
    `serial_num` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific asset unit. Used for warranty claims, recall tracking, and precise asset identification when multiple identical units exist. Sourced from IBM Maximo serial number field.',
    `warranty_expiry_date` DATE COMMENT 'Date on which the manufacturers warranty for the asset expires. Used to trigger warranty claim processes before expiry and to transition maintenance responsibility from warranty to O&M budget. Sourced from IBM Maximo warranty end date.',
    CONSTRAINT pk_registry PRIMARY KEY(`registry_id`)
) COMMENT 'Master record for every physical infrastructure asset owned or operated by the utility, including WTP/WWTP equipment, pipes, pumps, valves, electrical systems, meters, and vehicles. Captures asset identity, classification, installation details, location (GIS coordinates), manufacturer, model, serial number, asset tag, parent-child hierarchy, operational status, and lifecycle dates. This is the authoritative SSOT for all physical assets — the IBM Maximo asset master and SAP PM equipment master both synchronize to this record.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` (
    `asset_class_id` BIGINT COMMENT 'Unique surrogate identifier for the asset class record in the enterprise asset management system. Primary key for the asset_class reference taxonomy. [ROLE: REFERENCE_LOOKUP — this entity is a reference taxonomy/classification table defining the hierarchy of utility asset types; per-role minimums are exempt, but MASTER_RESOURCE categories are applied for completeness given the entity carries rich business metadata beyond a simple code list.]',
    `ami_applicable` BOOLEAN COMMENT 'Indicates whether assets of this class are part of the AMI/AMR metering infrastructure managed via the Sensus FlexNet AMI Platform. True for smart meters and communication endpoints; False for all other asset classes.',
    `asset_domain` STRING COMMENT 'Operational domain to which this asset class primarily belongs within the utility (e.g., Water Treatment, Water Distribution, Wastewater Collection, Wastewater Treatment, Metering, Fleet, Facilities, Cross-Domain). Drives domain-specific maintenance strategies and regulatory reporting alignment. [ENUM-REF-CANDIDATE: Water Treatment|Water Distribution|Wastewater Collection|Wastewater Treatment|Metering|Fleet|Facilities|Cross-Domain — promote to reference product]',
    `capex_threshold_usd` DECIMAL(18,2) COMMENT 'Minimum acquisition or renewal cost in USD above which expenditures on assets of this class are capitalized as CAPEX rather than expensed as OPEX. Aligned with GAAP/GASB capitalization policies and SAP FI/CO asset accounting rules.',
    `cip_program_category` STRING COMMENT 'CIP program category under which capital renewal projects for assets of this class are budgeted and tracked. Aligns with the utilitys multi-year CIP planning structure in SAP PS and financial reporting to the Public Utilities Commission. [ENUM-REF-CANDIDATE: Water Supply|Water Treatment|Water Distribution|Wastewater Collection|Wastewater Treatment|Metering|Facilities|Fleet|Cross-Program — promote to reference product]',
    `class_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the asset class within the enterprise taxonomy (e.g., MECH-PUMP, ELEC-TRANS, CIVIL-PIPE). Used as the externally-known business identifier in IBM Maximo, SAP PM, and GIS integrations.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `class_description` STRING COMMENT 'Detailed narrative description of the asset class, including its functional role within water or wastewater operations, typical installation context, and distinguishing characteristics from adjacent classes.',
    `class_name` STRING COMMENT 'Human-readable name of the asset class (e.g., Centrifugal Pump, Distribution Main Pipe, UV Disinfection Unit). Used in reports, work orders, and CAPEX planning documents.',
    `class_status` STRING COMMENT 'Current lifecycle status of the asset class record within the reference taxonomy. Active classes are available for new asset registrations; Deprecated classes are retained for historical assets but cannot be assigned to new assets.. Valid values are `Active|Inactive|Deprecated|Under Review`',
    `condition_assessment_method` STRING COMMENT 'Default method used to assess the physical condition of assets in this class. CIPP and pipe assets typically use CCTV; rotating equipment uses vibration analysis; distribution mains may use acoustic leak detection. Drives field inspection work order types in Maximo. [ENUM-REF-CANDIDATE: Visual Inspection|CCTV|Acoustic Leak Detection|Vibration Analysis|Ultrasonic Testing|Hydraulic Testing|SCADA Monitoring|Not Applicable — promote to reference product]',
    `consequence_of_failure` STRING COMMENT 'Primary category of consequence if assets of this class fail. Drives risk-based maintenance prioritization and emergency response planning. [ENUM-REF-CANDIDATE: Service Interruption|Public Health Risk|Environmental Non-Compliance|Safety Hazard|Financial Loss|Reputational — promote to reference product]. Valid values are `Service Interruption|Public Health Risk|Environmental Non-Compliance|Safety Hazard|Financial Loss|Reputational`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset class record was first created in the enterprise data platform. Supports audit trail and data lineage requirements.',
    `criticality_tier` STRING COMMENT 'Default criticality tier classification for assets of this class based on consequence of failure analysis. Critical assets (e.g., primary WTP pumps, transmission mains) receive highest maintenance priority and fastest response SLAs.. Valid values are `Critical|High|Medium|Low`',
    `criticality_weight` DECIMAL(18,2) COMMENT 'Numeric weighting factor (typically 0.00–10.00) applied to assets of this class during criticality assessment scoring. Higher values indicate greater consequence of failure on service delivery, public health, or regulatory compliance. Used in risk-based asset prioritization per ISO 55001.',
    `depreciation_method` STRING COMMENT 'Default accounting depreciation method applied to assets of this class for financial reporting purposes. Straight-Line is most common for utility infrastructure. Aligned with GAAP/GASB requirements for municipal utility financial statements. [ENUM-REF-CANDIDATE: Straight-Line|Declining Balance|Units of Production|Sum-of-Years-Digits|Modified Accelerated Cost Recovery — promote to reference product]. Valid values are `Straight-Line|Declining Balance|Units of Production|Sum-of-Years-Digits|Modified Accelerated Cost Recovery`',
    `effective_date` DATE COMMENT 'Date from which this asset class definition became effective and available for use in asset registrations. Supports temporal validity tracking of the reference taxonomy.',
    `environmental_risk_flag` BOOLEAN COMMENT 'Indicates whether failure of assets in this class poses a direct environmental risk requiring regulatory notification (e.g., SSO, CSO, chemical spill, NPDES permit exceedance). True triggers mandatory environmental incident reporting workflows.',
    `gis_feature_class` STRING COMMENT 'Corresponding feature class name in Esri ArcGIS geodatabase for assets of this class (e.g., wDistributionMain, wValve, wPump). Enables spatial analysis, network modeling in Innovyze InfoWater, and GIS-CMMS integration for field crew dispatch.',
    `gl_account_code` STRING COMMENT 'Default General Ledger account code in SAP FI/CO to which asset acquisitions, depreciation, and disposals for this class are posted. Ensures consistent financial reporting and CAPEX/OPEX tracking across the utility.. Valid values are `^[0-9]{6,10}$`',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this class within the classification hierarchy (1 = top-level category, 2 = sub-category, 3 = class, 4 = sub-class). Drives roll-up aggregation logic in CAPEX planning and maintenance reporting.',
    `inspection_frequency_days` STRING COMMENT 'Default interval in calendar days between mandatory regulatory or condition inspections for assets of this class. Distinct from PM frequency — this is driven by regulatory compliance requirements (e.g., EPA, state primacy agency mandates) rather than maintenance strategy.',
    `iso_55001_aligned` BOOLEAN COMMENT 'Indicates whether the maintenance strategy, criticality assessment, and lifecycle management approach for this asset class have been formally aligned with ISO 55001 Asset Management System requirements. Used for ISO certification audit evidence.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset class record was most recently modified in the enterprise data platform. Used for change tracking, data synchronization with source systems (Maximo, SAP), and audit compliance.',
    `lcrr_applicable` BOOLEAN COMMENT 'Indicates whether assets of this class are subject to EPA Lead and Copper Rule Revisions (LCRR) compliance requirements, such as lead service line inventory and replacement tracking. Applicable to service lines, connectors, and plumbing components.',
    `maintenance_strategy` STRING COMMENT 'Default O&M maintenance strategy applied to assets of this class in IBM Maximo CMMS. Drives automatic PM schedule generation. Preventive and Condition-Based strategies are typical for critical water infrastructure; Run-to-Failure may apply to low-criticality ancillary assets.. Valid values are `Preventive|Predictive|Corrective|Condition-Based|Run-to-Failure`',
    `material_standard` STRING COMMENT 'Default material specification or construction standard applicable to assets of this class (e.g., AWWA C900 PVC, AWWA C200 Steel, ASTM A536 Ductile Iron, HDPE ASTM D3035). Used in procurement specifications and asset registry for infrastructure renewal planning.',
    `maximo_class_code` STRING COMMENT 'Corresponding asset class identifier in IBM Maximo Asset Management CMMS. Used for bidirectional synchronization between the Silver Layer lakehouse and Maximo for work order generation, PM scheduling, and asset lifecycle management.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `mean_time_between_failures_days` DECIMAL(18,2) COMMENT 'Industry benchmark mean time between failures in days for assets of this class, used as a baseline for reliability-centered maintenance planning and failure probability modeling. Sourced from AWWA reliability benchmarks and historical Maximo work order data.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Industry benchmark mean time to repair in hours for assets of this class, used for SLA setting, crew resource planning, and service restoration time estimation. Sourced from AWWA benchmarks and historical Maximo corrective work order durations.',
    `number_sap` STRING COMMENT 'Corresponding asset class number in SAP FI/CO Asset Accounting module (transaction AS02/AS03). Enables direct cross-reference between the enterprise data lakehouse and the SAP ERP system of record for financial reconciliation.. Valid values are `^[0-9]{4,8}$`',
    `pm_frequency_days` STRING COMMENT 'Default interval in calendar days between scheduled preventive maintenance activities for assets of this class. Used by IBM Maximo PM scheduling engine to auto-generate work orders. Overridable at the individual asset level.',
    `primary_category` STRING COMMENT 'Top-level classification grouping for the asset class aligned with standard utility asset taxonomy: Mechanical (pumps, blowers, mixers), Electrical (transformers, switchgear), Civil (pipes, structures, tanks), Instrumentation (sensors, meters, SCADA RTUs), Vehicle (fleet), Information Technology, or Other. [ENUM-REF-CANDIDATE: Mechanical|Electrical|Civil|Instrumentation|Vehicle|Information Technology|Other — promote to reference product]',
    `renewal_strategy` STRING COMMENT 'Default end-of-life renewal strategy for assets of this class used in CIP planning. CIPP (Cured-in-Place Pipe) and trenchless methods are common for buried pipe rehabilitation; rotating equipment typically follows Replace-in-Kind or Upgrade strategies.. Valid values are `Replace-in-Kind|Upgrade|Rehabilitation|CIPP|Trenchless|Decommission`',
    `retirement_date` DATE COMMENT 'Date on which this asset class was retired or deprecated from the active taxonomy. Null for currently active classes. Retained for historical asset records that were registered under this class prior to retirement.',
    `safety_classification` STRING COMMENT 'Primary safety hazard classification for work activities on assets of this class. Drives OSHA-compliant safety permit requirements (e.g., confined space entry permits, lockout/tagout procedures) when generating work orders in Maximo.. Valid values are `Confined Space|Electrical Hazard|Chemical Hazard|High Pressure|Radiation|None`',
    `salvage_value_pct` DECIMAL(18,2) COMMENT 'Default residual/salvage value expressed as a percentage of original acquisition cost at end of useful life for assets in this class. Used in depreciation calculations and asset disposal planning within SAP FI/CO.',
    `scada_monitored` BOOLEAN COMMENT 'Indicates whether assets of this class are typically monitored via SCADA (Supervisory Control and Data Acquisition) systems integrated with OSIsoft PI Historian. True for pumps, valves, flow meters, and treatment equipment; False for passive civil assets such as buried pipes.',
    `size_unit_of_measure` STRING COMMENT 'Standard unit of measure used to express the principal sizing attribute for assets of this class (e.g., inches for pipe diameter, HP for pump motor horsepower, kVA for transformer capacity, GPM for flow capacity). Ensures consistent sizing data entry across the asset registry. [ENUM-REF-CANDIDATE: inches|mm|feet|meters|kVA|HP|kW|GPM|MGD|gallons|cubic feet — promote to reference product]',
    `spare_parts_required` BOOLEAN COMMENT 'Indicates whether assets of this class typically require dedicated spare parts inventory to be maintained in the storeroom (SAP MM / Maximo Inventory). True for critical rotating equipment and instrumentation; False for passive civil assets.',
    `useful_life_years` STRING COMMENT 'Default expected useful life in years for assets belonging to this class, used as the baseline for depreciation schedules, CAPEX renewal planning, and CIP prioritization. Can be overridden at the individual asset level.',
    `work_order_type_default` STRING COMMENT 'Default work order type generated in IBM Maximo for assets of this class when a maintenance event is triggered. Drives labor planning, cost coding, and CAPEX vs OPEX classification of maintenance expenditures.. Valid values are `Preventive Maintenance|Corrective Maintenance|Inspection|Emergency Repair|Capital Renewal|Rehabilitation`',
    CONSTRAINT pk_asset_class PRIMARY KEY(`asset_class_id`)
) COMMENT 'Reference taxonomy defining the classification hierarchy for utility assets (e.g., Mechanical, Electrical, Civil, Instrumentation, Vehicle). Each class carries default useful life, depreciation method, maintenance strategy, criticality weighting rules, and applicable regulatory standards. Used to drive preventive maintenance scheduling, CAPEX planning, and ISO 55001 asset management framework alignment.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`location` (
    `location_id` BIGINT COMMENT 'Unique identifier for the asset location record. Primary key.',
    `facility_id` BIGINT COMMENT 'Reference to the top-level facility (WTP, WWTP, pump station) where this location resides.',
    `parent_location_id` BIGINT COMMENT 'Reference to the parent location in the hierarchical location structure (e.g., a rooms parent is a floor, a floors parent is a building).',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Physical locations (sites, pressure zones, facility areas) must be mapped to service territories for regulatory jurisdiction assignment, emergency response routing, and operational area management. A ',
    `access_restrictions` STRING COMMENT 'Description of physical or security access restrictions for the location (e.g., Restricted - Badge Required, Public Access, Confined Space).',
    `address_line_1` STRING COMMENT 'Primary street address of the location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address information (suite, unit, building number). Organizational contact data classified as confidential.',
    `area_square_feet` DECIMAL(18,2) COMMENT 'Physical area of the location in square feet, used for space planning and asset density analysis.',
    `capacity_rating` DECIMAL(18,2) COMMENT 'Rated capacity of the location for asset storage or operational throughput (e.g., MGD for treatment facilities, gallons for storage tanks).',
    `capacity_unit` STRING COMMENT 'Unit of measure for the capacity rating (e.g., Million Gallons per Day (MGD), Gallons per Minute (GPM), gallons, cubic meters).. Valid values are `mgd|gpm|gallons|cubic_meters|units`',
    `city` STRING COMMENT 'City or municipality where the location is situated.',
    `location_code` STRING COMMENT 'Business identifier code for the location, used for operational reference and integration with IBM Maximo CMMS and SAP PM systems.. Valid values are `^[A-Z0-9]{4,20}$`',
    `country_code` STRING COMMENT 'Three-letter ISO country code (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created in the system.',
    `location_description` STRING COMMENT 'Detailed description of the location, including physical characteristics, purpose, and operational context.',
    `dma_zone` STRING COMMENT 'District Metered Area zone identifier for water distribution network segmentation and Non-Revenue Water (NRW) analysis.',
    `effective_end_date` DATE COMMENT 'Date when the location was decommissioned or removed from active service (null for active locations).',
    `effective_start_date` DATE COMMENT 'Date when the location became operational or was added to the asset registry.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation above sea level in feet, used for hydraulic modeling and pressure zone analysis.',
    `environmental_conditions` STRING COMMENT 'Description of environmental conditions at the location (e.g., Indoor Climate Controlled, Outdoor Exposed, Wet Environment, Corrosive Atmosphere).',
    `floor_level` STRING COMMENT 'Floor or level number within a building (e.g., 1 for ground floor, 2 for second floor, -1 for basement).',
    `gis_feature_code` STRING COMMENT 'Unique feature identifier in the Esri ArcGIS system for spatial data integration and network topology analysis.',
    `hazard_classification` STRING COMMENT 'Safety hazard classification for the location (e.g., Confined Space, High Voltage, Chemical Storage, None).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was last updated or modified.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees for GIS integration with Esri ArcGIS.',
    `location_status` STRING COMMENT 'Current operational status of the location in its lifecycle.. Valid values are `active|inactive|under_construction|decommissioned|temporary`',
    `location_type` STRING COMMENT 'Classification of the location type within the asset hierarchy.. Valid values are `facility|building|floor|room|outdoor_site|storage_yard`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees for GIS integration with Esri ArcGIS.',
    `maximo_location_code` STRING COMMENT 'Location identifier in IBM Maximo CMMS for work order management and maintenance routing integration.',
    `location_name` STRING COMMENT 'Human-readable name of the asset location (e.g., Main Street Pump Station, North WTP Filter Building).',
    `notes` STRING COMMENT 'Additional notes or comments about the location for operational reference and maintenance planning.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the location. Organizational contact data classified as confidential.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `pressure_zone` STRING COMMENT 'Pressure zone designation for hydraulic modeling and distribution network operations, typically defined by elevation and Pressure Reducing Valve (PRV) boundaries.',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory jurisdiction or primacy agency responsible for oversight (e.g., state EPA, local health department).',
    `room_number` STRING COMMENT 'Room or space identifier within a floor or building (e.g., Room 101, Electrical Vault A).',
    `sap_functional_location` STRING COMMENT 'SAP PM functional location code for asset hierarchy and maintenance planning integration.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether the location is integrated with SCADA systems (OSIsoft PI Historian) for real-time monitoring and control.',
    `service_territory` STRING COMMENT 'Service territory or jurisdiction code defining the geographic area served by the utility.',
    `spatial_reference_code` STRING COMMENT 'Coordinate system reference identifier (EPSG code) used for GIS spatial data (e.g., EPSG:4326 for WGS 84).',
    `state_province` STRING COMMENT 'Two-letter state or province code (e.g., CA, TX, NY).. Valid values are `^[A-Z]{2}$`',
    `watershed` STRING COMMENT 'Watershed or drainage basin identifier for regulatory reporting and environmental compliance under the Clean Water Act (CWA).',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Hierarchical location registry defining where assets are physically installed or stored — from service territory down to facility, building, floor, room, and GIS coordinate. Supports Esri ArcGIS integration with spatial reference data (latitude, longitude, elevation, DMA zone, pressure zone, watershed). Enables location-based maintenance routing, network topology analysis, and regulatory reporting by geographic jurisdiction.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` (
    `condition_assessment_id` BIGINT COMMENT 'Unique identifier for the condition assessment record. Primary key.',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: Condition assessments for pipes, coatings, and linings often reference supporting lab analysis results (corrosion testing, material integrity tests). Real business need: linking physical asset conditi',
    `location_id` BIGINT COMMENT 'Reference to the asset location in the Geographic Information System (GIS), enabling spatial analysis and mapping of condition assessment results.',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: A condition assessment is the formal output produced by an inspection event. The inspection_event captures the operational execution (who inspected, when, what checklist was used), while condition_ass',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Condition assessments are mandated by specific regulations (LCRR lead service line inspections, AWIA risk assessments, state storage tank rules). condition_assessment has compliance_standard and regul',
    `work_order_id` BIGINT COMMENT 'Reference to the work order under which this condition assessment was performed, if applicable.',
    `approved_date` DATE COMMENT 'Date when the assessment was formally approved by management.',
    `assessment_date` DATE COMMENT 'The date on which the condition assessment was performed in the field.',
    `assessment_interval_months` STRING COMMENT 'Standard inspection frequency interval in months for this asset type and condition grade.',
    `assessment_method` STRING COMMENT 'The inspection or testing method used to assess asset condition. Common methods include visual inspection, Closed-Circuit Television (CCTV) for pipes, acoustic leak detection, vibration analysis for rotating equipment, ultrasonic thickness measurement for corrosion, infrared thermography for electrical systems, and various hydraulic testing methods. [ENUM-REF-CANDIDATE: visual|cctv|acoustic|vibration_analysis|ultrasonic_thickness|infrared_thermography|dye_testing|smoke_testing|pressure_testing|flow_testing|electrical_testing|corrosion_survey — 12 candidates stripped; promote to reference product]',
    `assessment_number` STRING COMMENT 'Business identifier for the condition assessment, typically generated by the Computerized Maintenance Management System (CMMS) or inspection system.',
    `assessment_status` STRING COMMENT 'Current workflow status of the condition assessment record: scheduled, in progress, completed (field work done), reviewed (technical review complete), approved (management sign-off), or cancelled.. Valid values are `scheduled|in_progress|completed|reviewed|approved|cancelled`',
    `assessment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the condition assessment was completed, including time zone information.',
    `assessment_type` STRING COMMENT 'Classification of the assessment purpose: routine scheduled inspection, preventive maintenance assessment, reactive inspection following an incident, condition-based monitoring, regulatory compliance inspection, pre-failure investigation, post-repair verification, or new asset commissioning. [ENUM-REF-CANDIDATE: routine|preventive|reactive|condition_based|regulatory|pre_failure|post_repair|commissioning — 8 candidates stripped; promote to reference product]',
    `compliance_standard` STRING COMMENT 'Specific regulatory standard, code, or requirement that this assessment addresses (e.g., SDWA Section 1433, AWWA C651, NFPA 25).',
    `condition_grade` STRING COMMENT 'Standardized condition rating on a 1-5 scale per American Water Works Association (AWWA) and Water Research Foundation (WRF) standards, where 1 = Excellent/New, 2 = Good/Minor Defects, 3 = Fair/Moderate Defects, 4 = Poor/Significant Defects, 5 = Very Poor/Critical/Imminent Failure.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this condition assessment record was first created in the Computerized Maintenance Management System (CMMS).',
    `critical_defect_count` STRING COMMENT 'Number of critical or high-severity defects requiring immediate attention or corrective action.',
    `criticality_rating` STRING COMMENT 'Business criticality classification of the asset based on consequence of failure analysis, considering service impact, public health risk, environmental impact, and financial exposure.. Valid values are `critical|high|medium|low`',
    `defect_count` STRING COMMENT 'Total number of defects, anomalies, or non-conformances identified during the condition assessment.',
    `defect_description` STRING COMMENT 'Detailed narrative description of defects, damage, deterioration, or performance issues observed during the assessment.',
    `environmental_conditions` STRING COMMENT 'Environmental factors that may affect assessment results or asset condition (e.g., soil conditions, groundwater level, chemical exposure, temperature extremes).',
    `estimated_repair_cost` DECIMAL(18,2) COMMENT 'Preliminary cost estimate for recommended repair or rehabilitation work, used for Capital Expenditure (CAPEX) and Operating Expenditure (OPEX) planning.',
    `estimated_replacement_cost` DECIMAL(18,2) COMMENT 'Estimated cost to fully replace the asset with equivalent new equipment or infrastructure.',
    `failure_probability` DECIMAL(18,2) COMMENT 'Statistical probability (0.0000 to 1.0000) of asset failure within the next planning period, calculated from condition data, age, and historical failure rates.',
    `inspection_equipment_used` STRING COMMENT 'Description of specialized equipment, instruments, or tools used during the assessment (e.g., CCTV crawler, ultrasonic thickness gauge, vibration analyzer, acoustic leak detector).',
    `inspector_certification` STRING COMMENT 'Professional certifications held by the inspector relevant to the assessment method (e.g., NASSCO PACP/MACP/LACP for pipeline inspection, ASNT Level II for ultrasonic testing, thermography certification).',
    `inspector_name` STRING COMMENT 'Full name of the inspector or technician who conducted the assessment.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the assessment location.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the assessment location.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this condition assessment record was last updated.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next condition assessment based on asset criticality, condition grade, and inspection frequency requirements.',
    `notes` STRING COMMENT 'Additional observations, comments, or contextual information recorded by the inspector during the assessment.',
    `performance_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100 scale) representing the operational performance and efficiency of the asset relative to design specifications.',
    `recommended_action` STRING COMMENT 'Recommended intervention strategy based on assessment findings: continue monitoring, schedule repair, plan rehabilitation, schedule replacement, no action required, or emergency repair needed.. Valid values are `monitor|repair|rehabilitate|replace|no_action|emergency_repair`',
    `recommended_action_priority` STRING COMMENT 'Priority level for the recommended intervention: immediate (0-30 days), urgent (1-6 months), high (6-12 months), medium (1-3 years), low (3+ years).. Valid values are `immediate|urgent|high|medium|low`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this assessment was performed to satisfy regulatory inspection requirements from Environmental Protection Agency (EPA), state primacy agencies, or other governing bodies.',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Estimated number of years the asset can continue to operate before requiring major rehabilitation or replacement, based on current condition and deterioration rate.',
    `reviewed_date` DATE COMMENT 'Date when the assessment was reviewed and validated by a supervisor or subject matter expert.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score calculated as the product of failure probability and consequence of failure, used to prioritize asset renewal and Capital Improvement Program (CIP) planning.',
    `structural_integrity_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100 scale) representing the structural soundness of the asset based on inspection findings. Higher scores indicate better structural condition.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of assessment, relevant for outdoor inspections and certain testing methods.',
    CONSTRAINT pk_condition_assessment PRIMARY KEY(`condition_assessment_id`)
) COMMENT 'Records the results of all formal assessments and inspections performed on infrastructure assets, encompassing both scored condition evaluations (condition grade 1-5 per AWWA/WRF standards, structural integrity score, remaining useful life estimate, failure probability) and regulatory/compliance inspections (EPA, state primacy agency, OSHA requirements). Captures assessment date, type (condition-scoring, regulatory-compliance, routine-operational, post-incident, pre-commissioning), method (visual, CCTV, acoustic, vibration analysis, ultrasonic thickness, leak detection), inspector identity and certification, checklist/protocol used, pass/fail outcome, deficiencies identified, corrective action required flag, recommended intervention, and regulatory permit reference. A single unified record for any event where an asset is formally evaluated — whether for condition scoring, compliance verification, or operational readiness. Drives asset renewal prioritization, CIP planning, regulatory inspection compliance tracking, and OSHA safety audit evidence. Integrates with IBM Maximo inspection records and supports EPA/state primacy agency reporting requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` (
    `criticality_rating_id` BIGINT COMMENT 'Unique identifier for the criticality rating record. Primary key for the criticality rating entity.',
    `approval_date` DATE COMMENT 'Date when this criticality rating was formally approved for operational use. Supports audit trail and governance compliance.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role that approved this criticality rating for operational use. Supports governance and accountability for asset management decisions.',
    `assessment_date` DATE COMMENT 'The date when the criticality assessment was performed. Distinct from the effective date; tracks when the analysis was conducted.',
    `assessment_performed_by` STRING COMMENT 'Name or identifier of the person, team, or system that performed the criticality assessment. Supports audit trail and accountability for rating decisions.',
    `capital_renewal_priority_rank` STRING COMMENT 'Relative priority ranking for capital renewal or replacement within the asset portfolio. Lower numbers indicate higher priority. Derived from criticality tier and overall risk score.',
    `cip_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this asset is eligible for inclusion in the Capital Improvement Program based on its criticality rating and condition. True if eligible for CIP funding consideration.',
    `consequence_of_failure_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the business, operational, safety, environmental, and regulatory impact if the asset fails. Typically scaled 1-100 or 1-10 depending on methodology.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this criticality rating record was first created in the system. Supports data lineage and audit trail requirements.',
    `criticality_tier` STRING COMMENT 'Categorical classification of asset criticality derived from the overall risk score. Determines maintenance frequency, inspection intervals, and capital renewal priority.. Valid values are `Critical|High|Medium|Low`',
    `customer_impact_count` STRING COMMENT 'Estimated number of customers or service connections that would be affected by failure of this asset. Used to quantify consequence of failure for distribution and collection system assets.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether failure of this asset would result in environmental harm such as discharge of untreated wastewater, contamination of water sources, or SSO/CSO events. True if environmental impact is likely.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial consequence of asset failure including emergency repair costs, lost revenue, regulatory fines, and liability claims. Expressed in USD.',
    `inspection_frequency_days` STRING COMMENT 'Recommended interval in days between routine inspections based on the criticality tier. Critical assets require more frequent inspection than low-criticality assets.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this criticality rating record was last updated. Supports change tracking and audit trail requirements.',
    `likelihood_of_failure_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the probability of asset failure based on age, condition, maintenance history, and operating environment. Typically scaled 1-100 or 1-10 depending on methodology.',
    `methodology_version` STRING COMMENT 'Version identifier of the criticality assessment methodology used to calculate this rating. Enables tracking of methodology changes over time and ensures consistent application across asset portfolio.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next criticality reassessment. Critical assets typically require more frequent review cycles than low-criticality assets.',
    `notes` STRING COMMENT 'Free-text notes documenting special considerations, assumptions, or qualitative factors that influenced the criticality rating. Supports transparency and knowledge transfer.',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'Composite risk score calculated from Consequence of Failure and Likelihood of Failure scores. Typically computed as CoF × LoF. Used to rank assets for maintenance and capital investment prioritization.',
    `preventive_maintenance_frequency_days` STRING COMMENT 'Recommended interval in days between preventive maintenance activities based on the criticality tier. Critical assets require more frequent PM than low-criticality assets.',
    `public_health_impact_flag` BOOLEAN COMMENT 'Indicates whether failure of this asset would pose a direct threat to public health through loss of water supply, water quality degradation, or exposure to contaminants. True if public health risk exists.',
    `rating_effective_date` DATE COMMENT 'The date from which this criticality rating becomes effective and is used for maintenance prioritization and capital planning decisions.',
    `rating_expiration_date` DATE COMMENT 'The date when this criticality rating expires and must be reassessed. Nullable for ratings without a defined review cycle.',
    `rating_status` STRING COMMENT 'Current lifecycle status of the criticality rating record. Active ratings are used for operational decisions; superseded ratings are retained for historical analysis.. Valid values are `Active|Superseded|Under Review|Pending Approval`',
    `redundancy_available_flag` BOOLEAN COMMENT 'Indicates whether backup or redundant assets are available to maintain service if this asset fails. True if redundancy exists, False if asset is a single point of failure.',
    `regulatory_consequence_flag` BOOLEAN COMMENT 'Indicates whether failure of this asset would result in regulatory non-compliance, permit violations, or mandatory reporting under SDWA, CWA, or NPDES. True if regulatory consequences exist.',
    `review_frequency_months` STRING COMMENT 'Standard interval in months between criticality reassessments for this asset. Typically shorter for critical assets and longer for low-criticality assets.',
    `safety_impact_flag` BOOLEAN COMMENT 'Indicates whether failure of this asset would create safety hazards for employees, contractors, or the public (e.g., chemical release, electrical hazard, structural collapse). True if safety risk exists.',
    `service_disruption_duration_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that service would be disrupted if this asset fails, accounting for repair time, parts availability, and system restoration procedures.',
    CONSTRAINT pk_criticality_rating PRIMARY KEY(`criticality_rating_id`)
) COMMENT 'Stores the criticality evaluation for each asset, capturing consequence of failure (CoF) score, likelihood of failure (LoF) score, overall risk score, criticality tier (Critical/High/Medium/Low), redundancy availability, customer impact count, regulatory consequence flag, and the methodology version used. Criticality ratings drive maintenance prioritization, inspection frequency, and capital renewal sequencing per ISO 55001 and AWWA asset management best practices.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the work order record. Primary key.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.job_plan. Business justification: Work orders frequently execute standardized job plans that define task sequences, labor requirements, materials, and safety procedures. This is a standard CMMS pattern (IBM Maximo, SAP PM). Job plan p',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Work orders performed for specific customer accounts (service calls, meter work, customer-requested repairs) require account linkage. Required for customer work history tracking, account-specific main',
    `location_id` BIGINT COMMENT 'Reference to the functional location or site where the work is performed (Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), pump station, District Metered Area (DMA)).',
    `pm_schedule_id` BIGINT COMMENT 'Reference to the preventive maintenance schedule or route that generated this work order, if applicable.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Work orders require service address for crew dispatch, customer contact, access instructions, and completion documentation. Essential for field operations, customer communication, and GIS-based work o',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Field service work orders for turn-on/off, meter replacement, and service restoration are executed against specific service agreements. Field crews and dispatch systems need the service agreement refe',
    `territory_id` BIGINT COMMENT 'Reference to the maintenance crew or work group assigned to perform the work.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred for the work order, including labor, materials, contractor services, and overhead allocations.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when work execution was completed in the field.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours actually expended on the work order, captured from time sheets and labor transactions.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work execution began in the field.',
    `approved_by` STRING COMMENT 'Name or identifier of the supervisor or manager who approved the work order for execution or closure.',
    `assigned_to` STRING COMMENT 'Name or identifier of the technician, crew, or contractor assigned to execute the work order.',
    `cause_code` STRING COMMENT 'Standardized code identifying the root cause of the failure (e.g., corrosion, age, improper operation, design defect).',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was formally closed and moved to historical status.',
    `completion_notes` STRING COMMENT 'Detailed narrative entered by the technician upon work completion, documenting findings, actions taken, parts replaced, and any follow-up recommendations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was first created in the Computerized Maintenance Management System (CMMS).',
    `work_order_description` STRING COMMENT 'Detailed narrative description of the work to be performed, including scope, objectives, and any special instructions or safety considerations.',
    `downtime_duration_hours` DECIMAL(18,2) COMMENT 'Total hours the asset was out of service or unavailable due to this maintenance activity, critical for calculating Mean Time Between Failures (MTBF) and Mean Time To Repair (MTTR) Key Performance Indicators (KPIs).',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Planned total cost for the work order including labor, materials, and services, used for budgeting and Capital Expenditure (CAPEX) / Operating Expenditure (OPEX) planning.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Planned total labor hours required to complete the work order, used for resource planning and scheduling.',
    `failure_code` STRING COMMENT 'Standardized code identifying the type of failure or problem that triggered the work order (e.g., leak, blockage, electrical fault, mechanical wear).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was last updated or modified.',
    `permit_required` BOOLEAN COMMENT 'Indicates whether regulatory permits (confined space entry, hot work, excavation, discharge) are required before work can commence.',
    `priority` STRING COMMENT 'Business priority level indicating urgency and impact of the work order on operations, safety, and regulatory compliance.. Valid values are `critical|high|medium|low`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this work order is driven by regulatory compliance requirements (Safe Drinking Water Act (SDWA), Clean Water Act (CWA), National Pollutant Discharge Elimination System (NPDES), Lead and Copper Rule Revisions (LCRR)).',
    `remedy_code` STRING COMMENT 'Standardized code identifying the corrective action taken to resolve the failure (e.g., repair, replace, adjust, clean).',
    `reported_date` DATE COMMENT 'Date when the work need was first reported or identified.',
    `safety_plan_required` BOOLEAN COMMENT 'Indicates whether a formal safety plan, Job Safety Analysis (JSA), or Occupational Safety and Health Administration (OSHA) compliance documentation is required for this work order.',
    `scheduled_finish_date` DATE COMMENT 'Planned date when work is scheduled to be completed.',
    `scheduled_start_date` DATE COMMENT 'Planned date when work is scheduled to begin.',
    `source` STRING COMMENT 'Origin or trigger that created the work order (preventive maintenance schedule, Supervisory Control and Data Acquisition (SCADA) alarm, customer complaint, inspection finding, operator observation, predictive analytics model, regulatory mandate). [ENUM-REF-CANDIDATE: pm_schedule|scada_alarm|customer_complaint|inspection|operator_round|predictive_analytics|regulatory_requirement — 7 candidates stripped; promote to reference product]',
    `supervisor_approval_date` DATE COMMENT 'Date when the work order was reviewed and approved by the maintenance supervisor or manager.',
    `warranty_claim` BOOLEAN COMMENT 'Indicates whether this work order is associated with a warranty claim against a vendor or contractor for defective equipment or workmanship.',
    `work_order_number` STRING COMMENT 'Externally visible business identifier for the work order, typically human-readable and used in field operations and reporting.',
    `work_order_status` STRING COMMENT 'Current lifecycle status of the work order in the maintenance workflow, from creation through completion and closure. [ENUM-REF-CANDIDATE: draft|approved|scheduled|in_progress|on_hold|completed|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `work_order_type` STRING COMMENT 'Classification of the work order by maintenance strategy: preventive maintenance (PM), corrective maintenance (CM), predictive maintenance (PdM), emergency, inspection, calibration, or capital project work. [ENUM-REF-CANDIDATE: preventive_maintenance|corrective_maintenance|predictive_maintenance|emergency|inspection|calibration|project — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Core transactional record for all maintenance activities — preventive (PM), corrective (CM), predictive (PdM), and emergency work orders. Captures work type, priority, originating asset, assigned crew/technician, scheduled and actual start/finish dates, labor hours, failure code, cause code, remedy code, downtime duration, and work order cost. Includes material line items: parts consumed or reserved with quantity, unit cost, issue date, storeroom, and reservation status. Enables actual vs. planned cost tracking (labor, material, contractor/service, overhead) per work order with GL account code and cost center. The authoritative SSOT for maintenance execution and O&M cost accounting, synchronized with IBM Maximo Work Order and SAP PM Order. Supports rate case cost justification and AWWA benchmarking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record.',
    `asset_class_id` BIGINT COMMENT 'Reference to the standardized job plan that defines the detailed work instructions, materials, tools, and safety procedures for this maintenance task.',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), pumping station, or other facility where the asset is located and the preventive maintenance will be performed.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset (equipment, pipe, pump, valve, vehicle) to which this preventive maintenance schedule applies.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory requirements drive PM schedules (monthly chlorine residual checks per permit, quarterly backwash inspections per state rules). Links maintenance planning to compliance obligations, ensures',
    `asset_criticality_rating` STRING COMMENT 'Criticality classification of the asset to which this schedule applies, indicating the impact of asset failure on operations, safety, regulatory compliance, or customer service.. Valid values are `critical|essential|important|standard`',
    `auto_generate_work_order_flag` BOOLEAN COMMENT 'Indicates whether work orders should be automatically generated by the CMMS system when the schedule becomes due, or whether manual review and approval is required before work order creation.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which preventive maintenance costs should be allocated for accounting and budgeting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this preventive maintenance schedule record was first created in the CMMS system.',
    `downtime_required_flag` BOOLEAN COMMENT 'Indicates whether the asset must be taken out of service (downtime) to perform the preventive maintenance task, requiring operational planning and backup capacity arrangements.',
    `effective_end_date` DATE COMMENT 'Date when this preventive maintenance schedule expires or is deactivated, after which no further work orders will be generated. Null indicates an open-ended schedule.',
    `effective_start_date` DATE COMMENT 'Date when this preventive maintenance schedule becomes active and begins generating work orders.',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that the asset will be out of service during preventive maintenance, used for operational planning and redundancy management.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Estimated cost of labor required to complete the preventive maintenance task based on estimated hours and labor rates, used for budgeting and OPEX planning.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete the preventive maintenance task, used for workforce planning and scheduling.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Estimated cost of materials, parts, and consumables required to complete the preventive maintenance task, used for budgeting and OPEX planning.',
    `frequency_interval` STRING COMMENT 'Numeric value representing the interval between preventive maintenance occurrences, interpreted based on the frequency unit (e.g., 30 for days, 500 for hours, 1000 for gallons).',
    `frequency_unit` STRING COMMENT 'Unit of measure for the frequency interval, defining whether the schedule is based on time periods (days, weeks, months, years), operating hours, operational cycles, or volume processed (gallons, cubic meters). [ENUM-REF-CANDIDATE: days|weeks|months|years|hours|cycles|gallons|cubic_meters — 8 candidates stripped; promote to reference product]',
    `gl_account_code` STRING COMMENT 'General ledger account code for recording preventive maintenance expenses in the financial system, distinguishing between OPEX maintenance and CAPEX capital improvements.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this preventive maintenance schedule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this preventive maintenance schedule record was last modified in the CMMS system.',
    `last_performed_date` DATE COMMENT 'Date when the preventive maintenance task was last completed, used to calculate the next due date for calendar-based schedules.',
    `lead_time_days` STRING COMMENT 'Number of days before the next due date that the work order should be generated to allow for planning, scheduling, and resource allocation.',
    `maintenance_task_description` STRING COMMENT 'Detailed description of the preventive maintenance task to be performed, including specific procedures, inspections, or servicing activities required.',
    `meter_threshold` DECIMAL(18,2) COMMENT 'Threshold value for meter-based preventive maintenance triggers; when the asset meter reading reaches or exceeds this value, a work order is automatically generated.',
    `meter_type` STRING COMMENT 'Type of meter or measurement used for meter-based preventive maintenance triggers, such as operating hours, flow volume, pressure cycles, or other asset-specific usage metrics.',
    `next_due_date` DATE COMMENT 'Calculated date when the next preventive maintenance work order should be generated based on the schedule frequency and last performed date.',
    `priority` STRING COMMENT 'Priority level assigned to the preventive maintenance schedule based on asset criticality, regulatory requirements, or operational impact, used to sequence work order execution.. Valid values are `critical|high|medium|low`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this preventive maintenance schedule is required to meet regulatory compliance obligations such as EPA Safe Drinking Water Act (SDWA), Clean Water Act (CWA), NPDES permit conditions, or state-level inspection requirements.',
    `regulatory_reference` STRING COMMENT 'Citation or reference to the specific regulatory requirement, permit condition, or compliance standard that mandates this preventive maintenance activity (e.g., SDWA Section 1412, NPDES Permit Condition 3.2).',
    `required_skill_certifications` STRING COMMENT 'Comma-separated list of required skill certifications or qualifications that technicians must possess to perform this preventive maintenance task safely and effectively (e.g., electrical license, confined space entry, SCADA operator certification).',
    `safety_requirements` STRING COMMENT 'Description of safety precautions, personal protective equipment (PPE), lockout/tagout procedures, confined space entry protocols, or other safety measures required for this preventive maintenance task.',
    `schedule_name` STRING COMMENT 'Descriptive name of the preventive maintenance schedule for easy identification by operations and maintenance staff.',
    `schedule_number` STRING COMMENT 'Business identifier for the preventive maintenance schedule, typically assigned by the CMMS system for tracking and reporting purposes.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the preventive maintenance schedule indicating whether it is actively generating work orders or has been suspended or deactivated.. Valid values are `active|inactive|suspended|draft|expired`',
    `seasonal_end_month` STRING COMMENT 'Month number (1-12) when seasonal preventive maintenance schedule becomes inactive, applicable only when seasonal_schedule_flag is true.',
    `seasonal_schedule_flag` BOOLEAN COMMENT 'Indicates whether this preventive maintenance schedule is seasonal in nature, applicable only during specific months or seasons (e.g., winterization of outdoor equipment, summer peak demand preparation).',
    `seasonal_start_month` STRING COMMENT 'Month number (1-12) when seasonal preventive maintenance schedule becomes active, applicable only when seasonal_schedule_flag is true.',
    `trigger_type` STRING COMMENT 'Type of trigger mechanism that determines when preventive maintenance is due: calendar-based (time intervals), meter-based (usage thresholds), condition-based (sensor readings), runtime-based (operating hours), or cycle-based (number of operations).. Valid values are `calendar|meter|condition|runtime|cycle`',
    `work_order_type` STRING COMMENT 'Classification of the work order that will be generated from this schedule, indicating the nature of the maintenance activity (preventive maintenance, inspection, calibration, lubrication, cleaning).. Valid values are `preventive|inspection|calibration|lubrication|cleaning`',
    `work_zone` STRING COMMENT 'Specific work zone, area, or department within the facility where the preventive maintenance activity will take place, used for crew assignment and access control.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this preventive maintenance schedule record in the CMMS system.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Defines preventive maintenance schedules for assets, including maintenance task description, trigger type (calendar-based, meter-based, condition-based), frequency or interval, last performed date, next due date, estimated labor hours, required skill certifications, and associated job plan. Drives automatic work order generation in IBM Maximo. Supports AWWA O&M best practices and regulatory inspection compliance requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` (
    `failure_record_id` BIGINT COMMENT 'Unique identifier for the asset failure event record. Primary key.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Failure events (main breaks, SSOs, CSOs) trigger mandatory regulatory notification obligations under specific SDWA/NPDES requirements. failure_record.regulatory_notification_required_flag and regulato',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Regulatory service interruption reporting and customer outage notification require linking failure records directly to service addresses. Utilities must notify affected customers and report main break',
    `work_order_id` BIGINT COMMENT 'Reference to the corrective maintenance work order generated in response to this failure event.',
    `actual_repair_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred to repair or replace the failed asset after work completion.',
    `affected_system` STRING COMMENT 'The operational system or process affected by the failure (e.g., high service pump station, chlorination system, SCADA network, distribution main).',
    `corrective_actions_recommended` STRING COMMENT 'List of recommended corrective and preventive actions to prevent recurrence of similar failures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this failure record was first created in the system.',
    `cso_event_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure resulted in a Combined Sewer Overflow event requiring regulatory reporting.',
    `customers_affected_count` STRING COMMENT 'Count of customer accounts impacted by the failure event (service interruption, pressure loss, water quality issue).',
    `detection_method` STRING COMMENT 'Method by which the failure was discovered (SCADA alarm, operator inspection, customer complaint, etc.). [ENUM-REF-CANDIDATE: scada_alarm|operator_inspection|customer_complaint|scheduled_inspection|predictive_maintenance|routine_testing|emergency_response — 7 candidates stripped; promote to reference product]',
    `downtime_duration_hours` DECIMAL(18,2) COMMENT 'Total duration in hours that the asset was out of service due to the failure.',
    `emergency_response_actions` STRING COMMENT 'Detailed description of immediate emergency response actions taken to mitigate the failure (e.g., valve isolation, backup system activation, customer notification).',
    `environmental_impact_description` STRING COMMENT 'Description of any environmental impact resulting from the failure (e.g., water body contamination, soil contamination, habitat damage).',
    `failure_cause` STRING COMMENT 'Identified root cause of the failure (e.g., age-related deterioration, improper installation, inadequate maintenance, design deficiency, operational error, external damage).',
    `failure_criticality_score` STRING COMMENT 'Calculated criticality score based on failure severity, service impact, and asset importance (typically 1-100 scale).',
    `failure_date` DATE COMMENT 'Calendar date when the asset failure occurred.',
    `failure_effect` STRING COMMENT 'Description of the operational impact and consequences of the failure on system performance and service delivery.',
    `failure_mode` STRING COMMENT 'Classification of how the asset failed (e.g., mechanical fracture, electrical short, corrosion perforation, seal leakage, bearing seizure, control malfunction).',
    `failure_number` STRING COMMENT 'Business-readable unique identifier for the failure event, typically auto-generated by CMMS.',
    `failure_severity` STRING COMMENT 'Severity classification of the failure based on service impact, safety risk, and regulatory implications.. Valid values are `critical|major|moderate|minor`',
    `failure_status` STRING COMMENT 'Current lifecycle status of the failure record in the investigation and resolution workflow.. Valid values are `reported|under_investigation|rca_in_progress|corrective_action_pending|resolved|closed`',
    `failure_time` TIMESTAMP COMMENT 'Precise date and time when the asset failure was detected or occurred.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this failure record was last updated or modified.',
    `mtbf_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this failure event should be included in MTBF reliability calculations for the asset class.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Measured time in hours from failure detection to restoration of asset to full operational status.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context related to the failure event.',
    `overflow_volume_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of wastewater overflow in gallons resulting from SSO or CSO event, if applicable.',
    `pressure_drop_psi` DECIMAL(18,2) COMMENT 'Measured drop in system pressure (PSI) resulting from the failure event.',
    `production_loss_mgd` DECIMAL(18,2) COMMENT 'Estimated water production capacity lost due to the failure, measured in Million Gallons per Day.',
    `regulatory_notification_date` DATE COMMENT 'Date when regulatory agencies were notified of the failure event, if applicable.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure event requires notification to regulatory agencies (EPA, state primacy agency).',
    `repair_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost to repair or replace the failed asset, including labor, materials, and contractor costs.',
    `resolution_date` DATE COMMENT 'Date when the failure was fully resolved and the asset was restored to normal operation.',
    `root_cause_analysis_completed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a formal root cause analysis (RCA) has been completed for this failure event.',
    `root_cause_analysis_findings` STRING COMMENT 'Detailed findings and conclusions from the root cause analysis investigation, including contributing factors and systemic issues identified.',
    `service_interruption_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure resulted in a complete service interruption to customers.',
    `sso_event_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure resulted in a Sanitary Sewer Overflow event requiring regulatory reporting.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure is covered under manufacturer or contractor warranty and a claim was filed.',
    CONSTRAINT pk_failure_record PRIMARY KEY(`failure_record_id`)
) COMMENT 'Documents asset failure events including failure date and time, failure mode, failure cause, failure effect, affected system, downtime duration, service impact (customers affected, MGD lost, PSI drop), emergency response actions taken, and root cause analysis findings. Supports reliability-centered maintenance (RCM) analysis, MTBF/MTTR calculations, and regulatory SSO/CSO incident reporting. Linked to corrective work orders in IBM Maximo.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` (
    `acquisition_id` BIGINT COMMENT 'Unique identifier for the asset acquisition record. Primary key for the asset acquisition data product.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: The acquisition table stores asset_class as a plain STRING column, which is a denormalized snapshot of the asset classification. Normalizing this to a FK (asset_class_id → asset.asset_class.asset_clas',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Capital acquisitions mandated by enforcement actions (administrative orders, consent decrees) must be traceable to the specific enforcement action. This supports consent decree compliance reporting, p',
    `facility_id` BIGINT COMMENT 'Identifier for the Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), pump station, or other facility where the asset is located.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: New asset installations (meters, service lines, backflow preventers) are tied to specific premises for connection fee reconciliation, CIP project tracking, and regulatory asset inventory. Water utilit',
    `registry_id` BIGINT COMMENT 'Reference to the asset being acquired in the asset registry. Links this acquisition to the corresponding asset_registry record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Capital acquisitions are frequently mandated by regulatory requirements (LCRR lead service line replacement programs, consent decree capital projects, SDWA infrastructure mandates). Linking acquisitio',
    `territory_id` BIGINT COMMENT 'Capital Improvement Program project identifier if the asset was acquired as part of a capital project. Links to project management and budget tracking.',
    `acquisition_date` DATE COMMENT 'Date on which the asset was legally acquired or title transferred to the utility. Used for depreciation start date calculation and asset lifecycle tracking.',
    `acquisition_status` STRING COMMENT 'Current status of the acquisition record in the workflow. Tracks progression from initiation through completion and asset registry creation.. Valid values are `pending|approved|completed|cancelled`',
    `acquisition_type` STRING COMMENT 'Method by which the asset was acquired into the utilitys asset base. Determines accounting treatment and capitalization rules.. Valid values are `purchase|construction|donation|transfer|lease`',
    `approval_date` DATE COMMENT 'Date on which the asset acquisition was formally approved by the designated authority. Part of the audit trail.',
    `approved_by` STRING COMMENT 'Name or identifier of the manager or authority who approved the asset acquisition. Required for audit trail and governance.',
    `asset_category` STRING COMMENT 'Detailed categorization within the asset class such as pump, valve, pipe, tank, or vehicle. Supports asset hierarchy and reporting.',
    `capitalization_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum dollar amount threshold for capitalizing an asset as defined by the utilitys accounting policy. Typically ranges from $1,000 to $5,000 for water utilities.',
    `capitalization_threshold_met_flag` BOOLEAN COMMENT 'Indicates whether the acquisition cost meets the utilitys capitalization threshold for fixed asset recording. Determines if asset is capitalized or expensed.',
    `commissioning_date` DATE COMMENT 'Date on which the asset was placed into service and became operational. Marks the start of depreciation for accounting purposes.',
    `contractor_name` STRING COMMENT 'Name of the construction contractor who built or installed the asset, applicable for construction acquisition type.',
    `cost` DECIMAL(18,2) COMMENT 'Total cost of acquiring the asset including purchase price, installation, freight, and other capitalizable costs. Basis for depreciation calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset acquisition record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost. Typically USD for United States water utilities.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the asset over its useful life. Straight-line is most common for water utility infrastructure.. Valid values are `straight_line|declining_balance|units_of_production`',
    `functional_location` STRING COMMENT 'SAP PM functional location code representing the hierarchical location of the asset within the utilitys infrastructure. Supports Geographic Information System (GIS) integration.',
    `funding_source` STRING COMMENT 'Source of funds used to finance the asset acquisition. Critical for Capital Expenditure (CAPEX) tracking and regulatory rate case filings.. Valid values are `capex|grant|bond|developer_contribution|rate_revenue|loan`',
    `grant_award_num` STRING COMMENT 'Unique identifier for the grant award that funded the acquisition, required for grant compliance reporting.',
    `grant_program_name` STRING COMMENT 'Name of the federal, state, or local grant program that funded the acquisition, if applicable. Examples include EPA Water Infrastructure Finance and Innovation Act (WIFIA) or State Revolving Fund (SRF).',
    `initial_condition_grade` STRING COMMENT 'Condition assessment grade assigned at the time of acquisition. Baseline for future condition monitoring and asset health tracking.. Valid values are `excellent|good|fair|poor|critical`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset acquisition record was last updated. Audit field for change tracking and data quality monitoring.',
    `maximo_asset_num` STRING COMMENT 'IBM Maximo Computerized Maintenance Management System (CMMS) asset number assigned at acquisition. External system identifier for cross-reference.',
    `notes` STRING COMMENT 'Free-text notes documenting special circumstances, conditions, or details about the asset acquisition. Supports audit trail and historical context.',
    `purchase_order_num` STRING COMMENT 'Purchase order number from SAP Materials Management (MM) or procurement system authorizing the asset acquisition. Links to procurement transaction.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. Used in depreciation calculation for certain methods.',
    `sap_equipment_num` STRING COMMENT 'SAP Enterprise Resource Planning (ERP) Plant Maintenance (PM) equipment number assigned at acquisition. External system identifier for cross-reference.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the asset in years for depreciation calculation. Varies by asset class per Generally Accepted Accounting Principles (GAAP) and Governmental Accounting Standards Board (GASB) guidelines.',
    `warranty_duration_months` STRING COMMENT 'Duration of the warranty period in months. Calculated from warranty start and expiry dates for reporting purposes.',
    `warranty_expiry_date` DATE COMMENT 'Date on which the manufacturer or contractor warranty period ends. Critical for maintenance planning and defect liability tracking.',
    `warranty_start_date` DATE COMMENT 'Date on which the manufacturer or contractor warranty period begins for the acquired asset.',
    `work_order_num` STRING COMMENT 'Work order number from IBM Maximo or SAP PM for construction or installation activities related to the acquisition.',
    CONSTRAINT pk_acquisition PRIMARY KEY(`acquisition_id`)
) COMMENT 'Records the acquisition of new assets into the utilitys asset base, capturing acquisition type (purchase, construction, donation, transfer), acquisition date, purchase order reference, vendor/contractor, acquisition cost, funding source (CAPEX, grant, developer contribution), commissioning date, and initial condition grade. Triggers creation of the asset_registry record and depreciation_schedule. Integrates with SAP MM purchase orders and SAP FI asset capitalization.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` (
    `inspection_event_id` BIGINT COMMENT 'Unique identifier for the inspection event record. Primary key.',
    `asset_class_id` BIGINT COMMENT 'Reference to the standardized inspection checklist or form template used during the inspection.',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), or other facility where the inspection occurred.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: The inspection_event table contains a functional_location STRING column that is a denormalized text reference to where the inspection occurred. The asset domain has a rich hierarchical location regi',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Inspection events in a water utility are frequently triggered by preventive maintenance schedules (e.g., annual valve inspections, quarterly pump checks defined in pm_schedule). Linking inspection_eve',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: inspection_event.regulatory_agency is a plain-text denormalized field referencing the regulatory agency conducting or mandating the inspection. Replacing it with a proper FK to regulatory_agency enabl',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Internal inspection events are scheduled to satisfy specific regulatory requirements (LCRR, Surface Water Treatment Rule, state tank inspection mandates). inspection_event has regulatory_inspection_fl',
    `treatment_permit_id` BIGINT COMMENT 'Foreign key linking to treatment.treatment_permit. Business justification: Regulatory inspections at treatment facilities are conducted under specific treatment permits. inspection_event.permit_number is a denormalized plain attribute that should be replaced with a proper FK',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order under which this inspection was performed, if applicable.',
    `approval_date` DATE COMMENT 'Date on which the inspection results were formally approved by the reviewing authority.',
    `checklist_version` STRING COMMENT 'Version identifier of the inspection checklist used, ensuring traceability to specific regulatory or operational standards.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which identified deficiencies must be remediated, based on regulatory or operational requirements.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action work orders or follow-up activities are required as a result of this inspection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection event record was first created in the system.',
    `critical_deficiency_flag` BOOLEAN COMMENT 'Indicates whether any critical or high-severity deficiencies were identified that require immediate corrective action.',
    `deficiencies_identified_count` STRING COMMENT 'Total number of deficiencies, non-conformances, or issues identified during the inspection.',
    `deficiency_summary` STRING COMMENT 'Summary description of all deficiencies identified during the inspection, including severity and recommended actions.',
    `duration_minutes` STRING COMMENT 'Total time spent performing the inspection, measured in minutes.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the inspection identified any environmental compliance issues or potential environmental impacts.',
    `inspection_date` DATE COMMENT 'The calendar date on which the physical inspection was performed.',
    `inspection_end_time` TIMESTAMP COMMENT 'Timestamp when the inspection activity was completed.',
    `inspection_frequency_days` STRING COMMENT 'Required frequency of this inspection type, measured in days, as mandated by regulatory or operational policy.',
    `inspection_notes` STRING COMMENT 'Free-text field for inspector observations, comments, and detailed findings from the inspection.',
    `inspection_start_time` TIMESTAMP COMMENT 'Timestamp when the inspection activity commenced.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection event. [ENUM-REF-CANDIDATE: scheduled|in_progress|completed|cancelled|failed|pending_review|approved — 7 candidates stripped; promote to reference product]',
    `inspection_type` STRING COMMENT 'Classification of the inspection activity. [ENUM-REF-CANDIDATE: routine|regulatory|post_incident|pre_commissioning|condition_assessment|safety|environmental|quality|preventive|corrective — promote to reference product]',
    `inspector_certification_num` STRING COMMENT 'Professional certification or license number of the inspector, if required by regulatory authority.',
    `inspector_name` STRING COMMENT 'Full name of the inspector who conducted the inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection event record was most recently updated.',
    `maximo_inspection_num` STRING COMMENT 'External inspection identifier from IBM Maximo CMMS system.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection of this asset or component.',
    `pass_fail_outcome` STRING COMMENT 'Overall pass/fail result of the inspection based on checklist criteria and regulatory requirements.. Valid values are `pass|fail|conditional_pass|not_applicable`',
    `regulatory_inspection_flag` BOOLEAN COMMENT 'Indicates whether this inspection was mandated by a regulatory authority (EPA, state primacy agency, OSHA) or was voluntary/internal.',
    `report_submission_date` DATE COMMENT 'Date on which the inspection report was submitted to the regulatory authority.',
    `report_submitted_flag` BOOLEAN COMMENT 'Indicates whether the inspection report has been submitted to the regulatory authority, if required.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident or near-miss occurred during the inspection activity.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of inspection, relevant for outdoor infrastructure inspections (pipes, valves, tanks).',
    CONSTRAINT pk_inspection_event PRIMARY KEY(`inspection_event_id`)
) COMMENT 'Operational record of a physical inspection performed on an asset or infrastructure component, including inspection type (routine, regulatory, post-incident, pre-commissioning), inspector identity, inspection date, checklist used, pass/fail outcome, deficiencies identified, corrective action required flag, and regulatory permit reference. Distinct from condition_assessment (which produces a scored condition grade) — inspection_event captures compliance-driven inspection activities required by EPA, state primacy agencies, and OSHA.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_parent_asset_registry_id` FOREIGN KEY (`parent_asset_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`asset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`asset` SET TAGS ('dbx_domain' = 'asset');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `parent_asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Asset Acquisition Cost (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category / Business Domain');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name / Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `asset_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag / Barcode Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `condition_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Condition Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission / Retirement Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Asset Nominal Diameter (Millimeters)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Asset Elevation (Meters Above Sea Level)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `functional_location` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `is_lead_service_line` SET TAGS ('dbx_business_glossary_term' = 'Lead Service Line (LSL) Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude Coordinate');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'preventive|predictive|corrective|run_to_failure|condition_based');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `maximo_asset_num` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `model_num` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Model Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|standby|decommissioned|under_construction|abandoned');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Pipe / Asset Material');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating (Kilowatts)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone / District Metered Area (DMA)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `regulatory_asset_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `replacement_cost` SET TAGS ('dbx_business_glossary_term' = 'Asset Replacement Cost (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `replacement_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `sap_equipment_num` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Maintenance (PM) Equipment Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `scada_tag` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `serial_num` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `ami_applicable` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Applicable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `asset_domain` SET TAGS ('dbx_business_glossary_term' = 'Asset Operational Domain');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `capex_threshold_usd` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Capitalization Threshold (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `cip_program_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Category');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `class_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `class_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `class_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `class_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `class_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Deprecated|Under Review');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `condition_assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Default Condition Assessment Method');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `consequence_of_failure` SET TAGS ('dbx_business_glossary_term' = 'Primary Consequence of Failure Category');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `consequence_of_failure` SET TAGS ('dbx_value_regex' = 'Service Interruption|Public Health Risk|Environmental Non-Compliance|Safety Hazard|Financial Loss|Reputational');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `criticality_tier` SET TAGS ('dbx_business_glossary_term' = 'Default Criticality Tier');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `criticality_tier` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `criticality_weight` SET TAGS ('dbx_business_glossary_term' = 'Criticality Weighting Factor');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Default Depreciation Method');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'Straight-Line|Declining Balance|Units of Production|Sum-of-Years-Digits|Modified Accelerated Cost Recovery');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `environmental_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Risk Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `gis_feature_class` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature Class Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Hierarchy Level');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Frequency (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `iso_55001_aligned` SET TAGS ('dbx_business_glossary_term' = 'ISO 55001 Asset Management Aligned Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `lcrr_applicable` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Rule Revisions (LCRR) Applicable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Default Maintenance Strategy');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'Preventive|Predictive|Corrective|Condition-Based|Run-to-Failure');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `material_standard` SET TAGS ('dbx_business_glossary_term' = 'Default Material Standard');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `maximo_class_code` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Asset Class Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `maximo_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `mean_time_between_failures_days` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `number_sap` SET TAGS ('dbx_business_glossary_term' = 'SAP Asset Class Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `number_sap` SET TAGS ('dbx_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `pm_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Frequency (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `primary_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Primary Category');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `renewal_strategy` SET TAGS ('dbx_business_glossary_term' = 'Default Asset Renewal Strategy');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `renewal_strategy` SET TAGS ('dbx_value_regex' = 'Replace-in-Kind|Upgrade|Rehabilitation|CIPP|Trenchless|Decommission');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Retirement Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Hazard Classification');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'Confined Space|Electrical Hazard|Chemical Hazard|High Pressure|Radiation|None');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `salvage_value_pct` SET TAGS ('dbx_business_glossary_term' = 'Default Salvage Value Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `scada_monitored` SET TAGS ('dbx_business_glossary_term' = 'SCADA Monitored Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `size_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Asset Size Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `spare_parts_required` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Default Useful Life (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `work_order_type_default` SET TAGS ('dbx_business_glossary_term' = 'Default Work Order Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `work_order_type_default` SET TAGS ('dbx_value_regex' = 'Preventive Maintenance|Corrective Maintenance|Inspection|Emergency Repair|Capital Renewal|Rehabilitation');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `parent_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Location Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `area_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Feet (sq ft)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Capacity Rating');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'mgd|gpm|gallons|cubic_meters|units');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `dma_zone` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Zone');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Elevation in Feet (ft)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|temporary');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'facility|building|floor|room|outdoor_site|storage_yard');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `maximo_location_code` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Location Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Location Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `sap_functional_location` SET TAGS ('dbx_business_glossary_term' = 'SAP Functional Location');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `service_territory` SET TAGS ('dbx_business_glossary_term' = 'Service Territory');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `spatial_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Spatial Reference Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `watershed` SET TAGS ('dbx_business_glossary_term' = 'Watershed');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Location Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `assessment_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Assessment Interval (Months)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|reviewed|approved|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Count');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `estimated_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Cost');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `estimated_repair_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `estimated_replacement_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Replacement Cost');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `estimated_replacement_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `failure_probability` SET TAGS ('dbx_business_glossary_term' = 'Failure Probability');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `inspection_equipment_used` SET TAGS ('dbx_business_glossary_term' = 'Inspection Equipment Used');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `inspector_certification` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `recommended_action` SET TAGS ('dbx_value_regex' = 'monitor|repair|rehabilitate|replace|no_action|emergency_repair');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `recommended_action_priority` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action Priority');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `recommended_action_priority` SET TAGS ('dbx_value_regex' = 'immediate|urgent|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `structural_integrity_score` SET TAGS ('dbx_business_glossary_term' = 'Structural Integrity Score');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `criticality_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `assessment_performed_by` SET TAGS ('dbx_business_glossary_term' = 'Assessment Performed By');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `capital_renewal_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Capital Renewal Priority Rank');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `cip_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Eligibility Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `consequence_of_failure_score` SET TAGS ('dbx_business_glossary_term' = 'Consequence of Failure (CoF) Score');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `criticality_tier` SET TAGS ('dbx_business_glossary_term' = 'Criticality Tier');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `criticality_tier` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `customer_impact_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Count');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `likelihood_of_failure_score` SET TAGS ('dbx_business_glossary_term' = 'Likelihood of Failure (LoF) Score');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `methodology_version` SET TAGS ('dbx_business_glossary_term' = 'Methodology Version');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `overall_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Score');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `preventive_maintenance_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Frequency (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `public_health_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Health Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `public_health_impact_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `public_health_impact_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `public_health_impact_flag` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `rating_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `rating_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'Active|Superseded|Under Review|Pending Approval');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `redundancy_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Available Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `regulatory_consequence_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Consequence Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `safety_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `service_disruption_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Disruption Duration (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'Cause Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `work_order_description` SET TAGS ('dbx_business_glossary_term' = 'Work Order Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `downtime_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration Hours');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `permit_required` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Order Priority');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `remedy_code` SET TAGS ('dbx_business_glossary_term' = 'Remedy Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `safety_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Plan Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Work Order Source');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `supervisor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `warranty_claim` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `asset_criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `asset_criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|essential|important|standard');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `auto_generate_work_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Generate Work Order Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `downtime_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Hours');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `frequency_interval` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Unit');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `last_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performed Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `maintenance_task_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Task Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `meter_threshold` SET TAGS ('dbx_business_glossary_term' = 'Meter Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Priority');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `required_skill_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Skill Certifications');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|draft|expired');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `seasonal_end_month` SET TAGS ('dbx_business_glossary_term' = 'Seasonal End Month');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `seasonal_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Schedule Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `seasonal_start_month` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Start Month');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Trigger Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'calendar|meter|condition|runtime|cycle');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'preventive|inspection|calibration|lubrication|cleaning');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `work_zone` SET TAGS ('dbx_business_glossary_term' = 'Work Zone');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `actual_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Repair Cost in US Dollars (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `affected_system` SET TAGS ('dbx_business_glossary_term' = 'Affected System or Process');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `corrective_actions_recommended` SET TAGS ('dbx_business_glossary_term' = 'Recommended Corrective Actions');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `cso_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Combined Sewer Overflow (CSO) Event Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `customers_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Customers Affected');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Failure Detection Method');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `downtime_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Asset Downtime Duration in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `emergency_response_actions` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Actions Taken');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `environmental_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause of Failure');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_criticality_score` SET TAGS ('dbx_business_glossary_term' = 'Failure Criticality Score');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_date` SET TAGS ('dbx_business_glossary_term' = 'Failure Occurrence Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_effect` SET TAGS ('dbx_business_glossary_term' = 'Failure Effect Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Classification');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_number` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_severity` SET TAGS ('dbx_business_glossary_term' = 'Failure Severity Level');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_severity` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_status` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|rca_in_progress|corrective_action_pending|resolved|closed');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_time` SET TAGS ('dbx_business_glossary_term' = 'Failure Occurrence Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `mtbf_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Impact Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `overflow_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Overflow Volume in Gallons');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `pressure_drop_psi` SET TAGS ('dbx_business_glossary_term' = 'System Pressure Drop in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `production_loss_mgd` SET TAGS ('dbx_business_glossary_term' = 'Production Loss in Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `repair_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Cost in US Dollars (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Failure Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `root_cause_analysis_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Completed Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `root_cause_analysis_findings` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Findings');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `service_interruption_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Interruption Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `sso_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Event Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Acquisition Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_value_regex' = 'pending|approved|completed|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_value_regex' = 'purchase|construction|donation|transfer|lease');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `capitalization_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Threshold Amount');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `capitalization_threshold_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Threshold Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `functional_location` SET TAGS ('dbx_business_glossary_term' = 'Functional Location');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'capex|grant|bond|developer_contribution|rate_revenue|loan');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `grant_award_num` SET TAGS ('dbx_business_glossary_term' = 'Grant Award Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `grant_program_name` SET TAGS ('dbx_business_glossary_term' = 'Grant Program Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `grant_program_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `initial_condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Initial Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `initial_condition_grade` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `maximo_asset_num` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `purchase_order_num` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `sap_equipment_num` SET TAGS ('dbx_business_glossary_term' = 'SAP Equipment Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life in Years');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `warranty_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Duration in Months');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `work_order_num` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `checklist_version` SET TAGS ('dbx_business_glossary_term' = 'Checklist Version');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `critical_deficiency_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Deficiency Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `deficiencies_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiencies Identified Count');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `deficiency_summary` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Summary');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration in Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency in Days');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspector_certification_num` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `maximo_inspection_num` SET TAGS ('dbx_business_glossary_term' = 'Maximo Inspection Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `pass_fail_outcome` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Outcome');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `pass_fail_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `regulatory_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Report Submitted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
