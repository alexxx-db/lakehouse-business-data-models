-- Schema for Domain: asset | Business: Manufacturing | Version: v2_ecm
-- Generated on: 2026-07-03 05:59:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`asset` COMMENT 'Equipment and asset lifecycle management domain tracking physical assets, machinery maintenance (CMMS), preventive maintenance scheduling, TPM, work order execution, MTBF/MTTR analysis, downtime events, spare parts, condition monitoring, and CapEx asset registers via Maximo. Manages production equipment, PLCs, CNC machines, robotics, and facility infrastructure.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` (
    `equipment_register_id` BIGINT COMMENT 'Unique surrogate identifier for each equipment record in the CapEx asset register. Primary key for the equipment_register data product.',
    `control_system_id` BIGINT COMMENT 'Foreign key linking to automation.control_system. Business justification: Needed for Control System Allocation Dashboard that assigns each equipment asset to the control system that governs its operation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAPITAL: Asset acquisition cost must be allocated to a cost center for budgeting, depreciation, and financial reporting.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Asset Management – Ownership Report: tracks which customer owns each equipment for warranty, billing, and service contracts.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to engineering.drawing. Business justification: Regulatory audit requires each equipment to reference its engineering drawing for compliance verification.',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.specification. Business justification: Quality control tracks equipment against its engineering specification to ensure performance and safety standards.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: DEPRECIATION: Each asset is tied to a GL account for posting depreciation expense in financial statements.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Capital asset procurement references a material master record; the link supports cost, valuation, and purchase‑order reporting across asset and inventory modules.',
    `asset_plant_id` BIGINT COMMENT 'Foreign key linking to asset.plant. Business justification: Plant is the top‑level site entity. Adding plant_id to equipment_register provides a proper foreign key to the plant master and eliminates the free‑text plant_code column.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for the Maintenance Assignment Report, which tracks which technician is responsible for each equipment piece; essential for preventive maintenance planning and accountability.',
    `engineer_id` BIGINT COMMENT 'Foreign key linking to service.engineer. Business justification: Primary Service Engineer assignment for each equipment is required for warranty support and engineer workload balancing; used in service contract management.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for Asset Management reports that tie each physical equipment to its product master record for warranty, maintenance, and cost analysis.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Business process: Asset Receiving & Storage requires tracking which warehouse bin new equipment is stored in before installation, enabling inventory valuation and location reporting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Procurement process records primary equipment supplier for warranty and support contracts.',
    `asset_pm_schedule_id` BIGINT COMMENT 'Reference identifier for the preventive maintenance plan assigned to this equipment in SAP PM or Maximo. Links the asset to its scheduled maintenance cycles, task lists, and service intervals.',
    `capex_asset_record_id` BIGINT COMMENT 'Foreign key linking to asset.capex_asset_record. Business justification: Each equipment_register represents a physical asset; linking to its financial capex record enables financial‑operational joins and removes duplicated cost fields from equipment_register.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Preferred Carrier Assignment process records the default carrier responsible for delivering each piece of equipment.',
    `asset_category` STRING COMMENT 'Broad category grouping for the asset used in CapEx asset register classification, depreciation policy assignment, and financial reporting under IFRS/GAAP fixed asset schedules.. Valid values are `Production Equipment|Facility Infrastructure|Utility System|Safety System|Measurement and Test Equipment|IT and Automation`',
    `asset_number` STRING COMMENT 'Externally-known unique asset tag or equipment number assigned in the CapEx asset register and stamped on the physical asset. Corresponds to the Maximo Asset Number and SAP S/4HANA Equipment Number (PM module). Serves as the primary business identifier for cross-system reconciliation.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the rated capacity value (e.g., units/hr, kg/hr, tonnes/day, cycles/min). Required to correctly interpret and compare capacity figures across heterogeneous equipment types.',
    `commissioning_date` TIMESTAMP COMMENT 'Date on which the equipment was formally commissioned and placed into productive service following installation and acceptance testing. Marks the start of the assets operational lifecycle and triggers depreciation commencement in SAP FI-AA.',
    `condition_at_transfer` TIMESTAMP COMMENT 'Recorded physical condition grade of the equipment at the time of its most recent transfer or relocation. Provides a point-in-time condition snapshot for the location assignment history audit trail and insurance/liability documentation.',
    `condition_grade` STRING COMMENT 'Current physical condition assessment grade of the equipment based on the most recent inspection or condition monitoring evaluation. Used in asset lifecycle management decisions (repair vs. replace), maintenance prioritization, and insurance assessments.. Valid values are `Excellent|Good|Fair|Poor|Critical`',
    `criticality_ranking` STRING COMMENT 'Business criticality classification of the equipment based on its impact on production throughput, safety, and quality if it fails. Critical assets receive priority maintenance resources and are included in TPM and FMEA programs. Used in maintenance strategy selection and spare parts stocking decisions.. Valid values are `Critical|High|Medium|Low`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values on this equipment record (acquisition cost, book value, replacement value). Supports multi-currency CapEx reporting for global manufacturing operations.. Valid values are `^[A-Z]{3}$`',
    `decommission_date` TIMESTAMP COMMENT 'Date on which the equipment was formally decommissioned and removed from productive service. Triggers asset write-off or disposal processing in SAP FI-AA. Null for active assets.',
    `device_registry_code` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Required for Equipment‑Control Integration Report linking each equipment asset to its primary controller device for diagnostics and maintenance planning.',
    `equipment_class` STRING COMMENT 'High-level classification of the equipment type used for asset categorization, maintenance strategy assignment, and reporting. [ENUM-REF-CANDIDATE: CNC Machine|PLC|Robotics|Conveyor|HVAC|Compressor|Pump|Electrical Panel|Facility Infrastructure|Inspection Equipment — promote to reference product]',
    `equipment_name` STRING COMMENT 'Human-readable descriptive name of the equipment or asset (e.g., CNC Milling Machine #3, Conveyor Belt Line A). Used as the primary identity label for display in reports, dashboards, and work orders.',
    `functional_location` STRING COMMENT 'Hierarchical functional location code (e.g., PLANT-AREA-LINE-STATION) representing the physical and functional position of the equipment within the facility structure. Corresponds to the SAP PM Functional Location and Maximo Location fields. Supports spatial analytics and maintenance planning.',
    `installation_date` TIMESTAMP COMMENT 'Date on which the equipment was physically installed at its designated location. May precede commissioning date if acceptance testing or qualification activities are required before productive use.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent formal inspection or condition assessment performed on the equipment. Used to track regulatory inspection compliance intervals and condition monitoring schedules.',
    `last_maintenance_date` DATE COMMENT 'Date on which the most recent completed maintenance activity (preventive or corrective) was performed on the equipment. Used to calculate maintenance intervals, overdue PM alerts, and MTBF analysis.',
    `last_transfer_date` DATE COMMENT 'Date of the most recent location transfer or relocation of the equipment. Part of the location assignment history audit trail tracking asset movements between plants, production lines, or storage areas.',
    `last_transfer_destination` STRING COMMENT 'Functional location or plant code to which the equipment was most recently transferred. Provides the destination leg of the location transfer audit trail for asset movement traceability.',
    `last_transfer_origin` STRING COMMENT 'Functional location or plant code from which the equipment was most recently transferred. Provides the origin leg of the location transfer audit trail for asset movement traceability.',
    `last_transfer_reason` STRING COMMENT 'Business reason code for the most recent equipment relocation or transfer. Part of the location assignment history audit trail required for asset tracking compliance and CapEx asset register accuracy.. Valid values are `Production Rebalancing|Maintenance|Decommission|New Project|Relocation|Disposal`',
    `maintenance_strategy` DECIMAL(18,2) COMMENT 'Assigned maintenance approach for the equipment as defined in the Maximo CMMS and SAP PM maintenance plan. Drives scheduling of preventive maintenance (PM) work orders, TPM activities, and condition monitoring programs.',
    `manufacture_date` TIMESTAMP COMMENT 'Date on which the equipment was manufactured by the OEM. Used to calculate equipment age, assess remaining useful life, and determine warranty expiry.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer (OEM) who produced the asset (e.g., Siemens, Fanuc, ABB, Bosch Rexroth). Used for warranty management, spare parts sourcing, and OEM service contract administration.',
    `mean_time_between_failures` DECIMAL(18,2) COMMENT 'Average elapsed time in hours between successive equipment failures, calculated from historical work order and downtime event data. Key reliability KPI used in TPM programs, maintenance strategy optimization, and OEE analysis. Expressed in hours.',
    `mean_time_to_repair` DECIMAL(18,2) COMMENT 'Average elapsed time in hours required to restore the equipment to operational status following a failure, calculated from historical corrective maintenance work orders. Key maintainability KPI used in TPM and SLA management. Expressed in hours.',
    `model_number` STRING COMMENT 'OEM-assigned model or part number for the equipment. Used for spare parts procurement, technical documentation lookup, and warranty claims.',
    `next_maintenance_due_date` TIMESTAMP COMMENT 'Scheduled date for the next planned preventive maintenance activity on the equipment, as calculated by the maintenance plan in SAP PM or Maximo. Drives work order generation and maintenance scheduling.',
    `operational_status` DECIMAL(18,2) COMMENT 'Current operational lifecycle state of the equipment. Drives maintenance scheduling, OEE calculations, and asset availability reporting. In Service indicates active production use; Decommissioned triggers asset write-off in SAP FI-AA.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Nominal electrical power consumption rating of the equipment in kilowatts as specified by the OEM. Used for energy management planning, ISO 50001 energy audits, electrical load balancing, and CapEx infrastructure sizing.',
    `rated_capacity` DECIMAL(18,2) COMMENT 'OEM-specified nominal production capacity or throughput rating of the equipment (e.g., units per hour, tonnes per day). Serves as the denominator for OEE availability and performance calculations and production planning in APS.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment record was first created in the master data system (Maximo or SAP S/4HANA). Provides the record creation audit trail for data governance and MDM lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the equipment record in the master data system. Used for change detection, data synchronization between Maximo and SAP, and MDM data quality monitoring.',
    `regulatory_certification` STRING COMMENT 'Applicable regulatory certifications and compliance markings held by the equipment (e.g., CE Marking, UL Listed, CSA, ATEX). Required for legal operation in specific jurisdictions and customer delivery compliance. Multiple certifications stored as comma-separated values.',
    `replacement_value` DECIMAL(18,2) COMMENT 'Current estimated cost to replace the equipment with an equivalent new asset. Used for insurance valuation, CapEx planning, and asset renewal decision-making. Updated periodically based on market pricing.',
    `safety_classification` STRING COMMENT 'Safety classification of the equipment based on occupational health and safety risk profile. Determines required safety permits, lockout/tagout (LOTO) procedures, PPE requirements, and regulatory inspection schedules under OSHA and ISO 45001.. Valid values are `Hazardous|Non-Hazardous|Pressure Vessel|Electrical High Voltage|Confined Space|Radiation Source`',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the specific equipment unit. Used for warranty registration, OEM service calls, and regulatory compliance traceability. Classified as confidential device identifier.',
    `transfer_authorization_ref` STRING COMMENT 'Reference number of the authorization document (e.g., work order, change request, or management approval) that sanctioned the most recent equipment transfer or relocation. Provides the authorization audit trail for asset movement governance.',
    `warranty_expiry_date` TIMESTAMP COMMENT 'Date on which the OEM or supplier warranty for the equipment expires. Used to trigger preventive maintenance strategy transitions from warranty-covered to self-maintained, and to initiate extended warranty negotiations.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Physical weight of the equipment in kilograms as specified by the OEM. Used for facility floor load planning, rigging and relocation logistics, and transportation planning during asset transfers.',
    `work_center_code` STRING COMMENT 'SAP PP/PM work center code associated with the equipment, linking it to production routing and capacity planning. Enables integration between asset management and production scheduling in SAP S/4HANA.',
    CONSTRAINT pk_equipment_register PRIMARY KEY(`equipment_register_id`)
) COMMENT 'Master record of all physical assets and production equipment in the CapEx asset register, including CNC machines, PLCs, robotics, conveyors, HVAC, and facility infrastructure. Serves as the SSOT for equipment identity, classification, parent-child hierarchy (structural decomposition into sub-assemblies and components), installation details, manufacturer specifications, commissioning date, depreciation method, book value, current operational status, criticality ranking, and location assignment history (including transfer/relocation audit trail with origin, destination, reason, condition at transfer, and authorization reference). Sourced from Maximo Asset Management and SAP S/4HANA PM module.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`location` (
    `location_id` BIGINT COMMENT 'Unique surrogate identifier for each asset location record in the Maximo Functional Location (FL) hierarchy. Serves as the primary key for the asset_location data product in the Databricks Silver Layer.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Field Service Planning: maps each asset location to the customer site for dispatch, SLA compliance, and site-specific safety rules.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: FACILITY: Location‑level overhead costs are allocated via a cost center for plant cost analysis.',
    `engineering_project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: Project asset management assigns physical locations to engineering projects for planning and reporting.',
    `network_segment_id` BIGINT COMMENT 'Foreign key linking to automation.network_segment. Business justification: Supports Network Topology Mapping Report linking physical plant locations to the IT network segment that provides connectivity.',
    `node_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_node. Business justification: Required for Logistics Node Assignment process, mapping each plant location to a logistics node for inbound/outbound shipment planning.',
    `parent_location_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediate parent location in the functional location hierarchy. Enables recursive traversal of the plant topology from site level down to individual bay/cell coordinates. Null for top-level (plant/site) locations.',
    `address_line1` STRING COMMENT 'Primary street address line of the facility or plant location. Used for regulatory reporting, logistics coordination, emergency services, and legal documentation. Classified as confidential organizational address data.',
    `area_sqm` DECIMAL(18,2) COMMENT 'Physical floor area of the location in square metres. Used for capacity planning, safety zone sizing, equipment layout design, and facility management reporting. Represents the principal quantitative measurement of the location resource.',
    `atex_zone_classification` STRING COMMENT 'Explosive atmosphere zone classification per ATEX Directive 2014/34/EU and IEC 60079 standard (e.g., Zone 0, Zone 1, Zone 2 for gas/vapour; Zone 20, Zone 21, Zone 22 for dust). Mandatory for equipment selection, safety inspections, and regulatory compliance in hazardous areas. Null if location is not classified as hazardous.. Valid values are `Zone 0|Zone 1|Zone 2|Zone 20|Zone 21|Zone 22`',
    `building_code` STRING COMMENT 'Alphanumeric code identifying the specific building or structure within the plant site where this location resides (e.g., BLD-A, HALL-3). Used for maintenance routing, emergency response planning, and facility management.. Valid values are `^[A-Z0-9]{1,10}$`',
    `capex_asset_register_code` STRING COMMENT 'SAP S/4HANA FI-AA (Fixed Asset Accounting) asset register code associated with this location for CapEx tracking, depreciation calculation, and balance sheet reporting. Links the physical location to the financial asset register per IFRS/GAAP fixed asset accounting standards.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `ceiling_height_m` DECIMAL(18,2) COMMENT 'Clear ceiling height at this location in metres. Determines suitability for tall equipment installation (e.g., overhead cranes, tall CNC machines, robotic gantries), forklift operation clearance, and ventilation system design.',
    `city` STRING COMMENT 'City or municipality where the facility location is situated. Used for regulatory reporting, tax jurisdiction determination, logistics routing, and multi-site geographic analytics.',
    `clean_room_classification` STRING COMMENT 'ISO 14644-1 clean room classification for controlled environment locations (ISO 1 through ISO 9, representing particle count per cubic metre). Governs equipment installation requirements, personnel access protocols, and environmental monitoring for precision manufacturing, electronics assembly, or pharmaceutical-adjacent processes. Null if not a controlled environment.. Valid values are `ISO 1|ISO 2|ISO 3|ISO 4|ISO 5|ISO 6`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the country where this location is situated (e.g., DEU, USA, CHN). Drives regulatory compliance framework selection (CE marking, OSHA, EPA), tax jurisdiction, and multi-national OEE benchmarking.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset location record was first created in the system (ISO 8601 format with timezone offset). Provides audit trail for data governance, MDM lineage tracking via Informatica MDM, and compliance with ISO 9001 record control requirements.',
    `location_description` STRING COMMENT 'Free-text detailed description of the asset location including physical characteristics, operational context, special conditions, and any relevant notes for maintenance technicians (e.g., North-east corner of Building A, adjacent to emergency exit 3, high-vibration environment due to press operations).',
    `effective_from_date` DATE COMMENT 'Date from which this location record became operationally active and valid for asset installation and maintenance work order assignment. Supports temporal validity tracking for location hierarchy changes, plant expansions, and decommissioning events.',
    `effective_until_date` DATE COMMENT 'Date on which this location record ceases to be operationally valid (e.g., due to decommissioning, demolition, or restructuring). Null for currently active locations. Enables historical analysis of plant topology changes and supports CapEx asset retirement workflows.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the location above mean sea level in metres (WGS84). Used for environmental zone classification, flood risk assessment, HVAC system design, and precision asset installation requirements in multi-storey or outdoor facilities.',
    `energy_zone_code` STRING COMMENT 'Energy management zone code assigned to this location per ISO 50001 energy management system. Groups locations into energy monitoring boundaries for sub-metering, energy consumption reporting, and energy efficiency KPI calculation by production area.. Valid values are `^[A-Z0-9-]{1,15}$`',
    `environmental_zone_code` STRING COMMENT 'Environmental monitoring zone code per ISO 14001 environmental management system. Groups locations for emissions monitoring, waste management tracking, and environmental compliance reporting to EPA and regulatory bodies.. Valid values are `^[A-Z0-9-]{1,15}$`',
    `fire_zone_code` STRING COMMENT 'Fire compartment or zone code assigned to this location per fire safety regulations and building codes (e.g., FZ-A1, COMP-03). Used for fire suppression system mapping, emergency response planning, and compliance with NFPA and local fire codes.. Valid values are `^[A-Z0-9-]{1,15}$`',
    `floor_level` STRING COMMENT 'Identifier for the floor or level within a building where this location is situated (e.g., G, 1, 2, B1, MEZZANINE). Supports maintenance technician routing, emergency evacuation planning, and vertical spatial queries.',
    `functional_location_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the functional location per Maximo FL structure and IEC 81346 reference designation system (e.g., PLT01-BLD02-FL03-WC04). Used as the primary business identifier for spatial referencing, maintenance routing, and asset installation tracking.. Valid values are `^[A-Z0-9]{2,20}(-[A-Z0-9]{1,20}){0,6}$`',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this location within the functional location hierarchy (1 = plant/site, 2 = building/area, 3 = floor/zone, 4 = production line, 5 = work center, 6 = bay/cell). Enables hierarchical rollup queries for OEE analysis, maintenance cost aggregation, and spatial reporting.',
    `iec_reference_designation` STRING COMMENT 'Structured reference designation code per IEC 81346 standard for industrial systems (e.g., =A1+B2-C3). Provides internationally standardized identification of the location within the technical system hierarchy, enabling interoperability with engineering documentation, CAD/CAM systems, and PLM.',
    `installed_asset_count` STRING COMMENT 'Current count of physical assets installed at this location as recorded in Maximo. Provides a snapshot of location utilization density for capacity planning, maintenance workload estimation, and facility layout optimization. Updated by the asset installation/deinstallation process.',
    `is_outdoor` BOOLEAN COMMENT 'Indicates whether this location is an outdoor or open-air area (True) versus an enclosed indoor facility (False). Determines weatherproofing requirements for installed assets, IP rating specifications for equipment, and applicable environmental protection standards.',
    `is_restricted_access` BOOLEAN COMMENT 'Indicates whether this location requires special authorization, permits, or PPE for personnel access (True) beyond standard plant access controls. Drives access management workflows, permit-to-work systems, and safety induction requirements for maintenance technicians.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this asset location record (ISO 8601 format with timezone offset). Supports change detection for ETL incremental loads, audit trail maintenance, and data quality monitoring in the Databricks Silver Layer.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (WGS84 decimal degrees) of the asset location for GIS-based spatial queries, maintenance technician navigation, and facility mapping. Applicable primarily to outdoor locations, large plant areas, or when GPS-enabled asset tracking is deployed.',
    `location_status` STRING COMMENT 'Current lifecycle status of the asset location indicating whether it is operationally active, temporarily inactive, decommissioned, under construction, or reserved for future use. Controls whether assets can be installed at this location and whether maintenance work orders can be raised against it.. Valid values are `active|inactive|decommissioned|under_construction|reserved`',
    `location_type` STRING COMMENT 'Classification of the location within the facility hierarchy (e.g., plant, building, floor, production_line, work_center, bay, cell). Drives hierarchy navigation, maintenance routing logic, and spatial analytics. [ENUM-REF-CANDIDATE: plant|building|floor|production_line|work_center|bay|cell|storage_area|utility_room|outdoor_area — promote to reference product]',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (WGS84 decimal degrees) of the asset location for GIS-based spatial queries, maintenance technician navigation, and facility mapping. Applicable primarily to outdoor locations, large plant areas, or when GPS-enabled asset tracking is deployed.',
    `maintenance_planner_group` STRING COMMENT 'SAP S/4HANA PM or Maximo planner group code responsible for planning and scheduling preventive maintenance (PM) and corrective maintenance work orders at this location. Drives maintenance routing, resource allocation, and TPM scheduling.. Valid values are `^[A-Z0-9]{3,10}$`',
    `maintenance_work_center` STRING COMMENT 'SAP S/4HANA PM maintenance work center responsible for executing maintenance activities at this location. Distinct from the production work center; this identifies the maintenance crew or workshop assigned for TPM, corrective maintenance, and breakdown response.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `max_asset_capacity` STRING COMMENT 'Maximum number of assets that can be physically installed at this location based on space, power, and structural constraints. Used for capacity planning, CapEx project scoping, and facility layout design to prevent over-installation.',
    `max_load_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum permissible floor or structural load capacity at this location in kilograms. Critical for equipment installation planning, CapEx asset placement decisions, and structural safety compliance. Prevents overloading of floors, platforms, or mezzanines during asset installation.',
    `maximo_location_code` STRING COMMENT 'Native location identifier from IBM Maximo Asset Management system (LOCATIONS.LOCATION field). Used for cross-system reconciliation between the Databricks Silver Layer and the Maximo CMMS source of record for work order routing and preventive maintenance scheduling.',
    `location_name` STRING COMMENT 'Human-readable descriptive name of the asset location (e.g., Assembly Line 3 - Bay 7, CNC Machining Cell A). Used in maintenance work orders, safety documentation, and OEE reporting to identify the physical location clearly.',
    `network_segment` STRING COMMENT 'Industrial network segment or VLAN identifier assigned to this location for IIoT device connectivity, SCADA/DCS integration, and PLC communication (e.g., OT-ZONE-A, SCADA-NET-02). Supports IEC 62443 industrial cybersecurity zone and conduit model for network segmentation compliance.. Valid values are `^[A-Za-z0-9_-]{1,50}$`',
    `pm_schedule_type` STRING COMMENT 'Type of preventive maintenance scheduling strategy applied to assets at this location (time_based, usage_based, condition_based, or none). Supports TPM strategy configuration, maintenance planning in Maximo, and predictive maintenance analytics.. Valid values are `time_based|usage_based|condition_based|none`',
    `power_supply_type` STRING COMMENT 'Primary electrical power supply specification available at this location (e.g., AC_220V, AC_480V, DC_24V). Governs equipment compatibility for asset installation, PLC and CNC machine power requirements, and electrical safety compliance per IEC 61131 and NEC standards.. Valid values are `AC_110V|AC_220V|AC_380V|AC_480V|DC_24V|DC_48V`',
    `production_line_code` STRING COMMENT 'Code identifying the production line associated with this location (e.g., LINE-01, ASSY-B). Links the physical location to production scheduling, OEE measurement, and Siemens Opcenter MES work center definitions for throughput and cycle time analysis.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `safety_zone_type` STRING COMMENT 'Safety zone designation for the location per OSHA and ISO 45001 requirements (e.g., general access, restricted, exclusion zone, emergency assembly point, fire zone, chemical storage). Drives access control, PPE requirements, and emergency response planning. [ENUM-REF-CANDIDATE: general|restricted|exclusion|emergency_assembly|fire_zone|chemical_storage — promote to reference product]. Valid values are `general|restricted|exclusion|emergency_assembly|fire_zone|chemical_storage`',
    `site_code` STRING COMMENT 'Alphanumeric code identifying the manufacturing site or plant to which this location belongs (e.g., PLT01, SITE-DE-01). Aligns with SAP S/4HANA Plant code (MM/PM module) and Maximo site identifier for cross-system integration and multi-site OEE benchmarking.. Valid values are `^[A-Z0-9]{2,10}$`',
    `site_name` STRING COMMENT 'Full descriptive name of the manufacturing site or plant (e.g., Stuttgart Automation Plant, Detroit Assembly Facility). Used in reporting, safety documentation, and regulatory submissions to identify the physical facility.',
    `timezone` STRING COMMENT 'IANA time zone identifier for the location (e.g., Europe/Berlin, America/Detroit). Critical for accurate timestamp interpretation of SCADA/MES events, shift scheduling, maintenance work order timing, and cross-site production reporting across time zones.',
    `work_center_code` STRING COMMENT 'SAP S/4HANA or Opcenter MES work center code associated with this functional location. Enables direct linkage between the physical location and production planning, capacity scheduling, and cost center allocation for manufacturing execution analysis.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Hierarchical location structure for physical asset placement, covering plant, building, floor, production line, work center, and exact bay/cell coordinates with optional GIS/GPS reference points. Tracks functional location hierarchy per Maximo FL structure and IEC 81346 reference designation system, enabling spatial queries for maintenance routing, safety zone mapping, environmental zone classification (ATEX zones, clean rooms), and OEE analysis by location. Serves as the SSOT for where assets can be installed and the physical topology of the manufacturing facility.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` (
    `asset_work_order_id` BIGINT COMMENT 'Unique surrogate identifier for the maintenance work order record in the lakehouse silver layer. Primary key for this entity.',
    `control_system_id` BIGINT COMMENT 'Foreign key linking to automation.control_system. Business justification: Work Order Execution Specification requires identifying the control system used to carry out the order, used in Work Order Scheduling reports.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: COSTING: Work order expenses are charged to a cost center to track production cost and variance.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Work Order Billing & SLA: associates work orders with the requesting customer to allocate costs and measure SLA performance per account.',
    `engineering_project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: Work orders are cost‑tracked and reported under the engineering project that originated the change.',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.revision. Business justification: Implementation work orders must reference the specific engineering revision they are executing (ECO/ECN driven change).',
    `equipment_register_id` BIGINT COMMENT 'Reference to the physical equipment or asset against which this work order is executed. Links to the asset master record in the asset management domain (e.g., CNC machine, PLC, robotic cell, HVAC unit).',
    `job_plan_id` BIGINT COMMENT 'Reference to the maintenance plan or strategy record under which this work order was generated. Links to the strategic maintenance plan defining the maintenance approach for the asset class.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Required for Order‑to‑Production Allocation report linking each work order to the sales order line it fulfills.',
    `location_id` BIGINT COMMENT 'Reference to the functional location or plant area where the asset resides and the maintenance work is performed (e.g., production line, bay, building). Corresponds to LOCATION in Maximo and Functional Location in SAP PM.',
    `parent_work_order_asset_work_order_id` BIGINT COMMENT 'Self-referencing identifier linking this work order to a parent work order, used for shutdown/turnaround scope decomposition or hierarchical work order structures. Null for top-level work orders.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: Execution of a Planned Order creates a Work Order; required for the Planned Order Execution report linking production planning to execution.',
    `employee_id` BIGINT COMMENT 'Reference to the primary maintenance technician or craftsperson assigned to execute this work order. Links to the workforce/employee master. Corresponds to LABORCODE in Maximo and Person Responsible in SAP PM.',
    `production_work_order_id` BIGINT COMMENT 'SSOT reference to the single source of truth record; this product is a non-authoritative duplicate view.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Required for Project Execution Work Order Report linking each work order to its capital project.',
    `request_id` BIGINT COMMENT 'Foreign key linking to service.request. Business justification: Service Request fulfillment process creates internal work orders; linking enables request‑to‑work‑order tracking for SLA and performance reporting.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Needed for Load/Unload Work Order process, linking a work order that prepares equipment for a specific shipment.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Outsourced maintenance work orders require linking to the external service vendor for cost tracking and compliance.',
    `tertiary_asset_reported_by_employee_id` BIGINT COMMENT 'Reference to the person (operator, technician, or system) who originated and submitted this work order request. Supports traceability and accountability for maintenance initiation.',
    `work_order_type_id` BIGINT COMMENT 'FK to asset.work_order_type',
    `actual_finish_date` TIMESTAMP COMMENT 'Actual date and time when maintenance execution was completed and the asset was returned to service. Used for MTTR calculation, downtime reporting, and OEE analysis.',
    `actual_labor_cost` DECIMAL(18,2) COMMENT 'Actual cost of labor incurred for executing this work order, calculated from actual labor hours and applicable craft rates. Used for total maintenance cost reporting and OpEx analysis.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours actually expended by all technicians in executing this work order. Captured from time reporting in Maximo or Workday. Used for cost variance analysis and workforce productivity reporting.',
    `actual_material_cost` DECIMAL(18,2) COMMENT 'Actual cost of spare parts and materials consumed during execution of this work order, in the local operating currency. Sourced from inventory issue transactions in Maximo/SAP MM. Used for maintenance cost variance and OpEx reporting.',
    `actual_start_date` TIMESTAMP COMMENT 'Actual date and time when maintenance execution commenced on this work order. Captured by the technician via MES or Maximo mobile. Used for MTTR calculation and schedule adherence analysis.',
    `affected_production_lines` STRING COMMENT 'Comma-separated list or description of production lines impacted by this work orders execution. Applicable primarily for shutdown/turnaround and emergency work orders. Used for production scheduling coordination.',
    `asset_criticality` STRING COMMENT 'Criticality classification of the asset at the time this work order was created, indicating the business impact of asset failure. Drives maintenance prioritization and resource allocation. Derived from the asset master criticality assessment.. Valid values are `critical|high|medium|low`',
    `asset_pm_schedule_id` BIGINT COMMENT 'Reference to the preventive maintenance schedule master record that generated this work order, if applicable. Null for corrective or emergency work orders. Corresponds to PM record in Maximo.',
    `capex_opex_classification` STRING COMMENT 'Financial classification of the work order costs as either Capital Expenditure (CapEx) for asset improvements/replacements or Operational Expenditure (OpEx) for routine maintenance and repairs. Critical for financial reporting under IFRS/GAAP.. Valid values are `capex|opex`',
    `completion_code` STRING COMMENT 'Standardized code indicating the outcome or resolution of the work order upon completion (e.g., repaired, replaced, adjusted, no fault found, deferred). Used for failure analysis and maintenance effectiveness reporting. Corresponds to ACTFINISH resolution codes in Maximo.',
    `completion_remarks` STRING COMMENT 'Free-text technician notes documenting the work performed, findings, parts replaced, and any follow-up actions recommended upon work order completion. Captured in Maximo WORKLOG or SAP PM notification.',
    `craft_type` STRING COMMENT 'The maintenance craft or trade skill classification required and assigned to execute this work order (e.g., Electrician, Millwright, Instrumentation Technician, Welder, Pipefitter). Corresponds to CRAFT in Maximo Labor records.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work order record was first captured in the data platform. Audit trail field for data lineage and governance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary cost fields on this work order (e.g., USD, EUR, GBP). Enables multi-currency reporting for global manufacturing operations.. Valid values are `^[A-Z]{3}$`',
    `downtime_duration_hours` DECIMAL(18,2) COMMENT 'Total production downtime in hours caused by the failure or maintenance activity associated with this work order. Core input for OEE availability calculation and MTTR analysis. Null if the work order did not cause production downtime.',
    `failure_code` STRING COMMENT 'Standardized failure classification code identifying the root cause or failure mode that originated this work order. Used for FMEA analysis, MTBF/MTTR trending, and CAPA tracking. Corresponds to FAILURECODE in Maximo and Cause Code in SAP PM.',
    `failure_description` STRING COMMENT 'Free-text narrative describing the observed failure, fault symptom, or maintenance trigger that initiated this work order. Captured by the originating technician or operator at time of request.',
    `is_production_impacting` BOOLEAN COMMENT 'Indicates whether this work order caused or required a production stoppage or capacity reduction. True = production was impacted; False = maintenance performed without production impact (e.g., running maintenance). Key filter for OEE and availability reporting.',
    `long_description` STRING COMMENT 'Detailed narrative of the scope of work, maintenance instructions, safety precautions, and special requirements for executing this work order. Corresponds to LDTEXT in Maximo.',
    `ncr_reference` STRING COMMENT 'Reference number of any Non-Conformance Report (NCR) or CAPA record linked to this work order, where the maintenance activity was triggered by or resulted in a quality non-conformance event.',
    `planned_finish_date` TIMESTAMP COMMENT 'Scheduled date and time when execution of this work order is planned to be completed. Used for production downtime planning and resource scheduling. Corresponds to SCHEDFINISH in Maximo.',
    `planned_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours estimated and planned for executing this work order across all assigned crafts. Used for resource capacity planning, scheduling, and budget estimation. Corresponds to ESTLABHRS in Maximo.',
    `planned_material_cost` DECIMAL(18,2) COMMENT 'Estimated cost of spare parts and materials planned for this work order, in the local operating currency. Used for maintenance budget planning and CapEx/OpEx classification. Corresponds to ESTMATCOST in Maximo.',
    `planned_start_date` TIMESTAMP COMMENT 'Scheduled date and time when execution of this work order is planned to begin. Used for maintenance scheduling, resource planning, and production coordination. Corresponds to SCHEDSTART in Maximo.',
    `priority` STRING COMMENT 'Priority ranking assigned to the work order indicating urgency and scheduling precedence. Priority 1 (Emergency) requires immediate response; Priority 5 (Low) is deferred maintenance. Drives scheduling in APS and resource allocation decisions.. Valid values are `1_emergency|2_urgent|3_high|4_medium|5_low`',
    `reported_date` TIMESTAMP COMMENT 'Date and time when the maintenance need was first reported or the work order was created in the source system. Represents the principal business event timestamp for this transaction. Corresponds to REPORTDATE in Maximo.',
    `safety_permit_number` STRING COMMENT 'Reference number of the safety permit (e.g., LOTO permit, hot work permit) issued for this work order. Null if no permit is required. Supports OSHA compliance audit trails.',
    `safety_permit_required` BOOLEAN COMMENT 'Indicates whether a safety permit (e.g., Lockout/Tagout, hot work permit, confined space entry permit) is required before executing this work order. Drives safety compliance workflow in Maximo. Mandatory for OSHA and ISO 45001 compliance.',
    `shutdown_scope_summary` STRING COMMENT 'For shutdown or turnaround-type work orders only: a structured summary of the full scope of work to be executed during the planned outage. Null for non-shutdown work orders.',
    `total_estimated_cost` DECIMAL(18,2) COMMENT 'Total estimated cost for this work order encompassing planned labor, materials, and any additional service costs. Used for maintenance budget approval workflows and CapEx authorization. Corresponds to ESTLABCOST + ESTMATCOST + ESTSERVCOST in Maximo.',
    `tpm_pillar` STRING COMMENT 'Classification of the work order under the applicable Total Productive Maintenance (TPM) pillar framework. Enables TPM program performance tracking and OEE improvement analysis. Null if the work order is not part of a formal TPM program.. Valid values are `autonomous_maintenance|planned_maintenance|quality_maintenance|focused_improvement|early_equipment_management`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this work order record was last modified in the data platform. Used for incremental data loading, change detection, and audit compliance.',
    `work_order_description` STRING COMMENT 'Short descriptive title or summary of the maintenance task to be performed. Displayed on work order printouts and shop floor scheduling boards. Corresponds to DESCRIPTION in Maximo WORKORDER table.',
    `work_order_number` STRING COMMENT 'Externally-known, human-readable work order number assigned by the source system (Maximo or SAP PM). Used for cross-system reference, shop floor communication, and audit trails. Corresponds to WONUM in Maximo and Order Number in SAP PM.. Valid values are `^WO-[0-9]{8,12}$`',
    `work_order_source` STRING COMMENT 'System or channel through which this work order was originated. Enables source system traceability and analysis of maintenance demand drivers (e.g., SCADA alarm-triggered vs. manually created vs. IoT condition-based alert). [ENUM-REF-CANDIDATE: maximo|sap_pm|scada_alarm|iot_alert|manual|inspection|operator_request — 7 candidates stripped; promote to reference product]',
    `work_order_status` STRING COMMENT 'Current lifecycle state of the work order workflow. Tracks progression from creation through approval, material staging, execution, completion, and closure. Corresponds to STATUS field in Maximo WORKORDER table. [ENUM-REF-CANDIDATE: draft|approved|waiting_material|in_progress|on_hold|completed|closed|cancelled — promote to reference product]',
    CONSTRAINT pk_asset_work_order PRIMARY KEY(`asset_work_order_id`)
) COMMENT 'Maintenance work order record capturing all maintenance activity types executed against equipment assets: corrective, preventive, predictive, condition-based, emergency, and shutdown/turnaround maintenance. Tracks work order type, priority, TPM pillar classification, originating failure code, assigned craft/trade, planned vs actual labor hours, planned vs actual material costs, spare parts reserved and consumed (part number, quantity, issue date, cost), start/finish dates, downtime duration, and completion status. For shutdown-type work orders, additionally captures scope of work summary, affected production lines, shutdown coordinator, planned start/end dates, and estimated total cost. Core transactional entity sourced from Maximo Work Management module and SAP PM orders. Serves as the SSOT for all maintenance execution activity.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` (
    `asset_pm_schedule_id` BIGINT COMMENT 'Unique system-generated identifier for the preventive maintenance schedule record. Primary key for the pm_schedule data product.',
    `asset_work_order_id` BIGINT COMMENT 'Reference to the most recently generated work order from this PM schedule. Enables direct navigation from the schedule to the latest execution record for status tracking.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Preventive‑maintenance schedules are created per component type to align with design‑life expectations.',
    `control_system_id` BIGINT COMMENT 'Foreign key linking to automation.control_system. Business justification: Preventive Maintenance Schedule must reference the control system whose components are maintained, used in Maintenance Planning dashboards.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SCHEDULING: PM schedules generate labor/material spend that must be posted to the responsible cost center.',
    `craft_skill_id` BIGINT COMMENT 'Reference to the primary craft or trade skill required to execute this PM schedule (e.g., Electrician, Millwright, Instrumentation Technician). Used for labor planning and scheduling.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Preventive Maintenance Contracts: links maintenance schedules to the customer contract holder for compliance reporting and contract billing.',
    `equipment_register_id` BIGINT COMMENT 'Reference to the physical equipment or asset for which this PM schedule is defined. Links to the asset master record (e.g., CNC machine, PLC, conveyor, robotic arm).',
    `job_plan_id` BIGINT COMMENT 'Reference to the job plan that defines the detailed task steps, materials, tools, and labor requirements for this PM schedule. Job plans are maintained in Maximo and reused across multiple PM schedules.',
    `location_id` BIGINT COMMENT 'Reference to the operational location (plant, building, production line, or functional location) where the asset subject to this PM schedule resides.',
    `maintenance_strategy_id` BIGINT COMMENT 'Foreign key linking to asset.maintenance_strategy. Business justification: Asset PM schedules reference a maintenance strategy. Replacing the free‑text field with a FK to the maintenance_strategy table normalizes strategy definitions.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: Preventive Maintenance Schedule is derived from a specific MRP Run; needed for the Maintenance Schedule vs MRP Run compliance audit.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Maintenance schedules are tied to project timelines for project‑driven maintenance planning.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Preventive‑maintenance contracts often involve third‑party service providers; linking enables contract compliance reporting.',
    `work_order_type_id` BIGINT COMMENT 'Reference to the work order type that will be generated when this PM schedule triggers (e.g., Preventive, Inspection, Calibration, Lubrication). Drives workflow routing and cost classification.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the maintenance manager or engineering authority who approved this PM schedule for execution. Required for regulatory compliance and quality management system documentation.',
    `approved_date` DATE COMMENT 'Date on which this PM schedule was formally approved by the authorized maintenance manager or engineering authority. Marks the schedule as valid for work order generation.',
    `condition_threshold_unit` STRING COMMENT 'Unit of measure for the condition monitoring threshold value (e.g., mm/s for vibration velocity, °C for temperature, cSt for oil viscosity). Provides context for interpreting condition_threshold_value.',
    `condition_threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value for condition-based PM triggering. When the monitored parameter (e.g., vibration amplitude, temperature, oil viscosity) exceeds this value, a PM work order is generated. Applicable when trigger_type is CONDITION.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PM schedule record was first created in the system. Provides the audit trail creation marker for data governance and lineage tracking.',
    `crew_size` STRING COMMENT 'Number of maintenance technicians or craft workers required to execute this PM task simultaneously. Used for labor resource planning and shift scheduling.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated_material_cost field (e.g., USD, EUR, GBP). Supports multi-currency operations across global manufacturing sites.. Valid values are `^[A-Z]{3}$`',
    `asset_pm_schedule_description` STRING COMMENT 'Detailed narrative description of the preventive maintenance schedule, including the scope of work, maintenance objectives, and any special instructions or safety precautions relevant to the task.',
    `effective_end_date` DATE COMMENT 'Date after which this PM schedule is no longer active and will not generate new work orders. Null for open-ended schedules. Used when an asset is decommissioned or a maintenance program is superseded.',
    `effective_start_date` DATE COMMENT 'Date from which this PM schedule becomes active and eligible to generate work orders. Supports phased rollout of new maintenance programs and asset commissioning workflows.',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated number of hours the asset will be unavailable for production during execution of this PM task. Used in OEE calculations, production scheduling, and downtime planning.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete the preventive maintenance task. Used for maintenance scheduling, craft resource planning, and downtime window estimation.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Estimated cost of materials and spare parts required to execute this PM task, in the local operating currency. Used for maintenance budget planning and CapEx/OpEx cost allocation.',
    `frequency_unit` STRING COMMENT 'Unit of measure for the PM recurrence frequency. Combined with frequency_value to define the full interval (e.g., 30 DAYS, 500 HOURS, 10000 CYCLES). Determines whether the schedule is calendar-based or meter-based. [ENUM-REF-CANDIDATE: DAYS|WEEKS|MONTHS|YEARS|HOURS|CYCLES|KILOMETERS — 7 candidates stripped; promote to reference product]',
    `frequency_value` DECIMAL(18,2) COMMENT 'Numeric value representing how often the PM task should recur. Interpreted in conjunction with frequency_unit (e.g., a value of 30 with unit DAYS means every 30 days; a value of 500 with unit HOURS means every 500 operating hours).',
    `is_regulatory_required` BOOLEAN COMMENT 'Indicates whether this PM schedule is mandated by a regulatory body (e.g., OSHA, EPA, UL, CE Marking authority) and must be completed and documented for compliance purposes. Drives audit trail requirements.',
    `is_safety_critical` BOOLEAN COMMENT 'Indicates whether this PM schedule is classified as safety-critical, meaning non-execution could result in personnel injury, environmental incident, or regulatory violation. Safety-critical PMs require mandatory completion tracking.',
    `last_completion_date` TIMESTAMP COMMENT 'Date on which the most recent execution of this PM schedule was completed and the corresponding work order was closed. Used as the baseline for calculating the next due date.',
    `last_revised_date` DATE COMMENT 'Date on which this PM schedule definition was last revised or updated. Supports document control, audit trails, and change management processes.',
    `lead_time_days` STRING COMMENT 'Number of days before the next_due_date that the PM work order should be generated to allow sufficient time for parts procurement, scheduling, and preparation. Supports JIT maintenance planning.',
    `maintenance_type` STRING COMMENT 'Classification of the maintenance activity type. PREVENTIVE: time/usage-based task to prevent failure. PREDICTIVE: condition-monitoring-driven task. INSPECTION: regulatory or quality inspection. LUBRICATION: lubrication task. CALIBRATION: instrument calibration. OVERHAUL: major scheduled overhaul.. Valid values are `PREVENTIVE|PREDICTIVE|INSPECTION|LUBRICATION|CALIBRATION|OVERHAUL`',
    `meter_unit` STRING COMMENT 'Unit of measure for the meter reading used in meter-based PM scheduling (e.g., HOURS for operating hours, CYCLES for press strokes, KILOMETERS for vehicle mileage). Null when trigger_type is CALENDAR only.. Valid values are `HOURS|CYCLES|KILOMETERS|STROKES|STARTS|UNITS`',
    `next_due_date` TIMESTAMP COMMENT 'Calculated date on which the next preventive maintenance work order is due to be generated or executed. Derived from last_completion_date plus the frequency interval. Drives maintenance scheduling and resource planning.',
    `next_due_meter_reading` DECIMAL(18,2) COMMENT 'Meter reading value (e.g., operating hours, cycle count, kilometers) at which the next PM work order is due. Applicable when trigger_type is METER or when a meter-based override supplements calendar scheduling.',
    `priority` STRING COMMENT 'Business priority assigned to this PM schedule, used to rank and sequence work order generation when competing maintenance demands exist. CRITICAL schedules are associated with safety-critical or regulatory-mandated equipment.. Valid values are `CRITICAL|HIGH|MEDIUM|LOW`',
    `regulatory_reference` STRING COMMENT 'Specific regulatory standard, clause, or requirement that mandates this PM schedule (e.g., OSHA 29 CFR 1910.217 Mechanical Power Presses, ISO 9001:2015 Clause 7.1.5 Monitoring Resources). Populated when is_regulatory_required is True.',
    `revision_number` STRING COMMENT 'Document revision number for this PM schedule, incremented when the schedule definition is updated (e.g., frequency change, task scope change, job plan update). Supports document control and change management per ISO 9001.',
    `schedule_name` STRING COMMENT 'Human-readable name or title describing the preventive maintenance schedule (e.g., Monthly Lubrication — CNC Spindle, Annual Safety Inspection — Conveyor Line 3). Used for display and search.',
    `schedule_number` STRING COMMENT 'Externally-known alphanumeric identifier for the PM schedule, as assigned in Maximo Asset Management. Used for cross-system reference and field communication (e.g., PM-2024-00123).',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the preventive maintenance schedule. ACTIVE schedules generate work orders automatically. SUSPENDED schedules are temporarily paused (e.g., during planned shutdown). CLOSED schedules are retired.. Valid values are `ACTIVE|INACTIVE|DRAFT|SUSPENDED|CLOSED`',
    `sequence_number` STRING COMMENT 'Ordering sequence number for this PM schedule within a TPM task sequence or maintenance route. Enables ordered execution of multiple PM tasks on the same asset or production line during a maintenance window.',
    `shutdown_required` BOOLEAN COMMENT 'Indicates whether the asset must be taken offline (production shutdown) to perform this PM task. Critical for production planning and scheduling maintenance windows to minimize OEE impact.',
    `spare_parts_required` BOOLEAN COMMENT 'Indicates whether this PM task requires spare parts or consumable materials to be reserved or procured prior to execution. Triggers inventory reservation in WMS or SAP MM when True.',
    `tolerance_days` STRING COMMENT 'Allowable number of days before or after the next_due_date within which the PM task can be performed without being considered overdue. Provides scheduling flexibility while maintaining compliance.',
    `tpm_pillar` STRING COMMENT 'TPM pillar classification to which this PM schedule belongs. Aligns maintenance activities with the eight TPM pillars: Autonomous Maintenance, Planned Maintenance, Quality Maintenance, Focused Improvement, Early Equipment Management, Education and Training, Safety Health and Environment, Office TPM. [ENUM-REF-CANDIDATE: AUTONOMOUS|PLANNED|QUALITY|FOCUSED|EARLY_EQUIPMENT|EDUCATION|SAFETY|OFFICE — promote to reference product]',
    `trigger_type` STRING COMMENT 'Mechanism that triggers the generation of a work order for this PM schedule. CALENDAR: time-based (e.g., every 30 days). METER: usage-based (e.g., every 500 operating hours). CONDITION: condition-based monitoring threshold breach. SEASONAL: tied to seasonal calendar. EVENT: triggered by a specific operational event.. Valid values are `CALENDAR|METER|CONDITION|SEASONAL|EVENT`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this PM schedule record was last modified in the system. Used for change detection, incremental data loading, and audit trail maintenance.',
    `work_center_code` STRING COMMENT 'Code identifying the maintenance work center or crew responsible for executing this PM schedule (e.g., MAINT-ELEC-01, MAINT-MECH-02). Used for capacity planning and work order routing in SAP PM.',
    `work_order_count` STRING COMMENT 'Cumulative count of work orders that have been generated from this PM schedule since its creation. Provides a historical activity indicator and supports MTBF/MTTR analysis.',
    CONSTRAINT pk_asset_pm_schedule PRIMARY KEY(`asset_pm_schedule_id`)
) COMMENT 'Preventive maintenance schedule master defining recurring maintenance tasks, inspection intervals, trigger types (calendar-based, meter-based, condition-based), and TPM task sequences for each equipment asset. Stores frequency, last completion date, next due date, estimated duration, required craft skills, and associated job plan reference. Supports TPM pillar execution and regulatory inspection compliance.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` (
    `job_plan_id` BIGINT COMMENT 'Unique surrogate identifier for the job plan record in the lakehouse silver layer. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PLANNING: Job plans are budgeted against a cost center for preventive maintenance cost control.',
    `plc_program_id` BIGINT COMMENT 'Foreign key linking to automation.plc_program. Business justification: Job Plan to PLC Program Mapping is essential for Production Scheduling and ensures the correct program is deployed for each plan.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Job plans are created as part of project planning for new equipment installation.',
    `applicable_equipment_class` STRING COMMENT 'Equipment class or asset type classification code for which this job plan is applicable (e.g., CNC-LATHE, ROBOT-WELDING, CONVEYOR-BELT, COMPRESSOR-SCREW). Enables automatic job plan assignment when creating PM schedules for assets of a given class.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the maintenance engineer or supervisor who formally approved this job plan for operational use. Required for ISO 9001 document control and change management compliance.',
    `approved_date` DATE COMMENT 'Date on which this job plan was formally approved for use. Supports document control, audit trails, and compliance reporting per ISO 9001 requirements.',
    `asset_category` STRING COMMENT 'Category of physical asset or equipment type this job plan is designed for (e.g., CNC Machine, PLC Panel, Conveyor System, Hydraulic Press, HVAC Unit, Robotic Arm). Enables filtering and reuse of job plans across similar asset classes.',
    `confined_space_entry` BOOLEAN COMMENT 'Indicates whether this job plan involves entry into a permit-required confined space as defined by OSHA 29 CFR 1910.146. Triggers additional safety controls, atmospheric testing, and standby attendant requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this job plan record was first created in the source system. Provides audit trail for record creation and supports data lineage in the lakehouse silver layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all cost estimates in this job plan (e.g., USD, EUR, GBP). Ensures consistent financial reporting across multi-site operations.. Valid values are `^[A-Z]{3}$`',
    `job_plan_description` STRING COMMENT 'Detailed narrative description of the maintenance procedure, scope of work, and objectives covered by this job plan. Provides context for planners and technicians beyond the short title.',
    `effective_date` DATE COMMENT 'Date from which this job plan version becomes effective and can be applied to work orders and PM schedules. Supports version management and ensures only current approved procedures are used.',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated production downtime in hours required to execute this job plan. Used for production scheduling, OEE impact analysis, and maintenance window planning. Distinct from labor duration as it represents asset unavailability time.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Total estimated labor hours required to complete all task steps in this job plan. Used for work order scheduling, capacity planning, and maintenance cost estimation. Represents the sum of all task step estimated hours.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Estimated total labor cost to execute this job plan, calculated from craft rates and estimated hours. Used for maintenance budget planning and CapEx/OpEx analysis. Expressed in the operational currency.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Estimated total cost of spare parts and materials required to execute this job plan. Used for maintenance budget planning and procurement forecasting. Expressed in the operational currency.',
    `expiry_date` DATE COMMENT 'Date on which this job plan version expires and must be reviewed or replaced. Null for open-ended plans. Supports periodic review cycles mandated by ISO 9001 and ISO 45001 document control requirements.',
    `frequency_interval` STRING COMMENT 'Numeric interval value for scheduling this job plan on PM schedules. Interpreted in conjunction with frequency_unit (e.g., interval=3 with unit=MONTH means every 3 months). Null for condition-based or on-demand plans.',
    `frequency_type` STRING COMMENT 'Defines the trigger basis for scheduling this job plan on PM schedules. TIME_BASED = calendar interval; METER_BASED = usage/runtime meter (hours, cycles, km); CONDITION_BASED = triggered by condition monitoring threshold; EVENT_BASED = triggered by a specific event; ON_DEMAND = unscheduled/corrective.. Valid values are `TIME_BASED|METER_BASED|CONDITION_BASED|EVENT_BASED|ON_DEMAND`',
    `frequency_unit` STRING COMMENT 'Unit of measure for the maintenance frequency interval. Defines whether the interval is time-based (DAY, WEEK, MONTH, YEAR), meter-based (HOUR, CYCLE, KM, RUNTIME_HOUR), or other. Used with frequency_interval to compute PM due dates. [ENUM-REF-CANDIDATE: HOUR|DAY|WEEK|MONTH|YEAR|CYCLE|KM|RUNTIME_HOUR — 8 candidates stripped; promote to reference product]',
    `hazardous_materials_involved` BOOLEAN COMMENT 'Indicates whether the execution of this job plan involves handling, exposure to, or disposal of hazardous materials (chemicals, lubricants, refrigerants, etc.). Triggers environmental compliance controls per EPA and ISO 14001 requirements.',
    `inspection_checklist_ref` STRING COMMENT 'Reference identifier for the associated inspection checklist or measurement point document linked to this job plan. Used when the job plan includes condition monitoring readings, SPC measurement points, or quality inspection steps.',
    `job_plan_number` STRING COMMENT 'Externally-known alphanumeric identifier for the job plan as assigned in Maximo or SAP PM Task List. Used by maintenance planners and technicians to reference the standard procedure (e.g., JP-MECH-0042, TASKLIST-PM-001).',
    `last_reviewed_date` DATE COMMENT 'Date on which this job plan was last formally reviewed for accuracy, safety compliance, and alignment with current OEM recommendations. Supports periodic review tracking per ISO 9001 and ISO 45001 document control.',
    `loto_required` BOOLEAN COMMENT 'Indicates whether Lockout/Tagout (LOTO) energy isolation procedures are mandatory before executing this job plan. Drives safety compliance workflows and permit-to-work issuance in the CMMS.',
    `manufacturer_reference` STRING COMMENT 'Manufacturer name or OEM reference associated with this job plan, indicating the equipment manufacturer whose maintenance recommendations informed this procedure (e.g., Siemens, Fanuc, ABB, Bosch Rexroth). Supports OEM-aligned maintenance compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this job plan record was last modified in the source system. Supports change tracking, audit trails, and incremental data loading in the lakehouse silver layer.',
    `oem_procedure_reference` STRING COMMENT 'Reference number or document identifier from the Original Equipment Manufacturer (OEM) maintenance manual or service bulletin that this job plan is based on or aligned with. Ensures traceability to manufacturer-recommended procedures.',
    `permit_to_work_required` BOOLEAN COMMENT 'Indicates whether a formal Permit to Work (PTW) must be issued and approved before this job plan can be executed. Applies to high-risk activities such as hot work, confined space entry, and electrical work on live systems.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the job plan indicating whether it is available for use on work orders and PM schedules. DRAFT = under development; ACTIVE = approved and in use; INACTIVE = temporarily suspended; PENDING_REVIEW = awaiting approval; OBSOLETE = superseded and retired.. Valid values are `DRAFT|ACTIVE|INACTIVE|PENDING_REVIEW|OBSOLETE`',
    `plan_type` STRING COMMENT 'Classification of the maintenance activity type this job plan covers. Drives scheduling logic, resource allocation, and KPI reporting. [ENUM-REF-CANDIDATE: PREVENTIVE|CORRECTIVE|PREDICTIVE|INSPECTION|OVERHAUL|LUBRICATION|CALIBRATION|EMERGENCY|SHUTDOWN — promote to reference product]',
    `planner_group` STRING COMMENT 'Maintenance planner group or planning team responsible for maintaining and executing this job plan (e.g., MECH-PLANNER-01, ELEC-PLANNER-NORTH). Aligns with SAP PM Planner Group and Maximo planning organization structure.',
    `ppe_requirements` STRING COMMENT 'Comma-separated list or narrative description of required Personal Protective Equipment (PPE) for executing this job plan (e.g., safety glasses, hard hat, arc flash suit, chemical gloves, hearing protection). Mandatory for ISO 45001 and OSHA compliance.',
    `primary_craft` STRING COMMENT 'The primary labor craft or trade skill required to execute this job plan (e.g., Millwright, Electrician, Instrumentation Technician, Mechanic). Sourced from Maximo Craft master and used for work order labor planning.',
    `priority_level` STRING COMMENT 'Default priority level assigned to work orders generated from this job plan. Drives scheduling urgency and resource allocation in the CMMS. CRITICAL = safety/production-critical; HIGH = significant impact; MEDIUM = moderate impact; LOW = minor impact; ROUTINE = standard scheduled.. Valid values are `CRITICAL|HIGH|MEDIUM|LOW|ROUTINE`',
    `regulatory_compliance_ref` STRING COMMENT 'Reference to applicable regulatory standards, codes, or compliance requirements that this job plan satisfies (e.g., ISO 9001, ISO 45001, OSHA 1910.147, IEC 62443, UL certification requirement). Supports compliance audit traceability.',
    `required_technician_count` STRING COMMENT 'Minimum number of technicians required to safely and effectively execute this job plan. Used for crew scheduling and compliance with safety regulations (e.g., confined space entry requiring a standby person per OSHA 29 CFR 1910.146).',
    `required_tools` STRING COMMENT 'List of specialized tools, equipment, and instruments required to execute this job plan (e.g., torque wrench, vibration analyzer, multimeter, alignment laser, hydraulic jack). Used for tool reservation and kitting in the CMMS.',
    `revision_number` STRING COMMENT 'Version or revision identifier of the job plan, incremented each time the procedure is formally updated (e.g., REV-01, REV-02). Supports change control and audit traceability per ISO 9001 document control requirements.',
    `safety_precautions` STRING COMMENT 'Narrative description of mandatory safety precautions, lockout/tagout (LOTO) requirements, personal protective equipment (PPE), and hazard controls that must be observed before and during execution of this job plan. Compliance with OSHA and ISO 45001 requirements.',
    `shutdown_required` BOOLEAN COMMENT 'Indicates whether execution of this job plan requires a planned production shutdown or equipment isolation. Used for maintenance window scheduling and production planning coordination to minimize OEE impact.',
    `site_code` STRING COMMENT 'Plant or facility site code where this job plan is applicable. Enables site-specific job plan management in multi-site manufacturing operations. Aligns with SAP Plant code and Maximo Site.',
    `source_system_key` STRING COMMENT 'Natural key or identifier of this job plan record in the originating source system (e.g., Maximo Job Plan Number, SAP PM Task List Number). Enables traceability and reconciliation between the lakehouse and operational systems.',
    `spare_parts_list` STRING COMMENT 'Narrative or structured list of spare parts and materials required for this job plan, including part numbers and quantities (e.g., Bearing SKF 6205-2RS x2, O-Ring Kit x1, Filter Element x1). Used for pre-kitting and MRP-driven spare parts reservation.',
    `task_step_count` STRING COMMENT 'Total number of discrete task steps defined within this job plan. Provides a quick indicator of procedure complexity and is used for work order progress tracking in Maximo and Siemens Opcenter MES.',
    `title` STRING COMMENT 'Human-readable descriptive title of the job plan summarizing the maintenance activity (e.g., Annual Preventive Maintenance - CNC Spindle Assembly, Hydraulic System Inspection). Used in work order templates and PM schedules.',
    `work_category` STRING COMMENT 'Trade or discipline category of the maintenance work defined in this job plan. Used to route work orders to the correct craft group and for workforce planning. [ENUM-REF-CANDIDATE: MECHANICAL|ELECTRICAL|INSTRUMENTATION|CIVIL|HVAC|HYDRAULIC|PNEUMATIC|LUBRICATION|AUTOMATION|WELDING — promote to reference product]',
    `work_center` STRING COMMENT 'Maintenance work center or department responsible for executing this job plan (e.g., MAINT-MECH-01, MAINT-ELEC-02). Maps to SAP PM Work Center and Maximo Labor Group for capacity planning and cost center assignment.',
    `work_order_type` STRING COMMENT 'Default work order type that should be generated when this job plan is applied. PM = Preventive Maintenance; CM = Corrective Maintenance; EM = Emergency Maintenance; INSPECTION = Inspection only; OVERHAUL = Major overhaul; PROJECT = Capital project work.. Valid values are `PM|CM|EM|INSPECTION|OVERHAUL|PROJECT`',
    CONSTRAINT pk_job_plan PRIMARY KEY(`job_plan_id`)
) COMMENT 'Standardized job plan (task list) defining the step-by-step maintenance procedure, required labor crafts, estimated hours per task step, safety precautions, required tools, and spare parts for a specific maintenance activity type. Acts as the reusable template applied to work orders and PM schedules. Sourced from Maximo Job Plans and SAP PM Task Lists.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` (
    `failure_record_id` BIGINT COMMENT 'Unique surrogate identifier for each failure event record in the system. Primary key for the failure_record data product.',
    `asset_work_order_id` BIGINT COMMENT 'Reference to the maintenance work order created in Maximo or SAP PM to remediate this failure event. Enables traceability from failure detection to corrective action execution.',
    `equipment_register_id` BIGINT COMMENT 'Reference to the physical asset or equipment that experienced the failure event. Core foreign key linking the failure record to the asset master in the asset management domain.',
    `notification_id` BIGINT COMMENT 'Reference to the originating SAP Plant Maintenance (PM) notification number that triggered or documented this failure event. Links the failure record back to the SAP S/4HANA PM module source transaction.',
    `production_line_id` BIGINT COMMENT 'Reference to the production line or work center where the failed asset is installed and where the failure event occurred. Enables production impact analysis by line and supports OEE reporting at the line level.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (operator, technician, or inspector) who initially reported or detected the failure event. Supports accountability tracking and workforce performance analysis via Workday HCM integration.',
    `affected_component_code` STRING COMMENT 'Standardized code identifying the specific sub-component or part of the asset that failed (e.g., bearing, motor, seal, valve, sensor, gearbox). Sourced from the Maximo component hierarchy and aligned with the BOM structure from Siemens Teamcenter PLM.',
    `affected_component_description` STRING COMMENT 'Human-readable description of the affected component or sub-assembly that experienced the failure. Embedded from the FMEA failure mode classification taxonomy as the affected component class descriptor.',
    `asset_operating_hours_at_failure` TIMESTAMP COMMENT 'Total cumulative operating hours recorded on the asset at the time of the failure event. Used as a key input for reliability analysis, MTBF trending, and predictive maintenance model training.',
    `capa_reference_number` STRING COMMENT 'The reference number of the formal CAPA record initiated in response to this failure event. Populated when capa_required_flag is True. Enables traceability between the failure event and the quality management corrective action process.',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether a formal Corrective and Preventive Action (CAPA) process must be initiated as a result of this failure event. True if CAPA is required; False otherwise. Driven by RPN threshold, safety impact, or quality management system requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this failure record was first created in the system of record. Serves as the audit creation timestamp, distinct from the actual failure event time. Used for data lineage and audit trail compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the repair_cost amount (e.g., USD, EUR, GBP). Supports multi-currency operations across global manufacturing sites.. Valid values are `^[A-Z]{3}$`',
    `detection_method_code` STRING COMMENT 'Standardized code indicating how the failure was detected (e.g., operator observation, automated alarm, predictive sensor alert, scheduled inspection, SCADA alarm, condition monitoring). Sourced from FMEA detection method taxonomy and Aveva SCADA alarm data. [ENUM-REF-CANDIDATE: operator_observation|scada_alarm|condition_monitoring|scheduled_inspection|predictive_alert|customer_report|automated_sensor — promote to reference product]',
    `detection_rating` STRING COMMENT 'Numeric detection rating (1-10 scale) from the FMEA/PFMEA analysis indicating the ability of current controls to detect the failure cause or mode before it reaches the customer or causes production impact. A rating of 10 represents the lowest detectability. Used in RPN calculation.',
    `downtime_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of equipment downtime in minutes resulting from this failure event, calculated as the difference between downtime_end_datetime and downtime_start_datetime. Stored as a business-captured field from the source system (Maximo) rather than derived at query time. Feeds OEE, MTTR, and production impact analysis.',
    `downtime_end_datetime` TIMESTAMP COMMENT 'The precise date and time at which the equipment was restored to operational status following the failure event. Used in conjunction with downtime_start_datetime to calculate total downtime duration and MTTR. Null if equipment has not yet been restored.',
    `downtime_start_datetime` TIMESTAMP COMMENT 'The precise date and time at which the equipment became unavailable for production due to this failure event. Used to calculate total downtime duration and OEE impact. Feeds MTTR analysis and production loss quantification.',
    `environmental_incident_flag` BOOLEAN COMMENT 'Indicates whether this failure event resulted in an environmental incident such as a spill, emission exceedance, or hazardous material release. True if an environmental event occurred; False otherwise. Triggers EPA and ISO 14001 reporting obligations.',
    `failure_cause_code` STRING COMMENT 'Standardized code identifying the root cause of the failure event (e.g., inadequate lubrication, overload, material defect, operator error, design deficiency). Sourced from the Maximo Failure Cause catalog and used in CAPA and FMEA root cause analysis.',
    `failure_cause_description` STRING COMMENT 'Detailed description of the identified root cause of the failure, providing narrative context for the failure_cause_code. Supports CAPA documentation and FMEA validation.',
    `failure_class_code` STRING COMMENT 'Standardized classification code categorizing the type of failure at the highest level of the failure taxonomy (e.g., mechanical, electrical, hydraulic, pneumatic, software, structural). Sourced from the Maximo Failure Class hierarchy and aligned with ISO 14224 failure classification. [ENUM-REF-CANDIDATE: mechanical|electrical|hydraulic|pneumatic|software|structural|thermal|instrumentation|process — promote to reference product]',
    `failure_class_description` STRING COMMENT 'Human-readable description of the failure class, providing context for the failure_class_code. Used in maintenance reports, FMEA documentation, and reliability dashboards.',
    `failure_datetime` TIMESTAMP COMMENT 'The precise date and time at which the equipment failure or fault was detected or reported. This is the principal real-world event timestamp for the failure record, distinct from the record creation audit timestamp. Used as the anchor for MTBF calculations and downtime duration derivation.',
    `failure_impact_type` STRING COMMENT 'Classification of the operational impact of the failure event on production and safety. production_stoppage indicates complete halt of production; partial_degradation indicates reduced throughput or capacity; quality_impact indicates output quality was affected; safety_incident indicates a safety hazard was created; no_production_impact indicates the failure was detected without affecting output.. Valid values are `production_stoppage|partial_degradation|quality_impact|safety_incident|no_production_impact`',
    `failure_mode_code` STRING COMMENT 'Standardized code identifying the specific manner in which the equipment failed (e.g., wear, fracture, corrosion, overheating, short circuit, vibration). Sourced from the Maximo Failure Mode catalog and aligned with FMEA/PFMEA failure mode taxonomy. Feeds FMEA validation and maintenance strategy selection.',
    `failure_mode_description` STRING COMMENT 'Detailed description of the failure mode, explaining how the equipment deviated from its intended function. Embedded from the FMEA/PFMEA failure mode classification taxonomy. Used in reliability analysis and maintenance strategy documentation.',
    `failure_narrative` STRING COMMENT 'Free-text narrative description of the failure event as recorded by the reporting technician or operator. Captures contextual details not covered by structured codes, including observed symptoms, environmental conditions, and sequence of events. Used in root cause analysis and knowledge base enrichment.',
    `failure_number` STRING COMMENT 'Externally visible, human-readable business identifier for this failure event record. Used in maintenance reports, CAPA documentation, and cross-system references. Follows the format FR-XXXXXXXXXX.. Valid values are `^FR-[0-9]{8,12}$`',
    `functional_location_code` STRING COMMENT 'SAP PM or Maximo functional location code identifying the hierarchical physical location within the plant where the failed asset is installed (e.g., building, floor, production area, equipment position). Supports location-based failure pattern analysis.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this failure record was most recently modified. Tracks the latest update for change management, audit compliance, and incremental data pipeline processing.',
    `maintenance_type` STRING COMMENT 'Classification of the maintenance response triggered by this failure event. corrective indicates planned corrective maintenance; emergency indicates unplanned breakdown response; predictive indicates maintenance triggered by condition monitoring prediction; preventive indicates a failure discovered during scheduled PM; condition_based indicates maintenance triggered by condition threshold breach.. Valid values are `corrective|emergency|predictive|preventive|condition_based`',
    `mtbf_contribution_hours` DECIMAL(18,2) COMMENT 'The operating hours accumulated on the asset since the previous failure event of the same failure class, contributing to the MTBF calculation for this asset and failure class combination. Stored as a raw business input value from Maximo rather than an aggregated metric. Feeds reliability analysis and TPM strategy.',
    `ncr_reference_number` STRING COMMENT 'The reference number of the Non-Conformance Report (NCR) raised in the quality management system as a result of this failure event. Links the failure record to the formal quality non-conformance documentation in SAP QM.',
    `occurrence_rating` STRING COMMENT 'Numeric occurrence rating (1-10 scale) from the FMEA/PFMEA analysis indicating the likelihood or frequency of the failure cause occurring. A rating of 10 represents the highest probability of occurrence. Used in RPN calculation and preventive maintenance scheduling.',
    `plant_code` STRING COMMENT 'SAP plant code identifying the manufacturing facility or site where the failure event occurred. Enables geographic and site-level failure analysis and supports multi-plant reliability benchmarking.. Valid values are `^[A-Z0-9]{2,6}$`',
    `potential_failure_effect` STRING COMMENT 'Description of the potential effect or consequence of the failure mode on the process, product quality, equipment, or safety. Embedded from the FMEA failure mode classification taxonomy. Used in FMEA validation and maintenance strategy documentation.',
    `production_units_lost` DECIMAL(18,2) COMMENT 'Estimated number of production units (parts, assemblies, or output units) lost due to this failure event and associated downtime. Quantifies the direct production impact for OEE performance loss analysis and financial impact assessment.',
    `record_status` STRING COMMENT 'Current lifecycle status of the failure record workflow. open indicates the failure has been reported but not yet actioned; in_progress indicates active remediation; closed indicates the failure has been resolved and verified; cancelled indicates the record was voided; pending_review indicates awaiting quality or engineering sign-off.. Valid values are `open|in_progress|closed|cancelled|pending_review`',
    `remedy_code` STRING COMMENT 'Standardized code identifying the corrective action or remedy applied to resolve the failure (e.g., replacement, repair, adjustment, cleaning, lubrication, recalibration). Sourced from the Maximo Remedy catalog and SAP PM catalog codes.',
    `remedy_description` STRING COMMENT 'Detailed description of the corrective action taken to resolve the failure event. Provides narrative context for the remedy_code and supports maintenance knowledge base and CAPA documentation.',
    `repair_cost` DECIMAL(18,2) COMMENT 'Total cost incurred to remediate this failure event, including labor, spare parts, and external contractor costs. Expressed in the local operating currency. Used for maintenance cost analysis, CapEx vs OpEx classification, and total cost of ownership (TCO) reporting.',
    `risk_priority_number` STRING COMMENT 'Risk Priority Number derived from FMEA/PFMEA analysis, calculated as the product of severity_rating × occurrence_rating × detection_rating (range 1-1000). Stored as a business-captured value from the FMEA source record rather than computed at query time. Used to prioritize corrective actions and maintenance strategy selection.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether this failure event resulted in or contributed to a safety incident, near-miss, or occupational hazard. True if a safety event occurred; False otherwise. Triggers mandatory OSHA/ISO 45001 reporting workflows and CAPA initiation.',
    `severity_rating` STRING COMMENT 'Numeric severity rating (1-10 scale) from the FMEA/PFMEA analysis indicating the seriousness of the failure effect on the product, process, or safety. A rating of 10 represents the most severe impact (safety hazard or regulatory non-compliance). Used in RPN calculation and maintenance strategy prioritization.',
    `spare_part_consumed_flag` BOOLEAN COMMENT 'Indicates whether one or more spare parts were consumed during the remediation of this failure event. True if spare parts were used; False otherwise. Feeds spare parts inventory consumption analysis and reorder planning.',
    CONSTRAINT pk_failure_record PRIMARY KEY(`failure_record_id`)
) COMMENT 'Failure event record capturing equipment breakdowns and fault occurrences, including failure date/time, failure class, failure mode code, failure cause code, remedy code, affected component, downtime start/end, production impact (units lost), and MTBF contribution data. Embeds the full failure mode classification taxonomy: failure mode description, affected component class, potential cause, detection method, severity rating, occurrence rating, detection rating, and RPN (Risk Priority Number) derived from FMEA/PFMEA analysis. Serves as both the transactional failure event record and the reference catalog for standardized failure modes per equipment class. Feeds MTBF/MTTR reliability analysis, FMEA validation, and maintenance strategy selection. Sourced from Maximo Failure Reporting and SAP PM Notifications.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` (
    `asset_downtime_event_id` BIGINT COMMENT 'Unique surrogate identifier for each discrete downtime event record. Primary key for the downtime_event data product in the asset domain.',
    `alarm_event_id` BIGINT COMMENT 'The alarm or event identifier from the Aveva SCADA system that triggered or corresponds to this downtime event. Enables direct traceability from the downtime record back to the SCADA alarm log for process control analysis.',
    `asset_work_order_id` BIGINT COMMENT 'Reference to the Maximo work order created or associated with this downtime event, particularly for corrective or preventive maintenance activities triggered by the stoppage.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: LOSS ANALYSIS: Downtime cost allocation requires linking each event to a cost center.',
    `equipment_register_id` BIGINT COMMENT 'Reference to the physical equipment or asset that experienced the stoppage. Links to the asset master record (e.g., CNC machine, PLC, robot, conveyor) managed in Maximo Asset Management.',
    `employee_id` BIGINT COMMENT 'Reference to the operator or technician who reported or initiated the downtime event record. Supports accountability tracking and manual entry audit. Sourced from Workday HCM or Opcenter MES operator login.',
    `production_downtime_event_id` BIGINT COMMENT 'SSOT reference to the single source of truth record; this product is a non-authoritative duplicate view.',
    `production_line_id` BIGINT COMMENT 'Reference to the production line or work center affected by the downtime event. Used for line-level OEE availability analysis and production loss costing.',
    `production_work_order_id` BIGINT COMMENT 'Reference to the SAP production order or MES work order that was interrupted or delayed by this downtime event. Enables production loss costing and schedule impact analysis.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Downtime events are reported against project schedules to assess impact on project delivery.',
    `shift_id` BIGINT COMMENT 'Reference to the production shift during which the downtime event occurred. Enables shift-level downtime analysis and operator accountability reporting.',
    `affected_product_code` STRING COMMENT 'The Stock Keeping Unit (SKU) or material number of the product being manufactured at the time of the downtime event. Used for production loss costing and quality impact assessment.',
    `capa_reference` STRING COMMENT 'Reference number of the Corrective and Preventive Action (CAPA) record initiated as a result of this downtime event. Links the downtime event to the quality management system for systematic root cause elimination. Sourced from SAP QM or the plants CAPA system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the downtime event record was first created in the system, either automatically by MES/SCADA detection or manually by an operator. Audit trail field. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated_loss_cost field (e.g., USD, EUR, GBP). Supports multi-currency enterprise reporting.. Valid values are `^[A-Z]{3}$`',
    `detection_method` STRING COMMENT 'Method by which the downtime event was detected and captured. Distinguishes automated detection (SCADA alarm, MES alert, IIoT sensor trigger, predictive maintenance alert) from manual detection (operator report, visual inspection, manual entry). Supports data quality assessment and IIoT maturity tracking. [ENUM-REF-CANDIDATE: scada_alarm|mes_alert|operator_report|sensor_trigger|visual_inspection|predictive_alert|manual_entry — 7 candidates stripped; promote to reference product]',
    `downtime_category` STRING COMMENT 'High-level classification of the downtime event type. Drives OEE availability loss categorization and Pareto analysis. [ENUM-REF-CANDIDATE: breakdown|planned_maintenance|changeover|tooling|material_shortage|quality_hold|no_operator|utility_failure|scheduled_break|trial_run — promote to reference product]',
    `downtime_type` STRING COMMENT 'Indicates whether the downtime event was unplanned (unexpected equipment failure, breakdown) or planned (scheduled maintenance, changeover, tooling change). Critical discriminator for OEE availability calculation — only unplanned downtime reduces OEE availability.. Valid values are `unplanned|planned`',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total elapsed duration of the downtime event in minutes, calculated as the difference between end_timestamp and start_timestamp. Stored as a business field for direct use in OEE availability calculations, Pareto analysis, and production loss costing. Null if event is still open.',
    `end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the equipment was restored to operational status and production resumed. Null if the event is still open/in-progress. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether this downtime event resulted in an environmental impact (e.g., spill, emission exceedance, energy waste) requiring EPA or ISO 14001 reporting. True = environmental impact occurred.',
    `estimated_loss_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost of production loss attributable to this downtime event, expressed in the plants local currency. Calculated from estimated_production_loss_units multiplied by the standard cost per unit. Used for downtime Pareto cost analysis and CapEx justification.',
    `estimated_production_loss_units` DECIMAL(18,2) COMMENT 'Estimated number of production units lost due to this downtime event, calculated based on the equipments standard throughput rate and the downtime duration. Used for production loss costing and OEE throughput impact analysis.',
    `event_number` STRING COMMENT 'Externally-known, human-readable business identifier for the downtime event (e.g., DT-2024-000123). Used for cross-system reference, operator communication, and audit trail. Sourced from Maximo or Siemens Opcenter MES downtime capture.. Valid values are `^DT-[0-9]{4}-[0-9]{6}$`',
    `event_status` STRING COMMENT 'Current lifecycle state of the downtime event record. open indicates the stoppage is active; in_progress indicates maintenance is underway; resolved indicates equipment is restored; closed indicates the record is fully documented and approved; cancelled indicates a false or erroneous entry.. Valid values are `open|in_progress|resolved|closed|cancelled`',
    `failure_class` STRING COMMENT 'High-level classification of the failure mode grouping (mechanical, electrical, hydraulic, pneumatic, software, instrumentation, structural, operator_error, external). Aligns with Maximo failure class hierarchy and supports FMEA/PFMEA analysis and spare parts categorization. [ENUM-REF-CANDIDATE: mechanical|electrical|hydraulic|pneumatic|software|instrumentation|structural|operator_error|external — 9 candidates stripped; promote to reference product]',
    `failure_code` STRING COMMENT 'Maximo/CMMS standardized failure code classifying the type of equipment failure (e.g., bearing failure, seal leak, motor burnout, software fault). Distinct from root_cause_code — failure_code describes WHAT failed, root_cause_code describes WHY. Used for MTBF analysis and spare parts planning.',
    `is_repeat_failure` BOOLEAN COMMENT 'Indicates whether this downtime event is a recurrence of a previously recorded failure on the same asset within a defined lookback period (typically 30 or 90 days). True = repeat failure. Used to trigger CAPA escalation and identify chronic equipment issues.',
    `is_safety_incident` BOOLEAN COMMENT 'Indicates whether this downtime event was associated with or caused a safety incident (True) or not (False). Triggers mandatory safety reporting workflows and OSHA recordkeeping requirements when True.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the downtime event record (e.g., root cause update, closure, CAPA linkage). Supports change tracking and data lineage in the Databricks Silver Layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `maintenance_type` STRING COMMENT 'Classification of the maintenance activity associated with this downtime event. Distinguishes corrective (reactive repair), preventive (scheduled PM), predictive (condition-triggered), condition-based, and emergency maintenance. Supports TPM and maintenance strategy analysis.. Valid values are `corrective|preventive|predictive|condition_based|emergency`',
    `ncr_reference` STRING COMMENT 'Reference number of the Non-Conformance Report (NCR) associated with this downtime event, applicable when the stoppage was caused by or resulted in a quality non-conformance (e.g., quality hold, defective material). Links downtime to quality management records.',
    `oee_availability_impact_pct` DECIMAL(18,2) COMMENT 'The percentage reduction in OEE availability attributable to this specific downtime event, expressed as a decimal percentage (e.g., 4.17 = 4.17%). Calculated as (duration_minutes / planned_production_time_minutes) * 100 for the affected shift/period. Feeds OEE calculation pipelines.',
    `plant_code` STRING COMMENT 'SAP plant code identifying the manufacturing facility where the downtime event occurred. Enables multi-plant downtime benchmarking and OEE comparison across the enterprise.',
    `plc_fault_code` STRING COMMENT 'The fault or error code reported by the Programmable Logic Controller (PLC) or DCS at the time of the downtime event. Provides low-level diagnostic information for maintenance engineers and supports automated fault classification.',
    `problem_code` STRING COMMENT 'Maximo CMMS problem code describing the observed symptom or problem that triggered the downtime event (e.g., vibration, overheating, noise, no output). Part of the Maximo failure reporting triad: problem_code → failure_code → root_cause_code.',
    `remedy_code` STRING COMMENT 'Maximo CMMS remedy code describing the corrective action taken to restore the equipment (e.g., replaced bearing, adjusted alignment, reset PLC, cleaned filter). Completes the Maximo failure reporting triad and supports maintenance knowledge base and CAPA closure.',
    `repair_time_minutes` DECIMAL(18,2) COMMENT 'Elapsed time in minutes from when maintenance work began to when the equipment was restored to operational status. Core component of Mean Time To Repair (MTTR) calculation. Excludes waiting/response time.',
    `response_time_minutes` DECIMAL(18,2) COMMENT 'Elapsed time in minutes from the downtime event start_timestamp to when a maintenance technician acknowledged or began working on the issue. Component of Mean Time To Repair (MTTR) analysis and maintenance SLA performance tracking.',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the root cause of the downtime event (e.g., mechanical failure, electrical fault, operator error, material defect, software fault). Sourced from the plants root cause taxonomy maintained in Maximo or the CMMS. Used for CAPA initiation and FMEA updates. [ENUM-REF-CANDIDATE: promote to reference product with full root cause taxonomy]',
    `root_cause_description` STRING COMMENT 'Free-text narrative description of the identified root cause of the downtime event, as entered by the maintenance technician or engineer. Complements the structured root_cause_code with contextual detail for CAPA and FMEA analysis.',
    `safety_incident_reference` STRING COMMENT 'Reference number of the associated safety incident report when is_safety_incident is True. Links the downtime event to the EHS (Environmental Health and Safety) management system for OSHA compliance reporting.',
    `source_event_reference` STRING COMMENT 'The native identifier of this downtime event in the originating source system (e.g., Maximo work order number, Opcenter MES downtime record ID, SCADA alarm ID). Enables traceability back to the system of record for reconciliation and audit.',
    `spare_parts_used` STRING COMMENT 'Comma-separated list or free-text description of spare parts consumed during the repair of this downtime event (e.g., part numbers, descriptions). Used for spare parts consumption tracking, inventory replenishment, and maintenance cost analysis. Detailed parts data is managed in Maximo inventory.',
    `start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the equipment stoppage began. Principal real-world event timestamp for the downtime event. Captured from SCADA/MES automated detection or manual operator entry. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `technician_notes` STRING COMMENT 'Free-text field for maintenance technician observations, diagnostic findings, and repair actions taken during the downtime event. Captured in Maximo work order long description. Supports knowledge management and future FMEA updates.',
    CONSTRAINT pk_asset_downtime_event PRIMARY KEY(`asset_downtime_event_id`)
) COMMENT 'Discrete downtime event record tracking unplanned and planned equipment stoppages on the shop floor, including start timestamp, end timestamp, total duration minutes, downtime category (breakdown, changeover, planned maintenance, tooling, material shortage, quality hold, no operator), affected equipment asset, affected production line, shift context, root cause code, and OEE availability impact percentage. Integrates with MES/SCADA downtime capture systems and manual operator entry. Feeds OEE calculation pipelines, downtime Pareto analysis, and production loss costing. Serves as the SSOT for all equipment stoppage events regardless of cause.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` (
    `condition_reading_id` BIGINT COMMENT 'Unique surrogate identifier for each condition monitoring or meter reading record. Primary key for the condition_reading data product in the asset domain.',
    `alarm_event_id` BIGINT COMMENT 'Reference to the condition monitoring alert or alarm record generated as a result of this threshold-breaching reading. Null when no alert was raised.',
    `asset_downtime_event_id` BIGINT COMMENT 'Reference to a downtime event record if this reading was captured in the context of or immediately preceding an equipment downtime event. Enables correlation of condition readings with downtime causation for MTBF/MTTR analysis.',
    `asset_pm_schedule_id` BIGINT COMMENT 'Reference to the preventive maintenance schedule record that was triggered or updated by this reading. Populated when pm_trigger_flag is true.',
    `asset_work_order_id` BIGINT COMMENT 'Reference to the maintenance work order associated with this reading, if the reading was captured during a planned or corrective maintenance activity in Maximo.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Condition Reading records must identify the originating device for traceability in Condition Monitoring and Alerting systems.',
    `employee_id` BIGINT COMMENT 'Reference to the operator or maintenance technician who manually entered or confirmed this reading. Populated for manual_entry and cmms_import reading sources. Null for fully automated sensor feeds.',
    `equipment_register_id` BIGINT COMMENT 'Reference to the physical asset or equipment from which this reading was captured. Links to the asset master record in Maximo Asset Management.',
    `location_id` BIGINT COMMENT 'Reference to the physical plant location or functional location where the asset and sensor are installed at the time of reading. Supports geographic and facility-level aggregation of condition data.',
    `lubrication_route_id` BIGINT COMMENT 'Reference to the lubrication route record when this reading was captured as part of a scheduled lubrication monitoring round. Supports oil viscosity and contamination trending for lubrication-based CBM programs.',
    `production_line_id` BIGINT COMMENT 'Reference to the production line or manufacturing cell on which the asset is operating at the time of reading. Enables correlation of condition readings with production output, OEE, and downtime events.',
    `shift_id` BIGINT COMMENT 'Reference to the production shift during which this reading was captured. Enables shift-level analysis of equipment condition trends and correlation with operator-specific maintenance practices.',
    `tag_definition_id` BIGINT COMMENT 'The SCADA or DCS tag name/identifier assigned to the sensor or measurement point (e.g., LINE1-PUMP-VIB-001). Used to correlate readings back to the process control system tag database in Aveva SCADA or a DCS historian.',
    `alert_severity` STRING COMMENT 'Severity classification assigned to this reading when a threshold breach is detected. none indicates no breach; informational is advisory only; warning requires monitoring; critical requires prompt maintenance action; emergency requires immediate shutdown or intervention. Drives maintenance prioritization and escalation routing.. Valid values are `none|informational|warning|critical|emergency`',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'The ambient environmental temperature in degrees Celsius at the measurement location at the time of reading. Used as a contextual covariate for temperature-sensitive condition measurements such as bearing temperature and oil viscosity.',
    `asset_operating_state` STRING COMMENT 'The operational state of the asset at the time the reading was captured. Condition readings taken during different operating states (running vs idle vs startup) have different baseline norms and must be segregated for accurate trend analysis and anomaly detection.. Valid values are `running|idle|startup|shutdown|maintenance`',
    `asset_tag_number` STRING COMMENT 'The externally visible physical tag or barcode number affixed to the equipment from which this reading was taken. Provides a human-readable cross-reference to the physical asset in the field, independent of the system surrogate key.',
    `batch_number` STRING COMMENT 'Identifier of the data ingestion batch or pipeline run that loaded this reading into the lakehouse silver layer. Supports data lineage, reprocessing, and audit trail for the condition monitoring data pipeline.',
    `calibration_factor` DECIMAL(18,2) COMMENT 'Multiplicative or additive calibration coefficient applied to the raw sensor value to derive the engineering-unit reading value. Supports traceability of measurement accuracy and recalculation when sensor calibration is updated.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this condition reading record was first created or ingested into the lakehouse silver layer. Distinct from reading_timestamp which captures the real-world event time.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) representing the assessed quality and reliability of this reading, computed by the IIoT gateway, SCADA historian, or data ingestion pipeline. Factors include signal noise, transmission completeness, and calibration currency. Used to weight readings in predictive maintenance models.',
    `delta_value` DECIMAL(18,2) COMMENT 'The incremental change in the reading value since the previous reading for the same sensor or meter. For cumulative meters, this represents consumption or usage since the last reading (e.g., runtime hours accumulated since last meter read). Used for utilization rate calculation and meter-based PM trigger logic.',
    `equipment_class` STRING COMMENT 'Classification of the equipment type from which the reading was taken (e.g., rotating_machinery, static_equipment, electrical_panel, cnc_machine, robot, plc, hvac). Enables class-level benchmarking of condition data and FMEA alignment. [ENUM-REF-CANDIDATE: rotating_machinery|static_equipment|electrical_panel|cnc_machine|robot|plc|hvac|conveyor|compressor|pump — promote to reference product]',
    `frequency_band` STRING COMMENT 'For vibration and acoustic emission readings, the frequency band or spectral range (e.g., 10-1000 Hz, 1-10 kHz) within which the measurement was taken. Enables frequency-domain analysis for bearing fault detection and rotating machinery diagnostics.',
    `functional_location_code` STRING COMMENT 'Alphanumeric code identifying the functional location (plant area, production line, or equipment position) within the facility hierarchy where the reading was taken. Aligns with SAP PM functional location structure and Maximo location hierarchy.',
    `is_manual_override` BOOLEAN COMMENT 'Boolean flag indicating that the reading value was manually entered or corrected by an operator, overriding an automated sensor value. When true, the original automated value is preserved in raw_value for audit purposes.',
    `load_percentage` DECIMAL(18,2) COMMENT 'The percentage of rated capacity or load at which the asset was operating when this reading was taken (0.00–100.00). Load normalization is essential for accurate condition trending — the same vibration amplitude at 50% load vs 100% load has different diagnostic significance.',
    `measurement_direction` STRING COMMENT 'The physical axis or direction in which the measurement was taken for directional sensors such as vibration accelerometers (axial, radial, tangential) or displacement probes. Null for non-directional measurements such as temperature or pressure.. Valid values are `axial|radial|tangential|vertical|horizontal|omnidirectional`',
    `measurement_type` STRING COMMENT 'Specific physical or operational quantity being measured. Examples include vibration, temperature, pressure, oil_viscosity, acoustic_emission, ultrasound, runtime_hours, cycle_count, energy_consumption_kwh, distance_km, production_units. [ENUM-REF-CANDIDATE: vibration|temperature|pressure|oil_viscosity|acoustic_emission|ultrasound|runtime_hours|cycle_count|energy_consumption|distance|production_units|current|voltage|flow_rate — promote to reference product]',
    `override_reason` STRING COMMENT 'Free-text or coded reason provided by the operator when manually overriding or correcting an automated reading. Required when is_manual_override is true. Supports audit trail and data quality governance.',
    `pm_trigger_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this reading caused a meter-based or condition-based preventive maintenance (PM) schedule to be triggered in the CMMS. True when the cumulative meter value crossed a PM due-point or a condition indicator breached a CBM trigger threshold.',
    `raw_value` DECIMAL(18,2) COMMENT 'The unprocessed, uncalibrated value as received directly from the sensor or IIoT gateway before any engineering unit conversion, calibration offset, or data quality correction is applied. Preserved for audit, recalibration, and data lineage purposes.',
    `reading_source` STRING COMMENT 'Origin system or method by which the reading was captured. Distinguishes automated IIoT gateway feeds, Aveva SCADA real-time data, Siemens Opcenter MES inputs, manual operator entries, CMMS (Maximo) imports, and energy management system (EMS) feeds. Critical for data lineage and trust scoring.. Valid values are `iiot_gateway|scada|mes|manual_entry|cmms_import|ems`',
    `reading_status` STRING COMMENT 'Quality or lifecycle status of the reading record. valid indicates a confirmed good reading; suspect flags a reading that may be erroneous pending review; invalid marks a rejected reading; estimated indicates an interpolated or manually estimated value; overridden indicates the original value was corrected by an operator.. Valid values are `valid|suspect|invalid|estimated|overridden`',
    `reading_timestamp` TIMESTAMP COMMENT 'The precise date and time (with timezone offset) at which the condition measurement or meter reading was recorded. This is the principal business event timestamp used for time-series analysis, predictive maintenance (PdM) trigger logic, and condition-based maintenance (CBM) scheduling.',
    `reading_type` STRING COMMENT 'Discriminator indicating whether this record represents a condition indicator (instantaneous measurement such as vibration, temperature, pressure) or a cumulative meter/counter reading (runtime hours, cycle counts, energy consumption, distance traveled). Drives downstream PM trigger logic.. Valid values are `condition_indicator|cumulative_meter`',
    `reading_value` DECIMAL(18,2) COMMENT 'The principal observed numeric measurement or meter count captured at the reading timestamp. For condition indicators this is the instantaneous measured value (e.g., 2.45 mm/s vibration velocity). For cumulative meters this is the absolute odometer-style counter value at the time of reading.',
    `sampling_interval_sec` STRING COMMENT 'The configured data acquisition interval in seconds at which this sensor or meter is polled or sampled. Used to validate reading frequency, detect missed readings, and calculate expected vs actual data completeness.',
    `sensor_code` BIGINT COMMENT 'Reference to the specific sensor, transducer, or meter instrument that produced this reading. Identifies the IIoT device, SCADA tag, or manual meter point.',
    `source_system_record_code` STRING COMMENT 'The native record identifier from the originating operational system (e.g., Maximo meter reading ID, Aveva SCADA historian tag timestamp key, Siemens Opcenter MES event ID). Enables bidirectional traceability between the lakehouse silver layer and the system of record.',
    `threshold_breached` BOOLEAN COMMENT 'Boolean flag indicating whether the reading value exceeded either the low or high threshold limit at the time of capture. True triggers downstream alert generation and may initiate predictive maintenance (PdM) or corrective maintenance workflows.',
    `threshold_high` DECIMAL(18,2) COMMENT 'Upper boundary of the acceptable operating range for this measurement type on this asset. A reading above this value triggers a high-threshold breach flag and may initiate a CBM alert or PdM workflow.',
    `threshold_low` DECIMAL(18,2) COMMENT 'Lower boundary of the acceptable operating range for this measurement type on this asset. A reading below this value triggers a low-threshold breach flag and may initiate a condition-based maintenance (CBM) alert or predictive maintenance (PdM) workflow.',
    `unit_of_measure` STRING COMMENT 'Engineering unit associated with the reading value (e.g., mm/s, °C, bar, cSt, dB, kWh, hours, cycles, units, km). Follows SI and industry-standard unit conventions to ensure dimensional consistency across analytics.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this condition reading record was last modified in the lakehouse silver layer, for example following a manual override, data quality correction, or status update.',
    CONSTRAINT pk_condition_reading PRIMARY KEY(`condition_reading_id`)
) COMMENT 'Time-series asset measurement record capturing condition monitoring data (vibration, temperature, pressure, oil viscosity, acoustic emission, ultrasound) and cumulative meter/counter readings (runtime hours, cycle counts, production units, energy consumption, distance traveled) from equipment sensors, IIoT gateways, SCADA systems, and manual operator inputs. Stores reading timestamp, sensor/meter identifier, reading type (condition indicator vs cumulative meter), measurement unit, current value, delta since last reading, threshold breach flag, alert severity, and reading source. Serves as the single source of truth for all equipment measurement data — supports predictive maintenance (PdM) trigger logic, condition-based maintenance (CBM), meter-based PM schedule triggering, lubrication route monitoring, and asset utilization rate calculation.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` (
    `spare_part_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for the spare part master record in the Maximo Inventory and SAP MM-PM integration. Serves as the primary key for this entity.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Spare‑part inventory matches parts to engineering component definitions for correct replacement and cost estimation.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Spare Part Inventory links parts to the specific device they service, required for Spare Part Allocation and Serviceability reports.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Spare parts are stored at a physical location; linking to asset_location eliminates redundant location fields and enables location‑based inventory queries.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Enables inventory, procurement and cost tracking by linking each spare part to its SKU definition used in MRP and purchasing.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Spare‑part inventory management uses stock_location to locate bins; linking enables accurate stock counts, replenishment planning, and pick‑list generation.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Spare‑part purchasing tracks which vendor supplies each part for inventory valuation and PO generation.',
    `abc_class` STRING COMMENT 'ABC classification for inventory prioritization based on annual consumption value. A items represent high-value, high-priority parts requiring tight inventory control; B items are moderate value; C items are low-value, high-volume parts with relaxed control. Aligns with SAP MM ABC Indicator and supports MRP/MRP II planning.. Valid values are `A|B|C`',
    `average_annual_consumption` DECIMAL(18,2) COMMENT 'Average quantity of this spare part consumed per year across all work orders and maintenance activities. Used for ABC classification, reorder point calculation, and inventory optimization in Microsoft Dynamics 365 Supply Chain Management.',
    `capex_asset_flag` BOOLEAN COMMENT 'Indicates whether this spare part is classified as a capital expenditure (CapEx) item that must be capitalized on the asset register rather than expensed as operational expenditure (OpEx). Drives financial treatment in SAP FI/CO and supports CapEx asset register management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the spare part master record was first created in the source system (Maximo or SAP MM). Supports data lineage, audit trail, and record lifecycle tracking per ISO 9001 document control requirements.',
    `criticality_class` STRING COMMENT 'Maintenance criticality classification of the spare part. insurance_spare denotes a high-value, long-lead-time part held solely to protect against catastrophic equipment failure; critical denotes parts whose absence would cause significant production downtime; non_critical denotes parts with readily available substitutes or low downtime impact. Drives stocking policy and capital allocation decisions.. Valid values are `insurance_spare|critical|non_critical`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard cost and last purchase price fields (e.g., USD, EUR, GBP). Enables multi-currency reporting across global manufacturing plants.. Valid values are `^[A-Z]{3}$`',
    `drawing_number` STRING COMMENT 'Reference to the engineering drawing or technical document number in Siemens Teamcenter PLM (PDM) that defines the specifications, dimensions, and tolerances for this spare part. Supports design-to-maintenance traceability.',
    `equipment_category` STRING COMMENT 'Broad category of production equipment or facility asset for which this spare part is applicable. Supports OEM compatibility list management and enables filtering of applicable parts during maintenance planning. [ENUM-REF-CANDIDATE: cnc_machine|plc|robotics|conveyor|hvac|electrical_panel|pump|motor|sensor|general — promote to reference product]',
    `equipment_class_code` STRING COMMENT 'Equipment class or functional location class code identifying the category of production equipment (e.g., CNC machines, PLCs, robotics, conveyors) for which this spare part is applicable. Supports OEM compatibility list management and preventive maintenance (PM) task planning in Maximo.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether this spare part is classified as a hazardous material requiring special handling, storage, or disposal procedures under OSHA or EPA regulations. Drives safety data sheet (SDS) requirements and storeroom segregation rules.',
    `hazmat_class_code` STRING COMMENT 'Regulatory hazardous material classification code (e.g., UN/DOT hazard class) for spare parts flagged as hazardous. Required for compliant storage, transport documentation, and EPA/OSHA reporting. Null when hazardous_material_flag is false.',
    `interchangeable_part_numbers` STRING COMMENT 'Comma-separated list of alternative part numbers that are functionally interchangeable with this spare part. Supports maintenance technician substitution decisions when the primary part is out of stock. Managed in Maximo Item Cross-Reference.',
    `last_issued_date` DATE COMMENT 'Date on which this spare part was most recently issued from the storeroom to a maintenance work order. Used to identify slow-moving or dormant inventory for stock rationalization and obsolescence review.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the spare part master record was most recently updated in the source system. Used for change tracking, delta load processing in the Databricks Silver Layer, and audit compliance.',
    `last_purchase_price` DECIMAL(18,2) COMMENT 'Most recent purchase price per unit of measure paid to a supplier for this spare part. Sourced from SAP MM purchasing info record (EINA/EINE) or Maximo PO history. Used for budget estimation and procurement benchmarking.',
    `last_received_date` DATE COMMENT 'Date on which the most recent goods receipt was posted for this spare part in the storeroom. Used to track replenishment activity and assess supplier delivery performance.',
    `maintenance_strategy` DECIMAL(18,2) COMMENT 'Maintenance strategy associated with this spare part, indicating the primary maintenance approach for which the part is consumed. Supports Total Productive Maintenance (TPM) planning and work order scheduling in Maximo and SAP PM.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer (OEM) or component manufacturer who produces this spare part. Used for sourcing, warranty management, and OEM compatibility validation.',
    `manufacturer_part_number` STRING COMMENT 'The Original Equipment Manufacturer (OEM) or component manufacturers part number. Used for cross-referencing during procurement, warranty claims, and interchangeability validation. Corresponds to SAP Manufacturer Part Number (MFRPN) and Maximo Manufacturer Part Number field.',
    `material_group_code` STRING COMMENT 'SAP Material Group (MATKL) code classifying the spare part into a procurement category for spend analysis, sourcing strategy, and reporting. Aligns with SAP Ariba category management and supports CapEx/OpEx classification.',
    `max_stock_qty` DECIMAL(18,2) COMMENT 'Maximum allowable on-hand inventory quantity for this spare part in the storeroom. Used to prevent overstocking and manage storeroom space. Corresponds to SAP MM Maximum Stock Level (MABST) and Maximo Maximum Quantity.',
    `minimum_order_qty` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered per purchase order line for this spare part, as stipulated by the supplier or procurement policy. Corresponds to SAP MM Minimum Order Quantity (MINBE) and Maximo Order Unit.',
    `mro_category` STRING COMMENT 'MRO procurement category classifying the spare part within the broader maintenance materials taxonomy. Used for spend analytics, category management in SAP Ariba, and OpEx reporting. [ENUM-REF-CANDIDATE: spare_parts|consumables|lubricants|tools|safety_supplies|electrical_supplies — promote to reference product]. Valid values are `spare_parts|consumables|lubricants|tools|safety_supplies|electrical_supplies`',
    `part_description` STRING COMMENT 'Long-form technical description of the spare part including functional purpose, specifications, and application context. Supports maintenance technician identification and procurement sourcing.',
    `part_name` STRING COMMENT 'Short descriptive name of the spare part as used in maintenance work orders, purchase requisitions, and storeroom pick lists. Corresponds to SAP Material Short Text (MAKTX) and Maximo Item Description.',
    `part_number` STRING COMMENT 'The internal part number (material number) assigned to the spare part in SAP MM / Maximo Inventory. This is the primary business identifier used across procurement, maintenance work orders, and storeroom operations. Corresponds to SAP Material Number (MATNR) and Maximo Item Number.. Valid values are `^[A-Z0-9-.]{3,40}$`',
    `part_status` STRING COMMENT 'Current lifecycle status of the spare part master record. active indicates the part is in use and available for procurement and work orders; obsolete indicates the part is no longer supported; superseded indicates it has been replaced by another part number; pending_approval indicates the record is under review; blocked indicates procurement or usage is temporarily suspended.. Valid values are `active|obsolete|superseded|pending_approval|blocked`',
    `part_type` STRING COMMENT 'Technical classification of the spare part by engineering discipline. Drives routing to the correct maintenance trade, storeroom zone, and procurement category. [ENUM-REF-CANDIDATE: mechanical|electrical|electronic|hydraulic|pneumatic|consumable|structural|instrumentation — promote to reference product]',
    `preferred_vendor_number` STRING COMMENT 'SAP Vendor Account Number (LIFNR) or SAP Ariba supplier ID of the preferred supplier for this spare part. Used to default the vendor on purchase requisitions and supports supplier performance management.',
    `procurement_type` STRING COMMENT 'Indicates whether the spare part is procured externally from a supplier (external), produced internally (internal), or both. Corresponds to SAP MM Procurement Type (BESKZ) and drives MRP planning logic.. Valid values are `external|internal|both`',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether this spare part requires a quality inspection upon goods receipt before it can be issued to a work order. Corresponds to SAP QM Inspection Type 01 (Goods Receipt Inspection) and supports ISO 9001 incoming quality control requirements.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level at which a replenishment order is automatically triggered in SAP MRP or Maximo Inventory. Calculated based on average consumption rate, lead time, and safety stock. Expressed in the parts base unit of measure.',
    `replenishment_lead_time_days` STRING COMMENT 'Number of calendar days from purchase order placement to receipt of the spare part at the storeroom. Used in reorder point calculation and MRP planning. Corresponds to SAP MM Planned Delivery Time (PLIFZ) and Maximo Lead Time.',
    `safety_stock_qty` DECIMAL(18,2) COMMENT 'Minimum buffer stock quantity maintained to protect against demand variability and supply lead time uncertainty. Corresponds to SAP MM Safety Stock (EISBE) and Maximo Safety Stock field. Expressed in the parts base unit of measure.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days this spare part can be stored before it expires or degrades below acceptable quality standards. Applicable to consumables, lubricants, seals, gaskets, and chemical materials. Corresponds to SAP MM Total Shelf Life (MHDRZ). Zero or null indicates no shelf life restriction.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit of measure for the spare part as maintained in SAP MM valuation (moving average or standard price). Used for inventory valuation, work order cost accounting, and CapEx/OpEx reporting. Expressed in the plants local currency.',
    `superseded_by_part_number` STRING COMMENT 'Part number of the replacement spare part that supersedes this record in the interchangeability/supersession chain. Populated when part_status is superseded. Enables maintenance planners to identify the correct current part for work orders.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for the spare part as defined in SAP MM (MEINS) and Maximo. Governs how the part is stocked, issued, and ordered. Common values include EA (each), KG (kilogram), L (litre), M (metre), SET, BOX. [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|SET|BOX|ROLL|PAIR — 10 candidates stripped; promote to reference product]',
    `valuation_class` STRING COMMENT 'SAP MM Valuation Class (BKLAS) that determines the general ledger (GL) accounts posted when inventory movements occur for this spare part. Critical for financial integration between MM and FI/CO modules.',
    `warranty_expiry_date` DATE COMMENT 'Date on which the manufacturers warranty for this spare part expires. Used to trigger warranty claims before expiry and to avoid unnecessary procurement of parts still under warranty coverage.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Gross weight of the spare part per base unit of measure, expressed in kilograms. Used for logistics planning, freight cost estimation, and storeroom load calculations. Corresponds to SAP MM Gross Weight (BRGEW).',
    CONSTRAINT pk_spare_part PRIMARY KEY(`spare_part_id`)
) COMMENT 'Spare parts and MRO (Maintenance, Repair, and Operations) materials master record specific to asset maintenance, including part number, description, manufacturer part number, OEM compatibility list (linked to equipment classes and specific assets), criticality classification (insurance spares, critical, non-critical), ABC classification for inventory prioritization, reorder point, safety stock level, lead time, unit of measure, storeroom bin location, interchangeability/supersession chain, and shelf life expiry where applicable. Distinct from production inventory — focused on maintenance-specific materials managed in Maximo Inventory and SAP MM-PM integration. Serves as the SSOT for maintenance material identity and stocking parameters.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` (
    `reliability_record_id` BIGINT COMMENT 'Unique surrogate identifier for the reliability performance record. Primary key for this entity in the Databricks Silver Layer.',
    `asset_work_order_id` BIGINT COMMENT 'Reference to the most recent corrective or preventive maintenance work order associated with this reliability measurement period. Sourced from Maximo Asset Management.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: RELIABILITY: Reliability metrics are reported per cost center for performance benchmarking.',
    `equipment_register_id` BIGINT COMMENT 'Reference to the physical equipment or asset for which this reliability record is calculated. Maps to the asset master in Maximo Asset Management.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Reliability metrics are reported at the project level for performance tracking.',
    `approved_by` STRING COMMENT 'Name or employee ID of the reliability engineer or maintenance manager who reviewed and approved this reliability record. Required for ISO 55001 audit trail and CAPA documentation.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this reliability record was formally approved by the responsible engineer or manager (yyyy-MM-ddTHH:mm:ss.SSSXXX). Part of the ISO 55001 asset management audit trail.',
    `asset_class` STRING COMMENT 'Classification of the asset by equipment type (e.g., CNC Machine, PLC Controller, Robotic Arm, Conveyor, HVAC, Compressor). Drives maintenance strategy selection and RAM analysis grouping. [ENUM-REF-CANDIDATE: cnc_machine|plc_controller|robotic_arm|conveyor|hvac|compressor|press|pump|motor|sensor — promote to reference product]',
    `asset_description` STRING COMMENT 'Human-readable description of the equipment or asset (e.g., CNC Machining Center Line 3, Hydraulic Press Unit 7). Denormalized from the asset master for reporting convenience.',
    `asset_health_score` DECIMAL(18,2) COMMENT 'Composite asset health index (0-100) derived from availability, MTBF variance, trend direction, and condition monitoring signals. Feeds the asset health dashboard and maintenance strategy selection engine. Calculated by the reliability analytics model.',
    `asset_number` STRING COMMENT 'The externally-known asset tag or equipment number as registered in Maximo Asset Management and the CapEx asset register. Enables cross-system traceability without requiring a FK join.',
    `availability_pct` DECIMAL(18,2) COMMENT 'Percentage of scheduled operating time during which the asset was available for production. Calculated as (total_uptime_hours / total_scheduled_hours) * 100. Represents the OEE availability component per SEMI E10.',
    `availability_target_pct` DECIMAL(18,2) COMMENT 'The contractual or engineering target availability percentage for this asset. Used to measure actual availability against defined performance thresholds and trigger maintenance strategy reviews.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The timestamp when this reliability record was calculated and written to the Silver Layer (yyyy-MM-ddTHH:mm:ss.SSSXXX). Represents the business event time of the reliability computation run. Used for audit and data freshness tracking.',
    `condition_monitoring_enabled` BOOLEAN COMMENT 'Indicates whether the asset is equipped with active condition monitoring sensors (vibration, temperature, oil analysis, ultrasound) feeding real-time data to Aveva SCADA or IIoT platforms. True = condition monitoring active; False = no condition monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reliability record was first created in the system (yyyy-MM-ddTHH:mm:ss.SSSXXX). Audit trail field for data governance and lineage tracking per ISO 55001.',
    `data_source_system` STRING COMMENT 'Identifies the operational system of record from which the failure and downtime data was sourced for this reliability record. Supports data lineage traceability and audit requirements.. Valid values are `maximo|sap_pm|opcenter_mes|aveva_scada|manual`',
    `downtime_cost_usd` DECIMAL(18,2) COMMENT 'Estimated financial cost of unplanned downtime during the measurement period in USD, calculated from production loss rates and maintenance labor costs. Used for CapEx justification and maintenance ROI analysis. Classified confidential as it contains business-sensitive financial data.',
    `failure_mode_count` STRING COMMENT 'Number of distinct failure modes observed for this asset during the measurement period. A high count indicates diverse failure patterns requiring FMEA review; a low count with high frequency indicates a systemic issue.',
    `failure_mode_dominant` STRING COMMENT 'The most frequently occurring failure mode for this asset during the measurement period, as classified in the FMEA register (e.g., bearing wear, seal failure, electrical fault, software fault). Sourced from Maximo failure codes and PFMEA documentation in Teamcenter.',
    `failure_rate` DECIMAL(18,2) COMMENT 'Instantaneous failure rate (lambda) expressed as failures per operating hour. Calculated as total_failures / total_uptime_hours. Used in Weibull analysis and reliability growth modeling per IEC 60300-3-1.',
    `last_failure_date` DATE COMMENT 'Date of the most recent confirmed failure event for this asset within or prior to the measurement period. Used to calculate time-since-last-failure and assess current reliability posture.',
    `maintenance_strategy` DECIMAL(18,2) COMMENT 'Recommended or active maintenance strategy for the asset based on its reliability tier and Weibull parameters. Drives work order generation in Maximo and maintenance scheduling in SAP PM.',
    `mean_time_between_failures` DECIMAL(18,2) COMMENT 'Average operating time between consecutive failure events, expressed in hours. Calculated as total_uptime_hours / total_failures. Core RAM metric used for maintenance strategy selection and spare parts planning. Per IEC 60050-192.',
    `mean_time_to_repair` DECIMAL(18,2) COMMENT 'Average time required to restore the asset to operational status following a failure, expressed in hours. Calculated as total_downtime_hours / total_failures. Key maintainability metric per IEC 60050-192.',
    `measurement_period_end` DATE COMMENT 'The end date of the reliability measurement window (yyyy-MM-dd). Together with measurement_period_start, defines the observation interval for all reliability KPIs in this record.',
    `measurement_period_start` DATE COMMENT 'The start date of the reliability measurement window (yyyy-MM-dd). Defines the beginning of the observation period over which MTBF, MTTR, availability, and failure rate are calculated.',
    `mtbf_target_hours` DECIMAL(18,2) COMMENT 'The engineering or contractual target MTBF value in hours for this asset class and reliability tier. Used to assess performance against design specifications and OEM guarantees. Sourced from Teamcenter PLM or OEM documentation.',
    `mtbf_variance_pct` DECIMAL(18,2) COMMENT 'Percentage variance of actual MTBF against the MTBF target, calculated as ((mean_time_between_failures - mtbf_target_hours) / mtbf_target_hours) * 100. Positive values indicate better-than-target performance; negative values indicate underperformance.',
    `mttr_target_hours` DECIMAL(18,2) COMMENT 'The engineering or SLA-defined target MTTR value in hours for this asset class. Used to assess maintenance team responsiveness against defined service levels. Sourced from Maximo SLA configuration or OEM documentation.',
    `next_pm_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity for this asset, as generated by Maximo PM scheduling based on the current reliability tier and maintenance strategy. Drives maintenance planning and spare parts pre-positioning.',
    `oee_availability_component` DECIMAL(18,2) COMMENT 'The availability component of the OEE metric for this asset during the measurement period, expressed as a percentage. Represents the proportion of scheduled time the asset was not lost to unplanned downtime. Feeds the OEE dashboard in Opcenter MES.',
    `period_duration_days` DECIMAL(18,2) COMMENT 'Total calendar duration of the measurement period in days. Derived from period start and end dates and stored for query performance in RAM analysis and trend reporting.',
    `planned_maintenance_hours` DECIMAL(18,2) COMMENT 'Total hours consumed by scheduled preventive maintenance activities during the measurement period. Excluded from unplanned downtime but included in total non-productive time for OEE availability component calculation.',
    `plant_code` STRING COMMENT 'SAP S/4HANA plant code identifying the manufacturing facility where the asset is installed. Used for site-level reliability benchmarking and OEE rollup.. Valid values are `^[A-Z0-9]{2,10}$`',
    `record_number` STRING COMMENT 'Externally-known business identifier for this reliability record, formatted as RR-{YYYY}-{NNNNNN}. Used for cross-system referencing and audit traceability in Maximo and SAP PM.. Valid values are `^RR-[0-9]{4}-[0-9]{6}$`',
    `record_status` STRING COMMENT 'Current lifecycle state of this reliability record. draft = under calculation; active = current approved record; superseded = replaced by a revised record; archived = historical retention only.. Valid values are `draft|active|superseded|archived`',
    `reliability_tier` STRING COMMENT 'Criticality-based reliability tier assigned to the asset for this period. P1 = mission-critical (highest priority); P2 = production-critical; P3 = important; P4 = standard; P5 = non-critical. Drives maintenance strategy selection (predictive vs preventive vs run-to-failure) and spare parts stocking levels.. Valid values are `P1|P2|P3|P4|P5`',
    `replacement_recommended` BOOLEAN COMMENT 'Indicates whether the reliability analysis for this period has triggered a capital replacement recommendation for the asset. True = replacement recommended based on Weibull end-of-life analysis or sustained P1 degradation trend. Feeds CapEx planning.',
    `total_downtime_hours` DECIMAL(18,2) COMMENT 'Cumulative unplanned downtime hours for the asset during the measurement period, including all failure-induced stoppages. Used as the primary input for MTTR and availability calculations. Source: Maximo and Opcenter MES.',
    `total_failures` DECIMAL(18,2) COMMENT 'Total count of confirmed failure events recorded for the asset during the measurement period. A failure is defined as any unplanned stoppage requiring corrective maintenance. Source: Maximo work order history.',
    `total_scheduled_hours` DECIMAL(18,2) COMMENT 'Total hours the asset was scheduled for production during the measurement period, excluding planned shutdowns and holidays. Denominator for availability percentage calculation per SEMI E10 standard.',
    `total_uptime_hours` DECIMAL(18,2) COMMENT 'Cumulative operating hours during which the asset was available and running during the measurement period. Used as the primary input for MTBF and availability calculations. Source: Maximo and Aveva SCADA.',
    `trend_direction` STRING COMMENT 'Directional indicator of reliability performance trend compared to the prior measurement period. improving = MTBF increasing / MTTR decreasing; stable = within control limits; degrading = MTBF declining; critical = threshold breach requiring immediate action.. Valid values are `improving|stable|degrading|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this reliability record (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, SCD Type 2 processing, and audit compliance.',
    `weibull_beta` DECIMAL(18,2) COMMENT 'Weibull distribution shape parameter (beta) fitted to the failure time data for this asset during the measurement period. Beta < 1 indicates infant mortality; beta = 1 indicates random failures; beta > 1 indicates wear-out. Used for predictive maintenance scheduling.',
    `weibull_eta` DECIMAL(18,2) COMMENT 'Weibull distribution scale parameter (eta), also known as the characteristic life, expressed in hours. Represents the time at which 63.2% of the asset population is expected to have failed. Used for replacement interval optimization.',
    `weibull_gamma` DECIMAL(18,2) COMMENT 'Weibull distribution location parameter (gamma), representing the failure-free operating period in hours before the onset of failures. Nullable when a two-parameter Weibull model is applied (gamma = 0).',
    `weibull_r_squared` DECIMAL(18,2) COMMENT 'Coefficient of determination (R²) for the Weibull distribution fit to the failure data. Values closer to 1.0 indicate a better fit. Used to validate the reliability model quality before using parameters for maintenance planning.',
    CONSTRAINT pk_reliability_record PRIMARY KEY(`reliability_record_id`)
) COMMENT 'Calculated reliability performance record per equipment asset capturing MTBF (Mean Time Between Failures), MTTR (Mean Time To Repair), availability percentage, failure rate (lambda), OEE availability component, and Weibull distribution parameters over a defined measurement period. Stores period start/end dates, total failures, total downtime hours, total uptime hours, reliability tier classification (P1-P5), and trend direction indicator. Feeds asset health scoring, maintenance strategy selection (run-to-failure vs preventive vs predictive), and capital replacement planning. Serves as the operational reliability SSOT for asset health trending and RAM (Reliability, Availability, Maintainability) analysis.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` (
    `capex_asset_record_id` BIGINT COMMENT 'Unique identifier for the capital expenditure asset record. Primary key for the asset register tracking capitalized equipment and infrastructure investments.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAPEX: Capital asset records need a cost‑center link for asset capitalization and depreciation tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or manager responsible for the asset. Used for asset custody tracking and accountability.',
    `equipment_register_id` BIGINT COMMENT 'Connect asset.capex_asset_record by adding column equipment_register_id (BIGINT) with an FK to asset.equipment_register.equipment_register_id. P17: connect_table: asset.capex_asset_record** - add column equipment_register_id (BIGINT) with F',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom the asset was purchased. Links to procurement and accounts payable systems.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since capitalization. Contra-asset account that reduces the gross book value to calculate net book value.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total original cost of acquiring the asset including purchase price, delivery, installation, and any costs necessary to bring the asset to working condition. Represents the capitalized value on the balance sheet.',
    `acquisition_date` TIMESTAMP COMMENT 'Date when the asset was acquired or purchased. Used as the starting point for asset lifecycle tracking and may differ from capitalization date.',
    `asset_category` STRING COMMENT 'High-level categorization of the asset type for reporting and analysis. Broader classification than asset class code. [ENUM-REF-CANDIDATE: production_equipment|facility_infrastructure|transportation|computer_equipment|furniture_fixtures|land|buildings|leasehold_improvements — 8 candidates stripped; promote to reference product]',
    `asset_class_code` STRING COMMENT 'Classification code defining the type of capital asset (e.g., machinery, buildings, vehicles, computer equipment, production equipment). Determines depreciation rules and financial treatment per SAP asset class hierarchy.. Valid values are `^[A-Z0-9]{4,10}$`',
    `asset_description` STRING COMMENT 'Detailed business description of the capital asset including make, model, specifications, and purpose. Used for asset identification and reporting.',
    `asset_group_code` STRING COMMENT 'Grouping code for related assets that function together as a unit (e.g., production line, SCADA system). Used for impairment testing and cash-generating unit analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `asset_number` STRING COMMENT 'Externally-known unique business identifier for the capitalized asset. Used across SAP FI-AA (Fixed Assets) module, maintenance systems, and financial reporting. Also known as asset tag or asset code.. Valid values are `^[A-Z0-9]{8,20}$`',
    `asset_status` STRING COMMENT 'Current lifecycle status of the capital asset. Determines whether depreciation is active and whether the asset appears in operational asset registers. [ENUM-REF-CANDIDATE: active|in_service|under_construction|retired|disposed|transferred|impaired — 7 candidates stripped; promote to reference product]',
    `capitalization_date` DATE COMMENT 'Date when the asset was placed in service and capitalized on the balance sheet. Depreciation begins from this date. Critical for financial reporting and tax compliance.',
    `capitalization_threshold_met` BOOLEAN COMMENT 'Indicates whether the asset acquisition cost met the company capitalization threshold policy. Assets below threshold are expensed as OpEx rather than capitalized as CapEx.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this asset record (acquisition cost, accumulated depreciation, net book value).. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate periodic depreciation expense. Straight-line is most common for manufacturing equipment. Method is determined by asset class and regulatory requirements.. Valid values are `straight_line|declining_balance|double_declining_balance|units_of_production|sum_of_years_digits|none`',
    `disposal_date` DATE COMMENT 'Date when the asset was disposed of, sold, scrapped, or retired from service. Marks the end of the asset lifecycle and triggers gain/loss calculation.',
    `disposal_method` STRING COMMENT 'Method by which the asset was disposed. Determines accounting treatment and documentation requirements.. Valid values are `sold|scrapped|traded_in|donated|transferred|retired`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Amount received from the sale or disposal of the asset. Used to calculate gain or loss on disposal (proceeds minus net book value at disposal).',
    `impairment_indicator` BOOLEAN COMMENT 'Flag indicating whether the asset has been tested for impairment and an impairment loss has been recognized. True if impaired, false otherwise.',
    `impairment_loss_amount` DECIMAL(18,2) COMMENT 'Total impairment loss recognized when the recoverable amount of the asset falls below its carrying amount. Reduces net book value.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering this asset. Used for risk management and claims processing.',
    `last_depreciation_date` DATE COMMENT 'Date when depreciation was last calculated and posted for this asset. Used to track depreciation run schedules and ensure accurate period-end financial reporting.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this asset record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset record was last updated. Used for change tracking and audit trail.',
    `location_description` STRING COMMENT 'Detailed physical location of the asset within the plant or facility (e.g., building, floor, room, production line). Used for asset tracking and maintenance work order dispatch.',
    `manufacturer_name` STRING COMMENT 'Name of the equipment manufacturer or Original Equipment Manufacturer (OEM). Used for warranty tracking, spare parts sourcing, and maintenance support.',
    `model_number` STRING COMMENT 'Manufacturer model number or designation for the asset. Used for technical specifications, spare parts identification, and maintenance procedures.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset calculated as acquisition cost minus accumulated depreciation. Represents the asset value on the balance sheet. Also known as carrying amount.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility where the asset is physically located. Used for asset tracking, maintenance planning, and site-level reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `purchase_order_number` STRING COMMENT 'Purchase order number under which the asset was procured. Provides audit trail to procurement documentation and invoice matching.. Valid values are `^[A-Z0-9]{8,20}$`',
    `revaluation_amount` DECIMAL(18,2) COMMENT 'Fair value amount determined at revaluation date. Difference between revalued amount and carrying amount is recognized in revaluation surplus or profit/loss.',
    `revaluation_date` DATE COMMENT 'Date of the most recent asset revaluation if the revaluation model is used instead of the cost model. Applicable under IFRS when fair value can be reliably measured.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. Used in depreciation calculations to determine depreciable base (acquisition cost minus salvage value).',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer. Used for warranty claims, service history tracking, and asset identification.',
    `tax_depreciation_method` STRING COMMENT 'Depreciation method used for tax reporting purposes. May differ from book depreciation method. MACRS is common in the US for tax purposes.. Valid values are `MACRS|straight_line_tax|section_179|bonus_depreciation|none`',
    `tax_useful_life_years` DECIMAL(18,2) COMMENT 'Useful life in years used for tax depreciation calculations. May differ from book useful life based on tax regulations.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Expected useful economic life of the asset in years over which depreciation will be calculated. Determined by asset class, industry standards, and regulatory guidelines.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty expires. Used for maintenance planning and cost management decisions.',
    CONSTRAINT pk_capex_asset_record PRIMARY KEY(`capex_asset_record_id`)
) COMMENT 'Capital expenditure asset register record tracking the financial lifecycle of capitalized equipment assets, including acquisition cost, capitalization date, asset class, depreciation method (straight-line, declining balance), useful life years, accumulated depreciation, net book value, disposal date, and disposal proceeds. Integrates with SAP FI-AA (Fixed Assets) module and supports CapEx vs OpEx classification for financial reporting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` (
    `inspection_event_id` BIGINT COMMENT 'Unique surrogate identifier for the inspection event record in the asset management domain. Primary key for this entity.',
    `asset_work_order_id` BIGINT COMMENT 'Reference to the Maximo work order under which this inspection was executed, linking the inspection event to the broader maintenance or compliance work order lifecycle.',
    `cost_center_id` BIGINT COMMENT 'Reference to the financial cost center responsible for the inspection activity. Used for CapEx/OpEx cost allocation of inspection labor and any remediation costs identified during the inspection.',
    `equipment_register_id` BIGINT COMMENT 'Reference to the physical asset, equipment, or facility infrastructure component that is the subject of this inspection event (e.g., CNC machine, PLC, robotic cell, HVAC unit).',
    `inspection_checklist_id` BIGINT COMMENT 'Reference to the standardized inspection checklist template used for this inspection event. The checklist defines the specific inspection points, acceptance criteria, and measurement requirements applicable to the asset type and inspection type.',
    `location_id` BIGINT COMMENT 'Reference to the plant, facility, or shop floor location where the inspected asset is installed. Supports geographic and site-level compliance reporting and maintenance planning.',
    `employee_id` BIGINT COMMENT 'Reference to the workforce record of the qualified inspector or technician who performed the inspection. Supports traceability and certification validation per OSHA and ISO 9001 requirements.',
    `product_certification_id` BIGINT COMMENT 'Foreign key linking to product.product_certification. Business justification: Inspection events verify product certification status; the FK enables inspection reports to reference the authoritative certification record.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Inspections are scheduled as part of project quality‑assurance activities.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: INSPECTION SCHEDULING: inspections are triggered by a particular regulation; recording the requirement links the event to compliance obligations.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: External inspection agencies are contracted; the link is required for audit traceability and regulatory reports.',
    `tertiary_inspection_approved_by_employee_id` BIGINT COMMENT 'Reference to the supervisor, quality manager, or authorized approver who reviewed and formally approved the inspection results. Required for regulatory compliance inspections and safety-critical equipment per ISO 9001 and OSHA requirements.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection results were formally reviewed and approved by the authorized approver. Establishes the official close of the inspection event for audit and compliance purposes.',
    `asset_operational_status_at_inspection` TIMESTAMP COMMENT 'The operational state of the asset at the time the inspection was conducted: running (in active production), shutdown (powered down for inspection), standby (idle but available), or under_maintenance (already in a maintenance window). Relevant for OEE downtime attribution and safety compliance.',
    `capa_reference_number` STRING COMMENT 'The externally visible CAPA or NCR reference number raised in the quality management system as a result of this inspections findings. Populated when corrective_action_required is True. Enables cross-system traceability between inspection events and quality corrective actions.',
    `certificate_expiry_date` DATE COMMENT 'The date on which the compliance or safety certificate issued as a result of this inspection expires. Populated only when certificate_issued is True. Drives certificate renewal scheduling and regulatory compliance monitoring.',
    `certificate_issued` BOOLEAN COMMENT 'Indicates whether a compliance certificate, safety certificate, or inspection certificate was issued as a result of this inspection event (True) or not (False). Relevant for UL, CE, and ISO certification inspections.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether one or more findings from this inspection require a formal Corrective and Preventive Action (CAPA) to be initiated. When True, triggers CAPA workflow creation in the quality management system per ISO 9001 Clause 10.2.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection event record was first created in the system, establishing the audit trail entry point. Distinct from inspection_date which records when the physical inspection occurred.',
    `critical_findings_count` STRING COMMENT 'Number of findings classified as critical or safety-critical, requiring immediate corrective action before the asset may return to service. Supports OSHA compliance reporting and safety escalation workflows.',
    `downtime_caused` BOOLEAN COMMENT 'Indicates whether this inspection event caused a production downtime event (True) or was conducted without interrupting production (False). Used for OEE downtime attribution and production loss reporting.',
    `downtime_duration_minutes` DECIMAL(18,2) COMMENT 'Duration in minutes of production downtime directly attributable to this inspection event. Populated only when downtime_caused is True. Feeds OEE availability calculations and production loss reporting.',
    `external_audit_reference` STRING COMMENT 'Reference number or identifier assigned by an external regulatory body, certification authority, or third-party auditor for inspections conducted as part of an external audit program (e.g., OSHA inspection citation number, UL audit reference, ISO certification audit ID). Nullable for internal inspections.',
    `findings_count` STRING COMMENT 'Total number of distinct findings, deficiencies, or non-conformances identified during the inspection event. A finding may span multiple checklist items; this field captures the consolidated count used for CAPA prioritization and NCR generation.',
    `findings_summary` STRING COMMENT 'Free-text narrative summary of the key findings, deficiencies, and observations recorded during the inspection. Provides the qualitative context for the quantitative findings_count and supports CAPA root cause analysis.',
    `inspection_date` TIMESTAMP COMMENT 'The calendar date on which the inspection was physically performed. This is the principal real-world event date used for compliance reporting, regulatory submissions, and maintenance history analysis.',
    `inspection_duration_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time in minutes from inspection start to completion. Derived from start and end timestamps at source but stored as a business fact for resource utilization reporting, labor cost estimation, and inspection planning benchmarks.',
    `inspection_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inspector completed all inspection activities and closed the event. Combined with start timestamp to derive inspection duration for resource planning.',
    `inspection_interval_days` STRING COMMENT 'The prescribed frequency interval in calendar days between successive inspections of this asset, as defined by the preventive maintenance plan, regulatory requirement, or manufacturer specification. Used to calculate next_inspection_due_date.',
    `inspection_method` STRING COMMENT 'The primary technique used to conduct the inspection: visual (physical observation), functional_test (operational test of equipment), measurement (dimensional or parametric measurement), non_destructive_testing (NDT methods such as ultrasonic or thermographic), or document_review (records and certification review). [ENUM-REF-CANDIDATE: visual|functional_test|measurement|non_destructive_testing|document_review|combined — promote to reference product]. Valid values are `visual|functional_test|measurement|non_destructive_testing|document_review`',
    `inspection_number` STRING COMMENT 'Externally visible, human-readable business identifier for the inspection event, used in regulatory submissions, audit trails, and cross-system references (e.g., INSP-2024-000123). Aligns with Maximo inspection record numbering conventions.. Valid values are `^INSP-[0-9]{4}-[0-9]{6}$`',
    `inspection_outcome` STRING COMMENT 'Overall pass/fail result of the inspection event: pass (all checklist items met), fail (one or more critical items failed), conditional_pass (minor findings with corrective action required but asset may continue operating), or incomplete (inspection not fully executed).. Valid values are `pass|fail|conditional_pass|incomplete`',
    `inspection_scope` STRING COMMENT 'Indicates the breadth of the inspection performed: full (all checklist items evaluated), partial (subset of items evaluated due to access or time constraints), or spot_check (random sampling of key items). Affects the validity weight of the inspection outcome for compliance purposes.. Valid values are `full|partial|spot_check`',
    `inspection_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inspector began the inspection activity on-site. Used for duration calculation, shift alignment, and OEE downtime impact analysis.',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the inspection event: scheduled (planned but not started), in_progress (inspector on-site), completed (results recorded), cancelled (inspection voided), or overdue (past due date without completion). Drives maintenance scheduling and compliance dashboards.. Valid values are `scheduled|in_progress|completed|cancelled|overdue`',
    `inspection_type` STRING COMMENT 'Classification of the inspection by its business purpose: preventive (scheduled TPM), safety (OSHA/facility safety), regulatory_compliance (UL, CE, ISO certification), quality_audit (QM equipment audit), condition_based (triggered by sensor/SCADA alert), ad_hoc (unplanned), or acceptance (new asset commissioning). [ENUM-REF-CANDIDATE: preventive|safety|regulatory_compliance|quality_audit|condition_based|ad_hoc|acceptance — promote to reference product]',
    `inspector_certification_number` STRING COMMENT 'The professional certification or qualification number of the inspector, confirming their authority to conduct this type of inspection (e.g., OSHA-certified safety inspector, UL-authorized auditor, ISO lead auditor credential). Required for regulatory compliance evidence.',
    `inspector_name` STRING COMMENT 'Full name of the qualified inspector or technician who performed the inspection. Stored for audit trail and regulatory evidence purposes. Classified as confidential as it is an employee business record.',
    `inspector_remarks` STRING COMMENT 'Free-text field for the inspectors additional observations, recommendations, or notes that do not constitute formal findings but provide context for maintenance planning and asset condition assessment.',
    `items_failed` STRING COMMENT 'Count of checklist line items that did not meet acceptance criteria during this inspection. Drives findings count reporting, CAPA initiation thresholds, and regulatory non-conformance escalation.',
    `items_passed` STRING COMMENT 'Count of checklist line items that met acceptance criteria during this inspection. Together with total_checklist_items and items_failed, provides the raw data for compliance rate reporting without pre-aggregating the metric.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection event record was most recently modified, supporting data lineage, audit trail, and Silver layer incremental processing in the Databricks Lakehouse.',
    `next_inspection_due_date` TIMESTAMP COMMENT 'The date by which the next inspection of this asset must be completed, as determined by the inspection interval, regulatory requirement, or inspector recommendation. Drives the preventive maintenance scheduling engine in Maximo.',
    `plant_code` STRING COMMENT 'SAP S/4HANA plant code identifying the manufacturing facility where the inspected asset resides. Used for cross-system reconciliation between Maximo and SAP PM/QM modules and for plant-level compliance reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `regulatory_body` STRING COMMENT 'The governing body or certification authority whose standard applies to this inspection (e.g., OSHA, ISO, IEC, UL, CE, EPA, NIST, ANSI, IPC). Used to filter and group compliance inspections for regulatory reporting dashboards. [ENUM-REF-CANDIDATE: OSHA|ISO|IEC|UL|CE|EPA|NIST|ANSI|IPC|NONE — 10 candidates stripped; promote to reference product]',
    `regulatory_standard` STRING COMMENT 'The specific regulatory or certification standard under which this inspection was conducted (e.g., OSHA 29 CFR 1910, ISO 9001, ISO 14001, ISO 45001, UL 508A, CE Directive 2006/42/EC, IEC 62443). Mandatory for compliance inspections to support regulatory reporting and audit evidence.',
    `risk_level` STRING COMMENT 'Risk classification assigned to the inspection outcome based on the severity and nature of findings: critical (immediate safety or production risk), high (significant risk requiring prompt action), medium (moderate risk with planned remediation), or low (minor or no risk). Drives escalation and prioritization workflows.. Valid values are `critical|high|medium|low`',
    `scheduled_date` DATE COMMENT 'The originally planned date for this inspection as generated by the preventive maintenance schedule or regulatory compliance calendar. Compared against inspection_date to measure schedule adherence.',
    `total_checklist_items` DECIMAL(18,2) COMMENT 'Total number of inspection checklist line items evaluated during this inspection event. Used as the denominator for compliance rate calculations and inspection completeness metrics.',
    CONSTRAINT pk_inspection_event PRIMARY KEY(`inspection_event_id`)
) COMMENT 'Formal equipment inspection event record capturing scheduled and ad-hoc inspections including safety inspections, regulatory compliance inspections (OSHA, UL, CE), and quality-related equipment audits. Stores inspection type, inspector identity, inspection date, checklist results, pass/fail outcome, findings count, corrective action required flag, and next inspection due date.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` (
    `calibration_record_id` BIGINT COMMENT 'Unique system-generated identifier for each calibration record event. Primary key for the calibration_record data product.',
    `asset_work_order_id` BIGINT COMMENT 'Reference to the Maximo work order under which this calibration activity was planned and executed. Enables traceability from calibration event back to maintenance scheduling.',
    `calibration_standard_id` BIGINT COMMENT 'Reference to the reference standard or master gauge used to perform the calibration. The reference standard must itself be traceable to national or international measurement standards (NIST/SI).',
    `cost_center_id` BIGINT COMMENT 'Reference to the SAP cost center responsible for the calibration activity. Used for OpEx allocation of calibration labor and external service costs.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Calibration records are tied to the calibrated device, needed for Calibration Management and Compliance audit reports.',
    `equipment_register_id` BIGINT COMMENT 'Reference to the physical instrument, gauge, sensor, PLC, or precision measurement tool that was calibrated. Links to the asset master record in Maximo Asset Management.',
    `location_id` BIGINT COMMENT 'Reference to the plant, facility, or functional location where the instrument is installed and where the calibration was performed. Supports site-level compliance reporting and geographic traceability.',
    `employee_id` BIGINT COMMENT 'Reference to the qualified technician or metrologist who performed and certified the calibration. Must hold documented competency for the instrument type per ISO 9001 and ISO/IEC 17025 personnel qualification requirements.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Calibration activities are tied to project milestones for equipment commissioning.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: CALIBRATION COMPLIANCE: each calibration activity is performed to satisfy a defined regulatory standard, requiring a reference to that requirement.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Calibration activities are performed on specific instrument models; linking to SKU provides traceability for compliance and performance reporting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Calibration labs are external suppliers; linking supports compliance and lab‑performance tracking.',
    `adjustment_description` STRING COMMENT 'Narrative description of the adjustment or corrective action applied to the instrument during calibration (e.g., zero offset correction, span adjustment, sensor replacement). Populated only when adjustment_made is True.',
    `adjustment_made` BOOLEAN COMMENT 'Indicates whether a physical adjustment or correction was applied to the instrument during this calibration event. True if the instrument was adjusted; False if it was verified only. Drives downstream impact assessment for prior measurements.',
    `as_found_error` DECIMAL(18,2) COMMENT 'The calculated deviation of the as-found reading from the reference value (as_found_reading minus reference_value). Stored as a business fact to support drift trend analysis and SPC instrument capability studies without requiring recalculation.',
    `as_found_reading` DECIMAL(18,2) COMMENT 'The measured value of the instrument at the start of the calibration event, before any adjustment is made. Used to assess instrument drift, determine if prior measurements were valid, and support SPC instrument traceability analysis.',
    `as_left_error` DECIMAL(18,2) COMMENT 'The calculated deviation of the as-left reading from the reference value (as_left_reading minus reference_value). Confirms residual error after adjustment and is used for measurement uncertainty budgets.',
    `as_left_reading` DECIMAL(18,2) COMMENT 'The measured value of the instrument at the conclusion of the calibration event, after any adjustment or correction has been applied. Confirms the instrument is within tolerance before being returned to service.',
    `calibration_date` TIMESTAMP COMMENT 'The date on which the calibration activity was physically performed. This is the principal business event date used for certificate issuance, compliance records, and next-due-date calculation.',
    `calibration_due_date` TIMESTAMP COMMENT 'The date by which the next calibration must be completed, calculated from calibration_date plus the calibration_interval. Used for preventive maintenance scheduling and compliance monitoring.',
    `calibration_interval_days` DECIMAL(18,2) COMMENT 'The approved recalibration frequency expressed in calendar days. Used to compute calibration_due_date and to schedule preventive maintenance in Maximo. Determined by instrument criticality, historical drift, and manufacturer recommendations.',
    `calibration_lab` DECIMAL(18,2) COMMENT 'Indicates whether the calibration was performed by an internal calibration lab, an externally accredited laboratory (ISO/IEC 17025), an external non-accredited service provider, or the OEM service team.',
    `calibration_method` DECIMAL(18,2) COMMENT 'The documented calibration procedure or method reference used (e.g., internal procedure number, NIST traceable method, manufacturer procedure). Ensures repeatability and traceability of the calibration process.',
    `calibration_notes` DECIMAL(18,2) COMMENT 'Free-text field for the technician to record observations, anomalies, special conditions, or additional context about the calibration event not captured in structured fields.',
    `calibration_number` DECIMAL(18,2) COMMENT 'Externally visible, human-readable unique identifier for this calibration event, used on calibration certificates and quality records. Format: CAL-{ASSET_CODE}-{SEQUENCE}.',
    `calibration_status` DECIMAL(18,2) COMMENT 'Overall result and lifecycle status of the calibration event. pass indicates the instrument is within tolerance; fail triggers quarantine and CAPA; conditional_pass indicates marginal acceptance with restrictions; out_of_tolerance indicates as-found deviation requiring adjustment.',
    `calibration_type` DECIMAL(18,2) COMMENT 'Classification of the calibration event by trigger or purpose. initial is performed on new instruments; periodic is routine scheduled calibration; after_repair follows maintenance; unscheduled is triggered by suspected drift or incident.',
    `capa_reference` STRING COMMENT 'Reference number of the Corrective and Preventive Action (CAPA) record initiated as a result of a calibration failure or out-of-tolerance finding. Links the calibration event to the quality management corrective action workflow.',
    `certificate_issue_date` DATE COMMENT 'The date on which the calibration certificate was formally issued and signed. May differ from calibration_date if review and approval occur after the physical calibration activity.',
    `certificate_number` STRING COMMENT 'The official certificate number issued upon successful calibration, as printed on the calibration certificate. Used for document control, quality records management, and regulatory audit evidence.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this calibration record was first created in the system. Used for audit trail, data lineage, and compliance record retention tracking.',
    `environmental_humidity_pct` DECIMAL(18,2) COMMENT 'Relative humidity percentage recorded at the time and location of calibration. Required environmental condition documentation per ISO/IEC 17025 for humidity-sensitive instruments.',
    `environmental_temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature in degrees Celsius recorded at the time and location of calibration. Environmental conditions can affect measurement accuracy and are required to be documented per ISO/IEC 17025.',
    `external_lab_accreditation_number` DECIMAL(18,2) COMMENT 'Accreditation body certificate number for the external calibration laboratory (e.g., A2LA, NVLAP, UKAS accreditation number). Validates the laboratorys ISO/IEC 17025 accreditation status.',
    `external_lab_name` STRING COMMENT 'Name of the external calibration service provider or accredited laboratory, when calibration_lab is external_accredited or external_non_accredited. Used for supplier qualification and audit trail.',
    `instrument_tag` STRING COMMENT 'Plant or facility tag number assigned to the measurement instrument per ISA-5.1 instrumentation standards (e.g., TI-101, PT-205). Used for shop floor identification and P&ID cross-reference.',
    `instrument_type` STRING COMMENT 'Classification of the measurement instrument or device being calibrated. Drives applicable calibration procedures and tolerance standards. [ENUM-REF-CANDIDATE: gauge|sensor|transducer|transmitter|analyzer|controller|plc|cnc_probe|torque_wrench|caliper|micrometer|thermometer|pressure_meter|flow_meter — promote to reference product]',
    `measurement_parameter` STRING COMMENT 'The physical or process parameter being measured by the instrument (e.g., temperature, pressure, flow, voltage, torque, dimension, weight). Determines the applicable calibration standard and tolerance regime.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'The expanded measurement uncertainty (k=2, 95% confidence) associated with the calibration result, expressed in the same unit as measurement_unit. Required for ISO/IEC 17025 accredited calibration certificates.',
    `measurement_unit` STRING COMMENT 'The unit of measure applicable to as_found_reading, as_left_reading, reference_value, and tolerance fields (e.g., °C, bar, mA, mm, Nm, V, kg). Must conform to SI units per ISO 80000.',
    `out_of_service` BOOLEAN COMMENT 'Indicates whether the instrument has been placed out of service as a result of this calibration event (e.g., due to a fail or out-of-tolerance result). When True, the instrument must be quarantined and a CAPA initiated before return to service.',
    `prior_measurement_impact` STRING COMMENT 'Assessment of whether measurements taken by this instrument since its last calibration may have been affected by the out-of-tolerance condition found. Required for product conformity risk assessment when a calibration failure is detected.. Valid values are `no_impact|under_investigation|impact_confirmed|impact_ruled_out`',
    `reference_value` DECIMAL(18,2) COMMENT 'The true or nominal value against which the instrument reading is compared during calibration. Established by the reference standard and used to compute as-found and as-left errors.',
    `standard_certificate_number` STRING COMMENT 'Certificate number of the reference standard used during calibration, establishing the NIST/SI traceability chain. Required for ISO/IEC 17025 compliance documentation.',
    `technician_certification_number` STRING COMMENT 'The qualification or certification number of the technician who performed the calibration, as issued by an accredited body (e.g., ASQ, NIST, internal competency register). Required for ISO/IEC 17025 personnel traceability.',
    `technician_name` STRING COMMENT 'Full name of the qualified technician who performed and certified the calibration. Captured as a denormalized field on the calibration certificate for regulatory traceability even if the technician record changes.',
    `tolerance_lower_limit` DECIMAL(18,2) COMMENT 'The minimum acceptable deviation from the reference value for the instrument to be considered in calibration. Expressed in the same unit as measurement_unit. Falling below this limit results in a fail or out-of-tolerance status.',
    `tolerance_upper_limit` DECIMAL(18,2) COMMENT 'The maximum acceptable deviation from the reference value for the instrument to be considered in calibration. Expressed in the same unit as measurement_unit. Exceeding this limit results in a fail or out-of-tolerance status.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this calibration record was last modified. Supports audit trail requirements and change detection in the Databricks Silver Layer ingestion pipeline.',
    CONSTRAINT pk_calibration_record PRIMARY KEY(`calibration_record_id`)
) COMMENT 'Instrument and measurement equipment calibration record tracking calibration events for gauges, sensors, PLCs, and precision measurement tools. Captures calibration date, calibration standard used, as-found reading, as-left reading, tolerance limits, pass/fail result, calibration interval, next due date, and certifying technician. Supports ISO 9001 measurement system compliance and SPC instrument traceability.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` (
    `asset_warranty_id` BIGINT COMMENT 'Unique system-generated identifier for the asset warranty record. Primary key for the asset_warranty data product.',
    `equipment_register_id` BIGINT COMMENT 'Reference to the physical asset or equipment covered by this warranty record. Links to the asset master in Maximo Asset Management.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Warranty obligations are managed per project for capital assets.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the original purchase order under which the asset was procured, establishing the warranty entitlement basis.',
    `service_warranty_id` BIGINT COMMENT 'SSOT reference to the single source of truth record; this product is a non-authoritative duplicate view.',
    `supplier_id` BIGINT COMMENT 'Reference to the Original Equipment Manufacturer (OEM) or warranty service provider responsible for honoring warranty claims. Links to the vendor/supplier master.',
    `activation_date` DATE COMMENT 'The actual date the warranty was formally activated with the OEM or warranty provider. May differ from start_date if activation requires registration or commissioning sign-off.',
    `claim_contact_email` STRING COMMENT 'Email address of the OEM or warranty providers claim contact. Used for formal claim submission and correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `claim_contact_name` STRING COMMENT 'Name of the designated contact person at the OEM or warranty service provider for submitting and tracking warranty claims.',
    `claim_contact_phone` STRING COMMENT 'Phone number of the OEM or warranty providers claim contact. Used by maintenance teams to initiate warranty service requests.',
    `claim_response_sla_days` STRING COMMENT 'The contractually committed number of business days within which the OEM or warranty provider must respond to a submitted warranty claim. Supports SLA monitoring and vendor performance management.',
    `claim_submission_process` STRING COMMENT 'The prescribed method for submitting warranty claims to the OEM or warranty provider. Guides maintenance technicians and procurement teams on the correct claim channel. [ENUM-REF-CANDIDATE: online_portal|email|phone|field_service_dispatch|rma_process|written_notice — promote to reference product if additional channels are needed]. Valid values are `online_portal|email|phone|field_service_dispatch|rma_process`',
    `coverage_scope` STRING COMMENT 'Defines the service delivery model under the warranty. on_site means the OEM/vendor dispatches technicians to the facility; depot_repair means the asset is sent to a repair center; return_to_factory means the asset is returned to the manufacturer; remote_support means coverage is provided via remote diagnostics; parts_only means only replacement parts are shipped.. Valid values are `on_site|depot_repair|return_to_factory|remote_support|parts_only`',
    `covered_components` STRING COMMENT 'Free-text description of the specific components, assemblies, or subsystems covered under this warranty (e.g., Motor, gearbox, and control panel electronics). Supports claim eligibility assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the warranty record was first created in the system. Supports data lineage, audit trail, and compliance with ISO 9001 record-keeping requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary values in this warranty record (e.g., USD, EUR, GBP). Ensures consistent financial reporting across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `document_reference` STRING COMMENT 'Reference number or path to the warranty certificate, contract document, or terms and conditions stored in the document management system (e.g., Siemens Teamcenter PLM document ID or file path).',
    `duration_months` DECIMAL(18,2) COMMENT 'Total duration of the warranty coverage expressed in months. Used for warranty planning, asset lifecycle analysis, and CapEx budgeting for post-warranty maintenance.',
    `excluded_components` STRING COMMENT 'Free-text description of components, failure modes, or conditions explicitly excluded from warranty coverage (e.g., Wear parts, consumables, damage from improper use). Critical for claim rejection analysis.',
    `expiration_date` TIMESTAMP COMMENT 'The date on which the warranty coverage ends. After this date, maintenance and repair costs are borne by the asset owner. Critical for triggering paid work orders and evaluating RMA eligibility.',
    `expiry_alert_days` STRING COMMENT 'Number of days before the warranty expiration date that an alert should be triggered to notify asset managers and procurement teams. Enables proactive extended warranty procurement or maintenance budget planning.',
    `extended_warranty_option_flag` BOOLEAN COMMENT 'Indicates whether the OEM or vendor offers an extended warranty option for this asset upon expiration of the current warranty. True = extension is available; False = no extension offered.',
    `labor_coverage_flag` BOOLEAN COMMENT 'Indicates whether labor costs for warranty repairs are covered under this warranty. True = labor is covered; False = labor costs are borne by the asset owner.',
    `last_claim_date` DATE COMMENT 'The date of the most recent warranty claim submitted under this warranty record. Supports warranty activity monitoring and vendor SLA tracking.',
    `maintenance_provider_restriction` STRING COMMENT 'Specifies restrictions on who may perform maintenance without voiding the warranty. oem_only = only OEM technicians; certified_partner = OEM-certified service partners; any_provider = no restriction; internal_allowed = internal maintenance team is permitted.. Valid values are `oem_only|certified_partner|any_provider|internal_allowed`',
    `maintenance_required_flag` BOOLEAN COMMENT 'Indicates whether the warranty requires adherence to a prescribed maintenance schedule to remain valid. True = warranty is voided if maintenance intervals are not followed per OEM specifications.',
    `max_claim_value` DECIMAL(18,2) COMMENT 'The maximum monetary value of claims that can be submitted under this warranty over its lifetime. Caps the total financial exposure covered by the OEM or warranty provider.',
    `notes` STRING COMMENT 'Free-text field for additional warranty terms, special conditions, exceptions, or operational notes not captured in structured fields (e.g., Warranty void if coolant is not replaced every 6 months).',
    `oem_vendor_name` STRING COMMENT 'Name of the Original Equipment Manufacturer (OEM) or third-party warranty service provider. Retained as a denormalized reference for reporting and claim correspondence without requiring a vendor master join.',
    `oem_warranty_reference` STRING COMMENT 'The OEMs internal warranty registration or reference number used when submitting claims directly to the manufacturers warranty portal or service desk.',
    `parts_coverage_flag` BOOLEAN COMMENT 'Indicates whether replacement parts costs are covered under this warranty. True = parts are covered; False = parts costs are borne by the asset owner.',
    `preventive_maintenance_covered_flag` BOOLEAN COMMENT 'Indicates whether scheduled preventive maintenance activities are covered under the warranty terms. True = PM is covered; False = PM costs are excluded. Relevant for Total Productive Maintenance (TPM) planning.',
    `remaining_warranty_value` DECIMAL(18,2) COMMENT 'The residual monetary value available for future warranty claims, calculated as max_claim_value minus the total value of claims already submitted and approved. Supports CapEx and OpEx planning.',
    `rma_eligible_flag` BOOLEAN COMMENT 'Indicates whether failed components under this warranty are eligible for Return Material Authorization (RMA) processing. True = RMA can be initiated; False = RMA not applicable under this warranty.',
    `source_system_code` STRING COMMENT 'The native identifier of this warranty record in the originating operational system (e.g., Maximo warranty record ID). Enables traceability back to the system of record for reconciliation and lineage.',
    `start_date` TIMESTAMP COMMENT 'The date on which the warranty coverage becomes effective. Typically aligned with the asset commissioning date, installation date, or purchase date as defined in the warranty terms.',
    `total_claimed_amount` DECIMAL(18,2) COMMENT 'The cumulative monetary value of all warranty claims submitted against this warranty record. Used to track warranty utilization and compare against max_claim_value.',
    `total_claims_count` DECIMAL(18,2) COMMENT 'The total number of warranty claims submitted against this warranty record to date. Supports vendor performance analysis and warranty utilization tracking.',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether the warranty can be transferred to a new asset owner in the event of asset sale or reassignment. True = warranty is transferable; False = warranty is non-transferable.',
    `travel_coverage_flag` BOOLEAN COMMENT 'Indicates whether travel and transportation costs for on-site warranty service are covered. True = travel is covered; False = travel costs are borne by the asset owner.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the warranty record was most recently modified. Supports change tracking, audit compliance, and data freshness monitoring in the Databricks Silver Layer.',
    `usage_based_flag` BOOLEAN COMMENT 'Indicates whether the warranty terms are based on asset usage metrics (e.g., operating hours, cycles, mileage) in addition to or instead of calendar time. True = usage-based terms apply.',
    `usage_limit_unit` STRING COMMENT 'Unit of measure for the usage-based warranty limit (e.g., hours for operating hours, cycles for production cycles). Applicable only when usage_based_flag is True.. Valid values are `hours|cycles|kilometers|strokes|starts`',
    `usage_limit_value` DECIMAL(18,2) COMMENT 'The maximum usage quantity (e.g., operating hours, production cycles, kilometers) allowed under the warranty before coverage expires. Applicable only when usage_based_flag is True.',
    `warranty_name` STRING COMMENT 'Descriptive name or title of the warranty agreement (e.g., Standard OEM 2-Year Parts and Labor Warranty, Extended Full Coverage Plan).',
    `warranty_number` STRING COMMENT 'Externally-known warranty certificate or contract number issued by the OEM or warranty provider. Used for claim submission and correspondence with the vendor.',
    `warranty_status` STRING COMMENT 'Current lifecycle state of the warranty record. active indicates coverage is in force; expired indicates the warranty period has ended; pending indicates awaiting activation; voided indicates warranty was invalidated (e.g., unauthorized modification); suspended indicates temporarily on hold.. Valid values are `active|expired|pending|voided|suspended`',
    `warranty_type` STRING COMMENT 'Classification of the warranty coverage scope. parts_only covers replacement components only; labor_only covers service labor only; full_coverage covers both parts and labor; extended is a purchased extension beyond OEM terms; limited covers specific components or failure modes; manufacturer is the standard OEM warranty.. Valid values are `parts_only|labor_only|full_coverage|extended|limited|manufacturer`',
    CONSTRAINT pk_asset_warranty PRIMARY KEY(`asset_warranty_id`)
) COMMENT 'Equipment warranty coverage record tracking OEM and extended warranty terms for purchased assets, including warranty type (parts, labor, full coverage), warranty start date, warranty expiration date, OEM vendor reference, covered components, claim submission process, and remaining warranty value. Enables warranty claim identification before issuing paid work orders and supports RMA processing for failed components under warranty.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` (
    `asset_certification_id` BIGINT COMMENT 'Unique system-generated identifier for each asset certification record. Primary key for the asset_certification data product.',
    `asset_work_order_id` BIGINT COMMENT 'Reference to the Maximo work order associated with the certification inspection, renewal activity, or corrective action. Links certification events to maintenance execution records.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: COMPLIANCE: Certification activities incur costs that must be charged to the responsible cost center.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee or asset manager responsible for managing the certification lifecycle, including renewal coordination and regulatory compliance. Links to Workday HCM workforce record.',
    `equipment_register_id` BIGINT COMMENT 'Reference to the physical equipment or asset for which this certification applies. Links to the asset master record in Maximo Asset Management.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Certifications are required for assets within specific projects to meet compliance.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: CERTIFICATION MANAGEMENT: each asset certification must be tied to the specific regulatory requirement it fulfills for audit and compliance reporting.',
    `product_certification_id` BIGINT COMMENT 'Foreign key linking to product.product_certification. Business justification: Asset certifications derive from product certifications; linking supports regulatory compliance dashboards and audit trails.',
    `atex_certificate_number` STRING COMMENT 'Specific ATEX (Atmosphères Explosibles) certificate number issued by a notified body for explosion-proof equipment. Null for non-ATEX assets. Required for operation in hazardous areas under EU Directive 2014/34/EU.',
    `ce_marking_flag` BOOLEAN COMMENT 'Indicates whether the asset bears CE marking, confirming conformity with applicable European Union health, safety, and environmental protection standards. True = CE marked; False = not CE marked.',
    `certificate_number` STRING COMMENT 'Externally-issued unique certificate number assigned by the certifying authority. Used for regulatory traceability and audit purposes (e.g., UL certificate number, CE declaration reference, ATEX certificate number).',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Drives compliance dashboards, renewal workflows, and legal operation eligibility checks. active = valid and in force; expired = past expiry date; suspended = temporarily withdrawn by authority; revoked = permanently cancelled; pending_renewal = renewal in progress.. Valid values are `active|expired|suspended|revoked|pending_renewal`',
    `certification_type` STRING COMMENT 'Category of regulatory or safety certification applicable to the asset. Classifies the certification domain for compliance tracking and reporting. [ENUM-REF-CANDIDATE: pressure_vessel|electrical_safety|crane_lifting|explosion_proof|fire_safety|environmental|machinery_safety|electromagnetic_compatibility|energy_efficiency|occupational_safety — promote to reference product]. Valid values are `pressure_vessel|electrical_safety|crane_lifting|explosion_proof|fire_safety|environmental`',
    `cost` DECIMAL(18,2) COMMENT 'Total cost incurred for obtaining or renewing this certification, including inspection fees, testing fees, and notified body charges. Expressed in the local currency. Supports CapEx asset register and OpEx maintenance cost analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the certification_cost amount (e.g., USD, EUR, GBP). Required for multi-currency financial reporting.. Valid values are `^[A-Z]{3}$`',
    `days_to_expiry` STRING COMMENT 'Number of calendar days remaining until the certification expires, calculated from the current date to expiry_date. Negative values indicate the certification is already expired. Used for compliance dashboards and renewal prioritization. Note: This is a pre-computed convenience field stored at ingestion time for reporting performance; the authoritative calculation is expiry_date minus current date.',
    `document_reference` STRING COMMENT 'Reference number or path to the scanned certificate document stored in the document management system (e.g., Siemens Teamcenter PLM document ID or SAP DMS reference). Enables direct retrieval of the physical certificate for audit purposes.',
    `document_storage_url` STRING COMMENT 'URL or file path to the digital copy of the certificate document stored in the enterprise document management or lakehouse storage layer. Supports paperless audit and compliance review.',
    `equipment_category` STRING COMMENT 'ATEX equipment category indicating the level of protection required (Category 1 = very high protection for Zone 0/20; Category 2 = high protection for Zone 1/21; Category 3 = normal protection for Zone 2/22). Null for non-ATEX certifications.. Valid values are `Category 1|Category 2|Category 3`',
    `expiry_date` TIMESTAMP COMMENT 'The date on which the certification expires and the asset is no longer legally authorized to operate under this certification. Null indicates an open-ended or lifetime certification. Drives automated renewal alerts and compliance reporting.',
    `hazardous_zone_classification` STRING COMMENT 'ATEX/IECEx hazardous area zone classification applicable to the certified equipment (e.g., Zone 1 for gas/vapour explosive atmospheres, Zone 21 for dust explosive atmospheres). Null for non-ATEX certifications.. Valid values are `Zone 0|Zone 1|Zone 2|Zone 20|Zone 21|Zone 22`',
    `inspection_date` DATE COMMENT 'The date on which the physical inspection, audit, or test was conducted by the certifying authority or inspector as part of the certification or renewal process.',
    `inspector_license_number` STRING COMMENT 'Official license or accreditation number of the inspector or inspection body, confirming their authority to issue or validate the certification. Required for regulatory audit trails.',
    `inspector_name` STRING COMMENT 'Full name of the qualified inspector or auditor who conducted the certification inspection on behalf of the issuing authority or notified body.',
    `issue_date` TIMESTAMP COMMENT 'The date on which the certification was formally issued or granted by the issuing authority. Represents the start of the certifications validity period.',
    `issuing_authority` BOOLEAN COMMENT 'Name of the regulatory body, notified body, or certification organization that issued the certificate (e.g., Underwriters Laboratories (UL), TÜV Rheinland, Bureau Veritas, Lloyds Register, OSHA, CE Notified Body NB 0044). Critical for audit and regulatory reporting.',
    `issuing_authority_country` BOOLEAN COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction in which the issuing authority operates (e.g., USA, DEU, GBR). Supports multi-jurisdictional compliance management.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was most recently modified. Supports change tracking, audit trail, and Silver layer incremental processing in the Databricks Lakehouse.',
    `location_code` STRING COMMENT 'Functional location or area code within the plant where the certified asset is installed (e.g., PLANT-A/LINE-3/PRESS-01). Aligns with Maximo functional location hierarchy for maintenance and compliance management.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this certification is legally mandatory for the asset to operate (True) or is a voluntary/optional certification (False). Mandatory certifications trigger compliance holds if expired.',
    `next_inspection_date` TIMESTAMP COMMENT 'Scheduled date for the next mandatory inspection or re-certification audit. Used for preventive maintenance scheduling and compliance calendar management in Maximo.',
    `nonconformance_reference` STRING COMMENT 'Reference number of any Non-Conformance Report (NCR) or Corrective and Preventive Action (CAPA) raised in connection with a failed or conditional certification inspection. Links to the quality management system for corrective action tracking.',
    `operation_hold_flag` BOOLEAN COMMENT 'Indicates whether the asset has been placed on an operational hold due to an expired, suspended, or revoked certification. True = asset must not be operated; False = no hold in effect. Integrates with MES shop floor control to prevent unauthorized use.',
    `pressure_rating_psi` DECIMAL(18,2) COMMENT 'Maximum allowable working pressure in pounds per square inch (PSI) as certified for pressure vessel or piping equipment. Null for non-pressure-rated assets. Critical for ASME and regulatory compliance.',
    `previous_certificate_number` STRING COMMENT 'Certificate number of the immediately preceding certification record that this record renews or supersedes. Enables certification history chain traceability for audit and regulatory review.',
    `rated_load_kg` DECIMAL(18,2) COMMENT 'Maximum safe working load in kilograms as certified for crane, hoist, or lifting equipment. Null for non-lifting assets. Required for OSHA and ASME B30 compliance.',
    `regulatory_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the regulatory jurisdiction under which this certification is required and enforced (e.g., USA for OSHA, DEU for ATEX/CE). Supports multi-country compliance management.. Valid values are `^[A-Z]{3}$`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, conditions, limitations, or observations recorded by the inspector or asset manager regarding the certification (e.g., conditional approval notes, deferred items, special operating restrictions).',
    `renewal_action_status` STRING COMMENT 'Current status of the renewal action for this certification. Tracks whether renewal activities have been initiated, are in progress, or completed. not_required = no renewal needed (lifetime cert); scheduled = renewal inspection/audit booked; in_progress = renewal process underway; completed = renewed successfully; overdue = renewal deadline passed without completion.. Valid values are `not_required|scheduled|in_progress|completed|overdue`',
    `renewal_due_date` DATE COMMENT 'The target date by which the renewal process must be completed to avoid a lapse in certification. May differ from expiry_date when lead time for inspection or re-certification is required. Used to trigger preventive renewal workflows in Maximo.',
    `scope_description` STRING COMMENT 'Detailed description of the scope of the certification, including specific components, operating conditions, pressure ratings, voltage ratings, or hazardous zone classifications covered by the certificate (e.g., Zone 1 ATEX Group IIB T4, Max operating pressure 150 PSI, Rated load 10 tonnes).',
    `standard` STRING COMMENT 'The specific regulatory standard, directive, or code under which the certification was issued (e.g., ISO 9001:2015, IEC 62443-2-1, ASME Section VIII, EN 13463, OSHA 1910.179, UL 508A). Enables precise compliance mapping.',
    `ul_listed_flag` BOOLEAN COMMENT 'Indicates whether the asset is UL Listed, meaning it has been tested and certified by Underwriters Laboratories for safety compliance. True = UL Listed; False = not UL Listed.',
    `voltage_rating_v` DECIMAL(18,2) COMMENT 'Maximum rated voltage in volts as certified for electrical equipment. Null for non-electrical certifications. Supports UL, CE, and IEC electrical safety compliance tracking.',
    CONSTRAINT pk_asset_certification PRIMARY KEY(`asset_certification_id`)
) COMMENT 'Regulatory and safety certification record for equipment assets, tracking certifications required for legal operation including pressure vessel certification, electrical safety certification (UL, CE), crane and lifting equipment certification, and explosion-proof (ATEX) certification. Stores certification type, issuing authority, issue date, expiry date, certificate number, and renewal action status.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` (
    `equipment_allocation_id` BIGINT COMMENT 'Primary key for the equipment_allocation association',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to the equipment register master record',
    `line_id` BIGINT COMMENT 'Foreign key linking to the sales order line',
    `allocated_by` STRING COMMENT '',
    `allocated_by_name` STRING COMMENT '',
    `allocated_by_user` STRING COMMENT 'allocated by user',
    `allocated_cost` DECIMAL(18,2) COMMENT '',
    `allocated_from_timestamp` TIMESTAMP COMMENT 'allocated from timestamp',
    `allocated_percentage` DECIMAL(18,2) COMMENT '',
    `allocated_quantity` DECIMAL(18,2) COMMENT '',
    `allocated_to` STRING COMMENT '',
    `allocated_to_name` STRING COMMENT '',
    `allocated_to_timestamp` TIMESTAMP COMMENT 'allocated to timestamp',
    `allocation_end_date` TIMESTAMP COMMENT 'Date when the equipment allocation ends for the order line',
    `allocation_notes` STRING COMMENT '',
    `allocation_number` STRING COMMENT '',
    `allocation_percentage` DECIMAL(18,2) COMMENT '',
    `allocation_purpose` STRING COMMENT '',
    `allocation_reason` STRING COMMENT '',
    `allocation_start_date` TIMESTAMP COMMENT 'Date when the equipment allocation begins for the order line',
    `allocation_status` STRING COMMENT '',
    `allocation_type` STRING COMMENT '',
    `cost_rate_amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `quantity` DECIMAL(18,2) COMMENT 'Business data attribute for equipment_allocation.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `usage_hours` DECIMAL(18,2) COMMENT 'Total hours the equipment was used to fulfill the order line',
    `utilization_percent` DECIMAL(18,2) COMMENT '',
    `utilization_rate_percent` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_equipment_allocation PRIMARY KEY(`equipment_allocation_id`)
) COMMENT 'This association captures the allocation of a specific equipment asset to a sales order line, including the period of allocation and the amount of equipment usage. Each record links one equipment_register to one order_line and stores attributes that belong only to the allocation relationship.. Existence Justification: Equipment from the asset register is allocated to sales order lines for production capacity planning and cost allocation. An equipment item can be allocated to many order lines over its lifecycle, and a single order line can require multiple pieces of equipment. The allocation is managed as an operational record with start/end dates and usage hours.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`equipment_shipment` (
    `equipment_shipment_id` BIGINT COMMENT 'Primary key for the equipment_shipment association',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to equipment_register',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to shipment',
    `actual_arrival_date` TIMESTAMP COMMENT '',
    `actual_delivery_date` DATE COMMENT '',
    `condition_at_shipment` TIMESTAMP COMMENT '',
    `condition_on_dispatch` STRING COMMENT '',
    `condition_on_receipt` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `destination_location` STRING COMMENT '',
    `expected_arrival_date` TIMESTAMP COMMENT 'Business data attribute for equipment_shipment.',
    `expected_arrival_timestamp` TIMESTAMP COMMENT 'expected arrival timestamp',
    `expected_delivery_date` DATE COMMENT '',
    `insured_flag` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `load_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment was loaded onto the shipment',
    `notes` STRING COMMENT 'Free-form text field capturing additional remarks, special handling instructions, or contextual information related to the equipment shipment record.',
    `origin_location` STRING COMMENT '',
    `quantity` DECIMAL(18,2) COMMENT 'Business data attribute for equipment_shipment.',
    `quantity_shipped` DECIMAL(18,2) COMMENT '',
    `ship_date` TIMESTAMP COMMENT '',
    `shipment_cost` DECIMAL(18,2) COMMENT '',
    `shipment_date` DATE COMMENT '',
    `shipment_notes` STRING COMMENT '',
    `shipment_quantity` STRING COMMENT '',
    `shipment_status` STRING COMMENT '',
    `shipment_type` STRING COMMENT '',
    `shipment_value_amount` DECIMAL(18,2) COMMENT '',
    `shipped_date` TIMESTAMP COMMENT '',
    `shipped_quantity` DECIMAL(18,2) COMMENT '',
    `shipped_timestamp` TIMESTAMP COMMENT 'shipped timestamp',
    `tracking_number` STRING COMMENT '',
    `tracking_reference` STRING COMMENT 'Business data attribute for equipment_shipment.',
    `unload_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment was unloaded from the shipment',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_equipment_shipment PRIMARY KEY(`equipment_shipment_id`)
) COMMENT 'Represents the assignment of a specific equipment item to a specific shipment, capturing the load and unload timestamps for that pairing. Each record links one equipment_register to one shipment.. Existence Justification: Each piece of equipment can be loaded onto multiple shipments over its lifecycle, and each shipment can contain many equipment items. The loading/unloading timestamps are captured for every equipment‑shipment pairing, and the pairing is actively created, updated, and deleted by logistics operators.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`compliance_assessment` (
    `compliance_assessment_id` BIGINT COMMENT 'Primary key for the compliance_assessment association',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to the equipment register',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to the regulatory requirement',
    `assessment_date` TIMESTAMP COMMENT 'Date on which the compliance assessment was performed',
    `assessment_number` STRING COMMENT '',
    `assessment_result` STRING COMMENT '',
    `assessment_score` DECIMAL(18,2) COMMENT '',
    `assessment_status` STRING COMMENT '',
    `assessment_type` STRING COMMENT '',
    `assessor` STRING COMMENT 'Business data attribute for compliance_assessment.',
    `assessor_name` STRING COMMENT '',
    `compliance_result` STRING COMMENT '',
    `compliance_score` DECIMAL(18,2) COMMENT '',
    `compliance_status` STRING COMMENT 'Current compliance state of the equipment for this requirement (e.g., Compliant, Non‑Compliant, Pending)',
    `corrective_action_required` BOOLEAN COMMENT '',
    `corrective_action_required_flag` BOOLEAN COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `finding_count` STRING COMMENT '',
    `finding_summary` STRING COMMENT '',
    `findings_summary` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `next_assessment_date` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `remediation_required_flag` BOOLEAN COMMENT '',
    `risk_level` STRING COMMENT '',
    `score` DECIMAL(18,2) COMMENT 'Business data attribute for compliance_assessment.',
    `score_value` DECIMAL(18,2) COMMENT 'score value',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_compliance_assessment PRIMARY KEY(`compliance_assessment_id`)
) COMMENT 'Represents the assessment of a specific equipment register against a specific regulatory requirement. Each record captures the compliance status and the date the assessment was performed, enabling traceability of compliance over time.. Existence Justification: Each piece of equipment must satisfy multiple regulatory requirements, and each regulatory requirement applies to many pieces of equipment. Compliance officers record the status and assessment date for every equipment‑requirement pair, creating a distinct record that is managed, updated, and audited as a business object.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` (
    `regulatory_applicability_id` BIGINT COMMENT 'Primary key for the regulatory_applicability association',
    `equipment_register_id` BIGINT COMMENT '',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to the regulatory requirement',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to the spare part',
    `applicability_flag` BOOLEAN COMMENT '',
    `applicability_notes` STRING COMMENT '',
    `applicability_rationale` DECIMAL(18,2) COMMENT '',
    `applicability_reason` STRING COMMENT '',
    `applicability_status` STRING COMMENT '',
    `applicable_from_date` TIMESTAMP COMMENT '',
    `applicable_until_date` TIMESTAMP COMMENT '',
    `assessed_by` STRING COMMENT '',
    `compliance_deadline_date` TIMESTAMP COMMENT '',
    `compliance_status` STRING COMMENT 'Current compliance status of the spare part for this requirement (e.g., Compliant, Non‑Compliant)',
    `created_timestamp` TIMESTAMP COMMENT '',
    `determination_basis` STRING COMMENT 'Business data attribute for regulatory_applicability.',
    `determination_notes` STRING COMMENT '',
    `determined_by_name` STRING COMMENT '',
    `determined_by_user` STRING COMMENT 'determined by user',
    `effective_date` DATE COMMENT 'Date the regulatory requirement became effective for this spare part',
    `exemption_reason` STRING COMMENT '',
    `expiry_date` DATE COMMENT '',
    `is_mandatory` BOOLEAN COMMENT '',
    `is_mandatory_flag` BOOLEAN COMMENT '',
    `jurisdiction` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `regulation_code` STRING COMMENT '',
    `regulation_name` STRING COMMENT '',
    `regulation_reference` STRING COMMENT '',
    `review_date` TIMESTAMP COMMENT '',
    `review_frequency` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_regulatory_applicability PRIMARY KEY(`regulatory_applicability_id`)
) COMMENT 'Represents the mapping between a spare part and a regulatory requirement. Each record captures the compliance status of the part with respect to the requirement and the date the requirement became effective for that part.. Existence Justification: A spare part may need to comply with multiple regulatory requirements, and a single regulatory requirement can apply to many spare parts. The compliance team actively creates, updates, and removes these mappings as regulations change, and each mapping carries its own compliance status and effective date.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` (
    `asset_plant_id` BIGINT COMMENT 'Primary key for plant',
    `company_code_id` BIGINT COMMENT '',
    `parent_plant_id` BIGINT COMMENT 'Self-referencing FK on plant (parent_plant_id)',
    `production_plant_id` BIGINT COMMENT 'SSOT reference to authoritative source of truth record.',
    `address_line1` STRING COMMENT 'First line of the plants street address.',
    `address_line2` STRING COMMENT 'Second line of the plants street address (optional).',
    `area_sq_m` DECIMAL(18,2) COMMENT 'Total built‑up area of the plant in square meters.',
    `capacity_units_per_year` DECIMAL(18,2) COMMENT 'Maximum number of production units the plant can output in a year.',
    `city` STRING COMMENT 'City where the plant is located.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Internal cost‑center identifier associated with the plant.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the plant resides.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `asset_plant_description` STRING COMMENT 'Free‑form textual description of the plants purpose, capabilities, and notable characteristics.',
    `email_address` STRING COMMENT 'Primary email address for plant communications.',
    `emissions_co2_tons` DECIMAL(18,2) COMMENT 'Total carbon dioxide emissions generated by the plant per year.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total electricity consumption of the plant per year in megawatt‑hours.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the plant (decimal degrees).',
    `lifecycle_status` STRING COMMENT 'Current operational state of the plant.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the plant (decimal degrees).',
    `maintenance_contract_status` STRING COMMENT 'Current status of any external maintenance contracts.',
    `maintenance_strategy` DECIMAL(18,2) COMMENT 'Approach used for maintaining plant equipment.',
    `manager_name` STRING COMMENT 'Name of the person responsible for plant operations.',
    `asset_plant_name` STRING COMMENT 'Human‑readable name of the plant.',
    `number_of_employees` STRING COMMENT 'Total headcount employed at the plant.',
    `operational_end_date` DATE COMMENT 'Date when the plant ceased operations (null if still active).',
    `operational_start_date` DATE COMMENT 'Date when the plant began commercial operations.',
    `phone_number` STRING COMMENT 'Primary telephone number for plant communications.',
    `plant_status` STRING COMMENT '',
    `plant_type` STRING COMMENT 'Category describing the primary function of the plant.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the plant address.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the plant record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plant record.',
    `safety_incident_count` STRING COMMENT 'Number of recorded safety incidents at the plant in the most recent year.',
    `state_province` STRING COMMENT 'State or province of the plant location.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the plant (e.g., America/Chicago).',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `website_url` STRING COMMENT 'Public website URL for the plant (if any).',
    CONSTRAINT pk_asset_plant PRIMARY KEY(`asset_plant_id`)
) COMMENT 'Master reference table for plant. Referenced by plant_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` (
    `calibration_standard_id` BIGINT COMMENT 'Primary key for calibration_standard',
    `reference_standard_calibration_standard_id` BIGINT COMMENT 'Self-referencing FK on calibration_standard (reference_calibration_standard_id)',
    `accuracy_unit` STRING COMMENT 'Unit associated with the accuracy value.',
    `accuracy_value` DECIMAL(18,2) COMMENT 'Numeric accuracy of the calibration standard.',
    `applicable_equipment_category` STRING COMMENT 'Equipment category for which the calibration standard is valid.',
    `calibration_certificate_number` DECIMAL(18,2) COMMENT 'Certificate number issued after calibration.',
    `calibration_interval_days` DECIMAL(18,2) COMMENT 'Recommended number of days between successive calibrations.',
    `calibration_location` DECIMAL(18,2) COMMENT 'Physical location where the calibration was performed.',
    `calibration_method` DECIMAL(18,2) COMMENT 'Method used to perform the calibration.',
    `calibration_provider` DECIMAL(18,2) COMMENT 'Organization or vendor that performed the calibration.',
    `calibration_standard_code` STRING COMMENT 'Business identifier or code assigned to the calibration standard.',
    `compliance_category` STRING COMMENT 'Regulatory compliance classification of the standard.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration standard record was created.',
    `calibration_standard_description` STRING COMMENT 'Detailed description of the calibration standard and its purpose.',
    `effective_from` DATE COMMENT 'Date from which the standard is considered effective.',
    `effective_until` DATE COMMENT 'Date until which the standard remains effective (null if open‑ended).',
    `is_traceable` BOOLEAN COMMENT 'Indicates whether the standard is traceable to a national or international reference.',
    `last_calibrated_date` DATE COMMENT 'Date when the standard was last calibrated.',
    `last_calibration_date` TIMESTAMP COMMENT '',
    `manufacturer` STRING COMMENT 'Organization that manufactures or issues the calibration standard.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT '',
    `measurement_unit` STRING COMMENT 'Unit of measurement used by the standard (e.g., °C, Pa, mm, V).',
    `model` STRING COMMENT 'Model identifier of the calibration standard, if applicable.',
    `calibration_standard_name` STRING COMMENT 'Human‑readable name of the calibration standard.',
    `next_calibration_due_date` TIMESTAMP COMMENT '',
    `next_due_date` DATE COMMENT 'Scheduled date for the next calibration.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the calibration standard.',
    `required_certification` STRING COMMENT 'Certification(s) required to use or maintain the standard.',
    `standard_body` STRING COMMENT 'Governing body or organization that defines the standard (e.g., ISO, IEC, NIST).',
    `standard_document_number` STRING COMMENT 'Reference number of the official standard document.',
    `standard_name` STRING COMMENT '',
    `standard_number` STRING COMMENT '',
    `standard_status` STRING COMMENT '',
    `standard_type` STRING COMMENT '',
    `calibration_standard_status` STRING COMMENT 'Current lifecycle status of the calibration standard.',
    `tolerance_unit` STRING COMMENT 'Unit associated with the tolerance value.',
    `tolerance_value` DECIMAL(18,2) COMMENT 'Numeric tolerance allowed for the measurement.',
    `traceability_reference` STRING COMMENT '',
    `calibration_standard_type` STRING COMMENT 'Category of measurement the standard applies to.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `version` STRING COMMENT 'Version identifier of the calibration standard.',
    CONSTRAINT pk_calibration_standard PRIMARY KEY(`calibration_standard_id`)
) COMMENT 'Master reference table for calibration_standard. Referenced by calibration_standard_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` (
    `lubrication_route_id` BIGINT COMMENT 'Primary key for lubrication_route',
    `parent_lubrication_route_id` BIGINT COMMENT 'Self-referencing FK on lubrication_route (parent_lubrication_route_id)',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated monetary cost per full execution of the route (lubricant + labor).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the route record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code for the cost estimate currency.',
    `lubrication_route_description` STRING COMMENT 'Free‑form text describing the purpose, scope, and special considerations of the route.',
    `end_date` DATE COMMENT 'Date when the lubrication route is retired or superseded; null if open‑ended.',
    `environmental_compliance` BOOLEAN COMMENT 'True if the route complies with environmental regulations for lubricant disposal and emissions.',
    `equipment_category` STRING COMMENT 'Type of equipment or asset that the lubrication route serves.',
    `estimated_duration_minutes` DECIMAL(18,2) COMMENT '',
    `frequency_unit` STRING COMMENT 'Time unit for the frequency value.',
    `frequency_value` DECIMAL(18,2) COMMENT 'Number of lubrication events that should occur within the defined frequency unit.',
    `interval_unit` STRING COMMENT 'Time unit for the interval value.',
    `interval_value` DECIMAL(18,2) COMMENT 'Numeric interval between successive lubrication events.',
    `last_lubrication_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent lubrication event recorded for this route.',
    `lubricant_type` STRING COMMENT 'Primary type of lubricant used on the route.',
    `lubrication_method` STRING COMMENT 'How lubricant is applied to the route (e.g., manual, automatic, robotic).',
    `next_scheduled_timestamp` TIMESTAMP COMMENT 'Planned timestamp for the next lubrication activity based on frequency/interval.',
    `notes` STRING COMMENT 'Additional remarks, engineering comments, or change‑log entries.',
    `point_count` STRING COMMENT '',
    `responsible_department` STRING COMMENT 'Organizational department accountable for maintaining the route.',
    `responsible_role` STRING COMMENT 'Job role or title (e.g., Maintenance Engineer) tasked with executing the route.',
    `route_code` STRING COMMENT 'Unique alphanumeric code assigned to the route for reference in Maximo and other CMMS systems.',
    `route_name` STRING COMMENT 'Human‑readable name of the lubrication route used in work orders and maintenance plans.',
    `route_number` STRING COMMENT '',
    `route_status` STRING COMMENT '',
    `route_type` STRING COMMENT 'Category describing the method of lubricant delivery along the route.',
    `safety_critical` BOOLEAN COMMENT 'Indicates whether the route is safety‑critical and requires special handling.',
    `start_date` DATE COMMENT 'Date when the lubrication route becomes active.',
    `lubrication_route_status` STRING COMMENT 'Current lifecycle state of the route.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the route record.',
    CONSTRAINT pk_lubrication_route PRIMARY KEY(`lubrication_route_id`)
) COMMENT 'Master reference table for lubrication_route. Referenced by lubrication_route_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` (
    `inspection_checklist_id` BIGINT COMMENT 'Primary key for inspection_checklist',
    `parent_inspection_checklist_id` BIGINT COMMENT 'Self-referencing FK on inspection_checklist (parent_inspection_checklist_id)',
    `applicable_asset_type` STRING COMMENT 'Asset type code to which the checklist applies (e.g., CNC, PLC, robot).',
    `approval_status` STRING COMMENT 'Current approval state of the checklist.',
    `author` STRING COMMENT 'Name or identifier of the person who authored the checklist.',
    `checklist_name` STRING COMMENT '',
    `checklist_number` STRING COMMENT '',
    `checklist_status` STRING COMMENT '',
    `checklist_type` STRING COMMENT '',
    `inspection_checklist_code` STRING COMMENT 'Business identifier or code used to reference the checklist in work orders and reports.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard that the checklist supports (e.g., ISO 45001).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the checklist record was first created.',
    `inspection_checklist_description` STRING COMMENT 'Detailed description of the checklist purpose and scope.',
    `document_url` STRING COMMENT 'Link to the digital document or PDF of the checklist.',
    `effective_date` TIMESTAMP COMMENT '',
    `effective_from` DATE COMMENT 'Date from which the checklist becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the checklist is no longer valid (nullable for open‑ended).',
    `estimated_duration_minutes` DECIMAL(18,2) COMMENT 'Typical time required to complete the checklist.',
    `frequency` STRING COMMENT 'Recommended execution frequency for the checklist.',
    `inspection_area` STRING COMMENT 'Physical area or system component covered by the checklist.',
    `item_count` STRING COMMENT '',
    `last_review_date` DATE COMMENT 'Date when the checklist was last reviewed for relevance.',
    `inspection_checklist_name` STRING COMMENT 'Human‑readable name of the inspection checklist.',
    `next_review_date` DATE COMMENT 'Planned date for the next review of the checklist.',
    `number_of_items` STRING COMMENT 'Total count of individual inspection items in the checklist.',
    `required` BOOLEAN COMMENT 'Indicates whether the checklist is mandatory for the associated asset or process.',
    `revision_history` STRING COMMENT 'Free‑text log of changes made to the checklist over time.',
    `revision_number` STRING COMMENT '',
    `risk_level` STRING COMMENT 'Risk classification associated with the checklist.',
    `safety_critical` BOOLEAN COMMENT 'True if the checklist addresses safety‑critical controls.',
    `inspection_checklist_status` STRING COMMENT 'Current lifecycle status of the checklist.',
    `inspection_checklist_type` STRING COMMENT 'Category of the checklist indicating its primary focus area.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the checklist record.',
    `version` STRING COMMENT 'Version label of the checklist (e.g., v1.0, v2.3).',
    CONSTRAINT pk_inspection_checklist PRIMARY KEY(`inspection_checklist_id`)
) COMMENT 'Master reference table for inspection_checklist. Referenced by checklist_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` (
    `work_order_type_id` BIGINT COMMENT 'Primary key for work_order_type',
    `parent_work_order_type_id` BIGINT COMMENT 'Self-referencing FK on work_order_type (parent_work_order_type_id)',
    `work_order_type_category` STRING COMMENT 'High-level category grouping of work order types.',
    `compliance_requirements` STRING COMMENT 'Regulatory or safety compliance requirements applicable to this work order type.',
    `cost_center` DECIMAL(18,2) COMMENT 'Financial cost center associated with this work order type for budgeting and chargeback.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the work order type record was created in the system.',
    `default_duration_hours` DECIMAL(18,2) COMMENT 'Standard estimated duration for work orders of this type, expressed in hours.',
    `default_priority` STRING COMMENT '',
    `work_order_type_description` STRING COMMENT 'Longer description of the work order type purpose and usage.',
    `effective_from` DATE COMMENT 'Date from which the work order type becomes valid for new work orders.',
    `effective_until` DATE COMMENT 'Date after which the work order type is no longer valid; null if open-ended.',
    `external_system_code` STRING COMMENT 'Code used to map this work order type to an external ERP or maintenance system.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the work order type is currently active and usable.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates if the work order type is deprecated and should not be used for new work orders.',
    `is_external` BOOLEAN COMMENT 'True if the work order type is intended for external contractor execution.',
    `is_preventive` BOOLEAN COMMENT '',
    `work_order_type_name` STRING COMMENT 'Descriptive name of the work order type.',
    `notes` STRING COMMENT 'Free-form notes or comments about the work order type.',
    `priority` STRING COMMENT 'Default priority level assigned to work orders of this type.',
    `requires_approval` BOOLEAN COMMENT 'Indicates if work orders of this type require managerial approval before execution.',
    `type_code` STRING COMMENT 'Short alphanumeric code identifying the work order type.',
    `type_description` STRING COMMENT '',
    `type_name` STRING COMMENT '',
    `updated_by` STRING COMMENT 'User identifier who last updated the work order type record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the work order type record.',
    `created_by` STRING COMMENT 'User identifier who created the work order type record.',
    CONSTRAINT pk_work_order_type PRIMARY KEY(`work_order_type_id`)
) COMMENT 'Master reference table for work_order_type. Referenced by work_order_type_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` (
    `craft_skill_id` BIGINT COMMENT 'Primary key for craft_skill',
    `parent_craft_skill_id` BIGINT COMMENT 'Self-referencing FK on craft_skill (parent_craft_skill_id)',
    `associated_equipment_type` STRING COMMENT 'Primary equipment type that the skill is associated with (e.g., CNC, PLC, Robot).',
    `average_training_hours` STRING COMMENT 'Typical number of training hours required to achieve proficiency.',
    `certification_required` BOOLEAN COMMENT 'Indicates whether formal certification is required to perform the skill.',
    `competency_framework` STRING COMMENT 'Reference to the competency framework governing the skill.',
    `craft_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the skill record was initially created in the system.',
    `currency_code` STRING COMMENT '',
    `craft_skill_description` STRING COMMENT 'Detailed textual description of the skill, including typical tasks and responsibilities.',
    `effective_date` DATE COMMENT 'Date from which the skill definition becomes active.',
    `expiration_date` DATE COMMENT 'Date after which the skill definition is retired (nullable).',
    `external_standard_code` STRING COMMENT 'External industry standard code for the skill, if any (e.g., NACE, NAICS).',
    `is_union_covered` BOOLEAN COMMENT 'Indicates if the skill is covered under a collective bargaining agreement.',
    `last_review_date` DATE COMMENT 'Date when the skill definition was last reviewed for relevance.',
    `review_frequency_months` STRING COMMENT 'Recommended frequency in months for reviewing the skill definition.',
    `safety_training_required` BOOLEAN COMMENT 'Indicates whether specific safety training is mandatory for the skill.',
    `skill_category` STRING COMMENT 'Broad category grouping of the skill.',
    `skill_code` STRING COMMENT 'Standardized short code for the skill used in work orders and scheduling.',
    `skill_description` STRING COMMENT '',
    `skill_level` STRING COMMENT 'Proficiency level required for the skill.',
    `skill_name` STRING COMMENT 'Descriptive name of the craft skill (e.g., Electrical Technician, CNC Machinist).',
    `standard_labor_rate` DECIMAL(18,2) COMMENT '',
    `craft_skill_status` STRING COMMENT 'Current lifecycle status of the skill.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the skill record.',
    CONSTRAINT pk_craft_skill PRIMARY KEY(`craft_skill_id`)
) COMMENT 'Master reference table for craft_skill. Referenced by craft_skill_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` (
    `maintenance_strategy_id` BIGINT COMMENT 'Primary key for maintenance_strategy',
    `parent_maintenance_strategy_id` BIGINT COMMENT 'Self-referencing FK on maintenance_strategy (parent_maintenance_strategy_id)',
    `applicable_asset_category` STRING COMMENT 'Asset category for which the strategy is intended.',
    `change_reason` STRING COMMENT 'Reason documented for the most recent change to the strategy.',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance constraints linked to the strategy.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated monetary cost of applying the maintenance strategy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the strategy record was first created.',
    `maintenance_strategy_description` STRING COMMENT 'Detailed description of the maintenance approach, scope, and objectives.',
    `effective_end_date` DATE COMMENT 'Date when the maintenance strategy expires or is superseded; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the maintenance strategy becomes effective.',
    `estimated_downtime_minutes` STRING COMMENT 'Estimated downtime in minutes associated with the strategy execution.',
    `external_reference_code` STRING COMMENT 'Code linking the strategy to an external standard or vendor catalog.',
    `frequency_interval_unit` STRING COMMENT 'Unit of time for the frequency interval (e.g., day, week, month).',
    `frequency_interval_value` DECIMAL(18,2) COMMENT 'Numeric value of the interval that defines how often the maintenance activity recurs.',
    `is_active` BOOLEAN COMMENT '',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this strategy is the default for newly commissioned assets.',
    `last_review_date` DATE COMMENT 'Date when the strategy was last reviewed for relevance and effectiveness.',
    `maintenance_window_end_time` TIMESTAMP COMMENT 'Preferred end time of the maintenance window in 24‑hour HH:mm format.',
    `maintenance_window_start_time` TIMESTAMP COMMENT 'Preferred start time of the maintenance window in 24‑hour HH:mm format.',
    `maintenance_strategy_name` STRING COMMENT 'Descriptive name of the maintenance strategy.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the strategy.',
    `priority` STRING COMMENT 'Priority level assigned to the strategy for scheduling purposes.',
    `requires_shutdown` BOOLEAN COMMENT 'Indicates whether execution of the strategy requires equipment shutdown.',
    `review_frequency_months` STRING COMMENT 'Number of months between mandatory strategy reviews.',
    `maintenance_strategy_status` STRING COMMENT 'Current lifecycle status of the strategy.',
    `strategy_code` DECIMAL(18,2) COMMENT '',
    `strategy_description` DECIMAL(18,2) COMMENT '',
    `strategy_name` DECIMAL(18,2) COMMENT '',
    `strategy_type` DECIMAL(18,2) COMMENT 'Category of maintenance approach applied by the strategy.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the strategy record.',
    `version_number` STRING COMMENT 'Version identifier for the maintenance strategy definition.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the record.',
    CONSTRAINT pk_maintenance_strategy PRIMARY KEY(`maintenance_strategy_id`)
) COMMENT 'Master reference table for maintenance_strategy. Referenced by maintenance_strategy_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_asset_plant_id` FOREIGN KEY (`asset_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_asset_pm_schedule_id` FOREIGN KEY (`asset_pm_schedule_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule`(`asset_pm_schedule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ADD CONSTRAINT `fk_asset_equipment_register_capex_asset_record_id` FOREIGN KEY (`capex_asset_record_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`capex_asset_record`(`capex_asset_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_job_plan_id` FOREIGN KEY (`job_plan_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`job_plan`(`job_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_parent_work_order_asset_work_order_id` FOREIGN KEY (`parent_work_order_asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ADD CONSTRAINT `fk_asset_asset_work_order_work_order_type_id` FOREIGN KEY (`work_order_type_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`work_order_type`(`work_order_type_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_craft_skill_id` FOREIGN KEY (`craft_skill_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`craft_skill`(`craft_skill_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_job_plan_id` FOREIGN KEY (`job_plan_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`job_plan`(`job_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_maintenance_strategy_id` FOREIGN KEY (`maintenance_strategy_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`maintenance_strategy`(`maintenance_strategy_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ADD CONSTRAINT `fk_asset_asset_pm_schedule_work_order_type_id` FOREIGN KEY (`work_order_type_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`work_order_type`(`work_order_type_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ADD CONSTRAINT `fk_asset_asset_downtime_event_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_asset_downtime_event_id` FOREIGN KEY (`asset_downtime_event_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_downtime_event`(`asset_downtime_event_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_asset_pm_schedule_id` FOREIGN KEY (`asset_pm_schedule_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule`(`asset_pm_schedule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ADD CONSTRAINT `fk_asset_condition_reading_lubrication_route_id` FOREIGN KEY (`lubrication_route_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`lubrication_route`(`lubrication_route_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ADD CONSTRAINT `fk_asset_spare_part_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ADD CONSTRAINT `fk_asset_reliability_record_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ADD CONSTRAINT `fk_asset_reliability_record_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ADD CONSTRAINT `fk_asset_capex_asset_record_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_inspection_checklist_id` FOREIGN KEY (`inspection_checklist_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`inspection_checklist`(`inspection_checklist_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_calibration_standard_id` FOREIGN KEY (`calibration_standard_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`calibration_standard`(`calibration_standard_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ADD CONSTRAINT `fk_asset_calibration_record_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`location`(`location_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ADD CONSTRAINT `fk_asset_asset_warranty_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ADD CONSTRAINT `fk_asset_asset_certification_asset_work_order_id` FOREIGN KEY (`asset_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_work_order`(`asset_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ADD CONSTRAINT `fk_asset_asset_certification_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` ADD CONSTRAINT `fk_asset_equipment_allocation_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_shipment` ADD CONSTRAINT `fk_asset_equipment_shipment_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`compliance_assessment` ADD CONSTRAINT `fk_asset_compliance_assessment_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` ADD CONSTRAINT `fk_asset_regulatory_applicability_equipment_register_id` FOREIGN KEY (`equipment_register_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`equipment_register`(`equipment_register_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` ADD CONSTRAINT `fk_asset_regulatory_applicability_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`spare_part`(`spare_part_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ADD CONSTRAINT `fk_asset_asset_plant_parent_plant_id` FOREIGN KEY (`parent_plant_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`asset_plant`(`asset_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ADD CONSTRAINT `fk_asset_calibration_standard_reference_standard_calibration_standard_id` FOREIGN KEY (`reference_standard_calibration_standard_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`calibration_standard`(`calibration_standard_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ADD CONSTRAINT `fk_asset_lubrication_route_parent_lubrication_route_id` FOREIGN KEY (`parent_lubrication_route_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`lubrication_route`(`lubrication_route_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ADD CONSTRAINT `fk_asset_inspection_checklist_parent_inspection_checklist_id` FOREIGN KEY (`parent_inspection_checklist_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`inspection_checklist`(`inspection_checklist_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ADD CONSTRAINT `fk_asset_work_order_type_parent_work_order_type_id` FOREIGN KEY (`parent_work_order_type_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`work_order_type`(`work_order_type_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ADD CONSTRAINT `fk_asset_craft_skill_parent_craft_skill_id` FOREIGN KEY (`parent_craft_skill_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`craft_skill`(`craft_skill_id`);
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ADD CONSTRAINT `fk_asset_maintenance_strategy_parent_maintenance_strategy_id` FOREIGN KEY (`parent_maintenance_strategy_id`) REFERENCES `vibe_manufacturing_v1`.`asset`.`maintenance_strategy`(`maintenance_strategy_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`asset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_manufacturing_v1`.`asset` SET TAGS ('dbx_domain' = 'asset');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` SET TAGS ('dbx_subdomain' = 'equipment_registry');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Technician Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `engineer_id` SET TAGS ('dbx_business_glossary_term' = 'Service Engineer Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `asset_pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `capex_asset_record_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Asset Record Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `asset_category` SET TAGS ('dbx_value_regex' = 'Production Equipment|Facility Infrastructure|Utility System|Safety System|Measurement and Test Equipment|IT and Automation');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `condition_at_transfer` SET TAGS ('dbx_business_glossary_term' = 'Condition at Transfer');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = 'Excellent|Good|Fair|Poor|Critical');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `criticality_ranking` SET TAGS ('dbx_business_glossary_term' = 'Criticality Ranking');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `criticality_ranking` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `device_registry_code` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `equipment_class` SET TAGS ('dbx_business_glossary_term' = 'Equipment Class');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `equipment_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `equipment_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `functional_location` SET TAGS ('dbx_business_glossary_term' = 'Functional Location');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `last_transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transfer Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `last_transfer_destination` SET TAGS ('dbx_business_glossary_term' = 'Last Transfer Destination Location');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `last_transfer_origin` SET TAGS ('dbx_business_glossary_term' = 'Last Transfer Origin Location');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `last_transfer_reason` SET TAGS ('dbx_business_glossary_term' = 'Last Transfer Reason');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `last_transfer_reason` SET TAGS ('dbx_value_regex' = 'Production Rebalancing|Maintenance|Decommission|New Project|Relocation|Disposal');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `mean_time_between_failures` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `mean_time_to_repair` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating (kW)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `regulatory_certification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Certification');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `replacement_value` SET TAGS ('dbx_business_glossary_term' = 'Replacement Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `replacement_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'Hazardous|Non-Hazardous|Pressure Vessel|Electrical High Voltage|Confined Space|Radiation Source');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `transfer_authorization_ref` SET TAGS ('dbx_business_glossary_term' = 'Transfer Authorization Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Equipment Weight (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_register` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` SET TAGS ('dbx_subdomain' = 'equipment_registry');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `engineering_project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `network_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Node Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `parent_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Area (Square Metres)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `atex_zone_classification` SET TAGS ('dbx_business_glossary_term' = 'ATEX Zone Classification');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `atex_zone_classification` SET TAGS ('dbx_value_regex' = 'Zone 0|Zone 1|Zone 2|Zone 20|Zone 21|Zone 22');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `building_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `capex_asset_register_code` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Asset Register Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `capex_asset_register_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `ceiling_height_m` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Height (Metres)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `clean_room_classification` SET TAGS ('dbx_business_glossary_term' = 'Clean Room ISO Classification');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `clean_room_classification` SET TAGS ('dbx_value_regex' = 'ISO 1|ISO 2|ISO 3|ISO 4|ISO 5|ISO 6');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Metres)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `energy_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Energy Zone Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `energy_zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `environmental_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Zone Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `environmental_zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `fire_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Fire Zone Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `fire_zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `functional_location_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Location (FL) Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `functional_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}(-[A-Z0-9]{1,20}){0,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `iec_reference_designation` SET TAGS ('dbx_business_glossary_term' = 'IEC 81346 Reference Designation');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `installed_asset_count` SET TAGS ('dbx_business_glossary_term' = 'Installed Asset Count');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `is_outdoor` SET TAGS ('dbx_business_glossary_term' = 'Is Outdoor Location');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `is_restricted_access` SET TAGS ('dbx_business_glossary_term' = 'Is Restricted Access');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|under_construction|reserved');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `maintenance_planner_group` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Planner Group');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `maintenance_planner_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `maintenance_work_center` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Center');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `maintenance_work_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `max_asset_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Asset Capacity');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `max_load_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Load Capacity (Kilograms)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `maximo_location_code` SET TAGS ('dbx_business_glossary_term' = 'Maximo Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `network_segment` SET TAGS ('dbx_business_glossary_term' = 'Network Segment');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `network_segment` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_-]{1,50}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `pm_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `pm_schedule_type` SET TAGS ('dbx_value_regex' = 'time_based|usage_based|condition_based|none');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `power_supply_type` SET TAGS ('dbx_business_glossary_term' = 'Power Supply Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `power_supply_type` SET TAGS ('dbx_value_regex' = 'AC_110V|AC_220V|AC_380V|AC_480V|DC_24V|DC_48V');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `production_line_code` SET TAGS ('dbx_business_glossary_term' = 'Production Line Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `production_line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `safety_zone_type` SET TAGS ('dbx_business_glossary_term' = 'Safety Zone Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `safety_zone_type` SET TAGS ('dbx_value_regex' = 'general|restricted|exclusion|emergency_assembly|fire_zone|chemical_storage');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `site_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `site_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`location` ALTER COLUMN `work_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` SET TAGS ('dbx_ssot' = 'master');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` SET TAGS ('dbx_ssot_group' = 'work_order');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` SET TAGS ('dbx_ssot_of' = 'production.production_work_order');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` SET TAGS ('dbx_ssot_role' = 'duplicate');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `engineering_project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `job_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `parent_work_order_asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_ssot_ref' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'External Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `tertiary_asset_reported_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `tertiary_asset_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `tertiary_asset_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `work_order_type_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `work_order_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date/Time');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Cost');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `actual_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Material Cost');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `actual_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date/Time');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `affected_production_lines` SET TAGS ('dbx_business_glossary_term' = 'Affected Production Lines');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `asset_criticality` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `asset_criticality` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `asset_pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) / Operational Expenditure (OpEx) Classification');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_value_regex' = 'capex|opex');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `completion_code` SET TAGS ('dbx_business_glossary_term' = 'Completion Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `completion_remarks` SET TAGS ('dbx_business_glossary_term' = 'Completion Remarks');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `craft_type` SET TAGS ('dbx_business_glossary_term' = 'Craft / Trade Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `downtime_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `failure_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `is_production_impacting` SET TAGS ('dbx_business_glossary_term' = 'Is Production Impacting Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Work Order Long Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `ncr_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date/Time');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `planned_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Labor Hours');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `planned_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Material Cost');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `planned_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date/Time');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Order Priority');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = '1_emergency|2_urgent|3_high|4_medium|5_low');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Work Order Reported Date/Time');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `safety_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `safety_permit_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `shutdown_scope_summary` SET TAGS ('dbx_business_glossary_term' = 'Shutdown / Turnaround Scope Summary');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `tpm_pillar` SET TAGS ('dbx_business_glossary_term' = 'Total Productive Maintenance (TPM) Pillar');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `tpm_pillar` SET TAGS ('dbx_value_regex' = 'autonomous_maintenance|planned_maintenance|quality_maintenance|focused_improvement|early_equipment_management');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `work_order_description` SET TAGS ('dbx_business_glossary_term' = 'Work Order Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{8,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `work_order_source` SET TAGS ('dbx_business_glossary_term' = 'Work Order Source / Origination Channel');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` SET TAGS ('dbx_ssot' = 'master');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` SET TAGS ('dbx_ssot_group' = 'pm_schedule');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` SET TAGS ('dbx_ssot_of' = 'asset.asset_pm_schedule');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` SET TAGS ('dbx_ssot_role' = 'source_of_truth');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `asset_pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `asset_pm_schedule_id` SET TAGS ('dbx_ssot_duplicate_resolved' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `asset_pm_schedule_id` SET TAGS ('dbx_ssot_master' = 'service.service_pm_schedule');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Last Generated Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `craft_skill_id` SET TAGS ('dbx_business_glossary_term' = 'Craft Skill ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `job_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `maintenance_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Service Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `work_order_type_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `condition_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Condition Monitoring Threshold Unit');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `condition_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Condition Monitoring Threshold Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `crew_size` SET TAGS ('dbx_business_glossary_term' = 'Required Crew Size');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `asset_pm_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated PM Duration (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'PM Frequency Unit');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `frequency_value` SET TAGS ('dbx_business_glossary_term' = 'PM Frequency Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `is_regulatory_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `is_safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Safety-Critical PM Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `last_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Last PM Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `last_revised_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revised Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'PM Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_value_regex' = 'PREVENTIVE|PREDICTIVE|INSPECTION|LUBRICATION|CALIBRATION|OVERHAUL');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `meter_unit` SET TAGS ('dbx_business_glossary_term' = 'Meter Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `meter_unit` SET TAGS ('dbx_value_regex' = 'HOURS|CYCLES|KILOMETERS|STROKES|STARTS|UNITS');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next PM Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `next_due_meter_reading` SET TAGS ('dbx_business_glossary_term' = 'Next PM Due Meter Reading');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Priority');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Revision Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|DRAFT|SUSPENDED|CLOSED');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'TPM Task Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `shutdown_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Shutdown Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `spare_parts_required` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `tolerance_days` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Tolerance (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `tpm_pillar` SET TAGS ('dbx_business_glossary_term' = 'Total Productive Maintenance (TPM) Pillar');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'PM Trigger Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'CALENDAR|METER|CONDITION|SEASONAL|EVENT');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_pm_schedule` ALTER COLUMN `work_order_count` SET TAGS ('dbx_business_glossary_term' = 'Total Work Orders Generated Count');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `job_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `plc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Plc Program Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `applicable_equipment_class` SET TAGS ('dbx_business_glossary_term' = 'Applicable Equipment Class');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `confined_space_entry` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Entry Required');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `job_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `frequency_interval` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency Interval');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `frequency_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `frequency_type` SET TAGS ('dbx_value_regex' = 'TIME_BASED|METER_BASED|CONDITION_BASED|EVENT_BASED|ON_DEMAND');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency Unit');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `hazardous_materials_involved` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Involved');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `inspection_checklist_ref` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `job_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `loto_required` SET TAGS ('dbx_business_glossary_term' = 'Lockout/Tagout (LOTO) Required');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `manufacturer_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `oem_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'OEM Procedure Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `permit_to_work_required` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Required');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'DRAFT|ACTIVE|INACTIVE|PENDING_REVIEW|OBSOLETE');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `planner_group` SET TAGS ('dbx_business_glossary_term' = 'Planner Group');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `primary_craft` SET TAGS ('dbx_business_glossary_term' = 'Primary Craft');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW|ROUTINE');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `regulatory_compliance_ref` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `required_technician_count` SET TAGS ('dbx_business_glossary_term' = 'Required Technician Count');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `required_tools` SET TAGS ('dbx_business_glossary_term' = 'Required Tools');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `safety_precautions` SET TAGS ('dbx_business_glossary_term' = 'Safety Precautions');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `shutdown_required` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Required');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `source_system_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Key');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `spare_parts_list` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts List');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `task_step_count` SET TAGS ('dbx_business_glossary_term' = 'Task Step Count');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Title');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `work_category` SET TAGS ('dbx_business_glossary_term' = 'Work Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `work_center` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`job_plan` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'PM|CM|EM|INSPECTION|OVERHAUL|PROJECT');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `notification_id` SET TAGS ('dbx_business_glossary_term' = 'SAP PM Notification ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `affected_component_code` SET TAGS ('dbx_business_glossary_term' = 'Affected Component Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `affected_component_description` SET TAGS ('dbx_business_glossary_term' = 'Affected Component Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `asset_operating_hours_at_failure` SET TAGS ('dbx_business_glossary_term' = 'Asset Operating Hours at Failure');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `capa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `detection_method_code` SET TAGS ('dbx_business_glossary_term' = 'Detection Method Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `detection_rating` SET TAGS ('dbx_business_glossary_term' = 'Failure Detection Rating (FMEA)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `downtime_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Date and Time');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `downtime_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Date and Time');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `environmental_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `failure_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `failure_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `failure_class_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Class Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `failure_class_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Class Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `failure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Date and Time');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `failure_impact_type` SET TAGS ('dbx_business_glossary_term' = 'Failure Impact Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `failure_impact_type` SET TAGS ('dbx_value_regex' = 'production_stoppage|partial_degradation|quality_impact|safety_incident|no_production_impact');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `failure_mode_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `failure_mode_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `failure_narrative` SET TAGS ('dbx_business_glossary_term' = 'Failure Narrative');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `failure_number` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `failure_number` SET TAGS ('dbx_value_regex' = '^FR-[0-9]{8,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `functional_location_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_value_regex' = 'corrective|emergency|predictive|preventive|condition_based');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `mtbf_contribution_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Contribution Hours');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `ncr_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `occurrence_rating` SET TAGS ('dbx_business_glossary_term' = 'Failure Occurrence Rating (FMEA)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `potential_failure_effect` SET TAGS ('dbx_business_glossary_term' = 'Potential Failure Effect Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `production_units_lost` SET TAGS ('dbx_business_glossary_term' = 'Production Units Lost');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|cancelled|pending_review');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `remedy_code` SET TAGS ('dbx_business_glossary_term' = 'Remedy Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `remedy_description` SET TAGS ('dbx_business_glossary_term' = 'Remedy Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Repair Cost');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `repair_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `risk_priority_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Priority Number (RPN)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Failure Severity Rating (FMEA)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`failure_record` ALTER COLUMN `spare_part_consumed_flag` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Consumed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` SET TAGS ('dbx_ssot' = 'master');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` SET TAGS ('dbx_ssot_group' = 'downtime_event');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` SET TAGS ('dbx_ssot_of' = 'asset.asset_downtime_event');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` SET TAGS ('dbx_ssot_role' = 'duplicate');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `asset_downtime_event_id` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `alarm_event_id` SET TAGS ('dbx_business_glossary_term' = 'SCADA Alarm ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `production_downtime_event_id` SET TAGS ('dbx_ssot_ref' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `production_downtime_event_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `affected_product_code` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Code (SKU)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `capa_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Downtime Detection Method');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Downtime Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `downtime_type` SET TAGS ('dbx_business_glossary_term' = 'Downtime Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `downtime_type` SET TAGS ('dbx_value_regex' = 'unplanned|planned');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `estimated_loss_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Production Loss Cost');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `estimated_loss_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `estimated_production_loss_units` SET TAGS ('dbx_business_glossary_term' = 'Estimated Production Loss (Units)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^DT-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `failure_class` SET TAGS ('dbx_business_glossary_term' = 'Failure Class');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `is_repeat_failure` SET TAGS ('dbx_business_glossary_term' = 'Is Repeat Failure Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `is_safety_incident` SET TAGS ('dbx_business_glossary_term' = 'Is Safety Incident Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|predictive|condition_based|emergency');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `ncr_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `oee_availability_impact_pct` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Availability Impact Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `plc_fault_code` SET TAGS ('dbx_business_glossary_term' = 'Programmable Logic Controller (PLC) Fault Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `problem_code` SET TAGS ('dbx_business_glossary_term' = 'Problem Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `remedy_code` SET TAGS ('dbx_business_glossary_term' = 'Remedy Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `repair_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Repair Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Response Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `safety_incident_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `source_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Event Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `spare_parts_used` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Used');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_downtime_event` ALTER COLUMN `technician_notes` SET TAGS ('dbx_business_glossary_term' = 'Technician Notes');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` SET TAGS ('dbx_subdomain' = 'condition_monitoring');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `condition_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Reading ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `alarm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Alert ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `asset_downtime_event_id` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `asset_pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator / Technician ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `lubrication_route_id` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Route ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `tag_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sensor Tag Identifier (Tag ID)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity Level');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `alert_severity` SET TAGS ('dbx_value_regex' = 'none|informational|warning|critical|emergency');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `ambient_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (°C)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `asset_operating_state` SET TAGS ('dbx_business_glossary_term' = 'Asset Operating State');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `asset_operating_state` SET TAGS ('dbx_value_regex' = 'running|idle|startup|shutdown|maintenance');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `calibration_factor` SET TAGS ('dbx_business_glossary_term' = 'Calibration Factor');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `delta_value` SET TAGS ('dbx_business_glossary_term' = 'Delta Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `equipment_class` SET TAGS ('dbx_business_glossary_term' = 'Equipment Class');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `frequency_band` SET TAGS ('dbx_business_glossary_term' = 'Frequency Band');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `functional_location_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `load_percentage` SET TAGS ('dbx_business_glossary_term' = 'Asset Load Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `measurement_direction` SET TAGS ('dbx_business_glossary_term' = 'Measurement Direction / Axis');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `measurement_direction` SET TAGS ('dbx_value_regex' = 'axial|radial|tangential|vertical|horizontal|omnidirectional');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `pm_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Trigger Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `raw_value` SET TAGS ('dbx_business_glossary_term' = 'Raw Sensor Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `reading_source` SET TAGS ('dbx_business_glossary_term' = 'Reading Source');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `reading_source` SET TAGS ('dbx_value_regex' = 'iiot_gateway|scada|mes|manual_entry|cmms_import|ems');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `reading_status` SET TAGS ('dbx_business_glossary_term' = 'Reading Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `reading_status` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid|estimated|overridden');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `reading_type` SET TAGS ('dbx_business_glossary_term' = 'Reading Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `reading_type` SET TAGS ('dbx_value_regex' = 'condition_indicator|cumulative_meter');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `reading_value` SET TAGS ('dbx_business_glossary_term' = 'Reading Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `sampling_interval_sec` SET TAGS ('dbx_business_glossary_term' = 'Sampling Interval (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor / Meter ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `threshold_breached` SET TAGS ('dbx_business_glossary_term' = 'Threshold Breached Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `threshold_high` SET TAGS ('dbx_business_glossary_term' = 'High Threshold Limit');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `threshold_low` SET TAGS ('dbx_business_glossary_term' = 'Low Threshold Limit');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`condition_reading` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` SET TAGS ('dbx_subdomain' = 'equipment_registry');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `abc_class` SET TAGS ('dbx_business_glossary_term' = 'ABC Inventory Classification');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `abc_class` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `average_annual_consumption` SET TAGS ('dbx_business_glossary_term' = 'Average Annual Consumption Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `capex_asset_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Asset Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `criticality_class` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Criticality Classification');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `criticality_class` SET TAGS ('dbx_value_regex' = 'insurance_spare|critical|non_critical');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Drawing Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Compatible Equipment Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `equipment_class_code` SET TAGS ('dbx_business_glossary_term' = 'OEM Compatible Equipment Class Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `hazmat_class_code` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Class Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `interchangeable_part_numbers` SET TAGS ('dbx_business_glossary_term' = 'Interchangeable Part Numbers');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `last_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Last Issued Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `last_purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Price');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `last_purchase_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code (SAP MATKL)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `max_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `minimum_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `mro_category` SET TAGS ('dbx_business_glossary_term' = 'Maintenance, Repair, and Operations (MRO) Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `mro_category` SET TAGS ('dbx_value_regex' = 'spare_parts|consumables|lubricants|tools|safety_supplies|electrical_supplies');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `part_description` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `part_name` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `part_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `part_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]{3,40}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `part_status` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `part_status` SET TAGS ('dbx_value_regex' = 'active|obsolete|superseded|pending_approval|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `part_type` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `preferred_vendor_number` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external|internal|both');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `replenishment_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `superseded_by_part_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Part Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class (SAP)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`spare_part` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` SET TAGS ('dbx_subdomain' = 'equipment_registry');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `reliability_record_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `asset_health_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Health Score');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `asset_health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `asset_health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `availability_pct` SET TAGS ('dbx_business_glossary_term' = 'Asset Availability Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `availability_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Availability Target Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reliability Calculation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `condition_monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Condition Monitoring Enabled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'maximo|sap_pm|opcenter_mes|aveva_scada|manual');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `downtime_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Downtime Cost (USD)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `downtime_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `failure_mode_count` SET TAGS ('dbx_business_glossary_term' = 'Distinct Failure Mode Count');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `failure_mode_dominant` SET TAGS ('dbx_business_glossary_term' = 'Dominant Failure Mode');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `failure_rate` SET TAGS ('dbx_business_glossary_term' = 'Failure Rate (Lambda)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `last_failure_date` SET TAGS ('dbx_business_glossary_term' = 'Last Failure Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `mean_time_between_failures` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `mean_time_to_repair` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `mtbf_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Target Hours');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `mtbf_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Variance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `mttr_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR) Target Hours');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `next_pm_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Preventive Maintenance (PM) Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `oee_availability_component` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Availability Component');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `period_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Duration (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `planned_maintenance_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Maintenance Hours');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Reliability Record Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `record_number` SET TAGS ('dbx_value_regex' = '^RR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Reliability Record Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|archived');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `reliability_tier` SET TAGS ('dbx_business_glossary_term' = 'Reliability Tier Classification');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `reliability_tier` SET TAGS ('dbx_value_regex' = 'P1|P2|P3|P4|P5');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `replacement_recommended` SET TAGS ('dbx_business_glossary_term' = 'Capital Replacement Recommended Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `total_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Downtime Hours');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `total_failures` SET TAGS ('dbx_business_glossary_term' = 'Total Failures');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `total_scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Scheduled Operating Hours');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `total_uptime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Uptime Hours');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Reliability Trend Direction');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'improving|stable|degrading|critical');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `weibull_beta` SET TAGS ('dbx_business_glossary_term' = 'Weibull Shape Parameter (Beta)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `weibull_eta` SET TAGS ('dbx_business_glossary_term' = 'Weibull Scale Parameter (Eta)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `weibull_gamma` SET TAGS ('dbx_business_glossary_term' = 'Weibull Location Parameter (Gamma)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`reliability_record` ALTER COLUMN `weibull_r_squared` SET TAGS ('dbx_business_glossary_term' = 'Weibull Goodness-of-Fit (R-Squared)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` SET TAGS ('dbx_subdomain' = 'equipment_registry');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `capex_asset_record_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Asset Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `asset_group_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Group Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `asset_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `capitalization_threshold_met` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Threshold Met');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|double_declining_balance|units_of_production|sum_of_years_digits|none');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sold|scrapped|traded_in|donated|transferred|retired');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `impairment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `impairment_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss Amount');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `last_depreciation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Depreciation Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `revaluation_amount` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Amount');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `revaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Depreciation Method');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_value_regex' = 'MACRS|straight_line_tax|section_179|bonus_depreciation|none');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `tax_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Tax Useful Life Years');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`capex_asset_record` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` SET TAGS ('dbx_subdomain' = 'condition_monitoring');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `product_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Certification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `tertiary_inspection_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `tertiary_inspection_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `tertiary_inspection_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `asset_operational_status_at_inspection` SET TAGS ('dbx_business_glossary_term' = 'Asset Operational Status at Inspection');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `capa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `certificate_issued` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `downtime_caused` SET TAGS ('dbx_business_glossary_term' = 'Downtime Caused Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `external_audit_reference` SET TAGS ('dbx_business_glossary_term' = 'External Audit Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Inspection Findings Count');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Interval (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'visual|functional_test|measurement|non_destructive_testing|document_review');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_number` SET TAGS ('dbx_value_regex' = '^INSP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|incomplete');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_value_regex' = 'full|partial|spot_check');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|overdue');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspector_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspector_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `inspector_remarks` SET TAGS ('dbx_business_glossary_term' = 'Inspector Remarks');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `items_failed` SET TAGS ('dbx_business_glossary_term' = 'Checklist Items Failed');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `items_passed` SET TAGS ('dbx_business_glossary_term' = 'Checklist Items Passed');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_event` ALTER COLUMN `total_checklist_items` SET TAGS ('dbx_business_glossary_term' = 'Total Checklist Items');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` SET TAGS ('dbx_subdomain' = 'condition_monitoring');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `calibration_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Technician ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Lab Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `adjustment_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `adjustment_made` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Made Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `as_found_error` SET TAGS ('dbx_business_glossary_term' = 'As-Found Error');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `as_found_reading` SET TAGS ('dbx_business_glossary_term' = 'As-Found Reading');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `as_left_error` SET TAGS ('dbx_business_glossary_term' = 'As-Left Error');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `as_left_reading` SET TAGS ('dbx_business_glossary_term' = 'As-Left Reading');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date (Next Calibration Date)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `calibration_lab` SET TAGS ('dbx_business_glossary_term' = 'Calibration Laboratory Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `calibration_method` SET TAGS ('dbx_business_glossary_term' = 'Calibration Method');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `calibration_notes` SET TAGS ('dbx_business_glossary_term' = 'Calibration Notes');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `calibration_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `calibration_type` SET TAGS ('dbx_business_glossary_term' = 'Calibration Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `capa_reference` SET TAGS ('dbx_business_glossary_term' = 'CAPA (Corrective and Preventive Action) Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `environmental_humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'Environmental Relative Humidity at Calibration (%)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `environmental_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Environmental Temperature at Calibration (°C)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `external_lab_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'External Laboratory Accreditation Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `external_lab_name` SET TAGS ('dbx_business_glossary_term' = 'External Laboratory Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `external_lab_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `external_lab_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `instrument_tag` SET TAGS ('dbx_business_glossary_term' = 'Instrument Tag Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `measurement_parameter` SET TAGS ('dbx_business_glossary_term' = 'Measurement Parameter');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `out_of_service` SET TAGS ('dbx_business_glossary_term' = 'Out of Service Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `prior_measurement_impact` SET TAGS ('dbx_business_glossary_term' = 'Prior Measurement Impact Assessment');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `prior_measurement_impact` SET TAGS ('dbx_value_regex' = 'no_impact|under_investigation|impact_confirmed|impact_ruled_out');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `reference_value` SET TAGS ('dbx_business_glossary_term' = 'Reference (Nominal) Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `standard_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Standard Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `technician_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Technician Certification Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Technician Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `technician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `technician_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `technician_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `tolerance_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Lower Limit');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `tolerance_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Upper Limit');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` SET TAGS ('dbx_subdomain' = 'equipment_registry');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` SET TAGS ('dbx_ssot' = 'master');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` SET TAGS ('dbx_ssot_group' = 'warranty');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` SET TAGS ('dbx_ssot_of' = 'asset.asset_warranty');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` SET TAGS ('dbx_ssot_role' = 'duplicate');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `asset_warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Warranty ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `asset_warranty_id` SET TAGS ('dbx_ssot_duplicate_resolved' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `asset_warranty_id` SET TAGS ('dbx_ssot_master' = 'service.service_warranty');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `service_warranty_id` SET TAGS ('dbx_ssot_ref' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `service_warranty_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Activation Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_response_sla_days` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Response Service Level Agreement (SLA) Days');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_submission_process` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Submission Process');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `claim_submission_process` SET TAGS ('dbx_value_regex' = 'online_portal|email|phone|field_service_dispatch|rma_process');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Scope');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_value_regex' = 'on_site|depot_repair|return_to_factory|remote_support|parts_only');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `covered_components` SET TAGS ('dbx_business_glossary_term' = 'Covered Components Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Warranty Document Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `duration_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Duration (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `excluded_components` SET TAGS ('dbx_business_glossary_term' = 'Excluded Components Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `expiry_alert_days` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Alert Lead Days');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `extended_warranty_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Extended Warranty Option Available Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `labor_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Labor Coverage Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `last_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Last Warranty Claim Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `maintenance_provider_restriction` SET TAGS ('dbx_business_glossary_term' = 'Warranty Maintenance Provider Restriction');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `maintenance_provider_restriction` SET TAGS ('dbx_value_regex' = 'oem_only|certified_partner|any_provider|internal_allowed');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `maintenance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Required to Maintain Warranty Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `max_claim_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Warranty Claim Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `max_claim_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Warranty Notes');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `oem_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Original Equipment Manufacturer (OEM) Vendor Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `oem_vendor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `oem_vendor_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `oem_warranty_reference` SET TAGS ('dbx_business_glossary_term' = 'OEM Warranty Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `parts_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Parts Coverage Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `preventive_maintenance_covered_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Covered Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `remaining_warranty_value` SET TAGS ('dbx_business_glossary_term' = 'Remaining Warranty Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `remaining_warranty_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `rma_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Eligible Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `total_claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Claimed Amount');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `total_claimed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `total_claims_count` SET TAGS ('dbx_business_glossary_term' = 'Total Warranty Claims Count');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Transferable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `travel_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Travel Coverage Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `usage_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Usage-Based Warranty Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `usage_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Warranty Usage Limit Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `usage_limit_unit` SET TAGS ('dbx_value_regex' = 'hours|cycles|kilometers|strokes|starts');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `usage_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Warranty Usage Limit Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `warranty_name` SET TAGS ('dbx_business_glossary_term' = 'Warranty Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `warranty_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `warranty_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `warranty_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `warranty_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `warranty_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending|voided|suspended');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'parts_only|labor_only|full_coverage|extended|limited|manufacturer');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` SET TAGS ('dbx_subdomain' = 'equipment_registry');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` SET TAGS ('dbx_ssot' = 'master');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` SET TAGS ('dbx_ssot_group' = 'certification');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` SET TAGS ('dbx_ssot_of' = 'asset.asset_certification');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` SET TAGS ('dbx_ssot_subject' = 'asset_equipment_certification');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` SET TAGS ('dbx_duplicate_resolution' = 'subject_partition');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` SET TAGS ('dbx_ssot_role' = 'source_of_truth');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `asset_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Certification ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `product_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Certification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `atex_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'ATEX Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `ce_marking_flag` SET TAGS ('dbx_business_glossary_term' = 'CE Marking Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_renewal');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'pressure_vessel|electrical_safety|crane_lifting|explosion_proof|fire_safety|environmental');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `days_to_expiry` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiry');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `document_storage_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Storage URL');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'ATEX Equipment Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `equipment_category` SET TAGS ('dbx_value_regex' = 'Category 1|Category 2|Category 3');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `hazardous_zone_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Zone Classification');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `hazardous_zone_classification` SET TAGS ('dbx_value_regex' = 'Zone 0|Zone 1|Zone 2|Zone 20|Zone 21|Zone 22');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `inspector_license_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector License Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `inspector_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `inspector_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `issuing_authority_country` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Country');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Certification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `nonconformance_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `operation_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Operation Hold Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `pressure_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Rating (PSI)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `previous_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Previous Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `rated_load_kg` SET TAGS ('dbx_business_glossary_term' = 'Rated Load (kg)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Certification Remarks');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `renewal_action_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Action Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `renewal_action_status` SET TAGS ('dbx_value_regex' = 'not_required|scheduled|in_progress|completed|overdue');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `ul_listed_flag` SET TAGS ('dbx_business_glossary_term' = 'UL Listed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_certification` ALTER COLUMN `voltage_rating_v` SET TAGS ('dbx_business_glossary_term' = 'Voltage Rating (V)');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` SET TAGS ('dbx_subdomain' = 'equipment_registry');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` SET TAGS ('dbx_association_edges' = 'asset.equipment_register,order.order_line');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` ALTER COLUMN `equipment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Allocation - Equipment Allocation Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Allocation - Equipment Register Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Allocation - Order Line Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` ALTER COLUMN `allocated_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` ALTER COLUMN `allocated_to_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` ALTER COLUMN `allocated_to_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_allocation` ALTER COLUMN `usage_hours` SET TAGS ('dbx_business_glossary_term' = 'Usage Hours');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_shipment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_shipment` SET TAGS ('dbx_subdomain' = 'equipment_registry');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_shipment` SET TAGS ('dbx_association_edges' = 'asset.equipment_register,logistics.shipment');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_shipment` ALTER COLUMN `equipment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Shipment - Equipment Shipment Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_shipment` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Shipment - Equipment Register Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Shipment - Shipment Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_shipment` ALTER COLUMN `load_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Load Time');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`equipment_shipment` ALTER COLUMN `unload_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Unload Time');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`compliance_assessment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`compliance_assessment` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`compliance_assessment` SET TAGS ('dbx_association_edges' = 'asset.equipment_register,compliance.regulatory_requirement');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`compliance_assessment` ALTER COLUMN `compliance_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment - Compliance Assessment Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`compliance_assessment` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment - Equipment Register Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`compliance_assessment` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment - Regulatory Requirement Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`compliance_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`compliance_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`compliance_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`compliance_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` SET TAGS ('dbx_association_edges' = 'asset.spare_part,compliance.regulatory_requirement');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` ALTER COLUMN `regulatory_applicability_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Applicability - Regulatory Applicability Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Applicability - Regulatory Requirement Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Applicability - Spare Part Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` ALTER COLUMN `compliance_status` SET TAGS ('dbx_sensitive' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` ALTER COLUMN `determined_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`regulatory_applicability` ALTER COLUMN `regulation_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` SET TAGS ('dbx_subdomain' = 'equipment_registry');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` SET TAGS ('dbx_ssot' = 'master');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` SET TAGS ('dbx_ssot_group' = 'plant');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` SET TAGS ('dbx_ssot_of' = 'asset.plant');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` SET TAGS ('dbx_ssot_role' = 'duplicate');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `parent_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Plant Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `parent_plant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_ssot' = 'reference');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `area_sq_m` SET TAGS ('dbx_business_glossary_term' = 'Area Sq M');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `capacity_units_per_year` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Year');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `asset_plant_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `emissions_co2_tons` SET TAGS ('dbx_business_glossary_term' = 'Emissions Co2 Tons');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Mwh');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `maintenance_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `asset_plant_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `asset_plant_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `asset_plant_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_business_glossary_term' = 'Number Of Employees');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `operational_end_date` SET TAGS ('dbx_business_glossary_term' = 'Operational End Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `operational_start_date` SET TAGS ('dbx_business_glossary_term' = 'Operational Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_business_glossary_term' = 'Plant Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`asset_plant` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` SET TAGS ('dbx_subdomain' = 'condition_monitoring');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `calibration_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `reference_standard_calibration_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Calibration Standard Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `reference_standard_calibration_standard_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `accuracy_unit` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Unit');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `accuracy_value` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `applicable_equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Equipment Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `calibration_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval Days');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `calibration_location` SET TAGS ('dbx_business_glossary_term' = 'Calibration Location');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `calibration_method` SET TAGS ('dbx_business_glossary_term' = 'Calibration Method');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `calibration_provider` SET TAGS ('dbx_business_glossary_term' = 'Calibration Provider');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `calibration_standard_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `calibration_standard_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `is_traceable` SET TAGS ('dbx_business_glossary_term' = 'Is Traceable');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `is_traceable` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `is_traceable` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `last_calibrated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibrated Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Model');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `calibration_standard_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `calibration_standard_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `calibration_standard_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `required_certification` SET TAGS ('dbx_business_glossary_term' = 'Required Certification');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `standard_body` SET TAGS ('dbx_business_glossary_term' = 'Standard Body');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `standard_document_number` SET TAGS ('dbx_business_glossary_term' = 'Standard Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `standard_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `calibration_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `tolerance_unit` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Unit');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `tolerance_value` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `traceability_reference` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `calibration_standard_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`calibration_standard` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `lubrication_route_id` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Route Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `parent_lubrication_route_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Lubrication Route Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `parent_lubrication_route_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `lubrication_route_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `environmental_compliance` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Unit');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `frequency_value` SET TAGS ('dbx_business_glossary_term' = 'Frequency Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `interval_unit` SET TAGS ('dbx_business_glossary_term' = 'Interval Unit');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `interval_value` SET TAGS ('dbx_business_glossary_term' = 'Interval Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `last_lubrication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Lubrication Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `lubricant_type` SET TAGS ('dbx_business_glossary_term' = 'Lubricant Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `lubrication_method` SET TAGS ('dbx_business_glossary_term' = 'Lubrication Method');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `next_scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `responsible_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Role');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Route Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `route_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `route_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `lubrication_route_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`lubrication_route` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` SET TAGS ('dbx_subdomain' = 'condition_monitoring');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `parent_inspection_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Inspection Checklist Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `parent_inspection_checklist_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `applicable_asset_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Asset Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `author` SET TAGS ('dbx_business_glossary_term' = 'Author');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `checklist_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Url');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_area` SET TAGS ('dbx_business_glossary_term' = 'Inspection Area');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `number_of_items` SET TAGS ('dbx_business_glossary_term' = 'Number Of Items');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `required` SET TAGS ('dbx_business_glossary_term' = 'Required');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `revision_history` SET TAGS ('dbx_business_glossary_term' = 'Revision History');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `inspection_checklist_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`inspection_checklist` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `work_order_type_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `parent_work_order_type_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Order Type Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `parent_work_order_type_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `work_order_type_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `default_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Default Duration Hours');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `work_order_type_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `is_external` SET TAGS ('dbx_business_glossary_term' = 'Is External');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `work_order_type_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `work_order_type_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `work_order_type_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `requires_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Approval');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Type Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `type_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`work_order_type` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `craft_skill_id` SET TAGS ('dbx_business_glossary_term' = 'Craft Skill Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `parent_craft_skill_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Craft Skill Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `parent_craft_skill_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `associated_equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Associated Equipment Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `average_training_hours` SET TAGS ('dbx_business_glossary_term' = 'Average Training Hours');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `competency_framework` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `craft_skill_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `external_standard_code` SET TAGS ('dbx_business_glossary_term' = 'External Standard Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `is_union_covered` SET TAGS ('dbx_business_glossary_term' = 'Is Union Covered');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `safety_training_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Required');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `skill_category` SET TAGS ('dbx_business_glossary_term' = 'Skill Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `skill_code` SET TAGS ('dbx_business_glossary_term' = 'Skill Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `skill_name` SET TAGS ('dbx_business_glossary_term' = 'Skill Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `skill_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `skill_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `craft_skill_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`craft_skill` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `maintenance_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `parent_maintenance_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Maintenance Strategy Id');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `parent_maintenance_strategy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `applicable_asset_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Asset Category');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `maintenance_strategy_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `estimated_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `frequency_interval_unit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval Unit');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `frequency_interval_value` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval Value');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `maintenance_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window End Time');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `maintenance_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start Time');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `maintenance_strategy_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `maintenance_strategy_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `maintenance_strategy_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `requires_shutdown` SET TAGS ('dbx_business_glossary_term' = 'Requires Shutdown');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `maintenance_strategy_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `strategy_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Strategy Type');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`asset`.`maintenance_strategy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
