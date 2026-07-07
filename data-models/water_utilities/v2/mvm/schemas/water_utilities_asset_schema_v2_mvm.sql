-- Schema for Domain: asset | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-02 05:00:52

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`asset` COMMENT 'Enterprise asset management domain owning the full lifecycle of physical infrastructure assets including WTP/WWTP equipment, pipes, pumps, valves, electrical systems, and vehicles. Manages asset registry, condition assessments, criticality ratings, preventive and corrective maintenance, work order management, depreciation schedules, and CAPEX/OPEX planning. Integrates with IBM Maximo CMMS and SAP PM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`registry` (
    `registry_id` BIGINT COMMENT 'Unique surrogate primary key for each physical infrastructure asset record in the enterprise asset registry. This is the authoritative SSOT identifier that IBM Maximo Asset Management and SAP Plant Maintenance (PM) equipment master synchronize against.',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Registry stores asset classification as a free‑text field; linking to the asset_class taxonomy enables consistent classification and removes the redundant string column. Ref: IBM Maximo.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Individual assets (wells, outfalls, storage tanks) are governed by specific operating permits. Asset managers must know which permit covers each asset for renewal tracking, permit-condition compliance',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Registry currently has no explicit location reference; adding a foreign key to location allows assets to be tied to a physical site and supports location‑based reporting. Ref: IBM Maximo.',
    `parent_asset_registry_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent asset in the asset hierarchy (e.g., a pump impellers parent is the pump assembly; the pump assemblys parent is the pump station). Enables parent-child asset hierarchy navigation for maintenance cost roll-up and condition assessment aggregation. Null for top-level assets. Ref: IBM Maximo.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Distribution assets (hydrants, valves, mains) serve specific service addresses. Critical for emergency response, outage notifications, GIS integration, and customer impact analysis during main breaks. Ref: IBM Maximo.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase or construction cost of the asset in US dollars at the time of acquisition. Represents the capitalized cost basis used for depreciation calculations and fixed asset register reporting. Sourced from SAP FI/CO asset accounting module. Required for GASB Statement No. 34 infrastructure asset reporting. Ref: IBM Maximo.',
    `asset_category` STRING COMMENT 'Operational domain category indicating which business process area the asset belongs to (e.g., water_treatment for WTP equipment, wastewater_treatment for WWTP equipment, distribution for pipes and valves in the distribution network, collection for sewer infrastructure, metering for AMI/AMR devices). [ENUM-REF-CANDIDATE: water_treatment|wastewater_treatment|distribution|collection|metering|electrical|mechanical|civil|vehicle|instrumentation_control — 10 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `asset_name` STRING COMMENT 'Human-readable name or short description of the asset (e.g., Raw Water Pump No. 3, Influent Gate Valve 12-inch, Chlorine Contact Basin Filter 2). Used as the primary display label in CMMS, GIS, and reporting interfaces. Ref: IBM Maximo.',
    `asset_tag` STRING COMMENT 'Physical asset tag number (barcode, QR code, or RFID label) affixed to the asset in the field. Used by field technicians for asset identification during inspections, maintenance, and inventory audits. Corresponds to the Maximo asset tag field. Ref: IBM Maximo.',
    `asset_type` STRING COMMENT 'Sub-classification within the asset class providing more granular categorization (e.g., Centrifugal Pump, Gate Valve, Ductile Iron Pipe, AMI Smart Meter). Aligns with IBM Maximo asset type and SAP PM equipment category for maintenance planning and spare parts management.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the rated_capacity field. Common units include GPM (Gallons per Minute) for pumps, MGD (Million Gallons per Day) for treatment processes, gallons for storage tanks, kW for electrical equipment, and PSI (Pounds per Square Inch) for pressure vessels. [ENUM-REF-CANDIDATE: GPM|MGD|gallons|kW|kVA|HP|PSI|NTU|mg_L — 9 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `condition_assessment_date` DATE COMMENT 'Date of the most recent formal condition assessment performed on the asset. Used to determine assessment currency and schedule the next inspection cycle. Condition assessments may be visual inspections, CCTV surveys, vibration analysis, or other diagnostic methods. Ref: IBM Maximo.',
    `condition_grade` STRING COMMENT 'Standardized condition rating of the asset based on the most recent condition assessment, using a 1-5 scale where 1=Excellent/New, 2=Good, 3=Fair, 4=Poor, 5=Very Poor/Failed. Aligned with AWWA and WEF condition assessment frameworks. Drives maintenance prioritization and renewal planning.. Valid values are `1|2|3|4|5`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was first created in the enterprise asset registry. Provides audit trail for record provenance and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Ref: IBM Maximo.',
    `criticality_rating` STRING COMMENT 'Risk-based criticality classification of the asset based on consequence of failure analysis (CoFA). critical assets have the highest consequence of failure impacting public health, regulatory compliance, or major service disruption. Used to prioritize maintenance resources, Capital Improvement Program (CIP) investments, and emergency response planning. Aligned with AWWA risk and resilience assessment methodology.. Valid values are `critical|high|medium|low`',
    `decommission_date` DATE COMMENT 'Date the asset was permanently decommissioned, retired, or removed from service. Null for active assets. Used for asset lifecycle reporting, fixed asset register reconciliation, and Capital Improvement Program (CIP) tracking. Triggers write-off in SAP FI/CO fixed asset module. Ref: IBM Maximo.',
    `diameter_mm` DECIMAL(18,2) COMMENT 'Nominal diameter of the asset in millimeters. For pipes and valves, this is the internal bore diameter. For pumps, this is the discharge diameter. Used for hydraulic capacity calculations, spare parts specification, and network modeling in Innovyze InfoWater. Ref: IBM Maximo.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the asset above mean sea level in meters. Critical for hydraulic modeling, pressure zone assignment, and gravity-fed system design. Used in Innovyze InfoWater hydraulic models and Esri ArcGIS 3D network analysis. Ref: IBM Maximo.',
    `expected_useful_life_years` STRING COMMENT 'The estimated total useful life of the asset in years as defined by engineering standards, manufacturer specifications, or utility policy. Used for depreciation calculations, Capital Improvement Program (CIP) planning, and asset renewal forecasting. Aligns with GASB Statement No. 34 infrastructure reporting requirements. Ref: IBM Maximo.',
    `functional_location` STRING COMMENT 'Hierarchical functional location code representing the physical or functional position of the asset within the utilitys infrastructure (e.g., WTP-PUMP-STATION-01-PUMP-03). Mirrors the SAP PM Functional Location (FLOC) structure and IBM Maximo Location field. Used for structured asset hierarchy navigation and maintenance cost allocation.',
    `gis_feature_code` BOOLEAN COMMENT 'The unique feature identifier for this asset in the Esri ArcGIS geographic information system. Enables spatial queries, network tracing, and hydraulic model integration via Innovyze InfoWater. Used for field crew navigation and infrastructure mapping. Ref: IBM Maximo.',
    `installation_date` DATE COMMENT 'Date the asset was physically installed and placed into service at its current location. Used as the baseline for age calculations, depreciation schedules, warranty period tracking, and remaining useful life (RUL) estimation. Sourced from IBM Maximo installation date field.',
    `is_lead_service_line` BOOLEAN COMMENT 'Indicates whether this asset is a lead service line or contains lead components. Critical for compliance with the EPA Lead and Copper Rule Revisions (LCRR) which requires utilities to inventory and replace lead service lines. True = confirmed lead service line; False = non-lead or unknown.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recently completed maintenance activity (preventive or corrective) performed on this asset. Used to calculate maintenance intervals, identify overdue assets, and support compliance reporting for regulatory-mandated maintenance activities. Ref: IBM Maximo.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset record in the enterprise asset registry. Used for change tracking, data synchronization with IBM Maximo and SAP PM, and audit trail maintenance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the asset location in decimal degrees (WGS84 datum). Used for GIS mapping, field crew navigation, spatial analysis, and hydraulic network modeling in Innovyze InfoWater. Sourced from Esri ArcGIS asset layer. Ref: IBM Maximo.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the asset location in decimal degrees (WGS84 datum). Used for GIS mapping, field crew navigation, spatial analysis, and hydraulic network modeling in Innovyze InfoWater. Sourced from Esri ArcGIS asset layer. Ref: IBM Maximo.',
    `maintenance_strategy` STRING COMMENT 'The primary maintenance approach applied to this asset as defined in the Computerized Maintenance Management System (CMMS). preventive indicates time-based scheduled maintenance; predictive indicates condition-monitoring-based maintenance; condition_based indicates maintenance triggered by condition thresholds; run_to_failure is applied to non-critical, easily replaceable assets. Ref: IBM Maximo.. Valid values are `preventive|predictive|corrective|run_to_failure|condition_based`',
    `manufacture_date` DATE COMMENT 'Date the asset was manufactured by the OEM. May differ from installation date for assets stored in inventory before deployment. Used for age-based condition assessment and manufacturer warranty calculations. Ref: IBM Maximo.',
    `manufacturer` STRING COMMENT 'Name of the original equipment manufacturer (OEM) of the asset (e.g., Xylem, Grundfos, Flowserve, Siemens, ABB). Used for warranty management, spare parts procurement, and vendor performance analysis. Sourced from IBM Maximo manufacturer field.',
    `maximo_asset_num` STRING COMMENT 'The asset number as assigned and maintained in IBM Maximo Asset Management (CMMS). This is the operational cross-reference key used by maintenance crews and work order management. Must be unique within the Maximo instance.',
    `model_num` STRING COMMENT 'Manufacturers model or product number for the asset (e.g., LF 3196 STX, NK 65-200). Used for spare parts identification, technical documentation retrieval, and procurement of replacement units. Sourced from IBM Maximo model field.',
    `next_maintenance_date` DATE COMMENT 'Date on which the next scheduled preventive maintenance activity is due for this asset. Derived from the PM schedule and last maintenance date. Used for maintenance planning, resource scheduling, and compliance tracking in IBM Maximo.',
    `operational_status` STRING COMMENT 'Current operational lifecycle state of the asset. in_service indicates the asset is active and performing its intended function. standby indicates the asset is available but not currently operating. out_of_service indicates the asset is temporarily removed from service for maintenance or repair. decommissioned indicates permanent retirement. Drives maintenance scheduling and regulatory reporting. Ref: IBM Maximo.. Valid values are `in_service|out_of_service|standby|decommissioned|under_construction|abandoned`',
    `pipe_material` STRING COMMENT 'Material composition of the asset (e.g., Ductile Iron, PVC, HDPE, Cast Iron, Concrete, Stainless Steel, Copper). Critical for corrosion risk assessment, Lead and Copper Rule Revisions (LCRR) compliance, Cured-in-Place Pipe (CIPP) rehabilitation planning, and remaining useful life estimation. Applicable primarily to pipe and fitting assets.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Nameplate power rating of the asset in kilowatts (kW). Applicable to pumps, blowers, motors, generators, and other electrical equipment. Used for energy consumption analysis, Variable Frequency Drive (VFD) sizing, electrical load planning, and OPEX budgeting. Ref: IBM Maximo.',
    `pressure_zone` STRING COMMENT 'The hydraulic pressure zone or District Metered Area (DMA) in which the asset is located. Used for pressure management, Non-Revenue Water (NRW) analysis, and distribution network operations. Aligns with Innovyze InfoWater zone definitions and GIS pressure zone polygons. Ref: IBM Maximo.',
    `rated_capacity` DECIMAL(18,2) COMMENT 'The manufacturer-rated operational capacity of the asset expressed in the appropriate unit of measure (see capacity_unit field). For pumps: Gallons per Minute (GPM); for treatment units: Million Gallons per Day (MGD); for tanks: gallons. Used for capacity planning, hydraulic modeling, and performance benchmarking. Ref: IBM Maximo.',
    `regulatory_asset_code` STRING COMMENT 'Asset identifier assigned by a regulatory authority (e.g., state drinking water program, EPA) for compliance tracking and reporting purposes. Used in regulatory submissions such as the Consumer Confidence Report (CCR), Discharge Monitoring Report (DMR), and NPDES permit compliance documentation. Ref: IBM Maximo.',
    `replacement_cost` DECIMAL(18,2) COMMENT 'Current estimated cost to replace the asset with a new equivalent unit in US dollars. Updated periodically based on market pricing and engineering estimates. Used for Capital Improvement Program (CIP) budgeting, insurance valuation, and risk-based asset management decision-making. Ref: IBM Maximo.',
    `sap_equipment_num` STRING COMMENT 'The equipment number assigned in SAP Plant Maintenance (PM) module. Used for integration with SAP FI/CO for depreciation, CAPEX/OPEX tracking, and maintenance cost postings. Enables bidirectional synchronization between SAP PM and the asset registry. Ref: IBM Maximo.',
    `scada_tag` STRING COMMENT 'The Supervisory Control and Data Acquisition (SCADA) tag name used to identify this assets data point(s) in the OSIsoft PI Historian system. Enables linkage between the physical asset registry and real-time operational data streams for performance monitoring, alarm management, and predictive maintenance analytics.',
    `serial_num` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific asset unit. Used for warranty claims, recall tracking, and precise asset identification when multiple identical units exist. Sourced from IBM Maximo serial number field.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `warranty_expiry_date` DATE COMMENT 'Date on which the manufacturers warranty for the asset expires. Used to trigger warranty claim processes before expiry and to transition maintenance responsibility from warranty to O&M budget. Sourced from IBM Maximo warranty end date.',
    CONSTRAINT pk_registry PRIMARY KEY(`registry_id`)
) COMMENT 'Master record for every physical infrastructure asset owned or operated by the utility, including WTP/WWTP equipment, pipes, pumps, valves, electrical systems, meters, and vehicles. Captures asset identity, classification, installation details, location (GIS coordinates), manufacturer, model, serial number, asset tag, parent-child hierarchy, operational status, and lifecycle dates. This is the authoritative SSOT for all physical assets — the IBM Maximo asset master and SAP PM equipment master both synchronize to this record.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`class` (
    `class_id` BIGINT COMMENT 'Unique surrogate identifier for the asset class record in the enterprise asset management system. Primary key for the asset_class reference taxonomy. [ROLE: REFERENCE_LOOKUP — this entity is a reference taxonomy/classification table defining the hierarchy of utility asset types; per-role minimums are exempt, but MASTER_RESOURCE categories are applied for completeness given the entity carries rich business metadata beyond a simple code list.]. Ref: IBM Maximo.',
    `ami_applicable` BOOLEAN COMMENT 'Indicates whether assets of this class are part of the AMI/AMR metering infrastructure managed via the Sensus FlexNet AMI Platform. True for smart meters and communication endpoints; False for all other asset classes. Ref: IBM Maximo.',
    `asset_domain` STRING COMMENT 'Operational domain to which this asset class primarily belongs within the utility (e.g., Water Treatment, Water Distribution, Wastewater Collection, Wastewater Treatment, Metering, Fleet, Facilities, Cross-Domain). Drives domain-specific maintenance strategies and regulatory reporting alignment. [ENUM-REF-CANDIDATE: Water Treatment|Water Distribution|Wastewater Collection|Wastewater Treatment|Metering|Fleet|Facilities|Cross-Domain — promote to reference product]. Ref: IBM Maximo.',
    `capex_threshold_usd` DECIMAL(18,2) COMMENT 'Minimum acquisition or renewal cost in USD above which expenditures on assets of this class are capitalized as CAPEX rather than expensed as OPEX. Aligned with GAAP/GASB capitalization policies and SAP FI/CO asset accounting rules. Ref: IBM Maximo.',
    `cip_program_category` STRING COMMENT 'CIP program category under which capital renewal projects for assets of this class are budgeted and tracked. Aligns with the utilitys multi-year CIP planning structure in SAP PS and financial reporting to the Public Utilities Commission. [ENUM-REF-CANDIDATE: Water Supply|Water Treatment|Water Distribution|Wastewater Collection|Wastewater Treatment|Metering|Facilities|Fleet|Cross-Program — promote to reference product]. Ref: IBM Maximo.',
    `class_status` STRING COMMENT 'Current lifecycle status of the asset class record within the reference taxonomy. Active classes are available for new asset registrations; Deprecated classes are retained for historical assets but cannot be assigned to new assets. Ref: IBM Maximo.. Valid values are `Active|Inactive|Deprecated|Under Review`',
    `class_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the asset class within the enterprise taxonomy (e.g., MECH-PUMP, ELEC-TRANS, CIVIL-PIPE). Used as the externally-known business identifier in IBM Maximo, SAP PM, and GIS integrations.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `condition_assessment_method` STRING COMMENT 'Default method used to assess the physical condition of assets in this class. CIPP and pipe assets typically use CCTV; rotating equipment uses vibration analysis; distribution mains may use acoustic leak detection. Drives field inspection work order types in Maximo. [ENUM-REF-CANDIDATE: Visual Inspection|CCTV|Acoustic Leak Detection|Vibration Analysis|Ultrasonic Testing|Hydraulic Testing|SCADA Monitoring|Not Applicable — promote to reference product]. Ref: IBM Maximo.',
    `consequence_of_failure` STRING COMMENT 'Primary category of consequence if assets of this class fail. Drives risk-based maintenance prioritization and emergency response planning. [ENUM-REF-CANDIDATE: Service Interruption|Public Health Risk|Environmental Non-Compliance|Safety Hazard|Financial Loss|Reputational — promote to reference product]. Ref: IBM Maximo.. Valid values are `Service Interruption|Public Health Risk|Environmental Non-Compliance|Safety Hazard|Financial Loss|Reputational`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset class record was first created in the enterprise data platform. Supports audit trail and data lineage requirements. Ref: IBM Maximo.',
    `criticality_tier` STRING COMMENT 'Default criticality tier classification for assets of this class based on consequence of failure analysis. Critical assets (e.g., primary WTP pumps, transmission mains) receive highest maintenance priority and fastest response SLAs. Ref: IBM Maximo.. Valid values are `Critical|High|Medium|Low`',
    `criticality_weight` DECIMAL(18,2) COMMENT 'Numeric weighting factor (typically 0.00–10.00) applied to assets of this class during criticality assessment scoring. Higher values indicate greater consequence of failure on service delivery, public health, or regulatory compliance. Used in risk-based asset prioritization per ISO 55001.',
    `depreciation_method` STRING COMMENT 'Default accounting depreciation method applied to assets of this class for financial reporting purposes. Straight-Line is most common for utility infrastructure. Aligned with GAAP/GASB requirements for municipal utility financial statements. [ENUM-REF-CANDIDATE: Straight-Line|Declining Balance|Units of Production|Sum-of-Years-Digits|Modified Accelerated Cost Recovery — promote to reference product]. Ref: IBM Maximo.. Valid values are `Straight-Line|Declining Balance|Units of Production|Sum-of-Years-Digits|Modified Accelerated Cost Recovery`',
    `class_description` STRING COMMENT 'Detailed narrative description of the asset class, including its functional role within water or wastewater operations, typical installation context, and distinguishing characteristics from adjacent classes. Ref: IBM Maximo.',
    `effective_date` DATE COMMENT 'Date from which this asset class definition became effective and available for use in asset registrations. Supports temporal validity tracking of the reference taxonomy. Ref: IBM Maximo.',
    `environmental_risk_flag` BOOLEAN COMMENT 'Indicates whether failure of assets in this class poses a direct environmental risk requiring regulatory notification (e.g., SSO, CSO, chemical spill, NPDES permit exceedance). True triggers mandatory environmental incident reporting workflows. Ref: IBM Maximo.',
    `gis_feature_class` BOOLEAN COMMENT 'Corresponding feature class name in Esri ArcGIS geodatabase for assets of this class (e.g., wDistributionMain, wValve, wPump). Enables spatial analysis, network modeling in Innovyze InfoWater, and GIS-CMMS integration for field crew dispatch. Ref: IBM Maximo.',
    `gl_account_code` STRING COMMENT 'Default General Ledger account code in SAP FI/CO to which asset acquisitions, depreciation, and disposals for this class are posted. Ensures consistent financial reporting and CAPEX/OPEX tracking across the utility. Ref: IBM Maximo.. Valid values are `^[0-9]{6,10}$`',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this class within the classification hierarchy (1 = top-level category, 2 = sub-category, 3 = class, 4 = sub-class). Drives roll-up aggregation logic in CAPEX planning and maintenance reporting. Ref: IBM Maximo.',
    `inspection_frequency_days` STRING COMMENT 'Default interval in calendar days between mandatory regulatory or condition inspections for assets of this class. Distinct from PM frequency — this is driven by regulatory compliance requirements (e.g., EPA, state primacy agency mandates) rather than maintenance strategy. Ref: IBM Maximo.',
    `iso_55001_aligned` BOOLEAN COMMENT 'Indicates whether the maintenance strategy, criticality assessment, and lifecycle management approach for this asset class have been formally aligned with ISO 55001 Asset Management System requirements. Used for ISO certification audit evidence.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset class record was most recently modified in the enterprise data platform. Used for change tracking, data synchronization with source systems (Maximo, SAP), and audit compliance. Ref: IBM Maximo.',
    `lcrr_applicable` BOOLEAN COMMENT 'Indicates whether assets of this class are subject to EPA Lead and Copper Rule Revisions (LCRR) compliance requirements, such as lead service line inventory and replacement tracking. Applicable to service lines, connectors, and plumbing components.',
    `maintenance_strategy` STRING COMMENT 'Default O&M maintenance strategy applied to assets of this class in IBM Maximo CMMS. Drives automatic PM schedule generation. Preventive and Condition-Based strategies are typical for critical water infrastructure; Run-to-Failure may apply to low-criticality ancillary assets.. Valid values are `Preventive|Predictive|Corrective|Condition-Based|Run-to-Failure`',
    `material_standard` STRING COMMENT 'Default material specification or construction standard applicable to assets of this class (e.g., AWWA C900 PVC, AWWA C200 Steel, ASTM A536 Ductile Iron, HDPE ASTM D3035). Used in procurement specifications and asset registry for infrastructure renewal planning.',
    `maximo_class_code` STRING COMMENT 'Corresponding asset class identifier in IBM Maximo Asset Management CMMS. Used for bidirectional synchronization between the Silver Layer lakehouse and Maximo for work order generation, PM scheduling, and asset lifecycle management.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `mean_time_between_failures_days` DECIMAL(18,2) COMMENT 'Industry benchmark mean time between failures in days for assets of this class, used as a baseline for reliability-centered maintenance planning and failure probability modeling. Sourced from AWWA reliability benchmarks and historical Maximo work order data.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Industry benchmark mean time to repair in hours for assets of this class, used for SLA setting, crew resource planning, and service restoration time estimation. Sourced from AWWA benchmarks and historical Maximo corrective work order durations.',
    `class_name` STRING COMMENT 'Human-readable name of the asset class (e.g., Centrifugal Pump, Distribution Main Pipe, UV Disinfection Unit). Used in reports, work orders, and CAPEX planning documents. Ref: IBM Maximo.',
    `number_sap` STRING COMMENT 'Corresponding asset class number in SAP FI/CO Asset Accounting module (transaction AS02/AS03). Enables direct cross-reference between the enterprise data lakehouse and the SAP ERP system of record for financial reconciliation. Ref: IBM Maximo.. Valid values are `^[0-9]{4,8}$`',
    `pm_frequency_days` STRING COMMENT 'Default interval in calendar days between scheduled preventive maintenance activities for assets of this class. Used by IBM Maximo PM scheduling engine to auto-generate work orders. Overridable at the individual asset level.',
    `primary_category` STRING COMMENT 'Top-level classification grouping for the asset class aligned with standard utility asset taxonomy: Mechanical (pumps, blowers, mixers), Electrical (transformers, switchgear), Civil (pipes, structures, tanks), Instrumentation (sensors, meters, SCADA RTUs), Vehicle (fleet), Information Technology, or Other. [ENUM-REF-CANDIDATE: Mechanical|Electrical|Civil|Instrumentation|Vehicle|Information Technology|Other — promote to reference product]. Ref: IBM Maximo.',
    `renewal_strategy` STRING COMMENT 'Default end-of-life renewal strategy for assets of this class used in CIP planning. CIPP (Cured-in-Place Pipe) and trenchless methods are common for buried pipe rehabilitation; rotating equipment typically follows Replace-in-Kind or Upgrade strategies. Ref: IBM Maximo.. Valid values are `Replace-in-Kind|Upgrade|Rehabilitation|CIPP|Trenchless|Decommission`',
    `retirement_date` DATE COMMENT 'Date on which this asset class was retired or deprecated from the active taxonomy. Null for currently active classes. Retained for historical asset records that were registered under this class prior to retirement. Ref: IBM Maximo.',
    `safety_classification` STRING COMMENT 'Primary safety hazard classification for work activities on assets of this class. Drives OSHA-compliant safety permit requirements (e.g., confined space entry permits, lockout/tagout procedures) when generating work orders in Maximo.. Valid values are `Confined Space|Electrical Hazard|Chemical Hazard|High Pressure|Radiation|None`',
    `salvage_value_pct` DECIMAL(18,2) COMMENT 'Default residual/salvage value expressed as a percentage of original acquisition cost at end of useful life for assets in this class. Used in depreciation calculations and asset disposal planning within SAP FI/CO. Ref: IBM Maximo.',
    `scada_monitored` BOOLEAN COMMENT 'Indicates whether assets of this class are typically monitored via SCADA (Supervisory Control and Data Acquisition) systems integrated with OSIsoft PI Historian. True for pumps, valves, flow meters, and treatment equipment; False for passive civil assets such as buried pipes.',
    `size_unit_of_measure` STRING COMMENT 'Standard unit of measure used to express the principal sizing attribute for assets of this class (e.g., inches for pipe diameter, HP for pump motor horsepower, kVA for transformer capacity, GPM for flow capacity). Ensures consistent sizing data entry across the asset registry. [ENUM-REF-CANDIDATE: inches|mm|feet|meters|kVA|HP|kW|GPM|MGD|gallons|cubic feet — promote to reference product]. Ref: IBM Maximo.',
    `spare_parts_required` BOOLEAN COMMENT 'Indicates whether assets of this class typically require dedicated spare parts inventory to be maintained in the storeroom (SAP MM / Maximo Inventory). True for critical rotating equipment and instrumentation; False for passive civil assets. Ref: IBM Maximo.',
    `ssot_entity_role` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: IBM Maximo.',
    `ssot_resolution_type` STRING COMMENT 'The ssot resolution type value recorded for each asset class in the asset domain.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'The ssot sync timestamp associated with each asset class record in the asset domain.',
    `useful_life_years` STRING COMMENT 'Default expected useful life in years for assets belonging to this class, used as the baseline for depreciation schedules, CAPEX renewal planning, and CIP prioritization. Can be overridden at the individual asset level. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `work_order_type_default` STRING COMMENT 'Default work order type generated in IBM Maximo for assets of this class when a maintenance event is triggered. Drives labor planning, cost coding, and CAPEX vs OPEX classification of maintenance expenditures.. Valid values are `Preventive Maintenance|Corrective Maintenance|Inspection|Emergency Repair|Capital Renewal|Rehabilitation`',
    CONSTRAINT pk_class PRIMARY KEY(`class_id`)
) COMMENT 'Reference taxonomy defining the classification hierarchy for utility assets (e.g., Mechanical, Electrical, Civil, Instrumentation, Vehicle). Each class carries default useful life, depreciation method, maintenance strategy, criticality weighting rules, and applicable regulatory standards. Used to drive preventive maintenance scheduling, CAPEX planning, and ISO 55001 asset management framework alignment. [SSOT: Canonical source of truth for this concept across domains.] Differentiated: asset_class is physical asset taxonomy (not customer service tier).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`location` (
    `location_id` BIGINT COMMENT 'Unique identifier for the asset location record. Primary key. Ref: IBM Maximo.',
    `facility_id` BIGINT COMMENT 'Reference to the top-level facility (WTP, WWTP, pump station) where this location resides. Ref: IBM Maximo.',
    `parent_location_id` BIGINT COMMENT 'Reference to the parent location in the hierarchical location structure (e.g., a rooms parent is a floor, a floors parent is a building). Ref: IBM Maximo.',
    `access_restrictions` STRING COMMENT 'Description of physical or security access restrictions for the location (e.g., Restricted - Badge Required, Public Access, Confined Space). Ref: IBM Maximo.',
    `address_line_1` STRING COMMENT 'Primary street address of the location. Organizational contact data classified as confidential. Ref: IBM Maximo.',
    `address_line_2` STRING COMMENT 'Secondary address information (suite, unit, building number). Organizational contact data classified as confidential. Ref: IBM Maximo.',
    `area_square_feet` DECIMAL(18,2) COMMENT 'Physical area of the location in square feet, used for space planning and asset density analysis. Ref: IBM Maximo.',
    `capacity_rating` DECIMAL(18,2) COMMENT 'Rated capacity of the location for asset storage or operational throughput (e.g., MGD for treatment facilities, gallons for storage tanks). Ref: IBM Maximo.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the capacity rating (e.g., Million Gallons per Day (MGD), Gallons per Minute (GPM), gallons, cubic meters). Ref: IBM Maximo.. Valid values are `mgd|gpm|gallons|cubic_meters|units`',
    `city` STRING COMMENT 'City or municipality where the location is situated. Ref: IBM Maximo.',
    `location_code` STRING COMMENT 'Business identifier code for the location, used for operational reference and integration with IBM Maximo CMMS and SAP PM systems.. Valid values are `^[A-Z0-9]{4,20}$`',
    `country_code` STRING COMMENT 'Three-letter ISO country code (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created in the system. Ref: IBM Maximo.',
    `location_description` STRING COMMENT 'Detailed description of the location, including physical characteristics, purpose, and operational context. Ref: IBM Maximo.',
    `dma_zone` STRING COMMENT 'District Metered Area zone identifier for water distribution network segmentation and Non-Revenue Water (NRW) analysis. Ref: IBM Maximo.',
    `effective_end_date` DATE COMMENT 'Date when the location was decommissioned or removed from active service (null for active locations). Ref: IBM Maximo.',
    `effective_start_date` DATE COMMENT 'Date when the location became operational or was added to the asset registry. Ref: IBM Maximo.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation above sea level in feet, used for hydraulic modeling and pressure zone analysis. Ref: IBM Maximo.',
    `environmental_conditions` STRING COMMENT 'Description of environmental conditions at the location (e.g., Indoor Climate Controlled, Outdoor Exposed, Wet Environment, Corrosive Atmosphere). Ref: IBM Maximo.',
    `floor_level` STRING COMMENT 'Floor or level number within a building (e.g., 1 for ground floor, 2 for second floor, -1 for basement). Ref: IBM Maximo.',
    `gis_feature_code` BOOLEAN COMMENT 'Unique feature identifier in the Esri ArcGIS system for spatial data integration and network topology analysis. Ref: IBM Maximo.',
    `hazard_classification` STRING COMMENT 'Safety hazard classification for the location (e.g., Confined Space, High Voltage, Chemical Storage, None). Ref: IBM Maximo.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was last updated or modified. Ref: IBM Maximo.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees for GIS integration with Esri ArcGIS. Ref: IBM Maximo.',
    `location_status` STRING COMMENT 'Current operational status of the location in its lifecycle. Ref: IBM Maximo.. Valid values are `active|inactive|under_construction|decommissioned|temporary`',
    `location_type` STRING COMMENT 'Classification of the location type within the asset hierarchy. Ref: IBM Maximo.. Valid values are `facility|building|floor|room|outdoor_site|storage_yard`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees for GIS integration with Esri ArcGIS. Ref: IBM Maximo.',
    `maximo_location_code` STRING COMMENT 'Location identifier in IBM Maximo CMMS for work order management and maintenance routing integration.',
    `location_name` STRING COMMENT 'Human-readable name of the asset location (e.g., Main Street Pump Station, North WTP Filter Building). Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Additional notes or comments about the location for operational reference and maintenance planning. Ref: IBM Maximo.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the location. Organizational contact data classified as confidential. Ref: IBM Maximo.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `pressure_zone` STRING COMMENT 'Pressure zone designation for hydraulic modeling and distribution network operations, typically defined by elevation and Pressure Reducing Valve (PRV) boundaries. Ref: IBM Maximo.',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory jurisdiction or primacy agency responsible for oversight (e.g., state EPA, local health department). Ref: IBM Maximo.',
    `room_number` STRING COMMENT 'Room or space identifier within a floor or building (e.g., Room 101, Electrical Vault A). Ref: IBM Maximo.',
    `sap_functional_location` STRING COMMENT 'SAP PM functional location code for asset hierarchy and maintenance planning integration. Ref: IBM Maximo.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether the location is integrated with SCADA systems (OSIsoft PI Historian) for real-time monitoring and control.',
    `service_territory` STRING COMMENT 'Service territory or jurisdiction code defining the geographic area served by the utility. Ref: IBM Maximo.',
    `spatial_reference_code` STRING COMMENT 'Coordinate system reference identifier (EPSG code) used for GIS spatial data (e.g., EPSG:4326 for WGS 84). Ref: IBM Maximo.',
    `state_province` STRING COMMENT 'Two-letter state or province code (e.g., CA, TX, NY). Ref: IBM Maximo.. Valid values are `^[A-Z]{2}$`',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each location in the asset domain.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `watershed` STRING COMMENT 'Watershed or drainage basin identifier for regulatory reporting and environmental compliance under the Clean Water Act (CWA). Ref: IBM Maximo.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Hierarchical location registry defining where assets are physically installed or stored — from service territory down to facility, building, floor, room, and GIS coordinate. Supports Esri ArcGIS integration with spatial reference data (latitude, longitude, elevation, DMA zone, pressure zone, watershed). Enables location-based maintenance routing, network topology analysis, and regulatory reporting by geographic jurisdiction.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` (
    `condition_assessment_id` BIGINT COMMENT 'Unique identifier for the condition assessment record. Primary key. Ref: IBM Maximo.',
    `location_id` BIGINT COMMENT 'Reference to the asset location in the Geographic Information System (GIS), enabling spatial analysis and mapping of condition assessment results. Ref: IBM Maximo.',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: A condition assessment is formally produced as the scored output of a physical inspection event. In water utility asset management, an inspection_event captures the operational act of inspection (who,',
    `registry_id` BIGINT COMMENT 'Reference to the infrastructure asset being assessed (pipe, pump, valve, treatment equipment, vehicle, etc.). Ref: IBM Maximo.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Condition assessments are mandated by specific regulatory requirements (AWIA 2018 risk assessments, state inspection programs). condition_assessment.compliance_standard is a denormalized reference rep',
    `work_order_id` BIGINT COMMENT 'Reference to the work order under which this condition assessment was performed, if applicable. Ref: IBM Maximo.',
    `approved_date` DATE COMMENT 'Date when the assessment was formally approved by management. Ref: IBM Maximo.',
    `assessment_date` DATE COMMENT 'The date on which the condition assessment was performed in the field. Ref: IBM Maximo.',
    `assessment_interval_months` STRING COMMENT 'Standard inspection frequency interval in months for this asset type and condition grade. Ref: IBM Maximo.',
    `assessment_method` STRING COMMENT 'The inspection or testing method used to assess asset condition. Common methods include visual inspection, Closed-Circuit Television (CCTV) for pipes, acoustic leak detection, vibration analysis for rotating equipment, ultrasonic thickness measurement for corrosion, infrared thermography for electrical systems, and various hydraulic testing methods. [ENUM-REF-CANDIDATE: visual|cctv|acoustic|vibration_analysis|ultrasonic_thickness|infrared_thermography|dye_testing|smoke_testing|pressure_testing|flow_testing|electrical_testing|corrosion_survey — 12 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `assessment_number` STRING COMMENT 'Business identifier for the condition assessment, typically generated by the Computerized Maintenance Management System (CMMS) or inspection system. Ref: IBM Maximo.',
    `assessment_status` STRING COMMENT 'Current workflow status of the condition assessment record: scheduled, in progress, completed (field work done), reviewed (technical review complete), approved (management sign-off), or cancelled. Ref: IBM Maximo.. Valid values are `scheduled|in_progress|completed|reviewed|approved|cancelled`',
    `assessment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the condition assessment was completed, including time zone information. Ref: IBM Maximo.',
    `assessment_type` STRING COMMENT 'Classification of the assessment purpose: routine scheduled inspection, preventive maintenance assessment, reactive inspection following an incident, condition-based monitoring, regulatory compliance inspection, pre-failure investigation, post-repair verification, or new asset commissioning. [ENUM-REF-CANDIDATE: routine|preventive|reactive|condition_based|regulatory|pre_failure|post_repair|commissioning — 8 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `condition_grade` STRING COMMENT 'Standardized condition rating on a 1-5 scale per American Water Works Association (AWWA) and Water Research Foundation (WRF) standards, where 1 = Excellent/New, 2 = Good/Minor Defects, 3 = Fair/Moderate Defects, 4 = Poor/Significant Defects, 5 = Very Poor/Critical/Imminent Failure.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this condition assessment record was first created in the Computerized Maintenance Management System (CMMS). Ref: IBM Maximo.',
    `critical_defect_count` STRING COMMENT 'Number of critical or high-severity defects requiring immediate attention or corrective action. Ref: IBM Maximo.',
    `criticality_rating` STRING COMMENT 'Business criticality classification of the asset based on consequence of failure analysis, considering service impact, public health risk, environmental impact, and financial exposure. Ref: IBM Maximo.. Valid values are `critical|high|medium|low`',
    `defect_count` STRING COMMENT 'Total number of defects, anomalies, or non-conformances identified during the condition assessment. Ref: IBM Maximo.',
    `defect_description` STRING COMMENT 'Detailed narrative description of defects, damage, deterioration, or performance issues observed during the assessment. Ref: IBM Maximo.',
    `environmental_conditions` STRING COMMENT 'Environmental factors that may affect assessment results or asset condition (e.g., soil conditions, groundwater level, chemical exposure, temperature extremes). Ref: IBM Maximo.',
    `estimated_repair_cost` DECIMAL(18,2) COMMENT 'Preliminary cost estimate for recommended repair or rehabilitation work, used for Capital Expenditure (CAPEX) and Operating Expenditure (OPEX) planning. Ref: IBM Maximo.',
    `estimated_replacement_cost` DECIMAL(18,2) COMMENT 'Estimated cost to fully replace the asset with equivalent new equipment or infrastructure. Ref: IBM Maximo.',
    `failure_probability` DECIMAL(18,2) COMMENT 'Statistical probability (0.0000 to 1.0000) of asset failure within the next planning period, calculated from condition data, age, and historical failure rates. Ref: IBM Maximo.',
    `inspection_equipment_used` STRING COMMENT 'Description of specialized equipment, instruments, or tools used during the assessment (e.g., CCTV crawler, ultrasonic thickness gauge, vibration analyzer, acoustic leak detector). Ref: IBM Maximo.',
    `inspector_certification` STRING COMMENT 'Professional certifications held by the inspector relevant to the assessment method (e.g., NASSCO PACP/MACP/LACP for pipeline inspection, ASNT Level II for ultrasonic testing, thermography certification). Ref: IBM Maximo.',
    `inspector_name` STRING COMMENT 'Full name of the inspector or technician who conducted the assessment. Ref: IBM Maximo.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the assessment location. Ref: IBM Maximo.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the assessment location. Ref: IBM Maximo.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this condition assessment record was last updated. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next condition assessment based on asset criticality, condition grade, and inspection frequency requirements. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Additional observations, comments, or contextual information recorded by the inspector during the assessment. Ref: IBM Maximo.',
    `performance_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100 scale) representing the operational performance and efficiency of the asset relative to design specifications. Ref: IBM Maximo.',
    `recommended_action` STRING COMMENT 'Recommended intervention strategy based on assessment findings: continue monitoring, schedule repair, plan rehabilitation, schedule replacement, no action required, or emergency repair needed. Ref: IBM Maximo.. Valid values are `monitor|repair|rehabilitate|replace|no_action|emergency_repair`',
    `recommended_action_priority` STRING COMMENT 'Priority level for the recommended intervention: immediate (0-30 days), urgent (1-6 months), high (6-12 months), medium (1-3 years), low (3+ years). Ref: IBM Maximo.. Valid values are `immediate|urgent|high|medium|low`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this assessment was performed to satisfy regulatory inspection requirements from Environmental Protection Agency (EPA), state primacy agencies, or other governing bodies. Ref: IBM Maximo.',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Estimated number of years the asset can continue to operate before requiring major rehabilitation or replacement, based on current condition and deterioration rate. Ref: IBM Maximo.',
    `reviewed_date` DATE COMMENT 'Date when the assessment was reviewed and validated by a supervisor or subject matter expert.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score calculated as the product of failure probability and consequence of failure, used to prioritize asset renewal and Capital Improvement Program (CIP) planning. Ref: IBM Maximo.',
    `structural_integrity_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100 scale) representing the structural soundness of the asset based on inspection findings. Higher scores indicate better structural condition. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of assessment, relevant for outdoor inspections and certain testing methods. Ref: IBM Maximo.',
    CONSTRAINT pk_condition_assessment PRIMARY KEY(`condition_assessment_id`)
) COMMENT 'Records the results of all formal assessments and inspections performed on infrastructure assets, encompassing both scored condition evaluations (condition grade 1-5 per AWWA/WRF standards, structural integrity score, remaining useful life estimate, failure probability) and regulatory/compliance inspections (EPA, state primacy agency, OSHA requirements). Captures assessment date, type (condition-scoring, regulatory-compliance, routine-operational, post-incident, pre-commissioning), method (visual, CCTV, acoustic, vibration analysis, ultrasonic thickness, leak detection), inspector identity and certification, checklist/protocol used, pass/fail outcome, deficiencies identified, corrective action required flag, recommended intervention, and regulatory permit reference. A single unified record for any event where an asset is formally evaluated — whether for condition scoring, compliance verification, or operational readiness. Drives asset renewal prioritization, CIP planning, regulatory inspection compliance tracking, and OSHA safety audit evidence. Integrates with IBM Maximo inspection records and supports EPA/state primacy agency reporting requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the work order record. Primary key. Ref: IBM Maximo.',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: Return-to-service protocols require analytical results confirming water quality clearance before restoring service after pipe repair or maintenance. Role-prefix clearance_ distinguishes this from th',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Work orders for permitted activities (construction, excavation, discharge) must reference the applicable permit. work_order.permit_required flag confirms permit-linked work exists. Permit managers nee',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Enforcement actions (consent orders, administrative orders) mandate specific remediation work with deadlines. Work orders must reference enforcement actions to track compliance schedule milestones, re. Ref: IBM Maximo.',
    `location_id` BIGINT COMMENT 'Reference to the functional location or site where the work is performed (Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), pump station, District Metered Area (DMA)). Ref: IBM Maximo.',
    `pm_schedule_id` BIGINT COMMENT 'Reference to the preventive maintenance schedule or route that generated this work order, if applicable. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset (pipe, pump, valve, treatment equipment, vehicle) that is the subject of this work order. Ref: IBM Maximo.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Ad-hoc regulatory work orders (consent order repairs, mandated replacements) must reference the specific regulatory requirement that triggered them — independent of any PM schedule. work_order.regulat',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Work orders require service address for crew dispatch, customer contact, access instructions, and completion documentation. Essential for field operations, customer communication, and GIS-based work o. Ref: IBM Maximo.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Work orders for meter replacements, service reconnections, and new connections are executed under a specific service agreement. This link enables billing of work order costs to the correct agreement, ',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred for the work order, including labor, materials, contractor services, and overhead allocations. Ref: IBM Maximo.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when work execution was completed in the field. Ref: IBM Maximo.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours actually expended on the work order, captured from time sheets and labor transactions. Ref: IBM Maximo.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work execution began in the field. Ref: IBM Maximo.',
    `approved_by` STRING COMMENT 'Name or identifier of the supervisor or manager who approved the work order for execution or closure.',
    `assigned_to` STRING COMMENT 'Name or identifier of the technician, crew, or contractor assigned to execute the work order. Ref: IBM Maximo.',
    `cause_code` STRING COMMENT 'Standardized code identifying the root cause of the failure (e.g., corrosion, age, improper operation, design defect). Ref: IBM Maximo.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was formally closed and moved to historical status. Ref: IBM Maximo.',
    `completion_notes` STRING COMMENT 'Detailed narrative entered by the technician upon work completion, documenting findings, actions taken, parts replaced, and any follow-up recommendations. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was first created in the Computerized Maintenance Management System (CMMS). Ref: IBM Maximo.',
    `work_order_description` STRING COMMENT 'Detailed narrative description of the work to be performed, including scope, objectives, and any special instructions or safety considerations. Ref: IBM Maximo.',
    `downtime_duration_hours` DECIMAL(18,2) COMMENT 'Total hours the asset was out of service or unavailable due to this maintenance activity, critical for calculating Mean Time Between Failures (MTBF) and Mean Time To Repair (MTTR) Key Performance Indicators (KPIs). Ref: IBM Maximo.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Planned total cost for the work order including labor, materials, and services, used for budgeting and Capital Expenditure (CAPEX) / Operating Expenditure (OPEX) planning. Ref: IBM Maximo.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Planned total labor hours required to complete the work order, used for resource planning and scheduling. Ref: IBM Maximo.',
    `failure_code` STRING COMMENT 'Standardized code identifying the type of failure or problem that triggered the work order (e.g., leak, blockage, electrical fault, mechanical wear). Ref: IBM Maximo.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was last updated or modified. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `permit_required` BOOLEAN COMMENT 'Indicates whether regulatory permits (confined space entry, hot work, excavation, discharge) are required before work can commence. Ref: IBM Maximo.',
    `priority` STRING COMMENT 'Business priority level indicating urgency and impact of the work order on operations, safety, and regulatory compliance. Ref: IBM Maximo.. Valid values are `critical|high|medium|low`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this work order is driven by regulatory compliance requirements (Safe Drinking Water Act (SDWA), Clean Water Act (CWA), National Pollutant Discharge Elimination System (NPDES), Lead and Copper Rule Revisions (LCRR)).',
    `remedy_code` STRING COMMENT 'Standardized code identifying the corrective action taken to resolve the failure (e.g., repair, replace, adjust, clean). Ref: IBM Maximo.',
    `reported_date` DATE COMMENT 'Date when the work need was first reported or identified. Ref: IBM Maximo.',
    `safety_plan_required` BOOLEAN COMMENT 'Indicates whether a formal safety plan, Job Safety Analysis (JSA), or Occupational Safety and Health Administration (OSHA) compliance documentation is required for this work order.',
    `scheduled_finish_date` DATE COMMENT 'Planned date when work is scheduled to be completed. Ref: IBM Maximo.',
    `scheduled_start_date` DATE COMMENT 'Planned date when work is scheduled to begin. Ref: IBM Maximo.',
    `source` STRING COMMENT 'Origin or trigger that created the work order (preventive maintenance schedule, Supervisory Control and Data Acquisition (SCADA) alarm, customer complaint, inspection finding, operator observation, predictive analytics model, regulatory mandate). [ENUM-REF-CANDIDATE: pm_schedule|scada_alarm|customer_complaint|inspection|operator_round|predictive_analytics|regulatory_requirement — 7 candidates stripped; promote to reference product]',
    `supervisor_approval_date` DATE COMMENT 'Date when the work order was reviewed and approved by the maintenance supervisor or manager.',
    `vibe_added_flag` BOOLEAN COMMENT 'The vibe added flag value recorded for each work order in the asset domain.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `warranty_claim` BOOLEAN COMMENT 'Indicates whether this work order is associated with a warranty claim against a vendor or contractor for defective equipment or workmanship. Ref: IBM Maximo.',
    `work_order_number` STRING COMMENT 'Externally visible business identifier for the work order, typically human-readable and used in field operations and reporting. Ref: IBM Maximo.',
    `work_order_status` STRING COMMENT 'Current lifecycle status of the work order in the maintenance workflow, from creation through completion and closure. [ENUM-REF-CANDIDATE: draft|approved|scheduled|in_progress|on_hold|completed|closed|cancelled — 8 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `work_order_type` STRING COMMENT 'Classification of the work order by maintenance strategy: preventive maintenance (PM), corrective maintenance (CM), predictive maintenance (PdM), emergency, inspection, calibration, or capital project work. [ENUM-REF-CANDIDATE: preventive_maintenance|corrective_maintenance|predictive_maintenance|emergency|inspection|calibration|project — 7 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Core transactional record for all maintenance activities — preventive (PM), corrective (CM), predictive (PdM), and emergency work orders. Captures work type, priority, originating asset, assigned crew/technician, scheduled and actual start/finish dates, labor hours, failure code, cause code, remedy code, downtime duration, and work order cost. Includes material line items: parts consumed or reserved with quantity, unit cost, issue date, storeroom, and reservation status. Enables actual vs. planned cost tracking (labor, material, contractor/service, overhead) per work order with GL account code and cost center. The authoritative SSOT for maintenance execution and O&M cost accounting, synchronized with IBM Maximo Work Order and SAP PM Order. Supports rate case cost justification and AWWA benchmarking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record. Ref: IBM Maximo.',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Preventive maintenance schedules in water utilities are typically defined at the asset class level — all pumps of a given class receive quarterly PM, all valves receive annual inspection, etc. The ass',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), pumping station, or other facility where the asset is located and the preventive maintenance will be performed. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset (equipment, pipe, pump, valve, vehicle) to which this preventive maintenance schedule applies. Ref: IBM Maximo.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory requirements drive PM schedules (monthly chlorine residual checks per permit, quarterly backwash inspections per state rules). Links maintenance planning to compliance obligations, ensures. Ref: IBM Maximo.',
    `asset_criticality_rating` STRING COMMENT 'Criticality classification of the asset to which this schedule applies, indicating the impact of asset failure on operations, safety, regulatory compliance, or customer service. Ref: IBM Maximo.. Valid values are `critical|essential|important|standard`',
    `auto_generate_work_order_flag` BOOLEAN COMMENT 'Indicates whether work orders should be automatically generated by the CMMS system when the schedule becomes due, or whether manual review and approval is required before work order creation. Ref: IBM Maximo.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which preventive maintenance costs should be allocated for accounting and budgeting purposes. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this preventive maintenance schedule record was first created in the CMMS system. Ref: IBM Maximo.',
    `downtime_required_flag` BOOLEAN COMMENT 'Indicates whether the asset must be taken out of service (downtime) to perform the preventive maintenance task, requiring operational planning and backup capacity arrangements. Ref: IBM Maximo.',
    `effective_end_date` DATE COMMENT 'Date when this preventive maintenance schedule expires or is deactivated, after which no further work orders will be generated. Null indicates an open-ended schedule. Ref: IBM Maximo.',
    `effective_start_date` DATE COMMENT 'Date when this preventive maintenance schedule becomes active and begins generating work orders. Ref: IBM Maximo.',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that the asset will be out of service during preventive maintenance, used for operational planning and redundancy management. Ref: IBM Maximo.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Estimated cost of labor required to complete the preventive maintenance task based on estimated hours and labor rates, used for budgeting and OPEX planning. Ref: IBM Maximo.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete the preventive maintenance task, used for workforce planning and scheduling. Ref: IBM Maximo.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Estimated cost of materials, parts, and consumables required to complete the preventive maintenance task, used for budgeting and OPEX planning. Ref: IBM Maximo.',
    `frequency_interval` STRING COMMENT 'Numeric value representing the interval between preventive maintenance occurrences, interpreted based on the frequency unit (e.g., 30 for days, 500 for hours, 1000 for gallons). Ref: IBM Maximo.',
    `frequency_unit` STRING COMMENT 'Unit of measure for the frequency interval, defining whether the schedule is based on time periods (days, weeks, months, years), operating hours, operational cycles, or volume processed (gallons, cubic meters). [ENUM-REF-CANDIDATE: days|weeks|months|years|hours|cycles|gallons|cubic_meters — 8 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `gl_account_code` STRING COMMENT 'General ledger account code for recording preventive maintenance expenses in the financial system, distinguishing between OPEX maintenance and CAPEX capital improvements. Ref: IBM Maximo.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this preventive maintenance schedule record. Ref: IBM Maximo.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this preventive maintenance schedule record was last modified in the CMMS system. Ref: IBM Maximo.',
    `last_performed_date` DATE COMMENT 'Date when the preventive maintenance task was last completed, used to calculate the next due date for calendar-based schedules. Ref: IBM Maximo.',
    `lead_time_days` STRING COMMENT 'Number of days before the next due date that the work order should be generated to allow for planning, scheduling, and resource allocation. Ref: IBM Maximo.',
    `maintenance_task_description` STRING COMMENT 'Detailed description of the preventive maintenance task to be performed, including specific procedures, inspections, or servicing activities required. Ref: IBM Maximo.',
    `meter_threshold` DECIMAL(18,2) COMMENT 'Threshold value for meter-based preventive maintenance triggers; when the asset meter reading reaches or exceeds this value, a work order is automatically generated. Ref: IBM Maximo.',
    `meter_type` STRING COMMENT 'Type of meter or measurement used for meter-based preventive maintenance triggers, such as operating hours, flow volume, pressure cycles, or other asset-specific usage metrics. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `next_due_date` DATE COMMENT 'Calculated date when the next preventive maintenance work order should be generated based on the schedule frequency and last performed date. Ref: IBM Maximo.',
    `priority` STRING COMMENT 'Priority level assigned to the preventive maintenance schedule based on asset criticality, regulatory requirements, or operational impact, used to sequence work order execution. Ref: IBM Maximo.. Valid values are `critical|high|medium|low`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this preventive maintenance schedule is required to meet regulatory compliance obligations such as EPA Safe Drinking Water Act (SDWA), Clean Water Act (CWA), NPDES permit conditions, or state-level inspection requirements. Ref: IBM Maximo.',
    `regulatory_reference` STRING COMMENT 'Citation or reference to the specific regulatory requirement, permit condition, or compliance standard that mandates this preventive maintenance activity (e.g., SDWA Section 1412, NPDES Permit Condition 3.2). Ref: IBM Maximo.',
    `required_skill_certifications` STRING COMMENT 'Comma-separated list of required skill certifications or qualifications that technicians must possess to perform this preventive maintenance task safely and effectively (e.g., electrical license, confined space entry, SCADA operator certification). Ref: IBM Maximo.',
    `safety_requirements` STRING COMMENT 'Description of safety precautions, personal protective equipment (PPE), lockout/tagout procedures, confined space entry protocols, or other safety measures required for this preventive maintenance task. Ref: IBM Maximo.',
    `schedule_name` STRING COMMENT 'Descriptive name of the preventive maintenance schedule for easy identification by operations and maintenance staff. Ref: IBM Maximo.',
    `schedule_number` STRING COMMENT 'Business identifier for the preventive maintenance schedule, typically assigned by the CMMS system for tracking and reporting purposes. Ref: IBM Maximo.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the preventive maintenance schedule indicating whether it is actively generating work orders or has been suspended or deactivated. Ref: IBM Maximo.. Valid values are `active|inactive|suspended|draft|expired`',
    `seasonal_end_month` STRING COMMENT 'Month number (1-12) when seasonal preventive maintenance schedule becomes inactive, applicable only when seasonal_schedule_flag is true. Ref: IBM Maximo.',
    `seasonal_schedule_flag` BOOLEAN COMMENT 'Indicates whether this preventive maintenance schedule is seasonal in nature, applicable only during specific months or seasons (e.g., winterization of outdoor equipment, summer peak demand preparation). Ref: IBM Maximo.',
    `seasonal_start_month` STRING COMMENT 'Month number (1-12) when seasonal preventive maintenance schedule becomes active, applicable only when seasonal_schedule_flag is true. Ref: IBM Maximo.',
    `trigger_type` STRING COMMENT 'Type of trigger mechanism that determines when preventive maintenance is due: calendar-based (time intervals), meter-based (usage thresholds), condition-based (sensor readings), runtime-based (operating hours), or cycle-based (number of operations). Ref: IBM Maximo.. Valid values are `calendar|meter|condition|runtime|cycle`',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `work_order_type` STRING COMMENT 'Classification of the work order that will be generated from this schedule, indicating the nature of the maintenance activity (preventive maintenance, inspection, calibration, lubrication, cleaning). Ref: IBM Maximo.. Valid values are `preventive|inspection|calibration|lubrication|cleaning`',
    `work_zone` STRING COMMENT 'Specific work zone, area, or department within the facility where the preventive maintenance activity will take place, used for crew assignment and access control. Ref: IBM Maximo.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this preventive maintenance schedule record in the CMMS system. Ref: IBM Maximo.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Defines preventive maintenance schedules for assets, including maintenance task description, trigger type (calendar-based, meter-based, condition-based), frequency or interval, last performed date, next due date, estimated labor hours, required skill certifications, and associated job plan. Drives automatic work order generation in IBM Maximo. Supports AWWA O&M best practices and regulatory inspection compliance requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` (
    `failure_record_id` BIGINT COMMENT 'Unique identifier for the asset failure event record. Primary key. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset that experienced the failure (equipment, pipe, pump, valve, etc.). Ref: IBM Maximo.',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: failure_record.sso_event_flag and overflow_volume_gallons indicate sewer-related failures. Linking failure records directly to sewer network segments enables MTBF analysis by pipe segment, rehabilitat',
    `work_order_id` BIGINT COMMENT 'Reference to the corrective maintenance work order generated in response to this failure event. Ref: IBM Maximo.',
    `actual_repair_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred to repair or replace the failed asset after work completion. Ref: IBM Maximo.',
    `affected_system` STRING COMMENT 'The operational system or process affected by the failure (e.g., high service pump station, chlorination system, SCADA network, distribution main). Ref: IBM Maximo.',
    `corrective_actions_recommended` STRING COMMENT 'List of recommended corrective and preventive actions to prevent recurrence of similar failures. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this failure record was first created in the system. Ref: IBM Maximo.',
    `cso_event_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure resulted in a Combined Sewer Overflow event requiring regulatory reporting. Ref: IBM Maximo.',
    `customers_affected_count` STRING COMMENT 'Count of customer accounts impacted by the failure event (service interruption, pressure loss, water quality issue). Ref: IBM Maximo.',
    `detection_method` STRING COMMENT 'Method by which the failure was discovered (SCADA alarm, operator inspection, customer complaint, etc.). [ENUM-REF-CANDIDATE: scada_alarm|operator_inspection|customer_complaint|scheduled_inspection|predictive_maintenance|routine_testing|emergency_response — 7 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `downtime_duration_hours` DECIMAL(18,2) COMMENT 'Total duration in hours that the asset was out of service due to the failure. Ref: IBM Maximo.',
    `emergency_response_actions` STRING COMMENT 'Detailed description of immediate emergency response actions taken to mitigate the failure (e.g., valve isolation, backup system activation, customer notification).',
    `environmental_impact_description` STRING COMMENT 'Description of any environmental impact resulting from the failure (e.g., water body contamination, soil contamination, habitat damage). Ref: IBM Maximo.',
    `failure_cause` STRING COMMENT 'Identified root cause of the failure (e.g., age-related deterioration, improper installation, inadequate maintenance, design deficiency, operational error, external damage). Ref: IBM Maximo.',
    `failure_criticality_score` STRING COMMENT 'Calculated criticality score based on failure severity, service impact, and asset importance (typically 1-100 scale). Ref: IBM Maximo.',
    `failure_date` DATE COMMENT 'Calendar date when the asset failure occurred. Ref: IBM Maximo.',
    `failure_effect` STRING COMMENT 'Description of the operational impact and consequences of the failure on system performance and service delivery. Ref: IBM Maximo.',
    `failure_mode` STRING COMMENT 'Classification of how the asset failed (e.g., mechanical fracture, electrical short, corrosion perforation, seal leakage, bearing seizure, control malfunction). Ref: IBM Maximo.',
    `failure_number` STRING COMMENT 'Business-readable unique identifier for the failure event, typically auto-generated by CMMS. Ref: IBM Maximo.',
    `failure_severity` STRING COMMENT 'Severity classification of the failure based on service impact, safety risk, and regulatory implications. Ref: IBM Maximo.. Valid values are `critical|major|moderate|minor`',
    `failure_status` STRING COMMENT 'Current lifecycle status of the failure record in the investigation and resolution workflow. Ref: IBM Maximo.. Valid values are `reported|under_investigation|rca_in_progress|corrective_action_pending|resolved|closed`',
    `failure_time` TIMESTAMP COMMENT 'Precise date and time when the asset failure was detected or occurred. Ref: IBM Maximo.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this failure record was last updated or modified. Ref: IBM Maximo.',
    `mtbf_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this failure event should be included in MTBF reliability calculations for the asset class. Ref: IBM Maximo.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Measured time in hours from failure detection to restoration of asset to full operational status. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context related to the failure event. Ref: IBM Maximo.',
    `overflow_volume_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of wastewater overflow in gallons resulting from SSO or CSO event, if applicable. Ref: IBM Maximo.',
    `pressure_drop_psi` DECIMAL(18,2) COMMENT 'Measured drop in system pressure (PSI) resulting from the failure event. Ref: IBM Maximo.',
    `production_loss_mgd` DECIMAL(18,2) COMMENT 'Estimated water production capacity lost due to the failure, measured in Million Gallons per Day. Ref: IBM Maximo.',
    `regulatory_notification_date` DATE COMMENT 'Date when regulatory agencies were notified of the failure event, if applicable. Ref: IBM Maximo.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure event requires notification to regulatory agencies (EPA, state primacy agency). Ref: IBM Maximo.',
    `repair_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost to repair or replace the failed asset, including labor, materials, and contractor costs. Ref: IBM Maximo.',
    `resolution_date` DATE COMMENT 'Date when the failure was fully resolved and the asset was restored to normal operation. Ref: IBM Maximo.',
    `root_cause_analysis_completed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a formal root cause analysis (RCA) has been completed for this failure event. Ref: IBM Maximo.',
    `root_cause_analysis_findings` BOOLEAN COMMENT 'Detailed findings and conclusions from the root cause analysis investigation, including contributing factors and systemic issues identified. Ref: IBM Maximo.',
    `service_interruption_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure resulted in a complete service interruption to customers. Ref: IBM Maximo.',
    `sso_event_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure resulted in a Sanitary Sewer Overflow event requiring regulatory reporting. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure is covered under manufacturer or contractor warranty and a claim was filed. Ref: IBM Maximo.',
    CONSTRAINT pk_failure_record PRIMARY KEY(`failure_record_id`)
) COMMENT 'Documents asset failure events including failure date and time, failure mode, failure cause, failure effect, affected system, downtime duration, service impact (customers affected, MGD lost, PSI drop), emergency response actions taken, and root cause analysis findings. Supports reliability-centered maintenance (RCM) analysis, MTBF/MTTR calculations, and regulatory SSO/CSO incident reporting. Linked to corrective work orders in IBM Maximo.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` (
    `inspection_event_id` BIGINT COMMENT 'Unique identifier for the inspection event record. Primary key. Ref: IBM Maximo.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Inspections verify compliance with specific permit conditions. inspection_event.permit_number is a denormalized business identifier replaced by this FK to compliance_permit. Permit managers track all ',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), or other facility where the inspection occurred. Ref: IBM Maximo.',
    `manhole_id` BIGINT COMMENT 'Foreign key linking to wastewater.manhole. Business justification: Manhole inspections (MACP scoring, structural assessment, I/I evaluation) are a named inspection type in wastewater operations. Direct FK from inspection_event to manhole enables MACP score history tr',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Inspection events in water utilities are frequently triggered by preventive maintenance schedules — a PM schedule with trigger_type=calendar or meter generates scheduled inspection events. Linking',
    `registry_id` BIGINT COMMENT 'Reference to the asset or infrastructure component that was inspected. Ref: IBM Maximo.',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: inspection_event.regulatory_agency is a denormalized plain-text reference to the agency mandating or conducting the inspection. Replacing with FK to compliance.regulatory_agency enables agency-level i',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order under which this inspection was performed, if applicable. Ref: IBM Maximo.',
    `approval_date` DATE COMMENT 'Date on which the inspection results were formally approved by the reviewing authority. Ref: IBM Maximo.',
    `checklist_version` STRING COMMENT 'Version identifier of the inspection checklist used, ensuring traceability to specific regulatory or operational standards. Ref: IBM Maximo.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which identified deficiencies must be remediated, based on regulatory or operational requirements. Ref: IBM Maximo.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action work orders or follow-up activities are required as a result of this inspection. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection event record was first created in the system. Ref: IBM Maximo.',
    `critical_deficiency_flag` BOOLEAN COMMENT 'Indicates whether any critical or high-severity deficiencies were identified that require immediate corrective action. Ref: IBM Maximo.',
    `deficiencies_identified_count` STRING COMMENT 'Total number of deficiencies, non-conformances, or issues identified during the inspection. Ref: IBM Maximo.',
    `deficiency_summary` STRING COMMENT 'Summary description of all deficiencies identified during the inspection, including severity and recommended actions. Ref: IBM Maximo.',
    `duration_minutes` STRING COMMENT 'Total time spent performing the inspection, measured in minutes. Ref: IBM Maximo.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the inspection identified any environmental compliance issues or potential environmental impacts. Ref: IBM Maximo.',
    `functional_location` STRING COMMENT 'SAP PM functional location code representing the hierarchical location of the inspected asset within the facility. Ref: IBM Maximo.',
    `inspection_date` DATE COMMENT 'The calendar date on which the physical inspection was performed. Ref: IBM Maximo.',
    `inspection_end_time` TIMESTAMP COMMENT 'Timestamp when the inspection activity was completed. Ref: IBM Maximo.',
    `inspection_frequency_days` STRING COMMENT 'Required frequency of this inspection type, measured in days, as mandated by regulatory or operational policy. Ref: IBM Maximo.',
    `inspection_notes` STRING COMMENT 'Free-text field for inspector observations, comments, and detailed findings from the inspection. Ref: IBM Maximo.',
    `inspection_start_time` TIMESTAMP COMMENT 'Timestamp when the inspection activity commenced. Ref: IBM Maximo.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection event. [ENUM-REF-CANDIDATE: scheduled|in_progress|completed|cancelled|failed|pending_review|approved — 7 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `inspection_type` STRING COMMENT 'Classification of the inspection activity. [ENUM-REF-CANDIDATE: routine|regulatory|post_incident|pre_commissioning|condition_assessment|safety|environmental|quality|preventive|corrective — promote to reference product]. Ref: IBM Maximo.',
    `inspector_certification_num` STRING COMMENT 'Professional certification or license number of the inspector, if required by regulatory authority. Ref: IBM Maximo.',
    `inspector_name` STRING COMMENT 'Full name of the inspector who conducted the inspection. Ref: IBM Maximo.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection event record was most recently updated. Ref: IBM Maximo.',
    `maximo_inspection_num` STRING COMMENT 'External inspection identifier from IBM Maximo CMMS system.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection of this asset or component. Ref: IBM Maximo.',
    `pass_fail_outcome` STRING COMMENT 'Overall pass/fail result of the inspection based on checklist criteria and regulatory requirements. Ref: IBM Maximo.. Valid values are `pass|fail|conditional_pass|not_applicable`',
    `regulatory_inspection_flag` BOOLEAN COMMENT 'Indicates whether this inspection was mandated by a regulatory authority (EPA, state primacy agency, OSHA) or was voluntary/internal.',
    `report_submission_date` DATE COMMENT 'Date on which the inspection report was submitted to the regulatory authority. Ref: IBM Maximo.',
    `report_submitted_flag` BOOLEAN COMMENT 'Indicates whether the inspection report has been submitted to the regulatory authority, if required. Ref: IBM Maximo.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident or near-miss occurred during the inspection activity. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of inspection, relevant for outdoor infrastructure inspections (pipes, valves, tanks). Ref: IBM Maximo.',
    CONSTRAINT pk_inspection_event PRIMARY KEY(`inspection_event_id`)
) COMMENT 'Operational record of a physical inspection performed on an asset or infrastructure component, including inspection type (routine, regulatory, post-incident, pre-commissioning), inspector identity, inspection date, checklist used, pass/fail outcome, deficiencies identified, corrective action required flag, and regulatory permit reference. Distinct from condition_assessment (which produces a scored condition grade) — inspection_event captures compliance-driven inspection activities required by EPA, state primacy agencies, and OSHA.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_class_id` FOREIGN KEY (`class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`class`(`class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_parent_asset_registry_id` FOREIGN KEY (`parent_asset_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_class_id` FOREIGN KEY (`class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`class`(`class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`asset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`asset` SET TAGS ('dbx_domain' = 'asset');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `parent_asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `service_address_id` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Asset Acquisition Cost (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category / Business Domain');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name / Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `asset_name` SET TAGS ('dbx_PII' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `ami_applicable` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Applicable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `asset_domain` SET TAGS ('dbx_business_glossary_term' = 'Asset Operational Domain');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `capex_threshold_usd` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Capitalization Threshold (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `cip_program_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Category');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `class_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `class_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Deprecated|Under Review');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `condition_assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Default Condition Assessment Method');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `consequence_of_failure` SET TAGS ('dbx_business_glossary_term' = 'Primary Consequence of Failure Category');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `consequence_of_failure` SET TAGS ('dbx_value_regex' = 'Service Interruption|Public Health Risk|Environmental Non-Compliance|Safety Hazard|Financial Loss|Reputational');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `criticality_tier` SET TAGS ('dbx_business_glossary_term' = 'Default Criticality Tier');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `criticality_tier` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `criticality_weight` SET TAGS ('dbx_business_glossary_term' = 'Criticality Weighting Factor');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Default Depreciation Method');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'Straight-Line|Declining Balance|Units of Production|Sum-of-Years-Digits|Modified Accelerated Cost Recovery');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `class_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `environmental_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Risk Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `gis_feature_class` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature Class Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Hierarchy Level');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Frequency (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `iso_55001_aligned` SET TAGS ('dbx_business_glossary_term' = 'ISO 55001 Asset Management Aligned Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `lcrr_applicable` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Rule Revisions (LCRR) Applicable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Default Maintenance Strategy');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'Preventive|Predictive|Corrective|Condition-Based|Run-to-Failure');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `material_standard` SET TAGS ('dbx_business_glossary_term' = 'Default Material Standard');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `maximo_class_code` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Asset Class Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `maximo_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `mean_time_between_failures_days` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `class_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `class_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `number_sap` SET TAGS ('dbx_business_glossary_term' = 'SAP Asset Class Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `number_sap` SET TAGS ('dbx_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `pm_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Frequency (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `primary_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Primary Category');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `renewal_strategy` SET TAGS ('dbx_business_glossary_term' = 'Default Asset Renewal Strategy');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `renewal_strategy` SET TAGS ('dbx_value_regex' = 'Replace-in-Kind|Upgrade|Rehabilitation|CIPP|Trenchless|Decommission');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Retirement Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Hazard Classification');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'Confined Space|Electrical Hazard|Chemical Hazard|High Pressure|Radiation|None');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `salvage_value_pct` SET TAGS ('dbx_business_glossary_term' = 'Default Salvage Value Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `scada_monitored` SET TAGS ('dbx_business_glossary_term' = 'SCADA Monitored Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `size_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Asset Size Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `spare_parts_required` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `ssot_entity_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `ssot_entity_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_canonical' = 'service.service_class');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot_sync' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Default Useful Life (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `work_order_type_default` SET TAGS ('dbx_business_glossary_term' = 'Default Work Order Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`class` ALTER COLUMN `work_order_type_default` SET TAGS ('dbx_value_regex' = 'Preventive Maintenance|Corrective Maintenance|Inspection|Emergency Repair|Capital Renewal|Rehabilitation');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `parent_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Location Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `area_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Feet (sq ft)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Capacity Rating');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'mgd|gpm|gallons|cubic_meters|units');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_PII' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ALTER COLUMN `watershed` SET TAGS ('dbx_business_glossary_term' = 'Watershed');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Location Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `inspector_name` SET TAGS ('dbx_PII' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Analytical Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `warranty_claim` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|draft|expired');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `seasonal_end_month` SET TAGS ('dbx_business_glossary_term' = 'Seasonal End Month');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `seasonal_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Schedule Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `seasonal_start_month` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Start Month');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Trigger Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'calendar|meter|condition|runtime|cycle');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'preventive|inspection|calibration|lubrication|cleaning');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `work_zone` SET TAGS ('dbx_business_glossary_term' = 'Work Zone');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `functional_location` SET TAGS ('dbx_business_glossary_term' = 'Functional Location');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency in Days');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspector_certification_num` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspector_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `maximo_inspection_num` SET TAGS ('dbx_business_glossary_term' = 'Maximo Inspection Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `pass_fail_outcome` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Outcome');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `pass_fail_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `regulatory_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Report Submitted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
