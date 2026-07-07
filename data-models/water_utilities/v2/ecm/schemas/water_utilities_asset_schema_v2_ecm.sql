-- Schema for Domain: asset | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:34:23

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`asset` COMMENT 'Enterprise asset management domain owning the full lifecycle of physical infrastructure assets including WTP/WWTP equipment, pipes, pumps, valves, electrical systems, and vehicles. Manages asset registry, condition assessments, criticality ratings, preventive and corrective maintenance, work order management, depreciation schedules, and CAPEX/OPEX planning. Integrates with IBM Maximo CMMS and SAP PM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`registry` (
    `registry_id` BIGINT COMMENT 'Unique surrogate primary key for each physical infrastructure asset record in the enterprise asset registry. This is the authoritative SSOT identifier that IBM Maximo Asset Management and SAP Plant Maintenance (PM) equipment master synchronize against.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Registry stores asset classification as a free‑text field; linking to the asset_class taxonomy enables consistent classification and removes the redundant string column. Ref: IBM Maximo.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Asset record creation audit trail for data quality accountability, asset management program metrics, and regulatory compliance documentation. Ref: IBM Maximo.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Registry currently has no explicit location reference; adding a foreign key to location allows assets to be tied to a physical site and supports location‑based reporting. Ref: IBM Maximo.',
    `parent_asset_registry_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent asset in the asset hierarchy (e.g., a pump impellers parent is the pump assembly; the pump assemblys parent is the pump station). Enables parent-child asset hierarchy navigation for maintenance cost roll-up and condition assessment aggregation. Null for top-level assets. Ref: IBM Maximo.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: Critical assets (SCADA systems, treatment equipment, pump stations) often have long-term service/maintenance contracts. Links enable contract compliance tracking, SLA monitoring, preventive maintenanc. Ref: IBM Maximo.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Distribution assets (hydrants, valves, mains) serve specific service addresses. Critical for emergency response, outage notifications, GIS integration, and customer impact analysis during main breaks. Ref: IBM Maximo.',
    `pm_schedule_id` BIGINT COMMENT 'Reference to the preventive maintenance schedule record in IBM Maximo that governs recurring maintenance activities for this asset. Links the asset to its O&M (Operations and Maintenance) task plans, frequencies, and resource requirements.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` (
    `asset_class_id` BIGINT COMMENT 'Unique surrogate identifier for the asset class record in the enterprise asset management system. Primary key for the asset_class reference taxonomy. [ROLE: REFERENCE_LOOKUP — this entity is a reference taxonomy/classification table defining the hierarchy of utility asset types; per-role minimums are exempt, but MASTER_RESOURCE categories are applied for completeness given the entity carries rich business metadata beyond a simple code list.]. Ref: IBM Maximo.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Asset class definition authorship for configuration management, subject matter expert identification, and asset hierarchy governance. Ref: IBM Maximo.',
    `ami_applicable` BOOLEAN COMMENT 'Indicates whether assets of this class are part of the AMI/AMR metering infrastructure managed via the Sensus FlexNet AMI Platform. True for smart meters and communication endpoints; False for all other asset classes. Ref: IBM Maximo.',
    `asset_domain` STRING COMMENT 'Operational domain to which this asset class primarily belongs within the utility (e.g., Water Treatment, Water Distribution, Wastewater Collection, Wastewater Treatment, Metering, Fleet, Facilities, Cross-Domain). Drives domain-specific maintenance strategies and regulatory reporting alignment. [ENUM-REF-CANDIDATE: Water Treatment|Water Distribution|Wastewater Collection|Wastewater Treatment|Metering|Fleet|Facilities|Cross-Domain — promote to reference product]. Ref: IBM Maximo.',
    `capex_threshold_usd` DECIMAL(18,2) COMMENT 'Minimum acquisition or renewal cost in USD above which expenditures on assets of this class are capitalized as CAPEX rather than expensed as OPEX. Aligned with GAAP/GASB capitalization policies and SAP FI/CO asset accounting rules. Ref: IBM Maximo.',
    `cip_program_category` STRING COMMENT 'CIP program category under which capital renewal projects for assets of this class are budgeted and tracked. Aligns with the utilitys multi-year CIP planning structure in SAP PS and financial reporting to the Public Utilities Commission. [ENUM-REF-CANDIDATE: Water Supply|Water Treatment|Water Distribution|Wastewater Collection|Wastewater Treatment|Metering|Facilities|Fleet|Cross-Program — promote to reference product]. Ref: IBM Maximo.',
    `class_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the asset class within the enterprise taxonomy (e.g., MECH-PUMP, ELEC-TRANS, CIVIL-PIPE). Used as the externally-known business identifier in IBM Maximo, SAP PM, and GIS integrations.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `class_description` STRING COMMENT 'Detailed narrative description of the asset class, including its functional role within water or wastewater operations, typical installation context, and distinguishing characteristics from adjacent classes. Ref: IBM Maximo.',
    `class_name` STRING COMMENT 'Human-readable name of the asset class (e.g., Centrifugal Pump, Distribution Main Pipe, UV Disinfection Unit). Used in reports, work orders, and CAPEX planning documents. Ref: IBM Maximo.',
    `class_status` STRING COMMENT 'Current lifecycle status of the asset class record within the reference taxonomy. Active classes are available for new asset registrations; Deprecated classes are retained for historical assets but cannot be assigned to new assets. Ref: IBM Maximo.. Valid values are `Active|Inactive|Deprecated|Under Review`',
    `condition_assessment_method` STRING COMMENT 'Default method used to assess the physical condition of assets in this class. CIPP and pipe assets typically use CCTV; rotating equipment uses vibration analysis; distribution mains may use acoustic leak detection. Drives field inspection work order types in Maximo. [ENUM-REF-CANDIDATE: Visual Inspection|CCTV|Acoustic Leak Detection|Vibration Analysis|Ultrasonic Testing|Hydraulic Testing|SCADA Monitoring|Not Applicable — promote to reference product]. Ref: IBM Maximo.',
    `consequence_of_failure` STRING COMMENT 'Primary category of consequence if assets of this class fail. Drives risk-based maintenance prioritization and emergency response planning. [ENUM-REF-CANDIDATE: Service Interruption|Public Health Risk|Environmental Non-Compliance|Safety Hazard|Financial Loss|Reputational — promote to reference product]. Ref: IBM Maximo.. Valid values are `Service Interruption|Public Health Risk|Environmental Non-Compliance|Safety Hazard|Financial Loss|Reputational`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset class record was first created in the enterprise data platform. Supports audit trail and data lineage requirements. Ref: IBM Maximo.',
    `criticality_tier` STRING COMMENT 'Default criticality tier classification for assets of this class based on consequence of failure analysis. Critical assets (e.g., primary WTP pumps, transmission mains) receive highest maintenance priority and fastest response SLAs. Ref: IBM Maximo.. Valid values are `Critical|High|Medium|Low`',
    `criticality_weight` DECIMAL(18,2) COMMENT 'Numeric weighting factor (typically 0.00–10.00) applied to assets of this class during criticality assessment scoring. Higher values indicate greater consequence of failure on service delivery, public health, or regulatory compliance. Used in risk-based asset prioritization per ISO 55001.',
    `depreciation_method` STRING COMMENT 'Default accounting depreciation method applied to assets of this class for financial reporting purposes. Straight-Line is most common for utility infrastructure. Aligned with GAAP/GASB requirements for municipal utility financial statements. [ENUM-REF-CANDIDATE: Straight-Line|Declining Balance|Units of Production|Sum-of-Years-Digits|Modified Accelerated Cost Recovery — promote to reference product]. Ref: IBM Maximo.. Valid values are `Straight-Line|Declining Balance|Units of Production|Sum-of-Years-Digits|Modified Accelerated Cost Recovery`',
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
    `number_sap` STRING COMMENT 'Corresponding asset class number in SAP FI/CO Asset Accounting module (transaction AS02/AS03). Enables direct cross-reference between the enterprise data lakehouse and the SAP ERP system of record for financial reconciliation. Ref: IBM Maximo.. Valid values are `^[0-9]{4,8}$`',
    `pm_frequency_days` STRING COMMENT 'Default interval in calendar days between scheduled preventive maintenance activities for assets of this class. Used by IBM Maximo PM scheduling engine to auto-generate work orders. Overridable at the individual asset level.',
    `primary_category` STRING COMMENT 'Top-level classification grouping for the asset class aligned with standard utility asset taxonomy: Mechanical (pumps, blowers, mixers), Electrical (transformers, switchgear), Civil (pipes, structures, tanks), Instrumentation (sensors, meters, SCADA RTUs), Vehicle (fleet), Information Technology, or Other. [ENUM-REF-CANDIDATE: Mechanical|Electrical|Civil|Instrumentation|Vehicle|Information Technology|Other — promote to reference product]. Ref: IBM Maximo.',
    `regulatory_standard_ref` STRING COMMENT 'Primary regulatory standard or code applicable to assets of this class (e.g., SDWA Section 1412, NPDES Permit, AWWA C900, ASME B31.3). Drives compliance inspection scheduling and regulatory reporting requirements in DMR/MOR submissions.',
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
    CONSTRAINT pk_asset_class PRIMARY KEY(`asset_class_id`)
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
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: Condition assessments for pipes, coatings, and linings often reference supporting lab analysis results (corrosion testing, material integrity tests). Real business need: linking physical asset conditi. Ref: IBM Maximo.',
    `billing_rate_schedule_id` DECIMAL(18,2) COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Asset condition assessments inform rate case filings and infrastructure replacement rate schedules. Required for rate case asset condition documentation, infrastructure surcharge justification (e.g.,. Ref: IBM Maximo.',
    `employee_id` BIGINT COMMENT 'Reference to the manager or authority who approved the assessment and recommended actions. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the infrastructure asset being assessed (pipe, pump, valve, treatment equipment, vehicle, etc.). Ref: IBM Maximo.',
    `condition_employee_id` BIGINT COMMENT 'Reference to the employee or contractor who performed the condition assessment. Ref: IBM Maximo.',
    `condition_registry_id` BIGINT COMMENT 'Reference to the infrastructure asset being assessed (pipe, pump, valve, treatment equipment, vehicle, etc.). Ref: IBM Maximo.',
    `condition_reviewed_by_employee_id` BIGINT COMMENT 'Reference to the supervisor or engineer who reviewed and validated the assessment findings.',
    `location_id` BIGINT COMMENT 'Reference to the asset location in the Geographic Information System (GIS), enabling spatial analysis and mapping of condition assessment results. Ref: IBM Maximo.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Condition assessments routinely require laboratory analysis of pipe scale, corrosion products, coating degradation, and material samples. Essential for determining remaining useful life and failure ro. Ref: IBM Maximo.',
    `primary_condition_employee_id` BIGINT COMMENT 'Reference to the employee or contractor who performed the condition assessment. Ref: IBM Maximo.',
    `tertiary_condition_approved_by_employee_id` BIGINT COMMENT 'Reference to the manager or authority who approved the assessment and recommended actions. Ref: IBM Maximo.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order under which this condition assessment was performed, if applicable. Ref: IBM Maximo.',
    `approved_date` DATE COMMENT 'Date when the assessment was formally approved by management. Ref: IBM Maximo.',
    `assessment_date` DATE COMMENT 'The date on which the condition assessment was performed in the field. Ref: IBM Maximo.',
    `assessment_interval_months` STRING COMMENT 'Standard inspection frequency interval in months for this asset type and condition grade. Ref: IBM Maximo.',
    `assessment_method` STRING COMMENT 'The inspection or testing method used to assess asset condition. Common methods include visual inspection, Closed-Circuit Television (CCTV) for pipes, acoustic leak detection, vibration analysis for rotating equipment, ultrasonic thickness measurement for corrosion, infrared thermography for electrical systems, and various hydraulic testing methods. [ENUM-REF-CANDIDATE: visual|cctv|acoustic|vibration_analysis|ultrasonic_thickness|infrared_thermography|dye_testing|smoke_testing|pressure_testing|flow_testing|electrical_testing|corrosion_survey — 12 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `assessment_number` STRING COMMENT 'Business identifier for the condition assessment, typically generated by the Computerized Maintenance Management System (CMMS) or inspection system. Ref: IBM Maximo.',
    `assessment_status` STRING COMMENT 'Current workflow status of the condition assessment record: scheduled, in progress, completed (field work done), reviewed (technical review complete), approved (management sign-off), or cancelled. Ref: IBM Maximo.. Valid values are `scheduled|in_progress|completed|reviewed|approved|cancelled`',
    `assessment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the condition assessment was completed, including time zone information. Ref: IBM Maximo.',
    `assessment_type` STRING COMMENT 'Classification of the assessment purpose: routine scheduled inspection, preventive maintenance assessment, reactive inspection following an incident, condition-based monitoring, regulatory compliance inspection, pre-failure investigation, post-repair verification, or new asset commissioning. [ENUM-REF-CANDIDATE: routine|preventive|reactive|condition_based|regulatory|pre_failure|post_repair|commissioning — 8 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `compliance_standard` STRING COMMENT 'Specific regulatory standard, code, or requirement that this assessment addresses (e.g., SDWA Section 1433, AWWA C651, NFPA 25).',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` (
    `criticality_rating_id` BIGINT COMMENT 'Unique identifier for the criticality rating record. Primary key for the criticality rating entity. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset being evaluated for criticality. Links to the asset registry in IBM Maximo CMMS.',
    `criticality_registry_id` BIGINT COMMENT 'Reference to the physical asset being evaluated for criticality. Links to the asset registry in IBM Maximo CMMS.',
    `approval_date` DATE COMMENT 'Date when this criticality rating was formally approved for operational use. Supports audit trail and governance compliance. Ref: IBM Maximo.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role that approved this criticality rating for operational use. Supports governance and accountability for asset management decisions. Ref: IBM Maximo.',
    `assessment_date` DATE COMMENT 'The date when the criticality assessment was performed. Distinct from the effective date; tracks when the analysis was conducted. Ref: IBM Maximo.',
    `assessment_performed_by` STRING COMMENT 'Name or identifier of the person, team, or system that performed the criticality assessment. Supports audit trail and accountability for rating decisions. Ref: IBM Maximo.',
    `capital_renewal_priority_rank` STRING COMMENT 'Relative priority ranking for capital renewal or replacement within the asset portfolio. Lower numbers indicate higher priority. Derived from criticality tier and overall risk score. Ref: IBM Maximo.',
    `cip_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this asset is eligible for inclusion in the Capital Improvement Program based on its criticality rating and condition. True if eligible for CIP funding consideration. Ref: IBM Maximo.',
    `consequence_of_failure_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the business, operational, safety, environmental, and regulatory impact if the asset fails. Typically scaled 1-100 or 1-10 depending on methodology. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this criticality rating record was first created in the system. Supports data lineage and audit trail requirements. Ref: IBM Maximo.',
    `criticality_tier` STRING COMMENT 'Categorical classification of asset criticality derived from the overall risk score. Determines maintenance frequency, inspection intervals, and capital renewal priority. Ref: IBM Maximo.. Valid values are `Critical|High|Medium|Low`',
    `customer_impact_count` STRING COMMENT 'Estimated number of customers or service connections that would be affected by failure of this asset. Used to quantify consequence of failure for distribution and collection system assets. Ref: IBM Maximo.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether failure of this asset would result in environmental harm such as discharge of untreated wastewater, contamination of water sources, or SSO/CSO events. True if environmental impact is likely. Ref: IBM Maximo.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial consequence of asset failure including emergency repair costs, lost revenue, regulatory fines, and liability claims. Expressed in USD. Ref: IBM Maximo.',
    `inspection_frequency_days` STRING COMMENT 'Recommended interval in days between routine inspections based on the criticality tier. Critical assets require more frequent inspection than low-criticality assets. Ref: IBM Maximo.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this criticality rating record was last updated. Supports change tracking and audit trail requirements. Ref: IBM Maximo.',
    `likelihood_of_failure_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the probability of asset failure based on age, condition, maintenance history, and operating environment. Typically scaled 1-100 or 1-10 depending on methodology. Ref: IBM Maximo.',
    `methodology_version` STRING COMMENT 'Version identifier of the criticality assessment methodology used to calculate this rating. Enables tracking of methodology changes over time and ensures consistent application across asset portfolio. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next criticality reassessment. Critical assets typically require more frequent review cycles than low-criticality assets. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Free-text notes documenting special considerations, assumptions, or qualitative factors that influenced the criticality rating. Supports transparency and knowledge transfer. Ref: IBM Maximo.',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'Composite risk score calculated from Consequence of Failure and Likelihood of Failure scores. Typically computed as CoF × LoF. Used to rank assets for maintenance and capital investment prioritization. Ref: IBM Maximo.',
    `preventive_maintenance_frequency_days` STRING COMMENT 'Recommended interval in days between preventive maintenance activities based on the criticality tier. Critical assets require more frequent PM than low-criticality assets. Ref: IBM Maximo.',
    `public_health_impact_flag` BOOLEAN COMMENT 'Indicates whether failure of this asset would pose a direct threat to public health through loss of water supply, water quality degradation, or exposure to contaminants. True if public health risk exists. Ref: IBM Maximo.',
    `rating_effective_date` DATE COMMENT 'The date from which this criticality rating becomes effective and is used for maintenance prioritization and capital planning decisions. Ref: IBM Maximo.',
    `rating_expiration_date` DATE COMMENT 'The date when this criticality rating expires and must be reassessed. Nullable for ratings without a defined review cycle. Ref: IBM Maximo.',
    `rating_status` STRING COMMENT 'Current lifecycle status of the criticality rating record. Active ratings are used for operational decisions; superseded ratings are retained for historical analysis. Ref: IBM Maximo.. Valid values are `Active|Superseded|Under Review|Pending Approval`',
    `redundancy_available_flag` BOOLEAN COMMENT 'Indicates whether backup or redundant assets are available to maintain service if this asset fails. True if redundancy exists, False if asset is a single point of failure. Ref: IBM Maximo.',
    `regulatory_consequence_flag` BOOLEAN COMMENT 'Indicates whether failure of this asset would result in regulatory non-compliance, permit violations, or mandatory reporting under SDWA, CWA, or NPDES. True if regulatory consequences exist. Ref: IBM Maximo.',
    `review_frequency_months` STRING COMMENT 'Standard interval in months between criticality reassessments for this asset. Typically shorter for critical assets and longer for low-criticality assets. Ref: IBM Maximo.',
    `safety_impact_flag` BOOLEAN COMMENT 'Indicates whether failure of this asset would create safety hazards for employees, contractors, or the public (e.g., chemical release, electrical hazard, structural collapse). True if safety risk exists. Ref: IBM Maximo.',
    `service_disruption_duration_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that service would be disrupted if this asset fails, accounting for repair time, parts availability, and system restoration procedures. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    CONSTRAINT pk_criticality_rating PRIMARY KEY(`criticality_rating_id`)
) COMMENT 'Stores the criticality evaluation for each asset, capturing consequence of failure (CoF) score, likelihood of failure (LoF) score, overall risk score, criticality tier (Critical/High/Medium/Low), redundancy availability, customer impact count, regulatory consequence flag, and the methodology version used. Criticality ratings drive maintenance prioritization, inspection frequency, and capital renewal sequencing per ISO 55001 and AWWA asset management best practices.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the work order record. Primary key. Ref: IBM Maximo.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Work orders charge costs to departmental cost centers (treatment plants, pump stations, distribution zones) for budget tracking, variance analysis, and operational cost allocation required for utility. Ref: IBM Maximo.',
    `crew_id` BIGINT COMMENT 'Reference to the maintenance crew or work group assigned to perform the work. Ref: IBM Maximo.',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Enforcement actions (consent orders, administrative orders) mandate specific remediation work with deadlines. Work orders must reference enforcement actions to track compliance schedule milestones, re. Ref: IBM Maximo.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Work orders post labor, material, and overhead costs to specific GL accounts for financial reporting, rate case cost-of-service studies, and GASB compliance. Essential for integrating maintenance cost. Ref: IBM Maximo.',
    `job_plan_id` BIGINT COMMENT 'Foreign key linking to asset.job_plan. Business justification: Work orders frequently execute standardized job plans that define task sequences, labor requirements, materials, and safety procedures. This is a standard CMMS pattern (IBM Maximo, SAP PM). Job plan p',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Work orders trigger water quality sampling for post-repair verification, commissioning tests, incident response, and regulatory compliance. Standard operational practice in water utilities to document. Ref: IBM Maximo.',
    `location_id` BIGINT COMMENT 'Reference to the functional location or site where the work is performed (Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), pump station, District Metered Area (DMA)). Ref: IBM Maximo.',
    `pm_schedule_id` BIGINT COMMENT 'Reference to the preventive maintenance schedule or route that generated this work order, if applicable. Ref: IBM Maximo.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Capital work orders and major repairs have associated POs for materials/equipment procurement. Enables three-way match (work order-PO-invoice), project cost reconciliation, budget tracking, and financ. Ref: IBM Maximo.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Work order origination tracking distinguishes internal employee-reported issues from customer complaints, critical for root cause analysis and employee engagement metrics. Removes denormalized reporte. Ref: IBM Maximo.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Work orders require service address for crew dispatch, customer contact, access instructions, and completion documentation. Essential for field operations, customer communication, and GIS-based work o. Ref: IBM Maximo.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Work orders for main breaks, repairs, flushing, and tank maintenance trigger mandatory water quality sampling per regulatory requirements (e.g., bacteriological sampling after distribution system repa. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset (pipe, pump, valve, treatment equipment, vehicle) that is the subject of this work order. Ref: IBM Maximo.',
    `work_registry_id` BIGINT COMMENT 'Reference to the physical asset (pipe, pump, valve, treatment equipment, vehicle) that is the subject of this work order. Ref: IBM Maximo.',
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
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), pumping station, or other facility where the asset is located and the preventive maintenance will be performed. Ref: IBM Maximo.',
    `job_plan_id` BIGINT COMMENT 'Reference to the standardized job plan that defines the detailed work instructions, materials, tools, and safety procedures for this maintenance task. Ref: IBM Maximo.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` (
    `job_plan_id` BIGINT COMMENT 'Unique identifier for the job plan. Primary key. Ref: IBM Maximo.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Job plans are standardized maintenance procedures defined for specific asset classes. Currently asset_class is stored as STRING code; should be FK to asset_class.asset_class_id for referential integri. Ref: IBM Maximo.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Job plans define standard maintenance tasks with estimated costs allocated to cost centers for annual O&M budgeting. Supports bottom-up budget development and cost center planning. Ref: IBM Maximo.',
    `org_unit_id` BIGINT COMMENT 'Reference to the maintenance work center or crew responsible for executing this job plan. Ref: IBM Maximo.',
    `job_work_center_org_unit_id` BIGINT COMMENT 'Reference to the maintenance work center or crew responsible for executing this job plan. Ref: IBM Maximo.',
    `approved_by` STRING COMMENT 'Username or identifier of the supervisor or manager who approved this job plan for active use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this job plan was approved and activated for use in work orders and preventive maintenance schedules. Ref: IBM Maximo.',
    `confined_space_flag` BOOLEAN COMMENT 'Indicates whether this job plan involves work in a confined space (e.g., wet well, tank, vault) requiring permit and atmospheric monitoring. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this job plan record was first created in the system. Ref: IBM Maximo.',
    `job_plan_description` STRING COMMENT 'Detailed narrative description of the job plan purpose, scope, and overview of the maintenance activity to be performed. Ref: IBM Maximo.',
    `downtime_required_flag` BOOLEAN COMMENT 'Indicates whether this job plan requires taking the asset or system offline, impacting operations and requiring coordination. Ref: IBM Maximo.',
    `effective_end_date` DATE COMMENT 'Date when this job plan version is superseded or retired. Null indicates the job plan is currently active with no planned end date. Ref: IBM Maximo.',
    `effective_start_date` DATE COMMENT 'Date when this job plan version becomes effective and available for use in work order generation. Ref: IBM Maximo.',
    `environmental_impact_notes` STRING COMMENT 'Description of potential environmental impacts and mitigation measures for this job plan (e.g., chemical spill containment, waste disposal procedures). Ref: IBM Maximo.',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that the asset or system will be out of service during execution of this job plan. Ref: IBM Maximo.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated total labor hours required to complete all tasks in this job plan. Used for work order scheduling and resource planning. Ref: IBM Maximo.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Estimated total labor cost in USD to execute this job plan, calculated from labor craft rates and estimated hours. Ref: IBM Maximo.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Estimated total material and parts cost in USD required to execute this job plan, based on the materials list. Ref: IBM Maximo.',
    `estimated_tool_cost` DECIMAL(18,2) COMMENT 'Estimated cost in USD for specialized tools, equipment rental, or contractor services required for this job plan. Ref: IBM Maximo.',
    `frequency_code` STRING COMMENT 'Standard frequency code indicating how often this job plan should be executed when attached to a preventive maintenance schedule. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|as_needed — 7 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `inspection_points` STRING COMMENT 'List of quality control and inspection checkpoints to be verified during or after job execution, ensuring work meets standards. Ref: IBM Maximo.',
    `job_plan_number` STRING COMMENT 'The externally-known unique alphanumeric code identifying this job plan template across the organization. Used for referencing in work orders and preventive maintenance schedules. Ref: IBM Maximo.',
    `job_plan_status` STRING COMMENT 'Current lifecycle status of the job plan. Only active job plans can be attached to work orders or preventive maintenance schedules. Ref: IBM Maximo.. Valid values are `draft|active|inactive|obsolete|under_review`',
    `job_type` STRING COMMENT 'Classification of the maintenance activity type that this job plan supports. Determines scheduling and priority rules. Ref: IBM Maximo.. Valid values are `preventive_maintenance|corrective_maintenance|predictive_maintenance|inspection|calibration|emergency_repair`',
    `last_modified_by` STRING COMMENT 'Username or identifier of the person who most recently updated this job plan record. Ref: IBM Maximo.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this job plan record was most recently updated. Ref: IBM Maximo.',
    `loto_required_flag` BOOLEAN COMMENT 'Indicates whether Lockout/Tagout procedures are mandatory for this job plan to ensure worker safety during equipment maintenance. Ref: IBM Maximo.',
    `materials_list` STRING COMMENT 'List of materials, parts, and consumables required for this job plan, including part numbers and estimated quantities. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Additional free-form notes, lessons learned, or special instructions for executing this job plan. Ref: IBM Maximo.',
    `ppe_requirements` STRING COMMENT 'List of required Personal Protective Equipment for workers executing this job plan (e.g., Hard hat, safety glasses, chemical-resistant gloves, steel-toe boots). Ref: IBM Maximo.',
    `priority` STRING COMMENT 'Default priority level assigned to work orders generated from this job plan. Lower numbers indicate higher priority (e.g., 1=Critical, 5=Routine). Ref: IBM Maximo.',
    `regulatory_compliance_notes` STRING COMMENT 'Notes on regulatory requirements, permits, or compliance documentation that must be completed as part of this job plan (e.g., EPA reporting, NPDES permit conditions). Ref: IBM Maximo.',
    `required_labor_crafts` STRING COMMENT 'Comma-separated list of labor craft skills required to execute this job plan (e.g., Electrician, Mechanic, Instrumentation Technician). Ref: IBM Maximo.',
    `revision_number` STRING COMMENT 'Sequential version number tracking changes to the job plan over time. Incremented each time the job plan is updated and re-approved. Ref: IBM Maximo.',
    `safety_requirements` STRING COMMENT 'Detailed safety procedures and precautions required for this job plan, including Lockout/Tagout (LOTO), confined space entry, Personal Protective Equipment (PPE), and hazard mitigation steps. Ref: IBM Maximo.',
    `source_reference` STRING COMMENT 'Reference to the source document or standard from which this job plan was derived (e.g., AWWA M11 Steel Pipe Manual, Manufacturer Service Bulletin 2023-04).',
    `task_sequence` STRING COMMENT 'Step-by-step instructions detailing the ordered sequence of tasks to be performed. Each step includes action description, safety notes, and quality checkpoints. Ref: IBM Maximo.',
    `title` STRING COMMENT 'Short descriptive title of the job plan that summarizes the maintenance activity (e.g., Pump Impeller Replacement, Chlorine Analyzer Calibration). Ref: IBM Maximo.',
    `tools_list` STRING COMMENT 'List of specialized tools, equipment, and instruments required to perform this job plan (e.g., Torque wrench, multimeter, pipe wrench set). Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `created_by` STRING COMMENT 'Username or identifier of the person who originally created this job plan record. Ref: IBM Maximo.',
    CONSTRAINT pk_job_plan PRIMARY KEY(`job_plan_id`)
) COMMENT 'Standardized task library defining the step-by-step instructions, required labor crafts, estimated durations, safety procedures (LOTO, confined space, PPE), and materials/tools needed to perform a specific maintenance activity. Job plans are reusable templates attached to PM schedules and work orders. Sourced from IBM Maximo Job Plan module and aligned with AWWA O&M manuals and OSHA safety standards.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` (
    `failure_record_id` BIGINT COMMENT 'Unique identifier for the asset failure event record. Primary key. Ref: IBM Maximo.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Failure events trigger emergency repairs charged to cost centers for unplanned maintenance budget tracking. Critical for analyzing cost center budget variances and justifying contingency reserves in r. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset that experienced the failure (equipment, pipe, pump, valve, etc.). Ref: IBM Maximo.',
    `failure_registry_id` BIGINT COMMENT 'Reference to the physical asset that experienced the failure (equipment, pipe, pump, valve, etc.). Ref: IBM Maximo.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Failure investigations require water quality sampling to determine if contamination, corrosion, or water chemistry contributed to asset failure. Regulatory requirement for reportable incidents and sta. Ref: IBM Maximo.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Failures of customer-side assets (service line breaks, meter malfunctions, lateral collapses) must be tracked to premises for customer impact analysis, regulatory reporting (e.g., lead service line fa. Ref: IBM Maximo.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who reported or documented the failure event. Ref: IBM Maximo.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Asset failures (main breaks, tank overflows, pressure loss events) trigger mandatory water quality sampling per regulatory requirements (e.g., bacteriological sampling after pressure loss per TCR/RTCR. Ref: IBM Maximo.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` (
    `asset_meter_id` BIGINT COMMENT 'Unique surrogate identifier for the asset meter record in the enterprise data platform. Primary key for the asset_meter product. Role: MASTER_RESOURCE. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the parent physical asset (pump, motor, valve, pipe segment, vehicle, etc.) to which this operational meter or counter is attached. Links to the asset master record in the asset domain. Ref: IBM Maximo.',
    `canonical_metering_meter_id` BIGINT COMMENT 'Unique identifier for the canonical metering meter referenced by each asset meter record in the asset domain.',
    `location_id` BIGINT COMMENT 'Reference to the functional location or facility location record where the metered asset is installed. Links to the location hierarchy in the asset domain (e.g., WTP, pump station, WWTP). Supports geographic and facility-level aggregation of meter data. Ref: IBM Maximo.',
    `metering_meter_id` BIGINT COMMENT 'The native meter identifier from IBM Maximo Asset Management CMMS (METERNAME or internal Maximo meter key). Used for system-of-record traceability and bidirectional synchronization between the Silver Layer and Maximo.',
    `primary_asset_registry_id` BIGINT COMMENT 'Reference to the parent physical asset (pump, motor, valve, pipe segment, vehicle, etc.) to which this operational meter or counter is attached. Links to the asset master record in the asset domain. Ref: IBM Maximo.',
    `alarm_high_threshold` DECIMAL(18,2) COMMENT 'The upper alarm threshold value for this meter. When the reading exceeds this value, a SCADA or CMMS alarm is triggered. For example, high vibration alarm at 0.5 in/s for a pump motor. Supports integration with SCADA HMI alarm management. Ref: IBM Maximo.',
    `alarm_low_threshold` DECIMAL(18,2) COMMENT 'The lower alarm threshold value for this meter. When the reading falls below this value, a SCADA or CMMS alarm is triggered. For example, low flow alarm at 0.1 MGD for a treatment process feed pump. Ref: IBM Maximo.',
    `average_reading_rate` DECIMAL(18,2) COMMENT 'The average rate of change per day for this meter, calculated and stored by the CMMS during reading entry (not a derived KPI — stored as a CMMS field used for PM trigger forecasting). For example, average run-hours per day for a pump. Used by meter-based PM triggers to forecast next maintenance due date. Ref: IBM Maximo.',
    `avg_calculation_method` STRING COMMENT 'Method used by the CMMS to compute the average_reading_rate. SLIDING_WINDOW: rolling average over a configurable number of recent readings. FIXED_PERIOD: average over a fixed calendar period. LAST_READING: uses only the most recent reading interval. Ref: IBM Maximo.. Valid values are `SLIDING_WINDOW|FIXED_PERIOD|LAST_READING`',
    `calibration_interval_days` STRING COMMENT 'The required frequency of calibration expressed in calendar days. Used to compute next_calibration_date from last_calibration_date and to schedule calibration work orders in IBM Maximo.',
    `calibration_status` STRING COMMENT 'Current calibration status of the meter instrument. CALIBRATED: within valid calibration period. DUE: calibration due within the next calibration_interval_days. OVERDUE: calibration date has passed without recalibration. IN_PROGRESS: currently being calibrated. NOT_REQUIRED: meter type does not require formal calibration (e.g., simple cycle counters). Ref: IBM Maximo.. Valid values are `CALIBRATED|DUE|OVERDUE|IN_PROGRESS|NOT_REQUIRED`',
    `calibration_tolerance` DECIMAL(18,2) COMMENT 'Acceptable measurement tolerance or accuracy specification for this meter expressed in the meters unit of measure. Readings outside this tolerance trigger recalibration. For example, ±0.5 PSI for a pressure transducer or ±0.01 MGD for a flow totalizer. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset meter record was first created in the enterprise data platform. Supports audit trail and data lineage requirements. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Ref: IBM Maximo.',
    `current_reading` DECIMAL(18,2) COMMENT 'The most recent recorded value of the meter or counter as of the last_reading_date. For CONTINUOUS meters this is the cumulative total; for GAUGE meters this is the last observed point-in-time value. Principal quantitative fact for this MASTER_RESOURCE. Ref: IBM Maximo.',
    `decommission_date` DATE COMMENT 'Date on which the meter was permanently removed from service and retired. Null for active meters. Used for lifecycle reporting and asset history. Ref: IBM Maximo.',
    `deprecated_flag` BOOLEAN COMMENT 'The deprecated flag value recorded for each asset meter in the asset domain.',
    `installation_date` DATE COMMENT 'Date on which the meter was physically installed on the asset. Used to calculate meter age, warranty expiry, and to establish the baseline reading at installation. Ref: IBM Maximo.',
    `is_regulatory_meter` BOOLEAN COMMENT 'Indicates whether readings from this meter are used in regulatory compliance reporting (e.g., EPA NPDES Discharge Monitoring Reports, Safe Drinking Water Act compliance, Monthly Operating Reports). True = regulatory-grade meter subject to calibration and data integrity requirements. Ref: IBM Maximo.',
    `last_calibration_date` DATE COMMENT 'Date on which the meter was most recently calibrated and certified as accurate. Critical for regulatory compliance where metered values (e.g., flow, pressure, chemical dosing) are used in EPA/NPDES reporting. Ref: IBM Maximo.',
    `last_reading_date` TIMESTAMP COMMENT 'Timestamp of the most recent meter reading captured, whether from SCADA/OSIsoft PI Historian automated feed or manual entry in IBM Maximo. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `location_description` STRING COMMENT 'Free-text description of the physical location where the meter is installed on the asset, e.g., Discharge side of Pump 3 at WTP Building A, Inlet valve actuator shaft. Supplements the parent asset location for field technician navigation. Ref: IBM Maximo.',
    `manufacturer` STRING COMMENT 'Name of the manufacturer of the meter instrument or sensor hardware, e.g., Endress+Hauser, Yokogawa, Emerson, Siemens. Used for procurement, warranty tracking, and spare parts management. Ref: IBM Maximo.',
    `measurement_unit` STRING COMMENT 'Engineering unit of measure for the meter reading, e.g., HOURS (run-hours), STARTS (motor starts), CYCLES (valve cycles), MGD (Million Gallons per Day), GPM (Gallons per Minute), PSI (Pounds per Square Inch), NTU (Nephelometric Turbidity Units), RPM, DEGREES_F, INCHES. Aligns with OSIsoft PI Historian tag engineering units.',
    `meter_name` STRING COMMENT 'Human-readable descriptive name for the meter or counter, e.g., Pump 3 Run Hours, Valve 12 Cycle Count, Influent Flow Totalizer. Used for display in CMMS work orders and PM triggers. Ref: IBM Maximo.',
    `meter_number` STRING COMMENT 'Externally-known unique alphanumeric identifier for the meter as assigned in IBM Maximo CMMS or SAP PM. Used for cross-system reference and field identification. Distinct from customer billing meter numbers managed by the Metering domain.',
    `meter_status` STRING COMMENT 'Current operational lifecycle status of the meter. ACTIVE: in service and collecting readings. INACTIVE: temporarily not in use. RETIRED: permanently decommissioned. SUSPENDED: readings paused (e.g., asset out of service). PENDING_CALIBRATION: due for or undergoing calibration. Ref: IBM Maximo.. Valid values are `ACTIVE|INACTIVE|RETIRED|SUSPENDED|PENDING_CALIBRATION`',
    `meter_type` STRING COMMENT 'Classification of the meter per IBM Maximo meter type taxonomy. CONTINUOUS: accumulating counter that never resets (e.g., run-hours, cycle counts, flow totalizer). GAUGE: point-in-time measurement that can go up or down (e.g., PSI, vibration amplitude, temperature). CHARACTERISTIC: qualitative or categorical observation (e.g., condition rating, oil color).. Valid values are `CONTINUOUS|GAUGE|CHARACTERISTIC`',
    `model_number` STRING COMMENT 'Manufacturers model or part number for the meter instrument. Used for procurement, spare parts identification, and technical documentation lookup. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `next_calibration_date` DATE COMMENT 'Scheduled date by which the meter must next be calibrated to maintain measurement accuracy and regulatory compliance. Drives calibration work order generation in IBM Maximo.',
    `pi_tag_name` STRING COMMENT 'The OSIsoft PI Historian tag identifier associated with this meter for automated SCADA data ingestion. Enables direct linkage between the CMMS meter record and the PI Historian time-series data stream. Null if the meter is not integrated with PI Historian.',
    `pm_trigger_interval` DECIMAL(18,2) COMMENT 'The recurring interval of meter units between successive PM work order generations. For example, every 500 run-hours or every 1000 valve cycles. Works in conjunction with pm_trigger_threshold for ongoing PM scheduling. Ref: IBM Maximo.',
    `pm_trigger_threshold` DECIMAL(18,2) COMMENT 'The meter reading value at which a Preventive Maintenance (PM) work order is automatically generated. For example, a pump PM triggered every 2000 run-hours. Core field enabling meter-based PM scheduling in IBM Maximo.',
    `previous_reading` DECIMAL(18,2) COMMENT 'The meter reading value recorded immediately prior to the current reading. Used to calculate consumption delta between readings and to detect anomalous jumps or rollover events. Ref: IBM Maximo.',
    `previous_reading_date` TIMESTAMP COMMENT 'Timestamp of the meter reading that preceded the current reading. Used in conjunction with previous_reading to compute usage rate and validate reading intervals. Ref: IBM Maximo.',
    `reading_frequency` STRING COMMENT 'Expected frequency at which meter readings are collected. CONTINUOUS: real-time SCADA/PI Historian streaming. HOURLY/DAILY/WEEKLY/MONTHLY: scheduled batch collection. ON_DEMAND: readings taken only when required (e.g., during inspections or work orders). Ref: IBM Maximo.. Valid values are `CONTINUOUS|HOURLY|DAILY|WEEKLY|MONTHLY|ON_DEMAND`',
    `reading_range_max` DECIMAL(18,2) COMMENT 'Maximum valid reading value for this meter as defined by the instruments operating range or process design limits. Readings above this value are flagged as suspect or trigger alarms. For example, 150 PSI maximum for a distribution pressure transducer. Ref: IBM Maximo.',
    `reading_range_min` DECIMAL(18,2) COMMENT 'Minimum valid reading value for this meter as defined by the instruments operating range or process design limits. Readings below this value are flagged as suspect. For example, 0 PSI minimum for a pressure transducer. Ref: IBM Maximo.',
    `reading_source` STRING COMMENT 'The system or method by which the current meter reading was captured. SCADA: from Supervisory Control and Data Acquisition system. PI_HISTORIAN: from OSIsoft PI Historian automated feed. MANUAL: entered manually by a technician in IBM Maximo. AMI: from Advanced Metering Infrastructure. CMMS_IMPORT: batch import from CMMS. FIELD_DEVICE: direct PLC/RTU feed.. Valid values are `SCADA|PI_HISTORIAN|MANUAL|AMI|CMMS_IMPORT|FIELD_DEVICE`',
    `regulatory_reporting_code` STRING COMMENT 'The regulatory parameter code or identifier associated with this meter for compliance reporting submissions, e.g., EPA DMR parameter code, NPDES permit parameter identifier, or state drinking water program monitoring code. Null if is_regulatory_meter is False. Ref: IBM Maximo.',
    `remarks` STRING COMMENT 'Free-text field for operational notes, technician observations, or special instructions related to this meter. For example, notes about known reading anomalies, temporary bypass conditions, or pending replacement. Sourced from IBM Maximo meter remarks field.',
    `rollover_value` DECIMAL(18,2) COMMENT 'The maximum value the meter counter can reach before rolling over to zero. Applicable to CONTINUOUS meters with fixed-digit displays (e.g., 99999.9 hours). Used to correctly compute cumulative usage across rollover events. Null if the meter has no rollover limit. Ref: IBM Maximo.',
    `sap_measuring_point_code` STRING COMMENT 'The measuring point identifier from SAP Plant Maintenance (PM) module corresponding to this asset meter. Enables reconciliation between IBM Maximo CMMS and SAP PM for assets managed across both systems.',
    `serial_number` STRING COMMENT 'Manufacturers serial number uniquely identifying the physical meter instrument. Used for warranty claims, calibration certificates, and asset tracking. Ref: IBM Maximo.',
    `ssot_resolution_type` STRING COMMENT 'The ssot resolution type value recorded for each asset meter in the asset domain.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'The ssot sync timestamp associated with each asset meter record in the asset domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset meter record was most recently modified in the enterprise data platform. Used for change tracking, incremental data loads, and audit compliance. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    CONSTRAINT pk_asset_meter PRIMARY KEY(`asset_meter_id`)
) COMMENT 'Tracks operational meters, counters, and their reading history for asset condition and usage monitoring — distinct from customer billing meters (owned by the metering domain). Examples include pump run-hours, motor starts, valve cycle counts, flow totalizers (MGD), pressure transducers (PSI), and vibration sensors. Captures meter type, unit of measure, current reading, rollover value, calibration status, and historical reading records (reading date/time, value, source — manual or SCADA/PI Historian automated, inspector ID, delta from previous reading). Feeds meter-based PM triggers, tracks asset utilization trends, and supports predictive maintenance analytics. Integrates with OSIsoft PI Historian. [SSOT: Domain-specific view; canonical source is metering.metering_meter.] Consolidated: metering.metering_meter is SSOT; this table references it.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`warranty` (
    `warranty_id` BIGINT COMMENT 'Unique system-generated identifier for each asset warranty record in the enterprise asset management system. Primary key for the asset_warranty data product. Ref: IBM Maximo.',
    `construction_contract_id` BIGINT COMMENT 'Foreign key linking to project.construction_contract. Business justification: Equipment warranties originate from construction contracts; warranty claim processing, vendor accountability, and performance bond claims require direct reference to the construction contract that spe. Ref: IBM Maximo.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Warranty record creation audit for procurement process tracking, warranty management program accountability, and data quality monitoring. Ref: IBM Maximo.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or manufacturer who issued and is responsible for honoring this warranty. Used to route warranty claims to the correct counterparty. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the physical infrastructure asset (e.g., pump, valve, pipe, electrical panel, vehicle, WTP/WWTP equipment) covered by this warranty record. Ref: IBM Maximo.',
    `warranty_registry_id` BIGINT COMMENT 'Reference to the physical infrastructure asset (e.g., pump, valve, pipe, electrical panel, vehicle, WTP/WWTP equipment) covered by this warranty record. Ref: IBM Maximo.',
    `claim_response_days` STRING COMMENT 'Contractually committed number of calendar days within which the vendor must respond to a submitted warranty claim. Used for SLA monitoring and vendor performance management. Ref: IBM Maximo.',
    `claim_submission_process` STRING COMMENT 'Description of the required process for submitting a warranty claim, including required documentation, submission channel (e.g., vendor portal URL, email, phone), and any pre-authorization requirements. Ensures maintenance staff follow correct procedures. Ref: IBM Maximo.',
    `claimed_amount_to_date` DECIMAL(18,2) COMMENT 'Cumulative monetary value of all warranty claims submitted against this warranty record to date, expressed in USD. Used to track remaining claim capacity against the maximum claim value. Ref: IBM Maximo.',
    `component_covered` STRING COMMENT 'Specific sub-component or assembly of the asset covered by this warranty record (e.g., motor winding, pump impeller, control panel, membrane module). A single asset may have multiple warranty records covering different components. Ref: IBM Maximo.',
    `contract_number` STRING COMMENT 'The vendor-issued or internally-assigned contract number governing the warranty terms and conditions. Used for legal reference and claim dispute resolution. Ref: IBM Maximo.',
    `coverage_end_date` DATE COMMENT 'The date on which warranty coverage expires. Proactive monitoring of this date enables timely claim submission and maintenance routing through warranty channels before expiration, reducing OPEX. Ref: IBM Maximo.',
    `coverage_scope` STRING COMMENT 'Narrative description of what is covered under this warranty, including specific components, failure modes, and exclusions. For example: Covers all mechanical and electrical components of the centrifugal pump excluding wear parts (seals, impellers) and damage caused by cavitation or improper operation.. Ref: IBM Maximo.',
    `coverage_start_date` DATE COMMENT 'The date on which warranty coverage becomes effective. Typically aligned with the asset installation date, commissioning date, or purchase date depending on warranty terms. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this warranty record was first created in the system. Used for audit trail, data lineage, and compliance reporting. Ref: IBM Maximo.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code applicable to all monetary values on this warranty record (e.g., USD). Supports multi-currency environments for international equipment procurement.. Valid values are `^[A-Z]{3}$`',
    `duration_months` STRING COMMENT 'Total length of the warranty coverage period expressed in months. Derived from the vendor contract terms and used for planning and renewal tracking. Ref: IBM Maximo.',
    `exclusions` STRING COMMENT 'Explicit list of conditions, components, or failure modes NOT covered by this warranty. Critical for maintenance routing decisions to avoid voiding coverage through excluded repair activities. Ref: IBM Maximo.',
    `expiry_alert_days` STRING COMMENT 'Number of calendar days before the coverage end date at which an automated alert should be triggered to notify asset managers and maintenance planners of impending warranty expiration. Enables proactive claim submission and maintenance routing. Ref: IBM Maximo.',
    `extended_warranty_cost` DECIMAL(18,2) COMMENT 'The cost paid to purchase an extended warranty beyond the standard manufacturer warranty period, expressed in USD. Captured for CAPEX/OPEX planning and ROI analysis of extended warranty investments. Ref: IBM Maximo.',
    `installation_date` DATE COMMENT 'The date the covered asset or component was physically installed and commissioned. Often used as the warranty coverage start trigger and is required for warranty claim substantiation. Ref: IBM Maximo.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this warranty record was most recently modified. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks lakehouse silver layer. Ref: IBM Maximo.',
    `max_claim_value` DECIMAL(18,2) COMMENT 'The maximum cumulative monetary value of claims that can be submitted under this warranty agreement, expressed in USD. Enables OPEX planning and ensures claims do not exceed contractual limits. Ref: IBM Maximo.',
    `maximo_warranty_code` STRING COMMENT 'The native warranty record identifier from IBM Maximo Asset Management (CMMS). Retained as a cross-reference key to enable bidirectional traceability between the lakehouse silver layer and the operational CMMS source system.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Free-text field for additional warranty-related information not captured in structured fields, such as special claim conditions, vendor negotiation history, or maintenance routing instructions specific to this warranty. Ref: IBM Maximo.',
    `performance_guarantee_metric` STRING COMMENT 'For performance-type warranties, the specific operational metric that is guaranteed (e.g., pump flow rate >= 500 GPM, motor efficiency >= 92%, membrane rejection rate >= 99%). Null for parts/labor-only warranties. Ref: IBM Maximo.',
    `performance_guarantee_threshold` DECIMAL(18,2) COMMENT 'The minimum or target numeric value of the performance guarantee metric that the asset must achieve under the warranty. For example, 500 (GPM) or 92 (%). Used to trigger performance warranty claims when asset output falls below the guaranteed level. Ref: IBM Maximo.',
    `performance_guarantee_unit` STRING COMMENT 'Unit of measure for the performance guarantee threshold value (e.g., GPM, MGD, PSI, %, NTU). Ensures correct interpretation of the numeric threshold in the context of the guaranteed metric. Ref: IBM Maximo.',
    `purchase_date` DATE COMMENT 'The date the asset or component was purchased. Some warranties are triggered from purchase date rather than installation date; retained for accurate coverage period calculation. Ref: IBM Maximo.',
    `purchase_order_number` STRING COMMENT 'The SAP purchase order number associated with the original procurement of the asset or component. Links the warranty to the procurement transaction for audit and claim substantiation. Ref: IBM Maximo.',
    `registration_date` DATE COMMENT 'The date the warranty was formally registered with the vendor or manufacturer. Some warranties require registration within a specified period post-purchase to be valid; failure to register may void coverage. Ref: IBM Maximo.',
    `renewal_option` BOOLEAN COMMENT 'Indicates whether the warranty agreement includes an option to renew or extend coverage beyond the original expiration date. If True, renewal terms and pricing should be captured in the coverage_scope field. Ref: IBM Maximo.',
    `requires_oem_service` BOOLEAN COMMENT 'Indicates whether the warranty terms require that all maintenance and repair work be performed exclusively by the original equipment manufacturer (OEM) or an OEM-authorized service provider. If True, routing non-OEM technicians to this asset may void the warranty. Ref: IBM Maximo.',
    `sap_pm_order_number` STRING COMMENT 'The SAP PM maintenance order number associated with warranty-covered repair or maintenance work. Links warranty coverage to the SAP PM work order for cost recovery and OPEX tracking. Ref: IBM Maximo.',
    `transferable` BOOLEAN COMMENT 'Indicates whether this warranty can be transferred to a new owner or operator in the event of asset sale, transfer, or organizational restructuring. Relevant for capital project asset handovers. Ref: IBM Maximo.',
    `vendor_contact_email` STRING COMMENT 'Email address for the designated warranty claims contact at the vendor or manufacturer. Used for formal claim submission and written correspondence. Ref: IBM Maximo.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Name of the designated warranty claims contact person at the vendor or manufacturer organization. Used to initiate and follow up on warranty claims. Ref: IBM Maximo.',
    `vendor_contact_phone` STRING COMMENT 'Phone number for the designated warranty claims contact at the vendor or manufacturer. Used to initiate and follow up on warranty claims. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `warranty_number` STRING COMMENT 'Externally-known warranty certificate or agreement number assigned by the vendor or manufacturer. Used for claim submission and correspondence with the warranty provider. Aligns with IBM Maximo warranty record identifier.',
    `warranty_status` STRING COMMENT 'Current lifecycle state of the warranty record. active indicates coverage is in force; expired indicates the coverage period has ended; claimed indicates a claim has been submitted and is under review; voided indicates the warranty was invalidated (e.g., unauthorized repair); pending_activation indicates the warranty has been registered but the coverage period has not yet started. Ref: IBM Maximo.. Valid values are `active|expired|claimed|voided|pending_activation`',
    `warranty_type` STRING COMMENT 'Classification of the warranty coverage scope. parts covers replacement components only; labor covers repair labor costs; performance guarantees operational output levels (e.g., pump flow rate, motor efficiency); comprehensive covers both parts and labor; extended is a purchased extension beyond the original term; manufacturer is the standard OEM warranty. Ref: IBM Maximo.. Valid values are `parts|labor|performance|comprehensive|extended|manufacturer`',
    CONSTRAINT pk_warranty PRIMARY KEY(`warranty_id`)
) COMMENT 'Tracks warranty coverage for assets and components, including warranty type (parts, labor, performance), vendor/manufacturer, warranty start and expiration dates, coverage terms, claim submission process, maximum claim value, and warranty status. Enables proactive warranty claim management before expiration and ensures maintenance work is routed through warranty channels when applicable, reducing OPEX.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` (
    `depreciation_schedule_id` BIGINT COMMENT 'Unique system-generated identifier for the depreciation schedule record. Primary key for this entity. Ref: IBM Maximo.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Capitalized assets from CIP projects require depreciation schedules linked to originating project for GASB 34 compliance, rate case justification, and audit trail connecting capital expenditure author. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the capital asset for which this depreciation schedule is maintained. Links to the enterprise asset registry. Ref: IBM Maximo.',
    `depreciation_registry_id` BIGINT COMMENT 'Reference to the capital asset for which this depreciation schedule is maintained. Links to the enterprise asset registry. Ref: IBM Maximo.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Depreciation schedules calculate periodic depreciation expense for fixed assets. Direct link supports automated depreciation posting, GASB 34 infrastructure reporting, and rate base calculations for u. Ref: IBM Maximo.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized from the depreciation start date through the end of the current fiscal period. Represents the contra-asset balance on the balance sheet. Expressed in USD. Ref: IBM Maximo.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total capitalized cost of the asset at acquisition, including purchase price, installation, freight, and any directly attributable costs required to bring the asset to its intended use. Expressed in USD. Ref: IBM Maximo.',
    `annual_depreciation_amount` DECIMAL(18,2) COMMENT 'The total depreciation expense allocated for the full fiscal year for this asset. For straight-line method: depreciable_base / useful_life_years. Expressed in USD. Ref: IBM Maximo.',
    `asset_class_code` STRING COMMENT 'SAP FI-AA asset class code categorizing the type of capital asset for depreciation area assignment and useful life defaults (e.g., PUMP, PIPE, BLDG, VEHICLE, ELEC, METER). Ref: IBM Maximo.',
    `asset_description` STRING COMMENT 'Human-readable description of the capital asset being depreciated (e.g., WTP High-Service Pump Unit 3, WWTP Aeration Blower, 12-inch Ductile Iron Main - Oak Street). Ref: IBM Maximo.',
    `asset_location_code` STRING COMMENT 'Functional location or facility code where the asset is installed (e.g., WTP facility code, WWTP unit, pump station ID, distribution zone). Aligns with IBM Maximo functional location hierarchy and Esri ArcGIS GIS asset registry.',
    `asset_number` STRING COMMENT 'The externally-known fixed asset number as assigned in SAP FI/CO Fixed Asset Accounting (FI-AA) or IBM Maximo. Used for cross-system reconciliation and audit trails.',
    `capex_project_number` STRING COMMENT 'The Capital Improvement Program (CIP) project number associated with the assets acquisition or construction. Links depreciation schedules to CAPEX planning and project close-out reporting. Ref: IBM Maximo.',
    `capitalization_date` DATE COMMENT 'The date the asset was formally capitalized and transferred from construction-in-progress (CIP) to fixed assets in SAP FI-AA. May differ from depreciation start date for assets with a commissioning lag. Ref: IBM Maximo.',
    `company_code` STRING COMMENT 'SAP FI company code representing the legal entity or municipal utility enterprise to which this depreciation schedule belongs. Supports multi-entity financial reporting and GASB fund accounting. Ref: IBM Maximo.',
    `cost_center_code` STRING COMMENT 'SAP CO cost center to which depreciation charges are posted, enabling OPEX/CAPEX allocation by operational unit (e.g., WTP operations, distribution, wastewater). Ref: IBM Maximo.',
    `declining_balance_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied per period for declining balance or double declining balance depreciation methods. Expressed as a decimal (e.g., 0.2000 = 20%). Null for straight-line method. Ref: IBM Maximo.',
    `depreciable_base` DECIMAL(18,2) COMMENT 'The amount subject to depreciation, calculated as acquisition cost minus salvage value. This is the total amount to be allocated over the assets useful life. Expressed in USD. Ref: IBM Maximo.',
    `depreciation_area_code` STRING COMMENT 'SAP FI-AA depreciation area identifier representing the valuation purpose (e.g., 01 for book depreciation per GAAP/GASB, 15 for tax depreciation, 20 for cost accounting). Supports parallel valuation for regulatory and tax reporting. Ref: IBM Maximo.',
    `depreciation_convention` STRING COMMENT 'The period convention applied to determine depreciation in the first and last year of the assets life (e.g., full_month, half_year, pro_rata). Aligns with SAP FI-AA period control settings. Ref: IBM Maximo.. Valid values are `full_month|half_year|mid_quarter|mid_month|pro_rata`',
    `depreciation_end_date` DATE COMMENT 'The projected or actual date on which depreciation ceases, corresponding to the end of the assets useful life or full depreciation of the depreciable base. Ref: IBM Maximo.',
    `depreciation_key` STRING COMMENT 'SAP FI-AA depreciation key code that defines the calculation method, period control, and base value for depreciation posting (e.g., LINR for straight-line, 0000 for no depreciation). Enables direct reconciliation with SAP Fixed Asset Accounting. Ref: IBM Maximo.',
    `depreciation_method` STRING COMMENT 'Accounting method used to allocate the depreciable base over the assets useful life. Straight-line is most common for municipal water utility infrastructure per GASB. [ENUM-REF-CANDIDATE: straight_line|declining_balance|double_declining_balance|units_of_production|sum_of_years_digits — promote to reference product]. Ref: IBM Maximo.. Valid values are `straight_line|declining_balance|double_declining_balance|units_of_production|sum_of_years_digits`',
    `depreciation_start_date` DATE COMMENT 'The date on which depreciation begins for the asset, typically the in-service date or acquisition date per GAAP/GASB capitalization policy. Ref: IBM Maximo.',
    `disposal_date` DATE COMMENT 'The date the asset was retired, disposed of, or decommissioned. Triggers cessation of depreciation and recognition of any gain or loss on disposal in SAP FI-AA. Ref: IBM Maximo.',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Cash or fair value received upon disposal or sale of the asset. Used to calculate gain or loss on disposal: disposal_proceeds minus net_book_value at disposal date. Expressed in USD. Ref: IBM Maximo.',
    `fiscal_period` STRING COMMENT 'The accounting period (month 1–12) within the fiscal year for which this depreciation record applies. Enables monthly depreciation posting and period-end close reconciliation in SAP FI/CO. Ref: IBM Maximo.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this depreciation schedule record applies. Supports annual depreciation posting, CAPEX/OPEX reporting, and GASB financial statement preparation. Ref: IBM Maximo.',
    `fund_code` STRING COMMENT 'Governmental fund code (e.g., Enterprise Fund, Capital Projects Fund) to which the asset and its depreciation are attributed, per GASB fund accounting requirements for municipal utilities. Ref: IBM Maximo.',
    `gl_account_code` STRING COMMENT 'SAP FI General Ledger account code for the depreciation expense posting (e.g., the depreciation expense account and accumulated depreciation contra-asset account). Enables financial statement mapping. Ref: IBM Maximo.',
    `impairment_loss` DECIMAL(18,2) COMMENT 'Cumulative impairment charges recognized against the asset when its carrying value exceeds its recoverable amount, per GAAP ASC 360 impairment testing. Reduces net book value beyond scheduled depreciation. Expressed in USD. Ref: IBM Maximo.',
    `in_service_date` DATE COMMENT 'The date the asset was placed into operational service. This is the trigger date for depreciation commencement per GAAP/GASB policy and aligns with IBM Maximo asset activation.',
    `last_reviewed_date` DATE COMMENT 'Date the depreciation schedule was last reviewed and validated by the asset accounting team, supporting annual audit requirements and GASB financial statement preparation. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset on the balance sheet, calculated as acquisition cost minus accumulated depreciation. Key metric for CAPEX/OPEX planning and asset renewal decisions. Expressed in USD. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Free-text field for recording significant accounting judgments, useful life revision rationale, impairment triggers, regulatory directives, or other material information relevant to this depreciation schedule. Ref: IBM Maximo.',
    `period_depreciation_amount` DECIMAL(18,2) COMMENT 'The depreciation expense allocated for the specific fiscal period (month). Used for monthly journal entry posting to the depreciation expense account in SAP FI/CO. Expressed in USD. Ref: IBM Maximo.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this depreciation schedule record was first created in the system, supporting audit trail and data lineage requirements. Ref: IBM Maximo.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this depreciation schedule record was last modified, supporting change tracking, audit trail, and period-end reconciliation. Ref: IBM Maximo.',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Estimated remaining useful life of the asset in years as of the last assessment date. Used for condition-based depreciation adjustments and asset renewal planning under CIP. Ref: IBM Maximo.',
    `reviewed_by` STRING COMMENT 'Name or employee ID of the asset accountant or finance officer who last reviewed and approved this depreciation schedule record, supporting audit trail and SOX/GASB compliance. Ref: IBM Maximo.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life, used to calculate the depreciable base. For most water utility infrastructure, this is often zero. Expressed in USD. Ref: IBM Maximo.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the depreciation schedule record. active = depreciation ongoing; suspended = temporarily halted (e.g., asset taken out of service); fully_depreciated = net book value at or near salvage value; disposed = asset retired; impaired = impairment recognized; draft = pending approval. Ref: IBM Maximo.. Valid values are `active|suspended|fully_depreciated|disposed|impaired|draft`',
    `units_of_production_period` DECIMAL(18,2) COMMENT 'Actual production units consumed during the current fiscal period, used to calculate period depreciation under the units-of-production method (e.g., gallons pumped, operating hours logged via SCADA/OSIsoft PI Historian).',
    `units_of_production_total` DECIMAL(18,2) COMMENT 'Total estimated production units over the assets useful life, used as the denominator for units-of-production depreciation method (e.g., total gallons pumped, total operating hours). Applicable only when depreciation_method = units_of_production. Ref: IBM Maximo.',
    `useful_life_revised_years` STRING COMMENT 'Updated estimated useful life in years following a formal engineering reassessment or condition assessment. Replaces original useful_life_years for prospective depreciation calculation. Ref: IBM Maximo.',
    `useful_life_revision_date` DATE COMMENT 'Date on which the assets estimated useful life was last revised, triggering a prospective change in depreciation calculation per GAAP ASC 250 change in accounting estimate. Ref: IBM Maximo.',
    `useful_life_years` STRING COMMENT 'Estimated useful life of the asset in years, as determined by engineering assessment and aligned with AWWA asset life guidelines and GASB/GAAP standards (e.g., 50 years for water mains, 20 years for pumps, 10 years for meters).',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `wbs_element` STRING COMMENT 'SAP PS Work Breakdown Structure element linking the asset to its originating Capital Improvement Program (CIP) project for CAPEX tracking and project settlement. Ref: IBM Maximo.',
    CONSTRAINT pk_depreciation_schedule PRIMARY KEY(`depreciation_schedule_id`)
) COMMENT 'Financial depreciation schedule for capital assets, capturing acquisition cost, salvage value, useful life (years), depreciation method (straight-line, declining balance, units of production), annual depreciation amount, accumulated depreciation, net book value, and depreciation start date. Aligned with GAAP/GASB standards for municipal utility accounting. Integrates with SAP FI/CO Fixed Asset module and supports CAPEX/OPEX reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` (
    `acquisition_id` BIGINT COMMENT 'Unique identifier for the asset acquisition record. Primary key for the asset acquisition data product. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the asset being acquired in the asset registry. Links this acquisition to the corresponding asset_registry record. Ref: IBM Maximo.',
    `acquisition_registry_id` BIGINT COMMENT 'Reference to the asset being acquired in the asset registry. Links this acquisition to the corresponding asset_registry record. Ref: IBM Maximo.',
    `cip_project_id` BIGINT COMMENT 'Capital Improvement Program project identifier if the asset was acquired as part of a capital project. Links to project management and budget tracking. Ref: IBM Maximo.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Acquisitions are charged to departmental cost centers for capital budget tracking, CIP program management, and accountability. Supports budget-to-actual variance reporting for capital projects. Ref: IBM Maximo.',
    `facility_id` BIGINT COMMENT 'Identifier for the Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), pump station, or other facility where the asset is located. Ref: IBM Maximo.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Capital asset acquisitions post to specific GL accounts for capitalization, depreciation tracking, and GASB 34 infrastructure reporting. Critical for financial statement preparation and regulatory com. Ref: IBM Maximo.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor in the procurement or Enterprise Resource Planning (ERP) system. Ref: IBM Maximo.',
    `acquisition_date` DATE COMMENT 'Date on which the asset was legally acquired or title transferred to the utility. Used for depreciation start date calculation and asset lifecycle tracking. Ref: IBM Maximo.',
    `acquisition_status` STRING COMMENT 'Current status of the acquisition record in the workflow. Tracks progression from initiation through completion and asset registry creation. Ref: IBM Maximo.. Valid values are `pending|approved|completed|cancelled`',
    `acquisition_type` STRING COMMENT 'Method by which the asset was acquired into the utilitys asset base. Determines accounting treatment and capitalization rules. Ref: IBM Maximo.. Valid values are `purchase|construction|donation|transfer|lease`',
    `approval_date` DATE COMMENT 'Date on which the asset acquisition was formally approved by the designated authority. Part of the audit trail. Ref: IBM Maximo.',
    `approved_by` STRING COMMENT 'Name or identifier of the manager or authority who approved the asset acquisition. Required for audit trail and governance. Ref: IBM Maximo.',
    `asset_category` STRING COMMENT 'Detailed categorization within the asset class such as pump, valve, pipe, tank, or vehicle. Supports asset hierarchy and reporting. Ref: IBM Maximo.',
    `asset_class` STRING COMMENT 'High-level classification of the asset type such as treatment equipment, distribution infrastructure, collection system, or vehicle. Used for depreciation schedule assignment. Ref: IBM Maximo.',
    `capitalization_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum dollar amount threshold for capitalizing an asset as defined by the utilitys accounting policy. Typically ranges from $1,000 to $5,000 for water utilities. Ref: IBM Maximo.',
    `capitalization_threshold_met_flag` BOOLEAN COMMENT 'Indicates whether the acquisition cost meets the utilitys capitalization threshold for fixed asset recording. Determines if asset is capitalized or expensed. Ref: IBM Maximo.',
    `commissioning_date` DATE COMMENT 'Date on which the asset was placed into service and became operational. Marks the start of depreciation for accounting purposes. Ref: IBM Maximo.',
    `contractor_name` STRING COMMENT 'Name of the construction contractor who built or installed the asset, applicable for construction acquisition type. Ref: IBM Maximo.',
    `cost` DECIMAL(18,2) COMMENT 'Total cost of acquiring the asset including purchase price, installation, freight, and other capitalizable costs. Basis for depreciation calculation. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset acquisition record was first created in the system. Audit field for data lineage and compliance. Ref: IBM Maximo.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost. Typically USD for United States water utilities.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the asset over its useful life. Straight-line is most common for water utility infrastructure. Ref: IBM Maximo.. Valid values are `straight_line|declining_balance|units_of_production`',
    `functional_location` STRING COMMENT 'SAP PM functional location code representing the hierarchical location of the asset within the utilitys infrastructure. Supports Geographic Information System (GIS) integration. Ref: IBM Maximo.',
    `funding_source` STRING COMMENT 'Source of funds used to finance the asset acquisition. Critical for Capital Expenditure (CAPEX) tracking and regulatory rate case filings. Ref: IBM Maximo.. Valid values are `capex|grant|bond|developer_contribution|rate_revenue|loan`',
    `grant_award_num` STRING COMMENT 'Unique identifier for the grant award that funded the acquisition, required for grant compliance reporting. Ref: IBM Maximo.',
    `grant_program_name` STRING COMMENT 'Name of the federal, state, or local grant program that funded the acquisition, if applicable. Examples include EPA Water Infrastructure Finance and Innovation Act (WIFIA) or State Revolving Fund (SRF). Ref: IBM Maximo.',
    `initial_condition_grade` STRING COMMENT 'Condition assessment grade assigned at the time of acquisition. Baseline for future condition monitoring and asset health tracking. Ref: IBM Maximo.. Valid values are `excellent|good|fair|poor|critical`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset acquisition record was last updated. Audit field for change tracking and data quality monitoring. Ref: IBM Maximo.',
    `maximo_asset_num` STRING COMMENT 'IBM Maximo Computerized Maintenance Management System (CMMS) asset number assigned at acquisition. External system identifier for cross-reference.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Free-text notes documenting special circumstances, conditions, or details about the asset acquisition. Supports audit trail and historical context. Ref: IBM Maximo.',
    `purchase_order_num` STRING COMMENT 'Purchase order number from SAP Materials Management (MM) or procurement system authorizing the asset acquisition. Links to procurement transaction. Ref: IBM Maximo.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. Used in depreciation calculation for certain methods. Ref: IBM Maximo.',
    `sap_equipment_num` STRING COMMENT 'SAP Enterprise Resource Planning (ERP) Plant Maintenance (PM) equipment number assigned at acquisition. External system identifier for cross-reference. Ref: IBM Maximo.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the asset in years for depreciation calculation. Varies by asset class per Generally Accepted Accounting Principles (GAAP) and Governmental Accounting Standards Board (GASB) guidelines. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `warranty_duration_months` STRING COMMENT 'Duration of the warranty period in months. Calculated from warranty start and expiry dates for reporting purposes. Ref: IBM Maximo.',
    `warranty_expiry_date` DATE COMMENT 'Date on which the manufacturer or contractor warranty period ends. Critical for maintenance planning and defect liability tracking. Ref: IBM Maximo.',
    `warranty_start_date` DATE COMMENT 'Date on which the manufacturer or contractor warranty period begins for the acquired asset. Ref: IBM Maximo.',
    `work_order_num` STRING COMMENT 'Work order number from IBM Maximo or SAP PM for construction or installation activities related to the acquisition.',
    CONSTRAINT pk_acquisition PRIMARY KEY(`acquisition_id`)
) COMMENT 'Records the acquisition of new assets into the utilitys asset base, capturing acquisition type (purchase, construction, donation, transfer), acquisition date, purchase order reference, vendor/contractor, acquisition cost, funding source (CAPEX, grant, developer contribution), commissioning date, and initial condition grade. Triggers creation of the asset_registry record and depreciation_schedule. Integrates with SAP MM purchase orders and SAP FI asset capitalization.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`disposal` (
    `disposal_id` BIGINT COMMENT 'Unique identifier for the asset disposal record. Primary key for the asset disposal transaction. Ref: IBM Maximo.',
    `cip_project_id` BIGINT COMMENT 'Reference to the CIP project that triggered the asset replacement and disposal, if applicable. Links disposal to capital planning and renewal programs. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the asset being disposed from the asset registry. Links to the physical infrastructure asset (pipe, pump, valve, equipment, vehicle) that is being retired or decommissioned. Ref: IBM Maximo.',
    `disposal_replacement_asset_registry_id` BIGINT COMMENT 'Reference to the new asset that replaced the disposed asset, if disposal reason was replacement. Links retired asset to its successor for lifecycle tracking. Ref: IBM Maximo.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Asset disposals generate gain/loss transactions posted to specific GL accounts for financial reporting. Required for accurate net book value adjustments and GASB compliance in financial statements. Ref: IBM Maximo.',
    `primary_disposal_registry_id` BIGINT COMMENT 'Reference to the asset being disposed from the asset registry. Links to the physical infrastructure asset (pipe, pump, valve, equipment, vehicle) that is being retired or decommissioned. Ref: IBM Maximo.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or contractor who performed the disposal, demolition, or removal services. Links to vendor master data in SAP MM or procurement system. Ref: IBM Maximo.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'The total depreciation expense accumulated on the asset from installation date through disposal date. Used in calculating book value and gain/loss on disposal. Ref: IBM Maximo.',
    `approval_date` DATE COMMENT 'The date on which the disposal transaction was formally approved by the authorizing approver. Required before disposal can proceed. Ref: IBM Maximo.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorizing approver who approved the asset disposal. Typically a senior manager, director, or capital planning committee member with authority over asset retirement decisions. Ref: IBM Maximo.',
    `book_value_at_disposal` DECIMAL(18,2) COMMENT 'The net book value (original acquisition cost minus accumulated depreciation) of the asset at the time of disposal. Used to calculate gain or loss on disposal for financial reporting. Ref: IBM Maximo.',
    `buyer_contact_info` STRING COMMENT 'Contact information (phone, email, or address) for the buyer of the asset. Used for transfer documentation and warranty transfer. Confidential business contact data. Ref: IBM Maximo.',
    `buyer_name` STRING COMMENT 'Name of the individual or organization that purchased the asset, if disposal method was sale or auction. Null for other disposal methods. Ref: IBM Maximo.',
    `completion_date` DATE COMMENT 'The date on which the physical disposal activity was completed. May differ from disposal effective date if removal or demolition took multiple days. Ref: IBM Maximo.',
    `cost` DECIMAL(18,2) COMMENT 'The total cost incurred to dispose of the asset. Includes demolition costs, removal costs, environmental remediation, transportation, and disposal fees. Ref: IBM Maximo.',
    `cost_center` STRING COMMENT 'The cost center responsible for the asset at the time of disposal. Used for departmental cost allocation and budget tracking. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this disposal record was first created in the system. Audit trail for record creation. Ref: IBM Maximo.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this disposal record. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `disposal_date` DATE COMMENT 'The date on which the asset was officially retired or disposed. This is the principal business event date that triggers SAP FI-AA asset retirement posting and updates the asset registry operational status to Retired. Ref: IBM Maximo.',
    `disposal_number` STRING COMMENT 'Business identifier for the disposal transaction. Externally-known unique number used for tracking and audit purposes across SAP FI-AA and Maximo. Ref: IBM Maximo.',
    `disposal_status` STRING COMMENT 'Current lifecycle status of the disposal transaction. Tracks workflow from initiation through final completion and posting to financial systems. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_progress|completed|cancelled|reversed — 7 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `environmental_clearance_date` DATE COMMENT 'The date on which environmental clearance was obtained, if required. Null if no clearance was required. Ref: IBM Maximo.',
    `environmental_clearance_notes` STRING COMMENT 'Free-text notes documenting environmental clearance process, remediation actions taken, or hazardous material handling procedures followed during disposal. Ref: IBM Maximo.',
    `environmental_clearance_required` BOOLEAN COMMENT 'Indicates whether environmental clearance or remediation was required before disposal. True for assets containing hazardous materials, lead pipes, asbestos insulation, or contaminated equipment. Ref: IBM Maximo.',
    `gain_loss_on_disposal` DECIMAL(18,2) COMMENT 'The accounting gain or loss recognized on the disposal transaction, calculated as net disposal value minus book value at disposal. Positive values represent gains, negative values represent losses. Ref: IBM Maximo.',
    `initiated_by` STRING COMMENT 'Name or identifier of the employee or department that initiated the disposal request. Typically an asset manager, operations supervisor, or maintenance planner.',
    `last_modified_by` STRING COMMENT 'The user identifier or name of the person who last modified this disposal record. Audit trail for accountability. Ref: IBM Maximo.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this disposal record was last updated. Audit trail for record modification. Ref: IBM Maximo.',
    `location` STRING COMMENT 'The physical location or facility where the asset was disposed, demolished, or removed from. May be a treatment plant, pump station, or field location. Ref: IBM Maximo.',
    `maximo_disposal_code` STRING COMMENT 'The disposal transaction identifier in IBM Maximo CMMS. Used for cross-system reconciliation and audit trail between Maximo and SAP FI-AA.',
    `method` STRING COMMENT 'The method by which the asset was disposed. Indicates whether the asset was sold, scrapped, transferred to another entity, donated, demolished, or salvaged for parts. [ENUM-REF-CANDIDATE: salvage|demolition|sale|donation|transfer|scrap|auction — 7 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `net_disposal_value` DECIMAL(18,2) COMMENT 'The net financial result of the disposal transaction, calculated as disposal proceeds minus disposal costs. May be positive (gain) or negative (loss). Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, special handling instructions, lessons learned, or other relevant information about the disposal transaction. Ref: IBM Maximo.',
    `proceeds` DECIMAL(18,2) COMMENT 'The monetary amount received from the disposal of the asset, if any. Represents sale price, salvage value, or auction proceeds. Zero for demolition or scrap with no recovery value. Ref: IBM Maximo.',
    `retirement_reason` STRING COMMENT 'The primary business or operational reason for retiring the asset. Captures whether disposal was due to end of useful life, failure, regulatory mandate, planned replacement, or other strategic decision. [ENUM-REF-CANDIDATE: end_of_life|catastrophic_failure|obsolescence|regulatory_requirement|replacement|consolidation|capacity_reduction|safety_hazard|environmental_compliance — 9 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `retirement_reason_notes` STRING COMMENT 'Free-text narrative providing additional context and details about the reason for asset retirement. May include failure analysis, condition assessment summary, or regulatory citation. Ref: IBM Maximo.',
    `sap_asset_retirement_doc` STRING COMMENT 'The SAP FI-AA asset retirement document number generated when the disposal transaction was posted to the financial system. Used for financial audit and reconciliation. Ref: IBM Maximo.',
    `sap_posting_date` DATE COMMENT 'The date on which the asset retirement transaction was posted to SAP FI-AA general ledger. May differ from disposal date due to period-end closing rules. Ref: IBM Maximo.',
    `transfer_to_entity` STRING COMMENT 'Name of the entity (department, municipality, or organization) to which the asset was transferred, if disposal method was transfer. Null for other disposal methods. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `work_order_number` STRING COMMENT 'The Maximo work order number associated with the physical removal, demolition, or disposal activity. Links disposal transaction to field execution. Ref: IBM Maximo.',
    `created_by` STRING COMMENT 'The user identifier or name of the person who created this disposal record. Audit trail for accountability. Ref: IBM Maximo.',
    CONSTRAINT pk_disposal PRIMARY KEY(`disposal_id`)
) COMMENT 'Records the retirement, disposal, or decommissioning of assets from the utilitys active inventory. Captures disposal date, disposal method (salvage, demolition, sale, transfer), disposal proceeds, reason for retirement (end of life, failure, regulatory, replacement), authorizing approver, and final book value at disposal. Triggers SAP FI-AA asset retirement posting and updates asset_registry operational status to Retired.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` (
    `inspection_event_id` BIGINT COMMENT 'Unique identifier for the inspection event record. Primary key. Ref: IBM Maximo.',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), or other facility where the inspection occurred. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the asset or infrastructure component that was inspected. Ref: IBM Maximo.',
    `inspection_checklist_id` BIGINT COMMENT 'Reference to the standardized inspection checklist or form template used during the inspection. Ref: IBM Maximo.',
    `inspection_registry_id` BIGINT COMMENT 'Reference to the asset or infrastructure component that was inspected. Ref: IBM Maximo.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who performed the inspection. Ref: IBM Maximo.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Inspections trigger compliance and investigative sampling: tank inspections require bacteriological verification, cross-connection inspections require water quality testing, valve inspections may trig. Ref: IBM Maximo.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Inspections of backflow prevention devices, service laterals, and customer-owned infrastructure occur at premises. Required for cross-connection control programs, LCRR compliance, and regulatory repor',
    `primary_inspection_approved_by_employee_id` BIGINT COMMENT 'Reference to the supervisor or manager who reviewed and approved the inspection results.',
    `project_permit_id` BIGINT COMMENT 'Foreign key linking to project.project_permit. Business justification: Operational compliance inspections (NPDES, drinking water, dam safety) reference permits issued during project phase; regulatory reporting requires linking inspection findings to permit conditions, de. Ref: IBM Maximo.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Regulatory inspections (sanitary surveys, LCRR system assessments, tank inspections) include water quality sampling as part of the inspection protocol. Real business need: compliance documentation lin',
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
    `permit_number` STRING COMMENT 'External permit identifier issued by the regulatory authority, if this inspection is tied to permit compliance. Ref: IBM Maximo.',
    `regulatory_agency` STRING COMMENT 'Name of the regulatory authority that mandated or oversees this inspection (e.g., EPA, state primacy agency, OSHA).',
    `regulatory_inspection_flag` BOOLEAN COMMENT 'Indicates whether this inspection was mandated by a regulatory authority (EPA, state primacy agency, OSHA) or was voluntary/internal.',
    `report_submission_date` DATE COMMENT 'Date on which the inspection report was submitted to the regulatory authority. Ref: IBM Maximo.',
    `report_submitted_flag` BOOLEAN COMMENT 'Indicates whether the inspection report has been submitted to the regulatory authority, if required. Ref: IBM Maximo.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident or near-miss occurred during the inspection activity. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure entity touched. Ref: IBM Maximo.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of inspection, relevant for outdoor infrastructure inspections (pipes, valves, tanks). Ref: IBM Maximo.',
    CONSTRAINT pk_inspection_event PRIMARY KEY(`inspection_event_id`)
) COMMENT 'Operational record of a physical inspection performed on an asset or infrastructure component, including inspection type (routine, regulatory, post-incident, pre-commissioning), inspector identity, inspection date, checklist used, pass/fail outcome, deficiencies identified, corrective action required flag, and regulatory permit reference. Distinct from condition_assessment (which produces a scored condition grade) — inspection_event captures compliance-driven inspection activities required by EPA, state primacy agencies, and OSHA.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`document` (
    `document_id` BIGINT COMMENT 'Unique identifier for the asset document record. Primary key for the asset document registry. Ref: IBM Maximo.',
    `certificate_of_analysis_id` BIGINT COMMENT 'Foreign key linking to laboratory.certificate_of_analysis. Business justification: Asset files contain certificates of analysis for treatment chemicals, pipe materials, coatings, and construction materials. Standard procurement documentation and regulatory compliance requirement for. Ref: IBM Maximo.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: As-built drawings, O&M manuals, warranty certificates, and technical specifications generated during capital projects must reference the originating CIP project for asset lifecycle documentation, regu. Ref: IBM Maximo.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the regulatory permit this document is associated with, if applicable. Ref: IBM Maximo.',
    `design_contract_id` BIGINT COMMENT 'Foreign key linking to project.design_contract. Business justification: Design deliverables (calculations, specifications, technical memoranda, basis-of-design reports) are design contract work products; professional liability claims, design standard compliance verificati. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset this document is associated with. Links to the asset registry. Ref: IBM Maximo.',
    `document_registry_id` BIGINT COMMENT 'Reference to the physical asset this document is associated with. Links to the asset registry for equipment, pipes, pumps, valves, and other infrastructure. Ref: IBM Maximo.',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), or other facility this document pertains to. Ref: IBM Maximo.',
    `employee_id` BIGINT COMMENT 'Employee identifier for the internal staff member who approved the document. Ref: IBM Maximo.',
    `primary_superseded_by_document_id` BIGINT COMMENT 'Reference to the newer document that replaces this document. Maintains document version lineage and ensures users access the current revision. Ref: IBM Maximo.',
    `work_order_id` BIGINT COMMENT 'Reference to a work order that generated or is associated with this document, such as inspection reports or maintenance records. Ref: IBM Maximo.',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Asset documentation packages include laboratory test results for commissioning reports, material certifications, water quality compliance records, and coating/lining verification. Required for regulat. Ref: IBM Maximo.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier who provided the document, applicable for vendor-supplied documentation such as manuals and specifications. Ref: IBM Maximo.',
    `access_restriction` STRING COMMENT 'Description of who may access the document. Defines user roles, departments, or security clearances required for document access. Ref: IBM Maximo.',
    `approval_date` DATE COMMENT 'Date when the document received official approval for release and use. Ref: IBM Maximo.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the document for use. Establishes document authority and accountability. Ref: IBM Maximo.',
    `approved_date` DATE COMMENT 'Date when the document was formally approved. Marks the transition to active status. Ref: IBM Maximo.',
    `author_name` STRING COMMENT 'Name of the individual or organization that created the document. Identifies the document originator for accountability. Ref: IBM Maximo.',
    `author_organization` STRING COMMENT 'Organization or company that produced the document. Relevant for vendor-supplied documentation and external engineering firms. Ref: IBM Maximo.',
    `document_category` STRING COMMENT 'High-level categorization of the document by business function. Supports document organization and retrieval. Ref: IBM Maximo.. Valid values are `technical|regulatory|operational|safety|quality|environmental`',
    `compliance_standard` STRING COMMENT 'Industry or regulatory standard that the document complies with. Examples include AWWA standards, ISO 55001, SDWA, CWA, or OSHA regulations.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the document content. Determines access controls and distribution restrictions. Ref: IBM Maximo.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the document record was first created in the system. Supports audit trails and data lineage. Ref: IBM Maximo.',
    `document_description` STRING COMMENT 'Detailed description of the document content, scope, and purpose. Supports document search and classification. Ref: IBM Maximo.',
    `destruction_eligible_date` DATE COMMENT 'Calculated date when the document becomes eligible for destruction based on retention policies. Ref: IBM Maximo.',
    `disposal_date` DATE COMMENT 'Date when the document is eligible for destruction or archival per retention policy. Supports records lifecycle management. Ref: IBM Maximo.',
    `document_number` STRING COMMENT 'Unique business identifier for the document. Used for tracking and retrieval in document management systems and regulatory audits. Ref: IBM Maximo.',
    `document_status` STRING COMMENT 'Current lifecycle status of the document. Tracks document progression through review, approval, and archival processes. [ENUM-REF-CANDIDATE: draft|under_review|approved|active|superseded|archived|obsolete — 7 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `document_type` STRING COMMENT 'Classification of the document type. Categorizes documents by their purpose and content to support ISO 55001 documentation requirements and regulatory audit readiness. [ENUM-REF-CANDIDATE: as_built_drawing|om_manual|equipment_datasheet|commissioning_report|test_certificate|regulatory_permit|warranty_document|inspection_report|maintenance_procedure|safety_data_sheet — 10 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date when the document becomes effective and applicable for use. Critical for regulatory permits and compliance documentation. Ref: IBM Maximo.',
    `expiration_date` DATE COMMENT 'Date when the document expires or is no longer valid. Applicable to permits, certifications, and time-limited approvals. Ref: IBM Maximo.',
    `file_format` STRING COMMENT 'Digital file format of the document. Identifies the software and tools required to view and edit the document. [ENUM-REF-CANDIDATE: pdf|dwg|dxf|docx|xlsx|jpg|png|tif — 8 candidates stripped; promote to reference product]. Ref: IBM Maximo.',
    `file_name` STRING COMMENT 'Name of the digital file as stored in the document management system. Includes file extension for format identification. Ref: IBM Maximo.',
    `file_size_kb` DECIMAL(18,2) COMMENT 'Size of the electronic document file measured in kilobytes. Ref: IBM Maximo.',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the document file in megabytes. Used for storage management and download time estimation. Ref: IBM Maximo.',
    `gis_feature_code` BOOLEAN COMMENT 'Identifier for the associated GIS feature in Esri ArcGIS. Links documents to spatial assets such as pipes, valves, and facilities. Ref: IBM Maximo.',
    `issue_date` DATE COMMENT 'Date when the document was officially issued or published for use. Ref: IBM Maximo.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags for document search and classification. Enhances document discoverability in the document management system. Ref: IBM Maximo.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the primary language of the document. Supports multilingual document management.. Valid values are `ENG|SPA|FRA`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the document record was last updated. Tracks the most recent change to the document metadata. Ref: IBM Maximo.',
    `maximo_document_code` STRING COMMENT 'Document identifier in IBM Maximo CMMS. Provides traceability to the source system for asset management integration.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Additional comments, instructions, or context about the document. Provides supplementary information not captured in other fields. Ref: IBM Maximo.',
    `regulatory_agency` STRING COMMENT 'Name of the regulatory agency that requires or issued the document. Examples include EPA, state drinking water programs, OSHA, or local health departments.',
    `regulatory_reference` STRING COMMENT 'Citation or reference to the regulatory requirement, permit, or compliance obligation that this document supports or fulfills. Ref: IBM Maximo.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether the document is required by regulatory agencies such as EPA, state primacy agencies, or OSHA. Critical for compliance audit readiness.',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per regulatory or business policy requirements. Supports records management and compliance. Ref: IBM Maximo.',
    `retention_trigger_date` DATE COMMENT 'Date from which the retention period begins, typically the document effective date or superseded date. Ref: IBM Maximo.',
    `review_due_date` DATE COMMENT 'Scheduled date for the next periodic review of the document to ensure continued accuracy and relevance. Ref: IBM Maximo.',
    `review_frequency_months` STRING COMMENT 'Standard interval in months between scheduled reviews of the document. Ref: IBM Maximo.',
    `reviewed_by` STRING COMMENT 'Name of the individual who reviewed the document for technical accuracy and completeness. Part of document quality control process. Ref: IBM Maximo.',
    `reviewed_date` DATE COMMENT 'Date when the document review was completed. Tracks document quality assurance timeline. Ref: IBM Maximo.',
    `revision_date` DATE COMMENT 'Date when the current revision of the document was created or last modified. Supports version tracking and audit trails. Ref: IBM Maximo.',
    `revision_number` STRING COMMENT 'Version or revision identifier for the document. Tracks document changes and updates over time to maintain version control. Ref: IBM Maximo.',
    `sap_document_number` STRING COMMENT 'Document number in SAP ERP system. Links to SAP PM or MM modules for equipment documentation and procurement records. Ref: IBM Maximo.',
    `storage_location` STRING COMMENT 'Physical or electronic location where the document is stored, such as file path, cabinet number, or repository identifier. Ref: IBM Maximo.',
    `storage_location_url` STRING COMMENT 'URL or file path to the document in the document management system. Provides direct access to the digital document file. Ref: IBM Maximo.',
    `title` STRING COMMENT 'Descriptive title of the document. Provides human-readable identification of the document content and purpose. Ref: IBM Maximo.',
    `url` STRING COMMENT 'Web address or hyperlink to access the electronic document in the document management system or external repository. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Marker set by asset-domain synthesizer. Ref: IBM Maximo.',
    CONSTRAINT pk_document PRIMARY KEY(`document_id`)
) COMMENT 'Master reference table for asset_document. ';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` (
    `procurement_mapping_id` BIGINT COMMENT 'Unique surrogate identifier for the asset class to procurement category mapping record. Ref: IBM Maximo.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to the asset class being sourced. Ref: IBM Maximo.',
    `material_master_id` BIGINT COMMENT 'Link to material master record. Ref: IBM Maximo.',
    `vendor_id` BIGINT COMMENT 'Secondary alternate vendor for procurement of this asset class. Ref: IBM Maximo.',
    `procurement_category_id` BIGINT COMMENT 'Foreign key linking to the procurement category used for sourcing. Ref: IBM Maximo.',
    `procurement_contract_id` BIGINT COMMENT 'Link to procurement contract. Ref: IBM Maximo.',
    `procurement_default_vendor_id` BIGINT COMMENT 'Default vendor for this asset class procurement. Ref: IBM Maximo.',
    `procurement_preferred_vendor_id` BIGINT COMMENT 'Primary preferred vendor for procurement of this asset class. Ref: IBM Maximo.',
    `procurement_vendor_id` BIGINT COMMENT 'Preferred vendor for this asset class. Ref: IBM Maximo.',
    `employee_id` BIGINT COMMENT 'Employee identifier for the procurement professional who last updated this mapping. Ref: IBM Maximo.',
    `annual_demand_forecast` STRING COMMENT 'Forecasted annual demand quantity for procurement planning. Ref: IBM Maximo.',
    `annual_spend_amount` DECIMAL(18,2) COMMENT 'Annual spend for this asset class. Ref: IBM Maximo.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates if special approval is required for procurement. Ref: IBM Maximo.',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'Dollar threshold requiring approval. Ref: IBM Maximo.',
    `approved_vendor_count` STRING COMMENT 'Number of approved vendors for this asset class within this procurement category. Used for supplier diversity analysis and sourcing risk assessment. Ref: IBM Maximo.',
    `asset_category` STRING COMMENT 'Category of asset (e.g., Meters, Pipes, Valves, Pumps). Ref: IBM Maximo.',
    `average_unit_cost` DECIMAL(18,2) COMMENT 'Benchmark average unit cost in USD for items of this asset class when procured through this category. Used for budgeting, cost variance analysis, and procurement performance tracking. Ref: IBM Maximo.',
    `bid_threshold_amount` DECIMAL(18,2) COMMENT 'Dollar threshold above which competitive bidding is required. Ref: IBM Maximo.',
    `buy_america_compliant_flag` BOOLEAN COMMENT 'Indicates whether the procurement mapping requires Buy America Act compliance per IIJA/BIL requirements. Ref: IBM Maximo.',
    `buy_america_required_flag` BOOLEAN COMMENT 'Indicates if Buy America Act compliance is required. Ref: IBM Maximo.',
    `capitalization_threshold` DECIMAL(18,2) COMMENT 'Capitalization threshold amount. Ref: IBM Maximo.',
    `commodity_code` STRING COMMENT 'Commodity code (e.g., UNSPSC, NIGP). Ref: IBM Maximo.',
    `contract_expiration_date` DECIMAL(18,2) COMMENT 'Expiration date of procurement contract. Ref: IBM Maximo.',
    `contract_number` STRING COMMENT 'Active procurement contract number for this asset-to-category mapping. Ref: IBM Maximo.',
    `contract_pricing_flag` BOOLEAN COMMENT 'Indicates whether pricing is governed by a procurement contract rather than spot pricing. Ref: IBM Maximo.',
    `contract_required_flag` BOOLEAN COMMENT 'Indicates if a procurement contract is required. Ref: IBM Maximo.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this mapping was established in the system. Ref: IBM Maximo.',
    `criticality_tier` STRING COMMENT 'Criticality tier for procurement prioritization (e.g., critical, essential, standard, non-critical). Ref: IBM Maximo.',
    `depreciation_method` STRING COMMENT 'Depreciation method (straight-line, declining balance). Ref: IBM Maximo.',
    `disposal_method` STRING COMMENT 'Recommended disposal method. Ref: IBM Maximo.',
    `economic_order_quantity` STRING COMMENT 'Economic order quantity. Ref: IBM Maximo.',
    `environmental_certification` STRING COMMENT 'Environmental certifications (Energy Star, EPEAT, etc.). Ref: IBM Maximo.',
    `expected_useful_life_years` STRING COMMENT 'Expected useful life in years. Ref: IBM Maximo.',
    `extra_attribute_1` STRING COMMENT 'The extra attribute 1 value recorded for each procurement mapping in the asset domain.',
    `extra_attribute_2` STRING COMMENT 'The extra attribute 2 value recorded for each procurement mapping in the asset domain.',
    `extra_attribute_3` STRING COMMENT 'The extra attribute 3 value recorded for each procurement mapping in the asset domain.',
    `extra_attribute_4` STRING COMMENT 'The extra attribute 4 value recorded for each procurement mapping in the asset domain.',
    `grant_eligible_flag` BOOLEAN COMMENT 'Whether eligible for grant funding. Ref: IBM Maximo.',
    `grant_program_list` STRING COMMENT 'List of applicable grant programs. Ref: IBM Maximo.',
    `hazmat_class` STRING COMMENT 'Hazmat classification if applicable. Ref: IBM Maximo.',
    `hazmat_flag` BOOLEAN COMMENT 'Whether item is hazardous material. Ref: IBM Maximo.',
    `last_price_update_date` DECIMAL(18,2) COMMENT 'Date of last price update. Ref: IBM Maximo.',
    `last_procurement_date` DATE COMMENT 'Most recent date when an item of this asset class was procured through this procurement category. Used to identify inactive mappings and refresh cost benchmarks. Ref: IBM Maximo.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this mapping was last modified, including updates to sourcing strategy, lead times, or cost benchmarks. Ref: IBM Maximo.',
    `local_preference_eligible_flag` BOOLEAN COMMENT 'Whether eligible for local preference. Ref: IBM Maximo.',
    `maintenance_interval_months` STRING COMMENT 'Recommended maintenance interval in months. Ref: IBM Maximo.',
    `mapping_description` STRING COMMENT 'Description of the asset class to procurement category mapping. Ref: IBM Maximo.',
    `mapping_name` STRING COMMENT 'Name of the procurement mapping. Ref: IBM Maximo.',
    `mapping_status` STRING COMMENT 'Current lifecycle status of this asset class to procurement category mapping. Active mappings are used in procurement workflows and materials planning. Ref: IBM Maximo.',
    `maximum_stock_quantity` STRING COMMENT 'Maximum stock quantity. Ref: IBM Maximo.',
    `minimum_order_quantity` STRING COMMENT 'Minimum order quantity. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `naics_code` STRING COMMENT 'North American Industry Classification System code. Ref: IBM Maximo.',
    `nigp_code` STRING COMMENT 'National Institute of Governmental Purchasing commodity code. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Additional notes. Ref: IBM Maximo.',
    `preferred_sourcing_strategy` STRING COMMENT 'Recommended procurement approach for this specific asset class when sourced through this procurement category. Drives purchasing workflow and approval routing. Ref: IBM Maximo.',
    `price_escalation_clause` DECIMAL(18,2) COMMENT 'Description of price escalation clause. Ref: IBM Maximo.',
    `procurement_frequency` STRING COMMENT 'Typical procurement frequency (e.g., monthly, quarterly, as-needed). Ref: IBM Maximo.',
    `procurement_method` STRING COMMENT 'Procurement method (e.g., competitive bid, sole source, blanket PO). Ref: IBM Maximo.',
    `recyclable_flag` BOOLEAN COMMENT 'Whether item is recyclable at end of life. Ref: IBM Maximo.',
    `recycled_content_pct` DECIMAL(18,2) COMMENT 'Percentage of recycled content. Ref: IBM Maximo.',
    `reorder_point` STRING COMMENT 'Reorder point threshold. Ref: IBM Maximo.',
    `reorder_point_quantity` STRING COMMENT 'Inventory level at which a reorder should be triggered for this asset class. Ref: IBM Maximo.',
    `safety_stock_quantity` STRING COMMENT 'Safety stock quantity. Ref: IBM Maximo.',
    `shelf_life_months` STRING COMMENT 'Shelf life in months. Ref: IBM Maximo.',
    `small_business_set_aside_flag` BOOLEAN COMMENT 'Whether eligible for small business set-aside. Ref: IBM Maximo.',
    `sole_source_allowed_flag` BOOLEAN COMMENT 'Indicates if sole source procurement is permitted. Ref: IBM Maximo.',
    `sole_source_flag` BOOLEAN COMMENT 'Indicates whether this asset class has only a single approved vendor (sole source). Ref: IBM Maximo.',
    `special_handling_instructions` STRING COMMENT 'Special handling instructions. Ref: IBM Maximo.',
    `special_handling_required_flag` BOOLEAN COMMENT 'Whether special handling is required. Ref: IBM Maximo.',
    `specification_document` STRING COMMENT 'Reference to procurement specification document. Ref: IBM Maximo.',
    `specification_document_reference` STRING COMMENT 'Reference to the technical specification document governing procurement of this asset class. Ref: IBM Maximo.',
    `specification_document_url` STRING COMMENT 'URL or path to the technical specification document for procurement. Ref: IBM Maximo.',
    `specification_reference` STRING COMMENT 'Reference to the technical specification document governing procurement of this asset class. Ref: IBM Maximo.',
    `standard_lead_time_days` STRING COMMENT 'Typical procurement lead time in days for items of this asset class when sourced through this procurement category. Used for materials planning and inventory reorder point calculations. Ref: IBM Maximo.',
    `storage_requirements` STRING COMMENT 'Storage requirements (temperature, humidity, etc.). Ref: IBM Maximo.',
    `supplier_diversity_category` STRING COMMENT 'Supplier diversity category (MBE, WBE, DBE, etc.). Ref: IBM Maximo.',
    `sustainability_rating` STRING COMMENT 'Sustainability rating. Ref: IBM Maximo.',
    `unit_of_measure` STRING COMMENT 'Unit of measure (e.g., EA, FT, LB). Ref: IBM Maximo.',
    `unspsc_code` STRING COMMENT 'United Nations Standard Products and Services Code. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Marker set by asset-domain synthesizer. Ref: IBM Maximo.',
    `warranty_period_months` STRING COMMENT 'Standard warranty period in months. Ref: IBM Maximo.',
    `warranty_terms` STRING COMMENT 'Standard warranty terms. Ref: IBM Maximo.',
    CONSTRAINT pk_procurement_mapping PRIMARY KEY(`procurement_mapping_id`)
) COMMENT 'This association product represents the strategic sourcing configuration between asset classes and procurement categories. It captures class-specific procurement strategies, lead times, cost benchmarks, and approved vendor counts used for materials planning, strategic sourcing decisions, and inventory optimization. Each record links one asset class to one procurement category with sourcing parameters that exist only in the context of this relationship.. Existence Justification: In water utility operations, asset classes (pumps, valves, meters, SCADA equipment) are sourced through multiple procurement categories (mechanical parts, electrical components, instrumentation supplies), and each procurement category serves multiple asset classes. The procurement function actively manages these mappings to maintain class-specific sourcing strategies, lead time benchmarks, approved vendor pools, and cost standards for strategic sourcing, materials planning, and inventory optimization.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` (
    `asset_sampling_point_id` BIGINT COMMENT 'Primary key for asset_sampling_point. Ref: IBM Maximo.',
    `canonical_quality_sampling_point_id` BIGINT COMMENT 'Unique identifier for the canonical quality sampling point referenced by each asset sampling point record in the asset domain.',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to the approved water quality sampling location where samples are collected. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to the physical infrastructure asset being monitored (tank, pump station, treatment unit, pipe segment, valve, etc.). Ref: IBM Maximo.',
    `configuration_status` STRING COMMENT 'Current operational status of this asset-sampling point configuration. Active = in use; suspended = temporarily inactive; under_review = pending validation; decommissioned = permanently retired. Ref: IBM Maximo.',
    `deprecated_flag` BOOLEAN COMMENT 'The deprecated flag value recorded for each asset sampling point in the asset domain.',
    `last_configuration_review_date` DATE COMMENT 'Date when this asset-sampling point configuration was last reviewed and validated as part of monitoring plan audits or regulatory compliance reviews. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether sampling at this specific asset-sampling point combination is mandated by regulatory permit conditions (NPDES, SDWA, state requirements) versus operational/voluntary monitoring. Ref: IBM Maximo.',
    `relationship_end_date` DATE COMMENT 'Date when this asset-sampling point configuration was deactivated (e.g., asset decommissioned, sampling point relocated, monitoring requirements changed). Null if currently active. Ref: IBM Maximo.',
    `relationship_start_date` DATE COMMENT 'Date when this asset-sampling point configuration became active and sampling began for this specific asset at this location. Used to track historical changes in monitoring configurations. Ref: IBM Maximo.',
    `sample_collection_responsibility` STRING COMMENT 'Identifies which team or entity is responsible for collecting samples at this asset-sampling point combination (may vary by asset even at the same sampling location based on access requirements or operational constraints). Ref: IBM Maximo.',
    `sampling_access_notes` STRING COMMENT 'Asset-specific access instructions, safety requirements, or logistical notes for sampling personnel collecting samples at this location for this particular asset (e.g., Requires confined space entry permit for tank interior sampling, Access via north valve vault only, Coordinate with operations for pump shutdown). Ref: IBM Maximo.',
    `sampling_frequency_override` STRING COMMENT 'Asset-specific override of the default sampling frequency for this sampling point. Allows different sampling cadences for different assets monitored at the same location (e.g., critical assets sampled daily while standard assets sampled weekly at the same point). Ref: IBM Maximo.',
    `sampling_priority_rank` STRING COMMENT 'Priority ranking (1=highest) for this asset-sampling point combination used to sequence sampling activities when multiple assets are monitored at the same location. Based on asset criticality, regulatory requirements, and operational risk. Ref: IBM Maximo.',
    `ssot_resolution_type` STRING COMMENT 'The ssot resolution type value recorded for each asset sampling point in the asset domain.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'The ssot sync timestamp associated with each asset sampling point record in the asset domain.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure touch. Ref: IBM Maximo.',
    CONSTRAINT pk_asset_sampling_point PRIMARY KEY(`asset_sampling_point_id`)
) COMMENT 'This association product represents the operational configuration between physical infrastructure assets and water quality sampling points. It captures the many-to-many relationship where a single asset (e.g., storage tank, pump station) can have multiple designated sampling locations (inlet, outlet, overflow, different depths), and a single sampling point can monitor water quality across multiple interconnected assets (e.g., a distribution system sampling point representing multiple mains). Each record defines the sampling configuration, frequency overrides, priority ranking, and access logistics specific to each asset-sampling point pair.. Existence Justification: In water utility operations, the relationship between physical assets and sampling points is genuinely many-to-many. A single asset such as a storage tank has multiple designated sampling locations (inlet, outlet, overflow, different depths for stratification monitoring), and a single sampling point in the distribution system can monitor water quality across multiple interconnected assets (mains, valves, service connections). The utility actively manages these sampling configurations as part of regulatory compliance and operational monitoring programs, with each asset-sampling point pair having specific frequency overrides, priority rankings, and access logistics. [SSOT: Domain-specific view; canonical source is quality.quality_sampling_point.] Consolidated: quality.quality_sampling_point is SSOT; this table references it.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` (
    `grant_funding_id` BIGINT COMMENT 'Unique identifier for this asset-grant funding relationship record. Primary key. Ref: IBM Maximo.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to the grant providing funding for the asset. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to the physical infrastructure asset being funded by the grant. Ref: IBM Maximo.',
    `amount` DECIMAL(18,2) COMMENT 'Dollar amount of grant funds allocated to this specific asset from this specific grant. Used for reimbursement tracking and audit reporting. Ref: IBM Maximo.',
    `amount_reimbursed` DECIMAL(18,2) COMMENT 'Cumulative dollar amount that has been reimbursed by the grantor for this asset under this grant. Used to calculate remaining funding balance. Ref: IBM Maximo.',
    `compliance_status` STRING COMMENT 'Current compliance status of this asset-grant funding relationship with respect to grantor requirements. Values: compliant (meets all conditions), non_compliant (violation identified), under_review (audit in progress), pending_documentation (awaiting supporting docs), closed (funding complete and closed out). Ref: IBM Maximo.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this asset-grant funding record was created in the system. Ref: IBM Maximo.',
    `eligible_cost_amount` DECIMAL(18,2) COMMENT 'Dollar amount of costs incurred for this asset that have been determined eligible for reimbursement under this grants allowable cost categories. Ref: IBM Maximo.',
    `funding_end_date` DATE COMMENT 'Date on which funding for this asset under this grant ends, typically aligned with the grants period of performance end date or asset completion date. Ref: IBM Maximo.',
    `funding_start_date` DATE COMMENT 'Date on which this asset became eligible for funding under this grant, typically aligned with the grants period of performance start date or asset installation date. Ref: IBM Maximo.',
    `grant_percentage` DECIMAL(18,2) COMMENT 'Percentage of the assets total cost that is funded by this grant (e.g., 75.00 means 75% grant-funded, 25% utility match). Used for matching requirement calculations. Ref: IBM Maximo.',
    `ineligible_cost_amount` DECIMAL(18,2) COMMENT 'Dollar amount of costs incurred for this asset that have been determined ineligible for reimbursement under this grant (e.g., costs incurred outside period of performance, non-allowable cost categories). Ref: IBM Maximo.',
    `last_drawdown_request_date` DATE COMMENT 'Date of the most recent drawdown request submitted to the grantor for reimbursement of costs associated with this asset under this grant. Ref: IBM Maximo.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this asset-grant funding record was last modified. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Free-text notes documenting special conditions, compliance issues, or other relevant information about this asset-grant funding relationship. Ref: IBM Maximo.',
    `project_phase` STRING COMMENT 'Current phase of the capital project for this asset under this grant. Used to track project milestones and align with grant drawdown schedules. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Marker set by asset-domain synthesizer. Ref: IBM Maximo.',
    CONSTRAINT pk_grant_funding PRIMARY KEY(`grant_funding_id`)
) COMMENT 'This association product represents the funding relationship between physical infrastructure assets and grants. It captures the allocation of grant funds to specific assets, tracking the funding amount, percentage, compliance status, and funding period for each asset-grant combination. Each record links one asset to one grant with attributes that exist only in the context of this funding relationship, supporting audit trails, reimbursement tracking, and grantor compliance reporting.. Existence Justification: In water utility capital finance, individual infrastructure assets (treatment plant upgrades, main replacements, pump stations) are routinely funded through multiple concurrent grants (DWSRF, CWSRF, EPA WIFIA, state programs, ARPA), and each grant program funds multiple assets across capital improvement projects. The utility must track the specific funding amount, percentage, compliance status, and reimbursement details for each asset-grant combination to support grantor reporting, single audit requirements (SEFA schedules), and drawdown requests.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` (
    `compliance_requirement_id` BIGINT COMMENT 'Unique surrogate primary key for each asset-requirement compliance relationship record. Ref: IBM Maximo.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to the physical infrastructure asset subject to the regulatory requirement. Ref: IBM Maximo.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to the regulatory requirement that applies to the asset. Ref: IBM Maximo.',
    `compliance_method` STRING COMMENT 'The specific method, control, or operational practice by which this asset achieves compliance with this requirement (e.g., continuous monitoring, quarterly sampling, treatment technique, operational control). Varies by asset-requirement combination. Ref: IBM Maximo.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting compliance issues, corrective actions, assessment findings, or special considerations specific to this asset-requirement relationship. Ref: IBM Maximo.',
    `compliance_status` STRING COMMENT 'Current compliance status of this specific asset with respect to this specific regulatory requirement. Tracks whether the asset meets the requirement, is out of compliance, is pending assessment, or has been granted a variance. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset-requirement compliance relationship record was created in the system. Ref: IBM Maximo.',
    `effective_date` DATE COMMENT 'Date on which this regulatory requirement became applicable to this specific asset. May differ from the requirements general effective date based on asset installation date, facility type, or system size. Ref: IBM Maximo.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent compliance assessment performed for this asset against this specific regulatory requirement. Used to track assessment currency and trigger next assessment scheduling. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next compliance assessment of this asset against this regulatory requirement. Calculated based on the requirements monitoring frequency and the last assessment date. Ref: IBM Maximo.',
    `responsible_person` STRING COMMENT 'Name or identifier of the individual responsible for ensuring this specific asset maintains compliance with this specific requirement. May differ from the general requirement owner based on asset location or operational area. Ref: IBM Maximo.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this asset-requirement compliance relationship record. Ref: IBM Maximo.',
    `variance_expiry_date` DATE COMMENT 'Expiration date of the granted variance or exemption for this asset-requirement pair. Null if no variance is granted or if variance is permanent. Ref: IBM Maximo.',
    `variance_granted_flag` BOOLEAN COMMENT 'Indicates whether a regulatory variance, exemption, or waiver has been granted for this specific asset-requirement combination. True if variance is active, false otherwise. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Marker set by asset-domain synthesizer. Ref: IBM Maximo.',
    CONSTRAINT pk_compliance_requirement PRIMARY KEY(`compliance_requirement_id`)
) COMMENT 'This association product represents the compliance relationship between physical infrastructure assets and regulatory requirements. It captures the specific compliance obligations, assessment schedules, and compliance status for each asset-requirement pair. Each record links one asset to one regulatory requirement with attributes that track compliance method, assessment dates, variance status, and compliance state specific to that asset-requirement combination.. Existence Justification: In water utility operations, a single physical asset (e.g., a chlorine contact basin) must comply with multiple overlapping regulatory requirements from different regulatory programs (SDWA Surface Water Treatment Rule for CT requirements, state disinfection rules, EPA DBP rules for chlorine residual limits, NPDES for discharge). Conversely, a single regulatory requirement (e.g., SDWA Lead and Copper Rule) applies to multiple different asset types across the utility (service lines, treatment plant corrosion control systems, distribution system storage tanks, sampling stations). The compliance relationship itself carries operational data including compliance status, assessment schedules, compliance methods, and variance status that are specific to each asset-requirement pair.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` (
    `inspection_checklist_id` BIGINT COMMENT 'Primary key for inspection_checklist. Ref: IBM Maximo.',
    `parent_inspection_checklist_id` BIGINT COMMENT 'Self-referencing FK on inspection_checklist (parent_inspection_checklist_id). Ref: IBM Maximo.',
    `applicable_asset_category` STRING COMMENT 'Asset category for which this checklist is intended. Ref: IBM Maximo.',
    `approval_status` STRING COMMENT 'Current approval state of the checklist. Ref: IBM Maximo.',
    `author` STRING COMMENT 'Name of the person who authored the checklist. Ref: IBM Maximo.',
    `checklist_type` STRING COMMENT 'Category of the checklist indicating its primary focus. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the checklist record was created. Ref: IBM Maximo.',
    `inspection_checklist_description` STRING COMMENT 'Detailed description of the purpose and scope of the checklist. Ref: IBM Maximo.',
    `effective_from` DATE COMMENT 'Date from which the checklist becomes valid. Ref: IBM Maximo.',
    `effective_until` DATE COMMENT 'Date after which the checklist is no longer valid (nullable). Ref: IBM Maximo.',
    `estimated_duration_minutes` STRING COMMENT 'Estimated time required to complete the checklist, in minutes. Ref: IBM Maximo.',
    `frequency_interval` STRING COMMENT 'Numeric interval defining how often the inspection should occur. Ref: IBM Maximo.',
    `frequency_unit` STRING COMMENT 'Time unit for the inspection frequency interval. Ref: IBM Maximo.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the checklist must be performed for the asset. Ref: IBM Maximo.',
    `last_modified_by` STRING COMMENT 'User identifier who performed the most recent modification. Ref: IBM Maximo.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date and time when the checklist was last applied to an inspection. Ref: IBM Maximo.',
    `mutator_note` STRING COMMENT 'Added by mutator to ensure change. Ref: IBM Maximo.',
    `inspection_checklist_name` STRING COMMENT 'Descriptive name of the checklist used to identify it in the system. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the checklist. Ref: IBM Maximo.',
    `number_of_items` STRING COMMENT 'Total count of individual inspection items in the checklist. Ref: IBM Maximo.',
    `regulation_reference` STRING COMMENT 'Identifier of the regulation that mandates this checklist. Ref: IBM Maximo.',
    `required_by_regulation` BOOLEAN COMMENT 'Indicates whether the checklist is mandated by regulation. Ref: IBM Maximo.',
    `reviewer` STRING COMMENT 'Name of the person who reviewed and approved the checklist. Ref: IBM Maximo.',
    `risk_level` STRING COMMENT 'Risk classification associated with the checklist. Ref: IBM Maximo.',
    `inspection_checklist_status` STRING COMMENT 'Current lifecycle status of the checklist. Ref: IBM Maximo.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the checklist record. Ref: IBM Maximo.',
    `version_number` STRING COMMENT 'Version identifier for the checklist, e.g., v1.0. Ref: IBM Maximo.',
    `vibe_asset_domain_flag` BOOLEAN COMMENT 'Marks that this product is part of the built-out asset domain. Ref: IBM Maximo.',
    `vibe_mutation_flag` BOOLEAN COMMENT 'Marker set by asset-domain synthesizer. Ref: IBM Maximo.',
    CONSTRAINT pk_inspection_checklist PRIMARY KEY(`inspection_checklist_id`)
) COMMENT 'Master reference table for inspection_checklist. Referenced by inspection_checklist_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` (
    `prediction_event_id` BIGINT COMMENT 'Primary key for the prediction event. Ref: IBM Maximo.',
    `employee_id` BIGINT COMMENT 'Employee who triggered or reviewed the prediction. Ref: IBM Maximo.',
    `prediction_reviewed_by_employee_id` BIGINT COMMENT 'Generic ML/AI prediction attribute: reviewed by employee id. Ref: IBM Maximo.',
    `absolute_error` DOUBLE COMMENT 'Absolute error magnitude. Ref: IBM Maximo.',
    `absolute_percentage_error` DECIMAL(18,2) COMMENT 'Generic ML/AI prediction attribute: absolute percentage error. Ref: IBM Maximo.',
    `action_recommended` STRING COMMENT 'Generic ML/AI prediction attribute: action recommended. Ref: IBM Maximo.',
    `action_taken` STRING COMMENT 'Generic ML/AI prediction attribute: action taken. Ref: IBM Maximo.',
    `action_taken_timestamp` TIMESTAMP COMMENT 'Generic ML/AI prediction attribute: action taken timestamp. Ref: IBM Maximo.',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual observed value (populated after the fact). Ref: IBM Maximo.',
    `actual_value_timestamp` TIMESTAMP COMMENT 'Generic ML/AI prediction attribute: actual value timestamp. Ref: IBM Maximo.',
    `alert_threshold_exceeded` BOOLEAN COMMENT 'Generic ML/AI prediction attribute: alert threshold exceeded. Ref: IBM Maximo.',
    `alert_threshold_value` DECIMAL(18,2) COMMENT 'Generic ML/AI prediction attribute: alert threshold value. Ref: IBM Maximo.',
    `confidence` DOUBLE COMMENT 'Model confidence score (0.0 to 1.0). Ref: IBM Maximo.',
    `confidence_interval_lower` DOUBLE COMMENT 'Generic ML/AI prediction attribute: confidence interval lower. Ref: IBM Maximo.',
    `confidence_interval_upper` DOUBLE COMMENT 'Generic ML/AI prediction attribute: confidence interval upper. Ref: IBM Maximo.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Model confidence 0.0-1.0. Ref: IBM Maximo.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: IBM Maximo.',
    `data_drift_detected` BOOLEAN COMMENT 'Generic ML/AI prediction attribute: data drift detected. Ref: IBM Maximo.',
    `data_drift_score` DOUBLE COMMENT 'Generic ML/AI prediction attribute: data drift score. Ref: IBM Maximo.',
    `domain_name` STRING COMMENT 'Generic ML/AI prediction attribute: domain name. Ref: IBM Maximo.',
    `entity_reference` BIGINT COMMENT 'Foreign key to the entity being predicted (polymorphic reference). Ref: IBM Maximo.',
    `entity_type` STRING COMMENT 'The domain entity type being predicted (e.g., facility, meter, pipe_main). Ref: IBM Maximo.',
    `error_value` DECIMAL(18,2) COMMENT 'Calculated error (actual_value - predicted_value) once actual is known. Ref: IBM Maximo.',
    `explainability_method` STRING COMMENT 'Generic ML/AI prediction attribute: explainability method. Ref: IBM Maximo.',
    `explainability_output_json` STRING COMMENT 'Generic ML/AI prediction attribute: explainability output json. Ref: IBM Maximo.',
    `feature_importance_json` STRING COMMENT 'Generic ML/AI prediction attribute: feature importance json. Ref: IBM Maximo.',
    `feature_vector_json` STRING COMMENT 'JSON-serialized feature vector used as model input. Ref: IBM Maximo.',
    `input_features_json` STRING COMMENT 'Generic ML/AI prediction attribute: input features json. Ref: IBM Maximo.',
    `model_accuracy_score` DOUBLE COMMENT 'Generic ML/AI prediction attribute: model accuracy score. Ref: IBM Maximo.',
    `model_algorithm` STRING COMMENT 'Algorithm used (e.g., XGBoost, LSTM, RandomForest). Ref: IBM Maximo.',
    `model_deployment_timestamp` TIMESTAMP COMMENT 'Generic ML/AI prediction attribute: model deployment timestamp. Ref: IBM Maximo.',
    `model_framework` STRING COMMENT 'Generic ML/AI prediction attribute: model framework. Ref: IBM Maximo.',
    `model_hyperparameters_json` STRING COMMENT 'Generic ML/AI prediction attribute: model hyperparameters json. Ref: IBM Maximo.',
    `model_name` STRING COMMENT 'Generic ML/AI prediction attribute: model name. Ref: IBM Maximo.',
    `model_retraining_required` BOOLEAN COMMENT 'Generic ML/AI prediction attribute: model retraining required. Ref: IBM Maximo.',
    `model_training_date` TIMESTAMP COMMENT 'Date the model was last trained. Ref: IBM Maximo.',
    `model_training_timestamp` TIMESTAMP COMMENT 'Generic ML/AI prediction attribute: model training timestamp. Ref: IBM Maximo.',
    `model_version` STRING COMMENT 'Version identifier of the ML model used for this prediction. Ref: IBM Maximo.',
    `notes` STRING COMMENT 'Generic ML/AI prediction attribute: notes. Ref: IBM Maximo.',
    `percent_error` DECIMAL(18,2) COMMENT 'Percentage error relative to actual value. Ref: IBM Maximo.',
    `predicted_value` DECIMAL(18,2) COMMENT 'The value predicted by the ML model. Ref: IBM Maximo.',
    `predicted_value_unit` STRING COMMENT 'Generic ML/AI prediction attribute: predicted value unit. Ref: IBM Maximo.',
    `prediction_error` DOUBLE COMMENT 'Generic ML/AI prediction attribute: prediction error. Ref: IBM Maximo.',
    `prediction_horizon_hours` STRING COMMENT 'Number of hours into the future this prediction covers. Ref: IBM Maximo.',
    `prediction_status` STRING COMMENT 'Generic ML/AI prediction attribute: prediction status. Ref: IBM Maximo.',
    `prediction_timestamp` TIMESTAMP COMMENT 'Timestamp when the prediction was generated. Ref: IBM Maximo.',
    `prediction_type` STRING COMMENT 'Type of prediction (e.g., pfas_breakthrough, demand_forecast, leak_detection). Ref: IBM Maximo.',
    `regulatory_context` STRING COMMENT 'Generic ML/AI prediction attribute: regulatory context. Ref: IBM Maximo.',
    `training_data_end_date` TIMESTAMP COMMENT 'Generic ML/AI prediction attribute: training data end date. Ref: IBM Maximo.',
    `training_data_start_date` TIMESTAMP COMMENT 'Generic ML/AI prediction attribute: training data start date. Ref: IBM Maximo.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: IBM Maximo.',
    `validation_status` STRING COMMENT 'Validation status (pending, validated, rejected). Ref: IBM Maximo.',
    CONSTRAINT pk_prediction_event PRIMARY KEY(`prediction_event_id`)
) COMMENT 'Generic ML/AI prediction event capturing predicted vs actual values, confidence scores, and model version. Serves PFAS breakthrough forecasting, demand forecasting, leak detection, and other predictive analytics use cases.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_parent_asset_registry_id` FOREIGN KEY (`parent_asset_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_condition_registry_id` FOREIGN KEY (`condition_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ADD CONSTRAINT `fk_asset_criticality_rating_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ADD CONSTRAINT `fk_asset_criticality_rating_criticality_registry_id` FOREIGN KEY (`criticality_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_job_plan_id` FOREIGN KEY (`job_plan_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`job_plan`(`job_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_work_registry_id` FOREIGN KEY (`work_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_job_plan_id` FOREIGN KEY (`job_plan_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`job_plan`(`job_plan_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_failure_registry_id` FOREIGN KEY (`failure_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ADD CONSTRAINT `fk_asset_asset_meter_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ADD CONSTRAINT `fk_asset_asset_meter_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ADD CONSTRAINT `fk_asset_asset_meter_primary_asset_registry_id` FOREIGN KEY (`primary_asset_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_warranty_registry_id` FOREIGN KEY (`warranty_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_depreciation_registry_id` FOREIGN KEY (`depreciation_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_acquisition_registry_id` FOREIGN KEY (`acquisition_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ADD CONSTRAINT `fk_asset_disposal_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ADD CONSTRAINT `fk_asset_disposal_disposal_replacement_asset_registry_id` FOREIGN KEY (`disposal_replacement_asset_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ADD CONSTRAINT `fk_asset_disposal_primary_disposal_registry_id` FOREIGN KEY (`primary_disposal_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_inspection_checklist_id` FOREIGN KEY (`inspection_checklist_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`inspection_checklist`(`inspection_checklist_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_inspection_registry_id` FOREIGN KEY (`inspection_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_document_registry_id` FOREIGN KEY (`document_registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_primary_superseded_by_document_id` FOREIGN KEY (`primary_superseded_by_document_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`document`(`document_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ADD CONSTRAINT `fk_asset_procurement_mapping_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ADD CONSTRAINT `fk_asset_asset_sampling_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ADD CONSTRAINT `fk_asset_grant_funding_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ADD CONSTRAINT `fk_asset_compliance_requirement_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`registry`(`registry_id`);
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ADD CONSTRAINT `fk_asset_inspection_checklist_parent_inspection_checklist_id` FOREIGN KEY (`parent_inspection_checklist_id`) REFERENCES `vibe_water_utilities_v1`.`asset`.`inspection_checklist`(`inspection_checklist_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`asset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`asset` SET TAGS ('dbx_domain' = 'asset');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `parent_asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `service_address_id` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`registry` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_ssot_pair' = 'service.service_class');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_ssot_status' = 'duplicate_of');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_ssot_duplicate_of' = 'service.service_class');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_ssot_master_for' = 'service.service_class');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `ami_applicable` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Applicable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `asset_domain` SET TAGS ('dbx_business_glossary_term' = 'Asset Operational Domain');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `capex_threshold_usd` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Capitalization Threshold (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `cip_program_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Category');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `class_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `class_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `class_name` SET TAGS ('dbx_PII' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `regulatory_standard_ref` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Standard Reference');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `renewal_strategy` SET TAGS ('dbx_business_glossary_term' = 'Default Asset Renewal Strategy');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `renewal_strategy` SET TAGS ('dbx_value_regex' = 'Replace-in-Kind|Upgrade|Rehabilitation|CIPP|Trenchless|Decommission');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Retirement Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Hazard Classification');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'Confined Space|Electrical Hazard|Chemical Hazard|High Pressure|Radiation|None');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `salvage_value_pct` SET TAGS ('dbx_business_glossary_term' = 'Default Salvage Value Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `scada_monitored` SET TAGS ('dbx_business_glossary_term' = 'SCADA Monitored Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `size_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Asset Size Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `spare_parts_required` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `ssot_entity_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `ssot_entity_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_canonical' = 'service.service_class');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot_sync' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Default Useful Life (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `work_order_type_default` SET TAGS ('dbx_business_glossary_term' = 'Default Work Order Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_class` ALTER COLUMN `work_order_type_default` SET TAGS ('dbx_value_regex' = 'Preventive Maintenance|Corrective Maintenance|Inspection|Emergency Repair|Capital Renewal|Rehabilitation');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`location` SET TAGS ('dbx_citation_discipline' = 'maintained');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `condition_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `condition_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `condition_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `condition_reviewed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `condition_reviewed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `condition_reviewed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Location Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `primary_condition_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `primary_condition_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `primary_condition_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `tertiary_condition_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `tertiary_condition_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`condition_assessment` ALTER COLUMN `tertiary_condition_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `criticality_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `criticality_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `rating_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `rating_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'Active|Superseded|Under Review|Pending Approval');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `redundancy_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Available Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `regulatory_consequence_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Consequence Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `safety_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `service_disruption_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Disruption Duration (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`criticality_rating` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `job_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`work_order` ALTER COLUMN `work_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`pm_schedule` ALTER COLUMN `job_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `job_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `job_work_center_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `confined_space_flag` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Entry Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `job_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `downtime_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `environmental_impact_notes` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `estimated_tool_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tool Cost');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `frequency_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `inspection_points` SET TAGS ('dbx_business_glossary_term' = 'Inspection Points');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `job_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `job_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `job_plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|obsolete|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `job_type` SET TAGS ('dbx_business_glossary_term' = 'Job Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `job_type` SET TAGS ('dbx_value_regex' = 'preventive_maintenance|corrective_maintenance|predictive_maintenance|inspection|calibration|emergency_repair');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `loto_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Lockout/Tagout (LOTO) Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `materials_list` SET TAGS ('dbx_business_glossary_term' = 'Materials List');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Priority');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `required_labor_crafts` SET TAGS ('dbx_business_glossary_term' = 'Required Labor Crafts');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `source_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Reference');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `task_sequence` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Title');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `tools_list` SET TAGS ('dbx_business_glossary_term' = 'Tools List');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`job_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `failure_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Employee Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`failure_record` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_ssot_pair' = 'metering.metering_meter');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_ssot_canonical' = 'metering.metering_meter');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_ssot_status' = 'duplicate_of');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_ssot_duplicate_of' = 'metering.metering_meter');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_ssot_secondary' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_ssot_canonical_ref' = 'metering.metering_meter');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_ssot_dependent' = 'metering.metering_meter');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `asset_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Meter ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `canonical_metering_meter_id` SET TAGS ('dbx_ssot_canonical_ref' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `canonical_metering_meter_id` SET TAGS ('dbx_resolution' = 'CREATE_VIEW');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Meter ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `primary_asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `alarm_high_threshold` SET TAGS ('dbx_business_glossary_term' = 'Alarm High Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `alarm_low_threshold` SET TAGS ('dbx_business_glossary_term' = 'Alarm Low Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `average_reading_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Meter Reading Rate');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `avg_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Average Calculation Method');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `avg_calculation_method` SET TAGS ('dbx_value_regex' = 'SLIDING_WINDOW|FIXED_PERIOD|LAST_READING');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Calibration Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'CALIBRATED|DUE|OVERDUE|IN_PROGRESS|NOT_REQUIRED');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `calibration_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Calibration Tolerance');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `current_reading` SET TAGS ('dbx_business_glossary_term' = 'Current Meter Reading');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Decommission Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `is_regulatory_meter` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Meter Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `last_reading_date` SET TAGS ('dbx_business_glossary_term' = 'Last Meter Reading Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Meter Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Meter Manufacturer');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `meter_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Meter Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `meter_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `meter_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Meter Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `meter_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Meter Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `meter_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|RETIRED|SUSPENDED|PENDING_CALIBRATION');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Meter Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'CONTINUOUS|GAUGE|CHARACTERISTIC');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Model Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `next_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `pi_tag_name` SET TAGS ('dbx_business_glossary_term' = 'OSIsoft PI Historian Tag Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `pi_tag_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `pm_trigger_interval` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Trigger Interval');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `pm_trigger_threshold` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Trigger Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `previous_reading` SET TAGS ('dbx_business_glossary_term' = 'Previous Meter Reading');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `previous_reading_date` SET TAGS ('dbx_business_glossary_term' = 'Previous Meter Reading Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `reading_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `reading_frequency` SET TAGS ('dbx_value_regex' = 'CONTINUOUS|HOURLY|DAILY|WEEKLY|MONTHLY|ON_DEMAND');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `reading_range_max` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Range Maximum');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `reading_range_min` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Range Minimum');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `reading_source` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Source');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `reading_source` SET TAGS ('dbx_value_regex' = 'SCADA|PI_HISTORIAN|MANUAL|AMI|CMMS_IMPORT|FIELD_DEVICE');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `regulatory_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Meter Remarks');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `rollover_value` SET TAGS ('dbx_business_glossary_term' = 'Meter Rollover Value');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `sap_measuring_point_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Maintenance (PM) Measuring Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_canonical' = 'metering.metering_meter');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot_sync' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_meter` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` SET TAGS ('dbx_subdomain' = 'lifecycle_finance');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Warranty ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `warranty_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `claim_response_days` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Response Time (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `claim_submission_process` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Submission Process');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `claimed_amount_to_date` SET TAGS ('dbx_business_glossary_term' = 'Claimed Amount to Date (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `claimed_amount_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `component_covered` SET TAGS ('dbx_business_glossary_term' = 'Component Covered');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage End Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Scope Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `duration_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Duration (Months)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Warranty Exclusions');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `expiry_alert_days` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Alert Lead Time (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `extended_warranty_cost` SET TAGS ('dbx_business_glossary_term' = 'Extended Warranty Cost (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `extended_warranty_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `max_claim_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Warranty Claim Value (USD)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `max_claim_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `maximo_warranty_code` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Warranty Record ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Warranty Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `performance_guarantee_metric` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Metric');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `performance_guarantee_threshold` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `performance_guarantee_unit` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Purchase Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Registration Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Warranty Renewal Option Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `requires_oem_service` SET TAGS ('dbx_business_glossary_term' = 'Requires OEM Service Provider Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `sap_pm_order_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Maintenance (PM) Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `transferable` SET TAGS ('dbx_business_glossary_term' = 'Warranty Transferable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Warranty Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Warranty Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Warranty Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `warranty_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `warranty_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `warranty_status` SET TAGS ('dbx_value_regex' = 'active|expired|claimed|voided|pending_activation');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'parts|labor|performance|comprehensive|extended|manufacturer');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` SET TAGS ('dbx_subdomain' = 'lifecycle_finance');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `annual_depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Depreciation Amount');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `annual_depreciation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `asset_location_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `capex_project_number` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center (CC) Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `declining_balance_rate` SET TAGS ('dbx_business_glossary_term' = 'Declining Balance Rate');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciable_base` SET TAGS ('dbx_business_glossary_term' = 'Depreciable Base');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciable_base` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_area_code` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_convention` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Convention');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_convention` SET TAGS ('dbx_value_regex' = 'full_month|half_year|mid_quarter|mid_month|pro_rata');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Key');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|double_declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Schedule Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `period_depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Period Depreciation Amount');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `period_depreciation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `salvage_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Schedule Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|suspended|fully_depreciated|disposed|impaired|draft');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `units_of_production_period` SET TAGS ('dbx_business_glossary_term' = 'Units of Production - Period');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `units_of_production_total` SET TAGS ('dbx_business_glossary_term' = 'Units of Production Total');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `useful_life_revised_years` SET TAGS ('dbx_business_glossary_term' = 'Revised Useful Life (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `useful_life_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Revision Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`depreciation_schedule` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` SET TAGS ('dbx_subdomain' = 'lifecycle_finance');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Acquisition Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `acquisition_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_value_regex' = 'pending|approved|completed|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_value_regex' = 'purchase|construction|donation|transfer|lease');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `capitalization_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Threshold Amount');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `capitalization_threshold_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Threshold Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `contractor_name` SET TAGS ('dbx_PII' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `grant_program_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `initial_condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Initial Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `initial_condition_grade` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `maximo_asset_num` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `purchase_order_num` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `sap_equipment_num` SET TAGS ('dbx_business_glossary_term' = 'SAP Equipment Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life in Years');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `warranty_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Duration in Months');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`acquisition` ALTER COLUMN `work_order_num` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` SET TAGS ('dbx_subdomain' = 'lifecycle_finance');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `disposal_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Disposal Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `disposal_replacement_asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `primary_disposal_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Vendor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Disposal Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `book_value_at_disposal` SET TAGS ('dbx_business_glossary_term' = 'Book Value at Disposal');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `buyer_contact_info` SET TAGS ('dbx_business_glossary_term' = 'Buyer Contact Information');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `buyer_contact_info` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Buyer Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `buyer_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cost Amount');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `disposal_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Transaction Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `disposal_status` SET TAGS ('dbx_business_glossary_term' = 'Disposal Transaction Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `environmental_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Environmental Clearance Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `environmental_clearance_notes` SET TAGS ('dbx_business_glossary_term' = 'Environmental Clearance Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `environmental_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Clearance Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `gain_loss_on_disposal` SET TAGS ('dbx_business_glossary_term' = 'Gain or Loss on Disposal');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Disposal Initiated By');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Disposal Location');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `maximo_disposal_code` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Disposal Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `net_disposal_value` SET TAGS ('dbx_business_glossary_term' = 'Net Disposal Value');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disposal Transaction Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds Amount');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Asset Retirement Reason');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `retirement_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason Detailed Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `sap_asset_retirement_doc` SET TAGS ('dbx_business_glossary_term' = 'SAP Asset Retirement Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `sap_posting_date` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `transfer_to_entity` SET TAGS ('dbx_business_glossary_term' = 'Transfer to Entity Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`disposal` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `primary_inspection_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `primary_inspection_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `primary_inspection_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `project_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Project Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `regulatory_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Report Submitted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_event` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Document ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Analysis Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `design_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Design Contract Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `document_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `primary_superseded_by_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Document ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `access_restriction` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `author_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `author_organization` SET TAGS ('dbx_business_glossary_term' = 'Author Organization');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `document_category` SET TAGS ('dbx_value_regex' = 'technical|regulatory|operational|safety|quality|environmental');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `destruction_eligible_date` SET TAGS ('dbx_business_glossary_term' = 'Destruction Eligible Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `file_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Kilobytes (KB)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size Megabytes (MB)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = 'ENG|SPA|FRA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `maximo_document_code` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Document ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `retention_trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `storage_location_url` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`document` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` SET TAGS ('dbx_subdomain' = 'lifecycle_finance');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` SET TAGS ('dbx_association_edges' = 'asset.asset_class,supply.procurement_category');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` SET TAGS ('dbx_data_depth' = 'expanded');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` SET TAGS ('dbx_review' = 'thin_product_expansion');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `procurement_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Procurement Mapping Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Procurement Mapping - Asset Class Id');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Alternate Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Procurement Mapping - Procurement Category Id');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `procurement_default_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Default Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `procurement_default_vendor_id` SET TAGS ('dbx_supply_vendor_vendor_id' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `procurement_preferred_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `procurement_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By Employee Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `annual_demand_forecast` SET TAGS ('dbx_business_glossary_term' = 'Annual Demand Forecast');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `annual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `approved_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Count');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `average_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Cost');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `bid_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `buy_america_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy America Compliant');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `buy_america_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy America Required');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `contract_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Pricing Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `contract_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Required');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `criticality_tier` SET TAGS ('dbx_business_glossary_term' = 'Criticality Tier');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `economic_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Economic Order Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `last_price_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Price Update');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `last_procurement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Procurement Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `mapping_description` SET TAGS ('dbx_business_glossary_term' = 'Mapping Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `mapping_name` SET TAGS ('dbx_business_glossary_term' = 'Mapping Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `mapping_status` SET TAGS ('dbx_business_glossary_term' = 'Mapping Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `maximum_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `preferred_sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Preferred Sourcing Strategy');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `procurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Procurement Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `sole_source_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sole Source Allowed');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `sole_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Sole Source Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `specification_document` SET TAGS ('dbx_business_glossary_term' = 'Specification Document');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `specification_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Document Reference');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `specification_document_url` SET TAGS ('dbx_business_glossary_term' = 'Specification Document URL');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time Days');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`procurement_mapping` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_association_edges' = 'asset.asset_registry,quality.sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_ssot_pair' = 'quality.quality_sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_ssot_canonical' = 'quality.quality_sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_ssot_status' = 'duplicate_of');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_ssot_duplicate_of' = 'quality.quality_sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_ssot_secondary' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_ssot_canonical_ref' = 'quality.quality_sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_ssot_dependent' = 'quality.quality_sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `asset_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'asset_sampling_point Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `canonical_quality_sampling_point_id` SET TAGS ('dbx_ssot_canonical_ref' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `canonical_quality_sampling_point_id` SET TAGS ('dbx_resolution' = 'CREATE_VIEW');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Sampling Point - Sampling Point Id');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_role' = 'sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Sampling Point - Asset Registry Id');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `last_configuration_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Configuration Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Sampling Relationship End Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Sampling Relationship Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `sample_collection_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Responsibility');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `sampling_access_notes` SET TAGS ('dbx_business_glossary_term' = 'Sampling Access Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `sampling_frequency_override` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency Override');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `sampling_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Sampling Priority Rank');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `ssot_resolution_type` SET TAGS ('dbx_canonical' = 'quality.quality_sampling_point');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `ssot_sync_timestamp` SET TAGS ('dbx_ssot_sync' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`asset_sampling_point` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` SET TAGS ('dbx_subdomain' = 'lifecycle_finance');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` SET TAGS ('dbx_association_edges' = 'asset.asset_registry,finance.grant');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `grant_funding_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Grant Funding ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Grant Funding - Grant Id');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Grant Funding - Asset Registry Id');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Grant Funding Amount');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `amount_reimbursed` SET TAGS ('dbx_business_glossary_term' = 'Amount Reimbursed');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `eligible_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Eligible Cost Amount');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `funding_end_date` SET TAGS ('dbx_business_glossary_term' = 'Funding End Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `funding_start_date` SET TAGS ('dbx_business_glossary_term' = 'Funding Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `grant_percentage` SET TAGS ('dbx_business_glossary_term' = 'Grant Funding Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `ineligible_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Ineligible Cost Amount');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `last_drawdown_request_date` SET TAGS ('dbx_business_glossary_term' = 'Last Drawdown Request Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Funding Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`grant_funding` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` SET TAGS ('dbx_subdomain' = 'lifecycle_finance');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` SET TAGS ('dbx_association_edges' = 'asset.asset_registry,compliance.regulatory_requirement');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `compliance_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Compliance Requirement ID');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Compliance Requirement - Asset Registry Id');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Compliance Requirement - Regulatory Requirement Id');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `compliance_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Method');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `responsible_person` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `variance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Variance Expiry Date');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `variance_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Granted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`compliance_requirement` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` SET TAGS ('dbx_cites' = 'AWIA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `parent_inspection_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Inspection Checklist Id');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `parent_inspection_checklist_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `applicable_asset_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Asset Category');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `author` SET TAGS ('dbx_business_glossary_term' = 'Author');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `checklist_type` SET TAGS ('dbx_business_glossary_term' = 'Checklist Type');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `frequency_interval` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Unit');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `number_of_items` SET TAGS ('dbx_business_glossary_term' = 'Number Of Items');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulation Reference');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `required_by_regulation` SET TAGS ('dbx_business_glossary_term' = 'Required By Regulation');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `reviewer` SET TAGS ('dbx_business_glossary_term' = 'Reviewer');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`inspection_checklist` ALTER COLUMN `vibe_asset_domain_flag` SET TAGS ('dbx_vibe_mutation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` SET TAGS ('dbx_ml' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` SET TAGS ('dbx_ai' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` SET TAGS ('dbx_prediction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` SET TAGS ('dbx_forecast' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` SET TAGS ('dbx_cites' = 'AWWA');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` ALTER COLUMN `prediction_reviewed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` ALTER COLUMN `prediction_reviewed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`asset`.`prediction_event` ALTER COLUMN `confidence_score` SET TAGS ('dbx_pii' = 'false');
